#!/bin/bash

adb start-server

device=`adb shell getprop ro.cm.device 2>&1 | sed 's/\\r//g'`
[[ $device == *"not found"* ]] && echo "No device detected!" && exit 1

scripts=($(find generic | grep sh))
[[ -d $device ]] && scripts+=($(find $device | grep sh))

case $device in
    *d2*)    script+=($(find d2 | grep sh));;
    *jf*)    script+=($(find jf | grep sh));;
    *p4vzw*) script+=($(find p4vzw | grep sh));;
    *);;
esac

count=0

for i in ${scripts[@]}; do
  echo $count ": " $i
  count=$((count+1))
done

echo
echo "Choose a script to install:"
read num
echo

if [[ $num > $((count-1)) ]] || [[ $num < 0 ]]; then
   echo "Invalid input!"
   exit 1
fi

echo "Restarting adb as root..."
adb wait-for-device root
echo "Waiting for device..."
sleep 3 # sleep for 3 seconds, some devices act weird if you try to issue a command right after adb root
echo "Remounting /system read/write"
adb wait-for-device remount

fullpath=${scripts[$num]}
scriptname=`ls $fullpath | xargs -n 1 basename`

echo "Pushing script..."
adb push $fullpath /system/addon.d/
echo "Setting permissions..."
adb shell chmod 755 /system/addon.d/$scriptname

echo "Grats! $scriptname is now installed and will run during rom installs!"
