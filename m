From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC cross reference drivers to sysfs filenames
Message-Id: <ebor419gohrbmmhmqgvvjad9mm42t5h6fi@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

As part of my trying to gain understanding of lmsensors area, and 
also due to my surprise at how macros create some of these filenames, 
I wrote a small bash script to extract cross-referenced lists from 
drivers in current directory.

One list sorted by driver_name, the other sorted by sysfs_filename, 
easy to query with grep or eyeball.

More on http://scatter.mine.nu/lmsensors/sysfs-names/

Cheers,
Grant.


#!/bin/bash
#
# crossref-driver-sysfs_name
#
# create cross references of sysfs names vs drivers in current directory
#
# Copyright (C) 2005 Grant Coady <gcoady@gmail.com> http://scatter.mine.nu/
#
# GPL per linux/COPYING by reference

TARGET_DIR="/home/public"

# intermediate files
CROSS_DRIVER_LIST="$TARGET_DIR/cross_driver_list"
CROSS_GCC_ERROR_LOG="$TARGET_DIR/cross_gcc_error_log"
CROSS_DRIVER_TEMP="$TARGET_DIR/cross_driver_temp"
CROSS_SYSFS_TEMP="$TARGET_DIR/cross_sysfs_temp"
CROSS_NAME_WORK="$TARGET_DIR/cross_name_work"
CROSS_TEMP_FILES="$TARGET_DIR/cross_*"

# output lists
CROSS_DRIVER_SYSFS="$TARGET_DIR/crossref_driver_sysfs.list"
CROSS_SYSFS_DRIVER="$TARGET_DIR/crossref_sysfs_driver.list"

rm -f $CROSS_TEMP_FILES

# Create driver list: filtering unwanted intermediate files in case 
# source tree already compiled.

echo -e "\ncrossref-driver-sysfs_name..."
ls *.c | grep -v "\.mod\.c" | sort > $CROSS_DRIVER_LIST

# Create cross reference list:
# Run driver through preprocessor to expand macros that build some sysfs 
# filenames, through sed to pickup sysfs filename and r/w attributes 
# (unused yet) and save to temp file.  Run temp file through blank line 
# filter and append to driver -> sysfs_name, sysfs_name -> driver.

while read driver_name rest; do
	echo "$driver_name"		# progress indicator
	gcc -E "$driver_name" 2> $CROSS_GCC_ERROR_LOG | \
	sed -n -e 's/[^D]*DEVICE_ATTR(\([^,]*\)\,\([^,]*\)[^D]*/\1\t\2\n/pg' \
	> $CROSS_NAME_WORK
	
	while read sysfs_name rest; do
		if test -n "$sysfs_name"; then
			echo -e "$driver_name\t$sysfs_name" >> $CROSS_DRIVER_TEMP
			echo -e "$sysfs_name\t$driver_name" >> $CROSS_SYSFS_TEMP
		fi
	done < $CROSS_NAME_WORK

done < $CROSS_DRIVER_LIST

# Presentation: sort sysfs_name -> driver list and line up columns.

cat $CROSS_SYSFS_TEMP | sort | expand -32 > $CROSS_SYSFS_DRIVER
cat $CROSS_DRIVER_TEMP | expand -16 > $CROSS_DRIVER_SYSFS

echo -e "\nDone!"

# end
