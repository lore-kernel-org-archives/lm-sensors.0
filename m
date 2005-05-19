From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567623617@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567611005@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.10, 2004/01/14 11:27:32-08:00, khali@linux-fr.org

[PATCH] I2C: New chip driver: lm90

This is my LM90/ADM1032 i2c chip driver ported to Linux 2.6


 drivers/i2c/chips/Kconfig  |   11=20
 drivers/i2c/chips/Makefile |    1=20
 drivers/i2c/chips/lm90.c   |  520 ++++++++++++++++++++++++++++++++++++++++=
+++++
 include/linux/i2c-id.h     |    1=20
 4 files changed, 533 insertions(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Jan 19 15:31:33 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Jan 19 15:31:33 2004
@@ -101,6 +101,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.
=20
+config SENSORS_LM90
+	tristate "National Semiconductor LM90 and compatibles"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM90
+	  and Analog Devices ADM1032 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm90.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Mon Jan 19 15:31:33 2004
+++ b/drivers/i2c/chips/Makefile	Mon Jan 19 15:31:33 2004
@@ -13,4 +13,5 @@
 obj-$(CONFIG_SENSORS_LM78)	+=3D lm78.o
 obj-$(CONFIG_SENSORS_LM83)	+=3D lm83.o
 obj-$(CONFIG_SENSORS_LM85)	+=3D lm85.o
+obj-$(CONFIG_SENSORS_LM90)	+=3D lm90.o
 obj-$(CONFIG_SENSORS_VIA686A)	+=3D via686a.o
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/lm90.c	Mon Jan 19 15:31:33 2004
@@ -0,0 +1,520 @@
+/*
+ * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
+ *          monitoring
+ * Copyright (C) 2003  Jean Delvare <khali@linux-fr.org>
+ *
+ * Based on the lm83 driver. The LM90 is a sensor chip made by National
+ * Semiconductor. It reports up to two temperatures (its own plus up to
+ * one external one) with a 0.125 deg resolution (1 deg for local
+ * temperature) and a 3-4 deg accuracy. Complete datasheet can be
+ * obtained from National's website at:
+ *   http://www.national.com/pf/LM/LM90.html
+ *
+ * This driver also supports the ADM1032, a sensor chip made by Analog
+ * Devices. That chip is similar to the LM90, with a few differences
+ * that are not handled by this driver. Complete datasheet can be
+ * obtained from Analog's website at:
+ *   http://products.analog.com/products/info.asp?product=ADM1032
+ *
+ * Since the LM90 was the first chipset supported by this driver, most
+ * comments will refer to this chipset, but are actually general and
+ * concern all supported chipsets, unless mentioned otherwise.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/*
+ * Addresses to scan
+ * Address is fully defined internally and cannot be changed.
+ */
+
+static unsigned short normal_i2c[] =3D { 0x4c, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] =3D { I2C_CLIENT_END };
+static unsigned int normal_isa[] =3D { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] =3D { I2C_CLIENT_ISA_END };
+
+/*
+ * Insmod parameters
+ */
+
+SENSORS_INSMOD_2(lm90, adm1032);
+
+/*
+ * The LM90 registers
+ */
+
+#define LM90_REG_R_MAN_ID		0xFE
+#define LM90_REG_R_CHIP_ID		0xFF
+#define LM90_REG_R_CONFIG1		0x03
+#define LM90_REG_W_CONFIG1		0x09
+#define LM90_REG_R_CONFIG2		0xBF
+#define LM90_REG_W_CONFIG2		0xBF
+#define LM90_REG_R_CONVRATE		0x04
+#define LM90_REG_W_CONVRATE		0x0A
+#define LM90_REG_R_STATUS		0x02
+#define LM90_REG_R_LOCAL_TEMP		0x00
+#define LM90_REG_R_LOCAL_HIGH		0x05
+#define LM90_REG_W_LOCAL_HIGH		0x0B
+#define LM90_REG_R_LOCAL_LOW		0x06
+#define LM90_REG_W_LOCAL_LOW		0x0C
+#define LM90_REG_R_LOCAL_CRIT		0x20
+#define LM90_REG_W_LOCAL_CRIT		0x20
+#define LM90_REG_R_REMOTE_TEMPH		0x01
+#define LM90_REG_R_REMOTE_TEMPL		0x10
+#define LM90_REG_R_REMOTE_OFFSH		0x11
+#define LM90_REG_W_REMOTE_OFFSH		0x11
+#define LM90_REG_R_REMOTE_OFFSL		0x12
+#define LM90_REG_W_REMOTE_OFFSL		0x12
+#define LM90_REG_R_REMOTE_HIGHH		0x07
+#define LM90_REG_W_REMOTE_HIGHH		0x0D
+#define LM90_REG_R_REMOTE_HIGHL		0x13
+#define LM90_REG_W_REMOTE_HIGHL		0x13
+#define LM90_REG_R_REMOTE_LOWH		0x08
+#define LM90_REG_W_REMOTE_LOWH		0x0E
+#define LM90_REG_R_REMOTE_LOWL		0x14
+#define LM90_REG_W_REMOTE_LOWL		0x14
+#define LM90_REG_R_REMOTE_CRIT		0x19
+#define LM90_REG_W_REMOTE_CRIT		0x19
+#define LM90_REG_R_TCRIT_HYST		0x21
+#define LM90_REG_W_TCRIT_HYST		0x21
+
+/*
+ * Conversions and various macros
+ * The LM90 uses signed 8-bit values for the local temperatures,
+ * and signed 11-bit values for the remote temperatures (except
+ * T_CRIT). Note that TEMP2_TO_REG does not round values, but
+ * stick to the nearest lower value instead. Fixing it is just
+ * not worth it.
+ */
+
+#define TEMP1_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
+#define TEMP1_TO_REG(val)	((val < 0 ? val+0x100*1000 : val) / 1000)
+#define TEMP2_FROM_REG(val)	(((val & 0x8000 ? val-0x10000 : val) >> 5) * 1=
25)
+#define TEMP2_TO_REG(val)	((((val / 125) << 5) + (val < 0 ? 0x10000 : 0)) =
& 0xFFE0)
+#define HYST_FROM_REG(val)	(val * 1000)
+#define HYST_TO_REG(val)	(val <=3D 0 ? 0 : val >=3D 31000 ? 31 : val / 100=
0)
+
+/*
+ * Functions declaration
+ */
+
+static int lm90_attach_adapter(struct i2c_adapter *adapter);
+static int lm90_detect(struct i2c_adapter *adapter, int address,
+	int kind);
+static void lm90_init_client(struct i2c_client *client);
+static int lm90_detach_client(struct i2c_client *client);
+static void lm90_update_client(struct i2c_client *client);
+
+/*
+ * Driver data (common to all clients)
+ */
+
+static struct i2c_driver lm90_driver =3D {
+	.owner		=3D THIS_MODULE,
+	.name		=3D "lm90",
+	.id		=3D I2C_DRIVERID_LM90,
+	.flags		=3D I2C_DF_NOTIFY,
+	.attach_adapter	=3D lm90_attach_adapter,
+	.detach_client	=3D lm90_detach_client,
+};
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct lm90_data {
+	struct semaphore update_lock;
+	char valid; /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+
+	/* registers values */
+	u8 temp_input1, temp_low1, temp_high1; /* local */
+	u16 temp_input2, temp_low2, temp_high2; /* remote, combined */
+	u8 temp_crit1, temp_crit2;
+	u8 temp_hyst;
+	u16 alarms; /* bitvector, combined */
+};
+
+/*
+ * Internal variables
+ */
+
+static int lm90_id =3D 0;
+
+/*
+ * Sysfs stuff
+ */
+
+#define show_temp(value, converter) \
+static ssize_t show_##value(struct device *dev, char *buf) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct lm90_data *data =3D i2c_get_clientdata(client); \
+	lm90_update_client(client); \
+	return sprintf(buf, "%d\n", converter(data->value)); \
+}
+show_temp(temp_input1, TEMP1_FROM_REG);
+show_temp(temp_input2, TEMP2_FROM_REG);
+show_temp(temp_low1, TEMP1_FROM_REG);
+show_temp(temp_low2, TEMP2_FROM_REG);
+show_temp(temp_high1, TEMP1_FROM_REG);
+show_temp(temp_high2, TEMP2_FROM_REG);
+show_temp(temp_crit1, TEMP1_FROM_REG);
+show_temp(temp_crit2, TEMP1_FROM_REG);
+
+#define set_temp1(value, reg) \
+static ssize_t set_##value(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct lm90_data *data =3D i2c_get_clientdata(client); \
+	data->value =3D TEMP1_TO_REG(simple_strtol(buf, NULL, 10)); \
+	i2c_smbus_write_byte_data(client, reg, data->value); \
+	return count; \
+}
+#define set_temp2(value, regh, regl) \
+static ssize_t set_##value(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct lm90_data *data =3D i2c_get_clientdata(client); \
+	data->value =3D TEMP2_TO_REG(simple_strtol(buf, NULL, 10)); \
+	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
+	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
+	return count; \
+}
+set_temp1(temp_low1, LM90_REG_W_LOCAL_LOW);
+set_temp2(temp_low2, LM90_REG_W_REMOTE_LOWH, LM90_REG_W_REMOTE_LOWL);
+set_temp1(temp_high1, LM90_REG_W_LOCAL_HIGH);
+set_temp2(temp_high2, LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL);
+set_temp1(temp_crit1, LM90_REG_W_LOCAL_CRIT);
+set_temp1(temp_crit2, LM90_REG_W_REMOTE_CRIT);
+
+#define show_temp_hyst(value, basereg) \
+static ssize_t show_##value(struct device *dev, char *buf) \
+{ \
+	struct i2c_client *client =3D to_i2c_client(dev); \
+	struct lm90_data *data =3D i2c_get_clientdata(client); \
+	lm90_update_client(client); \
+	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
+		       - HYST_FROM_REG(data->temp_hyst)); \
+}
+show_temp_hyst(temp_hyst1, temp_crit1);
+show_temp_hyst(temp_hyst2, temp_crit2);
+
+static ssize_t set_temp_hyst1(struct device *dev, const char *buf,
+	size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm90_data *data =3D i2c_get_clientdata(client);
+	int hyst =3D TEMP1_FROM_REG(data->temp_crit1) -
+		   simple_strtol(buf, NULL, 10);
+	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
+				  HYST_TO_REG(hyst));
+	return count;
+}
+
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm90_data *data =3D i2c_get_clientdata(client);
+	lm90_update_client(client);
+	return sprintf(buf, "%d\n", data->alarms);
+}
+
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp_input2, S_IRUGO, show_temp_input2, NULL);
+static DEVICE_ATTR(temp_min1, S_IWUSR | S_IRUGO, show_temp_low1,
+	set_temp_low1);
+static DEVICE_ATTR(temp_min2, S_IWUSR | S_IRUGO, show_temp_low2,
+	set_temp_low2);
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_high1,
+	set_temp_high1);
+static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_temp_high2,
+	set_temp_high2);
+static DEVICE_ATTR(temp_crit1, S_IWUSR | S_IRUGO, show_temp_crit1,
+	set_temp_crit1);
+static DEVICE_ATTR(temp_crit2, S_IWUSR | S_IRUGO, show_temp_crit2,
+	set_temp_crit2);
+static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO, show_temp_hyst1,
+	set_temp_hyst1);
+static DEVICE_ATTR(temp_hyst2, S_IRUGO, show_temp_hyst2, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+/*
+ * Real code
+ */
+
+static int lm90_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
+	return i2c_detect(adapter, &addr_data, lm90_detect);
+}
+
+/*
+ * The following function does more than just detection. If detection
+ * succeeds, it also registers the new chip.
+ */
+static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct lm90_data *data;
+	int err =3D 0;
+	const char *name =3D "";
+	u8 reg_config1=3D0, reg_convrate=3D0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(new_client =3D kmalloc(sizeof(struct i2c_client) +
+	    sizeof(struct lm90_data), GFP_KERNEL))) {
+		err =3D -ENOMEM;
+		goto exit;
+	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+	       sizeof(struct lm90_data));
+
+	/* The LM90-specific data is placed right after the common I2C
+	 * client data. */
+	data =3D (struct lm90_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr =3D address;
+	new_client->adapter =3D adapter;
+	new_client->driver =3D &lm90_driver;
+	new_client->flags =3D 0;
+
+	/*
+	 * Now we do the remaining detection. A negative kind means that
+	 * the driver was loaded with no force parameter (default), so we
+	 * must both detect and identify the chip. A zero kind means that
+	 * the driver was loaded with the force parameter, the detection
+	 * step shall be skipped. A positive kind means that the driver
+	 * was loaded with the force parameter and a given kind of chip is
+	 * requested, so both the detection and the identification steps
+	 * are skipped.
+	 */
+	if (kind < 0) { /* detection */
+		reg_config1 =3D i2c_smbus_read_byte_data(new_client,
+			      LM90_REG_R_CONFIG1);
+		reg_convrate =3D i2c_smbus_read_byte_data(new_client,
+			       LM90_REG_R_CONVRATE);
+
+		if ((reg_config1 & 0x2A) !=3D 0x00
+		 || reg_convrate > 0x0A) {
+			dev_dbg(&client->dev,
+				"LM90 detection failed at 0x%02x.\n"
+				address);
+			goto exit_free;
+		}
+	}
+
+	if (kind <=3D 0) { /* identification */
+		u8 man_id, chip_id;
+
+		man_id =3D i2c_smbus_read_byte_data(new_client,
+			 LM90_REG_R_MAN_ID);
+		chip_id =3D i2c_smbus_read_byte_data(new_client,
+			  LM90_REG_R_CHIP_ID);
+	=09
+		if (man_id =3D 0x01) { /* National Semiconductor */
+			if (chip_id >=3D 0x21 && chip_id < 0x30 /* LM90 */
+			 && (kind =3D 0 /* skip detection */
+			  || ((i2c_smbus_read_byte_data(new_client,
+				LM90_REG_R_CONFIG2) & 0xF8) =3D 0x00
+			   && reg_convrate <=3D 0x09))) {
+				kind =3D lm90;
+				name =3D "lm90";
+			}
+		}
+		else if (man_id =3D 0x41) { /* Analog Devices */
+			if ((chip_id & 0xF0) =3D 0x40 /* ADM1032 */
+			 && (kind =3D 0 /* skip detection */
+			  || (reg_config1 & 0x3F) =3D 0x00)) {
+				kind =3D adm1032;
+				name =3D "adm1032";
+			}
+		}
+
+		if (kind <=3D 0) { /* identification failed */
+			dev_info(&adapter->dev,
+			    "Unsupported chip (man_id=3D0x%02X, "
+			    "chip_id=3D0x%02X).\n", man_id, chip_id);
+			goto exit_free;
+		}
+	}
+
+	/* We can fill in the remaining client fields */
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	new_client->id =3D lm90_id++;
+	data->valid =3D 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err =3D i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the LM90 chip */
+	lm90_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_crit1);
+	device_create_file(&new_client->dev, &dev_attr_temp_crit2);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst2);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+
+	return 0;
+
+exit_free:
+	kfree(new_client);
+exit:
+	return err;
+}
+
+static void lm90_init_client(struct i2c_client *client)
+{
+	u8 config;
+
+	/*
+	 * Start the conversions.
+	 */
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE,
+				  5); /* 2 Hz */
+	config =3D i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG1);
+	if (config & 0x40)
+		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
+					  config & 0xBF); /* run */
+}
+
+static int lm90_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err =3D i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+	return 0;
+}
+
+static void lm90_update_client(struct i2c_client *client)
+{
+	struct lm90_data *data =3D i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ * 2) ||
+	    (jiffies < data->last_updated) ||
+	    !data->valid) {
+		u8 oldh, newh;
+
+		dev_dbg(&client->dev, "Updating lm90 data.\n");
+		data->temp_input1 =3D i2c_smbus_read_byte_data(client,
+				    LM90_REG_R_LOCAL_TEMP);
+		data->temp_high1 =3D i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_LOCAL_HIGH);
+		data->temp_low1 =3D i2c_smbus_read_byte_data(client,
+				  LM90_REG_R_LOCAL_LOW);
+		data->temp_crit1 =3D i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_LOCAL_CRIT);
+		data->temp_crit2 =3D i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_REMOTE_CRIT);
+		data->temp_hyst =3D i2c_smbus_read_byte_data(client,
+				  LM90_REG_R_TCRIT_HYST);
+
+		/*
+		 * There is a trick here. We have to read two registers to
+		 * have the remote sensor temperature, but we have to beware
+		 * a conversion could occur inbetween the readings. The
+		 * datasheet says we should either use the one-shot
+		 * conversion register, which we don't want to do (disables
+		 * hardware monitoring) or monitor the busy bit, which is
+		 * impossible (we can't read the values and monitor that bit
+		 * at the exact same time). So the solution used here is to
+		 * read the high byte once, then the low byte, then the high
+		 * byte again. If the new high byte matches the old one,
+		 * then we have a valid reading. Else we have to read the low
+		 * byte again, and now we believe we have a correct reading.
+		 */
+		oldh =3D i2c_smbus_read_byte_data(client,
+		       LM90_REG_R_REMOTE_TEMPH);
+		data->temp_input2 =3D i2c_smbus_read_byte_data(client,
+				    LM90_REG_R_REMOTE_TEMPL);
+		newh =3D i2c_smbus_read_byte_data(client,
+		       LM90_REG_R_REMOTE_TEMPH);
+		if (newh !=3D oldh) {
+			data->temp_input2 =3D i2c_smbus_read_byte_data(client,
+					    LM90_REG_R_REMOTE_TEMPL);
+#ifdef DEBUG
+			oldh =3D i2c_smbus_read_byte_data(client,
+			       LM90_REG_R_REMOTE_TEMPH);
+			/* oldh is actually newer */
+			if (newh !=3D oldh)
+				dev_warn(&client->dev, "Remote temperature may be "
+					 "wrong.\n");
+#endif
+		}
+		data->temp_input2 |=3D (newh << 8);
+
+		data->temp_high2 =3D (i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_REMOTE_HIGHH) << 8) +
+				   i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_REMOTE_HIGHL);
+		data->temp_low2 =3D (i2c_smbus_read_byte_data(client,
+				  LM90_REG_R_REMOTE_LOWH) << 8) +
+				  i2c_smbus_read_byte_data(client,
+				  LM90_REG_R_REMOTE_LOWL);
+		data->alarms =3D i2c_smbus_read_byte_data(client,
+			       LM90_REG_R_STATUS);
+
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	up(&data->update_lock);
+}
+
+static int __init sensors_lm90_init(void)
+{
+	return i2c_add_driver(&lm90_driver);
+}
+
+static void __exit sensors_lm90_exit(void)
+{
+	i2c_del_driver(&lm90_driver);
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("LM90/ADM1032 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_lm90_init);
+module_exit(sensors_lm90_exit);
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Mon Jan 19 15:31:33 2004
+++ b/include/linux/i2c-id.h	Mon Jan 19 15:31:33 2004
@@ -154,6 +154,7 @@
 #define I2C_DRIVERID_W83627HF 1038
 #define I2C_DRIVERID_LM85 1039
 #define I2C_DRIVERID_LM83 1040
+#define I2C_DRIVERID_LM90 1042
 #define I2C_DRIVERID_ASB100 1043
=20
 /*

