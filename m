From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 03 Jun 2005 22:25:13 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a driver for the PCA9539, a 16 bit digital I/O chip.
It uses the new i2c-sysfs interfaces.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

--- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/pca9539.c
1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.12-rc5-mm2-pca9539/drivers/i2c/chips/pca9539.c
2005-06-03 15:15:02.000000000 -0500
@@ -0,0 +1,188 @@
+/*
+    pca9539.c - 16 port digital I/O with interrupt and reset
+    
+    Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
+
+    This program is free software; you can redistribute it and/or
modify
+    it under the terms of the GNU General Public License as published
by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sysfs.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x74, 0x75, 0x76, 0x77,
I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(pca9539);
+
+enum pca9539_cmd
+{
+	PCA9539_INPUT_0 = 0,
+	PCA9539_INPUT_1 = 1,
+	PCA9539_OUTPUT_0 = 2,
+	PCA9539_OUTPUT_1 = 3,
+	PCA9539_INVERT_0 = 4,
+	PCA9539_INVERT_1 = 5,
+	PCA9539_CONFIG_0 = 6,
+	PCA9539_CONFIG_1 = 7
+};
+
+static int pca9539_attach_adapter(struct i2c_adapter *adapter);
+static int pca9539_detect(struct i2c_adapter *adapter, int address, int
kind);
+static int pca9539_detach_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pca9539_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pca9539",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= pca9539_attach_adapter,
+	.detach_client	= pca9539_detach_client,
+};
+
+struct pca9539_data {
+	struct i2c_client client;
+};
+
+/* following are the sysfs callback functions */
+static ssize_t pca9539_show(struct device *dev, struct device_attribute
*attr,
+			    char *buf)
+{
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct pca9539_data *data i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%d\n",
i2c_smbus_read_byte_data(&data->client, (u8)psa->index));
+}
+
+static ssize_t pca9539_store(struct device *dev, struct
device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct pca9539_data *data i2c_get_clientdata(to_i2c_client(dev));
+	u8 val = simple_strtoul(buf, NULL, 0);
+	i2c_smbus_write_byte_data(&data->client, (u8)psa->index, val);
+	return count;
+}
+
+/* Define the device attributes */
+
+#define PCA9539_ENTRY_RO(name,enum_name)	\
+	static
SENSOR_DEVICE_ATTR(name,S_IRUGO,pca9539_show,NULL,enum_name)
+
+#define PCA9539_ENTRY_RW(name,enum_name)	\
+	static
SENSOR_DEVICE_ATTR(name,S_IRUGO|S_IWUSR,pca9539_show,pca9539_store,enum_
name)
+
+PCA9539_ENTRY_RO(input0,  PCA9539_INPUT_0);
+PCA9539_ENTRY_RO(input1,  PCA9539_INPUT_1);
+PCA9539_ENTRY_RW(output0, PCA9539_OUTPUT_0);
+PCA9539_ENTRY_RW(output1, PCA9539_OUTPUT_1);
+PCA9539_ENTRY_RW(invert0, PCA9539_INVERT_0);
+PCA9539_ENTRY_RW(invert1, PCA9539_INVERT_1);
+PCA9539_ENTRY_RW(config0, PCA9539_CONFIG_0);
+PCA9539_ENTRY_RW(config1, PCA9539_CONFIG_1);
+
+static struct attribute *pca9539_attributes[] = {
+	&sensor_dev_attr_input0.dev_attr.attr,
+	&sensor_dev_attr_input1.dev_attr.attr,
+	&sensor_dev_attr_output0.dev_attr.attr,
+	&sensor_dev_attr_output1.dev_attr.attr,
+	&sensor_dev_attr_invert0.dev_attr.attr,
+	&sensor_dev_attr_invert1.dev_attr.attr,
+	&sensor_dev_attr_config0.dev_attr.attr,
+	&sensor_dev_attr_config1.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group pca9539_defattr_group = {
+	.attrs = pca9539_attributes,
+};
+
+static int pca9539_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, pca9539_detect);
+}
+
+/* This function is called by i2c_detect */
+static int pca9539_detect(struct i2c_adapter *adapter, int address, int
kind)
+{
+	struct i2c_client *new_client;
+	struct pca9539_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create
the
+	   client structure, even though we cannot fill it completely
yet. */
+	if (!(data = kmalloc(sizeof(struct pca9539_data), GFP_KERNEL)))
{
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct pca9539_data));
+	
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &pca9539_driver;
+	new_client->flags = 0;
+
+	/* Detection: not sure how to do that... 
+	 * possibility: toggle the value read from invert0 and see if
input0
+	 * changes polarity. 
+	 * However, if the inputs are changing, this won't work.
+	 */
+	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_kfree;
+
+	/* Register sysfs hooks */
+	return sysfs_create_group(&new_client->dev.kobj,
&pca9539_defattr_group);
+
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int pca9539_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not
detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static int __init pca9539_init(void)
+{
+	return i2c_add_driver(&pca9539_driver);
+}
+
+static void __exit pca9539_exit(void)
+{
+	i2c_del_driver(&pca9539_driver);
+}
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("PCA9539 driver");
+MODULE_LICENSE("GPL");
+
+module_init(pca9539_init);
+module_exit(pca9539_exit);
+

