From: Constantine Shulyupin <const@MakeLinux.com>
Date: Sat, 27 Jun 2015 21:23:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <1435440228-16625-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: const <const@MakeLinux.com>

From: const <const@MakeLinux.com>

0, 3 - Temperature attributes are hidden
1 - Current mode
2 - Thermistor mode

Reference:
Nuvoton Hardware Monitoring IC NCT7802Y
7.2.32 Mode Selection Register
Location : Index 22h

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 scripts/checkpatch.pl   |  2 +-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 60cf5d1..444eedf 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -49,7 +49,7 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] =3D {
 #define REG_VOLTAGE_LOW		0x0f
 #define REG_FANCOUNT_LOW	0x13
 #define REG_START		0x21
-#define REG_MODE		0x22
+#define REG_MODE		0x22 /* 7.2.32 Mode Selection Register */
 #define REG_PECI_ENABLE		0x23
 #define REG_FAN_ENABLE		0x24
 #define REG_VMON_ENABLE		0x25
@@ -725,7 +725,58 @@ static struct attribute_group nct7802_fan_group =3D {
 	.is_visible =3D nct7802_fan_is_visible,
 };
=20
+static ssize_t show_temp_type(struct device *dev, struct device_attribute =
*attr,
+		char *buf)
+{
+	struct nct7802_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	unsigned int val;
+	int ret;
+
+	ret =3D regmap_read(data->regmap, REG_MODE, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", val >> (2 * sattr->index) & 3);
+}
+
+static ssize_t store_temp_type(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nct7802_data *data =3D dev_get_drvdata(dev);
+	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
+	unsigned int val;
+	int err;
+
+	err =3D kstrtouint(buf, 0, &val);
+	if (err < 0)
+		return err;
+	if (val > 0xF)
+		return -EINVAL;
+
+	err =3D regmap_update_bits(data->regmap, REG_MODE,
+			3 << 2 * sattr->index, val << 2 * sattr->index);
+	sysfs_update_group(&dev->kobj, &nct7802_temp_group);
+	return err ? : count;
+}
+
+/* 7.2.32 Mode Selection Register */
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
+		show_temp_type, store_temp_type, 0);
+static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
+		show_temp_type, store_temp_type, 1);
+static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
+		show_temp_type, store_temp_type, 2);
+
+static struct attribute *general_attributes[] =3D {
+	&sensor_dev_attr_temp1_type.dev_attr.attr,
+	&sensor_dev_attr_temp2_type.dev_attr.attr,
+	&sensor_dev_attr_temp3_type.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group *nct7802_groups[] =3D {
+	&(const struct attribute_group){ .attrs =3D general_attributes },
 	&nct7802_temp_group,
 	&nct7802_in_group,
 	&nct7802_fan_group,
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4f484ac..bf9a680 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -14,7 +14,7 @@ my $V =3D '0.32';
=20
 use Getopt::Long qw(:config no_auto_abbrev);
=20
-my $LINELENGTH=120;
+my $LINELENGTH=80;
=20
 my $quiet =3D 0;
 my $tree =3D 1;
--=20
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
