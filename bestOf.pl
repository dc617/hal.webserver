#!/usr/bin/perl

# THIS MAY NEED TO HAVE A USERDIR DIRECTIVE FOR TRANSLATED PATHS
# SO THAT IT EASILY GOES TO site.com/~prof/bestOf rather than
# site.com/~prof/public_html/bestOf

# Get current user
my $userID = `whoami`;
chomp $userID;

# Get directory name
print "A 'Best Of' directory will be created in your home,\n";
print "you can name the directory, it will be created\n";
print "at /home/$userID/NAME...\n";
print "What do you want this directory to be named? ";
my $dirName = <>;
chomp $dirName;

# Check that it is valid, no spaces, no symbols
while($dirName =~ m/[^a-zA-Z0-9]/){
	print "Please enter a directory name with ONLY\n";
	print "letters and numbers, and NO spaces: ";
	$dirname = <>;
	chomp $dirName;
}

system ("mkdir ~/$dirName");

print "Directory at /home/$userID/$dirName has been created.\n";
