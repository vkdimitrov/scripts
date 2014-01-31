#!/bin/bash
mkdir /etc/opendkim/$1
chmod 700 /etc/opendkim/$1
chown opendkim:opendkim /etc/opendkim/$1
cd /etc/opendkim/$1
opendkim-genkey -t -s mail -d $1
mv mail.private mail
chown opendkim:opendkim mail mail.txt
chmod u=rw,go-rwx mail mail.txt
cat /etc/opendkim/$1/mail.txt
/etc/init.d/opendkim restart
