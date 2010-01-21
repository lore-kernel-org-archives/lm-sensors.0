From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 14:06:07 +0000
Subject: [lm-sensors] [PATCH 6/8] hwmon: (it87) Fix many checkpatch errors
Message-Id: <20100121150607.311869ea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Fix 20 errors and 11 warnings reported by the checkpatch script. The
remainining errors would require more work. The remaining warnings
will be addressed later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |  162 ++++++++++++++++++++++++++------------------------
 1 file changed, 87 insertions(+), 75 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-21 14:27:47.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-21 14:31:49.000000000 +0100
@@ -1,40 +1,40 @@
 /*
-    it87.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring.
-
-    The IT8705F is an LPC-based Super I/O part that contains UARTs, a
-    parallel port, an IR port, a MIDI port, a floppy controller, etc., in
-    addition to an Environment Controller (Enhanced Hardware Monitor and
-    Fan Controller)
-
-    This driver supports only the Environment Controller in the IT8705F and
-    similar parts.  The other devices are supported by different drivers.
-
-    Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chip w/LPC interface
-              IT8716F  Super I/O chip w/LPC interface
-              IT8718F  Super I/O chip w/LPC interface
-              IT8720F  Super I/O chip w/LPC interface
-              IT8726F  Super I/O chip w/LPC interface
-              Sis950   A clone of the IT8705F
-
-    Copyright (C) 2001 Chris Gauthron
-    Copyright (C) 2005-2007 Jean Delvare <khali@linux-fr.org>
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
+ *  it87.c - Part of lm_sensors, Linux kernel modules for hardware
+ *           monitoring.
+ *
+ *  The IT8705F is an LPC-based Super I/O part that contains UARTs, a
+ *  parallel port, an IR port, a MIDI port, a floppy controller, etc., in
+ *  addition to an Environment Controller (Enhanced Hardware Monitor and
+ *  Fan Controller)
+ *
+ *  This driver supports only the Environment Controller in the IT8705F and
+ *  similar parts.  The other devices are supported by different drivers.
+ *
+ *  Supports: IT8705F  Super I/O chip w/LPC interface
+ *            IT8712F  Super I/O chip w/LPC interface
+ *            IT8716F  Super I/O chip w/LPC interface
+ *            IT8718F  Super I/O chip w/LPC interface
+ *            IT8720F  Super I/O chip w/LPC interface
+ *            IT8726F  Super I/O chip w/LPC interface
+ *            Sis950   A clone of the IT8705F
+ *
+ *  Copyright (C) 2001 Chris Gauthron
+ *  Copyright (C) 2005-2010 Jean Delvare <khali@linux-fr.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -494,8 +494,9 @@ static ssize_t show_sensor(struct device
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	u8 reg = data->sensor; /* In case the value is updated while we use it */
-	
+	u8 reg = data->sensor;		/* In case the value is updated while
+					   we use it */
+
 	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
 	if (reg & (8 << nr))
@@ -522,9 +523,9 @@ static ssize_t set_sensor(struct device
 	}
 	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
 	if (val = 3)
-	    data->sensor |= 1 << nr;
+		data->sensor |= 1 << nr;
 	else if (val = 4)
-	    data->sensor |= 8 << nr;
+		data->sensor |= 8 << nr;
 	else if (val != 0) {
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -562,7 +563,7 @@ static ssize_t show_fan(struct device *d
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
@@ -572,8 +573,8 @@ static ssize_t show_fan_min(struct devic
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+				DIV_FROM_REG(data->fan_div[nr])));
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -584,8 +585,8 @@ static ssize_t show_fan_div(struct devic
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t show_pwm_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
@@ -623,9 +624,15 @@ static ssize_t set_fan_min(struct device
 	mutex_lock(&data->update_lock);
 	reg = it87_read_value(data, IT87_REG_FAN_DIV);
 	switch (nr) {
-	case 0: data->fan_div[nr] = reg & 0x07; break;
-	case 1: data->fan_div[nr] = (reg >> 3) & 0x07; break;
-	case 2: data->fan_div[nr] = (reg & 0x40) ? 3 : 1; break;
+	case 0:
+		data->fan_div[nr] = reg & 0x07;
+		break;
+	case 1:
+		data->fan_div[nr] = (reg >> 3) & 0x07;
+		break;
+	case 2:
+		data->fan_div[nr] = (reg & 0x40) ? 3 : 1;
+		break;
 	}
 
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -696,7 +703,8 @@ static ssize_t set_pwm_enable(struct dev
 		it87_write_value(data, IT87_REG_FAN_CTL, tmp | (1 << nr));
 		/* set on/off mode */
 		data->fan_main_ctrl &= ~(1 << nr);
-		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+				 data->fan_main_ctrl);
 	} else {
 		if (val = 1)				/* Manual mode */
 			data->pwm_ctrl[nr] = data->pwm_duty[nr];
@@ -705,7 +713,8 @@ static ssize_t set_pwm_enable(struct dev
 		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
 		/* set SmartGuardian mode */
 		data->fan_main_ctrl |= (1 << nr);
-		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+				 data->fan_main_ctrl);
 	}
 
 	mutex_unlock(&data->update_lock);
@@ -892,7 +901,8 @@ show_fan16_offset(4);
 show_fan16_offset(5);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -972,14 +982,14 @@ static SENSOR_DEVICE_ATTR(temp1_beep, S_
 static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);
 
-static ssize_t
-show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	u32 val;
@@ -991,8 +1001,8 @@ store_vrm_reg(struct device *dev, struct
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
-static ssize_t
-show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -1375,7 +1385,8 @@ static int __devinit it87_probe(struct p
 		goto ERROR0;
 	}
 
-	if (!(data = kzalloc(sizeof(struct it87_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct it87_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
@@ -1403,7 +1414,8 @@ static int __devinit it87_probe(struct p
 	it87_init_device(pdev);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&dev->kobj, &it87_group)))
+	err = sysfs_create_group(&dev->kobj, &it87_group);
+	if (err)
 		goto ERROR2;
 
 	if (sio_data->beep_pin) {
@@ -1624,7 +1636,8 @@ static void __devinit it87_init_device(s
 	if ((data->fan_main_ctrl & mask) = 0) {
 		/* Enable all fan tachometers */
 		data->fan_main_ctrl |= mask;
-		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+				 data->fan_main_ctrl);
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
@@ -1673,24 +1686,22 @@ static struct it87_data *it87_update_dev
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
-
 		if (update_vbat) {
 			/* Cleared after each update, so reenable.  Value
-		 	  returned by this read will be previous value */	
+			   returned by this read will be previous value */
 			it87_write_value(data, IT87_REG_CONFIG,
-			   it87_read_value(data, IT87_REG_CONFIG) | 0x40);
+				it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
 		for (i = 0; i <= 7; i++) {
 			data->in[i] -			    it87_read_value(data, IT87_REG_VIN(i));
+				it87_read_value(data, IT87_REG_VIN(i));
 			data->in_min[i] -			    it87_read_value(data, IT87_REG_VIN_MIN(i));
+				it87_read_value(data, IT87_REG_VIN_MIN(i));
 			data->in_max[i] -			    it87_read_value(data, IT87_REG_VIN_MAX(i));
+				it87_read_value(data, IT87_REG_VIN_MAX(i));
 		}
 		/* in8 (battery) has no limit registers */
-		data->in[8] -		    it87_read_value(data, IT87_REG_VIN(8));
+		data->in[8] = it87_read_value(data, IT87_REG_VIN(8));
 
 		for (i = 0; i < 5; i++) {
 			/* Skip disabled fans */
@@ -1698,7 +1709,7 @@ static struct it87_data *it87_update_dev
 				continue;
 
 			data->fan_min[i] -			    it87_read_value(data, IT87_REG_FAN_MIN[i]);
+				it87_read_value(data, IT87_REG_FAN_MIN[i]);
 			data->fan[i] = it87_read_value(data,
 				       IT87_REG_FAN[i]);
 			/* Add high byte if in 16-bit mode */
@@ -1711,11 +1722,11 @@ static struct it87_data *it87_update_dev
 		}
 		for (i = 0; i < 3; i++) {
 			data->temp[i] -			    it87_read_value(data, IT87_REG_TEMP(i));
+				it87_read_value(data, IT87_REG_TEMP(i));
 			data->temp_high[i] -			    it87_read_value(data, IT87_REG_TEMP_HIGH(i));
+				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
 			data->temp_low[i] -			    it87_read_value(data, IT87_REG_TEMP_LOW(i));
+				it87_read_value(data, IT87_REG_TEMP_LOW(i));
 		}
 
 		/* Newer chips don't have clock dividers */
@@ -1811,7 +1822,7 @@ exit:
 static int __init sm_it87_init(void)
 {
 	int err;
-	unsigned short isa_address=0;
+	unsigned short isa_address = 0;
 	struct it87_sio_data sio_data;
 
 	memset(&sio_data, 0, sizeof(struct it87_sio_data));
@@ -1823,7 +1834,7 @@ static int __init sm_it87_init(void)
 		return err;
 
 	err = it87_device_add(isa_address, &sio_data);
-	if (err){
+	if (err) {
 		platform_driver_unregister(&it87_driver);
 		return err;
 	}
@@ -1844,7 +1855,8 @@ MODULE_DESCRIPTION("IT8705F/8712F/8716F/
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
 module_param(fix_pwm_polarity, bool, 0);
-MODULE_PARM_DESC(fix_pwm_polarity, "Force PWM polarity to active high (DANGEROUS)");
+MODULE_PARM_DESC(fix_pwm_polarity,
+		 "Force PWM polarity to active high (DANGEROUS)");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
