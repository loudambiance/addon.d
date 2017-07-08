#!/sbin/sh
# 
# /system/addon.d/97-google-assistant.sh
# This script enables Google Assistant on all phones.
#

. /tmp/backuptool.functions

case "$1" in
    post-restore)
        # Check if A/B ota. If so, system will be mounted at /postinstall
        if [[ `getprop ro.build.ab_update` == "true" ]]; then
            # If device is system on root, handle that as well
            if [[ `getprop ro.build.system_root_image` == "true" ]]; then
                buildprop=/postinstall/system/build.prop
            else
                buildprop=/postinstall/build.prop
            fi
        else
            buildprop=/system/build.prop
        fi

        # Enable Google Assistant in build.prop
        echo -e "\n# Google Assistant\nro.opa.eligible_device=true" >> $buildprop
    done
  ;;
esac
