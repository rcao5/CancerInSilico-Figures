#!/bin/bash -l

#SBATCH
#SBATCH --job-name=cleanData
#SBATCH --time=1:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=end
#SBATCH --mail-user=tsherma4@jhu.edu

time Rscript cleanData.R
