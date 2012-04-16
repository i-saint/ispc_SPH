#ifndef _SPH_const_h_
#define _SPH_const_h_

#define SPH_PARTICLE_SIZE 0.02f
#define SPH_PARTICLE_STIFFNESS 1.0f

#define SPH_MAX_PARTICLE_NUM 131072
//#define SPH_MAX_PARTICLE_NUM 65536

#define SPH_GRID_SIZE 10.24
#define SPH_GRID_POS -10.24
#define SPH_GRID_CELL_SIZE 0.08f
#define SPH_GRID_DIV 256
#define SPH_GRID_DIV_BITS 8
#define SPH_GRID_CELL_NUM (SPH_GRID_DIV*SPH_GRID_DIV)

#endif // _SPH_const_h_
