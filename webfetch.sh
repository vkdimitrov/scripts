#!/bin/bash
#public_html folder in production
site='';

#gitosis-admin repo to be skiped
if [ "$1" = "gitosis-admin" ];
then
        continue
else
	#triem stariqt deploy source
        rm -rf ../production/deploy/$1
        mkdir -p ../production/deploy/$1
	
        cd /home/git/public_html/dev/$1
	#get branch
	original_branch=`git branch |grep \* |cut -d\* -f2`
	#checkout master 
	git checkout master
	git pull origin master 
        #kopirame samo sorsovete ot master versiqta
	git checkout-index -a -f --prefix=/home/git/production/deploy/$1/
	#checkout original branch
	git checkout $original_branch

	#setvame env promenlivata @site 
        case "$1" in
               	factor)   site="root@77.77.150.43:/var/www/factorin-bg.com-deploy"
			  rsync --rsh='ssh -p11122' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
                    ;;
		br3)	site="bridgebg@new.bridge.bg:/home/bridgebg/public_html"
			rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		ues) 	site="ssh uniqp1jx@new.uniqueestates.net:/home/uniqp1jx/public_html" 
			rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		sms-reminder)
			 site="bridgebg@new.bridge.bg:/home/bridgebg/smsreminder.bg"
                        rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		ifg )
			site="ifgleasingssh@ifgleasing.eu:/"
			rsync --rsh='ssh -p10022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
                voltron )   site="voltron.lan"
                    ;;
                *) echo "nqma takova repo" exit
                   ;;
        esac
fi

