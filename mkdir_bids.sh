#!/bin/bash
# mkdir_bids.sh

#this script makes the bids directory structure you will need to copy the nii files into, that you created using dcm2niix script
#open a terminal at the root project directory

mkdir CIHR-FTLD_bids
cp /Volumes/LaCie_SSD_PRO_2TB/CIHR-FTLD_bids_conv/CIHR-FTLD_original_scans/subjects.txt CIHR-FTLD_bids

cd CIHR-FTLD_bids
mkdir $(<subjects.txt) #this populates the directory with subdirectories for each subject

for subject in $(cat<"subjects.txt");
 do
   #Make scan subdirectories in each subject directory
   mkdir $subject/anat
   mkdir $subject/func
   mkdir $subject/dwi
   mkdir $subject/perf
done
