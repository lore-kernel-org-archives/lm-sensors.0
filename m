From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 20 Jan 2006 01:12:54 +0000
Subject: [lm-sensors] [patch 2/X] pc87360 - consolidate show_X_Y callbacks
Message-Id: <43D03916.7080805@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch uses the NR member in SENSOR_ATTR_2 to collapse
the multiple show_X_Y callbacks into show_X callbacks.
This saves 540 bytes of .text, and 5kb of disk.

Given that this patch replaces ~20 functions with 4 new ones, its 
unlikely that
further consolidation of the 4 into 1 is worth it, esp as it means lots 
of code movement.

$ size a2-pc-*/drivers/hwmon/pc87360.ko
   text    data     bss     dec     hex filename
  12114    3144      16   15274    3baa a2-pc-0/drivers/hwmon/pc87360.ko
  12046    3144      16   15206    3b66 a2-pc-1/drivers/hwmon/pc87360.ko
  11506    3144      16   14666    394a a2-pc-2/drivers/hwmon/pc87360.ko
$ ll a2-pc-*/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 135521 Jan 19 16:06 a2-pc-1/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 130166 Jan 19 17:08 a2-pc-2/drivers/hwmon/pc87360.ko

$ diffstat diff.a2-pc-2.20060119.174325
 pc87360.c |  398 
+++++++++++++++++++++++++++++---------------------------------
 1 files changed, 187 insertions(+), 211 deletions(-)

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-squeeze-show-callbacks.patch
Type: text/x-patch
Size: 25176 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060120/89b2cfb2/hwmon-pc87360-squeeze-show-callbacks.bin
