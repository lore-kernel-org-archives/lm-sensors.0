From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 19 Jul 2008 10:05:41 +0000
Subject: [lm-sensors] [PATCH 3/3] thmc50: add support for thmc51 and adm1028
Message-Id: <20080719120541.92fa7d08.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1 at wp.pl>

This patch add support two more sensor models:
Texas Instruments THMC51 and Analog Devices ADM1028.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>
---

A problem with the thmc51 is that it has a single temperature which
is numbered as the second one for all other sensors. I defined a new
thmc51_group which is registered for this sensor model only. 
It leaves core of driver untouched but requires more if-else
clauses in the detect and detach functions.

diff -urp hwmon/drivers/hwmon/thmc50.c linux-2.6.26/drivers/hwmon/thmc50.c
--- hwmon/drivers/hwmon/thmc50.c	2008-07-19 11:31:18.417979397 +0200
+++ linux-2.6.26/drivers/hwmon/thmc50.c	2008-07-19 11:48:21.037973587 +0200
@@ -35,7 +35,7 @@ MODULE_LICENSE("GPL");
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_2(thmc50, adm1022);
+I2C_CLIENT_INSMOD_4(thmc50, thmc51, adm1022, adm1028);
 I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs "
 			"to enable 3rd temperature (ADM1022 only)");
 
@@ -91,6 +91,8 @@ static struct thmc50_data *thmc50_update
 static const struct i2c_device_id thmc50_id[] = {
 	{ "adm1022", adm1022 },
 	{ "thmc50", thmc50 },
+	{ "adm1028", adm1028 },
+	{ "thmc51", thmc51 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, thmc50_id);
@@ -235,16 +237,48 @@ temp_reg(1);
 temp_reg(2);
 temp_reg(3);
 
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_input
+	= SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1);
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_min
+	= SENSOR_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min,
+			set_temp_min, 1);
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_max
+	= SENSOR_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max,
+			set_temp_max, 1);
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_crit
+	= SENSOR_ATTR(temp1_crit, S_IRUGO, show_temp_critical, NULL, 1);
+
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 7);
 static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
 
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_alarm
+	= SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 5);
+struct sensor_device_attribute sensor_dev_attr_thmc51_temp_fault
+	= SENSOR_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 7);
+
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_analog_out,
 			  set_analog_out, 0);
 static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
 
+static struct attribute *thmc51_attributes[] = {
+	&sensor_dev_attr_thmc51_temp_max.dev_attr.attr,
+	&sensor_dev_attr_thmc51_temp_min.dev_attr.attr,
+	&sensor_dev_attr_thmc51_temp_input.dev_attr.attr,
+	&sensor_dev_attr_thmc51_temp_crit.dev_attr.attr,
+	&sensor_dev_attr_thmc51_temp_alarm.dev_attr.attr,
+	&sensor_dev_attr_thmc51_temp_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group thmc51_group = {
+	.attrs = thmc51_attributes,
+};
+
 static struct attribute *thmc50_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -310,13 +344,23 @@ static int thmc50_detect(struct i2c_clie
 		kind = thmc50;
 	else if (kind < 0) {
 		err = -ENODEV;
-		if (revision >= 0xc0 && ((config & 0x10) = 0)) {
-			if (company = 0x49) {
-				kind = thmc50;
-				err = 0;
-			} else if (company = 0x41) {
-				kind = adm1022;
-				err = 0;
+		if ((config & 0x10) = 0) {
+			if ((revision & 0xf0) = 0xc0) {
+				if (company = 0x49) {
+					kind = thmc50;
+					err = 0;
+				} else if (company = 0x41) {
+					kind = adm1022;
+					err = 0;
+				}
+			} else if ((revision & 0xf0) >= 0xd0) {
+				if (company = 0x49) {
+					kind = thmc51;
+					err = 0;
+				} else if (company = 0x41) {
+					kind = adm1028;
+					err = 0;
+				}
 			}
 		}
 	}
@@ -340,6 +384,10 @@ static int thmc50_detect(struct i2c_clie
 							  config);
 				break;
 			}
+	} else if (kind = adm1028) {
+		type_name = "adm1028";
+	} else if (kind = thmc51) {
+		type_name = "thmc51";
 	} else {
 		type_name = "thmc50";
 	}
@@ -371,7 +419,12 @@ static int thmc50_probe(struct i2c_clien
 	thmc50_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &thmc50_group)))
+	if (data->type = thmc51)
+		err = sysfs_create_group(&client->dev.kobj, &thmc51_group);
+	else
+		err = sysfs_create_group(&client->dev.kobj, &thmc50_group);
+
+	if (err)
 		goto exit_free;
 
 	/* Register ADM1022 sysfs hooks */
@@ -393,7 +446,10 @@ exit_remove_sysfs:
 	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
-	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+	if (data->type = thmc51)
+		sysfs_remove_group(&client->dev.kobj, &thmc51_group);
+	else
+		sysfs_remove_group(&client->dev.kobj, &thmc50_group);
 exit_free:
 	kfree(data);
 exit:
@@ -405,7 +461,10 @@ static int thmc50_remove(struct i2c_clie
 	struct thmc50_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+	if (data->type = thmc51)
+		sysfs_remove_group(&client->dev.kobj, &thmc51_group);
+	else
+		sysfs_remove_group(&client->dev.kobj, &thmc50_group);
 	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
@@ -427,7 +486,7 @@ static void thmc50_init_client(struct i2
 		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
 					  data->analog_out);
 	}
-	data->temp_num = 2;
+	data->temp_num = (data->type = thmc51) ? 1 : 2;
 	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 	config |= 0x1;	/* start the chip if it is in standby mode */
 	if (config & (1 << 7)) /* config MSB */
@@ -446,12 +505,13 @@ static struct thmc50_data *thmc50_update
 	if (time_after(jiffies, data->last_updated + timeout)
 	    || !data->valid) {
 
+		int temp_start = (data->type = thmc51) ? 1 : 0;
 		int i;
 		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 
 		prog &= THMC50_REG_CONF_PROGRAMMED;
 
-		for (i = 0; i < data->temp_num; i++) {
+		for (i = temp_start; i < temp_start + data->temp_num; i++) {
 			data->temp_input[i] = i2c_smbus_read_byte_data(client,
 						THMC50_REG_TEMP[i]);
 			data->temp_max[i] = i2c_smbus_read_byte_data(client,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
