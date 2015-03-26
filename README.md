# generate-test-files
This bash script generates test files between the sizes of 2000-7000 KB with random pronouncable names. It was originally written to generate file attachments in order to test OPSWAT's Metascan 3.9.1 Mail Agent.

## file creation
A prompt will ask for the number of files you would like to create. All test files are be placed inside a folder named "testfiles", which is created in the current working directory.

## Eicar Test String
The eicar test string has very lower detection ratio when appended to a file that already has data written to it. For this reason, if you select the option to generate files that will look like a virus, the file will be created without a variable file size.

## Compatibility
This script was written on OSX 10.10 with Bash3.2. It test for different version of coreutils to create random numbers (shuf, gshuf & jot).

