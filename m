From: Constantine Shulyupin <const@MakeLinux.com>
Date: Thu, 02 Jul 2015 22:40:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7802) Add fan output control
Message-Id: <1435876843-1216-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Constantine Shulyupin <const@MakeLinux.com>

Notes:

Some lines intentionally more than 80 characters because wrapping
this lines decreases readability.
The patch was checked with scripts/checkpatch.pl --max-line-length=88

Following code is not typecasting.
It is inline struct attribute_group definition using compound literal.
(See https://gcc.gnu.org/onlinedocs/gcc-3.2.2/gcc/Compound-Literals.html)

static const struct attribute_group *nct7802_groups[] =3D {
	...
	&(const struct attribute_group){ .attrs =3D fan_output_attributes },
	...

Reference:

Nuvoton Hardware Monitoring IC NCT7802Y
7.2.91 Fan Control 1 Output Value
Location : Index 60h

7.2.92 Fan Control 2 Output Value
Location : Index 61h

7.2.93 Fan Control 3 Output Value
Location : Index 62h

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index afa242d..56d3547 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -102,6 +102,38 @@ static ssize_t store_temp_type(struct device *dev,
 	return err ? : count;
 }
=20
+static ssize_t show_dec(struct device *dev, struct device_attribute *devat=
tr, char *buf)
+{
+	int ret =3D -1;
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct nct7802_data *data =3D dev_get_drvdata(dev);
+	unsigned int val =3D 0;
+
+	ret =3D regmap_read(data->regmap, attr->index, &val);
+	if (ret < 0)
+		return ret;
+
+	ret =3D sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t store_u8(struct device *dev, struct device_attribute *devat=
tr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct nct7802_data *data =3D dev_get_drvdata(dev);
+	int err;
+	unsigned int val;
+
+	err =3D kstrtouint(buf, 0, &val);
+	if (err < 0)
+		return err;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	err =3D regmap_write(data->regmap, attr->index, val);
+	return err ? : count;
+}
=20
 static int nct7802_read_temp(struct nct7802_data *data,
 			     u8 reg_temp, u8 reg_temp_low, int *temp)
@@ -735,6 +767,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_=
alarm, NULL, 0x1a, 2);
 static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store=
_beep,
 			    0x5b, 2);
=20
+/* 7.2.91... Fan Control Output Value */
+static SENSOR_DEVICE_ATTR(fan1_output, S_IRUGO | S_IWUSR, show_dec, store_=
u8, 0x60);
+static SENSOR_DEVICE_ATTR(fan2_output, S_IRUGO | S_IWUSR, show_dec, store_=
u8, 0x61);
+static SENSOR_DEVICE_ATTR(fan3_output, S_IRUGO | S_IWUSR, show_dec, store_=
u8, 0x62);
+
 static struct attribute *nct7802_fan_attrs[] =3D {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -773,10 +810,18 @@ static struct attribute_group nct7802_fan_group =3D {
 	.is_visible =3D nct7802_fan_is_visible,
 };
=20
+static struct attribute *fan_output_attributes[] =3D {
+	&sensor_dev_attr_fan1_output.dev_attr.attr,
+	&sensor_dev_attr_fan2_output.dev_attr.attr,
+	&sensor_dev_attr_fan3_output.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group *nct7802_groups[] =3D {
 	&nct7802_temp_group,
 	&nct7802_in_group,
 	&nct7802_fan_group,
+	&(const struct attribute_group){ .attrs =3D fan_output_attributes },
 	NULL
 };
=20
--=20
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
