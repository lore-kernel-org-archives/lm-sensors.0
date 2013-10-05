From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Oct 2013 22:23:26 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (emc1403) Add support for EMC1404 and EMC1424
Message-Id: <1381011806-25136-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

EMC1404 and EMC1424 are similar to EMC1403 and EMC1423,
but support an additional external temperature sensor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c |   59 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index dc2a917..90ec117 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -21,7 +21,6 @@
  *
  * TODO
  *	-	cache alarm and critical limit registers
- *	-	add emc1404 support
  */
 
 #include <linux/module.h>
@@ -41,6 +40,7 @@
 
 struct thermal_data {
 	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex mutex;
 	/*
 	 * Cache the hyst value so we don't keep re-reading it. In theory
@@ -233,6 +233,22 @@ static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
 static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
 	show_hyst, store_hyst, 0x1A);
 
+static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x2D);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x2C);
+static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO | S_IWUSR,
+	show_temp, store_temp, 0x30);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 0x2A);
+static SENSOR_DEVICE_ATTR_2(temp4_min_alarm, S_IRUGO,
+	show_bit, NULL, 0x36, 0x08);
+static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
+	show_bit, NULL, 0x35, 0x08);
+static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO,
+	show_bit, NULL, 0x37, 0x08);
+static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO | S_IWUSR,
+	show_hyst, store_hyst, 0x30);
+
 static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
 	show_bit, store_bit, 0x03, 0x40);
 
@@ -264,7 +280,26 @@ static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_power_state.dev_attr.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(emc1403);
+
+static const struct attribute_group emc1403_group = {
+	.attrs = emc1403_attrs,
+};
+
+static struct attribute *emc1404_attrs[] = {
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group emc1404_group = {
+	.attrs = emc1404_attrs,
+};
 
 static int emc1403_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
@@ -284,10 +319,12 @@ static int emc1403_detect(struct i2c_client *client,
 	case 0x23:
 		strlcpy(info->type, "emc1423", I2C_NAME_SIZE);
 		break;
-	/*
-	 * Note: 0x25 is the 1404 which is very similar and this
-	 * driver could be extended
-	 */
+	case 0x25:
+		strlcpy(info->type, "emc1404", I2C_NAME_SIZE);
+		break;
+	case 0x27:
+		strlcpy(info->type, "emc1424", I2C_NAME_SIZE);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -314,13 +351,17 @@ static int emc1403_probe(struct i2c_client *client,
 	mutex_init(&data->mutex);
 	data->hyst_valid = jiffies - 1;		/* Expired */
 
+	data->groups[0] = &emc1403_group;
+	if (id->driver_data)
+		data->groups[1] = &emc1404_group;
+
 	hwmon_dev = hwmon_device_register_with_groups(&client->dev,
 						      client->name, data,
-						      emc1403_groups);
+						      data->groups);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
-	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
+	dev_info(&client->dev, "%s Thermal chip found\n", id->name);
 	return 0;
 }
 
@@ -330,7 +371,9 @@ static const unsigned short emc1403_address_list[] = {
 
 static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1403", 0 },
+	{ "emc1404", 1 },
 	{ "emc1423", 0 },
+	{ "emc1424", 1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
