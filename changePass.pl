#!/usr/bin/perl

# prevents warning, use of smartmatch operator ~~ in line ??/??
no warnings 'experimental::smartmatch';

print "For which user would you like to change a password? ";

# get student names
my $students = `members students`;
my @usernames = split / /, $students;
foreach (@usernames){
	chomp $_;
}

# get user to be changed
chomp($user=<>);

# makes sure valid user is entered
until ($user ~~ @usernames){
	print "Please enter an existing user: ";
	chomp($user=<>);
}

# password is random a-z,A-Z,0-9,!,$,_, excludes lower l
my @chars = ('a'..'k','m'..'z','A'..'Z','0'..'9','!','$','_');
my $pass;
	
# cats a random char from @chars
foreach(1..8){
	$pass .= $chars[rand @chars];
}
	
# sets pass
system("echo $user:$pass | chpasswd");
	

print "Changing $user password to: $pass\n";
print "Please record this change, it will not be reflected\n";
print "in the encrypted 'pass.txt.enc' file.\n";

	
	
