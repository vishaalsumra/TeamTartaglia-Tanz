#!/bin/bash
# rename_move_bids.sh

#this script renames nii files to BIDS standard and moves them from the orginal scans to BIDS directory
#run this following the mkdir_bids script
#open a terminal at the root project directory

cd ${dir}
#THIS IS DESTINATION FOR CONVERTED NII FILES
dir2=/Volumes/LaCie_SSD_PRO_2TB/CIHR-FTLD_bids_conv/CIHR-FTLD_bids
#THIS IS ORIGINAL SCAN DIRECTORY THAT DCM2NIIX WAS RUN ON
dir=/Volumes/LaCie_SSD_PRO_2TB/CIHR-FTLD_bids_conv/CIHR-FTLD_original_scans

for i in $(cat<"subjects.tsv");
 do

   #to populate anat subdir
    #for T1w
    cp $dir/$i/SAGITTAL_IR-SPGR.nii.gz  $dir2/$i/anat/sub-"$i"_T1w.nii.gz
    cp $dir/$i/SAGITTAL_IR-SPGR.json  $dir2/$i/anat/sub-"$i"_T1w.json
    #for T2w
    cp $dir/$i/AX_T2_FRFSE.nii.gz  $dir2/$i/anat/sub-"$i"_T2w.nii.gz
    cp $dir/$i/AX_T2_FRFSE.json  $dir2/$i/anat/sub-"$i"_T2w.json
    #for FLAIR
    cp $dir/$i/AX_T2_FLAIR.nii.gz  $dir2/$i/anat/sub-"$i"_FLAIR.nii.gz
    cp $dir/$i/AX_T2_FLAIR.json  $dir2/$i/anat/sub-"$i"_FLAIR.json

#to populate func subdir
    #for fmri
    cp $dir/$i/fMRI_RESTING.nii.gz  $dir2/$i/func/sub-"$i"_rest_bold.nii.gz
    cp $dir/$i/fMRI_RESTING.json  $dir2/$i/func/sub-"$i"_rest_bold.json

#to populate dwi subdir
    #for dwi
    cp $dir/$i/DTI_ASSET_*.bval  $dir2/$i/dwi/sub-"$i"_dwi.bval
    cp $dir/$i/DTI_ASSET_*.bvec  $dir2/$i/dwi/sub-"$i"_dwi.bvec
    cp $dir/$i/DTI_ASSET_*.json  $dir2/$i/dwi/sub-"$i"_dwi.json
    cp $dir/$i/DTI_ASSET_*.nii.gz  $dir2/$i/dwi/sub-"$i"_dwi.nii.gz
    cp $dir/$i/AX_DTI_*.bval  $dir2/$i/dwi/sub-"$i"_dwi_opt.bval
    cp $dir/$i/AX_DTI_*.bvec  $dir2/$i/dwi/sub-"$i"_dwi_opt.bvec
    cp $dir/$i/AX_DTI_*.json  $dir2/$i/dwi/sub-"$i"_dwi_opt.json
    cp $dir/$i/AX_DTI_*.nii.gz  $dir2/$i/dwi/sub-"$i"_dwi_opt.nii.gz

#to populate perf subdir
    cp $dir/$i/3D_ASL_real.nii.gz  $dir2/$i/perf/sub-"$i"_m0scan.nii.gz
    cp $dir/$i/3D_ASL_real.json  $dir2/$i/perf/sub-"$i"_m0scan.json
    cp $dir/$i/3D_ASL_reala.nii.gz  $dir2/$i/perf/sub-"$i"_asl.nii.gz
    cp $dir/$i/3D_ASL_reala.json  $dir2/$i/perf/sub-"$i"_asl.json

done
