#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=1      # number of processors per task
#SBATCH -J "fsall"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o fsall-slurm.%N.%j.out # STDOUT
#SBATCH -e fsall-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
wfall = DPT.objects.processDirs(dirs=None, exclude=['*array04*', '*eye*', '*mountains*'], objtype=pyh.Waveform); \
wfall.save();"


