#ifndef __SPH_collision_h__
#define __SPH_collision_h__

#include "ispc_vectormath.h"
#include "SPH_const.h"


struct Sphere
{
    float x, y, z;
    float radius;
};

struct Plane
{
    float nx, ny, nz;
    float distance;
};

struct Box
{
    Plane planes[6];
};


struct Particle
{
    float   x, y, z;
    float   vx, vy, vz;
    float   density;
    int32   hit;
    int32   lifetime;
};

struct Force
{
    float ax, ay, az;
};

struct GridData
{
    int32 begin, end;
    int32 soai;
    float density;
};


// struct �̎Q�Ɠn�����ł��Ȃ����ۂ��̂� macro ��...
// �����̌^�ɑΉ��ł���̂łނ��낱�����̂������̂���
#define get_pos(p)      {p.x, p.y, p.z}
#define get_vel(p)      {p.vx, p.vy, p.vz}
#define get_normal(p)   {p.nx, p.ny, p.nz}
#define get_accel(p)    {p.ax, p.ay, p.az}
#define set_pos(p, v)   p.x=v.x; p.y=v.y; p.z=v.z;
#define set_vel(p, v)   p.vx=v.x; p.vy=v.y; p.vz=v.z;
#define set_accel(p, v) p.ax=v.x; p.ay=v.y; p.az=v.z;

#define repulse(p, f, n, d)\
    {\
        p.hit++;\
        vec3 accel = get_accel(f);\
        accel += n * (-d * SPH_WALL_STIFFNESS);\
        set_accel(f, accel);\
    }


#endif // __SPH_collision_h__
