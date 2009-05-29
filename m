From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 May 2009 09:06:03 +0000
Subject: [lm-sensors] PATCH [3/4]: hwmon: f71882fg add temp#_fault sysfs
Message-Id: <4A1FA57B.3040505@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050001090501000409020005"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050001090501000409020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While working on f71852fg support I noticed that the f8000 sysfs attr
table was missing entries for temp#_fault, which the f8000 does have and
which we were already reading.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------050001090501000409020005
Content-Type: text/plain;
 name="hwmon-f71882fg-03-f8000-temp_fault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hwmon-f71882fg-03-f8000-temp_fault.patch"

hwmon: f71882fg add temp#_fault sysfs attr for f8000

While working on f71852fg support I noticed that the f8000 sysfs attr
table was missing entries for temp#_fault, which the f8000 does have and
which we were already reading.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.orig3	2009-05-28 21:30:34.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2009-05-28 21:32:20.000000000 +0200
@@ -344,6 +344,7 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 0),
 	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 4),
+	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
 	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
 	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 1),
@@ -351,12 +352,14 @@ static struct sensor_device_attribute_2 
 		store_temp_max, 0, 1),
 	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
 	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
 	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 2),
 	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 2),
 	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
+	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 };
 
 /* Fan / PWM attr common to all models */

--------------050001090501000409020005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050001090501000409020005--
