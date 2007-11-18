From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 22:46:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update the lm-sensors website address
Message-Id: <20071118234610.5f3d9dab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's about time to reflect the move of the lm-sensors project to
lm-sensors.org.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/userspace-tools |    2 +-
 Documentation/hwmon/w83627hf        |    3 +--
 Documentation/i2c/busses/i2c-piix4  |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.24-rc3.orig/Documentation/hwmon/userspace-tools	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.24-rc3/Documentation/hwmon/userspace-tools	2007-11-18 23:43:32.000000000 +0100
@@ -14,7 +14,7 @@ Lm-sensors
 
 Core set of utilities that will allow you to obtain health information,
 setup monitoring limits etc. You can get them on their homepage
-http://www.lm-sensors.nu/ or as a package from your Linux distribution.
+http://www.lm-sensors.org/ or as a package from your Linux distribution.
 
 If from website:
 Get lm-sensors from project web site. Please note, you need only userspace
--- linux-2.6.24-rc3.orig/Documentation/hwmon/w83627hf	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.24-rc3/Documentation/hwmon/w83627hf	2007-11-18 23:43:21.000000000 +0100
@@ -73,5 +73,4 @@ doesn't help, you may just ignore the bo
 
 For further information on this driver see the w83781d driver documentation.
 
-[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/vid
-
+[1] http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
--- linux-2.6.24-rc3.orig/Documentation/i2c/busses/i2c-piix4	2007-10-10 09:58:06.000000000 +0200
+++ linux-2.6.24-rc3/Documentation/i2c/busses/i2c-piix4	2007-11-18 23:42:48.000000000 +0100
@@ -95,4 +95,4 @@ of all affected systems, so the only saf
 the SMBus on all IBM systems (detected using DMI data.)
 
 For additional information, read:
-http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad
+http://www.lm-sensors.org/browser/lm-sensors/trunk/README.thinkpad


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
