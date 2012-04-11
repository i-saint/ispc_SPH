#ifndef _SPH_const_h_
#define _SPH_const_h_

#define SPH_PARTICLE_SIZE 0.02f
#define SPH_PARTICLE_STIFFNESS 1.0f
#define SPH_MAX_PARTICLE_NUM 8192

#define SPH_GRID_SIZE 1.28f
#define SPH_GRID_CELL_SIZE 0.04f
#define SPH_GRID_DIV 32
#define SPH_GRID_CELL_NUM (SPH_GRID_DIV*SPH_GRID_DIV*SPH_GRID_DIV)

#endif // _SPH_const_h_
