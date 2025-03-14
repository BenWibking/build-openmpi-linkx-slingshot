#!/bin/sh

INSTALL_PREFIX=$HOME/mpi_install
CASSINI_PREFIX=$HOME/cassini_build
CUDA_ROOT=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-12.4.0-6bzpo2x
LD_LIBRARY_PATH="$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH"

./configure --prefix=$INSTALL_PREFIX CC=mpicc CXX=mpicxx --enable-cuda --with-cuda=$CUDA_ROOT --with-cuda-libpath=/usr/lib64 LDFLAGS="-L$CUDA_ROOT/lib64 -lcudart -lcuda"
