#!/bin/bash

#SBATCH --job-name=runAllScenarios
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --array=1-22
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=500

# map array index to a capital letter
# i.e. 1 => 'A', 2 => 'B'
f(){
a=(_ {A..I} {1..26} {J..Z} {A..Z})
echo ${a[36#$1]}
}

# load matlab module
module load matlab/2018a

# navigate to the ReachabilityAnalysisAsADesignToolForStormwaterSystems directory
cd ../

# for array indices 1-16, map these to scenarios 'A'-'P' and use configuration 1
# otherwise map indices 17-22, map these scenarios to '1'-'6' and use configuration 2
if [ $SLURM_ARRAY_TASK_ID -le 16 ]
then
  matlab -r "Run_Scenario_And_Exit('$(f $SLURM_ARRAY_TASK_ID)',1)"
else
  matlab -r "Run_Scenario_And_Exit('$(($SLURM_ARRAY_TASK_ID - 16))',2)"
fi
