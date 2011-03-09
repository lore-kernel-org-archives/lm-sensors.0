From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:12 +0000
Subject: [lm-sensors] [PATCH 06/10] hwmon/f71882fg: Separate temp beep sysfs
Message-Id: <1299700636-9699-7-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a preparation patch for adding support for more different models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   76 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index a1ca0cf..7f71a5a 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -127,6 +127,14 @@ static const char f71882fg_has_in1_alarm[5] = {
 	0, /* f8000 */
 };
 
+static const char f71882fg_has_beep[5] = {
+	0, /* f71858fg */
+	1, /* f71862fg */
+	1, /* f71882fg */
+	1, /* f71889fg */
+	0, /* f8000 */
+};
+
 static struct platform_device *f71882fg_pdev;
 
 /* Super-I/O Function prototypes */
@@ -324,7 +332,7 @@ static struct sensor_device_attribute_2 f71858fg_temp_attr[] = {
 };
 
 /* Temp attr for the standard models */
-static struct sensor_device_attribute_2 fxxxx_temp_attr[3][11] = { {
+static struct sensor_device_attribute_2 fxxxx_temp_attr[3][9] = { {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 1),
@@ -334,15 +342,11 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[3][11] = { {
 	   the max and crit alarms separately and lm_sensors v2 depends on the
 	   presence of temp#_alarm files. The same goes for temp2/3 _alarm. */
 	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
-	SENSOR_ATTR_2(temp1_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 1),
 	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 1),
 	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 1),
 	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
-	SENSOR_ATTR_2(temp1_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 5),
 	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
 }, {
@@ -353,15 +357,11 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[3][11] = { {
 		store_temp_max_hyst, 0, 2),
 	/* Should be temp2_max_alarm, see temp1_alarm note */
 	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
-	SENSOR_ATTR_2(temp2_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 2),
 	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 2),
 	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 2),
 	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
-	SENSOR_ATTR_2(temp2_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 6),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 }, {
@@ -372,19 +372,33 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[3][11] = { {
 		store_temp_max_hyst, 0, 3),
 	/* Should be temp3_max_alarm, see temp1_alarm note */
 	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
-	SENSOR_ATTR_2(temp3_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 3),
 	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 3),
 	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 3),
 	SENSOR_ATTR_2(temp3_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 7),
-	SENSOR_ATTR_2(temp3_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 7),
 	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
 } };
 
+/* Temp attr for models which can beep on temp alarm */
+static struct sensor_device_attribute_2 fxxxx_temp_beep_attr[3][2] = { {
+	SENSOR_ATTR_2(temp1_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
+	SENSOR_ATTR_2(temp1_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 5),
+}, {
+	SENSOR_ATTR_2(temp2_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
+	SENSOR_ATTR_2(temp2_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 6),
+}, {
+	SENSOR_ATTR_2(temp3_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 3),
+	SENSOR_ATTR_2(temp3_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 7),
+} };
+
 /* Temp attr for the f8000
    Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
    is used as hysteresis value to clear alarms
@@ -989,17 +1003,19 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			data->temp_hyst[1] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_HYST(1));
 		}
+		/* All but the f71858fg / f8000 have this register */
+		if ((data->type != f71858fg) && (data->type != f8000)) {
+			reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
+			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
+			data->temp_type[2] = (reg & 0x04) ? 2 : 4;
+			data->temp_type[3] = (reg & 0x08) ? 2 : 4;
+		}
 
-		if (data->type = f71862fg || data->type = f71882fg ||
-		    data->type = f71889fg) {
+		if (f71882fg_has_beep[data->type]) {
 			data->fan_beep = f71882fg_read8(data,
 						F71882FG_REG_FAN_BEEP);
 			data->temp_beep = f71882fg_read8(data,
 						F71882FG_REG_TEMP_BEEP);
-			reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
-			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
-			data->temp_type[2] = (reg & 0x04) ? 2 : 4;
-			data->temp_type[3] = (reg & 0x08) ? 2 : 4;
 		}
 
 		data->pwm_enable = f71882fg_read8(data,
@@ -1979,6 +1995,15 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		if (err)
 			goto exit_unregister_sysfs;
 
+		if (f71882fg_has_beep[data->type]) {
+			err = f71882fg_create_sysfs_files(pdev,
+					&fxxxx_temp_beep_attr[0][0],
+					ARRAY_SIZE(fxxxx_temp_beep_attr[0])
+						* nr_temps);
+			if (err)
+				goto exit_unregister_sysfs;
+		}
+
 		for (i = 0; i < F71882FG_MAX_INS; i++) {
 			if (f71882fg_has_in[data->type][i]) {
 				err = device_create_file(&pdev->dev,
@@ -2042,8 +2067,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		if (err)
 			goto exit_unregister_sysfs;
 
-		if (data->type = f71862fg || data->type = f71882fg ||
-		    data->type = f71889fg) {
+		if (f71882fg_has_beep[data->type]) {
 			err = f71882fg_create_sysfs_files(pdev,
 					fxxxx_fan_beep_attr, nr_fans);
 			if (err)
@@ -2148,6 +2172,12 @@ static int f71882fg_remove(struct platform_device *pdev)
 				&fxxxx_temp_attr[0][0],
 				ARRAY_SIZE(fxxxx_temp_attr[0]) * nr_temps);
 		}
+		if (f71882fg_has_beep[data->type]) {
+			f71882fg_remove_sysfs_files(pdev,
+			       &fxxxx_temp_beep_attr[0][0],
+			       ARRAY_SIZE(fxxxx_temp_beep_attr[0]) * nr_temps);
+		}
+
 		for (i = 0; i < F71882FG_MAX_INS; i++) {
 			if (f71882fg_has_in[data->type][i]) {
 				device_remove_file(&pdev->dev,
@@ -2165,10 +2195,10 @@ static int f71882fg_remove(struct platform_device *pdev)
 		f71882fg_remove_sysfs_files(pdev, &fxxxx_fan_attr[0][0],
 				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
 
-		if (data->type = f71862fg || data->type = f71882fg ||
-		    data->type = f71889fg)
+		if (f71882fg_has_beep[data->type]) {
 			f71882fg_remove_sysfs_files(pdev,
 					fxxxx_fan_beep_attr, nr_fans);
+		}
 
 		switch (data->type) {
 		case f71862fg:
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
