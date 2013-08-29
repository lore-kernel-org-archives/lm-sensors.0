From: "Markezana, William" <William.Markezana@meas-spec.com>
Date: Thu, 29 Aug 2013 11:51:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: (htu21) Add Measurement Specialties HTU21D support
Message-Id: <E7458771276B644AB8F21A92079F7D6C0E6D04@tlse-mail1.europe.msiusa.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CEA4AE.21175D65"
List-Id: <lm-sensors.vger.kernel.org>
References: <E7458771276B644AB8F21A92079F7D6C53C593@tlse-mail1.europe.msiusa.com>
In-Reply-To: <E7458771276B644AB8F21A92079F7D6C53C593@tlse-mail1.europe.msiusa.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============4845491198832804118==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CEA4AE.21175D65"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CEA4AE.21175D65
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: William Markezana <william.markezana@meas-spec.com>

hwmon: (htu21) Add Measurement Specialties HTU21D support
Signed-off-by: William Markezana <william.markezana@meas-spec.com>
---
diff --git a/Documentation/hwmon/htu21 b/Documentation/hwmon/htu21
new file mode 100644
index 0000000..8082879
--- /dev/null
+++ b/Documentation/hwmon/htu21
@@ -0,0 +1,46 @@
+Kernel driver htu21
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Measurement Specialties HTU21D
+    Prefix: 'htu21'
+    Addresses scanned: none
+    Datasheet: Publicly available at the Measurement Specialties =
website
+    http://www.meas-spec.com/downloads/HTU21D.pdf
+
+
+Author:
+  William Markezana <william.markezana@meas-spec.com>
+
+Description
+-----------
+
+The HTU21D is a humidity and temperature sensor in a DFN package of
+only 3 x 3 mm footprint and 0.9 mm height.
+
+The devices communicate with the I2C protocol. All sensors are set to =
the
+same I2C address 0x40, so an entry with I2C_BOARD_INFO("htu21", 0x40) =
can
+be used in the board setup code.
+
+This driver does not auto-detect devices. You will have to instantiate =
the
+devices explicitly. Please see Documentation/i2c/instantiating-devices
+for details."
+
+sysfs-Interface
+---------------
+
+temp1_input - temperature input
+humidity1_input - humidity input
+
+Notes
+-----
+
+The driver uses the default resolution settings of 12 bit for humidity =
and 14
+bit for temperature, which results in typical measurement times of 11 =
ms for
+humidity and 44 ms for temperature. To keep self heating below 0.1 =
degree
+Celsius, the device should not be active for more than 10% of the time. =
For
+this reason, the driver performs no more than two measurements per =
second and
+reports cached information if polled more frequently.
+
+Different resolutions, the on-chip heater, using the CRC checksum and =
reading
+the serial number are not supported yet.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e989f7f..55973cd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -511,6 +511,16 @@ config SENSORS_HIH6130
 	  This driver can also be built as a module.  If so, the module
 	  will be called hih6130.
=20
+config SENSORS_HTU21
+	tristate "Measurement Specialties HTU21D humidity/temperature sensors"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Measurement Specialties
+	  HTU21D humidity and temperature sensors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called htu21.
+
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
 	depends on X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4f0fb52..ec7cde0 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+=3D gl520sm.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+=3D gpio-fan.o
 obj-$(CONFIG_SENSORS_HIH6130)	+=3D hih6130.o
+obj-$(CONFIG_SENSORS_HTU21)	+=3D htu21.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+=3D ultra45_env.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+=3D i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+=3D ibmaem.o
diff --git a/drivers/hwmon/htu21.c b/drivers/hwmon/htu21.c
new file mode 100644
index 0000000..743bf32
--- /dev/null
+++ b/drivers/hwmon/htu21.c
@@ -0,0 +1,201 @@
+/*
+ * Measurement Specialties HTU21D humidity and temperature sensor =
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
+
+/* HTU21 Commands */
+#define HTU21_T_MEASUREMENT_HM	0xE3
+#define HTU21_RH_MEASUREMENT_HM	0xE5
+
+struct htu21 {
+	struct device *hwmon_dev;
+	struct mutex lock;
+	bool valid;
+	unsigned long last_update;
+	int temperature;
+	int humidity;
+};
+
+static inline int htu21_temp_ticks_to_millicelsius(int ticks)
+{
+	ticks &=3D ~0x0003; /* clear status bits */
+	/*
+	 * Formula T =3D -46.85 + 175.72 * ST / 2^16 from datasheet p14,
+	 * optimized for integer fixed point (3 digits) arithmetic
+	 */
+	return ((21965 * ticks) >> 13) - 46850;
+}
+
+static inline int htu21_rh_ticks_to_per_cent_mille(int ticks)
+{
+	ticks &=3D ~0x0003; /* clear status bits */
+	/*
+	 * Formula RH =3D -6 + 125 * SRH / 2^16 from datasheet p14,
+	 * optimized for integer fixed point (3 digits) arithmetic
+	 */
+	return ((15625 * ticks) >> 13) - 6000;
+}
+
+static int htu21_update_measurements(struct i2c_client *client)
+{
+	int ret =3D 0;
+	struct htu21 *htu21 =3D i2c_get_clientdata(client);
+
+	mutex_lock(&htu21->lock);
+
+	if (time_after(jiffies, htu21->last_update + HZ / 2) ||
+	 !htu21->valid) {
+		ret =3D i2c_smbus_read_word_swapped(client,
+			HTU21_T_MEASUREMENT_HM);
+		if (ret < 0)
+			goto out;
+		htu21->temperature =3D htu21_temp_ticks_to_millicelsius(ret);
+		ret =3D i2c_smbus_read_word_swapped(client,
+			HTU21_RH_MEASUREMENT_HM);
+		if (ret < 0)
+			goto out;
+		htu21->humidity =3D htu21_rh_ticks_to_per_cent_mille(ret);
+		htu21->last_update =3D jiffies;
+		htu21->valid =3D true;
+	}
+out:
+	mutex_unlock(&htu21->lock);
+
+	return ret >=3D 0 ? 0 : ret;
+}
+
+static ssize_t htu21_show_temperature(struct device *dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct htu21 *htu21 =3D i2c_get_clientdata(client);
+	int ret =3D htu21_update_measurements(client);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", htu21->temperature);
+}
+
+static ssize_t htu21_show_humidity(struct device *dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct htu21 *htu21 =3D i2c_get_clientdata(client);
+	int ret =3D htu21_update_measurements(client);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", htu21->humidity);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+	htu21_show_temperature, NULL, 0);
+static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,
+	htu21_show_humidity, NULL, 0);
+
+static struct attribute *htu21_attributes[] =3D {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_humidity1_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group htu21_group =3D {
+	.attrs =3D htu21_attributes,
+};
+
+static int htu21_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct htu21 *htu21;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		dev_err(&client->dev,
+			"adapter does not support SMBus word transactions\n");
+		return -ENODEV;
+	}
+
+	htu21 =3D devm_kzalloc(&client->dev, sizeof(*htu21), GFP_KERNEL);
+	if (!htu21)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, htu21);
+
+	mutex_init(&htu21->lock);
+
+	err =3D sysfs_create_group(&client->dev.kobj, &htu21_group);
+	if (err) {
+		dev_dbg(&client->dev, "could not create sysfs files\n");
+		return err;
+	}
+	htu21->hwmon_dev =3D hwmon_device_register(&client->dev);
+	if (IS_ERR(htu21->hwmon_dev)) {
+		dev_dbg(&client->dev, "unable to register hwmon device\n");
+		err =3D PTR_ERR(htu21->hwmon_dev);
+		goto error;
+	}
+
+	dev_info(&client->dev, "initialized\n");
+
+	return 0;
+
+error:
+	sysfs_remove_group(&client->dev.kobj, &htu21_group);
+	return err;
+}
+
+static int htu21_remove(struct i2c_client *client)
+{
+	struct htu21 *htu21 =3D i2c_get_clientdata(client);
+
+	hwmon_device_unregister(htu21->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &htu21_group);
+
+	return 0;
+}
+
+static const struct i2c_device_id htu21_id[] =3D {
+	{ "htu21", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, htu21_id);
+
+static struct i2c_driver htu21_driver =3D {
+	.class =3D I2C_CLASS_HWMON,
+	.driver =3D {
+		.name	=3D "htu21",
+	},
+	.probe       =3D htu21_probe,
+	.remove      =3D htu21_remove,
+	.id_table    =3D htu21_id,
+};
+
+module_i2c_driver(htu21_driver);
+
+MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
+MODULE_DESCRIPTION("MEAS HTU21D humidity and temperature sensor =
driver");
+MODULE_LICENSE("GPL");

------_=_NextPart_001_01CEA4AE.21175D65
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
<TITLE>[PATCH] hwmon: (htu21) Add Measurement Specialties HTU21D =
support</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: William Markezana =
&lt;william.markezana@meas-spec.com&gt;<BR>
<BR>
hwmon: (htu21) Add Measurement Specialties HTU21D support<BR>
Signed-off-by: William Markezana =
&lt;william.markezana@meas-spec.com&gt;<BR>
---<BR>
diff --git a/Documentation/hwmon/htu21 b/Documentation/hwmon/htu21<BR>
new file mode 100644<BR>
index 0000000..8082879<BR>
--- /dev/null<BR>
+++ b/Documentation/hwmon/htu21<BR>
@@ -0,0 +1,46 @@<BR>
+Kernel driver htu21<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
+<BR>
+Supported chips:<BR>
+&nbsp; * Measurement Specialties HTU21D<BR>
+&nbsp;&nbsp;&nbsp; Prefix: 'htu21'<BR>
+&nbsp;&nbsp;&nbsp; Addresses scanned: none<BR>
+&nbsp;&nbsp;&nbsp; Datasheet: Publicly available at the Measurement =
Specialties website<BR>
+&nbsp;&nbsp;&nbsp; <A =
HREF=3D"http://www.meas-spec.com/downloads/HTU21D.pdf">http://www.meas-sp=
ec.com/downloads/HTU21D.pdf</A><BR>
+<BR>
+<BR>
+Author:<BR>
+&nbsp; William Markezana &lt;william.markezana@meas-spec.com&gt;<BR>
+<BR>
+Description<BR>
+-----------<BR>
+<BR>
+The HTU21D is a humidity and temperature sensor in a DFN package of<BR>
+only 3 x 3 mm footprint and 0.9 mm height.<BR>
+<BR>
+The devices communicate with the I2C protocol. All sensors are set to =
the<BR>
+same I2C address 0x40, so an entry with =
I2C_BOARD_INFO(&quot;htu21&quot;, 0x40) can<BR>
+be used in the board setup code.<BR>
+<BR>
+This driver does not auto-detect devices. You will have to instantiate =
the<BR>
+devices explicitly. Please see =
Documentation/i2c/instantiating-devices<BR>
+for details.&quot;<BR>
+<BR>
+sysfs-Interface<BR>
+---------------<BR>
+<BR>
+temp1_input - temperature input<BR>
+humidity1_input - humidity input<BR>
+<BR>
+Notes<BR>
+-----<BR>
+<BR>
+The driver uses the default resolution settings of 12 bit for humidity =
and 14<BR>
+bit for temperature, which results in typical measurement times of 11 =
ms for<BR>
+humidity and 44 ms for temperature. To keep self heating below 0.1 =
degree<BR>
+Celsius, the device should not be active for more than 10% of the time. =
For<BR>
+this reason, the driver performs no more than two measurements per =
second and<BR>
+reports cached information if polled more frequently.<BR>
+<BR>
+Different resolutions, the on-chip heater, using the CRC checksum and =
reading<BR>
+the serial number are not supported yet.<BR>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<BR>
index e989f7f..55973cd 100644<BR>
--- a/drivers/hwmon/Kconfig<BR>
+++ b/drivers/hwmon/Kconfig<BR>
@@ -511,6 +511,16 @@ config SENSORS_HIH6130<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver can also =
be built as a module.&nbsp; If so, the module<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; will be called =
hih6130.<BR>
<BR>
+config SENSORS_HTU21<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Measurement =
Specialties HTU21D humidity/temperature sensors&quot;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on I2C<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If you say yes here you get =
support for the Measurement Specialties<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; HTU21D humidity and =
temperature sensors.<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver can also be =
built as a module.&nbsp; If so, the module<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; will be called htu21.<BR>
+<BR>
&nbsp;config SENSORS_CORETEMP<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Intel =
Core/Core2/Atom temperature sensor&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on X86<BR>
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile<BR>
index 4f0fb52..ec7cde0 100644<BR>
--- a/drivers/hwmon/Makefile<BR>
+++ b/drivers/hwmon/Makefile<BR>
@@ -65,6 +65,7 @@ obj-$(CONFIG_SENSORS_GL518SM) +=3D gl518sm.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_GL520SM)&nbsp; +=3D gl520sm.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_GPIO_FAN) +=3D gpio-fan.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_HIH6130)&nbsp; +=3D hih6130.o<BR>
+obj-$(CONFIG_SENSORS_HTU21)&nbsp;&nbsp;&nbsp; +=3D htu21.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_ULTRA45)&nbsp; +=3D ultra45_env.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_I5K_AMB)&nbsp; +=3D i5k_amb.o<BR>
&nbsp;obj-$(CONFIG_SENSORS_IBMAEM)&nbsp;&nbsp; +=3D ibmaem.o<BR>
diff --git a/drivers/hwmon/htu21.c b/drivers/hwmon/htu21.c<BR>
new file mode 100644<BR>
index 0000000..743bf32<BR>
--- /dev/null<BR>
+++ b/drivers/hwmon/htu21.c<BR>
@@ -0,0 +1,201 @@<BR>
+/*<BR>
+ * Measurement Specialties HTU21D humidity and temperature sensor =
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
+<BR>
+/* HTU21 Commands */<BR>
+#define HTU21_T_MEASUREMENT_HM 0xE3<BR>
+#define =
HTU21_RH_MEASUREMENT_HM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xE5<BR>
+<BR>
+struct htu21 {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *hwmon_dev;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool valid;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last_update;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int temperature;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int humidity;<BR>
+};<BR>
+<BR>
+static inline int htu21_temp_ticks_to_millicelsius(int ticks)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ticks &amp;=3D ~0x0003; /* clear =
status bits */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Formula T =3D -46.85 + =
175.72 * ST / 2^16 from datasheet p14,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * optimized for integer =
fixed point (3 digits) arithmetic<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((21965 * ticks) &gt;&gt; =
13) - 46850;<BR>
+}<BR>
+<BR>
+static inline int htu21_rh_ticks_to_per_cent_mille(int ticks)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ticks &amp;=3D ~0x0003; /* clear =
status bits */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Formula RH =3D -6 + 125 * =
SRH / 2^16 from datasheet p14,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * optimized for integer =
fixed point (3 digits) arithmetic<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((15625 * ticks) &gt;&gt; =
13) - 6000;<BR>
+}<BR>
+<BR>
+static int htu21_update_measurements(struct i2c_client *client)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct htu21 *htu21 =3D =
i2c_get_clientdata(client);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_lock(&amp;htu21-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, =
htu21-&gt;last_update + HZ / 2) ||<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !htu21-&gt;valid) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
i2c_smbus_read_word_swapped(client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HTU21_T_MEASUREMENT_HM);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21-&gt;temperature =3D =
htu21_temp_ticks_to_millicelsius(ret);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
i2c_smbus_read_word_swapped(client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HTU21_RH_MEASUREMENT_HM);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21-&gt;humidity =3D =
htu21_rh_ticks_to_per_cent_mille(ret);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21-&gt;last_update =3D =
jiffies;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21-&gt;valid =3D true;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+out:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_unlock(&amp;htu21-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret &gt;=3D 0 ? 0 : =
ret;<BR>
+}<BR>
+<BR>
+static ssize_t htu21_show_temperature(struct device *dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D =
to_i2c_client(dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct htu21 *htu21 =3D =
i2c_get_clientdata(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D =
htu21_update_measurements(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, =
&quot;%d\n&quot;, htu21-&gt;temperature);<BR>
+}<BR>
+<BR>
+static ssize_t htu21_show_humidity(struct device *dev,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D =
to_i2c_client(dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct htu21 *htu21 =3D =
i2c_get_clientdata(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D =
htu21_update_measurements(client);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, =
&quot;%d\n&quot;, htu21-&gt;humidity);<BR>
+}<BR>
+<BR>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21_show_temperature, NULL, =
0);<BR>
+static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21_show_humidity, NULL, 0);<BR>
+<BR>
+static struct attribute *htu21_attributes[] =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;sensor_dev_attr_temp1_input.dev_attr.attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;sensor_dev_attr_humidity1_input.dev_attr.attr,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<BR>
+};<BR>
+<BR>
+static const struct attribute_group htu21_group =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attrs =3D htu21_attributes,<BR>
+};<BR>
+<BR>
+static int htu21_probe(struct i2c_client *client,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_device_id =
*id)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct htu21 *htu21;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!i2c_check_functionality(client-&gt;adapter,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; =
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21 =3D =
devm_kzalloc(&amp;client-&gt;dev, sizeof(*htu21), GFP_KERNEL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!htu21)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, =
htu21);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_init(&amp;htu21-&gt;lock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
sysfs_create_group(&amp;client-&gt;dev.kobj, &amp;htu21_group);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;client-&gt;dev, =
&quot;could not create sysfs files\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; htu21-&gt;hwmon_dev =3D =
hwmon_device_register(&amp;client-&gt;dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(htu21-&gt;hwmon_dev)) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;client-&gt;dev, =
&quot;unable to register hwmon device\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
PTR_ERR(htu21-&gt;hwmon_dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(&amp;client-&gt;dev, =
&quot;initialized\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+<BR>
+error:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;htu21_group);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<BR>
+}<BR>
+<BR>
+static int htu21_remove(struct i2c_client *client)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct htu21 *htu21 =3D =
i2c_get_clientdata(client);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hwmon_device_unregister(htu21-&gt;hwmon_dev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sysfs_remove_group(&amp;client-&gt;dev.kobj, &amp;htu21_group);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static const struct i2c_device_id htu21_id[] =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;htu21&quot;, 0 },<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<BR>
+};<BR>
+MODULE_DEVICE_TABLE(i2c, htu21_id);<BR>
+<BR>
+static struct i2c_driver htu21_driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .class =3D I2C_CLASS_HWMON,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp; =3D =
&quot;htu21&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.probe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D htu21_probe,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.remove&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D htu21_remove,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id_table&nbsp;&nbsp;&nbsp; =3D =
htu21_id,<BR>
+};<BR>
+<BR>
+module_i2c_driver(htu21_driver);<BR>
+<BR>
+MODULE_AUTHOR(&quot;William Markezana =
&lt;william.markezana@meas-spec.com&gt;&quot;);<BR>
+MODULE_DESCRIPTION(&quot;MEAS HTU21D humidity and temperature sensor =
driver&quot;);<BR>
+MODULE_LICENSE(&quot;GPL&quot;);<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CEA4AE.21175D65--


--===============4845491198832804118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4845491198832804118==--
