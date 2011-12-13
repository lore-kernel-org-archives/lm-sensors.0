From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 13 Dec 2011 18:19:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f75375s) Added F75387SG/RG support
Message-Id: <83C40BD6-D4B4-40DB-B664-6DC80FA4DB85@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
In-Reply-To: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added support for Fintek F75387SG/RG.

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Bjoern Gerhart <oss@extracloud.de>
---

Tested with kernel 2.6.39, but without fans so far.

v2:
- suitable ontop of the latest set of f75375s related patches
- simplified name of a local char variable

v3:
- detected reason for corrupted patch, should be solved now
- fixed F75387 fan handling: detect/select pwm_enable[0,1] 

 Kconfig   |    4 -
 f75375s.c |  174 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 129 insertions(+), 49 deletions(-)

diff -uNr linux-2.6.39-5patched/drivers/hwmon/f75375s.c linux-2.6.39/drivers/hwmon/f75375s.c
--- linux-2.6.39-5patched/drivers/hwmon/f75375s.c	2011-12-09 15:41:01.000000000 +0100
+++ linux-2.6.39/drivers/hwmon/f75375s.c	2011-12-13 13:58:04.000000000 +0100
@@ -1,6 +1,6 @@
 /*
- * f75375s.c - driver for the Fintek F75375/SP and F75373
- *             hardware monitoring features
+ * f75375s.c - driver for the Fintek F75375/SP, F75373 and
+ *             F75387SG/RG hardware monitoring features
  * Copyright (C) 2006-2007  Riku Voipio
  *
  * Datasheets available at:
@@ -11,6 +11,9 @@
  * f75373:
  * http://www.fintek.com.tw/files/productfiles/F75373_V025P.pdf
  *
+ * f75387:
+ * http://www.fintek.com.tw/files/productfiles/F75387_V027P.pdf
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -40,7 +43,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
 
-enum chips { f75373, f75375 };
+enum chips { f75373, f75375, f75387 };
 
 /* Fintek F75375 registers  */
 #define F75375_REG_CONFIG0		0x0
@@ -59,6 +62,7 @@
 #define F75375_REG_VOLT_LOW(nr)		(0x21 + (nr) * 2)
 
 #define F75375_REG_TEMP(nr)		(0x14 + (nr))
+#define F75387_REG_TEMP11_LSB(nr)	(0x1a + (nr))
 #define F75375_REG_TEMP_HIGH(nr)	(0x28 + (nr) * 2)
 #define F75375_REG_TEMP_HYST(nr)	(0x29 + (nr) * 2)
 
@@ -78,8 +82,11 @@
 #define F75375_REG_PWM1_DROP_DUTY	0x6B
 #define F75375_REG_PWM2_DROP_DUTY	0x6C
 
-#define FAN_CTRL_LINEAR(nr)		(4 + nr)
+#define F75375_FAN_CTRL_LINEAR(nr)	(4 + nr)
+#define F75387_FAN_CTRL_LINEAR(nr)	(1 + ((nr) * 4))
 #define FAN_CTRL_MODE(nr)		(4 + ((nr) * 2))
+#define F75387_FAN_DUTY_MODE(nr)	(2 + ((nr) * 4))
+#define F75387_FAN_MANU_MODE(nr)	((nr) * 4)
 
 /*
  * Data structures and manipulation thereof
@@ -108,7 +115,12 @@
 	u8 pwm[2];
 	u8 pwm_mode[2];
 	u8 pwm_enable[2];
-	s8 temp[2];
+	/*
+	 * f75387: For remote temperature reading, it uses signed 11-bit
+	 * values with LSB = 0.125 degree Celsius, left-justified in 16-bit
+	 * registers. For original 8-bit temp readings, the LSB just is 0.
+	 */
+	s16 temp11[2];
 	s8 temp_high[2];
 	s8 temp_max_hyst[2];
 };
@@ -122,6 +134,7 @@
 static const struct i2c_device_id f75375_id[] = {
 	{ "f75373", f75373 },
 	{ "f75375", f75375 },
+	{ "f75387", f75387 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, f75375_id);
@@ -205,8 +218,13 @@
 	if (time_after(jiffies, data->last_updated + 2 * HZ)
 		|| !data->valid) {
 		for (nr = 0; nr < 2; nr++) {
-			data->temp[nr] -				f75375_read8(client, F75375_REG_TEMP(nr));
+			/* assign MSB, therefore shift it by 8 bits */
+			data->temp11[nr] +				f75375_read8(client, F75375_REG_TEMP(nr)) << 8;
+			if (data->kind = f75387)
+				/* merge F75387's temperature LSB (11-bit) */
+				data->temp11[nr] |+					f75375_read8(client, F75387_REG_TEMP11_LSB(nr));
 			data->fan[nr]  				f75375_read16(client, F75375_REG_FAN(nr));
 		}
@@ -313,24 +331,50 @@
 		return -EINVAL;
 
 	fanmode = f75375_read8(client, F75375_REG_FAN_TIMER);
-	fanmode &= ~(3 << FAN_CTRL_MODE(nr));
-
-	switch (val) {
-	case 0: /* Full speed */
-		fanmode  |= (3 << FAN_CTRL_MODE(nr));
-		data->pwm[nr] = 255;
-		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-				data->pwm[nr]);
-		break;
-	case 1: /* PWM */
-		fanmode  |= (3 << FAN_CTRL_MODE(nr));
-		break;
-	case 2: /* AUTOMATIC*/
-		fanmode  |= (2 << FAN_CTRL_MODE(nr));
-		break;
-	case 3: /* fan speed */
-		break;
+	if (data->kind = f75387) {
+		/* clear each fanX_mode bit before setting them properly */
+		fanmode &= ~(1 << F75387_FAN_DUTY_MODE(nr));
+		fanmode &= ~(1 << F75387_FAN_MANU_MODE(nr));
+		switch (val) {
+		case 0: /* full speed */
+			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
+			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
+			data->pwm[nr] = 255;
+			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+					data->pwm[nr]);
+			break;
+		case 1: /* PWM */
+			fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
+			fanmode  |= (1 << F75387_FAN_DUTY_MODE(nr));
+			break;
+		case 2: /* AUTOMATIC*/
+			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
+			break;
+		case 3: /* fan speed */
+			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
+			break;
+		}
+	} else {
+		/* clear each fanX_mode bit before setting them properly */
+		fanmode &= ~(3 << FAN_CTRL_MODE(nr));
+		switch (val) {
+		case 0: /* full speed */
+			fanmode  |= (3 << FAN_CTRL_MODE(nr));
+			data->pwm[nr] = 255;
+			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+					data->pwm[nr]);
+			break;
+		case 1: /* PWM */
+			fanmode  |= (3 << FAN_CTRL_MODE(nr));
+			break;
+		case 2: /* AUTOMATIC*/
+			fanmode  |= (2 << FAN_CTRL_MODE(nr));
+			break;
+		case 3: /* fan speed */
+			break;
+		}
 	}
+
 	f75375_write8(client, F75375_REG_FAN_TIMER, fanmode);
 	data->pwm_enable[nr] = val;
 	return 0;
@@ -364,6 +408,7 @@
 	unsigned long val;
 	int err;
 	u8 conf;
+	char reg, ctrl;
 
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
@@ -376,14 +421,23 @@
 	if (data->kind = f75373 && val = 0)
 		return -EINVAL;
 
+	/* take care for different registers */
+	if (data->kind = f75387) {
+		reg = F75375_REG_FAN_TIMER;
+		ctrl = F75387_FAN_CTRL_LINEAR(nr);
+	} else {
+		reg = F75375_REG_CONFIG1;
+		ctrl = F75375_FAN_CTRL_LINEAR(nr);
+	}
+
 	mutex_lock(&data->update_lock);
-	conf = f75375_read8(client, F75375_REG_CONFIG1);
-	conf &= ~(1 << FAN_CTRL_LINEAR(nr));
+	conf = f75375_read8(client, reg);
+	conf &= ~(1 << ctrl);
 
 	if (val = 0)
-		conf |= (1 << FAN_CTRL_LINEAR(nr)) ;
+		conf |= (1 << ctrl);
 
-	f75375_write8(client, F75375_REG_CONFIG1, conf);
+	f75375_write8(client, reg, conf);
 	data->pwm_mode[nr] = val;
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -475,13 +529,14 @@
 }
 #define TEMP_FROM_REG(val) ((val) * 1000)
 #define TEMP_TO_REG(val) ((val) / 1000)
+#define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t show_temp11(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct f75375_data *data = f75375_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
+	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
 }
 
 static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
@@ -577,12 +632,12 @@
 	show_in_max, set_in_max, 3);
 static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,
 	show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,
 	show_temp_max_hyst, set_temp_max_hyst, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,
 	show_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
 	show_temp_max_hyst, set_temp_max_hyst, 1);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
@@ -664,18 +719,38 @@
 		conf = f75375_read8(client, F75375_REG_CONFIG1);
 		mode = f75375_read8(client, F75375_REG_FAN_TIMER);
 		for (nr = 0; nr < 2; nr++) {
-			if (!(conf & (1 << FAN_CTRL_LINEAR(nr))))
-				data->pwm_mode[nr] = 1;
-			switch ((mode >> FAN_CTRL_MODE(nr)) & 3) {
-			case 0:		/* speed */
-				data->pwm_enable[nr] = 3;
-				break;
-			case 1:		/* automatic */
-				data->pwm_enable[nr] = 2;
-				break;
-			default:	/* manual */
-				data->pwm_enable[nr] = 1;
-				break;
+			if (data->kind = f75387) {
+				bool manu, duty;
+
+				if (!(conf & (1 << F75387_FAN_CTRL_LINEAR(nr))))
+					data->pwm_mode[nr] = 1;
+
+				manu = ((mode >> F75387_FAN_MANU_MODE(nr)) & 1);
+				duty = ((mode >> F75387_FAN_DUTY_MODE(nr)) & 1);
+				if (manu && duty)
+					/* speed */
+					data->pwm_enable[nr] = 3;
+				else if (!manu && duty)
+					/* automatic */
+					data->pwm_enable[nr] = 2;
+				else
+					/* manual */
+					data->pwm_enable[nr] = 1;
+			} else {
+				if (!(conf & (1 << F75375_FAN_CTRL_LINEAR(nr))))
+					data->pwm_mode[nr] = 1;
+
+				switch ((mode >> FAN_CTRL_MODE(nr)) & 3) {
+				case 0:		/* speed */
+					data->pwm_enable[nr] = 3;
+					break;
+				case 1:		/* automatic */
+					data->pwm_enable[nr] = 2;
+					break;
+				default:	/* manual */
+					data->pwm_enable[nr] = 1;
+					break;
+				}
 			}
 		}
 		return;
@@ -763,10 +838,15 @@
 
 	vendid = f75375_read16(client, F75375_REG_VENDOR);
 	chipid = f75375_read16(client, F75375_CHIP_ID);
-	if (chipid = 0x0306 && vendid = 0x1934)
+	if (vendid != 0x1934)
+		return -ENODEV;
+
+	if (chipid = 0x0306)
 		name = "f75375";
-	else if (chipid = 0x0204 && vendid = 0x1934)
+	else if (chipid = 0x0204)
 		name = "f75373";
+	else if (chipid = 0x0410)
+		name = "f75387";
 	else
 		return -ENODEV;
 
@@ -789,7 +869,7 @@
 
 MODULE_AUTHOR("Riku Voipio");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("F75373/F75375 hardware monitoring driver");
+MODULE_DESCRIPTION("F75373/F75375/F75387 hardware monitoring driver");
 
 module_init(sensors_f75375_init);
 module_exit(sensors_f75375_exit);
diff -uNr linux-2.6.39-5patched/drivers/hwmon/Kconfig linux-2.6.39/drivers/hwmon/Kconfig
--- linux-2.6.39-5patched/drivers/hwmon/Kconfig	2011-12-09 15:41:09.000000000 +0100
+++ linux-2.6.39/drivers/hwmon/Kconfig	2011-12-13 05:41:52.000000000 +0100
@@ -335,11 +335,11 @@
 	  will be called f71882fg.
 
 config SENSORS_F75375S
-	tristate "Fintek F75375S/SP and F75373"
+	tristate "Fintek F75375S/SP, F75373 and F75387"
 	depends on I2C
 	help
 	  If you say yes here you get support for hardware monitoring
-	  features of the Fintek F75375S/SP and F75373
+	  features of the Fintek F75375S/SP, F75373 and F75387
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called f75375s.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
