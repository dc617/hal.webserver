#!/usr/bin/perl

$filename = 'pass.txt.enc';

# see if enc pass file exists
if (-e $filename){
	
	# decrypts pass.txt.enc and creates passwords.txt
	system ("openssl aes-256-cbc -d -a -in $filename -out passwords.txt");
}


# maybe use cron to check for file and delete if left undeleted?
