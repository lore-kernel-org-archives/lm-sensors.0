From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 May 2009 09:05:56 +0000
Subject: [lm-sensors] PATCH [1/4]: hwmon: f71882fg cleanup f8000 pwm handling
Message-Id: <4A1FA574.5050405@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000200020701080005060304"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200020701080005060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Currently we are using separate per model sysfs attr for the 3th pwm, because
the 3th pwm of the f8000 only has automatic mode and not manual mode. Doing
things this way was getting in the way for adding f71858fg support, so this
patch makes the pwm attr identical for all models, and instead adds a check
to store_pwm_enable() disallowing setting the 3th pwm to manual mode
on a f8000 IC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------000200020701080005060304
Content-Type: text/plain;
 name="hwmon-f71882fg-01-f8000-cleanup-pwm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hwmon-f71882fg-01-f8000-cleanup-pwm.patch"

hwmon: f71882fg cleanup f8000 pwm handling

Currently we are using separate per model sysfs attr for the 3th pwm, because
the 3th pwm of the f8000 only has automatic mode and not manual mode. Doing
things this way was getting in the way for adding f71858fg support, so this
patch makes the pwm attr identical for all models, and instead adds a check
to store_pwm_enable() disallowing setting the 3th pwm to manual mode
on a f8000 IC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.orig	2009-05-28 12:15:19.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2009-05-28 20:51:01.000000000 +0200
@@ -1,6 +1,6 @@
 /***************************************************************************
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
- *   Copyright (C) 2007,2008 by Hans de Goede <hdegoede@redhat.com>        *
+ *   Copyright (C) 2007-2009 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -395,6 +395,9 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
 
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
 		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
@@ -450,9 +453,6 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
 
-	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
-	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      1, 2),
@@ -565,9 +565,6 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
 
-	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
-	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 2),
@@ -659,8 +656,6 @@ static struct sensor_device_attribute_2 
 static struct sensor_device_attribute_2 f8000_fan_attr[] = {
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
 
-	SENSOR_ATTR_2(pwm3, S_IRUGO, show_pwm, NULL, 0, 2),
-
 	SENSOR_ATTR_2(temp1_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 2),
@@ -1440,6 +1435,10 @@ static ssize_t store_pwm_enable(struct d
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	long val = simple_strtol(buf, NULL, 10);
 
+	/* Special case for F8000 pwm channel 3 which only does auto mode */
+	if (data->type == f8000 && nr == 2 && val != 2)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	/* Special case for F8000 auto PWM mode / Thermostat mode */

--------------000200020701080005060304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000200020701080005060304--
