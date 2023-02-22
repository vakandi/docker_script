#!/bin/bash

# Check if the system is an LVM encrypted Linux machine
if [ ! -e /dev/mapper/vakandi--vg-home ] || [ ! -e /dev/mapper/vakandi--vg-var ]; then
	  echo "Error: LVM encrypted Linux machine not detected."
	    exit 1
fi

# Check if there is enough free space in the /home partition
if [ $(df /home --output=avail | tail -n1) -lt $(expr 6 \* 1024 \* 1024) ]; then
	  echo "Error: Not enough free space in the /home partition."
	    exit 1
fi

# Unmount the /var partition
umount /var

# Resize the /home partition
lvresize --size -6G /dev/mapper/vakandi--vg-home

# Resize the /var partition
lvresize --size +6G /dev/mapper/vakandi--vg-var

# Remount the /var partition
mount /var

# Verify the changes
df -h

