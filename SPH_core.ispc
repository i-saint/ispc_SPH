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
    vec3 diff = pos2 - pos1;
    float d = length3(diff);
    if(d > 0.0f) { // d==0: 衝突元＆衝突相手が同一
        vec3 dir = diff / d;
        accel += dir * (-min(0.0f, d-(SPH_PARTICLE_SIZE*2.0f)) * SPH_PARTICLE_STIFFNESS);
    }
}

static inline void ComputeGravity(
    uniform vec3 pos1,
    uniform vec3 &vel1 )
{
    // x,y,z=0,0,0 で半径 CENTER_SPHERE_RADIUS の球があるもんとして重力で引っ張る＆衝突判定

    const uniform float CENTER_SPHERE_RADIUS = 1.5f;
    const uniform float GRAVITY = -0.002f;

    // 中心の球との衝突判定
    uniform vec3 diff = pos1;
    uniform float d = length3(diff);
    uniform vec3 dir = diff / d;
    vel1 += dir * (-min(0.0f, d-CENTER_SPHERE_RADIUS) * SPH_PARTICLE_STIFFNESS);

    // 重力加速
    vel1 += dir * GRAVITY;
}

task void UpdateVelocity(
    uniform int32 particle_num,
    soa<8> Particle all_particles[] )
{
    // particle_num が SIMD lane 数 (programCount) の倍数でない場合配列を突き抜けてアクセスしますが、
    // 適切にマージンを設けてあるという前提の元に無視します。
    // (foreach(i=0 ... particle_num) だと突き抜けないように適切に対処してくれますが、若干コストを伴うため、敢えてこうします)

    uniform int32 beg = SPH_FLUID_BLOCK_SIZE * taskIndex;
    uniform int32 end = min(SPH_FLUID_BLOCK_SIZE, particle_num-beg);
    soa<8> Particle * uniform particles = &all_particles[beg];

    for(uniform int32 i=0; i<end; ++i) {
        uniform vec3 pos1 = {particles[i].posx, particles[i].posy, particles[i].posz};
        uniform vec3 vel1 = {particles[i].velx, particles[i].vely, particles[i].velz};
        vec3 accel = {0.0f, 0.0f, 0.0f};
        for(uniform int32 ti=0; ti<particle_num; ti+=programCount) {
            int t = ti+programIndex;
            vec3 pos2 = {all_particles[t].posx, all_particles[t].posy, all_particles[t].posz};
            ComputeParticleInteraction(pos1, pos2, accel);
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

task void Integrate(
    uniform int32 particle_num,
    soa<8> Particle all_particles[] )
{
    uniform int32 beg = SPH_FLUID_BLOCK_SIZE * taskIndex;
    uniform int32 end = min(SPH_FLUID_BLOCK_SIZE, particle_num-beg);
    soa<8> Particle * uniform particles = &all_particles[beg];

    for(uniform int pi=0; pi<end; pi+=programCount) {
        int i = pi+programIndex;
        vec3 pos = {particles[i].posx, particles[i].posy, particles[i].posz};
        vec3 vel = {particles[i].velx, particles[i].vely, particles[i].velz};
        pos += vel;
        particles[i].posx = pos.x;
        particles[i].posy = pos.y;
        particles[i].posz = pos.z;
    }
}

export void sphUpdate(
    uniform int32 particle_num,
    soa<8> Particle particles[] )
{
    const uniform int32 block_num = sphFluidBlockNum(particle_num);
    launch[block_num] UpdateVelocity(particle_num, particles);
    sync;
    launch[block_num] Integrate(particle_num, particles);
    sync;
}
