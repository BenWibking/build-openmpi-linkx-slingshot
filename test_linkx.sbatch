#!/bin/bash
#SBATCH --job-name="test_linkx"
#SBATCH --partition=gpuA100x4-interactive
#SBATCH --account=cvz-delta-gpu
#SBATCH --mem=0
#SBATCH --exclusive
#SBATCH --time=0:10:00
#SBATCH --constraint="scratch"
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=none

## env vars for custom OpenMPI/libfabric/libcxi build
export PATH=$HOME/mpi_install/bin:$PATH
export LD_LIBRARY_PATH=$HOME/mpi_install/lib:$LD_LIBRARY_PATH

## set libfabric vars
export FI_LNX_PROV_LINKS=shm+cxi
export FI_LOG_LEVEL=debug

## SLURM_LOCALID is not set when using mpirun, so we use OMPI_COMM_WORLD_LOCAL_RANK instead
mpirun -np 2 -mca pml cm -mca mtl ofi -mca opal_common_ofi_provider_include "shm+cxi:lnx" -prtemca ras_base_launch_orted_on_hn 1 -map-by numa bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-OMPI_COMM_WORLD_LOCAL_RANK));
    ~/mpi_install/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bibw D D"
