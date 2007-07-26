From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 26 Jul 2007 01:04:21 +0000
Subject: [lm-sensors] [PATCH] adt7470: Update sensors periodically via timer
Message-Id: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6386970818458124737=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============6386970818458124737==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Content-Disposition: inline


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To avoid blocking for 1s in the sysfs read functions, make it so
that adt7470 updates are done periodically with a timer instead
of being called from the read functions directly.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |   71 +++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 75aee3b..bfb0072 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/timer.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END =
};
@@ -124,6 +125,8 @@ struct adt7470_data {
 	struct mutex		lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
+	struct timer_list	timer;
+	struct work_struct	ref_work;
=20
 	s8			temp[ADT7470_TEMP_COUNT];
 	s8			temp_min[ADT7470_TEMP_COUNT];
@@ -184,10 +187,9 @@ static void adt7470_init_client(struct i2c_client *cli=
ent)
 	}
 }
=20
-static struct adt7470_data *adt7470_update_device(struct device *dev)
+static void adt7470_update_data(struct adt7470_data *data)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	struct i2c_client *client =3D &data->client;
 	u8 cfg;
 	int i;
=20
@@ -277,6 +279,29 @@ static struct adt7470_data *adt7470_update_device(stru=
ct device *dev)
=20
 out:
 	mutex_unlock(&data->lock);
+}
+
+static void adt7470_work_function(struct work_struct *work)
+{
+	struct adt7470_data *data =3D
+		container_of(work, struct adt7470_data, ref_work);
+
+	adt7470_update_data(data);
+	mod_timer(&data->timer, jiffies + REFRESH_INTERVAL);
+}
+
+static void adt7470_timer_function(unsigned long x)
+{
+	struct adt7470_data *data =3D (struct adt7470_data *)x;
+
+	schedule_work(&data->ref_work);
+}
+
+static struct adt7470_data *dev_to_adt7470_data(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7470_data *data =3D i2c_get_clientdata(client);
+
 	return data;
 }
=20
@@ -285,7 +310,7 @@ static ssize_t show_temp_min(struct device *dev,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
 }
=20
@@ -313,7 +338,7 @@ static ssize_t show_temp_max(struct device *dev,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
 }
=20
@@ -340,7 +365,7 @@ static ssize_t show_temp(struct device *dev, struct dev=
ice_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
 }
=20
@@ -349,7 +374,7 @@ static ssize_t show_alarms(struct device *dev,
 			   char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
=20
 	if (attr->index)
 		return sprintf(buf, "%x\n", data->alarms);
@@ -362,7 +387,7 @@ static ssize_t show_fan_max(struct device *dev,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
=20
 	if (FAN_DATA_VALID(data->fan_max[attr->index]))
 		return sprintf(buf, "%d\n",
@@ -397,7 +422,7 @@ static ssize_t show_fan_min(struct device *dev,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
=20
 	if (FAN_DATA_VALID(data->fan_min[attr->index]))
 		return sprintf(buf, "%d\n",
@@ -431,7 +456,7 @@ static ssize_t show_fan(struct device *dev, struct devi=
ce_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
=20
 	if (FAN_DATA_VALID(data->fan[attr->index]))
 		return sprintf(buf, "%d\n",
@@ -444,7 +469,7 @@ static ssize_t show_force_pwm_max(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", data->force_pwm_max);
 }
=20
@@ -475,7 +500,7 @@ static ssize_t show_pwm(struct device *dev, struct devi=
ce_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", data->pwm[attr->index]);
 }
=20
@@ -500,7 +525,7 @@ static ssize_t show_pwm_max(struct device *dev,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
 }
=20
@@ -528,7 +553,7 @@ static ssize_t show_pwm_min(struct device *dev,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
 }
=20
@@ -556,7 +581,7 @@ static ssize_t show_pwm_tmax(struct device *dev,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	/* the datasheet says that tmax =3D tmin + 20C */
 	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
 }
@@ -566,7 +591,7 @@ static ssize_t show_pwm_tmin(struct device *dev,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
 }
=20
@@ -594,7 +619,7 @@ static ssize_t show_pwm_auto(struct device *dev,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
 }
=20
@@ -638,7 +663,7 @@ static ssize_t show_pwm_auto_temp(struct device *dev,
 				  char *buf)
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
-	struct adt7470_data *data =3D adt7470_update_device(dev);
+	struct adt7470_data *data =3D dev_to_adt7470_data(dev);
 	u8 ctrl =3D data->pwm_auto_temp[attr->index];
=20
 	if (ctrl)
@@ -913,6 +938,14 @@ static int adt7470_detect(struct i2c_adapter *adapter,=
 int address, int kind)
 		goto exit_remove;
 	}
=20
+	/* Initialize automatic sensor refresh */
+	INIT_WORK(&data->ref_work, adt7470_work_function);
+	init_timer(&data->timer);
+	data->timer.expires =3D jiffies + REFRESH_INTERVAL;
+	data->timer.data =3D (unsigned long)data;
+	data->timer.function =3D adt7470_timer_function;
+	add_timer(&data->timer);
+
 	return 0;
=20
 exit_remove:
@@ -930,6 +963,8 @@ static int adt7470_detach_client(struct i2c_client *cli=
ent)
 	struct adt7470_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
+	del_timer_sync(&data->timer);
+	cancel_work_sync(&data->ref_work);
 	hwmon_device_unregister(data->class_dev);
 	for (i =3D 0; i < ARRAY_SIZE(adt7470_attr); i++)
 		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp/MVa6vRYYgWQuURApPtAKCc8OrLqZ8C7jdpSWfczMPqLcsuuQCfQkSA
x10Dhzi/rneNPrH4e2pW9WY=
=By5u
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--


--===============6386970818458124737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6386970818458124737==--
