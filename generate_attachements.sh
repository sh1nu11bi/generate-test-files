#!/bin/bash

cat<<"EOT"

-----------------------------------
G E N E R A T E  T E S T  F I L E S
-----------------------------------

EOT

###########################################
### (Generate) Random Pronouncable Word ###
###########################################

# This function was originally written by Ozh in php, and ported to bash by Hajo
# http://planetozh.com/blog/2012/10/generate-random-pronouceable-words/

function rpw {

  cons=(b c d f g h j k l m n p r s t v w x z pt gl gr ch ph ps sh st th wh)
  conscs=(ck cm dr ds ft gh gn kr ks ls lt lr mp mt ms ng ns rd rg rs rt ss ts tch)
  vows=(a e i o u y ee oa oo)

  len=$((($1+0 == 0) ? 6 : $1+0))
  alt=$RANDOM
  word=

  while [ ${#word} -lt $len ]; do

  if [ $(($alt%2)) -eq 0 ]; then
      rc=${cons[(($RANDOM%${#cons[*]}))]}
    else
      rc=${vows[(($RANDOM%${#vows[*]}))]}
  fi

  if [ $((${#word}+${#rc})) -gt $len ]; then continue; fi

    word=$word$rc

    ((alt++))

    if [ ${#conscs[*]} -gt 0 ]; then
      cons=(${cons[@]} ${conscs[@]})
      conscs=()
  fi

  done

  echo $word
}
#############################################
### Generate Random Number within a range ###
#############################################

function randomNumber {

  # Test to see which coreutil to use to generate random number
  # $1 = start of range
  # $2 = end of range
    if hash shuf 2>/dev/null
    then
        echo $(shuf -i $1-$2 -n 1)

    elif hash gshuf 2>/dev/null
    then
        echo $(gshuf -i $1-$2 -n 1)

    elif hash jot 2>/dev/null
    then
         echo $(jot -rn 1 $1 $2)

    else
        echo "ERROR! You need to have shuf (or jot) installed in order to run this script"
    fi
  }

####################################
### Pick file extension randomly ###
####################################

# use common files more frequently

function fileExtension {
  randomTen=$(randomNumber 0 100)

  if [[ $randomTen -lt 10 ]]
   then fileExt=".exe"

  elif [[ $randomTen -lt 25 ]]
    then fileExt=".pdf"


  elif [[ $randomTen -lt 50 ]]
    then fileExt=".xls"

  elif [[ $randomTen -lt 65 ]]
    then fileExt=".ppt"

  else
    fileExt=".doc"
  fi

  echo $fileExt
}

###################
### USER PROMPT ###
###################

# #aks user for number of loops
read -p "How many files would you like to create? " END

# dir=$(pwd)/testfiles/
# echo -n "By default, files will be created in:" $dir
# read directory
# echo $directory
read -p "By default, this script will create folder "testfiles" in directory $(pwd). Do you want to change it? (Y/n) "
[ -z "${var}" ] && var='$(pwd)/testfiles/'
$var
# echo "By default, files will be created in:" $dir
# echo "Would you like to change the directory? (y/N)"

# echo -n "Would you like to change the output directory? (y/N) "
# read dir
# #TODO: append eicar test string into file (using >> filename.ext?)
# echo "Do you want these files to look like viruses s(using Eicar test string)?"
# read eicar
# # Eicar test string
# # X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*



######################
### GENERATE FILES ###
######################


for i in $(seq 1 $END)
do
 :
# generate random filesize(KB) in range 2000-10000

  dd if=/dev/urandom bs=1 count=$(randomNumber 2000 7000) of=$dir $(rpw)$(fileExtension) >/dev/null 2>&1

  echo "testfiles/$(rpw)$(fileExtension)"

done






# i=1
# # loop through and create files
# while [ $i -le $end ];
#   do createFileExtension;
#   echo $fileExt;
#   i=$(($i + 1))
# done

# # append files with Eicar test
# for i in {1..3}; do
#   filename=file$i.txt
#   dd if=/dev/urandom bs=1 count=20 of=$filename
#   sed -i "1 a\ this would be EICAR test" $filename
#   cat $filename
# done


# # Generate random pronouncable words
#   # http://planetozh.com/blog/2012/10/generate-random-pronouceable-words/





# function createLogFile {
#   array=(things might actually work out)

#   for i in "${array[@]}"
#     do
#       :
#       echo $i >> output.txt
#   done
# }