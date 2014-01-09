#!/bin/bash
#public_html folder in production
site='';

#gitosis-admin repo to be skiped
if [ "$1" = "gitosis-admin" ];
then
        continue
else
        #triem stariqt deploy source
        rm -rf /home/git/production/deploy/$1
        mkdir -p /home/git/production/deploy/$1

        cd /home/git/production/repos/
        git clone git@dev.vjsoft.net:$1.git
        cd /home/git/production/repos/$1
        #kopirame samo sorsovete ot master versiqta
        git checkout-index -a -f --prefix=/home/git/production/deploy/$1/
        cd /home/git/production/
        rm -rf /home/git/production/repos/$1
        #setvame env promenlivata @site
        case "$1" in
        factoaar)
                        site="xxxx@xx.xx.xx.xx:/var/www/"
                        ports='ssh -p11122'
                    ;;
               *) echo "nqma takova repo" exit
                    ;;
        esac
        /usr/bin/rsync --rsh="$ports" -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
fi
