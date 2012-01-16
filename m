From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:06 +0000
Subject: [lm-sensors] [PATCH 04/39] hwmon: (adm1025) Fix checkpatch issues
Message-Id: <1326703781-14272-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=3D' (ctx:VxV)
ERROR: trailing whitespace
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed:
ERROR: Macros with multiple statements should be enclosed in a do - while l=
oop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1025.c |   63 ++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 60befc0..14d8997 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -12,7 +12,7 @@
  * resolution of about 0.5% of the nominal value). Temperature values are
  * reported with a 1 deg resolution and a 3 deg accuracy. Complete
  * datasheet can be obtained from Analog's website at:
- *   http://www.onsemi.com/PowerSolutions/product.do?id=ADM1025=20
+ *   http://www.onsemi.com/PowerSolutions/product.do?id=ADM1025
  *
  * This driver also supports the ADM1025A, which differs from the ADM1025
  * only in that it has "open-drain VID inputs while the ADM1025 has
@@ -91,15 +91,16 @@ enum chips { adm1025, ne1619 };
=20
 static const int in_scale[6] =3D { 2500, 2250, 3300, 5000, 12000, 3300 };
=20
-#define IN_FROM_REG(reg,scale)	(((reg) * (scale) + 96) / 192)
-#define IN_TO_REG(val,scale)	((val) <=3D 0 ? 0 : \
+#define IN_FROM_REG(reg, scale)	(((reg) * (scale) + 96) / 192)
+#define IN_TO_REG(val, scale)	((val) <=3D 0 ? 0 : \
 				 (val) * 192 >=3D (scale) * 255 ? 255 : \
-				 ((val) * 192 + (scale)/2) / (scale))
+				 ((val) * 192 + (scale) / 2) / (scale))
=20
 #define TEMP_FROM_REG(reg)	((reg) * 1000)
 #define TEMP_TO_REG(val)	((val) <=3D -127500 ? -128 : \
 				 (val) >=3D 126500 ? 127 : \
-				 (((val) < 0 ? (val)-500 : (val)+500) / 1000))
+				 (((val) < 0 ? (val) - 500 : \
+				   (val) + 500) / 1000))
=20
 /*
  * Functions declaration
@@ -218,7 +219,12 @@ static ssize_t set_in_min(struct device *dev, struct d=
evice_attribute *attr,
 	int index =3D to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1025_data *data =3D i2c_get_clientdata(client);
-	long val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_min[index] =3D IN_TO_REG(val, in_scale[index]);
@@ -234,7 +240,12 @@ static ssize_t set_in_max(struct device *dev, struct d=
evice_attribute *attr,
 	int index =3D to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1025_data *data =3D i2c_get_clientdata(client);
-	long val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_max[index] =3D IN_TO_REG(val, in_scale[index]);
@@ -264,7 +275,12 @@ static ssize_t set_temp_min(struct device *dev, struct=
 device_attribute *attr,
 	int index =3D to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1025_data *data =3D i2c_get_clientdata(client);
-	long val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_min[index] =3D TEMP_TO_REG(val);
@@ -280,7 +296,12 @@ static ssize_t set_temp_max(struct device *dev, struct=
 device_attribute *attr,
 	int index =3D to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1025_data *data =3D i2c_get_clientdata(client);
-	long val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_max[index] =3D TEMP_TO_REG(val);
@@ -343,7 +364,14 @@ static ssize_t set_vrm(struct device *dev, struct devi=
ce_attribute *attr,
 		       const char *buf, size_t count)
 {
 	struct adm1025_data *data =3D dev_get_drvdata(dev);
-	data->vrm =3D simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm =3D SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
@@ -462,14 +490,15 @@ static int adm1025_probe(struct i2c_client *client,
 	adm1025_init_client(client);
=20
 	/* Register sysfs hooks */
-	if ((err =3D sysfs_create_group(&client->dev.kobj, &adm1025_group)))
+	err =3D sysfs_create_group(&client->dev.kobj, &adm1025_group);
+	if (err)
 		goto exit_free;
=20
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	config =3D i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
 	if (!(config & 0x20)) {
-		if ((err =3D sysfs_create_group(&client->dev.kobj,
-					      &adm1025_group_in4)))
+		err =3D sysfs_create_group(&client->dev.kobj, &adm1025_group_in4);
+		if (err)
 			goto exit_remove;
 	}
=20
@@ -506,7 +535,7 @@ static void adm1025_init_client(struct i2c_client *clie=
nt)
 	 * setting yet, we better set the high limits to the max so that
 	 * no alarm triggers.
 	 */
-	for (i=3D0; i<6; i++) {
+	for (i =3D 0; i < 6; i++) {
 		reg =3D i2c_smbus_read_byte_data(client,
 					       ADM1025_REG_IN_MAX(i));
 		if (reg =3D 0)
@@ -514,7 +543,7 @@ static void adm1025_init_client(struct i2c_client *clie=
nt)
 						  ADM1025_REG_IN_MAX(i),
 						  0xFF);
 	}
-	for (i=3D0; i<2; i++) {
+	for (i =3D 0; i < 2; i++) {
 		reg =3D i2c_smbus_read_byte_data(client,
 					       ADM1025_REG_TEMP_HIGH(i));
 		if (reg =3D 0)
@@ -555,7 +584,7 @@ static struct adm1025_data *adm1025_update_device(struc=
t device *dev)
 		int i;
=20
 		dev_dbg(&client->dev, "Updating data.\n");
-		for (i=3D0; i<6; i++) {
+		for (i =3D 0; i < 6; i++) {
 			data->in[i] =3D i2c_smbus_read_byte_data(client,
 				      ADM1025_REG_IN(i));
 			data->in_min[i] =3D i2c_smbus_read_byte_data(client,
@@ -563,7 +592,7 @@ static struct adm1025_data *adm1025_update_device(struc=
t device *dev)
 			data->in_max[i] =3D i2c_smbus_read_byte_data(client,
 					  ADM1025_REG_IN_MAX(i));
 		}
-		for (i=3D0; i<2; i++) {
+		for (i =3D 0; i < 2; i++) {
 			data->temp[i] =3D i2c_smbus_read_byte_data(client,
 					ADM1025_REG_TEMP(i));
 			data->temp_min[i] =3D i2c_smbus_read_byte_data(client,
--=20
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
