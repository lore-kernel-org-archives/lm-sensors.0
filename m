From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Jun 2013 16:33:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Fix temperature alarm attributes
Message-Id: <1372005181-24385-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver displays wrong alarms for temperature attributes.

Turns out that temperature alarm bits are not fixed, but determined
by temperature source mapping. To fix the problem, walk through
the temperature sources to determine the correct alarm bit associated
with a given attribute.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   70 +++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 04638ae..d118417 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -625,6 +625,7 @@ struct nct6775_data {
 	u8 has_fan_min;		/* some fans don't have min register */
 	bool has_fan_div;
 
+	u8 num_temp_alarms;	/* 3 or 6 */
 	u8 temp_fixed_num;	/* 3 or 6 */
 	u8 temp_type[NUM_TEMP_FIXED];
 	s8 temp_offset[NUM_TEMP_FIXED];
@@ -1193,6 +1194,35 @@ show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 		       (unsigned int)((data->alarms >> nr) & 0x01));
 }
 
+static ssize_t
+show_temp_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct nct6775_data *data = nct6775_update_device(dev);
+	int index = sattr->index;
+	unsigned int alarm = 0;
+	int nr;
+
+	/*
+	 * For temperatures, there is no fixed mapping from registers to alarm
+	 * bits. Alarm bits are determined by the temperature source mapping.
+	 * Alarms are generated only for the first <num_temp_alarms> temperature
+	 * sources.
+	 */
+	for (nr = 0; nr < data->num_temp_alarms; nr++) {
+		int src;
+
+		src = nct6775_read_value(data,
+					 data->REG_TEMP_SOURCE[nr]) & 0x1f;
+		if (src = data->temp_src[index]) {
+			int bit = data->ALARM_BITS[nr + TEMP_ALARM_BASE];
+			alarm = (data->alarms >> bit) & 0x01;
+			break;
+		}
+	}
+	return sprintf(buf, "%u\n", alarm);
+}
+
 static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in_reg, NULL, 0, 0);
 static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in_reg, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in_reg, NULL, 2, 0);
@@ -1874,22 +1904,18 @@ static struct sensor_device_attribute sda_temp_type[] = {
 };
 
 static struct sensor_device_attribute sda_temp_alarm[] = {
-	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE),
-	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE + 1),
-	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE + 2),
-	SENSOR_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE + 3),
-	SENSOR_ATTR(temp5_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE + 4),
-	SENSOR_ATTR(temp6_alarm, S_IRUGO, show_alarm, NULL,
-		    TEMP_ALARM_BASE + 5),
+	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 2),
+	SENSOR_ATTR(temp4_alarm, S_IRUGO, show_temp_alarm, NULL, 3),
+	SENSOR_ATTR(temp5_alarm, S_IRUGO, show_temp_alarm, NULL, 4),
+	SENSOR_ATTR(temp6_alarm, S_IRUGO, show_temp_alarm, NULL, 5),
+	SENSOR_ATTR(temp7_alarm, S_IRUGO, show_temp_alarm, NULL, 6),
+	SENSOR_ATTR(temp8_alarm, S_IRUGO, show_temp_alarm, NULL, 7),
+	SENSOR_ATTR(temp9_alarm, S_IRUGO, show_temp_alarm, NULL, 8),
+	SENSOR_ATTR(temp10_alarm, S_IRUGO, show_temp_alarm, NULL, 9),
 };
 
-#define NUM_TEMP_ALARM	ARRAY_SIZE(sda_temp_alarm)
-
 static ssize_t
 show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -3215,13 +3241,11 @@ static void nct6775_device_remove_files(struct device *dev)
 		device_remove_file(dev, &sda_temp_max[i].dev_attr);
 		device_remove_file(dev, &sda_temp_max_hyst[i].dev_attr);
 		device_remove_file(dev, &sda_temp_crit[i].dev_attr);
+		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
 		if (!(data->have_temp_fixed & (1 << i)))
 			continue;
 		device_remove_file(dev, &sda_temp_type[i].dev_attr);
 		device_remove_file(dev, &sda_temp_offset[i].dev_attr);
-		if (i >= NUM_TEMP_ALARM)
-			continue;
-		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
 	}
 
 	device_remove_file(dev, &sda_caseopen[0].dev_attr);
@@ -3419,6 +3443,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->auto_pwm_num = 6;
 		data->has_fan_div = true;
 		data->temp_fixed_num = 3;
+		data->num_temp_alarms = 3;
 
 		data->ALARM_BITS = NCT6775_ALARM_BITS;
 
@@ -3483,6 +3508,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->auto_pwm_num = 4;
 		data->has_fan_div = false;
 		data->temp_fixed_num = 3;
+		data->num_temp_alarms = 3;
 
 		data->ALARM_BITS = NCT6776_ALARM_BITS;
 
@@ -3547,6 +3573,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->auto_pwm_num = 4;
 		data->has_fan_div = false;
 		data->temp_fixed_num = 6;
+		data->num_temp_alarms = 3;
 
 		data->ALARM_BITS = NCT6779_ALARM_BITS;
 
@@ -3873,6 +3900,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		err = device_create_file(dev, &sda_temp_input[i].dev_attr);
 		if (err)
 			goto exit_remove;
+		err = device_create_file(dev, &sda_temp_alarm[i].dev_attr);
+		if (err)
+			goto exit_remove;
 		if (data->temp_label) {
 			err = device_create_file(dev,
 						 &sda_temp_label[i].dev_attr);
@@ -3905,12 +3935,6 @@ static int nct6775_probe(struct platform_device *pdev)
 		err = device_create_file(dev, &sda_temp_offset[i].dev_attr);
 		if (err)
 			goto exit_remove;
-		if (i >= NUM_TEMP_ALARM ||
-		    data->ALARM_BITS[TEMP_ALARM_BASE + i] < 0)
-			continue;
-		err = device_create_file(dev, &sda_temp_alarm[i].dev_attr);
-		if (err)
-			goto exit_remove;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_caseopen); i++) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
