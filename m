From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:40 +0000
Subject: [lm-sensors] [PATCH 06/13] hwmon: (pmbus) Simplify memory allocation for sensor attributes
Message-Id: <1359253067-11644-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since memory is now allocated with dev_ functions, we no longer need to keep
track of allocated memory. Sensor memory allocation can therefore be
simplified significantly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   63 ++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d1792d7..3782fda 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -85,8 +85,9 @@
 #define PMBUS_NAME_SIZE		24
 
 struct pmbus_sensor {
+	struct pmbus_sensor *next;
 	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
-	struct sensor_device_attribute attribute;
+	struct device_attribute attribute;
 	u8 page;		/* page number */
 	u16 reg;		/* register */
 	enum pmbus_sensor_classes class;	/* sensor class */
@@ -94,6 +95,8 @@ struct pmbus_sensor {
 	int data;		/* Sensor data.
 				   Negative if there was a read error */
 };
+#define to_pmbus_sensor(_attr) \
+	container_of(_attr, struct pmbus_sensor, attribute)
 
 struct pmbus_boolean {
 	char name[PMBUS_NAME_SIZE];	/* sysfs boolean name */
@@ -127,11 +130,6 @@ struct pmbus_data {
 	struct attribute **attributes;
 	struct attribute_group group;
 
-	/*
-	 * Sensors cover both sensor and limit registers.
-	 */
-	int max_sensors;
-	int num_sensors;
 	struct pmbus_sensor *sensors;
 
 	struct mutex update_lock;
@@ -361,6 +359,7 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	const struct pmbus_driver_info *info = data->info;
+	struct pmbus_sensor *sensor;
 
 	mutex_lock(&data->update_lock);
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
@@ -410,9 +409,7 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 			  = _pmbus_read_byte_data(client, 0,
 						  PMBUS_STATUS_INPUT);
 
-		for (i = 0; i < data->num_sensors; i++) {
-			struct pmbus_sensor *sensor = &data->sensors[i];
-
+		for (sensor = data->sensors; sensor; sensor = sensor->next) {
 			if (!data->valid || sensor->update)
 				sensor->data
 				    = _pmbus_read_word_data(client,
@@ -748,13 +745,11 @@ static ssize_t pmbus_show_boolean(struct device *dev,
 }
 
 static ssize_t pmbus_show_sensor(struct device *dev,
-				 struct device_attribute *da, char *buf)
+				 struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct pmbus_data *data = pmbus_update_device(dev);
-	struct pmbus_sensor *sensor;
+	struct pmbus_sensor *sensor = to_pmbus_sensor(devattr);
 
-	sensor = &data->sensors[attr->index];
 	if (sensor->data < 0)
 		return sensor->data;
 
@@ -765,10 +760,9 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 				struct device_attribute *devattr,
 				const char *buf, size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pmbus_data *data = i2c_get_clientdata(client);
-	struct pmbus_sensor *sensor = &data->sensors[attr->index];
+	struct pmbus_sensor *sensor = to_pmbus_sensor(devattr);
 	ssize_t rv = count;
 	long val = 0;
 	int ret;
@@ -783,7 +777,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 	if (ret < 0)
 		rv = ret;
 	else
-		data->sensors[attr->index].data = regval;
+		sensor->data = regval;
 	mutex_unlock(&data->update_lock);
 	return rv;
 }
@@ -863,12 +857,13 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 					     bool update, bool readonly)
 {
 	struct pmbus_sensor *sensor;
-	struct sensor_device_attribute *a;
+	struct device_attribute *a;
 
-	BUG_ON(data->num_sensors >= data->max_sensors ||
-	       data->num_attributes >= data->max_attributes);
+	BUG_ON(data->num_attributes >= data->max_attributes);
 
-	sensor = &data->sensors[data->num_sensors];
+	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return NULL;
 	a = &sensor->attribute;
 
 	snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
@@ -877,12 +872,13 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	sensor->reg = reg;
 	sensor->class = class;
 	sensor->update = update;
-	pmbus_attr_init(a, sensor->name,
-			readonly ? S_IRUGO : S_IRUGO | S_IWUSR,
-			pmbus_show_sensor, pmbus_set_sensor, data->num_sensors);
+	pmbus_dev_attr_init(a, sensor->name,
+			    readonly ? S_IRUGO : S_IRUGO | S_IWUSR,
+			    pmbus_show_sensor, pmbus_set_sensor);
 
-	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
-	data->num_sensors++;
+	data->attributes[data->num_attributes++] = &a->attr;
+	sensor->next = data->sensors;
+	data->sensors = sensor;
 
 	return sensor;
 }
@@ -965,7 +961,6 @@ static void pmbus_find_max_attr(struct i2c_client *client,
 			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
 		}
 	}
-	data->max_sensors = max_sensors;
 	data->max_attributes = max_sensors + max_booleans + max_labels;
 }
 
@@ -1031,6 +1026,8 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 						page, l->reg, attr->class,
 						attr->update || l->update,
 						false);
+			if (!curr)
+				return -ENOMEM;
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
 				ret = pmbus_add_boolean(data, name,
 					l->alarm, index,
@@ -1067,6 +1064,8 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 	}
 	base = pmbus_add_sensor(data, name, "input", index, page, attr->reg,
 				attr->class, true, true);
+	if (!base)
+		return -ENOMEM;
 	if (attr->sfunc) {
 		ret = pmbus_add_limit_attrs(client, data, info, name,
 					    index, page, base, attr);
@@ -1605,9 +1604,10 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
 				continue;
 
-			pmbus_add_sensor(data, "fan", "input", index, page,
-					 pmbus_fan_registers[f], PSC_FAN, true,
-					 true);
+			if (pmbus_add_sensor(data, "fan", "input", index,
+					     page, pmbus_fan_registers[f],
+					     PSC_FAN, true, true) = NULL)
+				return -ENOMEM;
 
 			/*
 			 * Each fan status register covers multiple fans,
@@ -1770,11 +1770,6 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		return ret;
 	}
 
-	data->sensors = devm_kzalloc(dev, sizeof(struct pmbus_sensor)
-				     * data->max_sensors, GFP_KERNEL);
-	if (!data->sensors)
-		return -ENOMEM;
-
 	data->attributes = devm_kzalloc(dev, sizeof(struct attribute *)
 					* data->max_attributes, GFP_KERNEL);
 	if (!data->attributes)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
