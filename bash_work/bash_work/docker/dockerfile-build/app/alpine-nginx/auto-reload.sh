#!/bin/sh
oldcksum=`cksum /usr/local/nginx/conf/enable_vhosts/*.conf`

inotifywait -e modify,move,create,delete -mr --timefmt '%d/%m/%y %H:%M' --format '%T' \
/usr/local/nginx/conf/enable_vhosts/ | while read date time; do

    newcksum=`cksum /usr/local/nginx/conf/enable_vhosts/*.conf`
    if [ "$newcksum" != "$oldcksum" ]; then
        echo "At ${time} on ${date}, config file update detected."
        oldcksum=$newcksum
        nginx -s reload
    fi

done