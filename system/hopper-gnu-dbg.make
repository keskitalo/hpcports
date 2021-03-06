
# OS environment version
#
# For hopper, bump the major version when upgrading compilers and bump
# the minor version when upgrading MPI or vendor libs.  Document configuration
# here:
#
# 1.0 : gcc-4.6.3, ACML 4.4.0, xt-mpich2 5.4.5, fftw 3.3.0.0, python 2.7.1
#

HPCP_ENV = 1.0

# suffix, to avoid name collisions with nersc modules

HPCP_MOD_SUFFIX = -hpcp

# software download location

HPCP_POOL = /project/projectdirs/cmb/modules/hpcports_pool

# toolchain (gnu, darwin, intel, ibm)

TOOLCHAIN = gnu
BUILD_DYNAMIC = FALSE

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

openmpi_OVERRIDE = TRUE
openmpi_VERSION = cray.mpich2
MPICC = cc
MPICXX = CC
MPIF77 = ftn
MPIFC = ftn
MPILIB = mpich

# compile flags

CFLAGS = -O0 -g -m64 -static -fPIC
CXXFLAGS = -O0 -g -m64 -static -fPIC
FFLAGS = -O0 -g -m64 -static -fPIC
FCFLAGS = -O0 -g -m64 -static -fPIC

# OpenMP flags

OMPFLAGS = -fopenmp

# Fortran mixing

FLIBS = /opt/gcc/4.6.3/snos/lib64/libgfortran.a
FCLIBS = /opt/gcc/4.6.3/snos/lib64/libgfortran.a
MPIFCLIBS =

# Linking

LIBS = -L/usr/common/usg/acml/4.4.0/gfortran64_mp/lib -lacml_mp /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a
LDFLAGS = /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a

# vendor math libraries

VENDOR = amd
AMD_INCLUDE = $(ACML_DIR)/gfortran64_mp/include
AMD_LIBDIR = $(ACML_DIR)/gfortran64_mp/lib
AMD_LIBS_CC = -lacml_mp -lacml_mv /opt/gcc/4.6.3/snos/lib64/libgfortran.a /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a
AMD_LIBS_CXX = -lacml_mp -lacml_mv /opt/gcc/4.6.3/snos/lib64/libgfortran.a /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a
AMD_LIBS_F77 = -lacml_mp -lacml_mv /opt/gcc/4.6.3/snos/lib64/libgfortran.a /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a
AMD_LIBS_FC = -lacml_mp -lacml_mv /opt/gcc/4.6.3/snos/lib64/libgfortran.a /opt/gcc/4.6.3/snos/lib64/libgomp.a /usr/lib64/librt.a

# package overrides

python_OVERRIDE = TRUE
python_SITE = python2.7
python_VERSION = 2.7.1

fftw_OVERRIDE = TRUE
fftw_VERSION = 3.3.0.0

nose_OVERRIDE = TRUE
nose_VERSION = 2.7.1

numpy_OVERRIDE = TRUE
numpy_VERSION = 2.7.1

scipy_OVERRIDE = TRUE
scipy_VERSION = 2.7.1

pyfits_OVERRIDE = TRUE
pyfits_VERSION = 2.7.1

ipython_OVERRIDE = TRUE
ipython_VERSION = 2.7.1

matplotlib_OVERRIDE = TRUE
matplotlib_VERSION = 2.7.1

mpi4py_OVERRIDE = TRUE
mpi4py_VERSION = 2.7.1

pyslalib_OVERRIDE = TRUE
pyslalib_VERSION = 2.7.1

scientific_OVERRIDE = TRUE
scientific_VERSION = 2.7.1

healpy_OVERRIDE = TRUE
healpy_VERSION = 2.7.1

numexpr_OVERRIDE = TRUE
numexpr_VERSION = 2.7.1

# pkg-config already works

pkgconfig_OVERRIDE = TRUE
pkgconfig_VERSION = sys

# we get BLAS from ACML and Lapack, and ScaLapack from Cray libsci

blas_OVERRIDE = TRUE
blas_VERSION = 4.4.0
blas_LIBS_CC = $(AMD_LIBS_CC)
blas_LIBS_CXX = $(AMD_LIBS_CXX)
blas_LIBS_FC = $(AMD_LIBS_FC)
blas_LIBS_F77 = $(AMD_LIBS_F77)

lapack_OVERRIDE = TRUE
lapack_VERSION = 11.0.06

scalapack_OVERRIDE = TRUE
scalapack_VERSION = 11.0.06

