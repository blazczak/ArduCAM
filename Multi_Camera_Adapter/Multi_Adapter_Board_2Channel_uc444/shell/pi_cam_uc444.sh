#!/bin/sh
i2cset -y 1 0x70 0x00 0x01
gpio -g mode 17 out
gpio -g mode 4  out
gpio -g write 17 0 #set the gpio17 low
gpio -g write 4 0 #set the gpio4   low
OS=`grep ^NAME= /etc/os-release | cut -d= -f2 | sed 's/"//g'`
echo "Choose camera A"
if [ $OS = "Raspbian" ]; then
  raspistill -o camera1.jpg
else
  /usr/bin/fswebcam -r 2592x1944 --jpeg 90 camera1.jpg
fi
i2cset -y 1 0x70 0x00 0x02
gpio -g write 4 1 #set the gpio4 high
echo "Choose Camera B"
if [ $OS = "Raspbian" ]; then
  raspistill -o camera2.jpg
else
  /usr/bin/fswebcam -r 2592x1944 --jpeg 90 camera2.jpg
fi
echo "Test OK"
