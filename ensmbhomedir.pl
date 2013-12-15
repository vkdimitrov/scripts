#!/usr/bin/perl
use strict;
use warnings;

open(my $file ,"<", "/etc/samba/smb.conf") or die "nemoga da otvorq faila $!";
my @filec = <$file>;
my $i=0;
until ($filec[$i]  =~ /homes/)
{
 $i+=1;
}
$i+=11;
print $filec[$i];
 if ($filec[$i] =~ /\n/) 
	{
	$filec[$i] =~ s/\n/ /;
	}
$filec[$i]="${filec[$i]},$ARGV[0]\n";
print $filec[$i];
close $file;

open(STDOUT , ">", "/etc/samba/smb.conf") or die "nemoga da pi6a" ;
for (@filec)
{
s///;
print;
print "\n";
}
close STDOUT;

