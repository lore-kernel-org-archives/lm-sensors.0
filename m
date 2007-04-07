From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 19:01:12 +0000
Subject: [lm-sensors] [PATCH 1/5] w83781d: No longer use i2c-isa
Message-Id: <20070407210112.c2eb6b75.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reimplement the ISA device support as a platform driver, so that we no
longer rely on i2c-isa.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig   |    1 
 drivers/hwmon/w83781d.c |  571 +++++++++++++++++++++++++++++++----------------
 2 files changed, 377 insertions(+), 195 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/Kconfig	2007-04-07 15:23:44.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/Kconfig	2007-04-07 15:23:44.000000000 +0200
@@ -523,7 +523,6 @@ config SENSORS_VT8231
 config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
-	select I2C_ISA
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W8378x series
--- linux-2.6.21-rc6.orig/drivers/hwmon/w83781d.c	2007-04-04 18:01:43.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/w83781d.c	2007-04-07 15:26:44.000000000 +0200
@@ -2,8 +2,9 @@
     w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
                 monitoring
     Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    and Mark Studebaker <mdsxyz123@yahoo.com>
+                               Philip Edelbrock <phil@netroedge.com>,
+                               and Mark Studebaker <mdsxyz123@yahoo.com>
+    Copyright (c) 2007         Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -38,7 +39,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/sysfs.h>
@@ -47,6 +49,9 @@
 #include <asm/io.h>
 #include "lm75.h"
 
+/* ISA device, if found */
+static struct platform_device *pdev;
+
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
 					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
@@ -221,8 +226,8 @@ DIV_TO_REG(long val, enum chips type)
    a bit - except if there could be more than one SMBus. Groan. No solution
    for this yet. */
 
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
+   the driver field to differentiate between I2C and ISA chips. */
 struct w83781d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
@@ -263,14 +268,16 @@ struct w83781d_data {
 };
 
 static int w83781d_attach_adapter(struct i2c_adapter *adapter);
-static int w83781d_isa_attach_adapter(struct i2c_adapter *adapter);
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
+static int __devinit w83781d_isa_probe(struct platform_device *pdev);
+static int __devexit w83781d_isa_remove(struct platform_device *pdev);
+
 static int w83781d_read_value(struct i2c_client *client, u16 reg);
 static int w83781d_write_value(struct i2c_client *client, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
-static void w83781d_init_client(struct i2c_client *client);
+static void w83781d_init_device(struct device *dev);
 
 static struct i2c_driver w83781d_driver = {
 	.driver = {
@@ -281,13 +288,13 @@ static struct i2c_driver w83781d_driver 
 	.detach_client = w83781d_detach_client,
 };
 
-static struct i2c_driver w83781d_isa_driver = {
+static struct platform_driver w83781d_isa_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
-		.name = "w83781d-isa",
+		.name = "w83781d",
 	},
-	.attach_adapter = w83781d_isa_attach_adapter,
-	.detach_client = w83781d_detach_client,
+	.probe = w83781d_isa_probe,
+	.remove = w83781d_isa_remove,
 };
 
 
@@ -305,8 +312,8 @@ show_in_reg(in_max);
 #define store_in_reg(REG, reg) \
 static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
+	struct w83781d_data *data = dev_get_drvdata(dev); \
+	struct i2c_client *client = &data->client; \
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10) / 10; \
@@ -368,8 +375,8 @@ show_fan_reg(fan_min);
 static ssize_t
 store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -427,8 +434,8 @@ show_temp_reg(temp_max_hyst);
 #define store_temp_reg(REG, reg) \
 static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct w83781d_data *data = i2c_get_clientdata(client); \
+	struct w83781d_data *data = dev_get_drvdata(dev); \
+	struct i2c_client *client = &data->client; \
 	s32 val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
@@ -498,8 +505,7 @@ show_vrm_reg(struct device *dev, struct 
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -539,8 +545,8 @@ static ssize_t
 store_beep_reg(struct device *dev, const char *buf, size_t count,
 	       int update_mask)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	u32 val, val2;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -599,8 +605,8 @@ show_fan_div_reg(struct device *dev, cha
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	unsigned long min;
 	u8 reg;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -666,8 +672,8 @@ show_pwmenable_reg(struct device *dev, c
 static ssize_t
 store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -682,8 +688,8 @@ store_pwm_reg(struct device *dev, const 
 static ssize_t
 store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	u32 val, reg;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -755,8 +761,8 @@ show_sensor_reg(struct device *dev, char
 static ssize_t
 store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	u32 val, tmp;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -813,6 +819,16 @@ sysfs_sensor(1);
 sysfs_sensor(2);
 sysfs_sensor(3);
 
+/* I2C devices get this name attribute automatically, but for ISA devices
+   we must create it by ourselves. */
+static ssize_t
+show_name(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->client.name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -825,12 +841,6 @@ w83781d_attach_adapter(struct i2c_adapte
 	return i2c_probe(adapter, &addr_data, w83781d_detect);
 }
 
-static int
-w83781d_isa_attach_adapter(struct i2c_adapter *adapter)
-{
-	return w83781d_detect(adapter, isa_address, -1);
-}
-
 /* Assumes that adapter is of I2C, not ISA variety.
  * OTHERWISE DON'T CALL THIS
  */
@@ -994,77 +1004,85 @@ static const struct attribute_group w837
 	.attrs = w83781d_attributes_opt,
 };
 
+/* No clean up is done on error, it's up to the caller */
 static int
-w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
+w83781d_create_files(struct device *dev, int kind, int is_isa)
 {
-	int i = 0, val1 = 0, val2;
-	struct i2c_client *client;
-	struct device *dev;
-	struct w83781d_data *data;
 	int err;
-	const char *client_name = "";
-	int is_isa = i2c_is_isa_adapter(adapter);
-	enum vendor { winbond, asus } vendid;
 
-	if (!is_isa
-	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		err = -EINVAL;
-		goto ERROR0;
+	if ((err = sysfs_create_group(&dev->kobj, &w83781d_group)))
+		return err;
+
+	if (kind != w83783s) {
+		if ((err = device_create_file(dev, &dev_attr_in1_input))
+		    || (err = device_create_file(dev, &dev_attr_in1_min))
+		    || (err = device_create_file(dev, &dev_attr_in1_max)))
+			return err;
+	}
+	if (kind != as99127f && kind != w83781d && kind != w83783s) {
+		if ((err = device_create_file(dev, &dev_attr_in7_input))
+		    || (err = device_create_file(dev, &dev_attr_in7_min))
+		    || (err = device_create_file(dev, &dev_attr_in7_max))
+		    || (err = device_create_file(dev, &dev_attr_in8_input))
+		    || (err = device_create_file(dev, &dev_attr_in8_min))
+		    || (err = device_create_file(dev, &dev_attr_in8_max)))
+			return err;
+	}
+	if (kind != w83783s) {
+		if ((err = device_create_file(dev, &dev_attr_temp3_input))
+		    || (err = device_create_file(dev, &dev_attr_temp3_max))
+		    || (err = device_create_file(dev,
+						 &dev_attr_temp3_max_hyst)))
+			return err;
 	}
 
-	/* Prevent users from forcing a kind for a bus it isn't supposed
-	   to possibly be on */
-	if (is_isa && (kind = as99127f || kind = w83783s)) {
-		dev_err(&adapter->dev,
-			"Cannot force I2C-only chip for ISA address 0x%02x.\n",
-			address);
-		err = -EINVAL;
-		goto ERROR0;
+	if (kind != w83781d && kind != as99127f) {
+		if ((err = device_create_file(dev, &dev_attr_pwm1))
+		    || (err = device_create_file(dev, &dev_attr_pwm2))
+		    || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
+			return err;
 	}
-	
-	if (is_isa)
-		if (!request_region(address, W83781D_EXTENT,
-				    w83781d_isa_driver.driver.name)) {
-			dev_dbg(&adapter->dev, "Request of region "
-				"0x%x-0x%x for w83781d failed\n", address,
-				address + W83781D_EXTENT - 1);
-			err = -EBUSY;
-			goto ERROR0;
+	if (kind = w83782d && !is_isa) {
+		if ((err = device_create_file(dev, &dev_attr_pwm3))
+		    || (err = device_create_file(dev, &dev_attr_pwm4)))
+			return err;
+	}
+
+	if (kind != as99127f && kind != w83781d) {
+		if ((err = device_create_file(dev, &dev_attr_temp1_type))
+		    || (err = device_create_file(dev,
+						 &dev_attr_temp2_type)))
+			return err;
+		if (kind != w83783s) {
+			if ((err = device_create_file(dev,
+						      &dev_attr_temp3_type)))
+				return err;
 		}
+	}
 
-	/* Probe whether there is anything available on this address. Already
-	   done for SMBus clients */
-	if (kind < 0) {
-		if (is_isa) {
+	if (is_isa) {
+		err = device_create_file(&pdev->dev, &dev_attr_name);
+		if (err)
+			return err;
+	}
 
-#define REALLY_SLOW_IO
-			/* We need the timeouts for at least some LM78-like
-			   chips. But only if we read 'undefined' registers. */
-			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i
-			 || inb_p(address + 3) != i
-			 || inb_p(address + 7) != i) {
-				dev_dbg(&adapter->dev, "Detection of w83781d "
-					"chip failed at step 1\n");
-				err = -ENODEV;
-				goto ERROR1;
-			}
-#undef REALLY_SLOW_IO
+	return 0;
+}
 
-			/* Let's just hope nothing breaks here */
-			i = inb_p(address + 5) & 0x7f;
-			outb_p(~i & 0x7f, address + 5);
-			val2 = inb_p(address + 5) & 0x7f;
-			if (val2 != (~i & 0x7f)) {
-				outb_p(i, address + 5);
-				dev_dbg(&adapter->dev, "Detection of w83781d "
-					"chip failed at step 2 (0x%x != "
-					"0x%x at 0x%x)\n", val2, ~i & 0x7f,
-					address + 5);
-				err = -ENODEV;
-				goto ERROR1;
-			}
-		}
+static int
+w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int val1 = 0, val2;
+	struct i2c_client *client;
+	struct device *dev;
+	struct w83781d_data *data;
+	int err;
+	const char *client_name = "";
+	enum vendor { winbond, asus } vendid;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		err = -EINVAL;
+		goto ERROR1;
 	}
 
 	/* OK. For now, we presume we have a valid client. We now create the
@@ -1081,8 +1099,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	client->addr = address;
 	mutex_init(&data->lock);
 	client->adapter = adapter;
-	client->driver = is_isa ? &w83781d_isa_driver : &w83781d_driver;
-	client->flags = 0;
+	client->driver = &w83781d_driver;
 	dev = &client->dev;
 
 	/* Now, we do the remaining detection. */
@@ -1111,8 +1128,8 @@ w83781d_detect(struct i2c_adapter *adapt
 		}
 		/* If Winbond SMBus, check address at 0x48.
 		   Asus doesn't support, except for as99127f rev.2 */
-		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 = 0xa3)) ||
-				  ((val1 & 0x80) && (val2 = 0x5c)))) {
+		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
+		    ((val1 & 0x80) && (val2 = 0x5c))) {
 			if (w83781d_read_value
 			    (client, W83781D_REG_I2C_ADDR) != address) {
 				dev_dbg(&adapter->dev, "Detection of w83781d "
@@ -1149,12 +1166,11 @@ w83781d_detect(struct i2c_adapter *adapt
 			kind = w83781d;
 		else if (val1 = 0x30 && vendid = winbond)
 			kind = w83782d;
-		else if (val1 = 0x40 && vendid = winbond && !is_isa
-				&& address = 0x2d)
+		else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
 			kind = w83783s;
 		else if (val1 = 0x21 && vendid = winbond)
 			kind = w83627hf;
-		else if (val1 = 0x31 && !is_isa && address >= 0x28)
+		else if (val1 = 0x31 && address >= 0x28)
 			kind = as99127f;
 		else {
 			if (kind = 0)
@@ -1182,86 +1198,23 @@ w83781d_detect(struct i2c_adapter *adapt
 	strlcpy(client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 
-	data->valid = 0;
-	mutex_init(&data->update_lock);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(client)))
 		goto ERROR2;
 
 	/* attach secondary i2c lm75-like clients */
-	if (!is_isa) {
-		if ((err = w83781d_detect_subclients(adapter, address,
-				kind, client)))
-			goto ERROR3;
-	} else {
-		data->lm75[0] = NULL;
-		data->lm75[1] = NULL;
-	}
+	if ((err = w83781d_detect_subclients(adapter, address,
+			kind, client)))
+		goto ERROR3;
 
 	/* Initialize the chip */
-	w83781d_init_client(client);
-
-	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 3; i++) {
-		data->fan_min[i - 1] = w83781d_read_value(client,
-					W83781D_REG_FAN_MIN(i));
-	}
-	if (kind != w83781d && kind != as99127f)
-		for (i = 0; i < 4; i++)
-			data->pwmenable[i] = 1;
+	w83781d_init_device(dev);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&dev->kobj, &w83781d_group)))
+	err = w83781d_create_files(dev, kind, 0);
+	if (err)
 		goto ERROR4;
 
-	if (kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_in1_input))
-		    || (err = device_create_file(dev, &dev_attr_in1_min))
-		    || (err = device_create_file(dev, &dev_attr_in1_max)))
-			goto ERROR4;
-	}
-	if (kind != as99127f && kind != w83781d && kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_in7_input))
-		    || (err = device_create_file(dev, &dev_attr_in7_min))
-		    || (err = device_create_file(dev, &dev_attr_in7_max))
-		    || (err = device_create_file(dev, &dev_attr_in8_input))
-		    || (err = device_create_file(dev, &dev_attr_in8_min))
-		    || (err = device_create_file(dev, &dev_attr_in8_max)))
-			goto ERROR4;
-	}
-	if (kind != w83783s) {
-		if ((err = device_create_file(dev, &dev_attr_temp3_input))
-		    || (err = device_create_file(dev, &dev_attr_temp3_max))
-		    || (err = device_create_file(dev,
-						 &dev_attr_temp3_max_hyst)))
-			goto ERROR4;
-	}
-
-	if (kind != w83781d && kind != as99127f) {
-		if ((err = device_create_file(dev, &dev_attr_pwm1))
-		    || (err = device_create_file(dev, &dev_attr_pwm2))
-		    || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
-			goto ERROR4;
-	}
-	if (kind = w83782d && !is_isa) {
-		if ((err = device_create_file(dev, &dev_attr_pwm3))
-		    || (err = device_create_file(dev, &dev_attr_pwm4)))
-			goto ERROR4;
-	}
-
-	if (kind != as99127f && kind != w83781d) {
-		if ((err = device_create_file(dev, &dev_attr_temp1_type))
-		    || (err = device_create_file(dev,
-						 &dev_attr_temp2_type)))
-			goto ERROR4;
-		if (kind != w83783s) {
-			if ((err = device_create_file(dev,
-						      &dev_attr_temp3_type)))
-				goto ERROR4;
-		}
-	}
-
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
@@ -1287,9 +1240,6 @@ ERROR3:
 ERROR2:
 	kfree(data);
 ERROR1:
-	if (is_isa)
-		release_region(address, W83781D_EXTENT);
-ERROR0:
 	return err;
 }
 
@@ -1305,8 +1255,6 @@ w83781d_detach_client(struct i2c_client 
 		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
 		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
 	}
-	if (i2c_is_isa_client(client))
-		release_region(client->addr, W83781D_EXTENT);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
@@ -1322,6 +1270,88 @@ w83781d_detach_client(struct i2c_client 
 	return 0;
 }
 
+static int __devinit
+w83781d_isa_probe(struct platform_device *pdev)
+{
+	int err, reg;
+	struct w83781d_data *data;
+	struct resource *res;
+	const char *name;
+
+	/* Reserve the ISA region */
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, W83781D_EXTENT, "w83781d")) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_release_region;
+	}
+	mutex_init(&data->lock);
+	data->client.addr = res->start;
+	i2c_set_clientdata(&data->client, data);
+	platform_set_drvdata(pdev, data);
+
+	reg = w83781d_read_value(&data->client, W83781D_REG_WCHIPID);
+	switch (reg) {
+	case 0x21:
+		data->type = w83627hf;
+		name = "w83627hf";
+		break;
+	case 0x30:
+		data->type = w83782d;
+		name = "w83782d";
+		break;
+	default:
+		data->type = w83781d;
+		name = "w83781d";
+	}
+	strlcpy(data->client.name, name, I2C_NAME_SIZE);
+
+	/* Initialize the W83781D chip */
+	w83781d_init_device(&pdev->dev);
+
+	/* Register sysfs hooks */
+	err = w83781d_create_files(&pdev->dev, data->type, 1);
+	if (err)
+		goto exit_remove_files;
+
+	data->class_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_remove_files;
+	}
+
+	return 0;
+
+ exit_remove_files:
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	kfree(data);
+ exit_release_region:
+	release_region(res->start, W83781D_EXTENT);
+ exit:
+	return err;
+}
+
+static int __devexit
+w83781d_isa_remove(struct platform_device *pdev)
+{
+	struct w83781d_data *data = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	release_region(data->client.addr, W83781D_EXTENT);
+ 	kfree(data);
+
+ 	return 0;
+}
+
 /* The SMBus locks itself, usually, but nothing may access the Winbond between
    bank switches. ISA access must always be locked explicitly! 
    We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
@@ -1336,7 +1366,7 @@ w83781d_read_value(struct i2c_client *cl
 	struct i2c_client *cl;
 
 	mutex_lock(&data->lock);
-	if (i2c_is_isa_client(client)) {
+	if (!client->driver) { /* ISA device */
 		word_sized = (((reg & 0xff00) = 0x100)
 			      || ((reg & 0xff00) = 0x200))
 		    && (((reg & 0x00ff) = 0x50)
@@ -1405,7 +1435,7 @@ w83781d_write_value(struct i2c_client *c
 	struct i2c_client *cl;
 
 	mutex_lock(&data->lock);
-	if (i2c_is_isa_client(client)) {
+	if (!client->driver) { /* ISA device */
 		word_sized = (((reg & 0xff00) = 0x100)
 			      || ((reg & 0xff00) = 0x200))
 		    && (((reg & 0x00ff) = 0x53)
@@ -1462,9 +1492,10 @@ w83781d_write_value(struct i2c_client *c
 }
 
 static void
-w83781d_init_client(struct i2c_client *client)
+w83781d_init_device(struct device *dev)
 {
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	int i, p;
 	int type = data->type;
 	u8 tmp;
@@ -1477,7 +1508,7 @@ w83781d_init_client(struct i2c_client *c
 		   It might even go away if nobody reports it as being useful,
 		   as I see very little reason why this would be needed at
 		   all. */
-		dev_info(&client->dev, "If reset=1 solved a problem you were "
+		dev_info(dev, "If reset=1 solved a problem you were "
 			 "having, please report!\n");
 
 		/* save these registers */
@@ -1527,7 +1558,7 @@ w83781d_init_client(struct i2c_client *c
 		/* Enable temp2 */
 		tmp = w83781d_read_value(client, W83781D_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
-			dev_warn(&client->dev, "Enabling temp2, readings "
+			dev_warn(dev, "Enabling temp2, readings "
 				 "might not make sense\n");
 			w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
@@ -1538,7 +1569,7 @@ w83781d_init_client(struct i2c_client *c
 			tmp = w83781d_read_value(client,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
-				dev_warn(&client->dev, "Enabling temp3, "
+				dev_warn(dev, "Enabling temp3, "
 					 "readings might not make sense\n");
 				w83781d_write_value(client,
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
@@ -1551,12 +1582,23 @@ w83781d_init_client(struct i2c_client *c
 			    (w83781d_read_value(client,
 						W83781D_REG_CONFIG) & 0xf7)
 			    | 0x01);
+
+	/* A few vars need to be filled upon startup */
+	for (i = 1; i <= 3; i++) {
+		data->fan_min[i - 1] = w83781d_read_value(client,
+					W83781D_REG_FAN_MIN(i));
+	}
+	if (type != w83781d && type != as99127f)
+		for (i = 0; i < 4; i++)
+			data->pwmenable[i] = 1;
+
+	mutex_init(&data->update_lock);
 }
 
 static struct w83781d_data *w83781d_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct w83781d_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -1589,8 +1631,7 @@ static struct w83781d_data *w83781d_upda
 				data->pwm[i - 1]  				    w83781d_read_value(client,
 						       W83781D_REG_PWM(i));
-				if ((data->type != w83782d
-				     || i2c_is_isa_client(client))
+				if ((data->type != w83782d || !client->driver)
 				    && i = 2)
 					break;
 			}
@@ -1672,6 +1713,133 @@ static struct w83781d_data *w83781d_upda
 	return data;
 }
 
+/* return 1 if a supported chip is found, 0 otherwise */
+static int __init
+w83781d_isa_found(unsigned short address)
+{
+	int val, save, found = 0;
+
+	if (!request_region(address, W83781D_EXTENT, "w83781d"))
+		return 0;
+
+#define REALLY_SLOW_IO
+	/* We need the timeouts for at least some W83781D-like
+	   chips. But only if we read 'undefined' registers. */
+	val = inb_p(address + 1);
+	if (inb_p(address + 2) != val
+	 || inb_p(address + 3) != val
+	 || inb_p(address + 7) != val) {
+	 	pr_debug("w83781d: Detection failed at step 1\n");
+	 	goto release;
+	}
+#undef REALLY_SLOW_IO
+
+	/* We should be able to change the 7 LSB of the address port. The
+	   MSB (busy flag) should be clear initially, set after the write. */
+	save = inb_p(address + W83781D_ADDR_REG_OFFSET);
+	if (save & 0x80) {
+	 	pr_debug("w83781d: Detection failed at step 2\n");
+		goto release;
+	}
+	val = ~save & 0x7f;
+	outb_p(val, address + W83781D_ADDR_REG_OFFSET);
+	if (inb_p(address + W83781D_ADDR_REG_OFFSET) != (val | 0x80)) {
+		outb_p(save, address + W83781D_ADDR_REG_OFFSET);
+	 	pr_debug("w83781d: Detection failed at step 3\n");
+		goto release;
+	}
+
+	/* We found a device, now see if it could be a W83781D */
+	outb_p(W83781D_REG_CONFIG, address + W83781D_ADDR_REG_OFFSET);
+	val = inb_p(address + W83781D_DATA_REG_OFFSET);
+	if (val & 0x80) {
+	 	pr_debug("w83781d: Detection failed at step 4\n");
+		goto release;
+	}
+	outb_p(W83781D_REG_BANK, address + W83781D_ADDR_REG_OFFSET);
+	save = inb_p(address + W83781D_DATA_REG_OFFSET);
+	outb_p(W83781D_REG_CHIPMAN, address + W83781D_ADDR_REG_OFFSET);
+	val = inb_p(address + W83781D_DATA_REG_OFFSET);
+	if ((!(save & 0x80) && (val != 0xa3))
+	 || ((save & 0x80) && (val != 0x5c))) {
+	 	pr_debug("w83781d: Detection failed at step 5\n");
+		goto release;
+	}
+	outb_p(W83781D_REG_I2C_ADDR, address + W83781D_ADDR_REG_OFFSET);
+	val = inb_p(address + W83781D_DATA_REG_OFFSET);
+	if (val < 0x03 || val > 0x77) {	/* Not a valid I2C address */
+	 	pr_debug("w83781d: Detection failed at step 6\n");
+		goto release;
+	}
+
+	/* The busy flag should be clear again */
+	if (inb_p(address + W83781D_ADDR_REG_OFFSET) & 0x80) {
+	 	pr_debug("w83781d: Detection failed at step 7\n");
+		goto release;
+	}
+
+	/* Determine the chip type */
+	outb_p(W83781D_REG_BANK, address + W83781D_ADDR_REG_OFFSET);
+	save = inb_p(address + W83781D_DATA_REG_OFFSET);
+	outb_p(save & 0xf8, address + W83781D_DATA_REG_OFFSET);
+	outb_p(W83781D_REG_WCHIPID, address + W83781D_ADDR_REG_OFFSET);
+	val = inb_p(address + W83781D_DATA_REG_OFFSET);
+	if ((val & 0xfe) = 0x10	/* W83781D */
+	 || val = 0x30			/* W83782D */
+	 || val = 0x21)		/* W83627HF */
+		found = 1;
+
+	if (found)
+		pr_info("w83781d: Found a %s chip at %#x\n",
+			val = 0x21 ? "W83627HF" :
+			val = 0x30 ? "W83782D" : "W83781D", (int)address);
+
+ release:
+	release_region(address, W83781D_EXTENT);
+	return found;
+}
+
+static int __init
+w83781d_isa_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + W83781D_EXTENT,
+		.name	= "w83781d",
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc("w83781d", address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "w83781d: Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR "w83781d: Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR "w83781d: Device addition failed (%d)\n",
+		       err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+ exit_device_put:
+	platform_device_put(pdev);
+ exit:
+	pdev = NULL;
+	return err;
+}
+
 static int __init
 sensors_w83781d_init(void)
 {
@@ -1679,21 +1847,36 @@ sensors_w83781d_init(void)
 
 	res = i2c_add_driver(&w83781d_driver);
 	if (res)
-		return res;
+		goto exit;
 
-	/* Don't exit if this one fails, we still want the I2C variants
-	   to work! */
-	if (i2c_isa_add_driver(&w83781d_isa_driver))
-		isa_address = 0;
+	if (w83781d_isa_found(isa_address)) {
+		res = platform_driver_register(&w83781d_isa_driver);
+		if (res)
+			goto exit_unreg_i2c_driver;
+
+		/* Sets global pdev as a side effect */
+		res = w83781d_isa_device_add(isa_address);
+		if (res)
+			goto exit_unreg_isa_driver;
+	}
 
 	return 0;
+
+ exit_unreg_isa_driver:
+	platform_driver_unregister(&w83781d_isa_driver);
+ exit_unreg_i2c_driver:
+	i2c_del_driver(&w83781d_driver);
+ exit:
+	return res;
 }
 
 static void __exit
 sensors_w83781d_exit(void)
 {
-	if (isa_address)
-		i2c_isa_del_driver(&w83781d_isa_driver);
+	if (pdev) {
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&w83781d_isa_driver);
+	}
 	i2c_del_driver(&w83781d_driver);
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
