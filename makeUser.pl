#!/usr/bin/perl

print "How many users do you want to create?: ";
chomp($num=<>);
print "Creating $num users...\n";
# creates students if it doesn't exist
system ("groupadd -f students");
my $students = `members students`; # gets student names
my @usernames = split / /, $students; # split to array
for my $i (1..$num){
	my $username = "group$i";
	print "User '$username' being created...\n"; 
	# makes home dir if not existing, creates user
	# adds to students group, disable shell access
	system("useradd -g students -m -d /home/$username -s /sbin/nologin $username");
	#creates groups public_html directory
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
	# creates starter pass to be changed 'it240username'
	system("echo $username:it240$username | chpasswd");
	# forces user to change on first login
	system("chage -d 0 $username");
	print "$username created.\n";
}

