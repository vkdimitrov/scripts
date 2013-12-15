#!/usr/bin/perl
use strict;
use warnings;
open(my $file ,"<", "/tmp/$ARGV[0].endirs") or die "nemoga da otvorq faila $!";
my @filec = <$file>;

my $dir="/home/$ARGV[0]/public_html";
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
			open(my $vfile,">/etc/apache2/sites-enabled/dev.$ARGV[0]") or die $!;
			for(my $l=0;$l<=$#tmpArr;$l++)
			{
                        ${tmpArr[$l]} =~ s/\n//;
                        print $vfile "<VirtualHost *:80>\n";
                        if($ARGV[0] eq "git" or $ARGV[0] eq ${tmpArr[$l]})
                        {
                                print $vfile "        ServerName      ${tmpArr[$l]}.dev.vjsoft.net\n";
				print $vfile "        ServerAlias      ${tmpArr[$l]}.stage.vjsoft.net\n";
                        }
                        else
                        {
                        print $vfile "        ServerName      ${tmpArr[$l]}.$ARGV[0].dev.vjsoft.net\n";
                        }
                        print $vfile "        ServerAdmin     hosting\@vjsoft.net\n";
			if($ARGV[0] eq ${tmpArr[$l]})
			{
			print $vfile "        DocumentRoot    /home/$ARGV[0]/public_html/\n";
                        }
			else{
			print $vfile "        DocumentRoot    /home/$ARGV[0]/public_html/${tmpArr[$l]}\n";}
                        print $vfile "        ErrorLog        /var/log/apache2/${tmpArr[$l]}.$ARGV[0].error.log\n";
                        print $vfile "        <IfModule itk.c>\n";
                        print $vfile "                  AssignUserID $ARGV[0] $ARGV[0]\n";
                        print $vfile "        </IfModule>\n";
                        print $vfile "</VirtualHost>\n";
			}
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
			open(my $vfile,">>/etc/apache2/sites-enabled/dev.$ARGV[0]") or die $!;
			print $vfile "<VirtualHost *:80>\n";
			if($ARGV[0] eq "git")
			{
				print $vfile "        ServerName      ${tmpArr[$i]}.dev.vjsoft.net\n";	
                	}
			else
			{
			print $vfile "        ServerName      ${tmpArr[$i]}.$ARGV[0].dev.vjsoft.net\n";
		        }
			print $vfile "        ServerAdmin     hosting\@vjsoft.net\n";
                        print $vfile "        DocumentRoot    /home/$ARGV[0]/public_html/${tmpArr[$i]}\n";
			print $vfile "        ErrorLog	      /var/log/apache2/${tmpArr[$i]}.$ARGV[0].error.log\n";
			print $vfile "        <IfModule itk.c>\n";
			print $vfile "			AssignUserID $ARGV[0] $ARGV[0]\n"; 
			print $vfile "        </IfModule>\n";
                        print $vfile "</VirtualHost>\n";
		#	exec /etc/init.d/apache2 "reload";
			exec "/etc/init.d/apache2", "reload";	
		}
		else {print "else"; print $i; next;}
	}
}

exit 0;
