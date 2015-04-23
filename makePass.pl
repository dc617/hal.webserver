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

foreach my $key (sort {$a cmp $b} keys %userHash){
	print $fhIn "$key $userHash{$key}\n";
}

close $fhIn;

print "Below you will be asked for a password. It is IMPORTANT that\n";
print "you REMEMBER THIS PASSWORD. It is needed to decrypt the password file.\n\n";
sleep(3);
system ("openssl aes-256-cbc -a -salt -in temp.txt -out pass.txt.enc");

unlink $file;
