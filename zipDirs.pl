#!/usr/bin/perl

print "Do you want to get a .zip of all groups or a specific group?\n";
print "(all/spec): ";
my $zipScope = <>;
chomp $zipScope;
while ($zipScope !~ /^all$|^spec$/){
	print "Please choose 'all' or 'spec': ";
	$zipScope = <>;
	chomp $zipScope;
}

#system("zip -r $zipOut $dirIn");
