#!/usr/bin/perl

# prevents warning, use of smartmatch operator ~~ in line 30/58
no warnings 'experimental::smartmatch';

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
until ($secName ~~ @sections){
	print "Please enter an existing section: ";
	$secName = <>;
	chomp $secName;
}

$fileIn = $secName.'pass.txt.enc';
$fileOut = $secName.'pass.txt';

# see if enc pass file exists
if (-e $fileIn){
	
	# decrypts pass.txt.enc and creates passwords.txt
	system ("openssl aes-256-cbc -d -a -in $fileIn -out $fileOut");
}
else {die "fileIn error";}
