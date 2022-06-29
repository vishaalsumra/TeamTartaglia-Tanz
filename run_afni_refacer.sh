#!/bin/bash
# run_afni_refacer.sh

#This script runs the afni_refacer_run command and generates 3 volumes:
#defaced volume, refaced volume, and refaced plus volume

#Open terminal at bids directory

#create bidsubjects.txt from subject directory names, to use in for loop
printf '%s\n' * > bidsubjects.txt

for bidsubject in $(cat<"bidsubjects.txt");
do
  for file in ./"$bidsubject"/anat/*_T1w.nii.gz;
  do
    @afni_refacer_run               \
        -input $file                \
        -mode_all                   \
        -prefix ./"$bidsubject"/anat/"$bidsubject"_reface_T1w.nii.gz
    done
done
