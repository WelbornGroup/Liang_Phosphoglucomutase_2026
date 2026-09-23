#!/bin/bash
#SBATCH --account=welborn
#SBATCH --partition=l40s_normal_q
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=12
#SBATCH --cpus-per-task=1
#SBATCH --time=96:00:00

# Each node type has different modules avilable. Resetting makes the appropriate stack available
module reset
module load Tinker9/1.4.0-NVHPC-25.1


# Run the example
echo "-------- Starting tinker9: `date` -------"

tinker9 dynamic  5o6p_24_final.xyz_3  54730000 1 10 4 300 1 > dynamics_to300ns.log

echo "------- tinker9 has exited: `date` --------"
