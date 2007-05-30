From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 May 2007 18:54:49 +0000
Subject: [lm-sensors] |PATCH] hwmon/via686a: Convert to a platform driver
Message-Id: <20070530205449.26e9d63c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert the via686a driver from the nonsensical i2c-isa hack to a
regular platform driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Anyone with a VIA VT82C686 chip could please test this patch? It
applies on top of the bugfix I just sent. Thanks.

 drivers/hwmon/Kconfig   |    3 
 drivers/hwmon/via686a.c |  286 +++++++++++++++++++++++++----------------------
 2 files changed, 157 insertions(+), 132 deletions(-)

--- linux-2.6.22-rc3.orig/drivers/hwmon/Kconfig	2007-05-30 17:28:39.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/Kconfig	2007-05-30 17:38:49.000000000 +0200
@@ -497,8 +497,7 @@ config SENSORS_SMSC47B397
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on I2C && PCI
-	select I2C_ISA
+	depends on PCI
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.
--- linux-2.6.22-rc3.orig/drivers/hwmon/via686a.c	2007-05-30 17:30:09.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/via686a.c	2007-05-30 20:30:22.000000000 +0200
@@ -34,8 +34,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -51,10 +50,7 @@ module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
-/* Device address
-   Note that we can't determine the ISA address until we have initialized
-   our module */
-static unsigned short address;
+static struct platform_device *pdev;
 
 /*
    The Via 686a southbridge has a LM78-like chip integrated on the same IC.
@@ -295,7 +291,8 @@ static inline long TEMP_FROM_REG10(u16 v
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct via686a_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
 	struct class_device *class_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
@@ -315,22 +312,22 @@ struct via686a_data {
 
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
-static int via686a_detect(struct i2c_adapter *adapter);
-static int via686a_detach_client(struct i2c_client *client);
+static int via686a_probe(struct platform_device *pdev);
+static int via686a_remove(struct platform_device *pdev);
 
-static inline int via686a_read_value(struct i2c_client *client, u8 reg)
+static inline int via686a_read_value(struct via686a_data *data, u8 reg)
 {
-	return (inb_p(client->addr + reg));
+	return inb_p(data->addr + reg);
 }
 
-static inline void via686a_write_value(struct i2c_client *client, u8 reg,
+static inline void via686a_write_value(struct via686a_data *data, u8 reg,
 				       u8 value)
 {
-	outb_p(value, client->addr + reg);
+	outb_p(value, data->addr + reg);
 }
 
 static struct via686a_data *via686a_update_device(struct device *dev);
-static void via686a_init_client(struct i2c_client *client);
+static void via686a_init_device(struct via686a_data *data);
 
 /* following are the sysfs callback functions */
 
@@ -352,26 +349,24 @@ static ssize_t show_in_max(struct device
 
 static ssize_t set_in_min(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, nr);
-	via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
+	via686a_write_value(data, VIA686A_REG_IN_MIN(nr),
 			data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, nr);
-	via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
+	via686a_write_value(data, VIA686A_REG_IN_MAX(nr),
 			data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -429,26 +424,24 @@ static ssize_t show_temp_hyst(struct dev
 }
 static ssize_t set_temp_over(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_OVER[nr],
+	via686a_write_value(data, VIA686A_REG_TEMP_OVER[nr],
 			    data->temp_over[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_HYST[nr],
+	via686a_write_value(data, VIA686A_REG_TEMP_HYST[nr],
 			    data->temp_hyst[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -505,28 +498,26 @@ static ssize_t show_fan_div(struct devic
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	via686a_write_value(data, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr) {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 	int old;
 
 	mutex_lock(&data->update_lock);
-	old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	old = via686a_read_value(data, VIA686A_REG_FANDIV);
 	data->fan_div[nr] = DIV_TO_REG(val);
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
-	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	via686a_write_value(data, VIA686A_REG_FANDIV, old);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -570,6 +561,14 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct via686a_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *via686a_attributes[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in1_input.attr,
@@ -605,6 +604,7 @@ static struct attribute *via686a_attribu
 	&dev_attr_fan2_div.attr,
 
 	&dev_attr_alarms.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -612,58 +612,29 @@ static const struct attribute_group via6
 	.attrs = via686a_attributes,
 };
 
-/* The driver. I choose to use type i2c_driver, as at is identical to both
-   smbus_driver and isa_driver, and clients could be of either kind */
-static struct i2c_driver via686a_driver = {
+static struct platform_driver via686a_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "via686a",
 	},
-	.attach_adapter	= via686a_detect,
-	.detach_client	= via686a_detach_client,
+	.probe		= via686a_probe,
+	.remove		= __devexit_p(via686a_remove),
 };
 
 
 /* This is called when the module is loaded */
-static int via686a_detect(struct i2c_adapter *adapter)
+static int __devinit via686a_probe(struct platform_device *pdev)
 {
-	struct i2c_client *new_client;
 	struct via686a_data *data;
-	int err = 0;
-	const char client_name[] = "via686a";
-	u16 val;
-
-	/* 8231 requires multiple of 256, we enforce that on 686 as well */
-	if (force_addr) {
-		address = force_addr & 0xFF00;
-		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n",
-			 address);
-		if (PCIBIOS_SUCCESSFUL !-		    pci_write_config_word(s_bridge, VIA686A_BASE_REG, address))
-			return -ENODEV;
-	}
-	if (PCIBIOS_SUCCESSFUL !-	    pci_read_config_word(s_bridge, VIA686A_ENABLE_REG, &val))
-		return -ENODEV;
-	if (!(val & 0x0001)) {
-		if (force_addr) {
-			dev_info(&adapter->dev, "enabling sensors\n");
-			if (PCIBIOS_SUCCESSFUL !-			    pci_write_config_word(s_bridge, VIA686A_ENABLE_REG,
-						  val | 0x0001))
-				return -ENODEV;
-		} else {
-			dev_warn(&adapter->dev, "sensors disabled - enable "
-				 "with force_addr=0x%x\n", address);
-			return -ENODEV;
-		}
-	}
+	struct resource *res;
+	int err;
 
 	/* Reserve the ISA region */
-	if (!request_region(address, VIA686A_EXTENT,
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, VIA686A_EXTENT,
 			    via686a_driver.driver.name)) {
-		dev_err(&adapter->dev, "region 0x%x already in use!\n",
-			address);
+		dev_err(&pdev->dev, "Region 0x%lx-0x%lx already in use!\n",
+			(unsigned long)res->start, (unsigned long)res->end);
 		return -ENODEV;
 	}
 
@@ -672,30 +643,19 @@ static int via686a_detect(struct i2c_ada
 		goto exit_release;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &via686a_driver;
-	new_client->flags = 0;
-
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-
-	data->valid = 0;
+	platform_set_drvdata(pdev, data);
+	data->addr = res->start;
+	data->name = "via686a";
 	mutex_init(&data->update_lock);
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
 
 	/* Initialize the VIA686A chip */
-	via686a_init_client(new_client);
+	via686a_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &via686a_group)))
-		goto exit_detach;
+	if ((err = sysfs_create_group(&pdev->dev.kobj, &via686a_group)))
+		goto exit_free;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto exit_remove_files;
@@ -704,52 +664,46 @@ static int via686a_detect(struct i2c_ada
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &via686a_group);
-exit_detach:
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
 exit_free:
 	kfree(data);
 exit_release:
-	release_region(address, VIA686A_EXTENT);
+	release_region(res->start, VIA686A_EXTENT);
 	return err;
 }
 
-static int via686a_detach_client(struct i2c_client *client)
+static int __devexit via686a_remove(struct platform_device *pdev)
 {
-	struct via686a_data *data = i2c_get_clientdata(client);
-	int err;
+	struct via686a_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &via686a_group);
+	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	release_region(client->addr, VIA686A_EXTENT);
+	release_region(data->addr, VIA686A_EXTENT);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	return 0;
 }
 
-static void via686a_init_client(struct i2c_client *client)
+static void __devinit via686a_init_device(struct via686a_data *data)
 {
 	u8 reg;
 
 	/* Start monitoring */
-	reg = via686a_read_value(client, VIA686A_REG_CONFIG);
-	via686a_write_value(client, VIA686A_REG_CONFIG, (reg|0x01)&0x7F);
+	reg = via686a_read_value(data, VIA686A_REG_CONFIG);
+	via686a_write_value(data, VIA686A_REG_CONFIG, (reg | 0x01) & 0x7F);
 
 	/* Configure temp interrupt mode for continuous-interrupt operation */
-	reg = via686a_read_value(client, VIA686A_REG_TEMP_MODE);
-	via686a_write_value(client, VIA686A_REG_TEMP_MODE,
+	reg = via686a_read_value(data, VIA686A_REG_TEMP_MODE);
+	via686a_write_value(data, VIA686A_REG_TEMP_MODE,
 			    (reg & ~VIA686A_TEMP_MODE_MASK)
 			    | VIA686A_TEMP_MODE_CONTINUOUS);
 }
 
 static struct via686a_data *via686a_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct via686a_data *data = i2c_get_clientdata(client);
+	struct via686a_data *data = dev_get_drvdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -758,27 +712,27 @@ static struct via686a_data *via686a_upda
 	    || !data->valid) {
 		for (i = 0; i <= 4; i++) {
 			data->in[i] -			    via686a_read_value(client, VIA686A_REG_IN(i));
-			data->in_min[i] = via686a_read_value(client,
+			    via686a_read_value(data, VIA686A_REG_IN(i));
+			data->in_min[i] = via686a_read_value(data,
 							     VIA686A_REG_IN_MIN
 							     (i));
 			data->in_max[i] -			    via686a_read_value(client, VIA686A_REG_IN_MAX(i));
+			    via686a_read_value(data, VIA686A_REG_IN_MAX(i));
 		}
 		for (i = 1; i <= 2; i++) {
 			data->fan[i - 1] -			    via686a_read_value(client, VIA686A_REG_FAN(i));
-			data->fan_min[i - 1] = via686a_read_value(client,
+			    via686a_read_value(data, VIA686A_REG_FAN(i));
+			data->fan_min[i - 1] = via686a_read_value(data,
 						     VIA686A_REG_FAN_MIN(i));
 		}
 		for (i = 0; i <= 2; i++) {
-			data->temp[i] = via686a_read_value(client,
+			data->temp[i] = via686a_read_value(data,
 						 VIA686A_REG_TEMP[i]) << 2;
 			data->temp_over[i] -			    via686a_read_value(client,
+			    via686a_read_value(data,
 					       VIA686A_REG_TEMP_OVER[i]);
 			data->temp_hyst[i] -			    via686a_read_value(client,
+			    via686a_read_value(data,
 					       VIA686A_REG_TEMP_HYST[i]);
 		}
 		/* add in lower 2 bits
@@ -786,23 +740,23 @@ static struct via686a_data *via686a_upda
 		   temp2 uses bits 5-4 of VIA686A_REG_TEMP_LOW23
 		   temp3 uses bits 7-6 of VIA686A_REG_TEMP_LOW23
 		 */
-		data->temp[0] |= (via686a_read_value(client,
+		data->temp[0] |= (via686a_read_value(data,
 						     VIA686A_REG_TEMP_LOW1)
 				  & 0xc0) >> 6;
 		data->temp[1] |-		    (via686a_read_value(client, VIA686A_REG_TEMP_LOW23) &
+		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
 		     0x30) >> 4;
 		data->temp[2] |-		    (via686a_read_value(client, VIA686A_REG_TEMP_LOW23) &
+		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
 		     0xc0) >> 6;
 
-		i = via686a_read_value(client, VIA686A_REG_FANDIV);
+		i = via686a_read_value(data, VIA686A_REG_FANDIV);
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = i >> 6;
 		data->alarms -		    via686a_read_value(client,
+		    via686a_read_value(data,
 				       VIA686A_REG_ALARM1) |
-		    (via686a_read_value(client, VIA686A_REG_ALARM2) << 8);
+		    (via686a_read_value(data, VIA686A_REG_ALARM2) << 8);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -819,32 +773,103 @@ static struct pci_device_id via686a_pci_
 
 MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
+static int __devinit via686a_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + VIA686A_EXTENT - 1,
+		.name	= "via686a",
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc("via686a", address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "via686a: Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR "via686a: Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR "via686a: Device addition failed (%d)\n",
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
 static int __devinit via686a_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
-	u16 val;
+	u16 address, val;
 
+	if (force_addr) {
+		address = force_addr & ~(VIA686A_EXTENT - 1);
+		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n",
+			 address);
+		if (PCIBIOS_SUCCESSFUL !+		    pci_write_config_word(dev, VIA686A_BASE_REG, address | 1))
+			return -ENODEV;
+	}
 	if (PCIBIOS_SUCCESSFUL ! 	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
 		return -ENODEV;
 
 	address = val & ~(VIA686A_EXTENT - 1);
-	if (address = 0 && force_addr = 0) {
+	if (address = 0) {
 		dev_err(&dev->dev, "base address not set - upgrade BIOS "
 			"or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
-	s_bridge = pci_dev_get(dev);
-	if (i2c_isa_add_driver(&via686a_driver)) {
-		pci_dev_put(s_bridge);
-		s_bridge = NULL;
+	if (PCIBIOS_SUCCESSFUL !+	    pci_read_config_word(dev, VIA686A_ENABLE_REG, &val))
+		return -ENODEV;
+	if (!(val & 0x0001)) {
+		if (!force_addr) {
+			dev_warn(&dev->dev, "Sensors disabled, enable "
+				 "with force_addr=0x%x\n", address);
+			return -ENODEV;
+		}
+
+		dev_warn(&dev->dev, "Enabling sensors\n");
+		if (PCIBIOS_SUCCESSFUL !+		    pci_write_config_word(dev, VIA686A_ENABLE_REG,
+					  val | 0x0001))
+			return -ENODEV;
 	}
 
+	if (platform_driver_register(&via686a_driver))
+		goto exit;
+
+	/* Sets global pdev as a side effect */
+	if (via686a_device_add(address))
+		goto exit_unregister;
+
 	/* Always return failure here.  This is to allow other drivers to bind
 	 * to this pci device.  We don't really want to have control over the
 	 * pci device, we only wanted to read as few register values from it.
 	 */
+	s_bridge = pci_dev_get(dev);
+	return -ENODEV;
+
+exit_unregister:
+	platform_driver_unregister(&via686a_driver);
+exit:
 	return -ENODEV;
 }
 
@@ -863,7 +888,8 @@ static void __exit sm_via686a_exit(void)
 {
 	pci_unregister_driver(&via686a_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_isa_del_driver(&via686a_driver);
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&via686a_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
