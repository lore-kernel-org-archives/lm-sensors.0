From: Wolfgang Grandegger <wg@grandegger.com>
Date: Sat, 13 Sep 2008 08:53:01 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: w83781d: make ISA interface depend
Message-Id: <48CB7F6D.8010109@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Probing the ISA bus on systems without ISA bus may hang the system.
This patch makes the ISA bus related code depend on the kernel
configuration parameter CONFIG_ISA. It moves ISA bus related code
into one #ifdef CONFIG_ISA ... #endif block and adds some helper
function.

Note that this patch is based on the patches:

  hwmon-w83781d-01-refactor-beep-enable.patch
  hwmon-w83781d-02-alias-detect.patch

from http://jdelvare.pck.nerim.net/sensors/w83781d/.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/hwmon/w83781d.c |  666 +++++++++++++++++++++++++++---------------------
 1 file changed, 388 insertions(+), 278 deletions(-)

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
@@ -245,13 +240,13 @@ struct w83781d_data {
 	u8 vrm;
 };
 
+static struct w83781d_data *w83781d_data_if_isa(void);
+static int w83781d_alias_detect(struct i2c_client *client, u8 chipid);
+
 static int w83781d_attach_adapter(struct i2c_adapter *adapter);
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
-static int __devinit w83781d_isa_probe(struct platform_device *pdev);
-static int __devexit w83781d_isa_remove(struct platform_device *pdev);
-
 static int w83781d_read_value(struct w83781d_data *data, u16 reg);
 static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
@@ -265,16 +260,6 @@ static struct i2c_driver w83781d_driver 
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
@@ -836,16 +821,6 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_
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
@@ -855,13 +830,12 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
-	struct w83781d_data *data;
+	struct w83781d_data *data = w83781d_data_if_isa();
 	int err;
 
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 
-	data = pdev ? platform_get_drvdata(pdev) : NULL;
 	if (data)
 		mutex_lock(&data->update_lock);
 	err = i2c_probe(adapter, &addr_data, w83781d_detect);
@@ -1037,40 +1011,6 @@ static const struct attribute_group w837
 	.attrs = w83781d_attributes_opt,
 };
 
-/* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
-static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
-{
-	struct w83781d_data *i2c, *isa;
-	int i;
-
-	if (!pdev)	/* No ISA chip */
-		return 0;
-
-	i2c = i2c_get_clientdata(client);
-	isa = platform_get_drvdata(pdev);
-
-	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
-		return 0;	/* Address doesn't match */
-	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
-		return 0;	/* Chip type doesn't match */
-
-	/* We compare all the limit registers, the config register and the
-	 * interrupt mask registers */
-	for (i = 0x2b; i <= 0x3d; i++) {
-		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
-			return 0;
-	}
-	if (w83781d_read_value(isa, W83781D_REG_CONFIG) !-	    w83781d_read_value(i2c, W83781D_REG_CONFIG))
-		return 0;
-	for (i = 0x43; i <= 0x46; i++) {
-		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
-			return 0;
-	}
-
-	return 1;
-}
-
 /* No clean up is done on error, it's up to the caller */
 static int
 w83781d_create_files(struct device *dev, int kind, int is_isa)
@@ -1167,12 +1107,6 @@ w83781d_create_files(struct device *dev,
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
 
@@ -1381,221 +1315,80 @@ w83781d_detach_client(struct i2c_client 
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
-/* The SMBus locks itself, usually, but nothing may access the Winbond between
-   bank switches. ISA access must always be locked explicitly!
-   We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83781D access and should not be necessary.
-   There are some ugly typecasts here, but the good news is - they should
-   nowhere else be necessary! */
 static int
-w83781d_read_value(struct w83781d_data *data, u16 reg)
+w83781d_read_value_i2c(struct w83781d_data *data, u16 reg)
 {
 	struct i2c_client *client = &data->client;
-	int res, word_sized, bank;
+	int res, bank;
 	struct i2c_client *cl;
 
-	mutex_lock(&data->lock);
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
-	mutex_unlock(&data->lock);
+	if (bank > 2)
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
+
 	return res;
 }
 
 static int
-w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
+w83781d_write_value_i2c(struct w83781d_data *data, u16 reg, u16 value)
 {
 	struct i2c_client *client = &data->client;
-	int word_sized, bank;
 	struct i2c_client *cl;
+	int bank;
 
-	mutex_lock(&data->lock);
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
+					  value & 0xff);
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
+			i2c_smbus_write_byte_data(cl, 1, value & 0xff);
+			break;
+		case 0x53:	/* HYST */
+			i2c_smbus_write_word_data(cl, 2, swab16(value));
+			break;
+		case 0x55:	/* OVER */
+			i2c_smbus_write_word_data(cl, 3, swab16(value));
+			break;
 		}
-		if (bank > 2)
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
-	mutex_unlock(&data->lock);
+	if (bank > 2)
+		i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
+
 	return 0;
 }
 
@@ -1815,6 +1608,255 @@ static struct w83781d_data *w83781d_upda
 	return data;
 }
 
+#ifdef CONFIG_ISA
+
+/* ISA device, if found */
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
+static struct w83781d_data *w83781d_data_if_isa(void)
+{
+	return pdev ? platform_get_drvdata(pdev) : NULL;
+}
+
+/* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
+static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
+{
+	struct w83781d_data *i2c, *isa;
+	int i;
+
+	if (!pdev)	/* No ISA chip */
+		return 0;
+
+	i2c = i2c_get_clientdata(client);
+	isa = platform_get_drvdata(pdev);
+
+	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
+		return 0;	/* Address doesn't match */
+	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
+		return 0;	/* Chip type doesn't match */
+
+	/* We compare all the limit registers, the config register and the
+	 * interrupt mask registers */
+	for (i = 0x2b; i <= 0x3d; i++) {
+		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+			return 0;
+	}
+	if (w83781d_read_value(isa, W83781D_REG_CONFIG) !+	    w83781d_read_value(i2c, W83781D_REG_CONFIG))
+		return 0;
+	for (i = 0x43; i <= 0x46; i++) {
+		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+			return 0;
+	}
+
+	return 1;
+}
+
+static int
+w83781d_read_value_isa(struct w83781d_data *data, u16 reg)
+{
+	struct i2c_client *client = &data->client;
+	int word_sized, res;
+
+	word_sized = (((reg & 0xff00) = 0x100)
+		      || ((reg & 0xff00) = 0x200))
+	    && (((reg & 0x00ff) = 0x50)
+		|| ((reg & 0x00ff) = 0x53)
+		|| ((reg & 0x00ff) = 0x55));
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
+		res +		    (res << 8) + inb_p(client->addr +
+				       W83781D_DATA_REG_OFFSET);
+	}
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	return res;
+}
+
+static void
+w83781d_write_value_isa(struct w83781d_data *data, u16 reg, u16 value)
+{
+	struct i2c_client *client = &data->client;
+	int word_sized;
+
+	word_sized = (((reg & 0xff00) = 0x100)
+		      || ((reg & 0xff00) = 0x200))
+	    && (((reg & 0x00ff) = 0x53)
+		|| ((reg & 0x00ff) = 0x55));
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(reg >> 8,
+		       client->addr + W83781D_DATA_REG_OFFSET);
+	}
+	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+	if (word_sized) {
+		outb_p(value >> 8,
+		       client->addr + W83781D_DATA_REG_OFFSET);
+		outb_p((reg & 0xff) + 1,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+	}
+	outb_p(value & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK,
+		       client->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+	}
+}
+
+/* The SMBus locks itself, usually, but nothing may access the Winbond between
+   bank switches. ISA access must always be locked explicitly!
+   We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
+   would slow down the W83781D access and should not be necessary.
+   There are some ugly typecasts here, but the good news is - they should
+   nowhere else be necessary! */
+static int
+w83781d_read_value(struct w83781d_data *data, u16 reg)
+{
+	struct i2c_client *client = &data->client;
+	int res;
+
+	mutex_lock(&data->lock);
+	if (client->driver)
+		res = w83781d_read_value_i2c(data, reg);
+	else
+		res = w83781d_read_value_isa(data, reg);
+	mutex_unlock(&data->lock);
+	return res;
+}
+
+static int
+w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
+{
+	struct i2c_client *client = &data->client;
+
+	mutex_lock(&data->lock);
+	if (client->driver)
+		w83781d_write_value_i2c(data, reg, value);
+	else
+		w83781d_write_value_isa(data, reg, value);
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
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
+	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
+			    "w83781d")) {
+		err = -EBUSY;
+		goto exit;
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
+	/* Register sysfs hooks */
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
 /* return 1 if a supported chip is found, 0 otherwise */
 static int __init
 w83781d_isa_found(unsigned short address)
@@ -1951,12 +1993,10 @@ w83781d_isa_device_add(unsigned short ad
 }
 
 static int __init
-sensors_w83781d_init(void)
+w83781d_isa_register(void)
 {
 	int res;
 
-	/* We register the ISA device first, so that we can skip the
-	 * registration of an I2C interface to the same device. */
 	if (w83781d_isa_found(isa_address)) {
 		res = platform_driver_register(&w83781d_isa_driver);
 		if (res)
@@ -1968,16 +2008,89 @@ sensors_w83781d_init(void)
 			goto exit_unreg_isa_driver;
 	}
 
+	return 0;
+
+exit_unreg_isa_driver:
+	platform_driver_unregister(&w83781d_isa_driver);
+exit:
+	return res;
+
+}
+
+static void __init
+w83781d_isa_unregister(void)
+{
+	if (pdev) {
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&w83781d_isa_driver);
+	}
+}
+#else /* !CONFIG_ISA */
+
+static struct w83781d_data *w83781d_data_if_isa(void)
+{
+	return NULL;
+}
+
+static int
+w83781d_alias_detect(struct i2c_client *client, u8 chipid)
+{
+	return 0;
+}
+
+static int
+w83781d_read_value(struct w83781d_data *data, u16 reg)
+{
+	int res;
+
+	mutex_lock(&data->lock);
+	res = w83781d_read_value_i2c(data, reg);
+	mutex_unlock(&data->lock);
+
+	return res;
+}
+
+static int
+w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
+{
+	mutex_lock(&data->lock);
+	w83781d_write_value_i2c(data, reg, value);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static int __init
+w83781d_isa_register(void)
+{
+	return 0;
+}
+
+static void __init
+w83781d_isa_unregister(void)
+{
+}
+#endif /* CONFIG_ISA */
+
+static int __init
+sensors_w83781d_init(void)
+{
+	int res;
+
+	/* We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device. */
+	res = w83781d_isa_register();
+	if (res)
+		goto exit;
+
 	res = i2c_add_driver(&w83781d_driver);
 	if (res)
-		goto exit_unreg_isa_device;
+		goto exit_unreg_isa;
 
 	return 0;
 
- exit_unreg_isa_device:
-	platform_device_unregister(pdev);
- exit_unreg_isa_driver:
-	platform_driver_unregister(&w83781d_isa_driver);
+ exit_unreg_isa:
+	w83781d_isa_unregister();
  exit:
 	return res;
 }
@@ -1985,10 +2098,7 @@ sensors_w83781d_init(void)
 static void __exit
 sensors_w83781d_exit(void)
 {
-	if (pdev) {
-		platform_device_unregister(pdev);
-		platform_driver_unregister(&w83781d_isa_driver);
-	}
+	w83781d_isa_unregister();
 	i2c_del_driver(&w83781d_driver);
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
