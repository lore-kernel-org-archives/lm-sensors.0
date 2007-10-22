From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 15:46:17 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (gl518sm) Don't create sysfs files
Message-Id: <20071022174617.6866b875@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The early revisions of the GL518SM do not report voltage values for
the first 3 voltage channels. We should not create sysfs attributes
for these missing features.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-21 21:39:52.00000=
0000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-21 22:38:28.000000000 =
+0200
@@ -336,9 +336,6 @@ static DEVICE_ATTR(beep_mask, S_IWUSR|S_
 	show_beep_mask, set_beep_mask);
=20
 static struct attribute *gl518_attributes[] =3D {
-	&dev_attr_in0_input.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in2_input.attr,
 	&dev_attr_in3_input.attr,
 	&dev_attr_in0_min.attr,
 	&dev_attr_in1_min.attr,
@@ -371,6 +368,17 @@ static const struct attribute_group gl51
 	.attrs =3D gl518_attributes,
 };
=20
+static struct attribute *gl518_attributes_r80[] =3D {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+	&dev_attr_in2_input.attr,
+	NULL
+};
+
+static const struct attribute_group gl518_group_r80 =3D {
+	.attrs =3D gl518_attributes_r80,
+};
+
 /*
  * Real code
  */
@@ -445,12 +453,15 @@ static int gl518_detect(struct i2c_adapt
=20
 	/* Initialize the GL518SM chip */
 	data->alarm_mask =3D 0xff;
-	data->voltage_in[0]=DAta->voltage_in[1]=DAta->voltage_in[2]=3D0;
 	gl518_init_client(client);
=20
 	/* Register sysfs hooks */
 	if ((err =3D sysfs_create_group(&client->dev.kobj, &gl518_group)))
 		goto exit_detach;
+	if (data->type =3D gl518sm_r80)
+		if ((err =3D sysfs_create_group(&client->dev.kobj,
+					      &gl518_group_r80)))
+			goto exit_remove_files;
=20
 	data->hwmon_dev =3D hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -462,6 +473,8 @@ static int gl518_detect(struct i2c_adapt
=20
 exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &gl518_group);
+	if (data->type =3D gl518sm_r80)
+		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
 exit_detach:
 	i2c_detach_client(client);
 exit_free:
@@ -496,6 +509,8 @@ static int gl518_detach_client(struct i2
=20
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &gl518_group);
+	if (data->type =3D gl518sm_r80)
+		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
=20
 	if ((err =3D i2c_detach_client(client)))
 		return err;


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
