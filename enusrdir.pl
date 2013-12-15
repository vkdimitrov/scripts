#!/usr/bin/perl
use strict;
use warnings;

open(my $file ,"<", "/etc/apache2/conf.d/userdir") or die "nemoga da otvorq faila $!";
my @filec = <$file>;


print $filec[1];
 if ($filec[1] =~ /\n/) 
	{
	$filec[1] =~ s/\n/ /;
	}
$filec[1]="${filec[1]}$ARGV[0]\n";
print $filec[1];
close $file;

open(STDOUT , ">", "/etc/apache2/conf.d/userdir") or die "nemoga da pi6a" ;
for (@filec)
{
s///;
print;
print "\n";
}
close STDOUT;

