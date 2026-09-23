#!/bin/bash
#SBATCH -J betaG16P
#SBATCH -A welborn
#SBATCH -p normal_q
#SBATCH -N 1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=48
#SBATCH --time=1-00:00:00

echo "-------- Starting Poltype2: $(date) -------"

# Source conda initialization to ensure 'conda activate' works correctly
source ~/anaconda3/etc/profile.d/conda.sh

# Activate your environment
conda activate mypoltype2

# Optional: verify the environment and Python interpreter being used
echo "Active conda environment: $CONDA_DEFAULT_ENV"

source paths.sh

# Run Poltype2
python /projects/welbornlab/Poltype2/master_Feb2025/PoltypeModules/poltype.py

echo "------- Poltype2 has exited: $(date) --------"
