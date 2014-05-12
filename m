From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:46 +0000
Subject: [lm-sensors] [PATCH 4/9] hwmon: (emc1403) Add support for alarm and diode fault status on EMC14x2
Message-Id: <1399921311-9524-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alarm and fault status register on EMC1402, EMC1412, and EMC1422 is reported
in a different register than with other chips. Add support for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 8e82884..ee63d7b 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -299,6 +299,39 @@ static const struct attribute_group emc1404_group = {
 	.attrs = emc1404_attrs,
 };
 
+/*
+ * EMC14x2 uses a different register and different bits to report alarm and
+ * fault status. For simplicity, provide a separate attribute group for this
+ * chip series.
+ * Since we can not re-use the same attribute names, create a separate attribute
+ * array.
+ */
+static struct sensor_device_attribute_2 emc1402_alarms[] = {
+	SENSOR_ATTR_2(temp1_min_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x20),
+	SENSOR_ATTR_2(temp1_max_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x40),
+	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x01),
+
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_bit, NULL, 0x02, 0x04),
+	SENSOR_ATTR_2(temp2_min_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x08),
+	SENSOR_ATTR_2(temp2_max_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x10),
+	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x02),
+};
+
+static struct attribute *emc1402_alarm_attrs[] = {
+	&emc1402_alarms[0].dev_attr.attr,
+	&emc1402_alarms[1].dev_attr.attr,
+	&emc1402_alarms[2].dev_attr.attr,
+	&emc1402_alarms[3].dev_attr.attr,
+	&emc1402_alarms[4].dev_attr.attr,
+	&emc1402_alarms[5].dev_attr.attr,
+	&emc1402_alarms[6].dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group emc1402_alarm_group = {
+	.attrs = emc1402_alarm_attrs,
+};
+
 static int emc1403_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
 {
@@ -395,6 +428,9 @@ static int emc1403_probe(struct i2c_client *client,
 		data->groups[0] = &emc1402_group;
 	}
 
+	if (id->driver_data = emc1402)
+		data->groups[1] = &emc1402_alarm_group;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
 							   client->name, data,
 							   data->groups);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
