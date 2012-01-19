From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:11 +0000
Subject: [lm-sensors] [PATCH 17/82] hwmon: (atxp1) Fix multi-line comments
Message-Id: <1327017376-20466-18-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/atxp1.c |   63 ++++++++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index d4a589b..a9d5d0f 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -1,22 +1,22 @@
 /*
-    atxp1.c - kernel module for setting CPU VID and general purpose
-		I/Os using the Attansic ATXP1 chip.
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
-
-*/
+ * atxp1.c - kernel module for setting CPU VID and general purpose
+ *	     I/Os using the Attansic ATXP1 chip.
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
+ *
+ */
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -184,9 +184,10 @@ static ssize_t atxp1_storevcore(struct device *dev,
 	return count;
 }
 
-/* CPU core reference voltage
-    unit: millivolt
-*/
+/*
+ * CPU core reference voltage
+ * unit: millivolt
+ */
 static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore,
 		   atxp1_storevcore);
 
@@ -233,9 +234,10 @@ static ssize_t atxp1_storegpio1(struct device *dev,
 	return count;
 }
 
-/* GPIO1 data register
-    unit: Four bit as hex (e.g. 0x0f)
-*/
+/*
+ * GPIO1 data register
+ * unit: Four bit as hex (e.g. 0x0f)
+ */
 static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
 
 /* sys file functions for GPIO2 */
@@ -277,9 +279,10 @@ static ssize_t atxp1_storegpio2(struct device *dev,
 	return count;
 }
 
-/* GPIO2 data register
-    unit: Eight bit as hex (e.g. 0xff)
-*/
+/*
+ * GPIO2 data register
+ * unit: Eight bit as hex (e.g. 0xff)
+ */
 static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 
 static struct attribute *atxp1_attributes[] = {
@@ -312,8 +315,10 @@ static int atxp1_detect(struct i2c_client *new_client,
 	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
 		return -ENODEV;
 
-	/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
-	 * showing the same as register 0x00 */
+	/*
+	 * No vendor ID, now checking if registers 0x10,0x11 (non-existent)
+	 * showing the same as register 0x00
+	 */
 	temp = i2c_smbus_read_byte_data(new_client, 0x00);
 
 	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
