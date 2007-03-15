From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 12:38:42 +0000
Subject: [lm-sensors] [PATCH] smsc47m1: Convert to a platform driver
Message-Id: <20070315133842.cfb79821.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert the smsc47m1 driver from the nonsensical i2c-isa hack to a
regular platform driver.

Can anyone with supported hardware try this patch and report please?

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/Kconfig    |    3 -
 drivers/hwmon/smsc47m1.c |  327 +++++++++++++++++++++++++++-------------------
 2 files changed, 194 insertions(+), 136 deletions(-)

--- linux-2.6.21-rc3.orig/drivers/hwmon/Kconfig	2007-03-15 11:19:09.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/Kconfig	2007-03-15 11:32:42.000000000 +0100
@@ -416,8 +416,7 @@ config SENSORS_SIS5595
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
-	depends on HWMON && I2C
-	select I2C_ISA
+	depends on HWMON
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
--- linux-2.6.21-rc3.orig/drivers/hwmon/smsc47m1.c	2007-03-15 11:19:09.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/smsc47m1.c	2007-03-15 13:19:42.000000000 +0100
@@ -30,8 +30,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -39,9 +38,9 @@
 #include <linux/sysfs.h>
 #include <asm/io.h>
 
-/* Address is autodetected, there is no default value */
-static unsigned short address;
-static u8 devid;
+static struct platform_device *pdev;
+
+#define DRVNAME "smsc47m1"
 enum chips { smsc47m1, smsc47m2 };
 
 /* Super-I/0 registers and commands */
@@ -113,7 +112,8 @@ static const u8 SMSC47M1_REG_PWM[3]		= {
 #define PWM_TO_REG(reg)			(((reg) >> 1) & 0x7E)
 
 struct smsc47m1_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
 	enum chips type;
 	struct class_device *class_dev;
 
@@ -127,30 +127,34 @@ struct smsc47m1_data {
 	u8 pwm[3];		/* Register value (bit 0 is disable) */
 };
 
+struct smsc47m1_sio_data {
+	enum chips type;
+};
 
-static int smsc47m1_detect(struct i2c_adapter *adapter);
-static int smsc47m1_detach_client(struct i2c_client *client);
+
+static int smsc47m1_probe(struct platform_device *pdev);
+static int smsc47m1_remove(struct platform_device *pdev);
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init);
 
-static inline int smsc47m1_read_value(struct i2c_client *client, u8 reg)
+static inline int smsc47m1_read_value(struct smsc47m1_data *data, u8 reg)
 {
-	return inb_p(client->addr + reg);
+	return inb_p(data->addr + reg);
 }
 
-static inline void smsc47m1_write_value(struct i2c_client *client, u8 reg,
+static inline void smsc47m1_write_value(struct smsc47m1_data *data, u8 reg,
 		u8 value)
 {
-	outb_p(value, client->addr + reg);
+	outb_p(value, data->addr + reg);
 }
 
-static struct i2c_driver smsc47m1_driver = {
+static struct platform_driver smsc47m1_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "smsc47m1",
+		.name	= DRVNAME,
 	},
-	.attach_adapter	= smsc47m1_detect,
-	.detach_client	= smsc47m1_detach_client,
+	.probe		= smsc47m1_probe,
+	.remove		= __devexit_p(smsc47m1_remove),
 };
 
 /* nr is 0 or 1 in the callback functions below */
@@ -204,8 +208,7 @@ static ssize_t get_alarms(struct device 
 static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
 	long rpmdiv, val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -217,7 +220,7 @@ static ssize_t set_fan_min(struct device
 	}
 
 	data->fan_preload[nr] = 192 - ((983040 + rpmdiv / 2) / rpmdiv);
-	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD[nr],
+	smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
 			     data->fan_preload[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -231,8 +234,7 @@ static ssize_t set_fan_min(struct device
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
 
 	long new_div = simple_strtol(buf, NULL, 10), tmp;
 	u8 old_div = DIV_FROM_REG(data->fan_div[nr]);
@@ -254,15 +256,15 @@ static ssize_t set_fan_div(struct device
 	switch (nr) {
 	case 0:
 	case 1:
-		tmp = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV)
+		tmp = smsc47m1_read_value(data, SMSC47M1_REG_FANDIV)
 		      & ~(0x03 << (4 + 2 * nr));
 		tmp |= data->fan_div[nr] << (4 + 2 * nr);
-		smsc47m1_write_value(client, SMSC47M1_REG_FANDIV, tmp);
+		smsc47m1_write_value(data, SMSC47M1_REG_FANDIV, tmp);
 		break;
 	case 2:
-		tmp = smsc47m1_read_value(client, SMSC47M2_REG_FANDIV3) & 0xCF;
+		tmp = smsc47m1_read_value(data, SMSC47M2_REG_FANDIV3) & 0xCF;
 		tmp |= data->fan_div[2] << 4;
-		smsc47m1_write_value(client, SMSC47M2_REG_FANDIV3, tmp);
+		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
 		break;
 	}
 
@@ -270,7 +272,7 @@ static ssize_t set_fan_div(struct device
 	tmp = 192 - (old_div * (192 - data->fan_preload[nr])
 		     + new_div / 2) / new_div;
 	data->fan_preload[nr] = SENSORS_LIMIT(tmp, 0, 191);
-	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD[nr],
+	smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
 			     data->fan_preload[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -280,8 +282,7 @@ static ssize_t set_fan_div(struct device
 static ssize_t set_pwm(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
 
 	long val = simple_strtol(buf, NULL, 10);
 
@@ -291,7 +292,7 @@ static ssize_t set_pwm(struct device *de
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] &= 0x81; /* Preserve additional bits */
 	data->pwm[nr] |= PWM_TO_REG(val);
-	smsc47m1_write_value(client, SMSC47M1_REG_PWM[nr],
+	smsc47m1_write_value(data, SMSC47M1_REG_PWM[nr],
 			     data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -301,8 +302,7 @@ static ssize_t set_pwm(struct device *de
 static ssize_t set_pwm_en(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
 
 	long val = simple_strtol(buf, NULL, 10);
 	
@@ -312,7 +312,7 @@ static ssize_t set_pwm_en(struct device 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] &= 0xFE; /* preserve the other bits */
 	data->pwm[nr] |= !val;
-	smsc47m1_write_value(client, SMSC47M1_REG_PWM[nr],
+	smsc47m1_write_value(data, SMSC47M1_REG_PWM[nr],
 			     data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -377,6 +377,15 @@ fan_present(3);
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 /* Almost all sysfs files may or may not be created depending on the chip
    setup so we create them individually. It is still convenient to define a
    group to remove them all at once. */
@@ -399,6 +408,7 @@ static struct attribute *smsc47m1_attrib
 	&dev_attr_pwm3_enable.attr,
 
 	&dev_attr_alarms.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -406,12 +416,13 @@ static const struct attribute_group smsc
 	.attrs = smsc47m1_attributes,
 };
 
-static int __init smsc47m1_find(unsigned short *addr)
+static int __init smsc47m1_find(unsigned short *addr,
+				struct smsc47m1_sio_data *sio_data)
 {
 	u8 val;
 
 	superio_enter();
-	devid = superio_inb(SUPERIO_REG_DEVID);
+	val = superio_inb(SUPERIO_REG_DEVID);
 
 	/*
 	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
@@ -424,23 +435,28 @@ static int __init smsc47m1_find(unsigned
 	 * supports a 3rd fan, and the pin configuration registers are
 	 * unfortunately different.
 	 */
-	switch (devid) {
+	switch (val) {
 	case 0x51:
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
+		sio_data->type = smsc47m1;
 		break;
 	case 0x59:
 		printk(KERN_INFO "smsc47m1: Found SMSC "
 		       "LPC47M10x/LPC47M112/LPC47M13x\n");
+		sio_data->type = smsc47m1;
 		break;
 	case 0x5F:
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
+		sio_data->type = smsc47m1;
 		break;
 	case 0x60:
 		printk(KERN_INFO "smsc47m1: Found SMSC "
 		       "LPC47M15x/LPC47M192/LPC47M997\n");
+		sio_data->type = smsc47m1;
 		break;
 	case 0x6B:
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M292\n");
+		sio_data->type = smsc47m2;
 		break;
 	default:
 		superio_exit();
@@ -461,15 +477,25 @@ static int __init smsc47m1_find(unsigned
 	return 0;
 }
 
-static int smsc47m1_detect(struct i2c_adapter *adapter)
+static int __devinit smsc47m1_probe(struct platform_device *pdev)
 {
-	struct i2c_client *new_client;
+	struct device *dev = &pdev->dev;
+	struct smsc47m1_sio_data *sio_data = dev->platform_data;
 	struct smsc47m1_data *data;
+	struct resource *res;
 	int err = 0;
 	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
 
-	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.driver.name)) {
-		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
+	static const char *names[] = {
+		"smsc47m1",
+		"smsc47m2",
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, SMSC_EXTENT, DRVNAME)) {
+		dev_err(dev, "Region 0x%lx-0x%lx already in use!\n",
+			(unsigned long)res->start,
+			(unsigned long)res->end);
 		return -EBUSY;
 	}
 
@@ -478,131 +504,99 @@ static int smsc47m1_detect(struct i2c_ad
 		goto error_release;
 	}
 
-	data->type = devid = 0x6B ? smsc47m2 : smsc47m1;
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &smsc47m1_driver;
-	new_client->flags = 0;
-
-	strlcpy(new_client->name,
-		data->type = smsc47m2 ? "smsc47m2" : "smsc47m1",
-		I2C_NAME_SIZE);
+	data->addr = res->start;
+	data->type = sio_data->type;
+	data->name = names[sio_data->type];
 	mutex_init(&data->update_lock);
+	platform_set_drvdata(pdev, data);
 
 	/* If no function is properly configured, there's no point in
 	   actually registering the chip. */
-	pwm1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(0)) & 0x05)
+	pwm1 = (smsc47m1_read_value(data, SMSC47M1_REG_PPIN(0)) & 0x05)
 	       = 0x04;
-	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
+	pwm2 = (smsc47m1_read_value(data, SMSC47M1_REG_PPIN(1)) & 0x05)
 	       = 0x04;
 	if (data->type = smsc47m2) {
-		fan1 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN1)
+		fan1 = (smsc47m1_read_value(data, SMSC47M2_REG_TPIN1)
 			& 0x0d) = 0x09;
-		fan2 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN2)
+		fan2 = (smsc47m1_read_value(data, SMSC47M2_REG_TPIN2)
 			& 0x0d) = 0x09;
-		fan3 = (smsc47m1_read_value(new_client, SMSC47M2_REG_TPIN3)
+		fan3 = (smsc47m1_read_value(data, SMSC47M2_REG_TPIN3)
 			& 0x0d) = 0x0d;
-		pwm3 = (smsc47m1_read_value(new_client, SMSC47M2_REG_PPIN3)
+		pwm3 = (smsc47m1_read_value(data, SMSC47M2_REG_PPIN3)
 			& 0x0d) = 0x08;
 	} else {
-		fan1 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(0))
+		fan1 = (smsc47m1_read_value(data, SMSC47M1_REG_TPIN(0))
 			& 0x05) = 0x05;
-		fan2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_TPIN(1))
+		fan2 = (smsc47m1_read_value(data, SMSC47M1_REG_TPIN(1))
 			& 0x05) = 0x05;
 		fan3 = 0;
 		pwm3 = 0;
 	}
 	if (!(fan1 || fan2 || fan3 || pwm1 || pwm2 || pwm3)) {
-		dev_warn(&adapter->dev, "Device at 0x%x is not configured, "
-			 "will not use\n", new_client->addr);
+		dev_warn(dev, "Device not configured, will not use\n");
 		err = -ENODEV;
 		goto error_free;
 	}
 
-	if ((err = i2c_attach_client(new_client)))
-		goto error_free;
-
 	/* Some values (fan min, clock dividers, pwm registers) may be
 	   needed before any update is triggered, so we better read them
 	   at least once here. We don't usually do it that way, but in
 	   this particular case, manually reading 5 registers out of 8
 	   doesn't make much sense and we're better using the existing
 	   function. */
-	smsc47m1_update_device(&new_client->dev, 1);
+	smsc47m1_update_device(dev, 1);
 
 	/* Register sysfs hooks */
 	if (fan1) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_fan1_input))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan1_min))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan1_div)))
+		if ((err = device_create_file(dev, &dev_attr_fan1_input))
+		 || (err = device_create_file(dev, &dev_attr_fan1_min))
+		 || (err = device_create_file(dev, &dev_attr_fan1_div)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "Fan 1 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "Fan 1 not enabled by hardware, skipping\n");
 
 	if (fan2) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_fan2_input))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan2_min))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan2_div)))
+		if ((err = device_create_file(dev, &dev_attr_fan2_input))
+		 || (err = device_create_file(dev, &dev_attr_fan2_min))
+		 || (err = device_create_file(dev, &dev_attr_fan2_div)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "Fan 2 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "Fan 2 not enabled by hardware, skipping\n");
 
 	if (fan3) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_fan3_input))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan3_min))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_fan3_div)))
+		if ((err = device_create_file(dev, &dev_attr_fan3_input))
+		 || (err = device_create_file(dev, &dev_attr_fan3_min))
+		 || (err = device_create_file(dev, &dev_attr_fan3_div)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "Fan 3 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
 
 	if (pwm1) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm1))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm1_enable)))
+		if ((err = device_create_file(dev, &dev_attr_pwm1))
+		 || (err = device_create_file(dev, &dev_attr_pwm1_enable)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "PWM 1 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "PWM 1 not enabled by hardware, skipping\n");
 
 	if (pwm2) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm2))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm2_enable)))
+		if ((err = device_create_file(dev, &dev_attr_pwm2))
+		 || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "PWM 2 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "PWM 2 not enabled by hardware, skipping\n");
 
 	if (pwm3) {
-		if ((err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm3))
-		 || (err = device_create_file(&new_client->dev,
-					      &dev_attr_pwm3_enable)))
+		if ((err = device_create_file(dev, &dev_attr_pwm3))
+		 || (err = device_create_file(dev, &dev_attr_pwm3_enable)))
 			goto error_remove_files;
 	} else
-		dev_dbg(&new_client->dev, "PWM 3 not enabled by hardware, "
-			"skipping\n");
+		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");
 
-	if ((err = device_create_file(&new_client->dev, &dev_attr_alarms)))
+	if ((err = device_create_file(dev, &dev_attr_alarms)))
 		goto error_remove_files;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto error_remove_files;
@@ -611,27 +605,25 @@ static int smsc47m1_detect(struct i2c_ad
 	return 0;
 
 error_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &smsc47m1_group);
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group);
 error_free:
 	kfree(data);
 error_release:
-	release_region(address, SMSC_EXTENT);
+	release_region(res->start, SMSC_EXTENT);
 	return err;
 }
 
-static int smsc47m1_detach_client(struct i2c_client *client)
+static int smsc47m1_remove(struct platform_device *pdev)
 {
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
-	int err;
+	struct smsc47m1_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 
+	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &smsc47m1_group);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
+	sysfs_remove_group(&pdev->dev.kobj, &smsc47m1_group);
 
-	release_region(client->addr, SMSC_EXTENT);
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, SMSC_EXTENT);
 	kfree(data);
 
 	return 0;
@@ -640,8 +632,7 @@ static int smsc47m1_detach_client(struct
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init)
 {
- 	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m1_data *data = i2c_get_clientdata(client);
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
 
 	mutex_lock(&data->update_lock);
 
@@ -650,32 +641,32 @@ static struct smsc47m1_data *smsc47m1_up
 		fan_nr = data->type = smsc47m2 ? 3 : 2;
 
 		for (i = 0; i < fan_nr; i++) {
-			data->fan[i] = smsc47m1_read_value(client,
+			data->fan[i] = smsc47m1_read_value(data,
 				       SMSC47M1_REG_FAN[i]);
-			data->fan_preload[i] = smsc47m1_read_value(client,
+			data->fan_preload[i] = smsc47m1_read_value(data,
 					       SMSC47M1_REG_FAN_PRELOAD[i]);
-			data->pwm[i] = smsc47m1_read_value(client,
+			data->pwm[i] = smsc47m1_read_value(data,
 				       SMSC47M1_REG_PWM[i]);
 		}
 
-		i = smsc47m1_read_value(client, SMSC47M1_REG_FANDIV);
+		i = smsc47m1_read_value(data, SMSC47M1_REG_FANDIV);
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = i >> 6;
 
-		data->alarms = smsc47m1_read_value(client,
+		data->alarms = smsc47m1_read_value(data,
 			       SMSC47M1_REG_ALARM) >> 6;
 		/* Clear alarms if needed */
 		if (data->alarms)
-			smsc47m1_write_value(client, SMSC47M1_REG_ALARM, 0xC0);
+			smsc47m1_write_value(data, SMSC47M1_REG_ALARM, 0xC0);
 
 		if (fan_nr >= 3) {
-			data->fan_div[2] = (smsc47m1_read_value(client,
+			data->fan_div[2] = (smsc47m1_read_value(data,
 					    SMSC47M2_REG_FANDIV3) >> 4) & 0x03;
-			data->alarms |= (smsc47m1_read_value(client,
+			data->alarms |= (smsc47m1_read_value(data,
 					 SMSC47M2_REG_ALARM6) & 0x40) >> 4;
 			/* Clear alarm if needed */
 			if (data->alarms & 0x04)
-				smsc47m1_write_value(client,
+				smsc47m1_write_value(data,
 						     SMSC47M2_REG_ALARM6,
 						     0x40);
 		}
@@ -687,18 +678,86 @@ static struct smsc47m1_data *smsc47m1_up
 	return data;
 }
 
+static int __init smsc47m1_device_add(unsigned short address,
+				      const struct smsc47m1_sio_data *sio_data)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + SMSC_EXTENT - 1,
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
+	pdev->dev.platform_data = kmalloc(sizeof(struct smsc47m1_sio_data),
+					  GFP_KERNEL);
+	if (!pdev->dev.platform_data) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+	memcpy(pdev->dev.platform_data, sio_data,
+	       sizeof(struct smsc47m1_sio_data));
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
 static int __init sm_smsc47m1_init(void)
 {
-	if (smsc47m1_find(&address)) {
+	int err;
+	unsigned short address;
+	struct smsc47m1_sio_data sio_data;
+
+	if (smsc47m1_find(&address, &sio_data))
 		return -ENODEV;
-	}
 
-	return i2c_isa_add_driver(&smsc47m1_driver);
+	err = platform_driver_register(&smsc47m1_driver);
+	if (err)
+		goto exit;
+
+	/* Sets global pdev as a side effect */
+	err = smsc47m1_device_add(address, &sio_data);
+	if (err)
+		goto exit_driver;
+
+	return 0;
+
+exit_driver:
+	platform_driver_unregister(&smsc47m1_driver);
+exit:
+	return err;
 }
 
 static void __exit sm_smsc47m1_exit(void)
 {
-	i2c_isa_del_driver(&smsc47m1_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&smsc47m1_driver);
 }
 
 MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123 at yahoo.com>");


-- 
Jean Delvare

