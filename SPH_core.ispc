// コンパイルは↓みたいなカスタムビルドステップで。
// ispc %(FullPath) -o $(TargetDir)%(Filename).obj -h $(TargetDir)%(Filename)_ispc.h --target=sse2,sse4,avx --arch=x86-64 --opt=fast-masked-vload --opt=fast-math
// 
// Intel SPMD はこちら
// http://ispc.github.com/


#include "ispc_vectormath.h"
#include "SPH_const.h"
typedef unsigned int32 uint32;

const uniform int32 SPH_FLUID_BLOCK_SIZE = 128;


struct Particle
{
    float   posx, posy, posz;
    float   velx, vely, velz;
};

struct GridData
{
    int32 x;
    int32 y;
    int32 soai;
    float density;
};


static uniform int32 sphFluidBlockNum(uniform int32 n)
{
    uniform int32 b = (n / SPH_FLUID_BLOCK_SIZE);
    b += (n % SPH_FLUID_BLOCK_SIZE > 0 ? 1 : 0);
    return b;
}


static inline void ComputeParticleInteraction(
    vec3 pos1,
    vec3 pos2,
    vec3 &accel )
{
    const uniform float SPH_RCP_PARTICLE_SIZE2 = 1.0f/(SPH_PARTICLE_SIZE*2.0f);
    vec3 diff = pos2 - pos1;
    float d = length3(diff); // float d = length3est(diff); // 何故か est の方が遅くなる
    if(d > 0.0f) { // d==0: 衝突元＆衝突相手が同一
        vec3 dir = diff * SPH_RCP_PARTICLE_SIZE2; // vec3 dir = diff / d;
        accel += dir * (min(0.0f, d-(SPH_PARTICLE_SIZE*2.0f)) * SPH_PARTICLE_STIFFNESS);
    }
}

static inline void ComputeGravity(
    uniform vec3 pos1,
    uniform vec3 &vel1 )
{
    // x,y,z=0,0,0 で半径 CENTER_SPHERE_RADIUS の球があるもんとして重力で引っ張る＆衝突判定

    const uniform float CENTER_SPHERE_RADIUS = 1.0f;
    const uniform float GRAVITY = 0.002f;
    const uniform float DECELERATE = 0.997;

    // 中心の球との衝突判定
    uniform vec3 diff = -pos1;
    uniform float d = length3(diff);
    uniform vec3 dir = diff / d;
    vel1 += dir * (min(0.0f, d-CENTER_SPHERE_RADIUS) * SPH_PARTICLE_STIFFNESS);

    // 重力加速
    vel1 += dir * GRAVITY;

    // 自然減速
    vel1 *= DECELERATE;
}

export void sphUpdateVelocity(
    soa<8> Particle all_particles[],
    GridData uniform grid[],
    uniform int32 xi, uniform int32 yi )
{
    uniform const GridData &gd = grid[yi*SPH_GRID_DIV + xi];
    uniform const int32 particle_num = gd.y - gd.x;
    soa<8> Particle * uniform particles = &all_particles[gd.soai*8];

    uniform const int32 nx_beg = max(xi-1, 0);
    uniform const int32 nx_end = min(xi+1, SPH_GRID_DIV-1);
    uniform const int32 ny_beg = max(yi-1, 0);
    uniform const int32 ny_end = min(yi+1, SPH_GRID_DIV-1);

    for(uniform int32 i=0; i<particle_num; ++i) {
        uniform vec3 pos1 = {particles[i].posx, particles[i].posy, particles[i].posz};
        uniform vec3 vel1 = {particles[i].velx, particles[i].vely, particles[i].velz};
        vec3 accel = {0.0f, 0.0f, 0.0f};
        for(uniform int32 nxi=nx_beg; nxi<nx_end; ++nxi) {
            for(uniform int32 nyi=ny_beg; nyi<ny_end; ++nyi) {
                uniform const GridData &ngd = grid[nyi*SPH_GRID_DIV + nxi];
                soa<8> Particle * uniform neighbors = &all_particles[ngd.soai*8];
                uniform const int32 neighbor_num = ngd.y - ngd.x;
                foreach(t=0 ... neighbor_num) {
                    vec3 pos2 = {neighbors[t].posx, neighbors[t].posy, neighbors[t].posz};
                    ComputeParticleInteraction(pos1, pos2, accel);
                }
            }
        }

        vel1.x  += reduce_add(accel.x);
        vel1.y  += reduce_add(accel.y);
        vel1.z  += reduce_add(accel.z);
        ComputeGravity(pos1, vel1);

        particles[i].velx = vel1.x;
        particles[i].vely = vel1.y;
        particles[i].velz = vel1.z;
    }
}

export void sphIntegrate(
    soa<8> Particle all_particles[],
    GridData uniform grid[],
    uniform int32 xi, uniform int32 yi )
{
    uniform const GridData &gd = grid[yi*SPH_GRID_DIV + xi];
    uniform const int32 particle_num = gd.y - gd.x;
    soa<8> Particle * uniform particles = &all_particles[gd.soai*8];

    foreach(i=0 ... particle_num) {
        vec3 pos = {particles[i].posx, particles[i].posy, particles[i].posz};
        vec3 vel = {particles[i].velx, particles[i].vely, particles[i].velz};
        pos += vel;
        particles[i].posx = pos.x;
        particles[i].posy = pos.y;
        particles[i].posz = pos.z;
    }
}
