#!/bin/bash
# Job name:
#PBS -N FedSate
# Output and error files:
#PBS -j oe
#PBS -o FedSate.log
# Queue name:
#PBS -q auto
# Resource requests:
#PBS -l select=1:ngpus=4
# Walltime (maximum run time):
#PBS -l walltime=70:30:00
# Project code:
#PBS -P H100011

# Load Singularity module
module load singularity

# Change to the directory from which the job was submitted
cd $PBS_O_WORKDIR

nvidia-smi

# Assign tasks to different GPUs
CUDA_VISIBLE_DEVICES=0 ./run_in_singularity.sh task1.sh &
CUDA_VISIBLE_DEVICES=1 ./run_in_singularity.sh task2.sh &
CUDA_VISIBLE_DEVICES=2 ./run_in_singularity.sh task3.sh &
CUDA_VISIBLE_DEVICES=3 ./run_in_singularity.sh task4.sh &

# ./run_in_singularity.sh task1.sh

# Wait for all tasks to finish
wait