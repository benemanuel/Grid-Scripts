## Sample Usage:

This is aimed at network envrionments where end users require some form of quota output.

Put the server script into cron will add a default quota of 5g to all new users:
```bash
echo 'PATH="/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"' >  /etc/cron.d/zfs-default
echo '*/5 * * * * root /root/zfs-quota-default.sh" >> /etc/cron.d/zfs-default


echo "*/2 * * * * root /root/zfs-quota-server.sh  pool-data > /home/local/ACAD/quota.zfs 2>&1" >> /etc/cron.d/zfs-quota

```

the quota.zfs output should look similar to this:
```
aboutcher::1307875224::161061273600::1%
root::56580187648::64424509440::88%
```

Add the list of ZFS Servers to the array in the client script and the correct mountpoint, you could then alias quota with this script is required.

The sample output should look like this
```

 Quota Report for aboutcher
 Mount				Used		Total		Last Checked
 /mnt/home			1.3G (1%)	150G		Wed 28 Jun 2017 16:21:44 BST

```
