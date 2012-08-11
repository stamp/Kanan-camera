#!/bin/bash
logger "Mount camera"
mount /dev/sda1 /media/kamera
logger "Fetch filename"
filename=`curl --user-agent "fogent" --silent "http://kanan.vassaro.net/counter"`
logger "Move file $filename"
echo "Move file $filename"
mv /media/kamera/DCIM/*/*.JPG /home/stamp/incomming/$filename
rm /media/kamera/DCIM/*/*.JPG
#mv /media/kamera/DCIM/*/*.JPG /home/stamp/incomming
umount /dev/sda1

logger "Transfer done"

stampzilla beckhoff "set&tag=ibCameraReady"

logger "Start upload"
scp -p /home/stamp/incomming/* stamp@192.168.3.17:/home/stamp/incomming

rm /home/stamp/incomming/*
logger "Upload + clean done"
