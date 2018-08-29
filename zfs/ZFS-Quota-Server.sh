#!/bin/bash
# ZFS Quota Server

SAVEIFS=$IFS
#We need this to make it space correctly.
IFS="
"

if [[ -z "$1" ]]; then
        echo "Please include a quota pool i.e. pool-data";
        IFS=$SAVEIFS
        exit 1;
fi

if [[ -z "$2" ]]; then
        zcmd=$(/sbin/zfs userspace $1  | sed -n '1!p');
else
        zcmd=$(/sbin/zfs userspace $1  | grep $2);
fi

for zquota in `echo "$zcmd"`; do
        zuser=$(echo $zquota| awk '{print $3}');
        zused=$(echo $zquota| awk '{print $4}');
        zquot=$(echo $zquota| awk '{print $5}');
        #perc needs that both valuse are of the same type, at present some are m or k, or g
	#if [[ zquot -ne "none" ]]; then
        #       zperc=$(echo $zquota| awk '{printf "%.0f\n",  ($4/$5) * 100}');
        #else
        #       zpec=0;
        #fi
        echo -e "$zuser::$zused::$zquot::"; #$zperc%";
done;
IFS=$SAVEIFS
exit 0;
