#!/sbin/busybox sh

MOUNT="/sbin/busybox mount"
UMOUNT="/sbin/busybox umount"
MKDIR="/sbin/busybox mkdir"
RMDIR="/sbin/busybox rmdir"
TOUCH="/sbin/busybox touch"

$MKDIR /tmp/sdcard
$CHMOD 0770 /dev/block/mmcblk0p1
$MOUNT /dev/block/mmcblk0p1 /tmp/sdcard
if [ -f /tmp/sdcard/.bootsdcard ]; 
	then
		$TOUCH /tmp/.bootsdcard
	fi
$UMOUNT /tmp/sdcard
$RMDIR /tmp/sdcard

if [ -f /tmp/.bootsdcard ]; 
	then
		$UMOUNT /data;
		$CHMOD 0770 /dev/block/mmcblk0p4
		$MOUNT -t ext4 -o nosuid,nodev /dev/block/mmcblk0p4 /data
		$UMOUNT /system
		$CHMOD 0770 /dev/block/mmcblk0p3
		$MOUNT -t ext4 /dev/block/mmcblk0p3 /system
		$MOUNT -t ext4 -o remount,ro /dev/block/mmcblk0p3 /system
fi
