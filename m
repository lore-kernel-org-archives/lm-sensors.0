From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:02 +0000
Subject: [lm-sensors] [PATCH 23/79] hwmon: (amc6821) Fix multi-line comments
Message-Id: <1327373398-997-24-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: T. Mertelj <tomaz.mertelj@guest.arnes.si>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c |   57 ++++++++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 5298855..f600fa1 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -1,25 +1,25 @@
 /*
-	amc6821.c - Part of lm_sensors, Linux kernel modules for hardware
-	monitoring
-	Copyright (C) 2009 T. Mertelj <tomaz.mertelj@guest.arnes.si>
-
-	Based on max6650.c:
-	Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
-
-	This program is free software; you can redistribute it and/or modify
-	it under the terms of the GNU General Public License as published by
-	the Free Software Foundation; either version 2 of the License, or
-	(at your option) any later version.
-
-	This program is distributed in the hope that it will be useful,
-	but WITHOUT ANY WARRANTY; without even the implied warranty of
-	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-	GNU General Public License for more details.
-
-	You should have received a copy of the GNU General Public License
-	along with this program; if not, write to the Free Software
-	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * amc6821.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (C) 2009 T. Mertelj <tomaz.mertelj@guest.arnes.si>
+ *
+ * Based on max6650.c:
+ * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
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
 
 
 #include <linux/kernel.h>	/* Needed for KERN_INFO */
@@ -188,7 +188,7 @@ static struct i2c_driver amc6821_driver = {
 
 /*
  * Client data (each client gets its own)
-  */
+ */
 
 struct amc6821_data {
 	struct device *hwmon_dev;
@@ -836,8 +836,10 @@ static int amc6821_detect(
 		return -ENODEV;
 	}
 
-	/* Bit 7 of the address register is ignored, so we can check the
-	   ID registers again */
+	/*
+	 * Bit 7 of the address register is ignored, so we can check the
+	 * ID registers again
+	 */
 	dev_id = i2c_smbus_read_byte_data(client, 0x80 | AMC6821_REG_DEV_ID);
 	comp_id = i2c_smbus_read_byte_data(client, 0x80 | AMC6821_REG_COMP_ID);
 	if (dev_id != 0x21 || comp_id != 0x49) {
@@ -1080,9 +1082,10 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
 			data->pwm1_auto_channels_temp = 3;
 			data->pwm1_enable = 3;
 			break;
-		case 1: /*semi-open loop: software sets rpm, chip controls pwm1,
-			  *currently not implemented
-			  */
+		case 1: /*
+			 * semi-open loop: software sets rpm, chip controls
+			 * pwm1, currently not implemented
+			 */
 			data->pwm1_auto_channels_temp = 0;
 			data->pwm1_enable = 0;
 			break;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
