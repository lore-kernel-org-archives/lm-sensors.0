From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 19:13:17 +0000
Subject: [lm-sensors] [PATCH v4 1/3] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <1351624399-22595-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Add missing chip types (it8718 and it8720) to has_temp_offset()
    Clean up set_temp() a bit more
v3: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
    Limit support for new attributes to IT8716F and higher
    Clarify code to select target register in set_temp().
    Only clear valid flag when writing into offset registers,
    not for any other temperature limit set operations.
v2: The macro to calculate IT87_REG_TEMP_OFFSET was broken. Use array inste=
ad.
    When writing the temperature offset attribute, set the flag to enable i=
t.
    Add documentation describing the new attributes.

 Documentation/hwmon/it87 |    9 +++++++
 drivers/hwmon/it87.c     |   66 ++++++++++++++++++++++++++++++++++++++++++=
----
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 87850d8..e1f3828 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -209,3 +209,12 @@ doesn't use CPU cycles.
 Trip points must be set properly before switching to automatic fan speed
 control mode. The driver will perform basic integrity checks before
 actually switching to automatic control mode.
+
+
+Temperature offset attributes
+-----------------------------
+
+The driver supports temp[1-3]_offset sysfs attributes to adjust the report=
ed
+temperature for thermal diodes or diode-connected thermal transistors.
+If a temperature sensor is configured for thermistors, the attribute values
+are ignored.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index b3303fc..6ec827d 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -203,6 +203,8 @@ static const u8 IT87_REG_FAN[]		=3D { 0x0d, 0x0e, 0x0f,=
 0x80, 0x82 };
 static const u8 IT87_REG_FAN_MIN[]	=3D { 0x10, 0x11, 0x12, 0x84, 0x86 };
 static const u8 IT87_REG_FANX[]		=3D { 0x18, 0x19, 0x1a, 0x81, 0x83 };
 static const u8 IT87_REG_FANX_MIN[]	=3D { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
+static const u8 IT87_REG_TEMP_OFFSET[]	=3D { 0x56, 0x57, 0x59 };
+
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
 #define IT87_REG_PWM(nr)       (0x15 + (nr))
@@ -262,7 +264,7 @@ struct it87_data {
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
-	s8 temp[3][3];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax */
+	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
@@ -311,6 +313,17 @@ static inline int has_newer_autopwm(const struct it87_=
data *data)
 	    || data->type =3D it8728;
 }
=20
+static inline int has_temp_offset(const struct it87_data *data)
+{
+	return data->type =3D it8716
+	    || data->type =3D it8718
+	    || data->type =3D it8720
+	    || data->type =3D it8721
+	    || data->type =3D it8728
+	    || data->type =3D it8782
+	    || data->type =3D it8783;
+}
+
 static int adc_lsb(const struct it87_data *data, int nr)
 {
 	int lsb =3D has_12mv_adc(data) ? 12 : 16;
@@ -545,16 +558,34 @@ static ssize_t set_temp(struct device *dev, struct de=
vice_attribute *attr,
 	int index =3D sattr->index;
 	struct it87_data *data =3D dev_get_drvdata(dev);
 	long val;
+	u8 reg, regval;
=20
 	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
=20
 	mutex_lock(&data->update_lock);
+
+	switch (index) {
+	default:
+	case 1:
+		reg =3D IT87_REG_TEMP_LOW(nr);
+		break;
+	case 2:
+		reg =3D IT87_REG_TEMP_HIGH(nr);
+		break;
+	case 3:
+		regval =3D it87_read_value(data, IT87_REG_BEEP_ENABLE);
+		if (!(regval & 0x80)) {
+			regval |=3D 0x80;
+			it87_write_value(data, IT87_REG_BEEP_ENABLE, regval);
+		}
+		data->valid =3D 0;
+		reg =3D IT87_REG_TEMP_OFFSET[nr];
+		break;
+	}
+
 	data->temp[nr][index] =3D TEMP_TO_REG(val);
-	it87_write_value(data,
-			 index =3D 1 ? IT87_REG_TEMP_LOW(nr)
-				    : IT87_REG_TEMP_HIGH(nr),
-			 data->temp[nr][index]);
+	it87_write_value(data, reg, data->temp[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -564,16 +595,22 @@ static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IW=
USR, show_temp, set_temp,
 			    0, 1);
 static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_t=
emp,
 			    0, 2);
+static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGO | S_IWUSR, show_temp,
+			    set_temp, 0, 3);
 static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_t=
emp,
 			    1, 1);
 static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_t=
emp,
 			    1, 2);
+static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGO | S_IWUSR, show_temp,
+			    set_temp, 1, 3);
 static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
 static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_t=
emp,
 			    2, 1);
 static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_t=
emp,
 			    2, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp,
+			    set_temp, 2, 3);
=20
 static ssize_t show_temp_type(struct device *dev, struct device_attribute =
*attr,
 			      char *buf)
@@ -1426,6 +1463,12 @@ static const struct attribute_group it87_group_temp[=
3] =3D {
 	{ .attrs =3D it87_attributes_temp[2] },
 };
=20
+static struct attribute *it87_attributes_temp_offset[] =3D {
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+};
+
 static struct attribute *it87_attributes[] =3D {
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
@@ -1869,6 +1912,9 @@ static void it87_remove_files(struct device *dev)
 		if (!(data->has_temp & (1 << i)))
 			continue;
 		sysfs_remove_group(&dev->kobj, &it87_group_temp[i]);
+		if (has_temp_offset(data))
+			sysfs_remove_file(&dev->kobj,
+					  it87_attributes_temp_offset[i]);
 		if (sio_data->beep_pin)
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_temp_beep[i]);
@@ -1998,6 +2044,12 @@ static int __devinit it87_probe(struct platform_devi=
ce *pdev)
 		err =3D sysfs_create_group(&dev->kobj, &it87_group_temp[i]);
 		if (err)
 			goto error;
+		if (has_temp_offset(data)) {
+			err =3D sysfs_create_file(&dev->kobj,
+						it87_attributes_temp_offset[i]);
+			if (err)
+				goto error;
+		}
 		if (sio_data->beep_pin) {
 			err =3D sysfs_create_file(&dev->kobj,
 						it87_attributes_temp_beep[i]);
@@ -2361,6 +2413,10 @@ static struct it87_data *it87_update_device(struct d=
evice *dev)
 				it87_read_value(data, IT87_REG_TEMP_LOW(i));
 			data->temp[i][2]  				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
+			if (has_temp_offset(data))
+				data->temp[i][3] +				  it87_read_value(data,
+						  IT87_REG_TEMP_OFFSET[i]);
 		}
=20
 		/* Newer chips don't have clock dividers */
--=20
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
