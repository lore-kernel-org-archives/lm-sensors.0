From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Jul 2007 12:42:55 +0000
Subject: [lm-sensors] PATCH: hwmon-fscher-support-fscpos.patch
Message-Id: <46922D4F.6050703@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030008050005010202050902"
List-Id: <lm-sensors.vger.kernel.org>
References: <46922D2E.60400@hhs.nl>
In-Reply-To: <46922D2E.60400@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030008050005010202050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

<oops one more time this time with attachment>

Hi All, Stefan,

As already mentioned in various post to the lm-sensors mailing list, the fscher
and fscpos chip are very very similar, this patch adds support for the fscpos
chip to the fscher driver, so that over time the fscpos driver can be dropped.

Notice that this patch applies on top of the earlier posted max alarms patch
for the fscher:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html

Stefan, Jean told me that you ported the fscpos driver from 2.4 to 2.6, kan you
test if the fscher driver with this patch will also work correctly on your
fscpos machine (according to the datasheets it should).

I would like to ask you specifically to test the tempX_max attributes, try
something like:
cat /sys/class/hwmon/hwmon0/device/temp1_max
That should give you a reasonable max temperature, on my machine it defaults to
77. This needs testing as I reverse engineered the tempX_max registers on my
machine and I hope they are identically on yours. We need them to be able to
reset the temp alarms once the alarm condition is cleared, as the chip doesn't
do this itself.

If the temp1_max look ok try:
sudo su -c "echo -n 22000 > /sys/class/hwmon/hwmon0/device/temp1_max"

And then wait 5 seconds and:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

It should be 1 now. Now put temp1_max back:
sudo su -c "echo -n 77000 > /sys/class/hwmon/hwmon0/device/temp1_max"

wait 2 seconds and then:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

This time is should still be one, but the read should have cleared the alarm,
so again:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

It should be 0 now.

Many thanks for testing!

Regards,

Hans



--------------030008050005010202050902
Content-Type: text/x-patch;
 name="hwmon-fscher-support-fscpos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fscher-support-fscpos.patch"

As already mentioned in various post to the lm-sensors mailing list, the fscher
and fscpos chip are very very similar, this patch adds support for the fscpos
chip to the fscher driver, so that over time the fscpos driver can be dropped.

Notice that this is untested on a fscpos as I lack the hardware to test this.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/fscher.c.orig linux-2.6.22-rc4/drivers/hwmon/fscher.c
--- linux-2.6.22-rc4/drivers/hwmon/fscher.c.orig	2007-07-09 13:18:28.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/fscher.c	2007-07-09 13:23:52.000000000 +0200
@@ -2,6 +2,7 @@
  * fscher.c - Part of lm_sensors, Linux kernel modules for hardware
  * monitoring
  * Copyright (C) 2003, 2004 Reinhard Nissl <rnissl@gmx.de>
+ * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
  * 
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -46,7 +47,7 @@ static unsigned short normal_i2c[] = { 0
  * Insmod parameters
  */
 
-I2C_CLIENT_INSMOD_1(fscher);
+I2C_CLIENT_INSMOD_2(fscher, fscpos);
 
 /*
  * The FSCHER registers
@@ -72,6 +73,11 @@ I2C_CLIENT_INSMOD_1(fscher);
 #define FSCHER_REG_VOLT_5		0x42
 #define FSCHER_REG_VOLT_BATT		0x48
 
+/* special (different) fan 3 addresses for fscpos support */
+#define FSCPOS_REG_FAN3_ACT		0xab
+#define FSCPOS_REG_FAN3_STATE		0xa2
+#define FSCPOS_REG_FAN3_RIPPLE		0xaf
+
 /* fans */
 static const u8 FSCHER_REG_FAN_MIN[] =		{ 0x55, 0x65, 0xb5 };
 static const u8 FSCHER_REG_FAN_ACT[] =		{ 0x0e, 0x6b, 0xbb };
@@ -117,6 +123,7 @@ static struct i2c_driver fscher_driver =
  */
 
 struct fscher_data {
+	enum chips kind;
 	struct i2c_client client;
 	struct class_device *class_dev;
 	struct mutex update_lock;
@@ -268,7 +275,6 @@ static struct attribute *fscher_attribut
 	&dev_attr_fan3_div.attr,
 	&dev_attr_fan3_input.attr,
 	&dev_attr_fan3_alarm.attr,
-	&dev_attr_pwm3.attr,
 
 	&dev_attr_temp1_status.attr,
 	&dev_attr_temp1_input.attr,
@@ -329,20 +335,34 @@ static int fscher_detect(struct i2c_adap
 	new_client->driver = &fscher_driver;
 	new_client->flags = 0;
 
-	/* Do the remaining detection unless force or force_fscher parameter */
-	if (kind < 0) {
+	/* Detect & Identify the chip */
+	if (kind <= 0) {
 		if ((i2c_smbus_read_byte_data(new_client,
-		     FSCHER_REG_IDENT_0) != 0x48)	/* 'H' */
-		 || (i2c_smbus_read_byte_data(new_client,
-		     FSCHER_REG_IDENT_1) != 0x45)	/* 'E' */
-		 || (i2c_smbus_read_byte_data(new_client,
-		     FSCHER_REG_IDENT_2) != 0x52))	/* 'R' */
+				FSCHER_REG_IDENT_0) == 0x48)	/* 'H' */
+			&& (i2c_smbus_read_byte_data(new_client,
+				FSCHER_REG_IDENT_1) == 0x45)	/* 'E' */
+			&& (i2c_smbus_read_byte_data(new_client,
+				FSCHER_REG_IDENT_2) == 0x52))	/* 'R' */
+			data->kind = fscher;
+		else if ((i2c_smbus_read_byte_data(new_client,
+				FSCHER_REG_IDENT_0) == 0x50)	/* 'P' */
+			&& (i2c_smbus_read_byte_data(new_client,
+				FSCHER_REG_IDENT_1) == 0x45)	/* 'E' */
+			&& (i2c_smbus_read_byte_data(new_client,
+				FSCHER_REG_IDENT_2) == 0x47))	/* 'G' */
+			data->kind = fscpos;
+		else
 			goto exit_free;
-	}
+	} else
+		data->kind = kind;
 
 	/* Fill in the remaining client fields and put it into the
 	 * global list */
-	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
+	if (data->kind == fscher)
+		strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
+	else
+		strlcpy(new_client->name, "fscpos", I2C_NAME_SIZE);
+
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
@@ -355,6 +375,11 @@ static int fscher_detect(struct i2c_adap
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &fscher_group)))
 		goto exit_detach;
+	
+	/* only the fscher has a min fan speed register for fan 3 */ 
+	if (data->kind == fscher && (err = device_create_file(&new_client->dev,
+			&dev_attr_pwm3)))
+		goto exit_remove_files;
 
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
@@ -366,6 +391,7 @@ static int fscher_detect(struct i2c_adap
 
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &fscher_group);
+	device_remove_file(&new_client->dev, &dev_attr_pwm3);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
@@ -381,6 +407,7 @@ static int fscher_detach_client(struct i
 
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&client->dev.kobj, &fscher_group);
+	device_remove_file(&client->dev, &dev_attr_pwm3);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
@@ -440,14 +467,25 @@ static struct fscher_data *fscher_update
 				fscher_write_value(client,
 					FSCHER_REG_TEMP_STATE[i], 0x02);
 					
-			data->fan_act[i] = fscher_read_value(client,
+			/* The fscpos' third fan has its registers at different
+			   addresses and doesn't have a fan_min */
+			if (data->kind == fscpos && i == 2) {
+				data->fan_act[i] = fscher_read_value(client,
+						FSCPOS_REG_FAN3_ACT);
+				data->fan_status[i] = fscher_read_value(client,
+						FSCPOS_REG_FAN3_STATE);
+				data->fan_ripple[i] = fscher_read_value(client,
+						FSCPOS_REG_FAN3_RIPPLE);
+			} else {
+				data->fan_act[i] = fscher_read_value(client,
 						FSCHER_REG_FAN_ACT[i]);
-			data->fan_status[i] = fscher_read_value(client,
+				data->fan_status[i] = fscher_read_value(client,
 						FSCHER_REG_FAN_STATE[i]);
-			data->fan_min[i] = fscher_read_value(client,
-						FSCHER_REG_FAN_MIN[i]);
-			data->fan_ripple[i] = fscher_read_value(client,
+				data->fan_ripple[i] = fscher_read_value(client,
 						FSCHER_REG_FAN_RIPPLE[i]);
+				data->fan_min[i] = fscher_read_value(client,
+						FSCHER_REG_FAN_MIN[i]);
+			}
 
 			/* reset fan status if speed is back to > 0 */
 			if ((data->fan_status[i] & 0x04) && data->fan_act[i])
@@ -464,6 +502,8 @@ static struct fscher_data *fscher_update
 		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
 
 		data->global_event = fscher_read_value(client, FSCHER_REG_EVENT_STATE);
+		data->global_control = fscher_read_value(client,
+							FSCHER_REG_CONTROL);
 
 		data->last_updated = jiffies;
 		data->valid = 1;                 
@@ -696,11 +736,18 @@ static ssize_t set_watchdog_control(stru
 				    fscher_data *data, const char *buf, size_t count,
 				    int nr, int reg)
 {
-	/* bits 0..3 reserved => mask with 0xf0 */  
-	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+	u8 mask;
+
+	if (data->kind == fscher)
+		mask = 0xf0; /* bits 0..3 reserved */
+	else
+		mask = 0xb0; /* bits 0..3 & 6 reserved */
+
+	v &= mask;
 
 	mutex_lock(&data->update_lock);
-	data->watchdog[2] &= ~0xf0;
+	data->watchdog[2] &= ~mask;
 	data->watchdog[2] |= v;
 	fscher_write_value(client, reg, data->watchdog[2]);
 	mutex_unlock(&data->update_lock);
@@ -709,8 +756,14 @@ static ssize_t set_watchdog_control(stru
 
 static ssize_t show_watchdog_control(struct fscher_data *data, char *buf, int nr)
 {
-	/* bits 0..3 reserved, bit 5 write only => mask with 0xd0 */
-	return sprintf(buf, "%u\n", data->watchdog[2] & 0xd0);
+	u8 mask;
+
+	if (data->kind == fscher)
+		mask = 0xd0; /* bits 0..3 reserved, 5 write only */
+	else
+		mask = 0x90; /* bits 0..3 & 6 reserved, 5 write only */
+
+	return sprintf(buf, "%u\n", data->watchdog[2] & mask);
 }
 
 static ssize_t set_watchdog_status(struct i2c_client *client, struct fscher_data *data,
@@ -720,7 +773,7 @@ static ssize_t set_watchdog_status(struc
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
 
 	mutex_lock(&data->update_lock);
-	data->watchdog[1] &= ~v;
+	data->watchdog[1] &= ~v; /* write 1 to clear */
 	fscher_write_value(client, reg, v);
 	mutex_unlock(&data->update_lock);
 	return count;

--------------030008050005010202050902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030008050005010202050902--

