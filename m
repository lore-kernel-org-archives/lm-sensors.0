From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:58 +0000
Subject: [lm-sensors] [PATCH 04/82] hwmon: (adm1021) Fix multi-line comments
Message-Id: <1327017376-20466-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   54 +++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index e6fc006..3094bca 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -1,23 +1,23 @@
 /*
-    adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
-    Philip Edelbrock <phil@netroedge.com>
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
+ * adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
+ *			     Philip Edelbrock <phil@netroedge.com>
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
@@ -70,10 +70,12 @@ enum chips {
 
 /* Initial values */
 
-/* Note: Even though I left the low and high limits named os and hyst,
-they don't quite work like a thermostat the way the LM75 does.  I.e.,
-a lower temp than THYST actually triggers an alarm instead of
-clearing it.  Weird, ey?   --Phil  */
+/*
+ * Note: Even though I left the low and high limits named os and hyst,
+ * they don't quite work like a thermostat the way the LM75 does.  I.e.,
+ * a lower temp than THYST actually triggers an alarm instead of
+ * clearing it.  Weird, ey?   --Phil
+ */
 
 /* Each client has this additional data */
 struct adm1021_data {
@@ -447,8 +449,10 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
 		data->alarms = i2c_smbus_read_byte_data(client,
 						ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1023) {
-			/* The ADM1023 provides 3 extra bits of precision for
-			 * the remote sensor in extra registers. */
+			/*
+			 * The ADM1023 provides 3 extra bits of precision for
+			 * the remote sensor in extra registers.
+			 */
 			data->temp[1] += 125 * (i2c_smbus_read_byte_data(
 				client, ADM1023_REG_REM_TEMP_PREC) >> 5);
 			data->temp_max[1] += 125 * (i2c_smbus_read_byte_data(
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
