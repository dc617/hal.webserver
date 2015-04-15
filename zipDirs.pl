#!/usr/bin/perl

print "Do you want to get a .zip of all groups or a specific group?\n";
print "(all/spec): ";
my $zipScope = <>;
chomp $zipScope;

# make sure input is only all or spec
while ($zipScope !~ /^all$|^spec$/){
	print "Please choose 'all' or 'spec': ";
	$zipScope = <>;
	chomp $zipScope;
}

# get all student names, split to array
my $students = `members students`;
my @usernames = split / /, $students;
my $allStudents = '';
foreach(@usernames){
	$allStudents .= "/home/$_ ";
}

# zips all user directories
if ($zipScope eq 'all'){

	# this needs some more checks to make sure contains
	# no spaces, invalid chars, and has .zip/appends .zip
	print "Please enter the desired name of your .zip archive: ";
	my $zipName = <>;
	chomp $zipName;
	system("zip -r ~/$zipName $allStudents"); 
}

if ($zipScope eq 'spec'){

	print "Please enter a student group you would like a .zip archive of: ";
	
	# this should be checked against @usernames
	my $specStudent = <>;
	chomp $specStudent;
	print "Please enter the desired name of your .zip archive: ";
	my $zipName = <>;
	chomp $zipName;
	system("zip -r ~/$zipName /home/$specStudent"); 
}
