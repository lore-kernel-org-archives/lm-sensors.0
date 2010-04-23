From: Alan Cox <alan@linux.intel.com>
Date: Fri, 23 Apr 2010 15:12:05 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100423161205.05fbed5d@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Quick review follows. There's quite some cleanup work left before this
> driver can make it upstream.

It was trimmed from a bigger and not too pretty in-house driver so that
doesn't surprise me (its also why stuff was left that wasn't used)

Rev2 below the comments

> That's not OK. The value in register 0x21 is a relative one, that
> applies to all limits. The standard hwmon interface (see
> Documentation/hwmon/sysfs-interface) says that hysteresis temperatures
> must always be exported as absolute values. This means you must do
> some computations in the driver, and you must export one hyst file
> for every affected temperature limit.

I think I now have this as you intend


> > +static ssize_t show_power_state(struct device *dev,
> > +			struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	int ret_val = i2c_smbus_read_byte_data(client, 0x03);
> > +	return sprintf(buf, "%x", (ret_val >> 6) & 1);
> > +}
> 
> Does this follow any standard? I wouldn't use hexadecimal here (even
> if it makes no practical difference for a boolean.)

It turns the device on or off. I can't find an obvious general hwmon
path for this ?

> I am curious what this "mode" is all about. It's not a standard hwmon
> attribute, and not documented in the driver.

It flips it between just monitoring, and interrupting. It's not that
relevant to the basic driver but it becomes terribly important to any
follow on stuff where the chip is being used for thermal management of
an x86 SoC platform (non PC)

> I don't understand why you use 2-parameters attributes,

Nor me ;) 


> > +static void emc1403_set_default_config(struct i2c_client *client)
> > +{
> > +	i2c_smbus_write_byte_data(client, 0x03, 0x00);
> > +	i2c_smbus_write_byte_data(client, 0x04, 0x02);
> > +	i2c_smbus_write_byte_data(client, 0x22, 0x00);
> > +}
> 
> This is horrible. Each initialization step should be documented and
> justified. In many cases, the BIOS has already setup the thermal
> sensor chip before the OS runs, and configuration should not be
> changed arbitrarily.

Removed - this can go with the platform stuff  (basically it ultimately
needs to be part of a pair of drivers - an hwmon interface in user
space and optionally a platform specific driver for some SoC systems,
but I need to work out how to keep the separation clean before I submit
any further bits in that area.

> Can I get a dump of one of these chips (use i2cdump from the i2c-tools
> package)? This would help me test the next iteration of the driver,
> and add support to sensors-detect.

I will see what I can do.

Alan

--

commit db2988e43ad4fa9ddb155d770bf00dfc3ca1010d
Author: Kalhan Trisal <kalhan.trisal at intel.com>
Date:   Thu Apr 22 17:18:55 2010 +0100

    emc1403: thermal sensor support
    
    Provides support for the emc1403 thermal sensor. Only reporting of values
    is supported. The various Moorestown specific extras to do with thermal
    alerts and the like are not in this version of the driver.
    
    Signed-off-by: Kalhan Trisal <kalhan.trisal at intel.com>
    Signed-off-by: Alan Cox <alan@linux.intel.com>

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d38447f..900784d 100644
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
@@ -1088,6 +1098,16 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
 
+config SENSORS_EMC1403
+	tristate "SMSC EMC1403 thermal sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the SMSC Devices
+	  EMC1403 temperature monitoring chip.
+
+	  Threshold values can be configured using sysfs.
+	  Data from the different diode are accessible via sysfs.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4aa1a3d..1e6b083 100644
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
index 0000000..a7112df
--- /dev/null
+++ b/drivers/hwmon/emc1403.c
@@ -0,0 +1,393 @@
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
+/* Therm Limit reg store values */
+#define THERMAL_PID_REG		0xfd
+#define THERMAL_SMSC_ID_REG	0xfe
+#define THERMAL_REVISION_REG	0xff
+
+struct thermal_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+};
+
+/* A mutex per device is overkill here, one will do nicely */
+static DEFINE_MUTEX(reg_mutex);
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
+	return sprintf(buf, "%d0000\n", retval);
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
+	retval = i2c_smbus_write_byte_data(client, sda->index, val / 1000);
+	if (retval < 0)
+		return retval;
+	return count;
+}
+
+static ssize_t show_hyst(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	int retval;
+	int hyst;
+
+	retval = i2c_smbus_read_byte_data(client, sda->index);
+	if (retval < 0)
+		return retval;
+
+	hyst = i2c_smbus_read_byte_data(client, 0x21);
+	if (hyst < 0)
+		return retval;
+
+	return sprintf(buf, "%d0000\n", retval - hyst);
+}
+
+/* Control whether the device is powere don or off */
+static ssize_t show_power_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int retval = i2c_smbus_read_byte_data(client, 0x03);
+	return sprintf(buf, "%d", (retval >> 6) & 1);
+}
+
+static ssize_t store_power_state(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	u8 curr_val;
+	int retval;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&reg_mutex);
+	curr_val = i2c_smbus_read_byte_data(client, 0x03);
+	if (val = 1)
+		curr_val &= 0xBF;
+	else if (val = 0)
+		curr_val |= 0x40;
+	else {
+		mutex_unlock(&reg_mutex);
+		return -EINVAL;
+	}
+
+	retval = i2c_smbus_write_byte_data(client, 0x03, curr_val);
+
+	mutex_unlock(&reg_mutex);
+	if (retval < 0)
+		return retval;
+	
+	return count;
+}
+
+/* Report whether the device is reporting alarms by interrupt */
+static ssize_t show_mode(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int retval = i2c_smbus_read_byte_data(client, 0x03);
+	if (retval < 0)
+		return retval;
+	return sprintf(buf, "%d", (retval >> 7) & 1);
+}
+
+static ssize_t store_mode(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int curr_val;
+	int retval;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&reg_mutex);
+	curr_val = i2c_smbus_read_byte_data(client, 0x03);
+	if (val = 1)
+		curr_val &= 0x7F;
+	else if (val = 0)
+		curr_val |= 0x80;
+	else {
+		mutex_unlock(&reg_mutex);
+		return -EINVAL;
+	}
+
+	retval = i2c_smbus_write_byte_data(client, 0x03, curr_val);
+	mutex_unlock(&reg_mutex);
+	if (retval < 0)
+		return retval;
+	return count;
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
+static SENSOR_DEVICE_ATTR(temp1_curr, S_IRUGO, show_temp, NULL, 0x00);
+static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x01);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_temp, 0x20);
+
+static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x08);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x07);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x19);
+static SENSOR_DEVICE_ATTR(temp2_curr, S_IRUGO, show_temp, NULL, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x02);
+static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x02);
+static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x02);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_temp, 0x19);
+
+static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x16);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x15);
+static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x1A);
+static SENSOR_DEVICE_ATTR(temp3_curr, S_IRUGO, show_temp, NULL, 0x23);
+static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x04);
+static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x04);
+static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x04);
+static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_temp, 0x1A);
+
+static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
+	show_power_state, store_power_state);
+static DEVICE_ATTR(alarm_interrupt, S_IRUGO | S_IWUSR, show_mode, store_mode);
+
+static struct attribute *mid_att_thermal[] = {
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_curr.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_curr.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_curr.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	&dev_attr_power_state.attr,
+	&dev_attr_alarm_interrupt.attr,
+	NULL
+};
+
+static const struct attribute_group m_thermal_gr = {
+	.attrs = mid_att_thermal
+};
+
+/* We will need this for MRST platforms but can't enable it until the
+   relevant auto-detection patch is upstream for x86 */
+
+static void emc1403_set_default_config(struct i2c_client *client)
+{
+/*
+	i2c_smbus_write_byte_data(client, 0x03, 0x00);
+	i2c_smbus_write_byte_data(client, 0x04, 0x02);
+	i2c_smbus_write_byte_data(client, 0x22, 0x00);
+*/
+}
+
+
+static int emc1403_detect(struct i2c_client *client,
+			struct i2c_board_info *info)
+{
+	int id;
+	/* Check if thermal chip is SMSC and EMC1403 */
+	id = i2c_smbus_read_byte_data(client, THERMAL_SMSC_ID_REG);
+	if (id != 0x5d)
+		return -ENODEV;
+	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
+
+	/* Note: 0x25 is the 1404 which is very similar and this
+	   driver could be extended */
+	if (id != 0x21)
+		return -ENODEV;
+	id = i2c_smbus_read_byte_data(client,
+				THERMAL_REVISION_REG);
+	if (id != 0x01)
+		return -ENODEV;
+	return 0;
+}
+
+static int emc1403_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int res = 0;
+	struct thermal_data *data;
+
+	data = kzalloc(sizeof(struct thermal_data), GFP_KERNEL);
+	if (data = NULL) {
+		dev_warn(&client->dev, "emc1403: out of memory");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
+	if (res) {
+		dev_warn(&client->dev, "emc1403: create group failed\n");
+		hwmon_device_unregister(data->hwmon_dev);
+		goto thermal_error1;
+	}
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+		dev_warn(&client->dev, "emc1403: register hwmon dev failed\n");
+		goto thermal_error2;
+	}
+	emc1403_set_default_config(client);
+	dev_info(&client->dev, "%s EMC1403 Thermal chip found\n",
+							client->name);
+	return res;
+
+ioerr:
+	dev_warn(&client->dev,  "emc1403: smbus transaction failed.\n");
+	goto thermal_error1;
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
+const static struct i2c_device_id emc1403_idtable[] = {
+	{ "emc1403", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
+
+static struct i2c_driver sensor_emc1403 = {
+	.driver = {
+		.name = "emc1403",
+	},
+	.detect = emc1403_detect,
+	.probe = emc1403_probe,
+	.remove = emc1403_remove,
+	.id_table = emc1403_idtable,
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
