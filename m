From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Mar 2007 12:32:31 +0000
Subject: [lm-sensors] [PATCH 1/3] lm78: No longer use i2c-isa
Message-Id: <20070319133231.b2a2a2a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reimplement the ISA device support as a platform driver, so that we no
longer rely on i2c-isa.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/Kconfig |    1 -
 drivers/hwmon/lm78.c  |  377 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 267 insertions(+), 111 deletions(-)

--- linux-2.6.21-rc4.orig/drivers/hwmon/Kconfig	2007-03-19 09:24:35.000000000 +0100
+++ linux-2.6.21-rc4/drivers/hwmon/Kconfig	2007-03-19 09:24:36.000000000 +0100
@@ -291,7 +291,6 @@ config SENSORS_LM77
 config SENSORS_LM78
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C
-	select I2C_ISA
 	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
--- linux-2.6.21-rc4.orig/drivers/hwmon/lm78.c	2007-03-19 09:23:18.000000000 +0100
+++ linux-2.6.21-rc4/drivers/hwmon/lm78.c	2007-03-19 11:23:53.000000000 +0100
@@ -2,6 +2,7 @@
     lm78.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol at dds.nl> 
+    Copyright (c) 2007        Jean Delvare <khali at linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -23,13 +24,17 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
 
+/* ISA device, if found */
+static struct platform_device *pdev;
+
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
 					0x25, 0x26, 0x27, 0x28, 0x29,
@@ -121,12 +126,8 @@ static inline int TEMP_FROM_REG(s8 val)
    a bit - except if there could be more than one SMBus. Groan. No solution
    for this yet. */
 
-/* This module may seem overly long and complicated. In fact, it is not so
-   bad. Quite a lot of bookkeeping is done. A real driver can often cut
-   some corners. */
-
-/* For each registered chip, we need to keep some data in memory.
-   The structure is dynamically allocated. */
+/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
+   the driver field to differentiate between I2C and ISA chips. */
 struct lm78_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
@@ -152,10 +153,12 @@ struct lm78_data {
 
 
 static int lm78_attach_adapter(struct i2c_adapter *adapter);
-static int lm78_isa_attach_adapter(struct i2c_adapter *adapter);
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm78_detach_client(struct i2c_client *client);
 
+static int __devinit lm78_isa_probe(struct platform_device *pdev);
+static int __devexit lm78_isa_remove(struct platform_device *pdev);
+
 static int lm78_read_value(struct i2c_client *client, u8 reg);
 static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct lm78_data *lm78_update_device(struct device *dev);
@@ -171,13 +174,13 @@ static struct i2c_driver lm78_driver = {
 	.detach_client	= lm78_detach_client,
 };
 
-static struct i2c_driver lm78_isa_driver = {
+static struct platform_driver lm78_isa_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "lm78-isa",
+		.name	= "lm78",
 	},
-	.attach_adapter	= lm78_isa_attach_adapter,
-	.detach_client	= lm78_detach_client,
+	.probe		= lm78_isa_probe,
+	.remove		= lm78_isa_remove,
 };
 
 
@@ -203,8 +206,8 @@ static ssize_t show_in_max(struct device
 static ssize_t set_in_min(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -217,8 +220,8 @@ static ssize_t set_in_min(struct device 
 static ssize_t set_in_max(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -284,8 +287,8 @@ static ssize_t show_temp_over(struct dev
 
 static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -303,8 +306,8 @@ static ssize_t show_temp_hyst(struct dev
 
 static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -338,8 +341,8 @@ static ssize_t show_fan_min(struct devic
 static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -362,8 +365,8 @@ static ssize_t show_fan_div(struct devic
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	unsigned long min;
 	u8 reg;
@@ -378,7 +381,7 @@ static ssize_t set_fan_div(struct device
 	case 4: data->fan_div[nr] = 2; break;
 	case 8: data->fan_div[nr] = 3; break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not "
+		dev_err(dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -475,11 +478,6 @@ static int lm78_attach_adapter(struct i2
 	return i2c_probe(adapter, &addr_data, lm78_detect);
 }
 
-static int lm78_isa_attach_adapter(struct i2c_adapter *adapter)
-{
-	return lm78_detect(adapter, isa_address, -1);
-}
-
 static struct attribute *lm78_attributes[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in0_min.attr,
@@ -524,6 +522,17 @@ static const struct attribute_group lm78
 	.attrs = lm78_attributes,
 };
 
+/* I2C devices get this name attribute automatically, but for ISA devices
+   we must create it by ourselves. */
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct lm78_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->client.name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 /* This function is called by i2c_probe */
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -531,54 +540,10 @@ static int lm78_detect(struct i2c_adapte
 	struct i2c_client *new_client;
 	struct lm78_data *data;
 	const char *client_name = "";
-	int is_isa = i2c_is_isa_adapter(adapter);
 
-	if (!is_isa &&
-	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		err = -ENODEV;
-		goto ERROR0;
-	}
-
-	/* Reserve the ISA region */
-	if (is_isa)
-		if (!request_region(address, LM78_EXTENT,
-				    lm78_isa_driver.driver.name)) {
-			err = -EBUSY;
-			goto ERROR0;
-		}
-
-	/* Probe whether there is anything available on this address. Already
-	   done for SMBus clients */
-	if (kind < 0) {
-		if (is_isa) {
-
-#define REALLY_SLOW_IO
-			/* We need the timeouts for at least some LM78-like
-			   chips. But only if we read 'undefined' registers. */
-			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 3) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 7) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-#undef REALLY_SLOW_IO
-
-			/* Let's just hope nothing breaks here */
-			i = inb_p(address + 5) & 0x7f;
-			outb_p(~i & 0x7f, address + 5);
-			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
-				outb_p(i, address + 5);
-				err = -ENODEV;
-				goto ERROR1;
-			}
-		}
+		goto ERROR1;
 	}
 
 	/* OK. For now, we presume we have a valid client. We now create the
@@ -591,13 +556,10 @@ static int lm78_detect(struct i2c_adapte
 	}
 
 	new_client = &data->client;
-	if (is_isa)
-		mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = is_isa ? &lm78_isa_driver : &lm78_driver;
-	new_client->flags = 0;
+	new_client->driver = &lm78_driver;
 
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
@@ -605,8 +567,8 @@ static int lm78_detect(struct i2c_adapte
 			err = -ENODEV;
 			goto ERROR2;
 		}
-		if (!is_isa && (lm78_read_value(
-				new_client, LM78_REG_I2C_ADDR) != address)) {
+		if (lm78_read_value(new_client, LM78_REG_I2C_ADDR) !+		    address) {
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -641,9 +603,6 @@ static int lm78_detect(struct i2c_adapte
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 
-	data->valid = 0;
-	mutex_init(&data->update_lock);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
@@ -651,12 +610,6 @@ static int lm78_detect(struct i2c_adapte
 	/* Initialize the LM78 chip */
 	lm78_init_client(new_client);
 
-	/* A few vars need to be filled upon startup */
-	for (i = 0; i < 3; i++) {
-		data->fan_min[i] = lm78_read_value(new_client,
-					LM78_REG_FAN_MIN(i));
-	}
-
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm78_group)))
 		goto ERROR3;
@@ -676,9 +629,6 @@ ERROR3:
 ERROR2:
 	kfree(data);
 ERROR1:
-	if (is_isa)
-		release_region(address, LM78_EXTENT);
-ERROR0:
 	return err;
 }
 
@@ -693,9 +643,77 @@ static int lm78_detach_client(struct i2c
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	if(i2c_is_isa_client(client))
-		release_region(client->addr, LM78_EXTENT);
+	kfree(data);
+
+	return 0;
+}
+
+static int __devinit lm78_isa_probe(struct platform_device *pdev)
+{
+	int err;
+	struct lm78_data *data;
+	struct resource *res;
+	const char *name;
+
+	/* Reserve the ISA region */
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, LM78_EXTENT, "lm78")) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	if (!(data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_release_region;
+	}
+	mutex_init(&data->lock);
+	data->client.addr = res->start;
+	i2c_set_clientdata(&data->client, data);
+	platform_set_drvdata(pdev, data);
+
+	if (lm78_read_value(&data->client, LM78_REG_CHIPID) & 0x80) {
+		data->type = lm79;
+		name = "lm79";
+	} else {
+		data->type = lm78;
+		name = "lm78";
+	}
+	strlcpy(data->client.name, name, I2C_NAME_SIZE);
 
+	/* Initialize the LM78 chip */
+	lm78_init_client(&data->client);
+
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
+	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
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
+	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	kfree(data);
+ exit_release_region:
+	release_region(res->start, LM78_EXTENT);
+ exit:
+	return err;
+}
+
+static int __devexit lm78_isa_remove(struct platform_device *pdev)
+{
+	struct lm78_data *data = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	release_region(data->client.addr, LM78_EXTENT);
 	kfree(data);
 
 	return 0;
@@ -709,7 +727,7 @@ static int lm78_detach_client(struct i2c
 static int lm78_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
-	if (i2c_is_isa_client(client)) {
+	if (!client->driver) { /* ISA device */
 		struct lm78_data *data = i2c_get_clientdata(client);
 		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
@@ -729,7 +747,7 @@ static int lm78_read_value(struct i2c_cl
    nowhere else be necessary! */
 static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
-	if (i2c_is_isa_client(client)) {
+	if (!client->driver) { /* ISA device */
 		struct lm78_data *data = i2c_get_clientdata(client);
 		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
@@ -742,18 +760,29 @@ static int lm78_write_value(struct i2c_c
 
 static void lm78_init_client(struct i2c_client *client)
 {
-	u8 config = lm78_read_value(client, LM78_REG_CONFIG);
+	struct lm78_data *data = i2c_get_clientdata(client);
+	u8 config;
+	int i;
 
 	/* Start monitoring */
-	if (!(config & 0x01))
+	config = lm78_read_value(client, LM78_REG_CONFIG);
+	if ((config & 0x09) != 0x01)
 		lm78_write_value(client, LM78_REG_CONFIG,
 				 (config & 0xf7) | 0x01);
+
+	/* A few vars need to be filled upon startup */
+	for (i = 0; i < 3; i++) {
+		data->fan_min[i] = lm78_read_value(client,
+					LM78_REG_FAN_MIN(i));
+	}
+
+	mutex_init(&data->update_lock);
 }
 
 static struct lm78_data *lm78_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
+	struct lm78_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = &data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -761,7 +790,7 @@ static struct lm78_data *lm78_update_dev
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
 
-		dev_dbg(&client->dev, "Starting lm78 update\n");
+		dev_dbg(dev, "Starting lm78 update\n");
 
 		for (i = 0; i <= 6; i++) {
 			data->in[i] @@ -805,26 +834,154 @@ static struct lm78_data *lm78_update_dev
 	return data;
 }
 
+/* return 1 if a supported chip is found, 0 otherwise */
+static int __init lm78_isa_found(unsigned short address)
+{
+	int val, save, found = 0;
+
+	if (!request_region(address, LM78_EXTENT, "lm78"))
+		return 0;
+
+#define REALLY_SLOW_IO
+	/* We need the timeouts for at least some LM78-like
+	   chips. But only if we read 'undefined' registers. */
+	val = inb_p(address + 1);
+	if (inb_p(address + 2) != val
+	 || inb_p(address + 3) != val
+	 || inb_p(address + 7) != val)
+	 	goto release;
+#undef REALLY_SLOW_IO
+
+	/* We should be able to change the 7 LSB of the address port. The
+	   MSB (busy flag) should be clear initially, set after the write. */
+	save = inb_p(address + LM78_ADDR_REG_OFFSET);
+	if (save & 0x80)
+		goto release;
+	val = ~save & 0x7f;
+	outb_p(val, address + LM78_ADDR_REG_OFFSET);
+	if (inb_p(address + LM78_ADDR_REG_OFFSET) != (val | 0x80)) {
+		outb_p(save, address + LM78_ADDR_REG_OFFSET);
+		goto release;
+	}
+
+	/* We found a device, now see if it could be an LM78 */
+	outb_p(LM78_REG_CONFIG, address + LM78_ADDR_REG_OFFSET);
+	val = inb_p(address + LM78_DATA_REG_OFFSET);
+	if (val & 0x80)
+		goto release;
+	outb_p(LM78_REG_I2C_ADDR, address + LM78_ADDR_REG_OFFSET);
+	val = inb_p(address + LM78_DATA_REG_OFFSET);
+	if (val < 0x03 || val > 0x77)	/* Not a valid I2C address */
+		goto release;
+
+	/* The busy flag should be clear again */
+	if (inb_p(address + LM78_ADDR_REG_OFFSET) & 0x80)
+		goto release;
+
+	/* Explicitly prevent the misdetection of Winbond chips */
+	outb_p(0x4f, address + LM78_ADDR_REG_OFFSET);
+	val = inb_p(address + LM78_DATA_REG_OFFSET);
+	if (val = 0xa3 || val = 0x5c)
+		goto release;
+
+	/* Explicitly prevent the misdetection of ITE chips */
+	outb_p(0x58, address + LM78_ADDR_REG_OFFSET);
+	val = inb_p(address + LM78_DATA_REG_OFFSET);
+	if (val = 0x90)
+		goto release;
+
+	/* Determine the chip type */
+	outb_p(LM78_REG_CHIPID, address + LM78_ADDR_REG_OFFSET);
+	val = inb_p(address + LM78_DATA_REG_OFFSET);
+	if (val = 0x00			/* LM78 */
+	 || val = 0x40			/* LM78-J */
+	 || (val & 0xfe) = 0xc0)	/* LM79 */
+		found = 1;
+
+	if (found)
+		pr_info("lm78: Found an %s chip at %#x\n",
+			val & 0x80 ? "LM79" : "LM78", (int)address);
+
+ release:
+	release_region(address, LM78_EXTENT);
+	return found;
+}
+
+static int __init lm78_isa_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + LM78_EXTENT,
+		.name	= "lm78",
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc("lm78", address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "lm78: Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR "lm78: Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR "lm78: Device addition failed (%d)\n",
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
 static int __init sm_lm78_init(void)
 {
 	int res;
 
 	res = i2c_add_driver(&lm78_driver);
 	if (res)
-		return res;
+		goto exit;
 
-	/* Don't exit if this one fails, we still want the I2C variants
-	   to work! */
-	if (i2c_isa_add_driver(&lm78_isa_driver))
-		isa_address = 0;
+	if (lm78_isa_found(isa_address)) {
+		res = platform_driver_register(&lm78_isa_driver);
+		if (res)
+			goto exit_unreg_i2c_driver;
+
+		/* Sets global pdev as a side effect */
+		res = lm78_isa_device_add(isa_address);
+		if (res)
+			goto exit_unreg_isa_driver;
+	}
 
 	return 0;
+
+ exit_unreg_isa_driver:
+	platform_driver_unregister(&lm78_isa_driver);
+ exit_unreg_i2c_driver:
+	i2c_del_driver(&lm78_driver);
+ exit:
+	return res;
 }
 
 static void __exit sm_lm78_exit(void)
 {
-	if (isa_address)
-		i2c_isa_del_driver(&lm78_isa_driver);
+	if (pdev) {
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&lm78_isa_driver);
+	}
 	i2c_del_driver(&lm78_driver);
 }
 


-- 
Jean Delvare

