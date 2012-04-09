//#include "stdafx.h"
#include "SPH_types.h"
#include "SPH_types.h"

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
