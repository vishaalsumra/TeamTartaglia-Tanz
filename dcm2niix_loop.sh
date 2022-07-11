#!/bin/bash
# dcm2niix_loop.sh

#Open terminal at original scan raw data directory
#Run this script afer tar_extract.sh
#this uses dc,2niix to convert scan directories into nii files and json sidecars
#it will name the file after what scan it is

#this will take some time, depending how many subjects you have

for subject in $(cat<"subjects.tsv");
do
  for dir in ./"$subject"/;
  do
    dcm2niix -ba y -z y -f '%d' -o ./"$subject"/ ./"$subject"/ #converts the GE .MR files to nii and names using scan names so you can tell whats what
  done
done
