From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:00 +0000
Subject: [lm-sensors] [PATCH 21/79] hwmon: (ads7828) Fix multi-line comments
Message-Id: <1327373398-997-22-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Steve Hardy <shardy@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads7828.c |   59 ++++++++++++++++++++++++-----------------------
 1 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index ed60242..bf3fdf4 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -1,27 +1,27 @@
 /*
-	ads7828.c - lm_sensors driver for ads7828 12-bit 8-channel ADC
-	(C) 2007 EADS Astrium
-
-	This driver is based on the lm75 and other lm_sensors/hwmon drivers
-
-	Written by Steve Hardy <shardy@redhat.com>
-
-	Datasheet available at: http://focus.ti.com/lit/ds/symlink/ads7828.pdf
-
-	This program is free software; you can redistribute it and/or modify
-	it under the terms of the GNU General Public License as published by
-	the Free Software Foundation; either version 2 of the License, or
-	(at your option) any later version.
-
-	This program is distributed in the hope that it will be useful,
-	but WITHOUT ANY WARRANTY; without even the implied warranty of
-	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
-	GNU General Public License for more details.
-
-	You should have received a copy of the GNU General Public License
-	along with this program; if not, write to the Free Software
-	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * ads7828.c - lm_sensors driver for ads7828 12-bit 8-channel ADC
+ * (C) 2007 EADS Astrium
+ *
+ * This driver is based on the lm75 and other lm_sensors/hwmon drivers
+ *
+ * Written by Steve Hardy <shardy@redhat.com>
+ *
+ * Datasheet available at: http://focus.ti.com/lit/ds/symlink/ads7828.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -188,12 +188,13 @@ static int ads7828_detect(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA))
 		return -ENODEV;
 
-	/* Now, we do the remaining detection. There is no identification
-	dedicated register so attempt to sanity check using knowledge of
-	the chip
-	- Read from the 8 channel addresses
-	- Check the top 4 bits of each result are not set (12 data bits)
-	*/
+	/*
+	 * Now, we do the remaining detection. There is no identification
+	 * dedicated register so attempt to sanity check using knowledge of
+	 * the chip
+	 * - Read from the 8 channel addresses
+	 * - Check the top 4 bits of each result are not set (12 data bits)
+	 */
 	for (ch = 0; ch < ADS7828_NCH; ch++) {
 		u16 in_data;
 		u8 cmd = channel_cmd_byte(ch);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
