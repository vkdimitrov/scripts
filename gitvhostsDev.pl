#!/usr/bin/perl
use strict;
use warnings;
open(my $file ,"<", "/tmp/devgit.endirs") or die "nemoga da otvorq faila $!";
my @filec = <$file>;

my $dir="/home/git/public_html/dev";
my @tmpArr;
opendir(DIR,$dir) or die $!;
while (my $file=readdir(DIR)){
next if (($file =~ m/^\./)||($file =~ m/^.+\..+/));

push (@tmpArr,"$file\n");
}
@filec=sort @filec;
@tmpArr=sort @tmpArr;
print "--------------\napache config\n--------------\n";
print @filec;
print "--------------\nhome folder\n--------------\n";
print @tmpArr;
closedir(DIR);

	for(my $i=0;$i<=$#filec;$i++)
	{	
	 my $status=0;
		for(my $j=0;$j<=$#tmpArr;$j++)
		{
#			print "###########  ${filec[$i]}# == ${tmpArr[$j]}#\n";
			if(${filec[$i]} eq ${tmpArr[$j]})
			{
				$j=$#tmpArr;
		        	$status=1;		
			}
		}
	        if($status==0)
		{
			print "triem ${filec[$i]} \n";
			open(my $vfile,">/etc/apache2/sites-enabled/dev.git") or die $!;
			for(my $l=0;$l<=$#tmpArr;$l++)
			{
                        ${tmpArr[$l]} =~ s/\n//;
                        print $vfile "<VirtualHost *:80>\n";
                                print $vfile "        ServerName      ${tmpArr[$l]}.dev.vjsoft.net\n";
                        
			print $vfile "        ServerAdmin     hosting\@vjsoft.net\n";
			print $vfile "        DocumentRoot    /home/git/public_html/dev/${tmpArr[$l]}\n";}
 #                       print $vfile "        ErrorLog        /var/log/apache2/${tmpArr[$l]}.git.error.log\n";
                        print $vfile "        <IfModule itk.c>\n";
                        print $vfile "                  AssignUserID git git\n";
                        print $vfile "        </IfModule>\n";
                        print $vfile "</VirtualHost>\n";
			close($vfile);        
   		exec "/etc/init.d/apache2", "reload";	
		}
		 
	}

if($#tmpArr>$#filec)
{	
my 	$diff=$#tmpArr-$#filec;
	for(my $j=0;$j<$diff;$j++)
	{
	 push(@filec,'');
	}
	for(my $i=0;$i<=$#tmpArr;$i++)
	{
  	        if (${tmpArr[$i]} ne ${filec[$i]}) 
		{       
  			${tmpArr[$i]} =~ s/\n//;
			open(my $vfile,">>/etc/apache2/sites-enabled/dev.git") or die $!;
			print $vfile "<VirtualHost *:80>\n";
				print $vfile "        ServerName      ${tmpArr[$i]}.dev.vjsoft.net\n";	
			
			print $vfile "        ServerAdmin     hosting\@vjsoft.net\n";
                        print $vfile "        DocumentRoot    /home/git/public_html/dev/${tmpArr[$i]}\n";
			print $vfile "        ErrorLog	      /var/log/apache2/${tmpArr[$i]}.git.error.log\n";
			print $vfile "        <IfModule itk.c>\n";
			print $vfile "			AssignUserID git git\n"; 
			print $vfile "        </IfModule>\n";
                        print $vfile "</VirtualHost>\n";
		#	exec /etc/init.d/apache2 "reload";
			exec "/etc/init.d/apache2", "reload";	
		}
		else {print "else"; print $i; next;}
	}
}

exit 0;
