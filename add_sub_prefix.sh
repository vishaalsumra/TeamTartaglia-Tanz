#!/bin/bash
# add_sub_prefix.sh

#Open terminal at bids directory

for subject in $(cat<"subjects.txt");
do
  mv $subject sub-$subject
done
