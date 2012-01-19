From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:11 +0000
Subject: [lm-sensors] [PATCH 77/82] hwmon: (w83792d) Fix multi-line comments
Message-Id: <1327017376-20466-78-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83792d.c |  124 ++++++++++++++++++++++++++---------------------
 1 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index e356618..90f81a3 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1,39 +1,39 @@
 /*
-    w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-    Copyright (C) 2004, 2005 Winbond Electronics Corp.
-			Chunhao Huang <DZShen@Winbond.com.tw>,
-			Rudolf Marek <r.marek@assembler.cz>
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
-    Note:
-    1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
-    2. This driver is only for Winbond W83792D C version device, there
-       are also some motherboards with B version W83792D device. The
-       calculation method to in6-in7(measured value, limits) is a little
-       different between C and B version. C or B version can be identified
-       by CR[0x49h].
-*/
+ * w83792d.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (C) 2004, 2005 Winbond Electronics Corp.
+ *			    Chunhao Huang <DZShen@Winbond.com.tw>,
+ *			    Rudolf Marek <r.marek@assembler.cz>
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
+ * Note:
+ * 1. This driver is only for 2.6 kernel, 2.4 kernel need a different driver.
+ * 2. This driver is only for Winbond W83792D C version device, there
+ *     are also some motherboards with B version W83792D device. The
+ *     calculation method to in6-in7(measured value, limits) is a little
+ *     different between C and B version. C or B version can be identified
+ *     by CR[0x49h].
+ */
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -218,10 +218,12 @@ static const u8 W83792D_REG_LEVELS[3][4] = {
 #define W83792D_REG_VBAT		0x5D
 #define W83792D_REG_I2C_ADDR		0x48
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants. Note that you should be a bit careful with which arguments
+ * these macros are called: arguments may be evaluated more than once.
+ * Fixing this is just not worth it.
+ */
 #define IN_FROM_REG(nr, val) (((nr) <= 1) ? ((val) * 2) : \
 		((((nr) = 6) || ((nr) = 7)) ? ((val) * 6) : ((val) * 4)))
 #define IN_TO_REG(nr, val) (((nr) <= 1) ? ((val) / 2) : \
@@ -287,8 +289,10 @@ struct w83792d_data {
 	u8 temp1[3];		/* current, over, thyst */
 	u8 temp_add[2][6];	/* Register value */
 	u8 fan_div[7];		/* Register encoding, shifted right */
-	u8 pwm[7];		/* We only consider the first 3 set of pwm,
-				   although 792 chip has 7 set of pwm. */
+	u8 pwm[7];		/*
+				 * We only consider the first 3 set of pwm,
+				 * although 792 chip has 7 set of pwm.
+				 */
 	u8 pwmenable[3];
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
@@ -336,9 +340,11 @@ static inline long in_count_from_reg(int nr, struct w83792d_data *data)
 	return (data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03);
 }
 
-/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
-   but the driver only accesses registers in bank 0, so we don't have
-   to switch banks and lock access between switches. */
+/*
+ * The SMBus locks itself. The Winbond W83792D chip has a bank register,
+ * but the driver only accesses registers in bank 0, so we don't have
+ * to switch banks and lock access between switches.
+ */
 static inline int w83792d_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -450,10 +456,12 @@ show_fan_div(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least surprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan divisor.  This follows the principle of
+ * least surprise; the user doesn't expect the fan minimum to change just
+ * because the divisor changed.
+ */
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -1383,8 +1391,10 @@ w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
 		    ((val1 & 0x80) && val2 != 0x5c))
 			return -ENODEV;
 	}
-	/* If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83792D_REG_I2C_ADDR
+	 * should match
+	 */
 	if (w83792d_read_value(client, W83792D_REG_I2C_ADDR) != address)
 		return -ENODEV;
 
@@ -1440,8 +1450,10 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (err)
 		goto ERROR3;
 
-	/* Read GPIO enable register to check if pins for fan 4,5 are used as
-	   GPIO */
+	/*
+	 * Read GPIO enable register to check if pins for fan 4,5 are used as
+	 * GPIO
+	 */
 	val1 = w83792d_read_value(client, W83792D_REG_GPIO_EN);
 
 	if (!(val1 & 0x40)) {
@@ -1521,11 +1533,13 @@ w83792d_init_client(struct i2c_client *client)
 	if (init)
 		w83792d_write_value(client, W83792D_REG_CONFIG, 0x80);
 
-	/* Clear the bit6 of W83792D_REG_VID_IN_B(set it into 0):
-	   W83792D_REG_VID_IN_B bit6 = 0: the high/low limit of
-	     vin0/vin1 can be modified by user;
-	   W83792D_REG_VID_IN_B bit6 = 1: the high/low limit of
-	     vin0/vin1 auto-updated, can NOT be modified by user. */
+	/*
+	 * Clear the bit6 of W83792D_REG_VID_IN_B(set it into 0):
+	 * W83792D_REG_VID_IN_B bit6 = 0: the high/low limit of
+	 * vin0/vin1 can be modified by user;
+	 * W83792D_REG_VID_IN_B bit6 = 1: the high/low limit of
+	 * vin0/vin1 auto-updated, can NOT be modified by user.
+	 */
 	vid_in_b = w83792d_read_value(client, W83792D_REG_VID_IN_B);
 	w83792d_write_value(client, W83792D_REG_VID_IN_B,
 			    vid_in_b & 0xbf);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
