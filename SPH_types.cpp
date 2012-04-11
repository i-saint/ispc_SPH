//#include "stdafx.h"
#include "SPH_types.h"
#include "SPH_types.h"
#include <tbb/tbb.h>
#include <algorithm>

void SoAnize( uint32 num, const sphParticle *particles, ispc::Particle_SOA8 *out )
{
    uint32 blocks = num/8 + (num%8!=0 ? 1 : 0);
    for(uint32 bi=0; bi<blocks; ++bi) {
        uint32 i = 8*bi;
        ist::soavec34 soa;
        soa = ist::soa_transpose34(particles[i+0].position, particles[i+1].position, particles[i+2].position, particles[i+3].position);
        _mm_store_ps(out[bi].posx+0, soa.x());
        _mm_store_ps(out[bi].posy+0, soa.y());
        _mm_store_ps(out[bi].posz+0, soa.z());
        soa = ist::soa_transpose34(particles[i+0].velocity, particles[i+1].velocity, particles[i+2].velocity, particles[i+3].velocity);
        _mm_store_ps(out[bi].velx+0, soa.x());
        _mm_store_ps(out[bi].vely+0, soa.y());
        _mm_store_ps(out[bi].velz+0, soa.z());

        soa = ist::soa_transpose34(particles[i+4].position, particles[i+5].position, particles[i+6].position, particles[i+7].position);
        _mm_store_ps(out[bi].posx+4, soa.x());
        _mm_store_ps(out[bi].posy+4, soa.y());
        _mm_store_ps(out[bi].posz+4, soa.z());
        soa = ist::soa_transpose34(particles[i+4].velocity, particles[i+5].velocity, particles[i+6].velocity, particles[i+7].velocity);
        _mm_store_ps(out[bi].velx+4, soa.x());
        _mm_store_ps(out[bi].vely+4, soa.y());
        _mm_store_ps(out[bi].velz+4, soa.z());
    }
}

void AoSnize( uint32 num, const ispc::Particle_SOA8 *particles, sphParticle *out )
{
    uint32 blocks = num/8 + (num%8!=0 ? 1 : 0);
    for(uint32 bi=0; bi<blocks; ++bi) {
        uint32 i = 8*bi;
        ist::soavec44 aos_pos[2] = {
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].posx + 0),
                _mm_load_ps(particles[bi].posy + 0),
                _mm_load_ps(particles[bi].posz + 0),
                _mm_set1_ps(1.0f) ),
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].posx + 4),
                _mm_load_ps(particles[bi].posy + 4),
                _mm_load_ps(particles[bi].posz + 4),
                _mm_set1_ps(1.0f) ),
        };
        out[i+0].position = aos_pos[0][0];
        out[i+1].position = aos_pos[0][1];
        out[i+2].position = aos_pos[0][2];
        out[i+3].position = aos_pos[0][3];
        out[i+4].position = aos_pos[1][0];
        out[i+5].position = aos_pos[1][1];
        out[i+6].position = aos_pos[1][2];
        out[i+7].position = aos_pos[1][3];

        ist::soavec44 aos_vel[2] = {
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].velx + 0),
                _mm_load_ps(particles[bi].vely + 0),
                _mm_load_ps(particles[bi].velz + 0),
                _mm_set1_ps(0.0f) ),
            ist::soa_transpose44(
                _mm_load_ps(particles[bi].velx + 4),
                _mm_load_ps(particles[bi].vely + 4),
                _mm_load_ps(particles[bi].velz + 4),
                _mm_set1_ps(0.0f) ),
        };
        out[i+0].velocity = aos_vel[0][0];
        out[i+1].velocity = aos_vel[0][1];
        out[i+2].velocity = aos_vel[0][2];
        out[i+3].velocity = aos_vel[0][3];
        out[i+4].velocity = aos_vel[1][0];
        out[i+5].velocity = aos_vel[1][1];
        out[i+6].velocity = aos_vel[1][2];
        out[i+7].velocity = aos_vel[1][3];
    }
}


istForceInline uint32 GenHash(simdvec4 pos)
{
    static const float32 rcpcellsize = 1.0f/SPH_GRID_CELL_SIZE;
    const float *pos4 = (const float*)&pos;
    return  int(pos4[0]*rcpcellsize) <<  0 &
            int(pos4[1]*rcpcellsize) <<  8 &
            int(pos4[2]*rcpcellsize) << 16;
}

istForceInline void GenIndex(uint32 hash, int32 &xi, int32 &yi, int32 &zi)
{
    xi = (hash & 0x000000ff >>  0);
    yi = (hash & 0x0000ff00 >>  8);
    zi = (hash & 0x00ff0000 >> 16);
}

sphGrid::sphGrid()
{
    for(uint32 i=0; i<_countof(particles); ++i) {
        particles[i].position = ist::simdvec4_set(
            SPH_PARTICLE_SIZE*0.25f * (i % SPH_GRID_DIV*SPH_GRID_DIV),
            0.002f * (i % SPH_GRID_DIV*SPH_GRID_DIV),
            SPH_PARTICLE_SIZE*0.25f * (i / SPH_GRID_DIV*SPH_GRID_DIV),
            1.0f );
        particles[i].velocity = ist::simdvec4_set(0.0f, 0.0f, 0.0f, 0.0f);
    }
}

void sphGrid::update()
{
    sphParticle *ps = particles; // ƒƒ“ƒo•Ï”‚Í lampda ŠÖ”‚ÉŽæ‚èž‚ß‚È‚¢‚Ì‚Å

    tbb::parallel_for(tbb::blocked_range<int>(0, SPH_MAX_PARTICLE_NUM, 1024),
        [ps](const tbb::blocked_range<int> &r) {
            for(int i=r.begin(); i!=r.end(); ++i) {
                ps[i].params.hash = GenHash(ps[i].position);
            }
        });

    tbb::parallel_sort(particles, particles+SPH_MAX_PARTICLE_NUM, 
        [](const sphParticle &a, const sphParticle &b) { return a.params.hash < b.params.hash; } );

    SoAnize(SPH_MAX_PARTICLE_NUM, particles, particles_soa);
    ispc::sphUpdate(SPH_MAX_PARTICLE_NUM, particles_soa);
    AoSnize(SPH_MAX_PARTICLE_NUM, particles_soa, particles);
}
