From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 09:01:54 +0000
Subject: [lm-sensors] [PATCH] w83627hf: Convert to a platform driver
Message-Id: <20070311100154.89c57cb0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert the w83627hf driver from the nonsensical i2c-isa hack to a
regular platform driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/Kconfig    |    3 -
 drivers/hwmon/w83627hf.c |  591 ++++++++++++++++++++++++----------------------
 2 files changed, 311 insertions(+), 283 deletions(-)

--- linux-2.6.21-rc3.orig/drivers/hwmon/Kconfig	2007-03-11 08:46:27.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/Kconfig	2007-03-11 08:46:31.000000000 +0100
@@ -549,8 +549,7 @@ config SENSORS_W83L785TS
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
-	depends on HWMON && I2C
-	select I2C_ISA
+	depends on HWMON
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
--- linux-2.6.21-rc3.orig/drivers/hwmon/w83627hf.c	2007-03-11 08:46:29.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/w83627hf.c	2007-03-11 09:35:14.000000000 +0100
@@ -5,6 +5,7 @@
     Philip Edelbrock <phil at netroedge.com>,
     and Mark Studebaker <mdsxyz123 at yahoo.com>
     Ported to 2.6 by Bernhard C. Schrenk <clemy at clemy.org>
+    Copyright (c) 2007  Jean Delvare <khali at linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -42,8 +43,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
@@ -52,8 +52,7 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-/* The actual ISA address is read from Super-I/O configuration space */
-static unsigned short address;
+static struct platform_device *pdev;
 
 #define DRVNAME "w83627hf"
 enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
@@ -157,9 +156,9 @@ superio_exit(void)
 #define WINB_REGION_OFFSET	5
 #define WINB_REGION_SIZE	2
 
-/* Where are the sensors address/data registers relative to the base address */
-#define W83781D_ADDR_REG_OFFSET 5
-#define W83781D_DATA_REG_OFFSET 6
+/* Where are the sensors address/data registers relative to the region offset */
+#define W83781D_ADDR_REG_OFFSET 0
+#define W83781D_DATA_REG_OFFSET 1
 
 /* The W83781D registers */
 /* The W83782D registers for nr=7,8 are in bank 5 */
@@ -290,7 +289,8 @@ static inline u8 DIV_TO_REG(long val)
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct w83627hf_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
 	struct class_device *class_dev;
 	struct mutex lock;
 	enum chips type;
@@ -325,22 +325,26 @@ struct w83627hf_data {
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
 
+struct w83627hf_sio_data {
+	enum chips type;
+};
 
-static int w83627hf_detect(struct i2c_adapter *adapter);
-static int w83627hf_detach_client(struct i2c_client *client);
 
-static int w83627hf_read_value(struct i2c_client *client, u16 reg);
-static int w83627hf_write_value(struct i2c_client *client, u16 reg, u16 value);
+static int w83627hf_probe(struct platform_device *pdev);
+static int w83627hf_remove(struct platform_device *pdev);
+
+static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
+static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
 static struct w83627hf_data *w83627hf_update_device(struct device *dev);
-static void w83627hf_init_client(struct i2c_client *client);
+static void w83627hf_init_device(struct platform_device *pdev);
 
-static struct i2c_driver w83627hf_driver = {
+static struct platform_driver w83627hf_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRVNAME,
 	},
-	.attach_adapter	= w83627hf_detect,
-	.detach_client	= w83627hf_detach_client,
+	.probe		= w83627hf_probe,
+	.remove		= __devexit_p(w83627hf_remove),
 };
 
 /* following are the sysfs callback functions */
@@ -358,15 +362,14 @@ show_in_reg(in_max)
 static ssize_t \
 store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
+	struct w83627hf_data *data = dev_get_drvdata(dev); \
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
 	 \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
-	w83627hf_write_value(client, W83781D_REG_IN_##REG(nr), \
+	w83627hf_write_value(data, W83781D_REG_IN_##REG(nr), \
 			    data->in_##reg[nr]); \
 	 \
 	mutex_unlock(&data->update_lock); \
@@ -450,8 +453,7 @@ static ssize_t show_regs_in_max0(struct 
 static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -470,7 +472,7 @@ static ssize_t store_regs_in_min0(struct
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
 
-	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	w83627hf_write_value(data, W83781D_REG_IN_MIN(0), data->in_min[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -478,8 +480,7 @@ static ssize_t store_regs_in_min0(struct
 static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -498,7 +499,7 @@ static ssize_t store_regs_in_max0(struct
 		/* use VRM8 (standard) calculation */
 		data->in_max[0] = IN_TO_REG(val);
 
-	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	w83627hf_write_value(data, W83781D_REG_IN_MAX(0), data->in_max[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -523,8 +524,7 @@ show_fan_reg(fan_min);
 static ssize_t
 store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -532,7 +532,7 @@ store_fan_min(struct device *dev, const 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
-	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr),
+	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
 	mutex_unlock(&data->update_lock);
@@ -585,8 +585,7 @@ show_temp_reg(temp_max_hyst);
 static ssize_t \
 store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83627hf_data *data = i2c_get_clientdata(client); \
+	struct w83627hf_data *data = dev_get_drvdata(dev); \
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
@@ -595,11 +594,11 @@ store_temp_##reg (struct device *dev, co
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
-		w83627hf_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+		w83627hf_write_value(data, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \
 	} else {	/* TEMP1 */ \
 		data->temp_##reg = TEMP_TO_REG(val); \
-		w83627hf_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+		w83627hf_write_value(data, W83781D_REG_TEMP_##REG(nr), \
 			data->temp_##reg); \
 	} \
 	 \
@@ -657,8 +656,7 @@ show_vrm_reg(struct device *dev, struct 
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -693,8 +691,7 @@ static ssize_t
 store_beep_reg(struct device *dev, const char *buf, size_t count,
 	       int update_mask)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val, val2;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -703,18 +700,18 @@ store_beep_reg(struct device *dev, const
 
 	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val);
-		w83627hf_write_value(client, W83781D_REG_BEEP_INTS1,
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS1,
 				    data->beep_mask & 0xff);
-		w83627hf_write_value(client, W83781D_REG_BEEP_INTS3,
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS3,
 				    ((data->beep_mask) >> 16) & 0xff);
 		val2 = (data->beep_mask >> 8) & 0x7f;
 	} else {		/* We are storing beep_enable */
 		val2 -		    w83627hf_read_value(client, W83781D_REG_BEEP_INTS2) & 0x7f;
+		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
 		data->beep_enable = BEEP_ENABLE_TO_REG(val);
 	}
 
-	w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
+	w83627hf_write_value(data, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
 	mutex_unlock(&data->update_lock);
@@ -752,8 +749,7 @@ show_fan_div_reg(struct device *dev, cha
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long min;
 	u8 reg;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -766,19 +762,19 @@ store_fan_div_reg(struct device *dev, co
 
 	data->fan_div[nr] = DIV_TO_REG(val);
 
-	reg = (w83627hf_read_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+	reg = (w83627hf_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
 	       & (nr=0 ? 0xcf : 0x3f))
 	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
-	w83627hf_write_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
+	w83627hf_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
 
-	reg = (w83627hf_read_value(client, W83781D_REG_VBAT)
+	reg = (w83627hf_read_value(data, W83781D_REG_VBAT)
 	       & ~(1 << (5 + nr)))
 	    | ((data->fan_div[nr] & 0x04) << (3 + nr));
-	w83627hf_write_value(client, W83781D_REG_VBAT, reg);
+	w83627hf_write_value(data, W83781D_REG_VBAT, reg);
 
 	/* Restore fan_min */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -812,8 +808,7 @@ show_pwm_reg(struct device *dev, char *b
 static ssize_t
 store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -823,14 +818,14 @@ store_pwm_reg(struct device *dev, const 
 	if (data->type = w83627thf) {
 		/* bits 0-3 are reserved  in 627THF */
 		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
-		w83627hf_write_value(client,
+		w83627hf_write_value(data,
 				     W836X7HF_REG_PWM(data->type, nr),
 				     data->pwm[nr - 1] |
-				     (w83627hf_read_value(client,
+				     (w83627hf_read_value(data,
 				     W836X7HF_REG_PWM(data->type, nr)) & 0x0f));
 	} else {
 		data->pwm[nr - 1] = PWM_TO_REG(val);
-		w83627hf_write_value(client,
+		w83627hf_write_value(data,
 				     W836X7HF_REG_PWM(data->type, nr),
 				     data->pwm[nr - 1]);
 	}
@@ -866,8 +861,7 @@ show_sensor_reg(struct device *dev, char
 static ssize_t
 store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	u32 val, tmp;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -876,31 +870,31 @@ store_sensor_reg(struct device *dev, con
 
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
-		tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
-		w83627hf_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
+		w83627hf_write_value(data, W83781D_REG_SCFG1,
 				    tmp | BIT_SCFG1[nr - 1]);
-		tmp = w83627hf_read_value(client, W83781D_REG_SCFG2);
-		w83627hf_write_value(client, W83781D_REG_SCFG2,
+		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
+		w83627hf_write_value(data, W83781D_REG_SCFG2,
 				    tmp | BIT_SCFG2[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
 	case 2:		/* 3904 */
-		tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
-		w83627hf_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
+		w83627hf_write_value(data, W83781D_REG_SCFG1,
 				    tmp | BIT_SCFG1[nr - 1]);
-		tmp = w83627hf_read_value(client, W83781D_REG_SCFG2);
-		w83627hf_write_value(client, W83781D_REG_SCFG2,
+		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
+		w83627hf_write_value(data, W83781D_REG_SCFG2,
 				    tmp & ~BIT_SCFG2[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
 	case W83781D_DEFAULT_BETA:	/* thermistor */
-		tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
-		w83627hf_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
+		w83627hf_write_value(data, W83781D_REG_SCFG1,
 				    tmp & ~BIT_SCFG1[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
 	default:
-		dev_err(&client->dev,
+		dev_err(dev,
 		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
 		       (long) val, W83781D_DEFAULT_BETA);
 		break;
@@ -927,21 +921,52 @@ sysfs_sensor(1);
 sysfs_sensor(2);
 sysfs_sensor(3);
 
-static int __init w83627hf_find(int sioaddr, unsigned short *addr)
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static int __init w83627hf_find(int sioaddr, unsigned short *addr,
+				struct w83627hf_sio_data *sio_data)
 {
 	int err = -ENODEV;
 	u16 val;
 
+	static const __initdata char *names[] = {
+		"W83627HF",
+		"W83627THF",
+		"W83697HF",
+		"W83637HF",
+		"W83687THF",
+	};
+
 	REG = sioaddr;
 	VAL = sioaddr + 1;
 
 	superio_enter();
 	val= superio_inb(DEVID);
-	if(val != W627_DEVID &&
-	   val != W627THF_DEVID &&
-	   val != W697_DEVID &&
-	   val != W637_DEVID &&
-	   val != W687THF_DEVID) {
+	switch (val) {
+	case W627_DEVID:
+		sio_data->type = w83627hf;
+		break;
+	case W627THF_DEVID:
+		sio_data->type = w83627thf;
+		break;
+	case W697_DEVID:
+		sio_data->type = w83697hf;
+		break;
+	case W637_DEVID:
+		sio_data->type = w83637hf;
+		break;
+	case W687THF_DEVID:
+		sio_data->type = w83687thf;
+		break;
+	default:
+		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%x)\n", val);
 		goto exit;
 	}
 
@@ -969,6 +994,8 @@ static int __init w83627hf_find(int sioa
 	}
 
 	err = 0;
+	pr_info(DRVNAME ": Found %s chip at %#x\n",
+		names[sio_data->type], *addr);
 
  exit:
 	superio_exit();
@@ -1018,6 +1045,7 @@ static struct attribute *w83627hf_attrib
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm2.attr,
 
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -1054,147 +1082,92 @@ static const struct attribute_group w836
 	.attrs = w83627hf_attributes_opt,
 };
 
-static int w83627hf_detect(struct i2c_adapter *adapter)
+static int __devinit w83627hf_probe(struct platform_device *pdev)
 {
-	int val, kind;
-	struct i2c_client *new_client;
+	struct device *dev = &pdev->dev;
+	struct w83627hf_sio_data *sio_data = dev->platform_data;
 	struct w83627hf_data *data;
-	int err = 0;
-	const char *client_name = "";
+	struct resource *res;
+	int err;
 
-	if (!request_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE,
-	                    w83627hf_driver.driver.name)) {
+	static const char *names[] = {
+		"w83627hf",
+		"w83627thf",
+		"w83697hf",
+		"w83637hf",
+		"w83687thf",
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, WINB_REGION_SIZE, DRVNAME)) {
+		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
+			(unsigned long)res->start,
+			(unsigned long)(res->start + WINB_REGION_SIZE - 1));
 		err = -EBUSY;
 		goto ERROR0;
 	}
 
-	superio_enter();
-	val= superio_inb(DEVID);
-	if(val = W627_DEVID)
-		kind = w83627hf;
-	else if(val = W697_DEVID)
-		kind = w83697hf;
-	else if(val = W627THF_DEVID)
-		kind = w83627thf;
-	else if(val = W637_DEVID)
-		kind = w83637hf;
-	else if (val = W687THF_DEVID)
-		kind = w83687thf;
-	else {
-		dev_info(&adapter->dev,
-			 "Unsupported chip (dev_id=0x%02X).\n", val);
-		goto ERROR1;
-	}
-	superio_exit();
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access w83627hf_{read,write}_value. */
-
 	if (!(data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
+	data->addr = res->start;
+	data->type = sio_data->type;
+	data->name = names[sio_data->type];
 	mutex_init(&data->lock);
-	new_client->adapter = adapter;
-	new_client->driver = &w83627hf_driver;
-	new_client->flags = 0;
-
-
-	if (kind = w83627hf) {
-		client_name = "w83627hf";
-	} else if (kind = w83627thf) {
-		client_name = "w83627thf";
-	} else if (kind = w83697hf) {
-		client_name = "w83697hf";
-	} else if (kind = w83637hf) {
-		client_name = "w83637hf";
-	} else if (kind = w83687thf) {
-		client_name = "w83687thf";
-	}
-
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-	data->type = kind;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto ERROR2;
+	platform_set_drvdata(pdev, data);
 
 	/* Initialize the chip */
-	w83627hf_init_client(new_client);
+	w83627hf_init_device(pdev);
 
 	/* A few vars need to be filled upon startup */
-	data->fan_min[0] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(1));
-	data->fan_min[1] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(2));
-	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
+	data->fan_min[0] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(1));
+	data->fan_min[1] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(2));
+	data->fan_min[2] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(3));
 
 	/* Register common device attributes */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &w83627hf_group)))
+	if ((err = sysfs_create_group(&dev->kobj, &w83627hf_group)))
 		goto ERROR3;
 
 	/* Register chip-specific device attributes */
-	if (kind = w83627hf || kind = w83697hf)
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in5_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_max))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_max)))
+	if (data->type = w83627hf || data->type = w83697hf)
+		if ((err = device_create_file(dev, &dev_attr_in5_input))
+		 || (err = device_create_file(dev, &dev_attr_in5_min))
+		 || (err = device_create_file(dev, &dev_attr_in5_max))
+		 || (err = device_create_file(dev, &dev_attr_in6_input))
+		 || (err = device_create_file(dev, &dev_attr_in6_min))
+		 || (err = device_create_file(dev, &dev_attr_in6_max)))
 			goto ERROR4;
 
-	if (kind != w83697hf)
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in1_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in1_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in1_max))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan3_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan3_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan3_div))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_max))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_max_hyst))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_type)))
+	if (data->type != w83697hf)
+		if ((err = device_create_file(dev, &dev_attr_in1_input))
+		 || (err = device_create_file(dev, &dev_attr_in1_min))
+		 || (err = device_create_file(dev, &dev_attr_in1_max))
+		 || (err = device_create_file(dev, &dev_attr_fan3_input))
+		 || (err = device_create_file(dev, &dev_attr_fan3_min))
+		 || (err = device_create_file(dev, &dev_attr_fan3_div))
+		 || (err = device_create_file(dev, &dev_attr_temp3_input))
+		 || (err = device_create_file(dev, &dev_attr_temp3_max))
+		 || (err = device_create_file(dev, &dev_attr_temp3_max_hyst))
+		 || (err = device_create_file(dev, &dev_attr_temp3_type)))
 			goto ERROR4;
 
-	if (kind != w83697hf && data->vid != 0xff) {
+	if (data->type != w83697hf && data->vid != 0xff) {
 		/* Convert VID to voltage based on VRM */
 		data->vrm = vid_which_vrm();
 
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_cpu0_vid))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_vrm)))
+		if ((err = device_create_file(dev, &dev_attr_cpu0_vid))
+		 || (err = device_create_file(dev, &dev_attr_vrm)))
 			goto ERROR4;
 	}
 
-	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_pwm3)))
+	if (data->type = w83627thf || data->type = w83637hf
+	 || data->type = w83687thf)
+		if ((err = device_create_file(dev, &dev_attr_pwm3)))
 			goto ERROR4;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto ERROR4;
@@ -1203,47 +1176,37 @@ static int w83627hf_detect(struct i2c_ad
 	return 0;
 
       ERROR4:
-	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group);
-	sysfs_remove_group(&new_client->dev.kobj, &w83627hf_group_opt);
+	sysfs_remove_group(&dev->kobj, &w83627hf_group);
+	sysfs_remove_group(&dev->kobj, &w83627hf_group_opt);
       ERROR3:
-	i2c_detach_client(new_client);
-      ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE);
+	release_region(res->start, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
 
-static int w83627hf_detach_client(struct i2c_client *client)
+static int __devexit w83627hf_remove(struct platform_device *pdev)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int err;
+	struct w83627hf_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 
+	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 
-	sysfs_remove_group(&client->dev.kobj, &w83627hf_group);
-	sysfs_remove_group(&client->dev.kobj, &w83627hf_group_opt);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	release_region(client->addr + WINB_REGION_OFFSET, WINB_REGION_SIZE);
+	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group);
+	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group_opt);
 	kfree(data);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, WINB_REGION_SIZE);
+
 	return 0;
 }
 
 
-/*
-   ISA access must always be locked explicitly!
-   We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83781D access and should not be necessary.
-   There are some ugly typecasts here, but the good news is - they should
-   nowhere else be necessary! */
-static int w83627hf_read_value(struct i2c_client *client, u16 reg)
+static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
 	int res, word_sized;
 
 	mutex_lock(&data->lock);
@@ -1254,29 +1217,29 @@ static int w83627hf_read_value(struct i2
 		   || ((reg & 0x00ff) = 0x55));
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(reg >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->addr + W83781D_DATA_REG_OFFSET);
 	}
-	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
-	res = inb_p(client->addr + W83781D_DATA_REG_OFFSET);
+	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
+	res = inb_p(data->addr + W83781D_DATA_REG_OFFSET);
 	if (word_sized) {
 		outb_p((reg & 0xff) + 1,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
 		res -		    (res << 8) + inb_p(client->addr +
+		    (res << 8) + inb_p(data->addr +
 				       W83781D_DATA_REG_OFFSET);
 	}
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
 	}
 	mutex_unlock(&data->lock);
 	return res;
 }
 
-static int w83627thf_read_gpio5(struct i2c_client *client)
+static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 {
 	int res = 0xff, sel;
 
@@ -1285,7 +1248,7 @@ static int w83627thf_read_gpio5(struct i
 
 	/* Make sure these GPIO pins are enabled */
 	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
-		dev_dbg(&client->dev, "GPIO5 disabled, no VID function\n");
+		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
 		goto exit;
 	}
 
@@ -1293,12 +1256,12 @@ static int w83627thf_read_gpio5(struct i
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
 	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
-		dev_dbg(&client->dev, "GPIO5 not configured for VID "
+		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
 			"function\n");
 		goto exit;
 	}
 
-	dev_info(&client->dev, "Reading VID from GPIO5\n");
+	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
 	res = superio_inb(W83627THF_GPIO5_DR) & sel;
 
 exit:
@@ -1306,7 +1269,7 @@ exit:
 	return res;
 }
 
-static int w83687thf_read_vid(struct i2c_client *client)
+static int __devinit w83687thf_read_vid(struct platform_device *pdev)
 {
 	int res = 0xff;
 
@@ -1315,13 +1278,13 @@ static int w83687thf_read_vid(struct i2c
 
 	/* Make sure these GPIO pins are enabled */
 	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
-		dev_dbg(&client->dev, "VID disabled, no VID function\n");
+		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input */
 	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
-		dev_dbg(&client->dev, "VID configured as output, "
+		dev_dbg(&pdev->dev, "VID configured as output, "
 			"no VID function\n");
 		goto exit;
 	}
@@ -1333,9 +1296,8 @@ exit:
 	return res;
 }
 
-static int w83627hf_write_value(struct i2c_client *client, u16 reg, u16 value)
+static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
 	int word_sized;
 
 	mutex_lock(&data->lock);
@@ -1345,31 +1307,31 @@ static int w83627hf_write_value(struct i
 		   || ((reg & 0x00ff) = 0x55));
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(reg >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->addr + W83781D_DATA_REG_OFFSET);
 	}
-	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
 	if (word_sized) {
 		outb_p(value >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->addr + W83781D_DATA_REG_OFFSET);
 		outb_p((reg & 0xff) + 1,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
 	}
 	outb_p(value & 0xff,
-	       client->addr + W83781D_DATA_REG_OFFSET);
+	       data->addr + W83781D_DATA_REG_OFFSET);
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		       data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
 	}
 	mutex_unlock(&data->lock);
 	return 0;
 }
 
-static void w83627hf_init_client(struct i2c_client *client)
+static void __devinit w83627hf_init_device(struct platform_device *pdev)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = platform_get_drvdata(pdev);
 	int i;
 	enum chips type = data->type;
 	u8 tmp;
@@ -1380,53 +1342,53 @@ static void w83627hf_init_client(struct 
 		   speed...) so it is now optional. It might even go away if
 		   nobody reports it as being useful, as I see very little
 		   reason why this would be needed at all. */
-		dev_info(&client->dev, "If reset=1 solved a problem you were "
+		dev_info(&pdev->dev, "If reset=1 solved a problem you were "
 			 "having, please report!\n");
 
 		/* save this register */
-		i = w83627hf_read_value(client, W83781D_REG_BEEP_CONFIG);
+		i = w83627hf_read_value(data, W83781D_REG_BEEP_CONFIG);
 		/* Reset all except Watchdog values and last conversion values
 		   This sets fan-divs to 2, among others */
-		w83627hf_write_value(client, W83781D_REG_CONFIG, 0x80);
+		w83627hf_write_value(data, W83781D_REG_CONFIG, 0x80);
 		/* Restore the register and disable power-on abnormal beep.
 		   This saves FAN 1/2/3 input/output values set by BIOS. */
-		w83627hf_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
+		w83627hf_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
 		/* Disable master beep-enable (reset turns it on).
 		   Individual beeps should be reset to off but for some reason
 		   disabling this bit helps some people not get beeped */
-		w83627hf_write_value(client, W83781D_REG_BEEP_INTS2, 0);
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS2, 0);
 	}
 
 	/* Minimize conflicts with other winbond i2c-only clients...  */
 	/* disable i2c subclients... how to disable main i2c client?? */
 	/* force i2c address to relatively uncommon address */
-	w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
-	w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
+	w83627hf_write_value(data, W83781D_REG_I2C_SUBADDR, 0x89);
+	w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
 
 	/* Read VID only once */
 	if (type = w83627hf || type = w83637hf) {
-		int lo = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
-		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
+		int lo = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
+		int hi = w83627hf_read_value(data, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
 	} else if (type = w83627thf) {
-		data->vid = w83627thf_read_gpio5(client);
+		data->vid = w83627thf_read_gpio5(pdev);
 	} else if (type = w83687thf) {
-		data->vid = w83687thf_read_vid(client);
+		data->vid = w83687thf_read_vid(pdev);
 	}
 
 	/* Read VRM & OVT Config only once */
 	if (type = w83627thf || type = w83637hf || type = w83687thf) {
 		data->vrm_ovt = 
-			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
+			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
 	}
 
-	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
+	tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
 		if (!(tmp & BIT_SCFG1[i - 1])) {
 			data->sens[i - 1] = W83781D_DEFAULT_BETA;
 		} else {
 			if (w83627hf_read_value
-			    (client,
+			    (data,
 			     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
 				data->sens[i - 1] = 1;
 			else
@@ -1438,38 +1400,37 @@ static void w83627hf_init_client(struct 
 
 	if(init) {
 		/* Enable temp2 */
-		tmp = w83627hf_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		tmp = w83627hf_read_value(data, W83781D_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
-			dev_warn(&client->dev, "Enabling temp2, readings "
+			dev_warn(&pdev->dev, "Enabling temp2, readings "
 				 "might not make sense\n");
-			w83627hf_write_value(client, W83781D_REG_TEMP2_CONFIG,
+			w83627hf_write_value(data, W83781D_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
 		}
 
 		/* Enable temp3 */
 		if (type != w83697hf) {
-			tmp = w83627hf_read_value(client,
+			tmp = w83627hf_read_value(data,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
-				dev_warn(&client->dev, "Enabling temp3, "
+				dev_warn(&pdev->dev, "Enabling temp3, "
 					 "readings might not make sense\n");
-				w83627hf_write_value(client,
+				w83627hf_write_value(data,
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
 		}
 	}
 
 	/* Start monitoring */
-	w83627hf_write_value(client, W83781D_REG_CONFIG,
-			    (w83627hf_read_value(client,
+	w83627hf_write_value(data, W83781D_REG_CONFIG,
+			    (w83627hf_read_value(data,
 						W83781D_REG_CONFIG) & 0xf7)
 			    | 0x01);
 }
 
 static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83627hf_data *data = i2c_get_clientdata(client);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -1483,23 +1444,23 @@ static struct w83627hf_data *w83627hf_up
 			    && (i = 5 || i = 6)))
 				continue;
 			data->in[i] -			    w83627hf_read_value(client, W83781D_REG_IN(i));
+			    w83627hf_read_value(data, W83781D_REG_IN(i));
 			data->in_min[i] -			    w83627hf_read_value(client,
+			    w83627hf_read_value(data,
 					       W83781D_REG_IN_MIN(i));
 			data->in_max[i] -			    w83627hf_read_value(client,
+			    w83627hf_read_value(data,
 					       W83781D_REG_IN_MAX(i));
 		}
 		for (i = 1; i <= 3; i++) {
 			data->fan[i - 1] -			    w83627hf_read_value(client, W83781D_REG_FAN(i));
+			    w83627hf_read_value(data, W83781D_REG_FAN(i));
 			data->fan_min[i - 1] -			    w83627hf_read_value(client,
+			    w83627hf_read_value(data,
 					       W83781D_REG_FAN_MIN(i));
 		}
 		for (i = 1; i <= 3; i++) {
-			u8 tmp = w83627hf_read_value(client,
+			u8 tmp = w83627hf_read_value(data,
 				W836X7HF_REG_PWM(data->type, i));
  			/* bits 0-3 are reserved  in 627THF */
  			if (data->type = w83627thf)
@@ -1510,47 +1471,47 @@ static struct w83627hf_data *w83627hf_up
 				break;
 		}
 
-		data->temp = w83627hf_read_value(client, W83781D_REG_TEMP(1));
+		data->temp = w83627hf_read_value(data, W83781D_REG_TEMP(1));
 		data->temp_max -		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER(1));
+		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(1));
 		data->temp_max_hyst -		    w83627hf_read_value(client, W83781D_REG_TEMP_HYST(1));
+		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0] -		    w83627hf_read_value(client, W83781D_REG_TEMP(2));
+		    w83627hf_read_value(data, W83781D_REG_TEMP(2));
 		data->temp_max_add[0] -		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER(2));
+		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0] -		    w83627hf_read_value(client, W83781D_REG_TEMP_HYST(2));
+		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83697hf) {
 			data->temp_add[1] -			  w83627hf_read_value(client, W83781D_REG_TEMP(3));
+			  w83627hf_read_value(data, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] -			  w83627hf_read_value(client, W83781D_REG_TEMP_OVER(3));
+			  w83627hf_read_value(data, W83781D_REG_TEMP_OVER(3));
 			data->temp_max_hyst_add[1] -			  w83627hf_read_value(client, W83781D_REG_TEMP_HYST(3));
+			  w83627hf_read_value(data, W83781D_REG_TEMP_HYST(3));
 		}
 
-		i = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
+		i = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = (i >> 6) & 0x03;
 		if (data->type != w83697hf) {
-			data->fan_div[2] = (w83627hf_read_value(client,
+			data->fan_div[2] = (w83627hf_read_value(data,
 					       W83781D_REG_PIN) >> 6) & 0x03;
 		}
-		i = w83627hf_read_value(client, W83781D_REG_VBAT);
+		i = w83627hf_read_value(data, W83781D_REG_VBAT);
 		data->fan_div[0] |= (i >> 3) & 0x04;
 		data->fan_div[1] |= (i >> 4) & 0x04;
 		if (data->type != w83697hf)
 			data->fan_div[2] |= (i >> 5) & 0x04;
 		data->alarms -		    w83627hf_read_value(client, W83781D_REG_ALARM1) |
-		    (w83627hf_read_value(client, W83781D_REG_ALARM2) << 8) |
-		    (w83627hf_read_value(client, W83781D_REG_ALARM3) << 16);
-		i = w83627hf_read_value(client, W83781D_REG_BEEP_INTS2);
+		    w83627hf_read_value(data, W83781D_REG_ALARM1) |
+		    (w83627hf_read_value(data, W83781D_REG_ALARM2) << 8) |
+		    (w83627hf_read_value(data, W83781D_REG_ALARM3) << 16);
+		i = w83627hf_read_value(data, W83781D_REG_BEEP_INTS2);
 		data->beep_enable = i >> 7;
 		data->beep_mask = ((i & 0x7f) << 8) |
-		    w83627hf_read_value(client, W83781D_REG_BEEP_INTS1) |
-		    w83627hf_read_value(client, W83781D_REG_BEEP_INTS3) << 16;
+		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS1) |
+		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS3) << 16;
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -1560,19 +1521,87 @@ static struct w83627hf_data *w83627hf_up
 	return data;
 }
 
+static int __init w83627hf_device_add(unsigned short address,
+				      const struct w83627hf_sio_data *sio_data)
+{
+	struct resource res = {
+		.start	= address + WINB_REGION_OFFSET,
+		.end	= address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
+		.name	= DRVNAME,
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc(DRVNAME, address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	pdev->dev.platform_data = kmalloc(sizeof(struct w83627hf_sio_data),
+					  GFP_KERNEL);
+	if (!pdev->dev.platform_data) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+	memcpy(pdev->dev.platform_data, sio_data,
+	       sizeof(struct w83627hf_sio_data));
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
+		       err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	return err;
+}
+
 static int __init sensors_w83627hf_init(void)
 {
-	if (w83627hf_find(0x2e, &address)
-	 && w83627hf_find(0x4e, &address)) {
+	int err;
+	unsigned short address;
+	struct w83627hf_sio_data sio_data;
+
+	if (w83627hf_find(0x2e, &address, &sio_data)
+	 && w83627hf_find(0x4e, &address, &sio_data))
 		return -ENODEV;
-	}
 
-	return i2c_isa_add_driver(&w83627hf_driver);
+	err = platform_driver_register(&w83627hf_driver);
+	if (err)
+		goto exit;
+
+	/* Sets global pdev as a side effect */
+	err = w83627hf_device_add(address, &sio_data);
+	if (err)
+		goto exit_driver;
+
+	return 0;
+
+exit_driver:
+	platform_driver_unregister(&w83627hf_driver);
+exit:
+	return err;
 }
 
 static void __exit sensors_w83627hf_exit(void)
 {
-	i2c_isa_del_driver(&w83627hf_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&w83627hf_driver);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol at dds.nl>, "


-- 
Jean Delvare

