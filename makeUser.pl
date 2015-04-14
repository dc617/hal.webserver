#!/usr/bin/perl

use List::MoreUtils 'any';

print "How many users do you want to create?: ";
chomp($num=<>);
print "Creating $num users...\n";
my $students = `members students`; # gets student names
my @usernames = split / /, $students; # split to array
for my $i (1..$num){
	my $username = "group$i";
	my $matchFound = 0; # set matchFound to false
	# if username is in usernames, matchFound = true
	my $matchFound = any {/$username/} @usernames;
	# flags username and skips
	if ($matchFound){print "$username already exists\n"; next;}
	print "User '$username' being created...\n"; 
	# makes home dir if not existing, creates user, adds to students group
	system("useradd -g students -m -d /home/$username $username");
	#creates groups public html directory
	my $directory = "/home/$username/public_html";
	unless (-e $directory or mkdir $directory){
		die "Error creating public_html dir for $username\n";}
	my $indexFile = "index.html";
	open(my $fh, '>', "$directory/index.html")
		or die "Error creating index.html for $username\n";
		print $fh "Hello $username!";
	close $fh;
	# creates starter pass to be changed 'it240username'
	system("echo $username:it240$username | chpasswd");
	# forces user to change on first login
	system("chage -d 0 $username");
}

