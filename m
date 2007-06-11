From: "Roger Lucas" <roger@planbit.co.uk>
Date: Mon, 11 Jun 2007 21:51:05 +0000
Subject: [lm-sensors] VT8231 patch to convert to platform driver
Message-Id: <000f01c7ac72$9c6c7030$8001a8c0@wolverine>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Attached is the vt8231 patch against the latest stable kernel (2.6.21.5).

It works on my VIA Epia motherboard under the 2.6.16.20 kernel.  It has the release resource problem mentioned in the
earlier mail but this should be resolved with your patch (although I haven't updated to the latest kernel and applied
your patch to explicitly test this).

Best regards,

Roger

Signed-off-by: Roger Lucas <roger@planbit.co.uk>

--- a/drivers/hwmon/vt8231.c	2007-06-11 19:37:06.000000000 +0100
+++ b/drivers/hwmon/vt8231.c	2007-06-09 11:12:15.000000000 +0100
@@ -29,8 +29,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
@@ -42,10 +41,7 @@
 module_param(force_addr, int, 0);
 MODULE_PARM_DESC(force_addr, "Initialize the base address of the sensors");
 
-/* Device address
-   Note that we can't determine the ISA address until we have initialized
-   our module */
-static unsigned short isa_address;
+static struct platform_device *pdev;
 
 #define VT8231_EXTENT 0x80
 #define VT8231_BASE_REG 0x70
@@ -148,7 +144,9 @@
 #define FAN_FROM_REG(val, div) ((val) = 0 ? 0 : 1310720 / ((val) * (div)))
 
 struct vt8231_data {
-	struct i2c_client client;
+	unsigned short addr;
+	const char *name;
+
 	struct mutex update_lock;
 	struct class_device *class_dev;
 	char valid;		/* !=0 if following fields are valid */
@@ -168,20 +166,20 @@
 };
 
 static struct pci_dev *s_bridge;
-static int vt8231_detect(struct i2c_adapter *adapter);
-static int vt8231_detach_client(struct i2c_client *client);
+static int vt8231_probe(struct platform_device *pdev);
+static int vt8231_remove(struct platform_device *pdev);
 static struct vt8231_data *vt8231_update_device(struct device *dev);
-static void vt8231_init_client(struct i2c_client *client);
+static void vt8231_init_device(struct vt8231_data *data);
 
-static inline int vt8231_read_value(struct i2c_client *client, u8 reg)
+static inline int vt8231_read_value(struct vt8231_data *data, u8 reg)
 {
-	return inb_p(client->addr + reg);
+	return inb_p(data->addr + reg);
 }
 
-static inline void vt8231_write_value(struct i2c_client *client, u8 reg,
+static inline void vt8231_write_value(struct vt8231_data *data, u8 reg,
 					u8 value)
 {
-	outb_p(value, client->addr + reg);
+	outb_p(value, data->addr + reg);
 }
 
 /* following are the sysfs callback functions */
@@ -220,13 +218,12 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
-	vt8231_write_value(client, regvoltmin[nr], data->in_min[nr]);
+	vt8231_write_value(data, regvoltmin[nr], data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -236,13 +233,12 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
-	vt8231_write_value(client, regvoltmax[nr], data->in_max[nr]);
+	vt8231_write_value(data, regvoltmax[nr], data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -278,14 +274,13 @@
 static ssize_t set_in5_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[5] = SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
 					0, 255);
-	vt8231_write_value(client, regvoltmin[5], data->in_min[5]);
+	vt8231_write_value(data, regvoltmin[5], data->in_min[5]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -293,14 +288,13 @@
 static ssize_t set_in5_max(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[5] = SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
 					0, 255);
-	vt8231_write_value(client, regvoltmax[5], data->in_max[5]);
+	vt8231_write_value(data, regvoltmax[5], data->in_max[5]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -348,26 +342,24 @@
 static ssize_t set_temp0_max(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[0] = SENSORS_LIMIT((val + 500) / 1000, 0, 255);
-	vt8231_write_value(client, regtempmax[0], data->temp_max[0]);
+	vt8231_write_value(data, regtempmax[0], data->temp_max[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp0_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[0] = SENSORS_LIMIT((val + 500) / 1000, 0, 255);
-	vt8231_write_value(client, regtempmin[0], data->temp_min[0]);
+	vt8231_write_value(data, regtempmin[0], data->temp_min[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -404,13 +396,12 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
-	vt8231_write_value(client, regtempmax[nr], data->temp_max[nr]);
+	vt8231_write_value(data, regtempmax[nr], data->temp_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -419,13 +410,12 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
-	vt8231_write_value(client, regtempmin[nr], data->temp_min[nr]);
+	vt8231_write_value(data, regtempmin[nr], data->temp_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -486,13 +476,12 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr), data->fan_min[nr]);
+	vt8231_write_value(data, VT8231_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -500,12 +489,11 @@
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = sensor_attr->index;
-	int old = vt8231_read_value(client, VT8231_REG_FANDIV);
+	int old = vt8231_read_value(data, VT8231_REG_FANDIV);
 	long min = FAN_FROM_REG(data->fan_min[nr],
 				 DIV_FROM_REG(data->fan_div[nr]));
 
@@ -516,7 +504,7 @@
 	case 4: data->fan_div[nr] = 2; break;
 	case 8: data->fan_div[nr] = 3; break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not supported."
+		dev_err(dev, "fan_div value %ld not supported."
 		        "Choose one of 1, 2, 4 or 8!\n", val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -524,10 +512,10 @@
 
 	/* Correct the fan minimum speed */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr), data->fan_min[nr]);
+	vt8231_write_value(data, VT8231_REG_FAN_MIN(nr), data->fan_min[nr]);
 
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
-	vt8231_write_value(client, VT8231_REG_FANDIV, old);
+	vt8231_write_value(data, VT8231_REG_FANDIV, old);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -551,9 +539,16 @@
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
-
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct vt8231_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *vt8231_attributes_temps[6][4] = {
 	{
 		&dev_attr_temp1_input.attr,
@@ -648,6 +643,7 @@
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -655,13 +651,13 @@
 	.attrs = vt8231_attributes,
 };
 
-static struct i2c_driver vt8231_driver = {
+static struct platform_driver vt8231_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
+		.owner  = THIS_MODULE,
 		.name	= "vt8231",
 	},
-	.attach_adapter	= vt8231_detect,
-	.detach_client	= vt8231_detach_client,
+	.probe	= vt8231_probe,
+	.remove	= __devexit_p(vt8231_remove),
 };
 
 static struct pci_device_id vt8231_pci_ids[] = {
@@ -680,75 +676,43 @@
 	.probe		= vt8231_pci_probe,
 };
 
-int vt8231_detect(struct i2c_adapter *adapter)
+int vt8231_probe(struct platform_device *pdev)
 {
-	struct i2c_client *client;
+	struct resource *res;
 	struct vt8231_data *data;
 	int err = 0, i;
-	u16 val;
-
-	/* 8231 requires multiple of 256 */
-	if (force_addr)	{
-		isa_address = force_addr & 0xFF00;
-		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n",
-				 isa_address);
-		if (PCIBIOS_SUCCESSFUL != pci_write_config_word(s_bridge,
-						VT8231_BASE_REG, isa_address))
-			return -ENODEV;
-	}
-
-	if (PCIBIOS_SUCCESSFUL !-		pci_read_config_word(s_bridge, VT8231_ENABLE_REG, &val))
-		return -ENODEV;
-
-	if (!(val & 0x0001)) {
-		dev_warn(&adapter->dev, "enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !-			pci_write_config_word(s_bridge, VT8231_ENABLE_REG,
-							  val | 0x0001))
-			return -ENODEV;
-	}
-
-	/* Reserve the ISA region */
-	if (!request_region(isa_address, VT8231_EXTENT,
-			    vt8231_pci_driver.name)) {
-		dev_err(&adapter->dev, "region 0x%x already in use!\n",
-			   isa_address);
-		return -ENODEV;
-	}
+ 
+ 	/* Reserve the ISA region */
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, VT8231_EXTENT,
+ 			    vt8231_driver.driver.name)) {
+		dev_err(&pdev->dev, "Region 0x%lx-0x%lx already in use!\n",
+			(unsigned long)res->start, (unsigned long)res->end);
+ 		return -ENODEV;
+ 	}
 
 	if (!(data = kzalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
 
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = isa_address;
-	client->adapter = adapter;
-	client->driver = &vt8231_driver;
-
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(client->name, "vt8231", I2C_NAME_SIZE);
+	platform_set_drvdata(pdev, data);
+	data->addr = res->start;
+	data->name = "vt8231";
 
 	mutex_init(&data->update_lock);
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
-
-	vt8231_init_client(client);
+	vt8231_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &vt8231_group)))
-		goto exit_detach;
+	if ((err = sysfs_create_group(&pdev->dev.kobj, &vt8231_group)))
+		goto exit_free;
 
 	/* Must update device information to find out the config field */
-	data->uch_config = vt8231_read_value(client, VT8231_REG_UCH_CONFIG);
+	data->uch_config = vt8231_read_value(data, VT8231_REG_UCH_CONFIG);
 
 	for (i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++) {
 		if (ISTEMP(i, data->uch_config)) {
-			if ((err = sysfs_create_group(&client->dev.kobj,
+			if ((err = sysfs_create_group(&pdev->dev.kobj, 
 					&vt8231_group_temps[i])))
 				goto exit_remove_files;
 		}
@@ -756,13 +720,13 @@
 
 	for (i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++) {
 		if (ISVOLT(i, data->uch_config)) {
-			if ((err = sysfs_create_group(&client->dev.kobj,
+			if ((err = sysfs_create_group(&pdev->dev.kobj, 
 					&vt8231_group_volts[i])))
 				goto exit_remove_files;
 		}
 	}
 
-	data->class_dev = hwmon_device_register(&client->dev);
+	data->class_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto exit_remove_files;
@@ -770,57 +734,52 @@
 	return 0;
 
 exit_remove_files:
-	for (i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
-		sysfs_remove_group(&client->dev.kobj, &vt8231_group_volts[i]);
+	for(i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
+		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_volts[i]);
+
+	for(i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++)
+		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_temps[i]);
 
-	for (i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++)
-		sysfs_remove_group(&client->dev.kobj, &vt8231_group_temps[i]);
+	sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
 
-	sysfs_remove_group(&client->dev.kobj, &vt8231_group);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
+
 exit_release:
-	release_region(isa_address, VT8231_EXTENT);
+	release_region(res->start, VT8231_EXTENT);
 	return err;
 }
 
-static int vt8231_detach_client(struct i2c_client *client)
+static int vt8231_remove(struct platform_device *pdev)
 {
-	struct vt8231_data *data = i2c_get_clientdata(client);
-	int err, i;
+	struct vt8231_data *data = platform_get_drvdata(pdev);
+	int i;
 
 	hwmon_device_unregister(data->class_dev);
 
-	for (i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
-		sysfs_remove_group(&client->dev.kobj, &vt8231_group_volts[i]);
+	for(i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
+		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_volts[i]);
 
-	for (i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++)
-		sysfs_remove_group(&client->dev.kobj, &vt8231_group_temps[i]);
+	for(i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++)
+		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_temps[i]);
 
-	sysfs_remove_group(&client->dev.kobj, &vt8231_group);
+	sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
 
-	if ((err = i2c_detach_client(client))) {
-		return err;
-	}
-
-	release_region(client->addr, VT8231_EXTENT);
+	release_region(data->addr, VT8231_EXTENT);
+	platform_set_drvdata(pdev,NULL);
 	kfree(data);
-
 	return 0;
 }
 
-static void vt8231_init_client(struct i2c_client *client)
+static void vt8231_init_device(struct vt8231_data *data)
 {
-	vt8231_write_value(client, VT8231_REG_TEMP1_CONFIG, 0);
-	vt8231_write_value(client, VT8231_REG_TEMP2_CONFIG, 0);
+	vt8231_write_value(data, VT8231_REG_TEMP1_CONFIG, 0);
+	vt8231_write_value(data, VT8231_REG_TEMP2_CONFIG, 0);
 }
 
 static struct vt8231_data *vt8231_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct vt8231_data *data = i2c_get_clientdata(client);
+	struct vt8231_data *data = dev_get_drvdata(dev);
 	int i;
 	u16 low;
 
@@ -830,41 +789,33 @@
 	    || !data->valid) {
 		for (i = 0; i < 6; i++) {
 			if (ISVOLT(i, data->uch_config)) {
-				data->in[i] = vt8231_read_value(client,
-						regvolt[i]);
-				data->in_min[i] = vt8231_read_value(client,
-						regvoltmin[i]);
-				data->in_max[i] = vt8231_read_value(client,
-						regvoltmax[i]);
+				data->in[i] = vt8231_read_value(data, regvolt[i]);
+				data->in_min[i] = vt8231_read_value(data,regvoltmin[i]);
+				data->in_max[i] = vt8231_read_value(data, regvoltmax[i]);
 			}
 		}
 		for (i = 0; i < 2; i++) {
-			data->fan[i] = vt8231_read_value(client,
-						VT8231_REG_FAN(i));
-			data->fan_min[i] = vt8231_read_value(client,
-						VT8231_REG_FAN_MIN(i));
+			data->fan[i] = vt8231_read_value(data, VT8231_REG_FAN(i));
+			data->fan_min[i] = vt8231_read_value(data, VT8231_REG_FAN_MIN(i));
 		}
 
-		low = vt8231_read_value(client, VT8231_REG_TEMP_LOW01);
+		low = vt8231_read_value(data, VT8231_REG_TEMP_LOW01);
 		low = (low >> 6) | ((low & 0x30) >> 2)
-		    | (vt8231_read_value(client, VT8231_REG_TEMP_LOW25) << 4);
+		    | (vt8231_read_value(data, VT8231_REG_TEMP_LOW25) << 4);
 		for (i = 0; i < 6; i++) {
 			if (ISTEMP(i, data->uch_config)) {
-				data->temp[i] = (vt8231_read_value(client,
-						       regtemp[i]) << 2)
+				data->temp[i] = (vt8231_read_value(data, regtemp[i]) << 2)
 						| ((low >> (2 * i)) & 0x03);
-				data->temp_max[i] = vt8231_read_value(client,
-						      regtempmax[i]);
-				data->temp_min[i] = vt8231_read_value(client,
-						      regtempmin[i]);
+				data->temp_max[i] = vt8231_read_value(data, regtempmax[i]);
+				data->temp_min[i] = vt8231_read_value(data, regtempmin[i]);
 			}
 		}
 
-		i = vt8231_read_value(client, VT8231_REG_FANDIV);
+		i = vt8231_read_value(data, VT8231_REG_FANDIV);
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = i >> 6;
-		data->alarms = vt8231_read_value(client, VT8231_REG_ALARM1) |
-			(vt8231_read_value(client, VT8231_REG_ALARM2) << 8);
+		data->alarms = vt8231_read_value(data, VT8231_REG_ALARM1) |
+			(vt8231_read_value(data, VT8231_REG_ALARM2) << 8);
 
 		/* Set alarm flags correctly */
 		if (!data->fan[0] && data->fan_min[0]) {
@@ -888,34 +839,103 @@
 	return data;
 }
 
+static int __devinit vt8231_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + VT8231_EXTENT - 1,
+		.name	= "vt8231",
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc("vt8231", address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "vt8231: Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR "vt8231: Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR "vt8231: Device addition failed (%d)\n",
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
 static int __devinit vt8231_pci_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
-	u16 val;
+	u16 address, val;
+	if (force_addr) {
+		address = force_addr & ~(VT8231_EXTENT - 1);
+		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n",
+			 address);
+
+		if (PCIBIOS_SUCCESSFUL !+		    pci_write_config_word(dev, VT8231_BASE_REG, address | 1))
+			return -ENODEV;
+	}
 
 	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG,
 							&val))
 		return -ENODEV;
 
-	isa_address = val & ~(VT8231_EXTENT - 1);
-	if (isa_address = 0 && force_addr = 0) {
+	address = val & ~(VT8231_EXTENT - 1);
+	if (address = 0) {
 		dev_err(&dev->dev, "base address not set -\
 				 upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
-	s_bridge = pci_dev_get(dev);
+	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_ENABLE_REG,
+							&val))
+		return -ENODEV;
 
-	if (i2c_isa_add_driver(&vt8231_driver)) {
-		pci_dev_put(s_bridge);
-		s_bridge = NULL;
+	if (!(val & 0x0001)) {
+		dev_warn(&dev->dev, "enabling sensors\n");
+		if (PCIBIOS_SUCCESSFUL !+			pci_write_config_word(s_bridge, VT8231_ENABLE_REG,
+							  val | 0x0001))
+			return -ENODEV;
 	}
 
-	/* Always return failure here.  This is to allow other drivers to bind
-	 * to this pci device.  We don't really want to have control over the
-	 * pci device, we only wanted to read as few register values from it.
-	 */
+	if (platform_driver_register(&vt8231_driver))
+		goto exit;
+
+	/* Sets global pdev as a side effect */
+	if (vt8231_device_add(address))
+		goto exit_unregister;
+
+ 	/* Always return failure here.  This is to allow other drivers to bind
+ 	 * to this pci device.  We don't really want to have control over the
+ 	 * pci device, we only wanted to read as few register values from it.
+ 	 */
+
+	// We do, however, mark ourselves as using the PCI device to stop it
+	// getting unloaded.
+	s_bridge = pci_dev_get(dev);
 	return -ENODEV;
+
+exit_unregister:
+	platform_driver_unregister(&vt8231_driver);
+exit:
+ 	return -ENODEV;
 }
 
 static int __init sm_vt8231_init(void)
@@ -927,7 +947,8 @@
 {
 	pci_unregister_driver(&vt8231_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_isa_del_driver(&vt8231_driver);
+		platform_device_unregister(pdev);
+		platform_driver_unregister(&vt8231_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
