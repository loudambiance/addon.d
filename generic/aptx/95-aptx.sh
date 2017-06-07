#!/sbin/sh
#
# /system/addon.d/95-aptx.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
lib/libaptX-1.0.0-rel-Android21-ARMv7A.so
lib/libaptXHD-1.0.0-rel-Android21-ARMv7A.so
lib/libaptXScheduler.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
