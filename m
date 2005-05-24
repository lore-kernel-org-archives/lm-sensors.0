From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 24 May 2005 01:19:42 +0000
Subject: [lm-sensors] patch i2c-mailing-list-move.patch added to gregkh-2.6
Message-Id: <1DaMCC-41k-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: Sensors mailing list has moved

to my gregkh-2.6 tree.  Its filename is

     i2c-mailing-list-move.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-address_merge_video.patch
i2c/i2c-address_range_removal.patch
i2c/i2c-rtc8564_duplicate_include.patch
i2c/i2c-ds1337-02.patch
i2c/i2c-ds1337-03.patch
i2c/i2c-smsc47m1.patch
i2c/i2c-w83627ehf.patch
i2c/i2c-config_cleanup-01.patch
i2c/i2c-config_cleanup-02.patch
i2c/i2c-w83627ehf-cleanup.patch
i2c/i2c-ds1337_make_time_format_consistent.patch
i2c/i2c-ds1337_i2c_transfer_check.patch
i2c/i2c-ds1337_search_by_bus_number.patch
i2c/i2c-remove_redundancy_from_i2c_core.patch
i2c/i2c-ds1337-config-update.patch
i2c/i2c-ds1337-export-ds1337_do_command.patch
i2c/i2c-rename-cpu0_vid.patch
i2c/i2c-macro-abuse-cleanup.patch
i2c/i2c-Kconfig-corrections.patch
i2c/i2c-macro-abuse-cleanup-via686a.patch
i2c/i2c-via686a-code-cleanup.patch
i2c-mailing-list-move.patch
i2c-spelling-fixes-more-01.patch
i2c-spelling-fixes-more-02.patch
i2c-spelling-fixes-more-03.patch
i2c-spelling-fixes-more-04.patch


From khali@linux-fr.org Sun May 22 00:50:06 2005
Date: Sun, 22 May 2005 09:39:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: I2C: Sensors mailing list has moved
Message-Id: <20050522093911.04682857.khali@linux-fr.org>

The following patch updates all references to the sensors mailing list,
so as to reflect the fact that the list recently moved to a new home and
changed addresses. I'll work out a similar patch for Linux 2.4 soon.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/i2c/busses/i2c-sis69x |    2 +-
 Documentation/i2c/porting-clients   |    2 +-
 MAINTAINERS                         |   16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

--- gregkh-2.6.orig/MAINTAINERS	2005-05-23 16:06:40.000000000 -0700
+++ gregkh-2.6/MAINTAINERS	2005-05-23 16:18:27.000000000 -0700
@@ -194,7 +194,7 @@
 ADM1025 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 ADT746X FAN DRIVER
@@ -242,7 +242,7 @@
 ALI1563 I2C DRIVER
 P:	Rudolf Marek
 M:	r.marek@sh.cvut.cz
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 ALPHA PORT
@@ -992,7 +992,7 @@
 M:	greg@kroah.com
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.nu/
 S:	Maintained
 
@@ -1420,13 +1420,13 @@
 LM83 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 LM90 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP Dynamic Disks)
@@ -2065,7 +2065,7 @@
 SMSC47M1 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Odd Fixes
 
 SMB FILESYSTEM
@@ -2604,7 +2604,7 @@
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov
 M:	johnpol@2ka.mipt.ru
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 W83L51xD SD/MMC CARD INTERFACE DRIVER
@@ -2617,7 +2617,7 @@
 W83L785TS HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 S:	Odd Fixes
 
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)
--- gregkh-2.6.orig/Documentation/i2c/busses/i2c-sis69x	2005-05-09 09:06:53.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/busses/i2c-sis69x	2005-05-23 16:18:27.000000000 -0700
@@ -42,7 +42,7 @@
 chipsets as well: 635, and 635T. If anyone owns a board with those chips
 AND is willing to risk crashing & burning an otherwise well-behaved kernel
 in the name of progress... please contact me at <mhoffman@lightlink.com> or
-via the project's mailing list: <sensors@stimpy.netroedge.com>.  Please
+via the project's mailing list: <lm-sensors@lm-sensors.org>.  Please
 send bug reports and/or success stories as well.
 
 
--- gregkh-2.6.orig/Documentation/i2c/porting-clients	2005-05-09 09:06:53.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/porting-clients	2005-05-23 16:18:27.000000000 -0700
@@ -57,7 +57,7 @@
   Documentation/i2c/sysfs-interface for the individual files. Also
   convert the units these files read and write to the specified ones.
   If you need to add a new type of file, please discuss it on the
-  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
+  sensors mailing list <lm-sensors@lm-sensors.org> by providing a
   patch to the Documentation/i2c/sysfs-interface file.
 
 * [Attach] For I2C drivers, the attach function should make sure
