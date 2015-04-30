#!/usr/bin/perl

# prevents warning, use of smartmatch operator ~~ in line 30/58
no warnings 'experimental::smartmatch';

print "Would you like to make a new section?\n";
print "(y/n): ";
my $secChoice = <>;
chomp $secChoice;

while ($secChoice !~ /^y$|^n$/){
	print "Please choose 'y' or 'n': ";
	$secChoice = <>;
	chomp $secChoice;
}

# creates group if it doesn't exist
if ($secChoice eq 'y'){
	print "Please enter a section name: ";
	$secName = <>;
	chomp $secName;
	system ("groupadd -f $secName");
}

if ($secChoice eq 'n'){
	print "Please enter a section name: ";
	$secName = <>;
	chomp $secName;
}	

print "How many users do you want to create?: ";
chomp($num=<>);

# checks for valid input
while ($num < 1 or $num >50){
	print "Please enter a valid number between 1-50: ";
	chomp($num=<>);
}

print "Creating $num users...\n";

# gets student names already created, split to array
my $students = `members $secName`;
my @usernames = split / /, $students;
foreach (@usernames){chomp($_);}

# creates users
for my $i (1..$num){
	my $username = "group$i";
	
	# next if username already exists in students group
	if ($username ~~ @usernames){
		print "$username already exists\n";
		next;
	}
	print "User '$username' being created...\n"; 

	# makes home dir if not existing, creates user
	# adds to students group, disable shell access
	system("useradd -g $secChoice -m -d /home/$username -s /sbin/nologin $username");

	#creates groups public_html directory / index.html
	my $directory = "/home/$username/public_html";
	unless (-e $directory or mkdir $directory){
		die "Error creating public_html dir for $username\n";}
	my $indexFile = "index.html";
	open(my $fh, '>', "$directory/index.html")
		or die "Error creating index.html for $username\n";
		print $fh "Hello $username!";
	close $fh;

	# give student ownership of public_html dir
	system("chown $username:students $directory");

	# chroot jails student to public_html only
	system("chown root:root /home/$username");

	print "$username created.\n";
}
