From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <20050218154856.GA14189@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver for the TI TMP101 i2c temperature sensor chip.

Note, although the TMP101 is capable of SM-Bus alert,
I do not have that capability on any of the systems
I have these chips fitted on, so have not tested
it

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
diff -urN -X ../dontdiff linux-2.6.11-rc4-bk5/drivers/i2c/chips/Kconfig linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/Kconfig
--- linux-2.6.11-rc4-bk5/drivers/i2c/chips/Kconfig	2005-02-18 12:22:03.000000000 +0000
+++ linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/Kconfig	2005-02-18 15:40:42.000000000 +0000
@@ -264,6 +264,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m1.
 
+config SENSORS_TMP101
+	tristate "TI TMP101"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  Say y here for support for the TI TMP101 temperature monitoring
+	  chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tmp101.o
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on I2C && PCI && EXPERIMENTAL
diff -urN -X ../dontdiff linux-2.6.11-rc4-bk5/drivers/i2c/chips/Makefile linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/Makefile
--- linux-2.6.11-rc4-bk5/drivers/i2c/chips/Makefile	2005-02-18 12:22:03.000000000 +0000
+++ linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/Makefile	2005-02-18 12:41:23.000000000 +0000
@@ -32,6 +32,7 @@
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
+obj-$(CONFIG_SENSORS_TMP101)	+= tmp101.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
diff -urN -X ../dontdiff linux-2.6.11-rc4-bk5/drivers/i2c/chips/tmp101.c linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/tmp101.c
--- linux-2.6.11-rc4-bk5/drivers/i2c/chips/tmp101.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc4-bk5-tmp101/drivers/i2c/chips/tmp101.c	2005-02-18 15:36:05.000000000 +0000
@@ -0,0 +1,582 @@
+/* linux/drivers/i2c/chips/tmp101.c
+ *
+ * TI TMP101 senesor support
+ *
+ * (c) 2005 Simtec Electronics
+ *	http://www.simtec.co.uk/produces/SWLINUX/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Based on lm75.c, Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/* register defines */
+
+#define TMP101_VALUE		(0x00)
+#define TMP101_CONFIG		(0x01)
+#define TMP101_TLOW		(0x02)
+#define TMP101_THI		(0x03)
+
+#define TMP101_CONFIG_SD	(1<<0)
+#define TMP101_CONFIG_TM	(1<<1)
+#define TMP101_CONFIG_POL	(1<<2)
+#define TMP101_CONFIG_RES	(5)
+#define TMP101_CONFIG_RES_MASK	(3<<5)
+#define TMP101_CONFIG_OS	(1<<7)
+
+
+/* I2C addresses */
+
+static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+				       0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
+
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+/* forward definitions */
+
+static struct i2c_driver tmp101_driver;
+
+/* Insmod parameters */
+
+SENSORS_INSMOD_1(tmp101);
+
+/* client data */
+
+struct tmp101_data {	
+	struct i2c_client	client;
+	struct semaphore	update_lock;
+	unsigned long		last_read;
+
+	u16			temp;
+	u16			tlow;
+	u16			thigh;
+	u8			config;
+};
+
+static int tmp101_id;
+
+static inline int tval_to_degc(u16 val)
+{
+	if (val & 0x8000)
+		return -((0xffff - val) >> 8);
+
+	return val >> 8;
+}
+
+
+static int tmp101_check(struct i2c_client *cli)
+{
+	char reg = 0, data;
+	int ret;
+	int val;
+	struct i2c_msg msgs[2] = {
+		{ cli->addr, 0,        1, &reg },
+		{ cli->addr, I2C_M_RD, 1, &data }
+	};
+
+	/* check to see if there is anything there at-all */
+
+	ret = i2c_transfer(cli->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return 0;
+
+	/* do a few simple checks to see what is going on by checking
+	 * to see if our regsters wrap around at address 4. 
+	 */
+	
+	val = i2c_smbus_read_byte_data(cli, TMP101_CONFIG);
+	if (i2c_smbus_read_byte_data(cli, TMP101_CONFIG+4) != val)
+		return 0;
+
+	val = i2c_smbus_read_word_data(cli, TMP101_TLOW);
+	if (i2c_smbus_read_word_data(cli, TMP101_TLOW+4) != val)
+		return 0;
+
+	val = i2c_smbus_read_word_data(cli, TMP101_THI);
+	if (i2c_smbus_read_word_data(cli, TMP101_THI+4) != val)
+		return 0;
+
+	/* I guess we have an TMP101 */
+
+	return 1;
+}
+
+static void tmp101_start_conversion(struct tmp101_data *data)
+{
+	/* check to see if we the temperature convert has been shutdown */
+
+	if (data->config & TMP101_CONFIG_SD)
+		i2c_smbus_write_byte_data(&data->client, TMP101_CONFIG,
+					  data->config | TMP101_CONFIG_OS);
+}
+
+static int tmp101_update_data(struct tmp101_data *data)
+{
+	struct i2c_client *cli = &data->client;
+
+	dev_dbg(&cli->dev, "updating temperature data\n");
+
+	down(&data->update_lock);
+
+	data->last_read = jiffies;
+	data->config	= i2c_smbus_read_byte_data(cli, TMP101_CONFIG);
+
+	tmp101_start_conversion(data);
+
+	data->tlow	= swab16(i2c_smbus_read_word_data(cli, TMP101_TLOW));
+	data->thigh	= swab16(i2c_smbus_read_word_data(cli, TMP101_THI));
+	data->temp	= swab16(i2c_smbus_read_word_data(cli, TMP101_VALUE));
+
+	dev_dbg(&data->client.dev, "config = %02x\n", data->config);
+	dev_dbg(&data->client.dev, "temp   = %04x\n", data->temp);
+	dev_dbg(&data->client.dev, "tlow   = %04x\n", data->tlow);
+	dev_dbg(&data->client.dev, "thigh  = %04x\n", data->thigh);
+
+	up(&data->update_lock);
+	return 0;
+}
+
+static void tmp101_invalidate_data(struct tmp101_data *data)
+{
+	data->last_read--; // invalidate data
+}
+
+/* sysfs utils */
+
+static struct tmp101_data *tmp101_sysfs_update(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp101_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if (data->last_read = jiffies) {
+		up(&data->update_lock);
+		return data;
+	}
+
+	up(&data->update_lock);
+	tmp101_update_data(data);
+
+	return data;
+}
+
+static ssize_t tmp101_show_tval(char *buf, struct tmp101_data *data, int tval)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", tval_to_degc(tval));
+}
+
+static ssize_t tmp101_show_tval_raw(char *buf, struct tmp101_data *data, int tval)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", tval);
+}
+
+static ssize_t tmp101_set_tval(struct tmp101_data *data, const char *buf,
+			       size_t sz, int reg)
+{
+	long val = simple_strtol(buf, NULL, 10);
+	unsigned int regval;
+
+	if (val < -128 || val > 128)
+		return -ERANGE;
+
+	if (val > 0) {
+		regval = val << 8;
+	} else {
+		regval = 256 + val;
+		regval <<= 8;
+	}
+
+	dev_dbg(&data->client.dev, "set reg %d to 0x%04x (val %ld)\n",
+		reg, regval, val);
+
+	down(&data->update_lock);
+	i2c_smbus_write_word_data(&data->client, reg, swab16(regval));
+	tmp101_invalidate_data(data);
+	up(&data->update_lock);
+
+	return sz;
+}
+
+static ssize_t tmp101_set_tval_raw(struct tmp101_data *data, const char *buf,
+				   size_t sz, int reg)
+{
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if (val >= (1<<16))
+		return -ERANGE;
+
+	down(&data->update_lock);
+	i2c_smbus_write_word_data(&data->client, reg, swab16(val));
+	tmp101_invalidate_data(data);
+	up(&data->update_lock);
+
+	return sz;
+}
+
+static ssize_t tmp101_update_cfg(struct tmp101_data *data, const char *buf,
+				 size_t sz, int shift, int max, int offset)
+{
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	val -= offset;
+	
+	if (val > max)
+		return -EINVAL;
+
+	down(&data->update_lock);	
+	data->config &= ~(max << shift);
+	data->config |= (val << shift);
+
+	i2c_smbus_write_byte_data(&data->client, TMP101_CONFIG, data->config);
+	tmp101_invalidate_data(data);
+
+	up(&data->update_lock);
+
+	return sz;
+}
+
+
+/* sysfs files nodes */
+
+static ssize_t tmp101_show_temp(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval(buf, data, data->temp);
+}
+
+static DEVICE_ATTR(temperature, S_IRUGO, tmp101_show_temp, NULL);
+
+/* low temperature limit */
+
+static ssize_t tmp101_show_tlow(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval(buf, data, data->tlow);
+}
+
+static ssize_t tmp101_set_tlow(struct device *dev, const char *buf, size_t count)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_set_tval(data, buf, count, TMP101_TLOW);
+}
+
+static DEVICE_ATTR(talert_low,  S_IWUSR | S_IRUGO,
+		   tmp101_show_tlow, tmp101_set_tlow);
+
+/* high temperature limit */
+
+static ssize_t tmp101_show_thigh(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval(buf, data, data->thigh);
+}
+
+static ssize_t tmp101_set_thigh(struct device *dev, const char *buf, size_t count)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_set_tval(data, buf, count, TMP101_THI);
+}
+
+static DEVICE_ATTR(talert_high,  S_IWUSR | S_IRUGO,
+		   tmp101_show_thigh, tmp101_set_thigh);
+
+/* raw versions of the temperature and configurations */
+
+static ssize_t tmp101_show_temp_raw(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval_raw(buf, data, data->temp);
+}
+
+static DEVICE_ATTR(temperature_raw, S_IRUGO, tmp101_show_temp_raw, NULL);
+
+
+static ssize_t tmp101_show_tlow_raw(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval_raw(buf, data, data->tlow);
+}
+
+static ssize_t tmp101_set_tlow_raw(struct device *dev, const char *buf, size_t count)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_set_tval_raw(data, buf, count, TMP101_TLOW);
+}
+
+static DEVICE_ATTR(talert_low_raw,  S_IWUSR | S_IRUGO,
+		   tmp101_show_tlow_raw, tmp101_set_tlow_raw);
+
+
+static ssize_t tmp101_show_thigh_raw(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_show_tval(buf, data, data->thigh);
+}
+
+static ssize_t tmp101_set_thigh_raw(struct device *dev, const char *buf, size_t count)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_set_tval_raw(data, buf, count, TMP101_THI);
+}
+
+static DEVICE_ATTR(talert_high_raw,  S_IWUSR | S_IRUGO,
+		   tmp101_show_thigh_raw, tmp101_set_thigh_raw);
+
+/* configuration bits */
+
+static ssize_t tmp101_show_cfg_sd(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", (data->config & TMP101_CONFIG_SD) ? 1 : 0);
+}
+
+static ssize_t tmp101_set_cfg_sd(struct device *dev, const char *buf, size_t sz)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_update_cfg(data, buf, sz, 0, 1, 0);
+}
+
+static DEVICE_ATTR(shutdown, S_IWUSR | S_IRUGO,
+		   tmp101_show_cfg_sd, tmp101_set_cfg_sd);
+
+/* thermostat mode */
+
+static ssize_t tmp101_show_cfg_tm(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			(data->config & TMP101_CONFIG_TM) ? 1 : 0);
+}
+
+static ssize_t tmp101_set_cfg_tm(struct device *dev, const char *buf, size_t sz)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_update_cfg(data, buf, sz, 1, 1, 0);
+}
+
+static DEVICE_ATTR(thermostat, S_IWUSR | S_IRUGO,
+		   tmp101_show_cfg_tm, tmp101_set_cfg_tm);
+
+
+/* alert polarity */
+
+static ssize_t tmp101_show_cfg_pol(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			(data->config & TMP101_CONFIG_POL) ? 1 : 0);
+}
+
+static ssize_t tmp101_set_cfg_pol(struct device *dev, const char *buf, size_t sz)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_update_cfg(data, buf, sz, 2, 1, 0);
+}
+
+static DEVICE_ATTR(alert_polarity, S_IWUSR | S_IRUGO,
+		   tmp101_show_cfg_pol, tmp101_set_cfg_pol);
+
+/* converter resolution */
+
+static inline int tmp101_cfg_to_res(int config)
+{
+	return ((config & TMP101_CONFIG_RES_MASK) >> TMP101_CONFIG_RES) + 9;
+}
+
+static ssize_t tmp101_show_cfg_res(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp101_cfg_to_res(data->config));
+}
+
+static ssize_t tmp101_set_cfg_res(struct device *dev, const char *buf, size_t sz)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	return tmp101_update_cfg(data, buf, sz, 5, 3, 9);
+}
+
+static DEVICE_ATTR(resolution, S_IWUSR | S_IRUGO, tmp101_show_cfg_res, tmp101_set_cfg_res);
+
+/* all settings */
+
+#define HL(v,bit) (((v) & (bit)) ? "high" : "low")
+#define YN(v,bit) (((v) & (bit)) ? "yes" : "no")
+
+static ssize_t tmp101_show_all(struct device *dev, char *buf)
+{
+	struct tmp101_data *data = tmp101_sysfs_update(dev);
+	char *ptr = buf;
+	char *end = buf + PAGE_SIZE;
+
+	ptr += snprintf(ptr, end-ptr, "temperature:\t%d (%d)\n", 
+			tval_to_degc(data->temp), data->temp);
+
+	ptr += snprintf(ptr, end-ptr, "talert low:\t%d (%d)\n",
+			tval_to_degc(data->tlow), data->tlow);
+
+	ptr += snprintf(ptr, end-ptr, "talert high:\t%d (%d)\n",
+			tval_to_degc(data->thigh), data->thigh);
+
+	ptr += snprintf(ptr, end-ptr, "configuration:\t0x%02x\n",
+			data->config);
+
+	ptr += snprintf(ptr, end-ptr, "resolution:\t%d\n",
+			tmp101_cfg_to_res(data->config));
+
+	ptr += snprintf(ptr, end-ptr, "shutdown:\t%s\n",
+			YN(data->config, TMP101_CONFIG_SD));
+
+	ptr += snprintf(ptr, end-ptr, "alert_polarity: %s\n",
+			HL(data->config, TMP101_CONFIG_POL));
+
+
+	return ptr - buf;
+}
+
+static DEVICE_ATTR(all, S_IRUGO, tmp101_show_all, NULL);
+
+/* device detection */
+
+static int tmp101_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct tmp101_data *data;
+	int err;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(&adapter->dev, "No i2c smbus functionality\n");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	data = kmalloc(sizeof(struct tmp101_data), GFP_KERNEL);
+	if (data = NULL) {
+		dev_err(&adapter->dev, "no memory for tmp101 client\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memset(data, 0, sizeof(struct tmp101_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+
+	new_client->addr    = address;
+	new_client->adapter = adapter;
+	new_client->driver  = &tmp101_driver;
+	
+	strlcpy(new_client->name, "tmp101", I2C_NAME_SIZE);
+
+	/* see if we can work out what we have */
+
+	if (!tmp101_check(new_client)) {
+		dev_dbg(&adapter->dev, "cannot see any device here");
+		err = -ENODEV;
+		goto exit_free;
+	}
+
+	/* ok, attach ourselves */
+
+	new_client->id = tmp101_id++;
+	init_MUTEX(&data->update_lock);
+
+	/* announce life to the world */
+
+	err = tmp101_update_data(data);
+	if (err)
+		goto exit_free;
+
+	dev_info(&adapter->dev, "tmp101 detected, %d degC\n",
+		 tval_to_degc(data->temp));
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Register sysfs files */
+	device_create_file(&new_client->dev, &dev_attr_all);
+
+	device_create_file(&new_client->dev, &dev_attr_talert_low);
+	device_create_file(&new_client->dev, &dev_attr_talert_high);
+	device_create_file(&new_client->dev, &dev_attr_temperature);
+
+	device_create_file(&new_client->dev, &dev_attr_talert_low_raw);
+	device_create_file(&new_client->dev, &dev_attr_talert_high_raw);
+	device_create_file(&new_client->dev, &dev_attr_temperature_raw);
+
+	device_create_file(&new_client->dev, &dev_attr_shutdown);
+	device_create_file(&new_client->dev, &dev_attr_thermostat);
+	device_create_file(&new_client->dev, &dev_attr_alert_polarity);
+	device_create_file(&new_client->dev, &dev_attr_resolution);
+	
+	return 0;
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+
+}
+
+static int tmp101_detach_client(struct i2c_client *client)
+{
+	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static int tmp101_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, tmp101_detect);
+}
+
+
+static struct i2c_driver tmp101_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "tmp101",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= tmp101_attach_adapter,
+	.detach_client	= tmp101_detach_client,
+};
+
+/* module framework */
+
+static int __init sensors_tmp101_init(void)
+{
+	printk(KERN_INFO "TI TMP101 Driver, (c) 2005 Simtec Electronics\n");
+	return i2c_add_driver(&tmp101_driver);
+}
+
+static void __exit sensors_tmp101_exit(void)
+{
+	i2c_del_driver(&tmp101_driver);
+}
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("TI TMP101 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_tmp101_init);
+module_exit(sensors_tmp101_exit);
