#!/bin/bash
# run_icvmapp3r.sh
#SBATCH --nodes=2
#SBATCH --time=10:00:00
#SBATCH --ntasks-per-node=50
#SBATCH --job-name <your job name: ex - "run_icvmapper">
#SBATCH --mail-user= <your email here>
#SBATCH --mail-type=ALL



# NOTES:
# Make sure you have the icvmapper.sif file in the $bidsdir
# to build the container execute this in your bidsdir: singularity build icvmapper.sif docker://mgoubran/icvmapper

# DIRECTORY TO RUN - $SLURM_SUBMIT_DIR is the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR

#module load gnu-parallel/20191122
HOSTS=$(scontrol show hostnames $SLURM_NODELIST | tr '\n' ,)

bidsdir=/scratch/c/carmela/<your big folder with bids organized data>

module load NiaEnv
module load singularity
module load gcc/8.3.0
module load openblas/0.3.7
module load fsl

for i in $(cat<"subjects.txt");
 do

singularity exec -B /scratch icvmapper.sif icvmapper seg_icv -t1 $bidsdir/$i/anat/sub-"$i"_ses-01SE01MR_T1w.nii.gz -b

 done
 wait
