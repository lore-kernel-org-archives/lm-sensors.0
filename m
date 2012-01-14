From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jan 2012 09:08:36 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm63) Support extended lookup table of LM96163
Message-Id: <20120114100836.462e6f2e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM96163 has an extended lookup table with 12 entries instead of 8,
add support for that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Guenter, can you please test this patch (on top of the previous one) on
your LM96163? Thanks.

 drivers/hwmon/lm63.c |   69 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 7 deletions(-)

--- linux-3.3-rc0.orig/drivers/hwmon/lm63.c	2012-01-14 07:39:10.000000000 +0100
+++ linux-3.3-rc0/drivers/hwmon/lm63.c	2012-01-14 07:45:49.000000000 +0100
@@ -203,18 +203,19 @@ struct lm63_data {
 
 	int update_interval;	/* in milliseconds */
 	int max_convrate_hz;
+	int lut_size;		/* 8 or 12 */
 
 	/* registers values */
 	u8 config, config_fan;
 	u16 fan[2];	/* 0: input
 			   1: low limit */
 	u8 pwm1_freq;
-	u8 pwm1[9];	/* 0: current output
-			   1-8: lookup table */
-	s8 temp8[11];	/* 0: local input
+	u8 pwm1[13];	/* 0: current output
+			   1-12: lookup table */
+	s8 temp8[15];	/* 0: local input
 			   1: local high limit
 			   2: remote critical limit
-			   3-10: lookup table */
+			   3-14: lookup table */
 	s16 temp11[4];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
@@ -653,6 +654,26 @@ static SENSOR_DEVICE_ATTR(pwm1_auto_poin
 	show_lut_temp, NULL, 10);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp_hyst, S_IRUGO,
 	show_lut_temp_hyst, NULL, 10);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point9_pwm, S_IRUGO, show_pwm1, NULL, 9);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp, S_IRUGO,
+	show_lut_temp, NULL, 11);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 11);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point10_pwm, S_IRUGO, show_pwm1, NULL, 10);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp, S_IRUGO,
+	show_lut_temp, NULL, 12);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 12);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point11_pwm, S_IRUGO, show_pwm1, NULL, 11);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp, S_IRUGO,
+	show_lut_temp, NULL, 13);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 13);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point12_pwm, S_IRUGO, show_pwm1, NULL, 12);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp, S_IRUGO,
+	show_lut_temp, NULL, 14);
+static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp_hyst, S_IRUGO,
+	show_lut_temp_hyst, NULL, 14);
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_local_temp8, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_local_temp8,
@@ -732,6 +753,26 @@ static struct attribute *lm63_attributes
 	NULL
 };
 
+static struct attribute *lm63_attributes_extra_lut[] = {
+	&sensor_dev_attr_pwm1_auto_point9_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point9_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point9_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point10_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point10_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point10_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point11_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point11_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point11_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point12_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point12_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point12_temp_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm63_group_extra_lut = {
+	.attrs = lm63_attributes_extra_lut,
+};
+
 /*
  * On LM63, temp2_crit can be set only once, which should be job
  * of the bootloader.
@@ -861,6 +902,11 @@ static int lm63_probe(struct i2c_client
 					 &dev_attr_temp2_type);
 		if (err)
 			goto exit_remove_files;
+
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm63_group_extra_lut);
+		if (err)
+			goto exit_remove_files;
 	}
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
@@ -872,9 +918,13 @@ static int lm63_probe(struct i2c_client
 	return 0;
 
 exit_remove_files:
-	device_remove_file(&new_client->dev, &dev_attr_temp2_type);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group_fan1);
+	if (data->kind = lm96163) {
+		device_remove_file(&new_client->dev, &dev_attr_temp2_type);
+		sysfs_remove_group(&new_client->dev.kobj,
+				   &lm63_group_extra_lut);
+	}
 exit_free:
 	kfree(data);
 exit:
@@ -914,9 +964,11 @@ static void lm63_init_client(struct i2c_
 	case lm63:
 	case lm64:
 		data->max_convrate_hz = LM63_MAX_CONVRATE_HZ;
+		data->lut_size = 8;
 		break;
 	case lm96163:
 		data->max_convrate_hz = LM96163_MAX_CONVRATE_HZ;
+		data->lut_size = 12;
 		data->trutherm
 		  = i2c_smbus_read_byte_data(client,
 					     LM96163_REG_TRUTHERM) & 0x02;
@@ -963,9 +1015,12 @@ static int lm63_remove(struct i2c_client
 	struct lm63_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	device_remove_file(&client->dev, &dev_attr_temp2_type);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
+	if (data->kind = lm96163) {
+		device_remove_file(&client->dev, &dev_attr_temp2_type);
+		sysfs_remove_group(&client->dev.kobj, &lm63_group_extra_lut);
+	}
 
 	kfree(data);
 	return 0;
@@ -1046,7 +1101,7 @@ static struct lm63_data *lm63_update_dev
 
 	if (time_after(jiffies, data->lut_last_updated + 5 * HZ) ||
 	    !data->lut_valid) {
-		for (i = 0; i < 8; i++) {
+		for (i = 0; i < data->lut_size; i++) {
 			data->pwm1[1 + i] = i2c_smbus_read_byte_data(client,
 					    LM63_REG_LUT_PWM(i));
 			data->temp8[3 + i] = i2c_smbus_read_byte_data(client,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
