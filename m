From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:13 +0000
Subject: [lm-sensors] [PATCH 19/82] hwmon: (ds1621) Fix multi-line comments
Message-Id: <1327017376-20466-20-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   51 +++++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index e23a8ab..8c7b9fe 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -1,25 +1,25 @@
 /*
-    ds1621.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-    Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
-    based on lm75.c by Frodo Looijaard <frodol@dds.nl>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
-    the help of Jean Delvare <khali@linux-fr.org>
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
+ * ds1621.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	      monitoring
+ * Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
+ * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
+ * Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
+ * the help of Jean Delvare <khali@linux-fr.org>
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
@@ -222,9 +222,12 @@ static int ds1621_detect(struct i2c_client *client,
 				     | I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -ENODEV;
 
-	/* Now, we do the remaining detection. It is lousy. */
-	/* The NVB bit should be low if no EEPROM write has been  requested
-	   during the latest 10ms, which is highly improbable in our case. */
+	/*
+	 * Now, we do the remaining detection. It is lousy.
+	 *
+	 * The NVB bit should be low if no EEPROM write has been requested
+	 * during the latest 10ms, which is highly improbable in our case.
+	 */
 	conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 	if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
 		return -ENODEV;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
