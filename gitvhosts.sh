#!/bin/bash
	less /etc/apache2/sites-enabled/dev.git |grep ServerName |awk  '{print $2}'|cut -d. -f1 >/tmp/devgit.endirs            
	less /etc/apache2/sites-enabled/stage.git |grep ServerName |awk  '{print $2}'|cut -d. -f1 >/tmp/stagegit.endirs
/root/bin/gitvhostsDev.pl
/root/bin/gitvhostsStage.pl
