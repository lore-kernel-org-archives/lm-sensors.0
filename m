From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:46 +0000
Subject: [lm-sensors] [PATCH 67/79] hwmon: (emc2103) Fix multi-line comments
Message-Id: <1327373398-997-68-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc2103.c |   50 +++++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 0f51382..9691f66 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -1,21 +1,21 @@
 /*
-    emc2103.c - Support for SMSC EMC2103
-    Copyright (c) 2010 SMSC
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * emc2103.c - Support for SMSC EMC2103
+ * Copyright (c) 2010 SMSC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -48,12 +48,14 @@ static const u8 REG_TEMP_MAX[4] = { 0x34, 0x30, 0x31, 0x32 };
 /* equation 4 from datasheet: rpm = (3932160 * multipler) / count */
 #define FAN_RPM_FACTOR		3932160
 
-/* 2103-2 and 2103-4's 3rd temperature sensor can be connected to two diodes
+/*
+ * 2103-2 and 2103-4's 3rd temperature sensor can be connected to two diodes
  * in anti-parallel mode, and in this configuration both can be read
  * independently (so we have 4 temperature inputs).  The device can't
  * detect if it's connected in this mode, so we have to manually enable
  * it.  Default is to leave the device in the state it's already in (-1).
- * This parameter allows APD mode to be optionally forced on or off */
+ * This parameter allows APD mode to be optionally forced on or off
+ */
 static int apd = -1;
 module_param(apd, bint, 0);
 MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode mode");
@@ -302,10 +304,12 @@ show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
 	return sprintf(buf, "%d\n", fan_div);
 }
 
-/* Note: we also update the fan target here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least surprise; the user doesn't expect the fan target to change just
-   because the divider changed. */
+/*
+ * Note: we also update the fan target here, because its value is
+ * determined in part by the fan clock divider.  This follows the principle
+ * of least surprise; the user doesn't expect the fan target to change just
+ * because the divider changed.
+ */
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 			   const char *buf, size_t count)
 {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
