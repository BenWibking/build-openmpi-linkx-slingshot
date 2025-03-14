#!/bin/sh

INSTALL_PREFIX=$HOME/mpi_install
CASSINI_PREFIX=$HOME/cassini_build
CUDA_ROOT=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-12.4.0-6bzpo2x
LD_LIBRARY_PATH="$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH"

## download openmpi
wget https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.7.tar.bz2
tar xvf openmpi-5.0.7.tar.bz2
cd openmpi-5.0.7

## apply patch
wget https://patch-diff.githubusercontent.com/raw/open-mpi/ompi/pull/13090.patch
patch -p1 < ../13090.patch

./configure --prefix=$INSTALL_PREFIX --with-ofi=$INSTALL_PREFIX --with-cuda=$CUDA_ROOT CC=cc --with-cuda-libdir=/usr/lib64 LDFLAGS="-L$CUDA_ROOT/lib64/" --with-libevent=internal --with-hwloc=internal --with-pmix=internal
