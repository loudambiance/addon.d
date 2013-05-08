#!/sbin/sh
#
# /system/addon.d/95-ltedisable.sh	
# Removes software for cellular modem

. /tmp/backuptool.functions

case "$1" in
  post-restore)
	# Delete RIL files from /system/bin/
    find /system/bin/ | grep -i ril | xargs /system/bin/rm -rf
	
	# Delete RIL files from /system/lib/
	find /system/lib/ | grep -i ril | xargs /system/bin/rm -rf
  ;;
esac
