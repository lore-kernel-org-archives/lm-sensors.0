From: Herbert Valerio Riedel <hvr@gnu.org>
Date: Thu, 15 Nov 2007 11:22:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: add support for GMT G760A fan speed PWM
Message-Id: <200711151124.lAFBOFGj010650@shswe.swe>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This controller can be found on the D-Link DNS-323 for instance, 
where it is to be configured via static i2c_board_info in the
board-specific mach-orion/dns323-setup.c
(therefore I'm also providing new-style driver model compatibility)

As this is my first attempt at writing a hwmon driver... please be 
patience with me if I didn't get it right :-)

Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>
---
 Documentation/hwmon/g760a |   38 +++++
 drivers/hwmon/Kconfig     |   10 ++
 drivers/hwmon/Makefile    |    1 +
 drivers/hwmon/g760a.c     |  378 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h    |    1 +
 5 files changed, 428 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/g760a
 create mode 100644 drivers/hwmon/g760a.c

diff --git a/Documentation/hwmon/g760a b/Documentation/hwmon/g760a
new file mode 100644
index 0000000..1992ea2
--- /dev/null
+++ b/Documentation/hwmon/g760a
@@ -0,0 +1,38 @@
+Kernel driver g760a
+=========+
+Supported chips:
+  * Global Mixed-mode Technology Inc. G760A
+    Prefix: 'g760a'
+    Addresses scanned: I2C 0x3e
+    Datasheet: Publicly available at the GMT website
+      http://www.gmt.com.tw/datasheet/g760a.pdf
+
+Author: Herbert Valerio Riedel <hvr@gnu.org>
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
+Setting a period of 255 stops the fan; setting the period to 0 sets
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
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 700a165..f7a3843 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -281,6 +281,16 @@ config SENSORS_FSCHMD
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
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 6da3eef..89657af 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
+obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
new file mode 100644
index 0000000..972d796
--- /dev/null
+++ b/drivers/hwmon/g760a.c
@@ -0,0 +1,378 @@
+/*
+    g760a - Driver for the Global Mixed-mode Technology Inc. G760A
+	    fan speed PWM controller chip
+
+    Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
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
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x3e, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(g760a);
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
+	((0x00 = (val)) ? 0 : (((clk)*30)/((val)*(div))))
+
+/* legacy driver model */
+static int g760a_attach_adapter(struct i2c_adapter *adapter);
+static int g760a_detach_client(struct i2c_client *client);
+
+static struct i2c_driver g760a_legacy_driver = {
+	.driver = {
+		.name	= "g760a_legacy",
+	},
+	.id		= I2C_DRIVERID_G760A,
+	.attach_adapter	= g760a_attach_adapter,
+	.detach_client	= g760a_detach_client,
+};
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
+		       char *buf)
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
+static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct g760a_data *data = g760a_update_client(dev);
+
+	return sprintf(buf, "%d\n", data->fan_sta & 0x3);
+}
+
+static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	struct g760a_data *data = g760a_update_client(dev);
+
+	return sprintf(buf, "%d\n", data->set_cnt);
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
+	data->set_cnt = SENSORS_LIMIT(val, 0, 255);
+	g760a_write_value(client, G760A_REG_SET_CNT, data->set_cnt);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static struct attribute *g760a_attributes[] = {
+	&dev_attr_pwm1.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_alarms.attr,
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
+	if (err)
+		goto error_sysfs_create_group;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
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
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &g760a_group);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+
+/****************************************************************************
+ * legacy driver model code
+ */
+
+static int g760a_detect(struct i2c_adapter *adapter, int address, int kind);
+
+static int g760a_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, g760a_detect);
+}
+
+static int g760a_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	int err = 0, i, set_cnt;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!client) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &g760a_legacy_driver;
+
+	/* use heuristics to detect chip */
+	set_cnt = i2c_smbus_read_byte_data(client, 0);
+	for (i = 0; i < 0x100; i += 4) {
+		/* verify that register 0 is mirrored every 4th position */
+		if (i2c_smbus_read_byte_data(client, i) != set_cnt)
+			goto exit_free;
+
+		/* test for unused bits */
+		if (i2c_smbus_read_byte_data(client, i+2) & 0xfc)
+			goto exit_free;
+
+		/* test for 0xff pattern */
+		if (i2c_smbus_read_byte_data(client, i+3) != 0xff)
+			goto exit_free;
+	}
+
+	/* Fill in client name */
+	strlcpy(client->name, "g760a", I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+	err = i2c_attach_client(client);
+	if (err)
+		goto exit_free;
+
+	/* delegate remaining setup to new-style code */
+	err = g760a_probe(client);
+	if (err < 0)
+		goto exit_detach;
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(client);
+exit:
+	return err;
+}
+
+static int g760a_detach_client(struct i2c_client *client)
+{
+	struct g760a_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &g760a_group);
+
+	err = i2c_detach_client(client);
+	if (err)
+		return err;
+
+	kfree(data);
+
+	return 0;
+}
+
+/* module management */
+
+static int __init g760a_init(void)
+{
+	int rc;
+
+	rc = i2c_add_driver(&g760a_driver);
+	if (rc < 0)
+		goto error_add;
+
+	rc = i2c_add_driver(&g760a_legacy_driver);
+	if (rc < 0)
+		goto error_add_legacy;
+
+	return 0;
+
+error_add_legacy:
+	i2c_del_driver(&g760a_driver);
+error_add:
+	return rc;
+}
+
+static void __exit g760a_exit(void)
+{
+	i2c_del_driver(&g760a_driver);
+	i2c_del_driver(&g760a_legacy_driver);
+}
+
+MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
+MODULE_DESCRIPTION("GMT G760A driver");
+MODULE_LICENSE("GPL");
+
+module_init(g760a_init);
+module_exit(g760a_exit);
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 88c8140..47b8a11 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -163,6 +163,7 @@
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
+#define I2C_DRIVERID_G760A 1049
 
 /*
  * ---- Adapter types ----------------------------------------------------
-- 
1.5.3.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
