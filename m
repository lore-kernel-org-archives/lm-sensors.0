From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jun 2007 12:51:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <20070606145132.725ce3a2@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_qQ_MFRpPCHy9DZcaSGnOgxS"
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--MP_qQ_MFRpPCHy9DZcaSGnOgxS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ivo,

Please don't forget the mailing list!

On Wed, 6 Jun 2007 13:21:23 +0200, Ivo Manca wrote:
> [root@localhost ~]# sensors -v
> sensors version 2.10.1 with libsensors version 2.10.1
> 
> I'll update it if you want.

No, that should be OK.

> > If you already have lm-sensors version >= 2.10.1, please compile with
> > CONFIG_HWMON_DEBUG_CHIP=y and look into your logs when loading the
> > driver. Also check what you see under /sys/class/hwmon
> > and /sys/bus/platform.
> 
> I already enabled hwmon_debug_chip, however, nothing seems to get logged. It 
> should go somewhere to /var/log, shouldn't it? Only log file changing is my 
> messages, but that's just moaning about  nmbd ;)

If should show in the output of "dmesg" to start with, and indeed also
in /var/log/messages and/or /var/log/debug.

> [ivo@localhost log]$ ls -l /sys/class/hwmon/
> total 0
> 
> [ivo@localhost log]$ ls -lR /sys/bus/platform/
> /sys/bus/platform/:
> total 0
> drwxr-xr-x 2 root root    0 Jun  6 10:05 devices
> drwxr-xr-x 4 root root    0 Jun  6 10:05 drivers
> -rw-r--r-- 1 root root 4096 Jun  6 10:56 drivers_autoprobe
> --w------- 1 root root 4096 Jun  6 10:56 drivers_probe
> 
> /sys/bus/platform/devices:
> total 0
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 floppy.0 -> 
> ../../../devices/platform/floppy.0
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 i8042 -> 
> ../../../devices/platform/i8042
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 microcode -> 
> ../../../devices/platform/microcode
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 pcspkr -> 
> ../../../devices/platform/pcspkr
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 serial8250 -> 
> ../../../devices/platform/serial8250
> lrwxrwxrwx 1 root root 0 Jun  6 10:05 serial8250.0 -> 
> ../../../devices/platform/serial8250.0
> 
> /sys/bus/platform/drivers:
> total 0
> drwxr-xr-x 2 root root 0 Jun  6 10:05 i8042
> drwxr-xr-x 2 root root 0 Jun  6 10:05 serial8250
> 
> /sys/bus/platform/drivers/i8042:
> total 0
> --w------- 1 root root 4096 Jun  6 10:57 bind
> lrwxrwxrwx 1 root root    0 Jun  6 10:57 i8042 -> 
> ../../../../devices/platform/i8042
> --w------- 1 root root 4096 Jun  6 10:57 unbind
> 
> /sys/bus/platform/drivers/serial8250:
> total 0
> --w------- 1 root root 4096 Jun  6 10:57 bind
> lrwxrwxrwx 1 root root    0 Jun  6 10:57 serial8250 -> 
> ../../../../devices/platform/serial8250
> lrwxrwxrwx 1 root root    0 Jun  6 10:57 serial8250.0 -> 
> ../../../../devices/platform/serial8250.0
> --w------- 1 root root 4096 Jun  6 10:57 unbind

Odd. No sign of sis5595 anywhere.

> [ivo@localhost log]$ lsmod
> Module                  Size  Used by
> sis5595                14348  0
> i2c_sis5595            10244  0
> i2c_dev                 9860  0
> hwmon                   6404  1 sis5595
> ne2k_pci               12128  0
> 8390                   11520  1 ne2k_pci
> 
> /sys/class/hwmon shouldn't be empty, should it?

It shouldn't, but OTOH given that the sis5595 platform driver seemingly
wasn't registered properly, I am not surprised.

My previous patch had some error paths which didn't display any error
nor debug message. I guess that one of these error conditions occurred
and this is why you don't see anything in the logs. So I attached a new
version of the patch with messages on all the error paths. Please
revert the previous patch and apply this one instead, leaving debugging
enabled of course. Hopefully you'll have something in the log this
time, and from there we'll see what needs to be fixed.

Thanks,
-- 
Jean Delvare

--MP_qQ_MFRpPCHy9DZcaSGnOgxS
Content-Type: text/x-patch; name=hwmon-sis5595-to-platform-driver.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=hwmon-sis5595-to-platform-driver.patch

Subject: hwmon/sis5595: Convert to a platform driver

Convert the sis5595 driver from the nonsensical i2c-isa hack to a
regular platform driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig   |    3 
 drivers/hwmon/sis5595.c |  323 +++++++++++++++++++++++++----------------------
 2 files changed, 177 insertions(+), 149 deletions(-)

--- linux-2.6.22-rc4.orig/drivers/hwmon/Kconfig	2007-06-06 14:00:54.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/Kconfig	2007-06-06 14:05:02.000000000 +0200
@@ -431,8 +431,7 @@ config SENSORS_PC87427
 
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
-	depends on I2C && PCI && EXPERIMENTAL
-	select I2C_ISA
+	depends on PCI
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  SiS5595 South Bridges.
--- linux-2.6.22-rc4.orig/drivers/hwmon/sis5595.c	2007-06-05 19:42:33.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/sis5595.c	2007-06-06 14:24:31.000000000 +0200
@@ -54,8 +54,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -72,10 +71,7 @@ module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
-/* Device address
-   Note that we can't determine the ISA address until we have initialized
-   our module */
-static unsigned short address;
+static struct platform_device *pdev;
 
 /* Many SIS5595 constants specified below */
 
@@ -165,7 +161,8 @@ static inline u8 DIV_TO_REG(int val)
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct sis5595_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
 	struct class_device *class_dev;
 	struct mutex lock;
 
@@ -189,21 +186,21 @@ struct sis5595_data {
 
 static struct pci_dev *s_bridge;	/* pointer to the (only) sis5595 */
 
-static int sis5595_detect(struct i2c_adapter *adapter);
-static int sis5595_detach_client(struct i2c_client *client);
+static int sis5595_probe(struct platform_device *pdev);
+static int sis5595_remove(struct platform_device *pdev);
 
-static int sis5595_read_value(struct i2c_client *client, u8 reg);
-static int sis5595_write_value(struct i2c_client *client, u8 reg, u8 value);
+static int sis5595_read_value(struct sis5595_data *data, u8 reg);
+static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value);
 static struct sis5595_data *sis5595_update_device(struct device *dev);
-static void sis5595_init_client(struct i2c_client *client);
+static void sis5595_init_device(struct sis5595_data *data);
 
-static struct i2c_driver sis5595_driver = {
+static struct platform_driver sis5595_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "sis5595",
 	},
-	.attach_adapter	= sis5595_detect,
-	.detach_client	= sis5595_detach_client,
+	.probe		= sis5595_probe,
+	.remove		= __devexit_p(sis5595_remove),
 };
 
 /* 4 Voltages */
@@ -228,13 +225,12 @@ static ssize_t show_in_max(struct device
 static ssize_t set_in_min(struct device *dev, const char *buf,
 	       size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
-	sis5595_write_value(client, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
+	sis5595_write_value(data, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -242,13 +238,12 @@ static ssize_t set_in_min(struct device 
 static ssize_t set_in_max(struct device *dev, const char *buf,
 	       size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
-	sis5595_write_value(client, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
+	sis5595_write_value(data, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -307,13 +302,12 @@ static ssize_t show_temp_over(struct dev
 
 static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
-	sis5595_write_value(client, SIS5595_REG_TEMP_OVER, data->temp_over);
+	sis5595_write_value(data, SIS5595_REG_TEMP_OVER, data->temp_over);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -326,13 +320,12 @@ static ssize_t show_temp_hyst(struct dev
 
 static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
-	sis5595_write_value(client, SIS5595_REG_TEMP_HYST, data->temp_hyst);
+	sis5595_write_value(data, SIS5595_REG_TEMP_HYST, data->temp_hyst);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -361,13 +354,12 @@ static ssize_t show_fan_min(struct devic
 static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	sis5595_write_value(data, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -385,8 +377,7 @@ static ssize_t show_fan_div(struct devic
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
@@ -394,7 +385,7 @@ static ssize_t set_fan_div(struct device
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			DIV_FROM_REG(data->fan_div[nr]));
-	reg = sis5595_read_value(client, SIS5595_REG_FANDIV);
+	reg = sis5595_read_value(data, SIS5595_REG_FANDIV);
 
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
@@ -402,7 +393,7 @@ static ssize_t set_fan_div(struct device
 	case 4: data->fan_div[nr] = 2; break;
 	case 8: data->fan_div[nr] = 3; break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not "
+		dev_err(dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -416,10 +407,10 @@ static ssize_t set_fan_div(struct device
 		reg = (reg & 0x3f) | (data->fan_div[nr] << 6);
 		break;
 	}
-	sis5595_write_value(client, SIS5595_REG_FANDIV, reg);
+	sis5595_write_value(data, SIS5595_REG_FANDIV, reg);
 	data->fan_min[nr] =
 		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	sis5595_write_value(data, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -473,6 +464,14 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct sis5595_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *sis5595_attributes[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in0_min.attr,
@@ -495,6 +494,7 @@ static struct attribute *sis5595_attribu
 	&dev_attr_fan2_div.attr,
 
 	&dev_attr_alarms.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -518,65 +518,32 @@ static const struct attribute_group sis5
 };
  
 /* This is called when the module is loaded */
-static int sis5595_detect(struct i2c_adapter *adapter)
+static int __devinit sis5595_probe(struct platform_device *pdev)
 {
 	int err = 0;
 	int i;
-	struct i2c_client *new_client;
 	struct sis5595_data *data;
+	struct resource *res;
 	char val;
-	u16 a;
 
-	if (force_addr)
-		address = force_addr & ~(SIS5595_EXTENT - 1);
 	/* Reserve the ISA region */
-	if (!request_region(address, SIS5595_EXTENT,
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, SIS5595_EXTENT,
 			    sis5595_driver.driver.name)) {
 		err = -EBUSY;
 		goto exit;
 	}
-	if (force_addr) {
-		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n", address);
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_word(s_bridge, SIS5595_BASE_REG, address))
-			goto exit_release;
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_read_config_word(s_bridge, SIS5595_BASE_REG, &a))
-			goto exit_release;
-		if ((a & ~(SIS5595_EXTENT - 1)) != address)
-			/* doesn't work for some chips? */
-			goto exit_release;
-	}
-
-	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_byte(s_bridge, SIS5595_ENABLE_REG, &val)) {
-		goto exit_release;
-	}
-	if ((val & 0x80) == 0) {
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_byte(s_bridge, SIS5595_ENABLE_REG,
-					  val | 0x80))
-			goto exit_release;
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_read_config_byte(s_bridge, SIS5595_ENABLE_REG, &val))
-			goto exit_release;
-		if ((val & 0x80) == 0) 
-			/* doesn't work for some chips! */
-			goto exit_release;
-	}
 
 	if (!(data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
 
-	new_client = &data->client;
-	new_client->addr = address;
 	mutex_init(&data->lock);
-	i2c_set_clientdata(new_client, data);
-	new_client->adapter = adapter;
-	new_client->driver = &sis5595_driver;
-	new_client->flags = 0;
+	mutex_init(&data->update_lock);
+	data->addr = res->start;
+	data->name = "sis5595";
+	platform_set_drvdata(pdev, data);
 
 	/* Check revision and pin registers to determine whether 4 or 5 voltages */
 	pci_read_config_byte(s_bridge, SIS5595_REVISION_REG, &(data->revision));
@@ -589,47 +556,37 @@ static int sis5595_detect(struct i2c_ada
 			data->maxins = 4;
 	}
 	
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, "sis5595", I2C_NAME_SIZE);
-
-	data->valid = 0;
-	mutex_init(&data->update_lock);
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
-	
 	/* Initialize the SIS5595 chip */
-	sis5595_init_client(new_client);
+	sis5595_init_device(data);
 
 	/* A few vars need to be filled upon startup */
 	for (i = 0; i < 2; i++) {
-		data->fan_min[i] = sis5595_read_value(new_client,
+		data->fan_min[i] = sis5595_read_value(data,
 					SIS5595_REG_FAN_MIN(i));
 	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &sis5595_group)))
-		goto exit_detach;
+	if ((err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group)))
+		goto exit_free;
 	if (data->maxins == 4) {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&pdev->dev,
 					      &dev_attr_in4_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&pdev->dev,
 					      &dev_attr_in4_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&pdev->dev,
 					      &dev_attr_in4_max)))
 			goto exit_remove_files;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&pdev->dev,
 					      &dev_attr_temp1_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&pdev->dev,
 					      &dev_attr_temp1_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&pdev->dev,
 					      &dev_attr_temp1_max_hyst)))
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto exit_remove_files;
@@ -638,32 +595,26 @@ static int sis5595_detect(struct i2c_ada
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group);
-	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group_opt);
-exit_detach:
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_opt);
 exit_free:
 	kfree(data);
 exit_release:
-	release_region(address, SIS5595_EXTENT);
+	release_region(res->start, SIS5595_EXTENT);
 exit:
 	return err;
 }
 
-static int sis5595_detach_client(struct i2c_client *client)
+static int __devexit sis5595_remove(struct platform_device *pdev)
 {
-	struct sis5595_data *data = i2c_get_clientdata(client);
-	int err;
+	struct sis5595_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &sis5595_group);
-	sysfs_remove_group(&client->dev.kobj, &sis5595_group_opt);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	release_region(client->addr, SIS5595_EXTENT);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_opt);
 
+	release_region(data->addr, SIS5595_EXTENT);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	return 0;
@@ -671,41 +622,37 @@ static int sis5595_detach_client(struct 
 
 
 /* ISA access must be locked explicitly. */
-static int sis5595_read_value(struct i2c_client *client, u8 reg)
+static int sis5595_read_value(struct sis5595_data *data, u8 reg)
 {
 	int res;
 
-	struct sis5595_data *data = i2c_get_clientdata(client);
 	mutex_lock(&data->lock);
-	outb_p(reg, client->addr + SIS5595_ADDR_REG_OFFSET);
-	res = inb_p(client->addr + SIS5595_DATA_REG_OFFSET);
+	outb_p(reg, data->addr + SIS5595_ADDR_REG_OFFSET);
+	res = inb_p(data->addr + SIS5595_DATA_REG_OFFSET);
 	mutex_unlock(&data->lock);
 	return res;
 }
 
-static int sis5595_write_value(struct i2c_client *client, u8 reg, u8 value)
+static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value)
 {
-	struct sis5595_data *data = i2c_get_clientdata(client);
 	mutex_lock(&data->lock);
-	outb_p(reg, client->addr + SIS5595_ADDR_REG_OFFSET);
-	outb_p(value, client->addr + SIS5595_DATA_REG_OFFSET);
+	outb_p(reg, data->addr + SIS5595_ADDR_REG_OFFSET);
+	outb_p(value, data->addr + SIS5595_DATA_REG_OFFSET);
 	mutex_unlock(&data->lock);
-	return 0;
 }
 
 /* Called when we have found a new SIS5595. */
-static void sis5595_init_client(struct i2c_client *client)
+static void __devinit sis5595_init_device(struct sis5595_data *data)
 {
-	u8 config = sis5595_read_value(client, SIS5595_REG_CONFIG);
+	u8 config = sis5595_read_value(data, SIS5595_REG_CONFIG);
 	if (!(config & 0x01))
-		sis5595_write_value(client, SIS5595_REG_CONFIG,
+		sis5595_write_value(data, SIS5595_REG_CONFIG,
 				(config & 0xf7) | 0x01);
 }
 
 static struct sis5595_data *sis5595_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct sis5595_data *data = i2c_get_clientdata(client);
+	struct sis5595_data *data = dev_get_drvdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -715,35 +662,35 @@ static struct sis5595_data *sis5595_upda
 
 		for (i = 0; i <= data->maxins; i++) {
 			data->in[i] =
-			    sis5595_read_value(client, SIS5595_REG_IN(i));
+			    sis5595_read_value(data, SIS5595_REG_IN(i));
 			data->in_min[i] =
-			    sis5595_read_value(client,
+			    sis5595_read_value(data,
 					       SIS5595_REG_IN_MIN(i));
 			data->in_max[i] =
-			    sis5595_read_value(client,
+			    sis5595_read_value(data,
 					       SIS5595_REG_IN_MAX(i));
 		}
 		for (i = 0; i < 2; i++) {
 			data->fan[i] =
-			    sis5595_read_value(client, SIS5595_REG_FAN(i));
+			    sis5595_read_value(data, SIS5595_REG_FAN(i));
 			data->fan_min[i] =
-			    sis5595_read_value(client,
+			    sis5595_read_value(data,
 					       SIS5595_REG_FAN_MIN(i));
 		}
 		if (data->maxins == 3) {
 			data->temp =
-			    sis5595_read_value(client, SIS5595_REG_TEMP);
+			    sis5595_read_value(data, SIS5595_REG_TEMP);
 			data->temp_over =
-			    sis5595_read_value(client, SIS5595_REG_TEMP_OVER);
+			    sis5595_read_value(data, SIS5595_REG_TEMP_OVER);
 			data->temp_hyst =
-			    sis5595_read_value(client, SIS5595_REG_TEMP_HYST);
+			    sis5595_read_value(data, SIS5595_REG_TEMP_HYST);
 		}
-		i = sis5595_read_value(client, SIS5595_REG_FANDIV);
+		i = sis5595_read_value(data, SIS5595_REG_FANDIV);
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = i >> 6;
 		data->alarms =
-		    sis5595_read_value(client, SIS5595_REG_ALARM1) |
-		    (sis5595_read_value(client, SIS5595_REG_ALARM2) << 8);
+		    sis5595_read_value(data, SIS5595_REG_ALARM1) |
+		    (sis5595_read_value(data, SIS5595_REG_ALARM2) << 8);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -774,10 +721,50 @@ static int blacklist[] __devinitdata = {
 	PCI_DEVICE_ID_SI_5598,
 	0 };
 
+static int __devinit sis5595_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + SIS5595_EXTENT - 1,
+		.name	= "sis5595",
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc("sis5595", address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "sis5595: Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR "sis5595: Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR "sis5595: Device addition failed (%d)\n",
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
 static int __devinit sis5595_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
-	u16 val;
+	u16 address;
+	u8 enable;
 	int *i;
 
 	for (i = blacklist; *i != 0; i++) {
@@ -790,27 +777,68 @@ static int __devinit sis5595_pci_probe(s
 		}
 	}
 	
+	force_addr &= ~(SIS5595_EXTENT - 1);
+	if (force_addr) {
+		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n", force_addr);
+		pci_write_config_word(dev, SIS5595_BASE_REG, force_addr);
+	}
+
 	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_word(dev, SIS5595_BASE_REG, &val))
+	    pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
+		dev_err(&dev->dev, "Failed to read ISA address\n");
 		return -ENODEV;
+	}
 	
-	address = val & ~(SIS5595_EXTENT - 1);
-	if (address == 0 && force_addr == 0) {
+	address &= ~(SIS5595_EXTENT - 1);
+	if (!address) {
 		dev_err(&dev->dev, "Base address not set - upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
+	if (force_addr && address != force_addr) {
+		/* doesn't work for some chips? */
+		dev_warn(&dev->dev, "Failed to force ISA address\n");
+		return -ENODEV;
+	}
 
-	s_bridge = pci_dev_get(dev);
-	if (i2c_isa_add_driver(&sis5595_driver)) {
-		pci_dev_put(s_bridge);
-		s_bridge = NULL;
+	if (PCIBIOS_SUCCESSFUL !=
+	    pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable)) {
+		dev_err(&dev->dev, "Failed to read enable register\n");
+		return -ENODEV;
+	}
+	if (!(enable & 0x80)) {
+		if ((PCIBIOS_SUCCESSFUL !=
+		     pci_write_config_byte(dev, SIS5595_ENABLE_REG,
+					   enable | 0x80))
+		 || (PCIBIOS_SUCCESSFUL !=
+		     pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable))
+		 || (!(enable & 0x80))) {
+			/* doesn't work for some chips! */
+			dev_err(&dev->dev, "Failed to enable HWM device\n");
+			return -ENODEV;
+		}
 	}
 
+	if (platform_driver_register(&sis5595_driver)) {
+		dev_dbg(&dev->dev, "Failed to register sis5595 driver\n");
+		goto exit;
+	}
+
+	s_bridge = pci_dev_get(dev);
+	/* Sets global pdev as a side effect */
+	if (sis5595_device_add(address))
+		goto exit_unregister;
+
 	/* Always return failure here.  This is to allow other drivers to bind
 	 * to this pci device.  We don't really want to have control over the
 	 * pci device, we only wanted to read as few register values from it.
 	 */
 	return -ENODEV;
+
+exit_unregister:
+	pci_dev_put(dev);
+	platform_driver_unregister(&sis5595_driver);
+exit:
+	return -ENODEV;
 }
 
 static struct pci_driver sis5595_pci_driver = {
@@ -828,7 +856,8 @@ static void __exit sm_sis5595_exit(void)
 {
 	pci_unregister_driver(&sis5595_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_isa_del_driver(&sis5595_driver);
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&sis5595_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}

--MP_qQ_MFRpPCHy9DZcaSGnOgxS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_qQ_MFRpPCHy9DZcaSGnOgxS--
