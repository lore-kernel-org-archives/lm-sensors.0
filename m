From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 05 May 2008 17:11:50 +0000
Subject: [lm-sensors] [Patch] max1236-9 ADC support
Message-Id: <481F3FD6.6090605@cam.ac.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040803040009030008020503"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040803040009030008020503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Initial support for Maxim MAX1236, MAX1237, MAX1238 and MAX1239 ADCs.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---

The max123x chips are 4 / 12 input 12-bit ADCs.
I'm not sure Hardware Monitoring is the correct place to put this in the kernel,
but it seemed the most appropriate as you already have one straight ADC
and the particular board I have with one of these on is using it for power
monitoring.

All comments / feedback welcomed as I am still fairly new to driver writing.

  Kconfig   |   10 +
  Makefile  |    1
  max123x.c |  449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 460 insertions(+)

--

--------------040803040009030008020503
Content-Type: text/x-patch;
 name="max123x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max123x.patch"

--- a/drivers/hwmon/Kconfig	2008-04-17 03:49:44.000000000 +0100
+++ c/drivers/hwmon/Kconfig	2008-05-05 18:01:01.000000000 +0100
@@ -489,6 +489,16 @@ config SENSORS_LM93
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm93.
 
+config SENSORS_MAX123X
+       tristate "Maxim MAX1236 - MAX1239 ADC chips"
+       depends on I2C && EXPERIMENTAL
+       help 
+         If you say yes here you get support for the MAX1236 and MAX1237
+	 4 input ADC chips and the MAX1238 and MAX1239 12 input ADC chips.
+
+	 This driver can also be built as a module. If so, the module
+	 will be called max123x.
+
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on I2C
--- a/drivers/hwmon/Makefile	2008-04-17 03:49:44.000000000 +0100
+++ c/drivers/hwmon/Makefile	2008-05-05 12:57:19.000000000 +0100
@@ -56,6 +56,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
+obj-$(CONFIG_SENSORS_MAX123X)   += max123x.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
--- a/drivers/hwmon/max123x.c	1970-01-01 01:00:00.000000000 +0100
+++ c/drivers/hwmon/max123x.c	2008-05-05 18:00:33.000000000 +0100
@@ -0,0 +1,449 @@
+/*
+ * max123x.c - lm_sensors driver for max1236-max1239 12-bit ADCs
+ * (C) 2008 Jonathan Cameron <jic23@cam.ac.uk>
+ *
+ * This driver is based on the ads7828 lm_sensors/hwmon driver
+ * with some portions from intels max123x driver which forms part
+ * of the platformx distribution for the stargate2.
+ *
+ * Written by Jonathan Cameron <jic23@cam.ac.uk>
+ *
+ * Datasheet available at
+ * http://datasheets.maxim-ic.com/en/ds/MAX1236-MAX1239M.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Currently unsupported:
+ *
+ * Selecting channel other than last one.
+ * Scan modes other than read all.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+
+
+/* The max123x registers */
+#define MAX123X_SETUP_BYTE(a)     0x80 | a
+#define MAX123X_CONF_BYTE(a)      0x00 | a
+
+/* Other options for this not handled */
+#define MAX123X_REF_VDD           0x00
+#define MAX123X_REF_EXT           0x20
+#define MAX123X_REF_INT           0x50
+
+#define MAX123X_EXT_CLK           0x08
+#define MAX123X_INT_CLK           0x00
+
+#define MAX123X_BIPOLAR           0x04
+#define MAX123X_UNIPOLAR          0x00
+
+#define MAX123X_NO_CONFREG_RESET  0x02
+
+/* Scan mode selection has not been implemented */
+#define MAX123X_SCAN_TO_CHANNEL   0x00
+#define MAX123X_SCAN_CHANNEL_X_8  0x20
+#define MAX123X_SCAN_MID_TO_CHAN  0x40
+#define MAX123X_SCAN_CHANNEL_X_1  0x60
+
+#define MAX123X_CHANNEL_SEL(a)    (a & 0x0F) << 1
+#define MAX123X_SE                0x01
+#define MAX123X_DIFF              0x00
+
+struct max123x_chip_info {
+	const char *name;
+	u8 num_inputs;
+	u16 int_vref_mv;
+};
+
+static const struct max123x_chip_info max123x_chip_info_tbl[] = {
+	{
+		.name = "max1236",
+		.num_inputs = 4,
+		.int_vref_mv = 4096,
+	},
+	{
+		.name = "max1237",
+		.num_inputs = 4,
+		.int_vref_mv = 2048,
+	},
+	{
+		.name = "max1238",
+		.num_inputs = 12,
+		.int_vref_mv = 4096,
+	},
+	{
+		.name = "max1239",
+		.num_inputs = 12,
+		.int_vref_mv = 2048,
+	},
+};
+
+/* Module parameters */
+static int se_input     = 1; /* Default is SE, 0 == diff */
+static int de_input_rev;     /* Default 0 = -, 1 = + etc */
+static int ref_ext;          /* Default internal reference */
+static int ref_ext_vdd;      /* Default AIN_3 used as reference */
+static int ext_clk;          /* Default internal clock */
+static int bipolar;          /* Default to unipolar operation */
+
+module_param(se_input,     bool, S_IRUGO);
+module_param(de_input_rev, bool, S_IRUGO);
+module_param(ref_ext,      bool, S_IRUGO);
+module_param(ref_ext_vdd,  bool, S_IRUGO);
+module_param(ext_clk,      bool, S_IRUGO);
+module_param(bipolar,      bool, S_IRUGO);
+
+/* Global Vairables */
+static u8 max123x_conf_byte;
+static u8 max123x_setup_byte;
+
+/* Client data */
+struct max123x_data {
+	struct i2c_client client;
+	struct device *hwmon_dev;
+	const struct max123x_chip_info *chip_info;
+	struct mutex update_lock;
+	/* used to monitor which attribute group is in use */
+	const struct attribute_group *ag;
+};
+
+static int max123x_read(struct i2c_client *client,
+			unsigned char *buf,
+			unsigned char len)
+{
+	int ret = -EIO;
+	struct i2c_msg msg = { client->addr, I2C_M_RD, len, buf};
+
+	if (!buf) {
+		ret = -EINVAL;
+		goto done;
+	}
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret == 1)
+		ret = 0;
+
+done:
+	return ret;
+}
+
+static int max123x_write(struct i2c_client *client,
+			 unsigned char data1,
+			 unsigned char data2)
+{
+	int ret = 0;
+	struct i2c_msg wr;
+	unsigned char dat[2] = { data1, data2 };
+
+	wr.addr = client->addr;
+	wr.flags = 0;
+	wr.len = 2;
+	wr.buf = dat;
+	ret = i2c_transfer(client->adapter, &wr, 1);
+	if (ret == 1)
+		ret = 0;
+
+	return ret;
+}
+
+/* sysfs callback function */
+static ssize_t show_in(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	int ret, len = 0;
+	s16 val;
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max123x_data *data = i2c_get_clientdata(client);
+	/* overkill for the 4 input devices */
+	u8 databuf[24];
+
+	/* direct read from the device */
+	ret = max123x_read(client, databuf, data->chip_info->num_inputs*2);
+	if (ret)
+		return -EIO;
+	/* in bipolar differential mode this will be a 2's complement value */
+	if ((!se_input) && bipolar) {
+		val = ((databuf[attr->index*2]&0xf)*256 +
+		       databuf[attr->index*2+1]);
+		/* Propagate the sign bit */
+		val |= val&0x80 ? 0xF0 : 0x00;
+	} else {
+		val = (databuf[attr->index*2]&0xf)*256 +
+			databuf[attr->index*2+1];
+	}
+	/* technically this could be a float if vref = 2048*/
+	len += sprintf(buf+len, "%d\n",
+		       (val * data->chip_info->int_vref_mv) / 4096);
+
+	return len;
+}
+
+#define MAX123X_SE_INPUT(offset)					\
+	static SENSOR_DEVICE_ATTR(in##offset##_se_input,		\
+				  S_IRUGO, show_in,			\
+				  NULL, offset)
+
+#define MAX123X_DE_INPUT(offset1, offset2)				\
+	static SENSOR_DEVICE_ATTR(in##offset1##_##offset2##_de_input,	\
+				  S_IRUGO, show_in,			\
+				  NULL, offset1/2)
+
+#define MAX123X_DE_REV_INPUT(offset1, offset2)				\
+	static SENSOR_DEVICE_ATTR(in##offset1##_##offset2##_de_input,	\
+				  S_IRUGO, show_in,			\
+				  NULL, offset2/2)
+
+
+MAX123X_SE_INPUT(0);
+MAX123X_SE_INPUT(1);
+MAX123X_SE_INPUT(2);
+MAX123X_SE_INPUT(3);
+MAX123X_SE_INPUT(4);
+MAX123X_SE_INPUT(5);
+MAX123X_SE_INPUT(6);
+MAX123X_SE_INPUT(7);
+MAX123X_SE_INPUT(8);
+MAX123X_SE_INPUT(9);
+MAX123X_SE_INPUT(10);
+MAX123X_SE_INPUT(11);
+
+MAX123X_DE_INPUT(0, 1);
+MAX123X_DE_INPUT(2, 3);
+MAX123X_DE_INPUT(4, 5);
+MAX123X_DE_INPUT(6, 7);
+MAX123X_DE_INPUT(8, 9);
+MAX123X_DE_INPUT(10, 11);
+
+MAX123X_DE_REV_INPUT(1, 0);
+MAX123X_DE_REV_INPUT(3, 2);
+MAX123X_DE_REV_INPUT(5, 4);
+MAX123X_DE_REV_INPUT(7, 6);
+MAX123X_DE_REV_INPUT(9, 8);
+MAX123X_DE_REV_INPUT(11, 10);
+
+
+static struct attribute *max123_67_se_attributes[] = {
+	&sensor_dev_attr_in0_se_input.dev_attr.attr,
+	&sensor_dev_attr_in1_se_input.dev_attr.attr,
+	&sensor_dev_attr_in2_se_input.dev_attr.attr,
+	&sensor_dev_attr_in3_se_input.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *max123_67_de_attributes[] = {
+	&sensor_dev_attr_in0_1_de_input.dev_attr.attr,
+	&sensor_dev_attr_in2_3_de_input.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max123_67_de_rev_attributes[] = {
+	&sensor_dev_attr_in1_0_de_input.dev_attr.attr,
+	&sensor_dev_attr_in3_2_de_input.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max123_89_se_attributes[] = {
+	&sensor_dev_attr_in0_se_input.dev_attr.attr,
+	&sensor_dev_attr_in1_se_input.dev_attr.attr,
+	&sensor_dev_attr_in2_se_input.dev_attr.attr,
+	&sensor_dev_attr_in3_se_input.dev_attr.attr,
+	&sensor_dev_attr_in4_se_input.dev_attr.attr,
+	&sensor_dev_attr_in5_se_input.dev_attr.attr,
+	&sensor_dev_attr_in6_se_input.dev_attr.attr,
+	&sensor_dev_attr_in7_se_input.dev_attr.attr,
+	&sensor_dev_attr_in8_se_input.dev_attr.attr,
+	&sensor_dev_attr_in9_se_input.dev_attr.attr,
+	&sensor_dev_attr_in10_se_input.dev_attr.attr,
+	&sensor_dev_attr_in11_se_input.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max123_89_de_attributes[] = {
+	&sensor_dev_attr_in0_1_de_input.dev_attr.attr,
+	&sensor_dev_attr_in2_3_de_input.dev_attr.attr,
+	&sensor_dev_attr_in4_5_de_input.dev_attr.attr,
+	&sensor_dev_attr_in6_7_de_input.dev_attr.attr,
+	&sensor_dev_attr_in8_9_de_input.dev_attr.attr,
+	&sensor_dev_attr_in10_11_de_input.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max123_89_de_rev_attributes[] = {
+	&sensor_dev_attr_in1_0_de_input.dev_attr.attr,
+	&sensor_dev_attr_in3_2_de_input.dev_attr.attr,
+	&sensor_dev_attr_in5_4_de_input.dev_attr.attr,
+	&sensor_dev_attr_in7_6_de_input.dev_attr.attr,
+	&sensor_dev_attr_in9_8_de_input.dev_attr.attr,
+	&sensor_dev_attr_in11_10_de_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max123_67_se_group = {
+	.attrs = max123_67_se_attributes,
+};
+
+static const struct attribute_group max123_67_de_group = {
+	.attrs = max123_67_de_attributes,
+};
+
+static const struct attribute_group max123_67_de_rev_group = {
+	.attrs = max123_67_de_rev_attributes,
+};
+
+static const struct attribute_group max123_89_se_group = {
+	.attrs = max123_89_se_attributes,
+};
+
+static const struct attribute_group max123_89_de_group = {
+	.attrs = max123_89_de_attributes,
+};
+
+static const struct attribute_group max123_89_de_rev_group = {
+	.attrs = max123_89_de_rev_attributes,
+};
+
+static int __devinit max123x_probe(struct i2c_client *client)
+{
+	int ret, i;
+	struct max123x_data *data;
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		ret = -ENODEV;
+		goto err_ret;
+	}
+
+	data = kzalloc(sizeof(struct max123x_data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_ret;
+	}
+	dev_info(&client->dev,
+		 "chip found \n");
+
+	data->chip_info = NULL;
+	for (i = 0; i < ARRAY_SIZE(max123x_chip_info_tbl); i++)
+		if (!strcmp(max123x_chip_info_tbl[i].name, client->name)) {
+			data->chip_info = &max123x_chip_info_tbl[i];
+			break;
+		};
+	if (!data->chip_info) {
+		dev_err(&client->dev, "%s is not supported\n", client->name);
+		ret = -ENODEV;
+		goto exit_free;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	if (data->chip_info->num_inputs == 4) {
+		if (se_input)
+			data->ag = &max123_67_se_group;
+		else if (de_input_rev)
+			data->ag = &max123_67_de_rev_group;
+		else
+			data->ag = &max123_67_de_group;
+	} else {
+		if (se_input)
+			data->ag = &max123_89_se_group;
+		else if (de_input_rev)
+			data->ag = &max123_89_de_rev_group;
+		else
+			data->ag = &max123_89_de_group;
+	}
+	ret = sysfs_create_group(&client->dev.kobj, data->ag);
+	if (ret)
+		goto exit_detach;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		ret = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+	/*Actually configure the device */
+	ret = max123x_write(client,
+			    MAX123X_SETUP_BYTE(max123x_setup_byte),
+			    MAX123X_CONF_BYTE(max123x_conf_byte));
+	if (ret)
+		goto exit_remove;
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, data->ag);
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(data);
+err_ret:
+	return ret;
+}
+
+static int max123x_remove(struct i2c_client *client)
+{
+	struct max123x_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, data->ag);
+	kfree(data);
+
+	return 0;
+}
+
+static struct i2c_driver max123x_driver = {
+	.driver = {
+		.name = "max123x",
+	},
+	.probe = max123x_probe,
+	.remove = max123x_remove,
+};
+
+static int __init sensors_max123x_init(void)
+{
+	/* Initialize the setup byte according to module parameters */
+	max123x_setup_byte = MAX123X_NO_CONFREG_RESET;
+	max123x_setup_byte
+		|= ref_ext ? (ref_ext_vdd ? MAX123X_REF_VDD : MAX123X_REF_EXT)
+		: MAX123X_REF_INT;
+	max123x_setup_byte |= ext_clk ? MAX123X_EXT_CLK : MAX123X_INT_CLK;
+	max123x_setup_byte |= bipolar ? MAX123X_BIPOLAR : MAX123X_UNIPOLAR;
+
+	/* Initialize the config byte according to module parameters */
+	max123x_conf_byte = 0;
+	max123x_conf_byte |= MAX123X_SCAN_TO_CHANNEL;
+	/* For max1236/7 top two bits are ignored */
+	max123x_conf_byte |= (!se_input) && de_input_rev ?
+		MAX123X_CHANNEL_SEL(10) :MAX123X_CHANNEL_SEL(11);
+	max123x_conf_byte |= se_input ? MAX123X_SE : MAX123X_DIFF;
+
+	return i2c_add_driver(&max123x_driver);
+}
+
+static void __exit sensors_max123x_exit(void)
+{
+	i2c_del_driver(&max123x_driver);
+}
+
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
+MODULE_DESCRIPTION("MAX1236, MAX1237, MAX1238 and MAX1239 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_max123x_init);
+module_exit(sensors_max123x_exit);

--------------040803040009030008020503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040803040009030008020503--
