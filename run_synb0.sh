#!/bin/bash
# run_synb0.sh
#SBATCH --nodes=2
#SBATCH --time=12:00:00
#SBATCH --ntasks-per-node=50
#SBATCH --job-name <your job name: ex - "run_synb0">
#SBATCH --mail-user= <your email here>
#SBATCH --mail-type=ALL



# NOTES:
# Make sure you have the synb0.sif file as well as the freesurfer license.txt in the $bidsdir
# if you want to do topup to create your feildmap then remove the --notopup from the last line where you're running singularity
# to build the container execute this in : "singularity build --sandbox synb0.sif docker://hansencb/synb0"




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

for i in $(cat<"subjects.txt"); #list of all subjects
 do

# makes a processing folder within the big bids directory specifically for synb0
mkdir $bidsdir/$i/proc/
mkdir $bidsdir/$i/proc/synb0
mkdir $bidsdir/$i/proc/synb0/INPUTS
mkdir $bidsdir/$i/proc/synb0/OUTPUTS

# Copying T1 to INPUTSdir
cp $bidsdir/$i/anat/sub-"$i"_ses-01SE01MR_T1w.nii.gz $bidsdir/$i/proc/synb0/INPUTS/T1.nii.gz

# Copying b0 (first volume of the dwi) to the INPUTSdir
fslroi $bidsdir/$i/dwi/sub-"$i"_dwi.nii.gz $bidsdir/$i/proc/synb0/INPUTS/b0.nii.gz 0 1

# Running synb0
singularity run -e -B $bidsdir/$i/proc/synb0/INPUTS/:/INPUTS -B $bidsdir/$i/proc/synb0/OUTPUTS/:/OUTPUTS -B $bidsdir/license.txt:/extra/freesurfer/license.txt $bidsdir/synb0.sif --notopup

 done
 wait
