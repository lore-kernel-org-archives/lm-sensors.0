From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2007 19:01:37 +0000
Subject: [lm-sensors] [PATCH 1/2] smsc47b397: Convert to a platform driver
Message-Id: <20070418210137.4ac37f76@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert the smsc47b397 driver from the nonsensical i2c-isa hack to a
regular platform driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Testers wanted!

 drivers/hwmon/Kconfig      |    3 
 drivers/hwmon/smsc47b397.c |  164 ++++++++++++++++++++++++++++----------------
 2 files changed, 109 insertions(+), 58 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/Kconfig	2007-04-18 20:33:31.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/Kconfig	2007-04-18 20:33:36.000000000 +0200
@@ -477,8 +477,7 @@ config SENSORS_SMSC47M192
 
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
-	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_ISA
+	depends on HWMON && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
 	  sensor chip.
--- linux-2.6.21-rc6.orig/drivers/hwmon/smsc47b397.c	2007-04-18 20:30:53.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/smsc47b397.c	2007-04-18 20:57:39.000000000 +0200
@@ -30,16 +30,16 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
 
-/* Address is autodetected, there is no default value */
-static unsigned short address;
+static struct platform_device *pdev;
+
+#define DRVNAME "smsc47b397"
 
 /* Super-I/0 registers and commands */
 
@@ -91,7 +91,8 @@ static u8 smsc47b397_reg_temp[] = {0x25,
 #define SMSC47B397_REG_FAN_MSB(nr) (0x29 + 2 * (nr))
 
 struct smsc47b397_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
 	struct class_device *class_dev;
 	struct mutex lock;
 
@@ -104,45 +105,43 @@ struct smsc47b397_data {
 	u8 temp[4];
 };
 
-static int smsc47b397_read_value(struct i2c_client *client, u8 reg)
+static int smsc47b397_read_value(struct smsc47b397_data* data, u8 reg)
 {
-	struct smsc47b397_data *data = i2c_get_clientdata(client);
 	int res;
 
 	mutex_lock(&data->lock);
-	outb(reg, client->addr);
-	res = inb_p(client->addr + 1);
+	outb(reg, data->addr);
+	res = inb_p(data->addr + 1);
 	mutex_unlock(&data->lock);
 	return res;
 }
 
 static struct smsc47b397_data *smsc47b397_update_device(struct device *dev)
 {
- 	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47b397_data *data = i2c_get_clientdata(client);
+	struct smsc47b397_data *data = dev_get_drvdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		dev_dbg(&client->dev, "starting device update...\n");
+		dev_dbg(dev, "starting device update...\n");
 
 		/* 4 temperature inputs, 4 fan inputs */
 		for (i = 0; i < 4; i++) {
-			data->temp[i] = smsc47b397_read_value(client,
+			data->temp[i] = smsc47b397_read_value(data,
 					SMSC47B397_REG_TEMP(i));
 
 			/* must read LSB first */
-			data->fan[i]  = smsc47b397_read_value(client,
+			data->fan[i]  = smsc47b397_read_value(data,
 					SMSC47B397_REG_FAN_LSB(i));
-			data->fan[i] |= smsc47b397_read_value(client,
+			data->fan[i] |= smsc47b397_read_value(data,
 					SMSC47B397_REG_FAN_MSB(i)) << 8;
 		}
 
 		data->last_updated = jiffies;
 		data->valid = 1;
 
-		dev_dbg(&client->dev, "... device update complete\n");
+		dev_dbg(dev, "... device update complete\n");
 	}
 
 	mutex_unlock(&data->update_lock);
@@ -202,6 +201,14 @@ sysfs_fan(2);
 sysfs_fan(3);
 sysfs_fan(4);
 
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct smsc47b397_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *smsc47b397_attributes[] = {
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp2_input.attr,
@@ -212,6 +219,7 @@ static struct attribute *smsc47b397_attr
 	&dev_attr_fan3_input.attr,
 	&dev_attr_fan4_input.attr,
 
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -219,44 +227,44 @@ static const struct attribute_group smsc
 	.attrs = smsc47b397_attributes,
 };
 
-static int smsc47b397_detach_client(struct i2c_client *client)
+static int __devexit smsc47b397_remove(struct platform_device *pdev)
 {
-	struct smsc47b397_data *data = i2c_get_clientdata(client);
-	int err;
+	struct smsc47b397_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &smsc47b397_group);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	release_region(client->addr, SMSC_EXTENT);
+	sysfs_remove_group(&pdev->dev.kobj, &smsc47b397_group);
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, SMSC_EXTENT);
 	kfree(data);
 
 	return 0;
 }
 
-static int smsc47b397_detect(struct i2c_adapter *adapter);
+static int smsc47b397_probe(struct platform_device *pdev);
 
-static struct i2c_driver smsc47b397_driver = {
+static struct platform_driver smsc47b397_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "smsc47b397",
+		.name	= DRVNAME,
 	},
-	.attach_adapter	= smsc47b397_detect,
-	.detach_client	= smsc47b397_detach_client,
+	.probe		= smsc47b397_probe,
+	.remove		= __devexit_p(smsc47b397_remove),
 };
 
-static int smsc47b397_detect(struct i2c_adapter *adapter)
+static int __devinit smsc47b397_probe(struct platform_device *pdev)
 {
-	struct i2c_client *new_client;
+	struct device *dev = &pdev->dev;
 	struct smsc47b397_data *data;
+	struct resource *res;
 	int err = 0;
 
-	if (!request_region(address, SMSC_EXTENT,
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, SMSC_EXTENT,
 			    smsc47b397_driver.driver.name)) {
-		dev_err(&adapter->dev, "Region 0x%x already in use!\n",
-			address);
+		dev_err(dev, "Region 0x%lx-0x%lx already in use!\n",
+			(unsigned long)res->start,
+			(unsigned long)res->start + SMSC_EXTENT - 1);
 		return -EBUSY;
 	}
 
@@ -265,25 +273,16 @@ static int smsc47b397_detect(struct i2c_
 		goto error_release;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
+	data->addr = res->start;
+	data->name = "smsc47b397";
 	mutex_init(&data->lock);
-	new_client->adapter = adapter;
-	new_client->driver = &smsc47b397_driver;
-	new_client->flags = 0;
-
-	strlcpy(new_client->name, "smsc47b397", I2C_NAME_SIZE);
-
 	mutex_init(&data->update_lock);
+	platform_set_drvdata(pdev, data);
 
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = sysfs_create_group(&dev->kobj, &smsc47b397_group)))
 		goto error_free;
 
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &smsc47b397_group)))
-		goto error_detach;
-
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto error_remove;
@@ -292,13 +291,50 @@ static int smsc47b397_detect(struct i2c_
 	return 0;
 
 error_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &smsc47b397_group);
-error_detach:
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&dev->kobj, &smsc47b397_group);
 error_free:
 	kfree(data);
 error_release:
-	release_region(address, SMSC_EXTENT);
+	release_region(res->start, SMSC_EXTENT);
+	return err;
+}
+
+static int __init smsc47b397_device_add(unsigned short address)
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
 	return err;
 }
 
@@ -320,7 +356,7 @@ static int __init smsc47b397_find(unsign
 	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
 		 |  superio_inb(SUPERIO_REG_BASE_LSB);
 
-	printk(KERN_INFO "smsc47b397: found SMSC %s "
+	printk(KERN_INFO DRVNAME ": found SMSC %s "
 		"(base address 0x%04x, revision %u)\n",
 		id = 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
 
@@ -330,17 +366,33 @@ static int __init smsc47b397_find(unsign
 
 static int __init smsc47b397_init(void)
 {
+	unsigned short address;
 	int ret;
 
 	if ((ret = smsc47b397_find(&address)))
 		return ret;
 
-	return i2c_isa_add_driver(&smsc47b397_driver);
+	ret = platform_driver_register(&smsc47b397_driver);
+	if (ret)
+		goto exit;
+
+	/* Sets global pdev as a side effect */
+	ret = smsc47b397_device_add(address);
+	if (ret)
+		goto exit_driver;
+
+	return 0;
+
+exit_driver:
+	platform_driver_unregister(&smsc47b397_driver);
+exit:
+	return ret;
 }
 
 static void __exit smsc47b397_exit(void)
 {
-	i2c_isa_del_driver(&smsc47b397_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&smsc47b397_driver);
 }
 
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
