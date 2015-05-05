#!/usr/bin/perl

# prevents warning, use of smartmatch operator ~~
no warnings 'experimental::smartmatch';

MAKECHOICE:

$choice = makeChoice();

if ($choice == 1){
	system("perl makeUser.pl");
	goto MAKECHOICE;
}
elsif ($choice == 2){
	system("perl makePass.pl");
	goto MAKECHOICE;
}
elsif ($choice == 3){
	system("perl getPass.pl");
	goto MAKECHOICE;
}
elsif ($choice == 4){
	system("perl zipDirs.pl");
	goto MAKECHOICE;
}
elsif ($choice == 5){
	system("perl delStudents.pl");
	goto MAKECHOICE;
}
elsif ($choice == 6){
	system("perl changePass.pl");
	goto MAKECHOICE;
}
elsif ($choice == 7){
	exit();
}


sub makeChoice {
	print "\nPlease enter the number for the tool you would like to use:\n";

	print "1 - Create group accounts for a section\n";
	print "2 - Set passwords for a section\n";
	print "3 - Get password list for a section\n";
	print "4 - Create .zip archive for a section or a student\n";
	print "5 - Delete a section of students\n";
	print "6 - Change a student's password\n";
	print "7 - Exit\n";

	print "\nYour choice: ";

	chomp(my $choice=<>);

	until ($choice ~~ /[1-7]/){
		print "Please enter a valid choice, between 1-7: ";
		chomp($choice=<>);
	}

	return $choice;

}
