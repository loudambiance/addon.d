#!/sbin/sh
# 
# /system/addon.d/97-google-assistant.sh
# This script enables Google Assistant on all phones.
#

. /tmp/backuptool.functions

case "$1" in
    post-restore)
		# Enable Software Keys in build.prop
		echo -e "\n# Google Assistant\nro.opa.eligible_device=true" >> /system/build.prop
    done
  ;;
esac
