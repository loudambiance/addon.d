#!/sbin/sh
# 
# /system/addon.d/97-gcam.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleCamera/GoogleCamera.apk
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
esac
