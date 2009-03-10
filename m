From: Martin Michlmayr <tbm@cyrius.com>
Date: Tue, 10 Mar 2009 09:21:19 +0000
Subject: [lm-sensors] [RFH] GMT G760A fan speed PWM controller
Message-Id: <20090310092119.GA3260@deprecation.cyrius.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Herbert Valerio Riedel originally submitted a driver for the GMT G760A
fan speed PWM controller in December 2007:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022161.html
Jean Delvare kindly reviewed the driver and provided some comments:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022291.html
Unfortunately, Herbert became busy and never got the time to finish
the driver.

Matt Palmer later made some modifications to Herbert's patch and came
up with the attached patch, but he also doesn't have the time to push
for mainline inclusion.

The GMT G760A is used on the D-Link DNS-323, which is a pretty popular
NAS device: http://wiki.dns323.info/  Even though there is a
reasonable community around Linux on the DNS-323, it seems that
there's nobody with the time and knowledge to finish this driver for
mainline inclusion.

I'd therefore like to ask the lm-sensors community for help to get
this driver into the mainline.  I'd be happy to test the driver on my
DNS-323.

The current version of the patch (from Matt Palmer) is attached below.
Note that it doesn't seem to work for me - the g760a module doesn't
get loaded, even though the DNS-323 board code loads it.  (The lm75
module, which is also loaded from the DNS-323 board code, is properly
loaded, though, so I suspect it's a problem with the g760a patch.)

-- 
Martin Michlmayr
http://www.cyrius.com/

--SUOF0GtieIMvvwua
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="g760a.patch"

From: Herbert Valerio Riedel <hvr at gnu.org>
Subject: hwmon: add support for GMT G760A fan speed PWM controller

This controller can be found on the D-Link DNS-323 for instance,
where it is to be configured via static i2c_board_info in the
board-specific mach-orion/dns323-setup.c; this driver supports only
the new-style driver model.

Signed-off-by: Herbert Valerio Riedel <hvr at gnu.org>
Signed-off-by: Matthew Palmer <mpalmer@debian.org>

--- linux-2.6-2.6.26.orig/Documentation/hwmon/g760a	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6-2.6.26.i2c/Documentation/hwmon/g760a	2008-10-26 09:11:20.000000000 +1100
@@ -0,0 +1,37 @@
+Kernel driver g760a
+===================
+
+Supported chips:
+  * Global Mixed-mode Technology Inc. G760A
+    Prefix: 'g760a'
+    Datasheet: Publicly available at the GMT website
+      http://www.gmt.com.tw/datasheet/g760a.pdf
+
+Author: Herbert Valerio Riedel <hvr at gnu.org>
+
+Description
+-----------
+
+The GMT G760A Fan Speed PWM Controller is connected directly to a fan
+and performs closed-loop control of the fan speed.
+
+The fan speed is programmed by setting the period via 'pwm1' of two
+consecutive speed pulses. The period is defined in terms of clock
+cycle counts of an assumed 32kHz clock source.
+
+Setting a period of 0 stops the fan; setting the period to 255 sets
+fan to maximum speed.
+
+The measured fan rotation speed returned via 'fan1_input' is derived
+from the measured speed pulse period by assuming again a 32kHz clock
+source and a 2 pulse-per-revolution fan.
+
+The 'alarms' file provides access to the two alarm bits provided by
+the G760A chip's status register: Bit 0 is set when the actual fan
+speed differs more than 20% with respect to the programmed fan speed;
+bit 1 is set when fan speed is below 1920 rpm.
+ 
+The g760a driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
+
diff -urN linux-2.6-2.6.26.orig/drivers/hwmon/g760a.c linux-2.6-2.6.26.i2c/drivers/hwmon/g760a.c
--- linux-2.6-2.6.26.orig/drivers/hwmon/g760a.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6-2.6.26.i2c/drivers/hwmon/g760a.c	2008-10-26 12:32:11.000000000 +1100
@@ -0,0 +1,271 @@
+/*
+    g760a - Driver for the Global Mixed-mode Technology Inc. G760A
+	    fan speed PWM controller chip
+
+    Copyright (C) 2007  Herbert Valerio Riedel <hvr at gnu.org>
+
+    Complete datasheet is available at GMT's website:
+      http://www.gmt.com.tw/datasheet/g760a.pdf
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+enum g760a_regs {
+	G760A_REG_SET_CNT = 0x00,
+	G760A_REG_ACT_CNT = 0x01,
+	G760A_REG_FAN_STA = 0x02
+};
+
+#define G760A_REG_FAN_STA_RPM_OFF 0x1 /* 20% off */
+#define G760A_REG_FAN_STA_RPM_LOW 0x2 /* below 1920rpm */
+
+/* register data is read (and cached) at most once per second */
+#define G760A_UPDATE_INTERVAL (HZ)
+
+struct g760a_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+
+	/* board specific parameters */
+	u32 clk; /* default 32kHz */
+	u16 fan_div; /* default P=2 */
+
+	/* g760a register cache */
+	int valid:1;
+	unsigned long last_updated; /* In jiffies */
+
+	u8 set_cnt; /* PWM (period) count number; 0xff stops fan	*/
+	u8 act_cnt; /*   formula: cnt = (CLK * 30)/(rpm * P)		*/
+	u8 fan_sta; /* bit 0: set when actual fan speed more than %20
+		     *   outside requested fan speed
+		     * bit 1: set when fan speed below 1920 rpm		*/
+};
+
+#define G760A_DEFAULT_CLK 32768
+#define G760A_DEFAULT_FAN_DIV 2
+
+#define RPM_FROM_REG(val, clk, div) \
+	((0x00 == (val)) ? 0 : (((clk)*30)/((val)*(div))))
+
+#define PWM_FROM_CNT(cnt)	(0xff-(cnt))
+#define PWM_TO_CNT(pwm)		(0xff-(pwm))
+
+/* new-style driver model */
+static int g760a_probe(struct i2c_client *client);
+static int g760a_remove(struct i2c_client *client);
+
+static struct i2c_driver g760a_driver = {
+	.driver = {
+		.name	= "g760a",
+	},
+	.probe	= g760a_probe,
+	.remove	= g760a_remove,
+};
+
+/* read/write wrappers */
+static int g760a_read_value(struct i2c_client *client, enum g760a_regs reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int g760a_write_value(struct i2c_client *client, enum g760a_regs reg,
+			     u16 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/****************************************************************************
+ * sysfs attributes
+ */
+
+static struct g760a_data *g760a_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g760a_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + G760A_UPDATE_INTERVAL)
+	    || !data->valid) {
+		dev_dbg(&client->dev, "Starting g760a update\n");
+
+		data->set_cnt = g760a_read_value(client, G760A_REG_SET_CNT);
+		data->act_cnt = g760a_read_value(client, G760A_REG_ACT_CNT);
+		data->fan_sta = g760a_read_value(client, G760A_REG_FAN_STA);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static ssize_t show_fan(struct device *dev, struct device_attribute *da,
+			char *buf)
+{
+	struct g760a_data *data = g760a_update_client(dev);
+	int rpm = 0;
+
+	mutex_lock(&data->update_lock);
+	if (!(data->fan_sta & G760A_REG_FAN_STA_RPM_LOW))
+		rpm = RPM_FROM_REG(data->act_cnt, data->clk, data->fan_div);
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t show_fan_alarm(struct device *dev, struct device_attribute *da,
+			      char *buf)
+{
+	struct g760a_data *data = g760a_update_client(dev);
+
+	int fan_alarm = (data->fan_sta & G760A_REG_FAN_STA_RPM_OFF) ? 1 : 0;
+
+	return sprintf(buf, "%d\n", fan_alarm);
+}
+
+static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	struct g760a_data *data = g760a_update_client(dev);
+
+	return sprintf(buf, "%d\n", PWM_FROM_CNT(data->set_cnt));
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
+		       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g760a_data *data = g760a_update_client(dev);
+
+	const long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->set_cnt = PWM_TO_CNT(SENSORS_LIMIT(val, 0, 255));
+	g760a_write_value(client, G760A_REG_SET_CNT, data->set_cnt);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
+static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
+
+static struct attribute *g760a_attributes[] = {
+	&dev_attr_pwm1.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_alarm.attr,
+	NULL
+};
+
+static const struct attribute_group g760a_group = {
+	.attrs = g760a_attributes,
+};
+
+/****************************************************************************
+ * new-style driver model code
+ */
+
+static int g760a_probe(struct i2c_client *client)
+{
+	struct g760a_data *data;
+	int err;
+
+	printk(KERN_INFO "g760a_probe\n");
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(struct g760a_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	/* setup default configuration for now */
+	data->fan_div = G760A_DEFAULT_FAN_DIV;
+	data->clk = G760A_DEFAULT_CLK;
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &g760a_group);
+	if (err) {
+		printk(KERN_ERR "Failed to create sysfs group: %i\n", err);
+		goto error_sysfs_create_group;
+	}
+	
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		printk(KERN_ERR "Failed to register hwmon device\n");
+		err = PTR_ERR(data->hwmon_dev);
+		goto error_hwmon_device_register;
+	}
+
+	return 0;
+
+error_hwmon_device_register:
+	sysfs_remove_group(&client->dev.kobj, &g760a_group);
+error_sysfs_create_group:
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+
+	return err;
+}
+
+static int g760a_remove(struct i2c_client *client)
+{
+	struct g760a_data *data = i2c_get_clientdata(client);
+
+	printk(KERN_INFO "g760a_remove\n");
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &g760a_group);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+/* module management */
+
+static int __init g760a_init(void)
+{
+	int rv;
+	
+	printk(KERN_INFO "g760a_init\n");
+	rv = i2c_add_driver(&g760a_driver);
+	printk(KERN_INFO "i2c_add_driver returned %i\n", rv);
+	return rv;
+}
+
+static void __exit g760a_exit(void)
+{
+	printk(KERN_INFO "g760a_exit\n");
+	i2c_del_driver(&g760a_driver);
+}
+
+MODULE_AUTHOR("Herbert Valerio Riedel <hvr at gnu.org>");
+MODULE_DESCRIPTION("GMT G760A driver");
+MODULE_LICENSE("GPL");
+
+module_init(g760a_init);
+module_exit(g760a_exit);
--- linux-2.6-2.6.26.orig/drivers/hwmon/Kconfig	2008-07-14 07:51:29.000000000 +1000
+++ linux-2.6-2.6.26.i2c/drivers/hwmon/Kconfig	2008-10-26 09:11:20.000000000 +1100
@@ -301,6 +301,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called fschmd.
 
+config SENSORS_G760A
+	tristate "GMT G760A"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G760A fan speed pwm controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g760a.
+
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
--- linux-2.6-2.6.26.orig/drivers/hwmon/Makefile	2008-07-14 07:51:29.000000000 +1000
+++ linux-2.6-2.6.26.i2c/drivers/hwmon/Makefile	2008-10-26 09:11:20.000000000 +1100
@@ -37,6 +37,7 @@
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
+obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--SUOF0GtieIMvvwua--
