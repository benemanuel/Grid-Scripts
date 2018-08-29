#!/bin/bash
#zfs set default quota

volume="/home/local/ACAD"

allusers=`ls -al $volume | grep ^d |awk '{print $3}'|sort|uniq`
for username in $allusers; do
        u=`zfs get -p -H userused@$username pool-data| awk '{print $3}'`;
        if [[ "-" == "$u" ]];
         then echo "$username no used no need for quota";
         else
                #echo "$username used so check if has quota";
                q=`zfs get -H -p -o value userquota@$username pool-data`;
                if [[ "0" == "$q" ]];
                 then `zfs set userquota@$username=5g pool-data`;
                 #else echo "$username user has quota $q ";
                fi
        fi
done
