From: Constantine Shulyupin <const@MakeLinux.com>
Date: Fri, 03 Jul 2015 21:11:51 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (nct7802) Add pwm control
Message-Id: <1435957911-19044-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Constantine Shulyupin <const@MakeLinux.com>

Notes:

Some lines intentionally more than 80 characters because wrapping
this lines decreases readability.
The patch was checked with scripts/checkpatch.pl --max-line-length=88

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 47 +++++++++++++++++++++++++++++++++++++++++++++=
++
 1 file changed, 47 insertions(+)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index afa242d..104d8b9 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -102,6 +102,36 @@ static ssize_t store_temp_type(struct device *dev,
 	return err ? : count;
 }
=20
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devat=
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
+	u8 val;
+
+	err =3D kstrtou8(buf, 0, &val);
+	if (err < 0)
+		return err;
+
+	err =3D regmap_write(data->regmap, attr->index, val);
+	return err ? : count;
+}
=20
 static int nct7802_read_temp(struct nct7802_data *data,
 			     u8 reg_temp, u8 reg_temp_low, int *temp)
@@ -735,6 +765,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_=
alarm, NULL, 0x1a, 2);
 static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store=
_beep,
 			    0x5b, 2);
=20
+/* 7.2.91... Fan Control Output Value */
+static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0x6=
0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0x6=
1);
+static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0x6=
2);
+
 static struct attribute *nct7802_fan_attrs[] =3D {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
@@ -773,10 +808,22 @@ static struct attribute_group nct7802_fan_group =3D {
 	.is_visible =3D nct7802_fan_is_visible,
 };
=20
+static struct attribute *nct7802_pwm_attrs[] =3D {
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group nct7802_pwm_group =3D {
+	.attrs =3D nct7802_pwm_attrs,
+};
+
 static const struct attribute_group *nct7802_groups[] =3D {
 	&nct7802_temp_group,
 	&nct7802_in_group,
 	&nct7802_fan_group,
+	&nct7802_pwm_group,
 	NULL
 };
=20
--=20
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
