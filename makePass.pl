#!/usr/bin/perl

# get student names
my $students = `members students`;
my @usernames = split / /, $students;
my %userHash;

# create and set passwords
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

# open file for temporary password storage
my $file = "temp.txt";
open (my $fhIn, '>' .$file) or die "File creation error.";

# sorts lists for reability
my @sorted_keys = sort {
    my @aa = $a =~ /^([A-Za-z]+)(\d*)/;
    my @bb = $b =~ /^([A-Za-z]+)(\d*)/;
    lc $aa[0] cmp lc $bb[0] or $aa[1] <=> $bb[1];
} keys %userHash;

# prints to list
foreach (@sorted_keys){
	my $username = "$_";
	print $fhIn "$username\t$userHash{$username}\n";
}

close $fhIn;

# encrypts pass file
print "Below you will be asked for a password. It is IMPORTANT that\n";
print "you REMEMBER THIS PASSWORD. It is needed to decrypt the password file.\n\n";
sleep(3);
system ("openssl aes-256-cbc -a -salt -in temp.txt -out pass.txt.enc");

# deletes plain text file
unlink $file;
