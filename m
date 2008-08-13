From: Wolfgang Grandegger <wg@grandegger.com>
Date: Wed, 13 Aug 2008 10:14:29 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <48A2B405.9040306@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 12 Aug 2008 11:28:54 +0200, Wolfgang Grandegger wrote:
>> Jean Delvare wrote:
>>> Hi Wolfgang,
>>>
>>> On Tue, 12 Aug 2008 10:55:58 +0200, Wolfgang Grandegger wrote:
>>>> We need support for the MON35W42 on an embedded MPC8544 board, which 
>>>> seems to be compatible with the w83782d. There are more issues, e.g. the 
>>>> early ISA bus probing of the existing driver hangs the system. Maybe i2c 
>>>> probing should be done first!?
>>> If both interfaces are available, we want to use the ISA one, because
>>> it's much faster, so it must be registered first.
>>>
>>> What could be done though would be disabling the ISA interface
>>> altogether on architectures where it isn't supported (in particular
>>> PPC.) This shouldn't be too difficult. If you write a patch doing this,
>>> I'll be happy to review it. Affected drivers would be w83781d and lm78.
>> Some PPC have an ISA bus as well:
>>
>>    http://lxr.linux.no/linux+v2.6.26.2/arch/powerpc/Kconfig#L494
>>
>> I think selecting the ISA code with '#ifdef CONFIG_ISA' would be the 
>> right solution?
> 
> Agreed.

See the attached patch below. When I have some more free time, I will
convert the driver to new style as well.

Wolfgang


=================================From: Wolfgang Grandegger <wg@grandegger.com>
Subject: HWMON: w83781d: make ISA interface depend on CONFIG_ISA

Probing the ISA bus on systems without ISA bus may hang the system.
This patch makes the ISA bus related code depend on the kernel
configuration parameter CONFIG_ISA.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/hwmon/w83781d.c |  525 ++++++++++++++++++++++++++----------------------
 1 file changed, 291 insertions(+), 234 deletions(-)

Index: linux-2.6-denx/drivers/hwmon/w83781d.c
=================================--- linux-2.6-denx.orig/drivers/hwmon/w83781d.c
+++ linux-2.6-denx/drivers/hwmon/w83781d.c
@@ -49,14 +49,9 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-/* ISA device, if found */
-static struct platform_device *pdev;
-
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 						0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned short isa_address = 0x290;
-
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_4(w83781d, w83782d, w83783s, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
@@ -253,14 +248,16 @@ static int w83781d_attach_adapter(struct
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
-static int __devinit w83781d_isa_probe(struct platform_device *pdev);
-static int __devexit w83781d_isa_remove(struct platform_device *pdev);
-
-static int w83781d_read_value(struct w83781d_data *data, u16 reg);
-static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
+static int w83781d_read_value_i2c(struct w83781d_data *data, u16 reg);
+static int w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 val);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_device(struct device *dev);
 
+static int (*w83781d_read_value)(struct w83781d_data *data, u16 reg) +	w83781d_read_value_i2c;
+static int (*w83781d_write_value)(struct w83781d_data *data, u16 reg, u16 val) +	w83781d_write_value_i2c;
+
 static struct i2c_driver w83781d_driver = {
 	.driver = {
 		.name = "w83781d",
@@ -269,16 +266,6 @@ static struct i2c_driver w83781d_driver 
 	.detach_client = w83781d_detach_client,
 };
 
-static struct platform_driver w83781d_isa_driver = {
-	.driver = {
-		.owner = THIS_MODULE,
-		.name = "w83781d",
-	},
-	.probe = w83781d_isa_probe,
-	.remove = w83781d_isa_remove,
-};
-
-
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, struct device_attribute *da, \
@@ -866,16 +853,6 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
 	show_sensor, store_sensor, 2);
 
-/* I2C devices get this name attribute automatically, but for ISA devices
-   we must create it by ourselves. */
-static ssize_t
-show_name(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct w83781d_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", data->client.name);
-}
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -1151,12 +1128,6 @@ w83781d_create_files(struct device *dev,
 		}
 	}
 
-	if (is_isa) {
-		err = device_create_file(&pdev->dev, &dev_attr_name);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
@@ -1297,7 +1268,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	/* Initialize the chip */
 	w83781d_init_device(dev);
 
-	/* Register sysfs hooks */
+	/* Register common sysfs hooks */
 	err = w83781d_create_files(dev, kind, 0);
 	if (err)
 		goto ERROR4;
@@ -1357,85 +1328,6 @@ w83781d_detach_client(struct i2c_client 
 	return 0;
 }
 
-static int __devinit
-w83781d_isa_probe(struct platform_device *pdev)
-{
-	int err, reg;
-	struct w83781d_data *data;
-	struct resource *res;
-	const char *name;
-
-	/* Reserve the ISA region */
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
-			    "w83781d")) {
-		err = -EBUSY;
-		goto exit;
-	}
-
-	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit_release_region;
-	}
-	mutex_init(&data->lock);
-	data->client.addr = res->start;
-	i2c_set_clientdata(&data->client, data);
-	platform_set_drvdata(pdev, data);
-
-	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
-	switch (reg) {
-	case 0x30:
-		data->type = w83782d;
-		name = "w83782d";
-		break;
-	default:
-		data->type = w83781d;
-		name = "w83781d";
-	}
-	strlcpy(data->client.name, name, I2C_NAME_SIZE);
-
-	/* Initialize the W83781D chip */
-	w83781d_init_device(&pdev->dev);
-
-	/* Register sysfs hooks */
-	err = w83781d_create_files(&pdev->dev, data->type, 1);
-	if (err)
-		goto exit_remove_files;
-
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
- exit_remove_files:
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	kfree(data);
- exit_release_region:
-	release_region(res->start + W83781D_ADDR_REG_OFFSET, 2);
- exit:
-	return err;
-}
-
-static int __devexit
-w83781d_isa_remove(struct platform_device *pdev)
-{
-	struct w83781d_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
-	kfree(data);
-
-	return 0;
-}
-
 /* The SMBus locks itself, usually, but nothing may access the Winbond between
    bank switches. ISA access must always be locked explicitly!
    We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
@@ -1443,134 +1335,80 @@ w83781d_isa_remove(struct platform_devic
    There are some ugly typecasts here, but the good news is - they should
    nowhere else be necessary! */
 static int
-w83781d_read_value(struct w83781d_data *data, u16 reg)
+w83781d_read_value_i2c(struct w83781d_data *data, u16 reg)
 {
 	struct i2c_client *client = &data->client;
-	int res, word_sized, bank;
 	struct i2c_client *cl;
+	int res, bank;
 
 	mutex_lock(&data->lock);
-	if (!client->driver) { /* ISA device */
-		word_sized = (((reg & 0xff00) = 0x100)
-			      || ((reg & 0xff00) = 0x200))
-		    && (((reg & 0x00ff) = 0x50)
-			|| ((reg & 0x00ff) = 0x53)
-			|| ((reg & 0x00ff) = 0x55));
-		if (reg & 0xff00) {
-			outb_p(W83781D_REG_BANK,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-			outb_p(reg >> 8,
-			       client->addr + W83781D_DATA_REG_OFFSET);
-		}
-		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
-		res = inb_p(client->addr + W83781D_DATA_REG_OFFSET);
-		if (word_sized) {
-			outb_p((reg & 0xff) + 1,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-			res -			    (res << 8) + inb_p(client->addr +
-					       W83781D_DATA_REG_OFFSET);
-		}
-		if (reg & 0xff00) {
-			outb_p(W83781D_REG_BANK,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
-		}
+	bank = (reg >> 8) & 0x0f;
+	if (bank > 2)
+		/* switch banks */
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
+					  bank);
+	if (bank = 0 || bank > 2) {
+		res = i2c_smbus_read_byte_data(client, reg & 0xff);
 	} else {
-		bank = (reg >> 8) & 0x0f;
-		if (bank > 2)
-			/* switch banks */
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
-						  bank);
-		if (bank = 0 || bank > 2) {
-			res = i2c_smbus_read_byte_data(client, reg & 0xff);
-		} else {
-			/* switch to subclient */
-			cl = data->lm75[bank - 1];
-			/* convert from ISA to LM75 I2C addresses */
-			switch (reg & 0xff) {
-			case 0x50:	/* TEMP */
-				res = swab16(i2c_smbus_read_word_data(cl, 0));
-				break;
-			case 0x52:	/* CONFIG */
-				res = i2c_smbus_read_byte_data(cl, 1);
-				break;
-			case 0x53:	/* HYST */
-				res = swab16(i2c_smbus_read_word_data(cl, 2));
-				break;
-			case 0x55:	/* OVER */
-			default:
-				res = swab16(i2c_smbus_read_word_data(cl, 3));
-				break;
-			}
+		/* switch to subclient */
+		cl = data->lm75[bank - 1];
+		/* convert from ISA to LM75 I2C addresses */
+		switch (reg & 0xff) {
+		case 0x50:	/* TEMP */
+			res = swab16(i2c_smbus_read_word_data(cl, 0));
+			break;
+		case 0x52:	/* CONFIG */
+			res = i2c_smbus_read_byte_data(cl, 1);
+			break;
+		case 0x53:	/* HYST */
+			res = swab16(i2c_smbus_read_word_data(cl, 2));
+			break;
+		case 0x55:	/* OVER */
+		default:
+			res = swab16(i2c_smbus_read_word_data(cl, 3));
+			break;
 		}
-		if (bank > 2)
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
+	if (bank > 2)
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	mutex_unlock(&data->lock);
 	return res;
 }
 
 static int
-w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
+w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 val)
 {
 	struct i2c_client *client = &data->client;
-	int word_sized, bank;
 	struct i2c_client *cl;
+	int bank;
 
 	mutex_lock(&data->lock);
-	if (!client->driver) { /* ISA device */
-		word_sized = (((reg & 0xff00) = 0x100)
-			      || ((reg & 0xff00) = 0x200))
-		    && (((reg & 0x00ff) = 0x53)
-			|| ((reg & 0x00ff) = 0x55));
-		if (reg & 0xff00) {
-			outb_p(W83781D_REG_BANK,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-			outb_p(reg >> 8,
-			       client->addr + W83781D_DATA_REG_OFFSET);
-		}
-		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
-		if (word_sized) {
-			outb_p(value >> 8,
-			       client->addr + W83781D_DATA_REG_OFFSET);
-			outb_p((reg & 0xff) + 1,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-		}
-		outb_p(value & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
-		if (reg & 0xff00) {
-			outb_p(W83781D_REG_BANK,
-			       client->addr + W83781D_ADDR_REG_OFFSET);
-			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
-		}
+	bank = (reg >> 8) & 0x0f;
+	if (bank > 2)
+		/* switch banks */
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
+					  bank);
+	if (bank = 0 || bank > 2) {
+		i2c_smbus_write_byte_data(client, reg & 0xff,
+					  val & 0xff);
 	} else {
-		bank = (reg >> 8) & 0x0f;
-		if (bank > 2)
-			/* switch banks */
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
-						  bank);
-		if (bank = 0 || bank > 2) {
-			i2c_smbus_write_byte_data(client, reg & 0xff,
-						  value & 0xff);
-		} else {
-			/* switch to subclient */
-			cl = data->lm75[bank - 1];
-			/* convert from ISA to LM75 I2C addresses */
-			switch (reg & 0xff) {
-			case 0x52:	/* CONFIG */
-				i2c_smbus_write_byte_data(cl, 1, value & 0xff);
-				break;
-			case 0x53:	/* HYST */
-				i2c_smbus_write_word_data(cl, 2, swab16(value));
-				break;
-			case 0x55:	/* OVER */
-				i2c_smbus_write_word_data(cl, 3, swab16(value));
-				break;
-			}
+		/* switch to subclient */
+		cl = data->lm75[bank - 1];
+		/* convert from ISA to LM75 I2C addresses */
+		switch (reg & 0xff) {
+		case 0x52:	/* CONFIG */
+			i2c_smbus_write_byte_data(cl, 1, val & 0xff);
+			break;
+		case 0x53:	/* HYST */
+			i2c_smbus_write_word_data(cl, 2, swab16(val));
+			break;
+		case 0x55:	/* OVER */
+			i2c_smbus_write_word_data(cl, 3, swab16(val));
+			break;
 		}
-		if (bank > 2)
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
+	if (bank > 2)
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	mutex_unlock(&data->lock);
 	return 0;
 }
@@ -1792,6 +1630,96 @@ static struct w83781d_data *w83781d_upda
 	return data;
 }
 
+#ifdef CONFIG_ISA
+/*
+ * ISA device
+ */
+static struct platform_device *pdev;
+
+static unsigned short isa_address = 0x290;
+
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
+/* The SMBus locks itself, usually, but nothing may access the Winbond between
+   bank switches. ISA access must always be locked explicitly!
+   We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
+   would slow down the W83781D access and should not be necessary.
+   There are some ugly typecasts here, but the good news is - they should
+   nowhere else be necessary! */
+static int
+w83781d_read_value_i2c_isa(struct w83781d_data *data, u16 reg)
+{
+	int res, word_sized, bank;
+
+	mutex_lock(&data->lock);
+	word_sized = (((reg & 0xff00) = 0x100) || ((reg & 0xff00) = 0x200))
+		&& (((reg & 0x00ff) = 0x50) || ((reg & 0x00ff) = 0x53)
+		    || ((reg & 0x00ff) = 0x55));
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(reg >> 8,
+		       client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+	res = inb_p(client->addr + W83781D_DATA_REG_OFFSET);
+	if (word_sized) {
+		outb_p((reg & 0xff) + 1,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		res +			(res << 8) + inb_p(client->addr +
+					   W83781D_DATA_REG_OFFSET);
+	}
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	mutex_unlock(&data->lock);
+	return res;
+}
+
+static int
+w83781d_write_value_i2c_isa(struct w83781d_data *data, u16 reg, u16 val)
+{
+	struct i2c_client *client = &data->client;
+	int word_sized, bank;
+	struct i2c_client *cl;
+
+	mutex_lock(&data->lock);
+	word_sized = (((reg & 0xff00) = 0x100) || ((reg & 0xff00) = 0x200))
+		&& (((reg & 0x00ff) = 0x53) || ((reg & 0x00ff) = 0x55));
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(reg >> 8,
+		       client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+	if (word_sized) {
+		outb_p(val >> 8,
+		       client->addr + W83781D_DATA_REG_OFFSET);
+		outb_p((reg & 0xff) + 1,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+	}
+	outb_p(val & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
 /* return 1 if a supported chip is found, 0 otherwise */
 static int __init
 w83781d_isa_found(unsigned short address)
@@ -1927,43 +1855,172 @@ w83781d_isa_device_add(unsigned short ad
 	return err;
 }
 
-static int __init
-sensors_w83781d_init(void)
+static int __devinit
+w83781d_isa_probe(struct platform_device *pdev)
 {
-	int res;
+	int err, reg;
+	struct w83781d_data *data;
+	struct resource *res;
+	const char *name;
 
-	res = i2c_add_driver(&w83781d_driver);
-	if (res)
+	/* Reserve the ISA region */
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
+			    "w83781d")) {
+		err = -EBUSY;
 		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit_release_region;
+	}
+	mutex_init(&data->lock);
+	data->client.addr = res->start;
+	i2c_set_clientdata(&data->client, data);
+	platform_set_drvdata(pdev, data);
+
+	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
+	switch (reg) {
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
+	/* Register sysfs common hooks */
+	err = w83781d_create_files(&pdev->dev, data->type, 1);
+	if (err)
+		goto exit_remove_files;
+
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
+		goto exit_remove_files;
+
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
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
+	release_region(res->start + W83781D_ADDR_REG_OFFSET, 2);
+ exit:
+	return err;
+}
+
+static int __devexit
+w83781d_isa_remove(struct platform_device *pdev)
+{
+	struct w83781d_data *data = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
+	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
+	kfree(data);
+
+	return 0;
+}
+
+static struct platform_driver w83781d_isa_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "w83781d",
+	},
+	.probe = w83781d_isa_probe,
+	.remove = w83781d_isa_remove,
+};
+
+static int __devinit
+w83781d_isa_add_driver(void)
+{
+	int res;
 
 	if (w83781d_isa_found(isa_address)) {
 		res = platform_driver_register(&w83781d_isa_driver);
 		if (res)
-			goto exit_unreg_i2c_driver;
+			goto exit;
 
 		/* Sets global pdev as a side effect */
 		res = w83781d_isa_device_add(isa_address);
 		if (res)
 			goto exit_unreg_isa_driver;
-	}
 
+		/* Use ISA bus to access registers */
+		w83781d_read_value = w83781d_read_value_isa;
+		w83781d_write_value = w83781d_write_value_isa;
+	}
 	return 0;
 
  exit_unreg_isa_driver:
 	platform_driver_unregister(&w83781d_isa_driver);
- exit_unreg_i2c_driver:
-	i2c_del_driver(&w83781d_driver);
  exit:
 	return res;
 }
 
-static void __exit
-sensors_w83781d_exit(void)
+static __devexit void w83781d_isa_del_driver(void)
 {
 	if (pdev) {
 		platform_device_unregister(pdev);
 		platform_driver_unregister(&w83781d_isa_driver);
 	}
+}
+
+#else /* !CONFIG_ISA */
+
+static int w83781d_isa_add_driver(void)
+{
+	return 0;
+}
+
+static void w83781d_isa_del_driver(void)
+{
+}
+
+#endif /* CONFIG_ISA */
+
+static int __init
+sensors_w83781d_init(void)
+{
+	int res;
+
+	res = i2c_add_driver(&w83781d_driver);
+	if (res)
+		goto exit;
+
+	res = w83781d_isa_add_driver();
+	if (res)
+		goto exit_unreg_i2c_driver;
+
+	return 0;
+
+ exit_unreg_i2c_driver:
+	i2c_del_driver(&w83781d_driver);
+ exit:
+	return res;
+}
+
+static void __exit
+sensors_w83781d_exit(void)
+{
+	w83781d_isa_del_driver();
 	i2c_del_driver(&w83781d_driver);
 }
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
