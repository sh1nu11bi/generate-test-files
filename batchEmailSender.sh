#!/bin/bash

# copy columns from CSV

  # column 1
  name=( $(cut -d ',' -f1 dummy-data.csv ) )
  # column 2
  username=( $(cut -d ',' -f2 dummy-data.csv ) )
  # column 3
  email=( $(cut -d ',' -f3 dummy-data.csv ) )

for i in {1..20}
  do
    :
    echo "${name[i]} / ${username[i]} / ${email[i]}"
done
 
# Turn it into an array

# Perform the batch send
  # Then iterate over each value in the array
  # and iterate over testfiles

  # add those values to command for EmailSender
#done