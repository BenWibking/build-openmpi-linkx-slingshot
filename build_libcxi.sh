#!/bin/sh

INSTALL_PREFIX=$HOME/mpi_install

export LIBNL_CFLAGS="-I$INSTALL_PREFIX/include"
export LIBNL_LIBS="-L$INSTALL_PREFIX/lib"
export LIBFUSE_CFLAGS="-I$INSTALL_PREFIX/include"
export LIBFUSE_LIBS="-L$INSTALL_PREFIX_/lib"
export LIBUV_CFLAGS="-I$INSTALL_PREFIX/include"
export LIBUV_LIBS="-L$INSTALL_PREFIX/lib"
export LIBCONFIG_CFLAGS="-I$INSTALL_PREFIX/include"
export LIBCONFIG_LIBS="-L$INSTALL_PREFIX/lib"

export LD_LIBRARY_PATH="$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH"
export LDFLAGS="-L$INSTALL_PREFIX/lib -lnl-3 -lfuse -lconfig -luv"
export CFLAGS="-I$INSTALL_PREFIX/include -I$INSTALL_PREFIX/include/libnl3 -D_FILE_OFFSET_BITS=64"

CUDA_ROOT=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-12.4.0-6bzpo2x

./configure --prefix=$INSTALL_PREFIX --with-systemdsystemunitdir=$INSTALL_PREFIX/systemd --with-udevrulesdir=$INSTALL_PREFIX/udev --with-cuda=$CUDA_ROOT --without-rocm

make -j
make install
