From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:41 +0000
Subject: [lm-sensors] [PATCH 07/13] hwmon: (pmbus) Use krealloc to allocate attribute memory
Message-Id: <1359253067-11644-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So far, attribute memory was allocated by pre-calculating the maximum possible
amount of attributes. Not only does this waste memory, it is also risky because
the calculation might be wrong. It also requires a lot of defines to specify
the maximum number of attributes per class.

Allocate attribute memory using krealloc() instead. That means we have to use
kfree(), since devm_krealloc() does not exist, but that is still less costly
and less risky than trying to predict the number of attributes at the beginning.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |  140 +++++++++-----------------------------
 1 file changed, 31 insertions(+), 109 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3782fda..26b699a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -31,39 +31,10 @@
 #include "pmbus.h"
 
 /*
- * Constants needed to determine number of sensors, booleans, and labels.
+ * Number of additional attribute pointers to allocate
+ * with each call to krealloc
  */
-#define PMBUS_MAX_INPUT_SENSORS		22	/* 10*volt, 7*curr, 5*power */
-#define PMBUS_VOUT_SENSORS_PER_PAGE	9	/* input, min, max, lcrit,
-						   crit, lowest, highest, avg,
-						   reset */
-#define PMBUS_IOUT_SENSORS_PER_PAGE	8	/* input, min, max, crit,
-						   lowest, highest, avg,
-						   reset */
-#define PMBUS_POUT_SENSORS_PER_PAGE	7	/* input, cap, max, crit,
-						 * highest, avg, reset
-						 */
-#define PMBUS_MAX_SENSORS_PER_FAN	1	/* input */
-#define PMBUS_MAX_SENSORS_PER_TEMP	9	/* input, min, max, lcrit,
-						 * crit, lowest, highest, avg,
-						 * reset
-						 */
-
-#define PMBUS_MAX_INPUT_BOOLEANS	7	/* v: min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm;
-						   c: alarm, crit_alarm;
-						   p: crit_alarm */
-#define PMBUS_VOUT_BOOLEANS_PER_PAGE	4	/* min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm */
-#define PMBUS_IOUT_BOOLEANS_PER_PAGE	3	/* alarm, lcrit_alarm,
-						   crit_alarm */
-#define PMBUS_POUT_BOOLEANS_PER_PAGE	3	/* cap_alarm, alarm, crit_alarm
-						 */
-#define PMBUS_MAX_BOOLEANS_PER_FAN	2	/* alarm, fault */
-#define PMBUS_MAX_BOOLEANS_PER_TEMP	4	/* min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm */
-
-#define PMBUS_MAX_INPUT_LABELS		4	/* vin, vcap, iin, pin */
+#define PMBUS_ATTR_ALLOC_SIZE	32
 
 /*
  * status, status_vout, status_iout, status_fans, status_fan34, and status_temp
@@ -127,7 +98,6 @@ struct pmbus_data {
 
 	int max_attributes;
 	int num_attributes;
-	struct attribute **attributes;
 	struct attribute_group group;
 
 	struct pmbus_sensor *sensors;
@@ -790,6 +760,22 @@ static ssize_t pmbus_show_label(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", label->label);
 }
 
+static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
+{
+	if (data->num_attributes >= data->max_attributes - 1) {
+		data->max_attributes += PMBUS_ATTR_ALLOC_SIZE;
+		data->group.attrs = krealloc(data->group.attrs,
+					     sizeof(struct attribute *) *
+					     data->max_attributes, GFP_KERNEL);
+		if (data->group.attrs = NULL)
+			return -ENOMEM;
+	}
+
+	data->group.attrs[data->num_attributes++] = attr;
+	data->group.attrs[data->num_attributes] = NULL;
+	return 0;
+}
+
 static void pmbus_dev_attr_init(struct device_attribute *dev_attr,
 				const char *name,
 				umode_t mode,
@@ -831,8 +817,6 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 	struct pmbus_boolean *boolean;
 	struct sensor_device_attribute *a;
 
-	BUG_ON(data->num_attributes >= data->max_attributes);
-
 	boolean = devm_kzalloc(data->dev, sizeof(*boolean), GFP_KERNEL);
 	if (!boolean)
 		return -ENOMEM;
@@ -845,9 +829,8 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 	boolean->s2 = s2;
 	pmbus_attr_init(a, boolean->name, S_IRUGO, pmbus_show_boolean, NULL,
 			(reg << 8) | mask);
-	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 
-	return 0;
+	return pmbus_add_attribute(data, &a->dev_attr.attr);
 }
 
 static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
@@ -859,8 +842,6 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	struct pmbus_sensor *sensor;
 	struct device_attribute *a;
 
-	BUG_ON(data->num_attributes >= data->max_attributes);
-
 	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return NULL;
@@ -876,7 +857,9 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 			    readonly ? S_IRUGO : S_IRUGO | S_IWUSR,
 			    pmbus_show_sensor, pmbus_set_sensor);
 
-	data->attributes[data->num_attributes++] = &a->attr;
+	if (pmbus_add_attribute(data, &a->attr))
+		return NULL;
+
 	sensor->next = data->sensors;
 	data->sensors = sensor;
 
@@ -890,8 +873,6 @@ static int pmbus_add_label(struct pmbus_data *data,
 	struct pmbus_label *label;
 	struct device_attribute *a;
 
-	BUG_ON(data->num_attributes >= data->max_attributes);
-
 	label = devm_kzalloc(data->dev, sizeof(*label), GFP_KERNEL);
 	if (!label)
 		return -ENOMEM;
@@ -906,62 +887,7 @@ static int pmbus_add_label(struct pmbus_data *data,
 			 index);
 
 	pmbus_dev_attr_init(a, label->name, S_IRUGO, pmbus_show_label, NULL);
-	data->attributes[data->num_attributes++] = &a->attr;
-	return 0;
-}
-
-/*
- * Determine maximum number of sensors, booleans, and labels.
- * To keep things simple, only make a rough high estimate.
- */
-static void pmbus_find_max_attr(struct i2c_client *client,
-				struct pmbus_data *data)
-{
-	const struct pmbus_driver_info *info = data->info;
-	int page, max_sensors, max_booleans, max_labels;
-
-	max_sensors = PMBUS_MAX_INPUT_SENSORS;
-	max_booleans = PMBUS_MAX_INPUT_BOOLEANS;
-	max_labels = PMBUS_MAX_INPUT_LABELS;
-
-	for (page = 0; page < info->pages; page++) {
-		if (info->func[page] & PMBUS_HAVE_VOUT) {
-			max_sensors += PMBUS_VOUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_VOUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_IOUT) {
-			max_sensors += PMBUS_IOUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_IOUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_POUT) {
-			max_sensors += PMBUS_POUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_POUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_FAN12) {
-			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
-			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
-		}
-		if (info->func[page] & PMBUS_HAVE_FAN34) {
-			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
-			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP2) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP3) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-	}
-	data->max_attributes = max_sensors + max_booleans + max_labels;
+	return pmbus_add_attribute(data, &a->attr);
 }
 
 /*
@@ -1709,8 +1635,6 @@ static int pmbus_identify_common(struct i2c_client *client,
 		}
 	}
 
-	/* Determine maximum number of sensors, booleans, and labels */
-	pmbus_find_max_attr(client, data);
 	pmbus_clear_fault_page(client, 0);
 	return 0;
 }
@@ -1770,14 +1694,9 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		return ret;
 	}
 
-	data->attributes = devm_kzalloc(dev, sizeof(struct attribute *)
-					* data->max_attributes, GFP_KERNEL);
-	if (!data->attributes)
-		return -ENOMEM;
-
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-		return ret;
+		goto out_kfree;
 
 	/*
 	 * If there are no attributes, something is wrong.
@@ -1785,15 +1704,15 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 */
 	if (!data->num_attributes) {
 		dev_err(dev, "No attributes found\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_kfree;
 	}
 
 	/* Register sysfs hooks */
-	data->group.attrs = data->attributes;
 	ret = sysfs_create_group(&dev->kobj, &data->group);
 	if (ret) {
 		dev_err(dev, "Failed to create sysfs entries\n");
-		return ret;
+		goto out_kfree;
 	}
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1805,6 +1724,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 out_hwmon_device_register:
 	sysfs_remove_group(&dev->kobj, &data->group);
+out_kfree:
+	kfree(data->group.attrs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
@@ -1814,6 +1735,7 @@ int pmbus_do_remove(struct i2c_client *client)
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->group);
+	kfree(data->group.attrs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
