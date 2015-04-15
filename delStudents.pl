#!/usr/bin/perl

print "Preparing to delete all students and student files...\n";
print "Would you like to make a .zip archive before deleting students?:\n";
print "(y/n): ";
my $zipChoice = <>;
chomp $zipChoice;

while ($zipChoice !~ /^y$|^n$/){
	print "Please choose 'y' or 'n': ";
	$zipChoice = <>;
	chomp $zipChoice;
}

if ($zipChoice eq 'y'){
	system("perl zipDirs.pl");
	print "Continuing student deletion task...\n";
	$zipChoice = 'n';
}

if ($zipChoice eq 'n'){
	print "Are you sure you want to delete all students, and student directories?\n";
	print "(y/n):";
	my $deleteChoice = <>;
	chomp $deleteChoice;
	while ($deleteChoice !~ /^y$|^n$/){
		print "Please choose 'y' or 'n': ";
		$deleteChoice = <>;
		chomp $deleteChoice;
	}
	if ($deleteChoice eq 'y'){
		print "Deleting students and student directories...\n";
		my $students = `members students`;
		my @usernames = split / /, $students;
		foreach(@usernames){
			my $student = $_;
			system("deluser $student");
			print "Deleting $student home directory...\n";
			system("rm -r /home/$student");
		}
	}
	if ($deleteChoice eq 'n'){
		print "Exiting...\n";
	}
}

