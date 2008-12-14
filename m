From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 14 Dec 2008 14:36:28 +0000
Subject: [lm-sensors] PATCH: f71882fg: separate max and crit alarm and beep
Message-Id: <494519EC.4060702@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010100020307070209070006"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100020307070209070006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

While studying the datasheets for adding F8000 support, I noticed that the
F718x2 has separate alarms (and beep control) for its max and crit limits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks & Regards,

Hans

--------------010100020307070209070006
Content-Type: text/plain;
	name="hwmon-f71882fg-11-separate-max-crit-alarm-and-beep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="hwmon-f71882fg-11-separate-max-crit-alarm-and-beep.patch"

While studying the datasheets for adding F8000 support, I noticed that the
F718x2 has separate alarms (and beep control) for its max and crit limits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.10-applied	2008-12-14 15:25:01.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-14 15:25:23.000000000 +0100
@@ -270,42 +270,51 @@
 		store_temp_max, 0, 1),
 	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 1),
+	SENSOR_ATTR_2(temp1_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(temp1_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
 	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 1),
 	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 1),
+	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
+	SENSOR_ATTR_2(temp1_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 5),
 	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 1),
-	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 1),
-	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
 	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 2),
 	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 2),
+	SENSOR_ATTR_2(temp2_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(temp2_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
 	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 2),
 	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 2),
+	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
+	SENSOR_ATTR_2(temp2_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 6),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 2),
-	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 2),
-	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 3),
 	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 3),
+	SENSOR_ATTR_2(temp3_max_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
+	SENSOR_ATTR_2(temp3_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 3),
 	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 3),
 	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 3),
+	SENSOR_ATTR_2(temp3_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 7),
+	SENSOR_ATTR_2(temp3_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 7),
 	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 3),
-	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 3),
-	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
 };
 

--------------010100020307070209070006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010100020307070209070006--
