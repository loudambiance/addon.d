#!/sbin/sh
#
# /system/addon.d/95-key.sh	
# Disables hardware home,back,menu keys and enables softkeys
# Changes hardware home key into camera key	
#
. /tmp/backuptool.functions

case "$1" in
  post-restore)
	# Enable Software Keys in build.prop
    echo -e "\nqemu.hw.mainkeys=0" >> /system/build.prop
	
	# Turn physical home key into Camera key
	sed -i 's/HOME/CAMERA/' /system/usr/keylayout/gpio-keys.kl
	
	# Turn Physical menu key off
	sed -i 's/key 139/#key 139/' /system/usr/keylayout/sec_touchkey.kl
	
	# Turn Physical back key off
	sed -i 's/key 158/#key 158/' /system/usr/keylayout/sec_touchkey.kl
  ;;
esac
