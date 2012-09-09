#include "../SPH_types.h"
#include "DynamicObjLoader.h"

extern sphWorld         g_sphgrid;


DOL_Module


DOL_Export void InitializeCollisions()
{
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
        g_sphgrid.collision_spheres.push_back(sphere);
    }
    {
        ispc::Plane plane;
        set_nxyz(plane, 1.0f, 0.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        g_sphgrid.collision_planes.push_back(plane);
        set_nxyz(plane,-1.0f, 0.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        g_sphgrid.collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f, 1.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        g_sphgrid.collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f,-1.0f, 0.0f); plane.distance = SPH_GRID_SIZE;
        g_sphgrid.collision_planes.push_back(plane);
        set_nxyz(plane, 0.0f, 0.0f,-1.0f); plane.distance = 0.0f;
        g_sphgrid.collision_planes.push_back(plane);
    }

    {
        ispc::PointForce force;
        set_xyz(force, 0.0f, 0.0f, 0.0f); force.strength = -0.001f;
        g_sphgrid.force_point.push_back(force);
    }
    {
        ispc::DirectionalForce force;
        set_nxyz(force, 0.0f, 0.0f, 1.0f); force.strength = 5.0f;
        g_sphgrid.force_directional.push_back(force);
    }
}


DOL_OnLoad({
})
