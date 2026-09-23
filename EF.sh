#!/bin/bash -l
#SBATCH -p normal_q
#SBATCH -J D10GSG8
#SBATCH -N 1
#SBATCH --ntasks-per-node=128 
#SBATCH -t 96:00:00
#SBATCH -A welbornlab
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=junbaol@vt.edu

DRIVER_LOC=/projects/welbornlab/Junbao/ELECTRIC/ELECTRIC/ELECTRIC.py
TINKER_LOC=/projects/welbornlab/Junbao/ELECTRIC/modules/Tinker/build/tinker/source/dynamic.x

#conda activate
source activate electric
#module load Miniconda3/23.10.0-1
rm -r work_bymol
mkdir work_bymol
cp * work_bymol/
cd work_bymol

# number of instances of Tinker to run as an engine
nengines=128

# set the number of threads used by each code
export OMP_NUM_THREADS=1
date +"%m-%d-%y %T"

# launch Tinker as an engine 
for i in $( eval echo {1..$nengines} )
do
${TINKER_LOC} 5o6p_8_final_dynamic.xyz  -k EF.key -mdi "-role ENGINE -name NO_EWALD -method TCP -port 8032 -hostname localhost"  10 1.0 0.001999 2 300.00 > no_ewald${i}.log &
done 

# launch the driver
python ${DRIVER_LOC} -probes "170 3440 3441 3442 135 167" -snap centered.arc -mdi "-role DRIVER -name driver -method TCP -port 8032" --bymol   --equil 10000   --nengines ${nengines} &
 
wait
date +"%m-%d-%y %T"
