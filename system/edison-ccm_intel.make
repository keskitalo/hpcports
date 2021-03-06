
# use this prefix (set from the command line) to update the 
# live hpcports install used by many people
#
#export HPCP_PREFIX=/project/projectdirs/cmb/modules/edison/hpcports_gnu

# OS environment version
#
# For edison, bump the major version when upgrading compilers and bump
# the minor version when upgrading MPI or vendor libs.  Document configuration
# here:
#
# 1.0 :  intel-14.0.0.080, mkl-13.0.3
#

HPCP_ENV = 1.0

# suffix, to avoid name collisions with nersc modules

HPCP_MOD_SUFFIX = -hpcp

# software download location

HPCP_POOL = /project/projectdirs/cmb/modules/hpcports_pool

# toolchain (gnu, darwin, intel, ibm)

TOOLCHAIN = intel
BUILD_DYNAMIC = TRUE

# UNIX tools

SHELL = /bin/bash
MAKE = make -s

# permissions on installed files

INST_GRP = cmb
INST_PERM = g+rwX,o+rX

# serial compilers

CC = cc
CXX = CC
F77 = ftn
FC = ftn

# MPI compilers

openmpi_EXTRA = --without-tm

# compile flags

CFLAGS = -O3 -fPIC -DNDEBUG
CXXFLAGS = -O3 -fPIC -DNDEBUG -std=c++11
FFLAGS = -O3 -fPIC -DNDEBUG -fexceptions
FCFLAGS = -O3 -fPIC -DNDEBUG -fexceptions

# OpenMP flags

OMPFLAGS = -openmp

# Fortran mixing
FLIBS = -lifcoremt
FCLIBS = -lifcoremt
MPIFCLIBS =

# Linking

LIBS = -lm -lpthread
LDFLAGS =

# vendor math libraries

VENDOR = intel
INTEL_PREFIX = /opt/intel/composer_xe_2013_sp1.0.080
INTEL_INCLUDE = $(INTEL_PREFIX)/mkl/include
INTEL_LIBDIR = $(INTEL_PREFIX)/mkl/lib/intel64
#INTEL_LIBS_CC = -lmkl_rt
#INTEL_LIBS_CC = -lmkl_rt -lmkl_mc3
INTEL_LIBS_CC = -lmkl_intel_lp64 -lmkl_core -lmkl_intel_thread -liomp -lpthread -lm
INTEL_LIBS_CXX = $(INTEL_LIBS_CC)
INTEL_LIBS_F77 = $(INTEL_LIBS_CC)
INTEL_LIBS_FC = $(INTEL_LIBS_CC)

# package overrides

git_OVERRIDE = TRUE
git_VERSION = 1.8.1.1

# pkg-config already works

pkgconfig_OVERRIDE = TRUE
pkgconfig_VERSION = sys

# we get BLAS and Lapack from MKL

blas_OVERRIDE = TRUE
blas_VERSION = 13.0.3
blas_LIBS_CC = $(INTEL_LIBS_CC)
blas_LIBS_CXX = $(INTEL_LIBS_CXX)
blas_LIBS_F77 = $(INTEL_LIBS_F77)
blas_LIBS_FC = $(INTEL_LIBS_FC)

lapack_OVERRIDE = TRUE
lapack_VERSION = 13.0.3
lapack_LIBS_CC = -lmkl_lapack95_lp64
lapack_LIBS_CXX = $(lapack_LIBS_CC)
lapack_LIBS_F77 = $(lapack_LIBS_CC)
lapack_LIBS_FC = $(lapack_LIBS_CC)

# package overrides

tcl_OVERRIDE = TRUE
tcl_VERSION = 8.5.5

tk_OVERRIDE = TRUE
tk_VERSION = 8.5.5

