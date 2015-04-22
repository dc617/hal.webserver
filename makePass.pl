#!/usr/bin/perl

my $students = `members students`;
my @usernames = split / /, $students;
my %userHash;
foreach(@usernames){
	my $student = $_;
	chomp $student;
	my @chars = ('a'..'z','A'..'Z','0'..'9','!','$','_');
	my $pass;
	foreach(1..8){
		$pass .= $chars[rand @chars];
	}
	$userHash{$student} = $pass;
}

my $file = "temp.txt";
open (my $fhIn, '>' .$file) or die "File creation error.";

print $fhIn "$_ $userHash{$_}\n" for (keys %userHash);

close $fhIn;

system ("openssl aes-256-cbc -a -salt -in temp.txt -out pass.txt.enc");

unlink $file;
