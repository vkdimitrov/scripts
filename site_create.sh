#!/bin/bash
DEFAULT_ADMIN="darky@vladko.org"
DEFAULT_ADDRESS="*"
DEFAULT_LOGDIR="/var/log/apache2"
HOSTNAME="$1"
DOCROOT="$2"
ADMIN="$3"
IPADDRESS="$4"

if [ "$HOSTNAME" == "" ] || [ "$DOCROOT" == "" ]; then
        echo "Usage: $0 <ServerName> <DocumentRoot> [server admin] [IP ADDRESS]"
        exit
fi

if [ "$ADMIN" == "" ]; then
        ADMIN="$DEFAULT_ADMIN"
fi

if [ "$IPADDRESS" == "" ]; then
        IPADDRESS="$DEFAULT_ADDRESS"
fi

VHOSTFILE="/etc/apache2/sites-enabled/$HOSTNAME"

cat << EOF > "$VHOSTFILE"
<VirtualHost $IPADDRESS:80>
        ServerName      $HOSTNAME
        ServerAlias     www.$HOSTNAME
        ServerAdmin     $ADMIN
        DocumentRoot    $DOCROOT
        ErrorLog        "$DEFAULT_LOGDIR/$HOSTNAME-error.log"
	TransferLog 	"$DEFAULT_LOGDIR/$HOSTNAME-access.log"
</VirtualHost>
EOF
chown root:root "$VHOSTFILE"
chmod 0640 "$VHOSTFILE"
apachectl graceful
chmod 0751 $DOCROOT
