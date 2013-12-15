#!/bin/bash
	less /etc/apache2/sites-enabled/dev.$1 |grep ServerName |awk  '{print $2}'|cut -d. -f1 >/tmp/$1.endirs            
/root/bin/autovhosts.pl $1
