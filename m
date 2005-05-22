From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 May 2005 09:39:46 +0000
Subject: [lm-sensors] [PATCH 2.6] Sensors mailing list has moved
Message-Id: <20050522093911.04682857.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch updates all references to the sensors mailing list,
so as to reflect the fact that the list recently moved to a new home and
changed addresses. I'll work out a similar patch for Linux 2.4 soon.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/busses/i2c-sis69x |    2 +-
 Documentation/i2c/porting-clients   |    2 +-
 MAINTAINERS                         |   16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc4.orig/MAINTAINERS	2005-05-19 19:13:27.000000000 +0200
+++ linux-2.6.12-rc4/MAINTAINERS	2005-05-22 09:33:45.000000000 +0200
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
--- linux-2.6.12-rc4.orig/Documentation/i2c/busses/i2c-sis69x	2005-05-19 19:13:27.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/i2c/busses/i2c-sis69x	2005-05-19 19:13:51.000000000 +0200
@@ -42,7 +42,7 @@
 chipsets as well: 635, and 635T. If anyone owns a board with those chips
 AND is willing to risk crashing & burning an otherwise well-behaved kernel
 in the name of progress... please contact me at <mhoffman@lightlink.com> or
-via the project's mailing list: <sensors@stimpy.netroedge.com>.  Please
+via the project's mailing list: <lm-sensors@lm-sensors.org>.  Please
 send bug reports and/or success stories as well.
 
 
--- linux-2.6.12-rc4.orig/Documentation/i2c/porting-clients	2005-05-19 19:13:27.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/i2c/porting-clients	2005-05-19 19:13:51.000000000 +0200
@@ -57,7 +57,7 @@
   Documentation/i2c/sysfs-interface for the individual files. Also
   convert the units these files read and write to the specified ones.
   If you need to add a new type of file, please discuss it on the
-  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
+  sensors mailing list <lm-sensors@lm-sensors.org> by providing a
   patch to the Documentation/i2c/sysfs-interface file.
 
 * [Attach] For I2C drivers, the attach function should make sure

-- 
Jean Delvare
