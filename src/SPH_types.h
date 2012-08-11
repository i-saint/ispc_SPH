#ifndef _SPH_types_h_
#define _SPH_types_h_

#include <vector>
#include "SPH_const.h"
#include "SPH_core_ispc.h"
#include "SoA.h"

typedef short           int16;
typedef unsigned short  uint16;
typedef int             int32;
typedef unsigned int    uint32;
typedef float           float32;

using ist::simdvec4;
using ist::simdvec8;
using ist::soavec24;
using ist::soavec34;
using ist::soavec44;

typedef ispc::Particle_SOA8 sphParticleSOA8;
typedef ispc::GridData sphGridData;

#define set_xyz(v, _x, _y, _z)  v.x =_x; v.y =_y; v.z =_z;
#define set_nxyz(v, _x, _y, _z) v.nx=_x; v.ny=_y; v.nz=_z;
#define set_vxyz(v, _x, _y, _z) v.vx=_x; v.vy=_y; v.vz=_z;


__declspec(align(16)) 
struct sphParticle
{
    simdvec4 position;
    simdvec4 velocity;
    union {
        struct {
            float32 density;
            uint32 hash;
            int32 hit;
            float32 lifetime;
        } params;
        simdvec4 paramsv;
    };
};

__declspec(align(16)) 
struct sphWorld
{
    sphParticle particles[SPH_MAX_PARTICLE_NUM];
    sphParticleSOA8 particles_soa[SPH_MAX_PARTICLE_NUM];
    sphGridData cell[SPH_GRID_DIV][SPH_GRID_DIV];
    size_t num_active_particles;
    float32 particle_lifetime;

    std::vector<ispc::Sphere>   collision_spheres;
    std::vector<ispc::Plane>    collision_planes;
    std::vector<ispc::Box>      collision_boxes;

    std::vector<ispc::PointForce>       force_point;
    std::vector<ispc::DirectionalForce> force_directional;
    std::vector<ispc::BoxForce>         force_box;

    sphWorld();
    void addParticles(sphParticle *p, size_t num_particles);
    void update(float32 dt);
};



#endif // _SPH_types_h_
