#!/sbin/sh
#
# /system/addon.d/95-xposed.sh
#

. /tmp/backuptool.functions

dex2oat_execs() {
cat <<EOF
bin/dex2oat
bin/patchoat
EOF
}

system_files_644() {
cat <<EOF
framework/XposedBridge.jar
lib/libart-compiler.so
lib/libart.so
lib/libsigchain.so
lib/libxposed_art.so
lib64/libart-disassembler.so
lib64/libart.so
lib64/libsigchain.so
lib64/libxposed_art.so
xposed.prop
EOF
}

system_files_755() {
cat <<EOF
bin/oatdump
EOF
}

zygote_execs() {
cat <<EOF
bin/app_process
bin/app_process32
bin/app_process32_original
bin/app_process32_xposed
bin/app_process64
bin/app_process64_original
bin/app_process64_xposed
EOF
}

case "$1" in
  backup)
    dex2oat_execs | while read FILE DUMMY; do backup_file $S/$FILE; done
    system_files_644 | while read FILE DUMMY; do backup_file $S/$FILE; done
    system_files_755 | while read FILE DUMMY; do backup_file $S/$FILE; done
    zygote_execs | while read FILE DUMMY; do backup_file $S/$FILE; done
  ;;
  restore)
    dex2oat_execs | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
    system_files_644 | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
    system_files_755 | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
    zygote_execs | while read FILE REPLACEMENT; do
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
    dex2oat_execs | while read FILE DUMMY; do
      chmod 0755 $S/$FILE
      chown root:shell $S/$FILE
      chcon u:object_r:dex2oat_exec:s0 $S/$FILE
    done

    system_files_644 | while read FILE DUMMY; do
      chmod 0644 $S/$FILE
      chown root:root $S/$FILE
      chcon u:object_r:system_file:s0 $S/$FILE
    done

    system_files_755 | while read FILE DUMMY; do
      chmod 0755 $S/$FILE
      chown root:shell $S/$FILE
      chcon u:object_r:system_file:s0 $S/$FILE
    done

    zygote_execs | while read FILE DUMMY; do
      chmod 0755 $S/$FILE
      chown root:shell $S/$FILE
      chcon u:object_r:zygote_exec:s0 $S/$FILE
    done
  ;;
esac
