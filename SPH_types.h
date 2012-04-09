#ifndef _SPH_types_h_
#define _SPH_types_h_

#include "SPH_const.h"
#include "SPH_core_ispc.h"
#include "SoA.h"
typedef int int32;
typedef unsigned int uint32;

using ist::simdvec4;
using ist::simdvec8;
using ist::soavec24;
using ist::soavec34;
using ist::soavec44;

struct sphParticle
{
    simdvec4 position;
    simdvec4 velocity;
    union {
        struct {
            float energy;
            float density;
            uint32 hash;
            uint32 dummy[1];
        } params;
        simdvec4 paramsv;
    };
};

void SoAnize(uint32 num, const sphParticle *particles, ispc::Particle_SOA8 *out);
void AoSnize(uint32 num, const ispc::Particle_SOA8 *particles, sphParticle *out);


#endif // _SPH_types_h_
