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


echo 'By default, this script will create the folder "testfiles" in directory' $(pwd) \n

# TODO: allow user to change the path
  # echo ""
  # echo $(pwd)
  # echo ""
  # read -e -p 'Enter new path, or else hit ENTER: ' dir
  # [ -z "${dir}" ] && dir=$(pwd)

# create folder for testfiles
if [[ ! -d "testfiles" ]]
  then
    mkdir -v testfiles
    echo \n
fi
# pause before creating the files



# append eicar test string into file

read -r -p "Do you want these files to look like viruses (using eicar test string)? (y/n)" response

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    eicar=1
else
    eicar=0
fi

# sleep 1

######################
### GENERATE FILES ###
######################

# Create output log
  echo  "GENERATE TEST FILES" $(date) >> testfiles/_output.txt

  if [[ $eicar == 1 ]]
  then
    echo "Files contain eicar Test string" >> testfiles/_output.txt
  fi

  echo "--------------------------------------"

# Write files

# TODO: for some reason this 2 files are created when $END=0, and the eicar string is not inserted into the file with data.
for i in $(seq 1 $END)
  do
    :
    # generate random filesize(KB) in range 2000-10000
    filename=$(rpw)_$(rpw)$(fileExtension)

    # writing blocks with /dev/urandom seemed to cause issues with the eicar string
    dd if=/dev/zero bs=$(randomNumber 2000 7000) count=1 of=testfiles/$filename >/dev/null 2>&1

    # append eicar test to newly created file
    if [[ $eicar == 1 ]]
    then
      # for some reason Metascan responds better to a file that was not written by DD &shrug;
      echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' >> testfiles/$filename
    fi

    # Add filename to the output log
    echo "testfiles/$(rpw)$(fileExtension)" >> testfiles/_output.txt

# TODO: loading bar?
done

echo "DONE"
echo $END "Test files have been generated"

