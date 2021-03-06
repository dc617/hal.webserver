#!/usr/bin/perl

# prevents warning, use of smartmatch operator ~~ in line 30/58
no warnings 'experimental::smartmatch';

# makes list of sections
my @sections;
open (my $fh, '<', "sections.txt") or die "section file error";
while (my $row = <$fh>){
	chomp $row;
	push @sections, $row;
}

close $fh;
print "\nPlease choose a section: ";
$secName = <>;
chomp $secName;
until ($secName ~~ @sections){
	print "Please enter an existing section: ";
	$secName = <>;
	chomp $secName;
}

print "Preparing to delete all students and student files...\n";
print "Would you like to make a .zip archive before deleting students?:\n";
print "(y/n): ";
my $zipChoice = <>;
chomp $zipChoice;

# checks for valid input
while ($zipChoice !~ /^y$|^n$/){
	print "Please choose 'y' or 'n': ";
	$zipChoice = <>;
	chomp $zipChoice;
}

# zips files if requested, then continues
if ($zipChoice eq 'y'){
	system("perl ./toolScripts/zipDirs.pl");
	print "Continuing student deletion task...\n";
	$zipChoice = 'n';
}

# deletion of students
if ($zipChoice eq 'n'){

	# makes sure deletion is intended
	print "Are you sure you want to delete all students, and student directories?\n";
	print "(y/n):";

	# checks for valid input
	my $deleteChoice = <>;
	chomp $deleteChoice;
	while ($deleteChoice !~ /^y$|^n$/){
		print "Please choose 'y' or 'n': ";
		$deleteChoice = <>;
		chomp $deleteChoice;
	}
	
	# gets students group members, deletes student and entire home dir
	if ($deleteChoice eq 'y'){
		print "Deleting students and student directories...\n";
		my $students = `members $secName`;
		my @usernames = split / /, $students;
		foreach(@usernames){
			my $student = $_;
			system("deluser $student");
			system("rm -r /home/$student");
		}
	}

	# exits
	if ($deleteChoice eq 'n'){
		print "Exiting...\n";
	}
}

