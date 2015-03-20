# generate-test-files
This bash script generates a variable number of test files between the sizes of 2000-7000 KB with random pronouncable names. It was originally written to generate file attachments for the purposes of testing OPSWAT's Metascan 3.9.1 Mail Agent.

It was written for OSX 10.10 with Bash3.2, although it does test for different version of coreutils to create random numbers (shuf, gshuf & jot).

