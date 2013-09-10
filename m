From: "Markezana, William" <William.Markezana@meas-spec.com>
Date: Tue, 10 Sep 2013 15:09:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ms5637) Add Measurement Specialties MS5637 support
Message-Id: <E7458771276B644AB8F21A92079F7D6C0E6D06@tlse-mail1.europe.msiusa.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CEAE37.D0171FEE"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============1342085540040239079==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CEAE37.D0171FEE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CEAE37.D0171FEE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: William Markezana <william.markezana@meas-spec.com>

hwmon: (ms5637) Add Measurement Specialties MS5637support
Signed-off-by: William Markezana <william.markezana@meas-spec.com>
---
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 55973cd..c4f1c8e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -954,6 +954,16 @@ config SENSORS_MCP3021
 	  This driver can also be built as a module.  If so, the module
 	  will be called mcp3021.
=20
+config SENSORS_MS5637
+	tristate "Measurement Specialties MS5637 pressure sensors"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Measurement Specialties
+	  MS5637 pressure sensors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ms5637.
+
 config SENSORS_NCT6775
 	tristate "Nuvoton NCT6775F and compatibles"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index ec7cde0..5d8f699 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+=3D max6650.o
 obj-$(CONFIG_SENSORS_MAX6697)	+=3D max6697.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
 obj-$(CONFIG_SENSORS_MCP3021)	+=3D mcp3021.o
+obj-$(CONFIG_SENSORS_MS5637)	+=3D ms5637.o
 obj-$(CONFIG_SENSORS_NCT6775)	+=3D nct6775.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+=3D ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o
diff --git a/drivers/hwmon/ms5637.c b/drivers/hwmon/ms5637.c
new file mode 100644
index 0000000..fe2c2df
--- /dev/null
+++ b/drivers/hwmon/ms5637.c
@@ -0,0 +1,302 @@
+/*
+ * Measurement Specialties MS5637 pressure and temperature sensor =
driver
+ *
+ * Copyright (C) 2013 William Markezana =
<william.markezana@meas-spec.com>
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
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+
+/* MS5637 Commands */
+#define MS5637_CONVERT_D1_OSR_4096	(0x48)
+#define MS5637_CONVERT_D2_OSR_4096	(0x58)
+#define MS5637_ADC_READ				(0x00)
+#define MS5637_PROM_READ			(0xA0)
+
+struct ms5637 {
+	struct device *hwmon_dev;
+	struct mutex lock;
+	bool valid;
+	unsigned long last_update;
+	int temperature;
+	int pressure;
+	unsigned short calibration_words[6];
+	bool got_calibration_words;
+};
+
+static int ms5637_get_calibration_word(struct i2c_client *client,
+	unsigned char address, unsigned short *word)
+{
+	int ret =3D 0;
+	ret =3D i2c_smbus_read_word_swapped(client,
+		MS5637_PROM_READ + (address << 1));
+	if (ret < 0)
+		return ret;
+	*word =3D (unsigned short)ret & 0xFFFF;
+	return 0;
+}
+
+static int ms5637_fill_calibration_words(struct i2c_client *client)
+{
+	int i, ret =3D 0;
+	struct ms5637 *ms5637 =3D i2c_get_clientdata(client);
+
+	for (i =3D 0; i < 6; i++) {
+		ret =3D ms5637_get_calibration_word(client, i+1,
+			&ms5637->calibration_words[i]);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"unable to get calibration word at address %d\n",
+				i+1);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int ms5637_get_adc_value(struct i2c_client *client,
+	unsigned int *adc_value)
+{
+	int ret =3D 0;
+	unsigned char buf[3];
+	ret =3D i2c_smbus_read_i2c_block_data(client, MS5637_ADC_READ, 3, =
buf);
+	if (ret < 0)
+		return ret;
+	*adc_value =3D (buf[0] << 16) + (buf[1] << 8) + buf[2];
+	return 0;
+}
+
+static int ms5637_get_conversion_result(struct i2c_client *client,
+	unsigned char command, unsigned int *adc_value)
+{
+	int ret;
+
+	ret =3D i2c_smbus_write_byte(client, command);
+	if (ret < 0)
+		return ret;
+	msleep(9);
+	ret =3D ms5637_get_adc_value(client, adc_value);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int ms5637_update_measurements(struct i2c_client *client)
+{
+	int ret =3D 0;
+	unsigned int d1, d2;
+	int dt, temp, p;
+	long long int off, sens;
+	struct ms5637 *ms5637 =3D i2c_get_clientdata(client);
+
+	mutex_lock(&ms5637->lock);
+
+	if (time_after(jiffies, ms5637->last_update + HZ / 2) ||
+	    !ms5637->valid) {
+
+		if (!ms5637->got_calibration_words)	{
+			ret =3D ms5637_fill_calibration_words(client);
+			if (ret < 0) {
+				dev_err(&client->dev,
+					"unable to get calibration words\n");
+				goto out;
+			}
+
+			ms5637->got_calibration_words =3D true;
+		}
+
+		ret =3D ms5637_get_conversion_result(client,
+			MS5637_CONVERT_D1_OSR_4096, &d1);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"unable to get adc conversion of D1_OSR_4096\n");
+			goto out;
+		}
+
+		ret =3D ms5637_get_conversion_result(client,
+			MS5637_CONVERT_D2_OSR_4096, &d2);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"unable to get adc conversion of D2_OSR_4096\n");
+			goto out;
+		}
+
+		dt =3D d2 - (int)ms5637->calibration_words[4] * 256;
+		temp =3D 20000 + div_s64((long long int)dt *
+			(long long int)ms5637->calibration_words[5], 838861);
+
+		off =3D (long long int)ms5637->calibration_words[1] * 131072 +
+			div_s64((long long int)ms5637->calibration_words[3] *
+			(long long int)dt, 64);
+		sens =3D (long long int)ms5637->calibration_words[0] * 65536 +
+			div_s64((long long int)ms5637->calibration_words[2] *
+			(long long int)dt, 128);
+		p =3D (int)div_s64((div_s64((long long int)d1 * sens, 2097152) -
+			off), 3277);
+
+		ms5637->temperature =3D temp;
+		ms5637->pressure =3D p;
+		ms5637->last_update =3D jiffies;
+		ms5637->valid =3D true;
+	}
+out:
+	mutex_unlock(&ms5637->lock);
+
+	return ret >=3D 0 ? 0 : ret;
+}
+
+static ssize_t ms5637_show_temperature(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct ms5637 *ms5637 =3D i2c_get_clientdata(client);
+	int ret =3D ms5637_update_measurements(client);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", ms5637->temperature);
+}
+
+static ssize_t ms5637_show_pressure(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct ms5637 *ms5637 =3D i2c_get_clientdata(client);
+	int ret =3D ms5637_update_measurements(client);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", ms5637->pressure);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  ms5637_show_temperature, NULL, 0);
+static SENSOR_DEVICE_ATTR(pressure1_input, S_IRUGO,
+			  ms5637_show_pressure, NULL, 0);
+
+static struct attribute *ms5637_attributes[] =3D {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_pressure1_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ms5637_group =3D {
+	.attrs =3D ms5637_attributes,
+};
+
+static int ms5637_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct ms5637 *ms5637;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		dev_err(&client->dev,
+			"adapter does not support SMBus word transactions\n");
+		return -ENODEV;
+	}
+
+	if (!i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_WRITE_BYTE)) {
+		dev_err(&client->dev,
+			"adapter does not support SMBus byte transactions\n");
+		return -ENODEV;
+	}
+
+	if (!i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		dev_err(&client->dev,
+			"adapter does not support SMBus block transactions\n");
+		return -ENODEV;
+	}
+
+	ms5637 =3D devm_kzalloc(&client->dev, sizeof(*ms5637), GFP_KERNEL);
+	if (!ms5637)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ms5637);
+
+	mutex_init(&ms5637->lock);
+
+	err =3D sysfs_create_group(&client->dev.kobj, &ms5637_group);
+	if (err) {
+		dev_dbg(&client->dev, "could not create sysfs files\n");
+		return err;
+	}
+	ms5637->hwmon_dev =3D hwmon_device_register(&client->dev);
+	if (IS_ERR(ms5637->hwmon_dev)) {
+		dev_dbg(&client->dev, "unable to register hwmon device\n");
+		err =3D PTR_ERR(ms5637->hwmon_dev);
+		goto error;
+	}
+
+	mutex_lock(&ms5637->lock);
+	err =3D ms5637_fill_calibration_words(client);
+	if (err >=3D 0)
+		ms5637->got_calibration_words =3D true;
+	mutex_unlock(&ms5637->lock);
+
+	dev_info(&client->dev, "initialized\n");
+
+	return 0;
+
+error:
+	sysfs_remove_group(&client->dev.kobj, &ms5637_group);
+	return err;
+}
+
+static int ms5637_remove(struct i2c_client *client)
+{
+	struct ms5637 *ms5637 =3D i2c_get_clientdata(client);
+
+	hwmon_device_unregister(ms5637->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ms5637_group);
+
+	return 0;
+}
+
+static const struct i2c_device_id ms5637_id[] =3D {
+	{ "ms5637", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ms5637_id);
+
+static struct i2c_driver ms5637_driver =3D {
+	.class =3D I2C_CLASS_HWMON,
+	.driver =3D {
+		.name	=3D "ms5637",
+	},
+	.probe       =3D ms5637_probe,
+	.remove      =3D ms5637_remove,
+	.id_table    =3D ms5637_id,
+};
+
+module_i2c_driver(ms5637_driver);
+
+MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
+MODULE_DESCRIPTION("MEAS MS5637 pressure and temperature sensor =
driver");
+MODULE_LICENSE("GPL");

------_=_NextPart_001_01CEAE37.D0171FEE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>[PATCH] hwmon: (ms5637) Add Measurement Specialties MS5637 =
support</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: William Markezana =
&lt;william.markezana@meas-spec.com&gt;<BR>
<BR>
hwmon: (ms5637) Add Measurement Specialties MS5637support<BR>
Signed-off-by: William Markezana =
&lt;william.markezana@meas-spec.com&gt;<BR>
---<BR>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<BR>
index 55973cd..c4f1c8e 100644<BR>
--- a/drivers/hwmon/Kconfig<BR>
+++ b/drivers/hwmon/Kconfig<BR>
@@ -954,6 +954,16 @@ config SENSORS_MCP3021<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver can also =
be built as a module.&nbsp; If so, the module<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; will be called =
mcp3021.<BR>
<BR>
+config SENSORS_MS5637<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Measurement =
Specialties MS5637 pressure sensors&quot;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on I2C<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If you say yes here you get =
support for the Measurement Specialties<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; MS5637 pressure =
sensors.<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver can also be =
built as a module.&nbsp; If so, the module<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; will be called ms5637.<BR>
+<BR>
&nbsp;config SENSORS_NCT6775<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Nuvoton =
NCT6775F and compatibles&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !PPC<BR>
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile<BR>
index ec7cde0..5d8f699 100644<BR>
--- a/drivers/hwmon/Makefile<BR>
+++ b/drivers/hwmon/Makefile<BR>
@@ -110,6 +110,7 @@ =
obj-$(CONFIG_SENSORS_MAX6650)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D =
max6650.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_MAX6697)&nbsp; +=3D max6697.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_MCP3021)&nbsp; +=3D mcp3021.o<BR>
+obj-$(CONFIG_SENSORS_MS5637)&nbsp;&nbsp; +=3D ms5637.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_NCT6775)&nbsp; +=3D nct6775.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_NTC_THERMISTOR)&nbsp;&nbsp; +=3D =
ntc_thermistor.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_PC87360)&nbsp; +=3D pc87360.o<BR>
diff --git a/drivers/hwmon/ms5637.c b/drivers/hwmon/ms5637.c<BR>
new file mode 100644<BR>
index 0000000..fe2c2df<BR>
--- /dev/null<BR>
+++ b/drivers/hwmon/ms5637.c<BR>
@@ -0,0 +1,302 @@<BR>
+/*<BR>
+ * Measurement Specialties MS5637 pressure and temperature sensor =
driver<BR>
+ *<BR>
+ * Copyright (C) 2013 William Markezana =
&lt;william.markezana@meas-spec.com&gt;<BR>
+ *<BR>
+ * This program is free software; you can redistribute it and/or =
modify<BR>
+ * it under the terms of the GNU General Public License as published =
by<BR>
+ * the Free Software Foundation; either version 2 of the License, =
or<BR>
+ * (at your option) any later version.<BR>
+ *<BR>
+ * This program is distributed in the hope that it will be useful,<BR>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<BR>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See =
the<BR>
+ * GNU General Public License for more details.<BR>
+ *<BR>
+ */<BR>
+<BR>
+#include &lt;linux/module.h&gt;<BR>
+#include &lt;linux/init.h&gt;<BR>
+#include &lt;linux/slab.h&gt;<BR>
+#include &lt;linux/i2c.h&gt;<BR>
+#include &lt;linux/hwmon.h&gt;<BR>
+#include &lt;linux/hwmon-sysfs.h&gt;<BR>
+#include &lt;linux/err.h&gt;<BR>
+#include &lt;linux/mutex.h&gt;<BR>
+#include &lt;linux/device.h&gt;<BR>
+#include &lt;linux/jiffies.h&gt;<BR>
+#include &lt;linux/delay.h&gt;<BR>
+<BR>
+/* MS5637 Commands */<BR>
+#define MS5637_CONVERT_D1_OSR_4096&nbsp;&nbsp;&nbsp;&nbsp; (0x48)<BR>
+#define MS5637_CONVERT_D2_OSR_4096&nbsp;&nbsp;&nbsp;&nbsp; (0x58)<BR>
+#define MS5637_ADC_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<BR>
+#define MS5637_PROM_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0xA0)<BR>
+<BR>
+struct ms5637 {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *hwmon_dev;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool valid;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last_update;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int temperature;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pressure;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short =
calibration_words[6];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool got_calibration_words;<BR>
+};<BR>
+<BR>
+static int ms5637_get_calibration_word(struct i2c_client *client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char address, unsigned =
short *word)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
i2c_smbus_read_word_swapped(client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MS5637_PROM_READ + (address =
&lt;&lt; 1));<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *word =3D (unsigned short)ret =
&amp; 0xFFFF;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static int ms5637_fill_calibration_words(struct i2c_client *client)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637 =3D =
i2c_get_clientdata(client);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 6; i++) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
ms5637_get_calibration_word(client, i+1,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;ms5637-&gt;calibration_words[i]);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unable to get =
calibration word at address %d\n&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i+1);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static int ms5637_get_adc_value(struct i2c_client *client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *adc_value)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char buf[3];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
i2c_smbus_read_i2c_block_data(client, MS5637_ADC_READ, 3, buf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adc_value =3D (buf[0] &lt;&lt; =
16) + (buf[1] &lt;&lt; 8) + buf[2];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static int ms5637_get_conversion_result(struct i2c_client *client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char command, unsigned =
int *adc_value)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
i2c_smbus_write_byte(client, command);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(9);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
ms5637_get_adc_value(client, adc_value);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static int ms5637_update_measurements(struct i2c_client *client)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int d1, d2;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int dt, temp, p;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long long int off, sens;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637 =3D =
i2c_get_clientdata(client);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_lock(&amp;ms5637-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, =
ms5637-&gt;last_update + HZ / 2) ||<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!ms5637-&gt;valid) {<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!ms5637-&gt;got_calibration_words)&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
ms5637_fill_calibration_words(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unable to get =
calibration words\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ms5637-&gt;got_calibration_words =3D true;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
ms5637_get_conversion_result(client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MS5637_CONVERT_D1_OSR_4096, =
&amp;d1);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unable to get adc =
conversion of D1_OSR_4096\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
ms5637_get_conversion_result(client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MS5637_CONVERT_D2_OSR_4096, =
&amp;d2);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unable to get adc =
conversion of D2_OSR_4096\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dt =3D d2 - =
(int)ms5637-&gt;calibration_words[4] * 256;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D 20000 + =
div_s64((long long int)dt *<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long =
int)ms5637-&gt;calibration_words[5], 838861);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; off =3D (long long =
int)ms5637-&gt;calibration_words[1] * 131072 +<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; div_s64((long long =
int)ms5637-&gt;calibration_words[3] *<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long int)dt, 64);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sens =3D (long long =
int)ms5637-&gt;calibration_words[0] * 65536 +<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; div_s64((long long =
int)ms5637-&gt;calibration_words[2] *<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long int)dt, 128);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p =3D =
(int)div_s64((div_s64((long long int)d1 * sens, 2097152) -<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; off), 3277);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637-&gt;temperature =3D =
temp;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637-&gt;pressure =3D =
p;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637-&gt;last_update =3D =
jiffies;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637-&gt;valid =3D =
true;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+out:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_unlock(&amp;ms5637-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret &gt;=3D 0 ? 0 : =
ret;<BR>
+}<BR>
+<BR>
+static ssize_t ms5637_show_temperature(struct device *dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr, char =
*buf)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D =
to_i2c_client(dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637 =3D =
i2c_get_clientdata(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D =
ms5637_update_measurements(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, =
&quot;%d\n&quot;, ms5637-&gt;temperature);<BR>
+}<BR>
+<BR>
+static ssize_t ms5637_show_pressure(struct device *dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; struct =
device_attribute *attr, char *buf)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D =
to_i2c_client(dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637 =3D =
i2c_get_clientdata(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D =
ms5637_update_measurements(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, =
&quot;%d\n&quot;, ms5637-&gt;pressure);<BR>
+}<BR>
+<BR>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
ms5637_show_temperature, NULL, 0);<BR>
+static SENSOR_DEVICE_ATTR(pressure1_input, S_IRUGO,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; ms5637_show_pressure, =
NULL, 0);<BR>
+<BR>
+static struct attribute *ms5637_attributes[] =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;sensor_dev_attr_temp1_input.dev_attr.attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;sensor_dev_attr_pressure1_input.dev_attr.attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<BR>
+};<BR>
+<BR>
+static const struct attribute_group ms5637_group =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attrs =3D ms5637_attributes,<BR>
+};<BR>
+<BR>
+static int ms5637_probe(struct i2c_client *client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_device_id *id)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!i2c_check_functionality(client-&gt;adapter,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
I2C_FUNC_SMBUS_READ_WORD_DATA)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;adapter does not =
support SMBus word transactions\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!i2c_check_functionality(client-&gt;adapter,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
I2C_FUNC_SMBUS_WRITE_BYTE)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;adapter does not =
support SMBus byte transactions\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!i2c_check_functionality(client-&gt;adapter,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;adapter does not =
support SMBus block transactions\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637 =3D =
devm_kzalloc(&amp;client-&gt;dev, sizeof(*ms5637), GFP_KERNEL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ms5637)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, =
ms5637);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_init(&amp;ms5637-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
sysfs_create_group(&amp;client-&gt;dev.kobj, &amp;ms5637_group);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;client-&gt;dev, =
&quot;could not create sysfs files\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms5637-&gt;hwmon_dev =3D =
hwmon_device_register(&amp;client-&gt;dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(ms5637-&gt;hwmon_dev)) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;client-&gt;dev, =
&quot;unable to register hwmon device\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
PTR_ERR(ms5637-&gt;hwmon_dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_lock(&amp;ms5637-&gt;lock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
ms5637_fill_calibration_words(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &gt;=3D 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ms5637-&gt;got_calibration_words =3D true;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_unlock(&amp;ms5637-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(&amp;client-&gt;dev, =
&quot;initialized\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+<BR>
+error:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;ms5637_group);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<BR>
+}<BR>
+<BR>
+static int ms5637_remove(struct i2c_client *client)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms5637 *ms5637 =3D =
i2c_get_clientdata(client);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hwmon_device_unregister(ms5637-&gt;hwmon_dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;ms5637_group);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static const struct i2c_device_id ms5637_id[] =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;ms5637&quot;, 0 },<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<BR>
+};<BR>
+MODULE_DEVICE_TABLE(i2c, ms5637_id);<BR>
+<BR>
+static struct i2c_driver ms5637_driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .class =3D I2C_CLASS_HWMON,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp; =3D =
&quot;ms5637&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.probe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ms5637_probe,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.remove&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ms5637_remove,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id_table&nbsp;&nbsp;&nbsp; =3D =
ms5637_id,<BR>
+};<BR>
+<BR>
+module_i2c_driver(ms5637_driver);<BR>
+<BR>
+MODULE_AUTHOR(&quot;William Markezana =
&lt;william.markezana@meas-spec.com&gt;&quot;);<BR>
+MODULE_DESCRIPTION(&quot;MEAS MS5637 pressure and temperature sensor =
driver&quot;);<BR>
+MODULE_LICENSE(&quot;GPL&quot;);<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CEAE37.D0171FEE--


--===============1342085540040239079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1342085540040239079==--
