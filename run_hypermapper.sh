#!/bin/bash
# run_hyp3rmapp3r.sh
#SBATCH --nodes=2
#SBATCH --time=10:00:00
#SBATCH --ntasks-per-node=50
#SBATCH --job-name <your job name: ex - "run_hypermapper">
#SBATCH --mail-user= <your email here>
#SBATCH --mail-type=ALL


# NOTES:
# Make sure you have the hypermapper.sif file in the $bidsdir
# to build the container execute this in your bidsdir: singularity build hypermapper.sif docker://mgoubran/hypermapper


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

#renaming the brainmask made by icvmapp3r to what hypermapp3r expects
cp $bidsdir/$i/anat/anat_T1acq_nu_HfB_pred.nii.gz $bidsdir/$i/anat/anat_T1acq_nu_HfBd.nii.gz

# linear registration of the FLAIR image to the subject T1 space - they have to be in the same space otherwise it will not run
flirt -in $bidsdir/$i/anat/sub-"$i"_FLAIR.nii.gz -ref $bidsdir/$i/anat/sub-"$i"_ses-01SE01MR_T1w.nii.gz -out $bidsdir/$i/anat/sub-"$i"_FLAIR_reg2T1.nii.gz

# now running hypermapper
singularity exec -B /scratch hypermapper.sif hypermapper seg_wmh -t1 $bidsdir/$i/anat/sub-"$i"_ses-01SE01MR_T1w.nii.gz -fl $bidsdir/$i/anat/sub-"$i"_FLAIR_reg2T1.nii.gz

 done
 wait
