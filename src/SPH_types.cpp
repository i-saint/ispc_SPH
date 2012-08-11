//#include "stdafx.h"
#include "SPH_types.h"
#include <tbb/tbb.h>
#include <algorithm>

const int32 SIMD_LANES = 8;

template<class T>
T clamp(T v, T minv, T maxv)
{
    return std::min<T>(std::max<T>(v, minv), maxv);
}

int32 soa_blocks(int32 i)
{
    return (i/SIMD_LANES) + (i%SIMD_LANES>0 ? 1 : 0);
}

template<class T>
inline void simd_store(void *address, T v)
{
    _mm_store_ps((float*)address, (const simdvec4&)v);
}

void SoAnize( int32 num, const sphParticle *particles, ispc::Particle_SOA8 *out )
{
    int32 blocks = soa_blocks(num);
    for(int32 bi=0; bi<blocks; ++bi) {
        int32 i = SIMD_LANES*bi;
        ist::soavec34 soav;
        soav = ist::soa_transpose34(particles[i+0].position, particles[i+1].position, particles[i+2].position, particles[i+3].position);
        simd_store(out[bi].x+0, soav.x());
        simd_store(out[bi].y+0, soav.y());
        simd_store(out[bi].z+0, soav.z());
        soav = ist::soa_transpose34(particles[i+0].velocity, particles[i+1].velocity, particles[i+2].velocity, particles[i+3].velocity);
        simd_store(out[bi].vx+0, soav.x());
        simd_store(out[bi].vy+0, soav.y());
        simd_store(out[bi].vz+0, soav.z());

        soav = ist::soa_transpose34(particles[i+4].position, particles[i+5].position, particles[i+6].position, particles[i+7].position);
        simd_store(out[bi].x+4, soav.x());
        simd_store(out[bi].y+4, soav.y());
        simd_store(out[bi].z+4, soav.z());
        soav = ist::soa_transpose34(particles[i+4].velocity, particles[i+5].velocity, particles[i+6].velocity, particles[i+7].velocity);
        simd_store(out[bi].vx+4, soav.x());
        simd_store(out[bi].vy+4, soav.y());
        simd_store(out[bi].vz+4, soav.z());

        simd_store(out[bi].hit+0, _mm_set1_epi32(0));
        simd_store(out[bi].hit+4, _mm_set1_epi32(0));

        //// 不要
        //soas = ist::simdvec4_set(particles[i+0].params.density, particles[i+1].params.density, particles[i+2].params.density, particles[i+3].params.density);
        //_mm_store_ps(out[bi].density+0, soas);
        //soas = ist::simdvec4_set(particles[i+4].params.density, particles[i+5].params.density, particles[i+6].params.density, particles[i+7].params.density);
        //_mm_store_ps(out[bi].density+4, soas);
    }
}

void AoSnize( int32 num, const ispc::Particle_SOA8 *particles, sphParticle *out )
{
    int32 blocks = soa_blocks(num);
    for(int32 bi=0; bi<blocks; ++bi) {
        int32 i = 8*bi;
        ist::soavec44 aos_pos[2] = {
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].x + 0),
                _mm_load_ps(particles[bi].y + 0),
                _mm_load_ps(particles[bi].z + 0),
                _mm_set1_ps(1.0f) ),
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].x + 4),
                _mm_load_ps(particles[bi].y + 4),
                _mm_load_ps(particles[bi].z + 4),
                _mm_set1_ps(1.0f) ),
        };
        ist::soavec44 aos_vel[2] = {
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].vx + 0),
                _mm_load_ps(particles[bi].vy + 0),
                _mm_load_ps(particles[bi].vz + 0),
                _mm_set1_ps(0.0f) ),
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].vx + 4),
                _mm_load_ps(particles[bi].vy + 4),
                _mm_load_ps(particles[bi].vz + 4),
                _mm_set1_ps(0.0f) ),
        };

        int32 e = std::min<int32>(SIMD_LANES, num-i);
        for(int32 ei=0; ei<e; ++ei) {
            out[i+ei].position = aos_pos[ei/4][ei%4];
            out[i+ei].velocity = aos_vel[ei/4][ei%4];
            out[i+ei].params.density = particles[bi].density[ei];
            out[i+ei].params.hit = particles[bi].hit[ei];
        }
    }
}

inline uint32 GenHash(const sphParticle &particle)
{
    static const float32 rcpcellsize = 1.0f/SPH_GRID_CELL_SIZE;

    const float *pos4 = (const float*)&particle.position;
    uint32 r=(clamp<int32>(int32((pos4[0]-SPH_GRID_POS)*rcpcellsize), 0, (SPH_GRID_DIV-1)) << (SPH_GRID_DIV_BITS*0)) |
             (clamp<int32>(int32((pos4[1]-SPH_GRID_POS)*rcpcellsize), 0, (SPH_GRID_DIV-1)) << (SPH_GRID_DIV_BITS*1));
    if(particle.params.lifetime==0.0f) { r |= 0x80000000; }
    return r;
}

inline void GenIndex(uint32 hash, int32 &xi, int32 &yi)
{
    xi = (hash >> (SPH_GRID_DIV_BITS*0)) & (SPH_GRID_DIV-1);
    yi = (hash >> (SPH_GRID_DIV_BITS*1)) & (SPH_GRID_DIV-1);
}

sphWorld::sphWorld()
    : num_active_particles(0)
    , particle_lifetime(3600.0f)
{
    for(uint32 i=0; i<_countof(particles); ++i) {
        particles[i].params.lifetime = 0.0f;
    }


    //{
    //    ispc::Sphere sphere;
    //    set_xyz(sphere, 0.0f, 0.0f, 0.0f); sphere.radius = 2.5f;
    //    collision_spheres.push_back(sphere);
    //}
    //{
    //    ispc::PointForce force;
    //    set_xyz(force, 0.0f, 0.0f, 0.0f); force.strength = -5.0f;
    //    force_point.push_back(force);
    //}

    {
        ispc::Sphere sphere;
        set_xyz(sphere, 0.0f, 0.0f, 0.0f); sphere.radius = 1.0f;
        collision_spheres.push_back(sphere);
    }
    {
        ispc::Plane plane;
        set_nxyz(plane, 1.0f, 0.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        collision_planes.push_back(plane);
        set_nxyz(plane,-1.0f, 0.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f, 1.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f,-1.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f, 0.0f,-1.0f); plane.distance = 0.0f;
        collision_planes.push_back(plane);
    }

    {
        ispc::PointForce force;
        set_xyz(force, 0.0f, 0.0f, 0.0f); force.strength = -0.001f;
        force_point.push_back(force);
    }
    {
        ispc::DirectionalForce force;
        set_nxyz(force, 0.0f, 0.0f, 1.0f); force.strength = 5.0f;
        force_directional.push_back(force);
    }
}

void sphWorld::addParticles( sphParticle *p, size_t num )
{
    num = std::min<size_t>(num, SPH_MAX_PARTICLE_NUM-num_active_particles);
    for(size_t i=0; i<num; ++i) {
        particles[num_active_particles+i] = p[i];
        particles[num_active_particles+i].params.lifetime = particle_lifetime;
    }
    num_active_particles += num;
}

void sphWorld::update(float32 dt)
{
    sphGridData *ce = &cell[0][0];          // 

    // clear grid
    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                ce[i].begin = ce[i].end = 0;
            }
        });

    // gen hash
    tbb::parallel_for(tbb::blocked_range<int>(0, (int32)num_active_particles, 1024),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                particles[i].params.lifetime = std::max<float32>(particles[i].params.lifetime-dt, 0.0f);
                particles[i].params.hash = GenHash(particles[i]);
            }
        });

    // パーティクルを hash で sort
    tbb::parallel_sort(particles, particles+num_active_particles, 
        [&](const sphParticle &a, const sphParticle &b) { return a.params.hash < b.params.hash; } );

    // パーティクルがどの grid に入っているかを算出
    tbb::parallel_for(tbb::blocked_range<int>(0, (int32)num_active_particles, 1024),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                const uint32 G_ID = i;
                uint32 G_ID_PREV = G_ID-1;
                uint32 G_ID_NEXT = G_ID+1;

                uint32 cell = particles[G_ID].params.hash;
                uint32 cell_prev = (G_ID_PREV==-1) ? -1 : particles[G_ID_PREV].params.hash;
                uint32 cell_next = (G_ID_NEXT==SPH_MAX_PARTICLE_NUM) ? -2 : particles[G_ID_NEXT].params.hash;
                if((cell & 0x80000000) != 0) { // 最上位 bit が立っていたら死んでいる扱い
                    if((cell_prev & 0x80000000) == 0) { // 
                        num_active_particles = G_ID;
                    }
                }
                else {
                    if(cell != cell_prev) {
                        ce[cell].begin = G_ID;
                    }
                    if(cell != cell_next) {
                        ce[cell].end = G_ID + 1;
                    }
                }
            }
    });
    {
        if( (particles[0].params.hash & 0x80000000) != 0 ) {
            num_active_particles = 0;
        }
        else if( (particles[SPH_MAX_PARTICLE_NUM-1].params.hash & 0x80000000) == 0 ) {
            num_active_particles = SPH_MAX_PARTICLE_NUM;
        }
    }

    {
        int32 soai = 0;
        for(int i=0; i!=SPH_GRID_CELL_NUM; ++i) {
            ce[i].soai = soai;
            soai += soa_blocks(ce[i].end-ce[i].begin);
        }
    }

    // AoS -> SoA
    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                int32 n = ce[i].end - ce[i].begin;
                if(n == 0) { continue; }
                sphParticle *p = &particles[ce[i].begin];
                ispc::Particle_SOA8 *t = &particles_soa[ce[i].soai];
                SoAnize(n, p, t);
            }
    });

//    // SPH
//    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
//        [&](const tbb::blocked_range<int> &r) {
//            for(int i=r.begin(); i!=r.end(); ++i) {
//                int32 n = ce[i].end - ce[i].begin;
//                if(n == 0) { continue; }
//                int xi, yi;
//                GenIndex(i, xi, yi);
//                ispc::sphUpdateDensity((ispc::Particle*)particles_soa, ce, xi, yi);
//            }
//    });
//#ifdef SPH_enable_neighbor_density_estimation
//    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
//        [&](const tbb::blocked_range<int> &r) {
//            for(int i=r.begin(); i!=r.end(); ++i) {
//                int32 n = ce[i].end - ce[i].begin;
//                if(n == 0) { continue; }
//                int xi, yi;
//                GenIndex(i, xi, yi);
//                ispc::sphUpdateDensity2((ispc::Particle*)particles_soa, ce, xi, yi);
//            }
//    });
//#endif // SPH_enable_neighbor_density_estimation
//    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
//        [&](const tbb::blocked_range<int> &r) {
//            for(int i=r.begin(); i!=r.end(); ++i) {
//                int32 n = ce[i].end - ce[i].begin;
//                if(n == 0) { continue; }
//                int xi, yi;
//                GenIndex(i, xi, yi);
//                ispc::sphUpdateForce((ispc::Particle*)particles_soa, ce, xi, yi);
//            }
//    });
//    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
//        [&](const tbb::blocked_range<int> &r) {
//            for(int i=r.begin(); i!=r.end(); ++i) {
//                int32 n = ce[i].end - ce[i].begin;
//                if(n == 0) { continue; }
//                int xi, yi;
//                GenIndex(i, xi, yi);
//                ispc::sphProcessExternalForce(
//                    (ispc::Particle*)particles_soa, ce, xi, yi,
//                    &force_point[0],        (int32)force_point.size(),
//                    &force_directional[0],  (int32)force_directional.size(),
//                    &force_box[0],          (int32)force_box.size() );
//                ispc::sphProcessCollision(
//                    (ispc::Particle*)particles_soa, ce, xi, yi,
//                    &collision_spheres[0],  (int32)collision_spheres.size(),
//                    &collision_planes[0],   (int32)collision_planes.size(),
//                    &collision_boxes[0],    (int32)collision_boxes.size() );
//                ispc::sphIntegrate((ispc::Particle*)particles_soa, ce, xi, yi);
//            }
//    });

    // impulse
    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                int32 n = ce[i].end - ce[i].begin;
                if(n == 0) { continue; }
                int xi, yi;
                GenIndex(i, xi, yi);
                ispc::impUpdateVelocity((ispc::Particle*)particles_soa, ce, xi, yi);
            }
    });
    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                int32 n = ce[i].end - ce[i].begin;
                if(n == 0) { continue; }
                int xi, yi;
                GenIndex(i, xi, yi);
                ispc::sphProcessExternalForce(
                    (ispc::Particle*)particles_soa, ce, xi, yi,
                    &force_point[0],        (int32)force_point.size(),
                    &force_directional[0],  (int32)force_directional.size(),
                    &force_box[0],          (int32)force_box.size() );
                ispc::sphProcessCollision(
                    (ispc::Particle*)particles_soa, ce, xi, yi,
                    &collision_spheres[0],  (int32)collision_spheres.size(),
                    &collision_planes[0],   (int32)collision_planes.size(),
                    &collision_boxes[0],    (int32)collision_boxes.size() );
                ispc::impIntegrate((ispc::Particle*)particles_soa, ce, xi, yi);
            }
    });

    // SoA -> AoS
    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_GRID_CELL_NUM, 128),
        [&](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                int32 n = ce[i].end - ce[i].begin;
                if(n > 0) {
                    sphParticle *p = &particles[ce[i].begin];
                    ispc::Particle_SOA8 *t = &particles_soa[ce[i].soai];
                    AoSnize(n, t, p);
                }
            }
    });
}
