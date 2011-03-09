From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:10 +0000
Subject: [lm-sensors] [PATCH 04/10] hwmon/f71882fg: Make creation of in
Message-Id: <1299700636-9699-5-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a preparation patch for adding support for more different models,
some of which have a sparse list of used voltage pins.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |  180 ++++++++++++++++++++++++++--------------------
 1 files changed, 103 insertions(+), 77 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 2b45af9..17c752c 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -93,6 +93,8 @@
 
 #define	F71882FG_REG_START		0x01
 
+#define F71882FG_MAX_INS		9
+
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
 
 static unsigned short force_id;
@@ -109,6 +111,22 @@ static const char *f71882fg_names[] = {
 	"f8000",
 };
 
+static const char f71882fg_has_in[5][F71882FG_MAX_INS] = {
+	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f71858fg */
+	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71862fg */
+	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71882fg */
+	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889fg */
+	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f8000 */
+};
+
+static const char f71882fg_has_in1_alarm[5] = {
+	0, /* f71858fg */
+	0, /* f71862fg */
+	1, /* f71882fg */
+	1, /* f71889fg */
+	0, /* f8000 */
+};
+
 static struct platform_device *f71882fg_pdev;
 
 /* Super-I/O Function prototypes */
@@ -135,7 +153,7 @@ struct f71882fg_data {
 	unsigned long last_limits;	/* In jiffies */
 
 	/* Register Values */
-	u8	in[9];
+	u8	in[F71882FG_MAX_INS];
 	u8	in1_max;
 	u8	in_status;
 	u8	in_beep;
@@ -264,13 +282,9 @@ static struct platform_driver f71882fg_driver = {
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-/* Temp and in attr for the f71858fg, the f71858fg is special as it
-   has its temperature indexes start at 0 (the others start at 1) and
-   it only has 3 voltage inputs */
-static struct sensor_device_attribute_2 f71858fg_in_temp_attr[] = {
-	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
-	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
-	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+/* Temp attr for the f71858fg, the f71858fg is special as it has its
+   temperature indexes start at 0 (the others start at 1) */
+static struct sensor_device_attribute_2 f71858fg_temp_attr[] = {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 0),
@@ -309,17 +323,8 @@ static struct sensor_device_attribute_2 f71858fg_in_temp_attr[] = {
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 };
 
-/* Temp and in attr common to the f71862fg, f71882fg and f71889fg */
-static struct sensor_device_attribute_2 fxxxx_in_temp_attr[] = {
-	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
-	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
-	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
-	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
-	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
-	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 0, 5),
-	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
-	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
-	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
+/* Temp attr for the standard models */
+static struct sensor_device_attribute_2 fxxxx_temp_attr[] = {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 1),
@@ -378,24 +383,12 @@ static struct sensor_device_attribute_2 fxxxx_in_temp_attr[] = {
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
 };
 
-/* For models with in1 alarm capability */
-static struct sensor_device_attribute_2 fxxxx_in1_alarm_attr[] = {
-	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
-		0, 1),
-	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep,
-		0, 1),
-	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
-};
-
-/* Temp and in attr for the f8000
+/* Temp attr for the f8000
    Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
    is used as hysteresis value to clear alarms
    Also like the f71858fg its temperature indexes start at 0
  */
-static struct sensor_device_attribute_2 f8000_in_temp_attr[] = {
-	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
-	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
-	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+static struct sensor_device_attribute_2 f8000_temp_attr[] = {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 0),
@@ -419,6 +412,28 @@ static struct sensor_device_attribute_2 f8000_in_temp_attr[] = {
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 };
 
+/* in attr for all models */
+static struct sensor_device_attribute_2 fxxxx_in_attr[] = {
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
+	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
+	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 0, 5),
+	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
+	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
+	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
+};
+
+/* For models with in1 alarm capability */
+static struct sensor_device_attribute_2 fxxxx_in1_alarm_attr[] = {
+	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
+		0, 1),
+	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep,
+		0, 1),
+	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
+};
+
 /* Fan / PWM attr common to all models */
 static struct sensor_device_attribute_2 fxxxx_fan_attr[4][6] = { {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
@@ -945,14 +960,13 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr, reg;
 	int nr_fans = (data->type = f71882fg) ? 4 : 3;
-	int nr_ins = (data->type = f71858fg || data->type = f8000) ? 3 : 9;
 
 	mutex_lock(&data->update_lock);
 
 	/* Update once every 60 seconds */
 	if (time_after(jiffies, data->last_limits + 60 * HZ) ||
 			!data->valid) {
-		if (data->type = f71882fg || data->type = f71889fg) {
+		if (f71882fg_has_in1_alarm[data->type]) {
 			data->in1_max  				f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
 			data->in_beep @@ -1056,17 +1070,18 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			data->pwm[nr]  			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
 		}
-
 		/* The f8000 can monitor 1 more fan, but has no pwm for it */
 		if (data->type = f8000)
 			data->fan[3] = f71882fg_read16(data,
 						F71882FG_REG_FAN(3));
-		if (data->type = f71882fg || data->type = f71889fg)
+
+		if (f71882fg_has_in1_alarm[data->type])
 			data->in_status = f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
-		for (nr = 0; nr < nr_ins; nr++)
-			data->in[nr] = f71882fg_read8(data,
-						F71882FG_REG_IN(nr));
+		for (nr = 0; nr < F71882FG_MAX_INS; nr++)
+			if (f71882fg_has_in[data->type][nr])
+				data->in[nr] = f71882fg_read8(data,
+							F71882FG_REG_IN(nr));
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -1941,34 +1956,41 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 				/* The f71858fg temperature alarms behave as
 				   the f8000 alarms in this mode */
 				err = f71882fg_create_sysfs_files(pdev,
-					f8000_in_temp_attr,
-					ARRAY_SIZE(f8000_in_temp_attr));
+					f8000_temp_attr,
+					ARRAY_SIZE(f8000_temp_attr));
 			else
 				err = f71882fg_create_sysfs_files(pdev,
-					f71858fg_in_temp_attr,
-					ARRAY_SIZE(f71858fg_in_temp_attr));
-			break;
-		case f71882fg:
-		case f71889fg:
-			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_in1_alarm_attr,
-					ARRAY_SIZE(fxxxx_in1_alarm_attr));
-			if (err)
-				goto exit_unregister_sysfs;
-			/* fall through! */
-		case f71862fg:
-			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_in_temp_attr,
-					ARRAY_SIZE(fxxxx_in_temp_attr));
+					f71858fg_temp_attr,
+					ARRAY_SIZE(f71858fg_temp_attr));
 			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
-					f8000_in_temp_attr,
-					ARRAY_SIZE(f8000_in_temp_attr));
+					f8000_temp_attr,
+					ARRAY_SIZE(f8000_temp_attr));
 			break;
+		default:
+			err = f71882fg_create_sysfs_files(pdev,
+					fxxxx_temp_attr,
+					ARRAY_SIZE(fxxxx_temp_attr));
 		}
 		if (err)
 			goto exit_unregister_sysfs;
+
+		for (i = 0; i < F71882FG_MAX_INS; i++) {
+			if (f71882fg_has_in[data->type][i]) {
+				err = device_create_file(&pdev->dev,
+						&fxxxx_in_attr[i].dev_attr);
+				if (err)
+					goto exit_unregister_sysfs;
+			}
+		}
+		if (f71882fg_has_in1_alarm[data->type]) {
+			err = f71882fg_create_sysfs_files(pdev,
+					fxxxx_in1_alarm_attr,
+					ARRAY_SIZE(fxxxx_in1_alarm_attr));
+			if (err)
+				goto exit_unregister_sysfs;
+		}
 	}
 
 	if (start_reg & 0x02) {
@@ -2091,7 +2113,7 @@ exit_free:
 static int f71882fg_remove(struct platform_device *pdev)
 {
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
-	int nr_fans = (data->type = f71882fg) ? 4 : 3;
+	int i, nr_fans = (data->type = f71882fg) ? 4 : 3;
 	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
 
 	platform_set_drvdata(pdev, NULL);
@@ -2105,29 +2127,33 @@ static int f71882fg_remove(struct platform_device *pdev)
 		case f71858fg:
 			if (data->temp_config & 0x10)
 				f71882fg_remove_sysfs_files(pdev,
-					f8000_in_temp_attr,
-					ARRAY_SIZE(f8000_in_temp_attr));
+					f8000_temp_attr,
+					ARRAY_SIZE(f8000_temp_attr));
 			else
 				f71882fg_remove_sysfs_files(pdev,
-					f71858fg_in_temp_attr,
-					ARRAY_SIZE(f71858fg_in_temp_attr));
-			break;
-		case f71882fg:
-		case f71889fg:
-			f71882fg_remove_sysfs_files(pdev,
-					fxxxx_in1_alarm_attr,
-					ARRAY_SIZE(fxxxx_in1_alarm_attr));
-			/* fall through! */
-		case f71862fg:
-			f71882fg_remove_sysfs_files(pdev,
-					fxxxx_in_temp_attr,
-					ARRAY_SIZE(fxxxx_in_temp_attr));
+					f71858fg_temp_attr,
+					ARRAY_SIZE(f71858fg_temp_attr));
 			break;
 		case f8000:
 			f71882fg_remove_sysfs_files(pdev,
-					f8000_in_temp_attr,
-					ARRAY_SIZE(f8000_in_temp_attr));
+					f8000_temp_attr,
+					ARRAY_SIZE(f8000_temp_attr));
 			break;
+		default:
+			f71882fg_remove_sysfs_files(pdev,
+					fxxxx_temp_attr,
+					ARRAY_SIZE(fxxxx_temp_attr));
+		}
+		for (i = 0; i < F71882FG_MAX_INS; i++) {
+			if (f71882fg_has_in[data->type][i]) {
+				device_remove_file(&pdev->dev,
+						&fxxxx_in_attr[i].dev_attr);
+			}
+		}
+		if (f71882fg_has_in1_alarm[data->type]) {
+			f71882fg_remove_sysfs_files(pdev,
+					fxxxx_in1_alarm_attr,
+					ARRAY_SIZE(fxxxx_in1_alarm_attr));
 		}
 	}
 
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
