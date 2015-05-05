#!/usr/bin/perl

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
while ($secName !~ @sections){
	print "Please enter an existing section: ";
	$secName = <>;
	chomp $secName;
}

# get student names
my $students = `members $secName`;
my @usernames = split / /, $students;
my %userHash;

# create and set passwords
foreach(@usernames){

	# gets student from array
	my $student = $_;
	chomp $student;

	# password is random a-z,A-Z,0-9,!,$,_, excludes lower l
	my @chars = ('a'..'k','m'..'z','A'..'Z','0'..'9','!','$','_');
	my $pass;
	
	# cats a random char from @chars
	foreach(1..8){
		$pass .= $chars[rand @chars];
	}
	
	# sets pass as value for username key in hash
	$userHash{$student} = $pass;

	# sets pass
	system("echo $student:$pass | chpasswd");
	
}

# open file for temporary password storage
my $file = "temp.txt";
open (my $fhIn, '>' .$file) or die "File creation error.";

# prints to list
foreach my $username (sort { my ($anum,$bnum); $a=~/.+group(\d)/; $anum=$1; $b=~/.+group(\d)/; $bnum=$1; $anum<=>$bnum} keys %userHash){
	print $fhIn "$username\t$userHash{$username}\n";
}

close $fhIn;

$fileOut = $secName."pass.txt.enc";

# encrypts pass file
print "Below you will be asked for a password. It is IMPORTANT that\n";
print "you REMEMBER THIS PASSWORD. It is needed to decrypt the password file.\n\n";
sleep(3);
system ("openssl aes-256-cbc -a -salt -in temp.txt -out $fileOut");

# deletes plain text file
unlink $file;
