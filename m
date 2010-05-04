From: Alan Cox <alan@linux.intel.com>
Date: Tue, 04 May 2010 11:33:00 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100504123300.44f674bc@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have no problem with individual power up/down of devices. But this
> doesn't make it a hwmon-specific requirement, so I insist that it
> doesn't belong to the hwmon framework.

I guess that can stay a vendor applied patch for now as it really isn't
obvious where else you would put it given the need to associate it
accurately with a specific emc1403.


> > +	retval = i2c_smbus_read_byte_data(client, sda->nr);
> > +	if (retval < 0)
> > +		goto fail;
> > +
> > +	retval &= sda->index;
> 
> Missing negation?

Yep but goes away removing the power bit.


> > +		goto thermal_error2;
> > +	}
> > +	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
> > +	return res;
> 
> An extra blank line here would be appreciated.

Agreed - done, and additional detection bits added from your mini-patch

Can't currently test this however.



emc1403: thermal sensor support

From: Kalhan Trisal <kalhan.trisal at intel.com>

Provides support for the emc1403 thermal sensor. Only reporting of values
is supported. The various Moorestown specific extras to do with thermal
alerts and the like are not in this version of the driver.

Considerably edited and tidied up by Alan Cox, plus fixes and detection bits
from Jean Delvare.

Signed-off-by: Kalhan Trisal <kalhan.trisal at intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1 
 drivers/hwmon/emc1403.c |  344 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/emc1403.c


diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 72b1c66..9310418 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -750,6 +750,16 @@ config SENSORS_DME1737
 	  This driver can also be built as a module.  If so, the module
 	  will be called dme1737.
 
+config SENSORS_EMC1403
+	tristate "SMSC EMC1403 thermal sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the SMSC EMC1403
+	  temperature monitoring chip.
+
+	  Threshold values can be configured using sysfs.
+	  Data from the different diodes are accessible via sysfs.
+
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
 	help
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d33bd4a..6b369d7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
 obj-$(CONFIG_SENSORS_F71882FG)	+= f71882fg.o
 obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
new file mode 100644
index 0000000..28cca34
--- /dev/null
+++ b/drivers/hwmon/emc1403.c
@@ -0,0 +1,344 @@
+/*
+ * emc1403.c - SMSC Thermal Driver
+ *
+ * Copyright (C) 2008 Intel Corp
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * TODO
+ *	-	cache alarm and critical limit registers
+ *	-	add emc1404 support
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/mutex.h>
+
+#define THERMAL_PID_REG		0xfd
+#define THERMAL_SMSC_ID_REG	0xfe
+#define THERMAL_REVISION_REG	0xff
+
+struct thermal_data {
+	struct device *hwmon_dev;
+	struct mutex mutex;
+	/* Cache the hyst value so we don't keep re-reading it. In theory
+	   we could cache it forever as nobody else should be writing it. */
+	u8 cached_hyst;
+	unsigned long hyst_valid;
+};
+
+static ssize_t show_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	int retval = i2c_smbus_read_byte_data(client, sda->index);
+
+	if (retval < 0)
+		return retval;
+	return sprintf(buf, "%d000\n", retval);
+}
+
+static ssize_t show_bit(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
+	int retval = i2c_smbus_read_byte_data(client, sda->nr);
+
+	if (retval < 0)
+		return retval;
+	retval &= sda->index;
+	return sprintf(buf, "%d\n", retval ? 1 : 0);
+}
+
+static ssize_t store_temp(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int retval;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+	retval = i2c_smbus_write_byte_data(client, sda->index,
+					DIV_ROUND_CLOSEST(val, 1000));
+	if (retval < 0)
+		return retval;
+	return count;
+}
+
+static ssize_t show_hyst(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thermal_data *data = i2c_get_clientdata(client);
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	int retval;
+	int hyst;
+
+	retval = i2c_smbus_read_byte_data(client, sda->index);
+	if (retval < 0)
+		return retval;
+
+	if (time_after(jiffies, data->hyst_valid)) {
+		hyst = i2c_smbus_read_byte_data(client, 0x21);
+		if (hyst < 0)
+			return retval;
+		data->cached_hyst = hyst;
+		data->hyst_valid = jiffies + HZ;
+	}
+	return sprintf(buf, "%d000\n", retval - data->cached_hyst);
+}
+
+static ssize_t store_hyst(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct thermal_data *data = i2c_get_clientdata(client);
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	int retval;
+	int hyst;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	retval = i2c_smbus_read_byte_data(client, sda->index);
+	if (retval < 0)
+		goto fail;
+
+	hyst = val - retval * 1000;
+	hyst = DIV_ROUND_CLOSEST(hyst, 1000);
+	if (hyst < 0 || hyst > 255) {
+		retval = -ERANGE;
+		goto fail;
+	}
+
+	retval = i2c_smbus_write_byte_data(client, 0x21, hyst);
+	if (retval = 0) {
+		retval = count;
+		data->cached_hyst = hyst;
+		data->hyst_valid = jiffies + HZ;
+	}
+fail:
+	mutex_unlock(&data->mutex);
+	return retval;
+}
+
+/*
+ *	Sensors. We pass the actual i2c register to the methods.
+ */
+
+static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x06);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x05);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x20);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0x00);
+static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x01);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_hyst, 0x20);
+
+static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x08);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x07);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x19);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x02);
+static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x02);
+static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x02);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_hyst, 0x19);
+
+static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x16);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x15);
+static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x1A);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 0x23);
+static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x04);
+static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x04);
+static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x04);
+static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_hyst, 0x1A);
+
+static struct attribute *mid_att_thermal[] = {
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group m_thermal_gr = {
+	.attrs = mid_att_thermal
+};
+
+static int emc1403_detect(struct i2c_client *client,
+			struct i2c_board_info *info)
+{
+	int id;
+	/* Check if thermal chip is SMSC and EMC1403 */
+
+	id = i2c_smbus_read_byte_data(client, THERMAL_SMSC_ID_REG);
+	if (id != 0x5d)
+		return -ENODEV;
+
+	/* Note: 0x25 is the 1404 which is very similar and this
+	   driver could be extended */
+	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
+	if (id != 0x21)
+		return -ENODEV;
+
+	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
+	if (id != 0x01)
+		return -ENODEV;
+
+	strlcpy(info->type, "emc1403", I2C_NAME_SIZE);
+	return 0;
+}
+
+static int emc1403_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int res;
+	struct thermal_data *data;
+
+	data = kzalloc(sizeof(struct thermal_data), GFP_KERNEL);
+	if (data = NULL) {
+		dev_warn(&client->dev, "out of memory");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->mutex);
+	data->hyst_valid = jiffies - 1;		/* Expired */
+
+	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
+	if (res) {
+		dev_warn(&client->dev, "create group failed\n");
+		hwmon_device_unregister(data->hwmon_dev);
+		goto thermal_error1;
+	}
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		dev_warn(&client->dev, "register hwmon dev failed\n");
+		goto thermal_error2;
+	}
+	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
+	return res;
+
+thermal_error2:
+	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
+thermal_error1:
+	kfree(data);
+	return res;
+}
+
+static int emc1403_remove(struct i2c_client *client)
+{
+	struct thermal_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
+	kfree(data);
+	return 0;
+}
+
+static const unsigned short emc1403_address_list[] = {
+	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
+};
+
+const static struct i2c_device_id emc1403_idtable[] = {
+	{ "emc1403", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
+
+static struct i2c_driver sensor_emc1403 = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "emc1403",
+	},
+	.detect = emc1403_detect,
+	.probe = emc1403_probe,
+	.remove = emc1403_remove,
+	.id_table = emc1403_idtable,
+	.address_list = emc1403_address_list,
+};
+
+static int __init sensor_emc1403_init(void)
+{
+	return i2c_add_driver(&sensor_emc1403);
+}
+
+static void  __exit sensor_emc1403_exit(void)
+{
+	i2c_del_driver(&sensor_emc1403);
+}
+
+module_init(sensor_emc1403_init);
+module_exit(sensor_emc1403_exit);
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_DESCRIPTION("emc1403 Thermal Driver");
+MODULE_LICENSE("GPL v2");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
