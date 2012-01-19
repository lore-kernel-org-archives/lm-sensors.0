From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:10 +0000
Subject: [lm-sensors] [PATCH 76/82] hwmon: (w83791d) Fix multi-line comments
Message-Id: <1327017376-20466-77-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83791d.c |  211 +++++++++++++++++++++++++++--------------------
 1 files changed, 122 insertions(+), 89 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 679146d..5fbea95 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1,36 +1,36 @@
 /*
-    w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-
-    Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
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
+ * w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ *
+ * Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
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
 
 /*
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83791d	10	5	5	3	0x71	0x5ca3	yes	no
-
-    The w83791d chip appears to be part way between the 83781d and the
-    83792d. Thus, this file is derived from both the w83792d.c and
-    w83781d.c files.
-
-    The w83791g chip is the same as the w83791d but lead-free.
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83791d	10	5	5	3	0x71	0x5ca3	yes	no
+ *
+ * The w83791d chip appears to be part way between the 83781d and the
+ * 83792d. Thus, this file is derived from both the w83792d.c and
+ * w83781d.c files.
+ *
+ * The w83791g chip is the same as the w83791d but lead-free.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -198,10 +198,12 @@ static const u8 W83791D_REG_BEEP_CTRL[3] = {
 #define W83791D_REG_VBAT		0x5D
 #define W83791D_REG_I2C_ADDR		0x48
 
-/* The SMBus locks itself. The Winbond W83791D has a bank select register
-   (index 0x4e), but the driver only accesses registers in bank 0. Since
-   we don't switch banks, we don't need any special code to handle
-   locking access between bank switches */
+/*
+ * The SMBus locks itself. The Winbond W83791D has a bank select register
+ * (index 0x4e), but the driver only accesses registers in bank 0. Since
+ * we don't switch banks, we don't need any special code to handle
+ * locking access between bank switches
+ */
 static inline int w83791d_read(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -212,9 +214,11 @@ static inline int w83791d_write(struct i2c_client *client, u8 reg, u8 value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* The analog voltage inputs have 16mV LSB. Since the sysfs output is
-   in mV as would be measured on the chip input pin, need to just
-   multiply/divide by 16 to translate from/to register values. */
+/*
+ * The analog voltage inputs have 16mV LSB. Since the sysfs output is
+ * in mV as would be measured on the chip input pin, need to just
+ * multiply/divide by 16 to translate from/to register values.
+ */
 #define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 8) / 16), 0, 255))
 #define IN_FROM_REG(val)	((val) * 16)
 
@@ -237,10 +241,12 @@ static u8 fan_to_reg(long rpm, int div)
 				 (val) < 0 ? ((val) - 500) / 1000 : \
 				 ((val) + 500) / 1000)
 
-/* for temp2 and temp3 which are 9-bit resolution, LSB = 0.5 degree Celsius
-   Assumes the top 8 bits are the integral amount and the bottom 8 bits
-   are the fractional amount. Since we only have 0.5 degree resolution,
-   the bottom 7 bits will always be zero */
+/*
+ * for temp2 and temp3 which are 9-bit resolution, LSB = 0.5 degree Celsius
+ * Assumes the top 8 bits are the integral amount and the bottom 8 bits
+ * are the fractional amount. Since we only have 0.5 degree resolution,
+ * the bottom 7 bits will always be zero
+ */
 #define TEMP23_FROM_REG(val)	((val) / 128 * 500)
 #define TEMP23_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
 				 (val) >= 127500 ? 0x7F80 : \
@@ -299,18 +305,22 @@ struct w83791d_data {
 	/* Temperature sensors */
 
 	s8 temp1[3];		/* current, over, thyst */
-	s16 temp_add[2][3];	/* fixed point value. Top 8 bits are the
-				   integral part, bottom 8 bits are the
-				   fractional part. We only use the top
-				   9 bits as the resolution is only
-				   to the 0.5 degree C...
-				   two sensors with three values
-				   (cur, over, hyst)  */
+	s16 temp_add[2][3];	/*
+				 * fixed point value. Top 8 bits are the
+				 * integral part, bottom 8 bits are the
+				 * fractional part. We only use the top
+				 * 9 bits as the resolution is only
+				 * to the 0.5 degree C...
+				 * two sensors with three values
+				 * (cur, over, hyst)
+				 */
 
 	/* PWMs */
 	u8 pwm[5];		/* pwm duty cycle */
-	u8 pwm_enable[3];	/* pwm enable status for fan 1-3
-					(fan 4-5 only support manual mode) */
+	u8 pwm_enable[3];	/*
+				 * pwm enable status for fan 1-3
+				 * (fan 4-5 only support manual mode)
+				 */
 
 	u8 temp_target[3];	/* pwm 1-3 target temperature */
 	u8 temp_tolerance[3];	/* pwm 1-3 temperature tolerance */
@@ -494,8 +504,10 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }
 
-/* Note: The bitmask for the beep enable/disable is different than
-   the bitmask for the alarm. */
+/*
+ * Note: The bitmask for the beep enable/disable is different than
+ * the bitmask for the alarm.
+ */
 static struct sensor_device_attribute sda_in_beep[] = {
 	SENSOR_ATTR(in0_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 0),
 	SENSOR_ATTR(in1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 13),
@@ -568,10 +580,12 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr]));
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
 static ssize_t store_fan_div(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -1015,8 +1029,10 @@ static struct sensor_device_attribute_2 sda_temp_max_hyst[] = {
 			show_temp23, store_temp23, 1, 2),
 };
 
-/* Note: The bitmask for the beep enable/disable is different than
-   the bitmask for the alarm. */
+/*
+ * Note: The bitmask for the beep enable/disable is different than
+ * the bitmask for the alarm.
+ */
 static struct sensor_device_attribute sda_temp_beep[] = {
 	SENSOR_ATTR(temp1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 4),
 	SENSOR_ATTR(temp2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 5),
@@ -1075,8 +1091,10 @@ static ssize_t store_beep_mask(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 
-	/* The beep_enable state overrides any enabling request from
-	   the masks */
+	/*
+	 * The beep_enable state overrides any enabling request from
+	 * the masks
+	 */
 	data->beep_mask = BEEP_MASK_TO_REG(val) & ~GLOBAL_BEEP_ENABLE_MASK;
 	data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
 
@@ -1113,8 +1131,10 @@ static ssize_t store_beep_enable(struct device *dev,
 	data->beep_mask &= ~GLOBAL_BEEP_ENABLE_MASK;
 	data->beep_mask |= (data->beep_enable << GLOBAL_BEEP_ENABLE_SHIFT);
 
-	/* The global control is in the second beep control register
-	   so only need to update that register */
+	/*
+	 * The global control is in the second beep control register
+	 * so only need to update that register
+	 */
 	val = (data->beep_mask >> 8) & 0xff;
 
 	w83791d_write(client, W83791D_REG_BEEP_CTRL[1], val);
@@ -1156,9 +1176,11 @@ static ssize_t store_vrm_reg(struct device *dev,
 	unsigned long val;
 	int err;
 
-	/* No lock needed as vrm is internal to the driver
-	   (not read from a chip register) and so is not
-	   updated in w83791d_update_device() */
+	/*
+	 * No lock needed as vrm is internal to the driver
+	 * (not read from a chip register) and so is not
+	 * updated in w83791d_update_device()
+	 */
 
 	err = kstrtoul(buf, 10, &val);
 	if (err)
@@ -1232,9 +1254,11 @@ static const struct attribute_group w83791d_group = {
 	.attrs = w83791d_attributes,
 };
 
-/* Separate group of attributes for fan/pwm 4-5. Their pins can also be
-   in use for GPIO in which case their sysfs-interface should not be made
-   available */
+/*
+ * Separate group of attributes for fan/pwm 4-5. Their pins can also be
+ * in use for GPIO in which case their sysfs-interface should not be made
+ * available
+ */
 static struct attribute *w83791d_attributes_fanpwm45[] = {
 	FAN_UNIT_ATTRS(3),
 	FAN_UNIT_ATTRS(4),
@@ -1325,8 +1349,10 @@ static int w83791d_detect(struct i2c_client *client,
 			return -ENODEV;
 		}
 	}
-	/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
+	 * should match
+	 */
 	if (w83791d_read(client, W83791D_REG_I2C_ADDR) != address)
 		return -ENODEV;
 
@@ -1376,8 +1402,10 @@ static int w83791d_probe(struct i2c_client *client,
 	/* Initialize the chip */
 	w83791d_init_client(client);
 
-	/* If the fan_div is changed, make sure there is a rational
-	   fan_min in place */
+	/*
+	 * If the fan_div is changed, make sure there is a rational
+	 * fan_min in place
+	 */
 	for (i = 0; i < NUMBER_OF_FANIN; i++)
 		data->fan_min[i] = w83791d_read(client, W83791D_REG_FAN_MIN[i]);
 
@@ -1442,19 +1470,20 @@ static void w83791d_init_client(struct i2c_client *client)
 	u8 tmp;
 	u8 old_beep;
 
-	/* The difference between reset and init is that reset
-	   does a hard reset of the chip via index 0x40, bit 7,
-	   but init simply forces certain registers to have "sane"
-	   values. The hope is that the BIOS has done the right
-	   thing (which is why the default is reset=0, init=0),
-	   but if not, reset is the hard hammer and init
-	   is the soft mallet both of which are trying to whack
-	   things into place...
-	   NOTE: The data sheet makes a distinction between
-	   "power on defaults" and "reset by MR". As far as I can tell,
-	   the hard reset puts everything into a power-on state so I'm
-	   not sure what "reset by MR" means or how it can happen.
-	   */
+	/*
+	 * The difference between reset and init is that reset
+	 * does a hard reset of the chip via index 0x40, bit 7,
+	 * but init simply forces certain registers to have "sane"
+	 * values. The hope is that the BIOS has done the right
+	 * thing (which is why the default is reset=0, init=0),
+	 * but if not, reset is the hard hammer and init
+	 * is the soft mallet both of which are trying to whack
+	 * things into place...
+	 * NOTE: The data sheet makes a distinction between
+	 * "power on defaults" and "reset by MR". As far as I can tell,
+	 * the hard reset puts everything into a power-on state so I'm
+	 * not sure what "reset by MR" means or how it can happen.
+	 */
 	if (reset || init) {
 		/* keep some BIOS settings when we... */
 		old_beep = w83791d_read(client, W83791D_REG_BEEP_CONFIG);
@@ -1538,8 +1567,10 @@ static struct w83791d_data *w83791d_update_device(struct device *dev)
 		data->fan_div[3] = reg_array_tmp[2] & 0x07;
 		data->fan_div[4] = (reg_array_tmp[2] >> 4) & 0x07;
 
-		/* The fan divisor for fans 0-2 get bit 2 from
-		   bits 5-7 respectively of vbat register */
+		/*
+		 * The fan divisor for fans 0-2 get bit 2 from
+		 * bits 5-7 respectively of vbat register
+		 */
 		vbat_reg = w83791d_read(client, W83791D_REG_VBAT);
 		for (i = 0; i < 3; i++)
 			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
@@ -1645,8 +1676,10 @@ static void w83791d_print_debug(struct w83791d_data *data, struct device *dev)
 		dev_dbg(dev, "fan_div[%d] is: 0x%02x\n", i, data->fan_div[i]);
 	}
 
-	/* temperature math is signed, but only print out the
-	   bits that matter */
+	/*
+	 * temperature math is signed, but only print out the
+	 * bits that matter
+	 */
 	dev_dbg(dev, "%d set of Temperatures: ==>\n", NUMBER_OF_TEMPIN);
 	for (i = 0; i < 3; i++)
 		dev_dbg(dev, "temp1[%d] is: 0x%02x\n", i, (u8) data->temp1[i]);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
