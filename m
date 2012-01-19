From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:01 +0000
Subject: [lm-sensors] [PATCH 07/82] hwmon: (adm1031) Fix multi-line comments
Message-Id: <1327017376-20466-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1031.c |   60 +++++++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 97e2cfb..7973267 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -1,25 +1,25 @@
 /*
-  adm1031.c - Part of lm_sensors, Linux kernel modules for hardware
-  monitoring
-  Based on lm75.c and lm85.c
-  Supports adm1030 / adm1031
-  Copyright (C) 2004 Alexandre d'Alton <alex@alexdalton.org>
-  Reworked by Jean Delvare <khali@linux-fr.org>
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of the GNU General Public License as published by
-  the Free Software Foundation; either version 2 of the License, or
-  (at your option) any later version.
-
-  This program is distributed in the hope that it will be useful,
-  but WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  GNU General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * adm1031.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Based on lm75.c and lm85.c
+ * Supports adm1030 / adm1031
+ * Copyright (C) 2004 Alexandre d'Alton <alex@alexdalton.org>
+ * Reworked by Jean Delvare <khali@linux-fr.org>
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
@@ -80,7 +80,8 @@ struct adm1031_data {
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned int update_interval;	/* In milliseconds */
-	/* The chan_select_table contains the possible configurations for
+	/*
+	 * The chan_select_table contains the possible configurations for
 	 * auto fan control.
 	 */
 	const auto_chan_table_t *chan_select_table;
@@ -205,7 +206,8 @@ static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
 #define GET_FAN_AUTO_BITFIELD(data, idx)	\
 	(*(data)->chan_select_table)[FAN_CHAN_FROM_REG((data)->conf1)][idx % 2]
 
-/* The tables below contains the possible values for the auto fan
+/*
+ * The tables below contains the possible values for the auto fan
  * control bitfields. the index in the table is the register value.
  * MSb is the auto fan control enable bit, so the four first entries
  * in the table disables auto fan control when both bitfields are zero.
@@ -226,7 +228,8 @@ static const auto_chan_table_t auto_channel_select_table_adm1030 = {
 	{ 3 /* 0b11 */		, 0 },
 };
 
-/* That function checks if a bitfield is valid and returns the other bitfield
+/*
+ * That function checks if a bitfield is valid and returns the other bitfield
  * nearest match if no exact match where found.
  */
 static int
@@ -252,7 +255,8 @@ get_fan_auto_nearest(struct adm1031_data *data,
 			break;
 		} else if (val = (*data->chan_select_table)[i][chan] &&
 			   first_match = -1) {
-			/* Save the first match in case of an exact match has
+			/*
+			 * Save the first match in case of an exact match has
 			 * not been found
 			 */
 			first_match = i;
@@ -306,9 +310,11 @@ set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
 	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {
 		if (data->conf1 & ADM1031_CONF1_AUTO_MODE) {
-			/* Switch to Auto Fan Mode
+			/*
+			 * Switch to Auto Fan Mode
 			 * Save PWM registers
-			 * Set PWM registers to 33% Both */
+			 * Set PWM registers to 33% Both
+			 */
 			data->old_pwm[0] = data->pwm[0];
 			data->old_pwm[1] = data->pwm[1];
 			adm1031_write_value(client, ADM1031_REG_PWM, 0x55);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
