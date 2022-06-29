#!/bin/bash
# dcm2niix_loop.sh

#Open terminal at original scan raw data directory

#create subjects.txt from subject directory names, to use in for loop
printf '%s\n' * > subjects.txt


for subject in $(cat<"subjects.txt");
do
  for file in ./"$subject"/*.tar;
  do
    tar -zxf "$file" -C ./"$subject"/; #this extracts all the tar files
  done
  for file in ./"$subject"/*.tar.gz;
  do
    tar -zxf "$file" -C ./"$subject"/; #this extracts all the tar.gz files
  done
done
