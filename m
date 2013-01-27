From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:38 +0000
Subject: [lm-sensors] [PATCH 04/13] hwmon: (pmbus) Simplify memory allocation for labels and booleans
Message-Id: <1359253067-11644-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since memory is now allocated with dev_ functions, we no longer need to keep
track of allocated memory. Memory allocation for booleans and labels can
therefore be simplified substantially by allocating it only as needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |  265 +++++++++++++++++++++-----------------
 1 file changed, 149 insertions(+), 116 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 97eca03..0f51cd6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -102,11 +102,14 @@ struct pmbus_boolean {
 
 struct pmbus_label {
 	char name[PMBUS_NAME_SIZE];	/* sysfs label name */
-	struct sensor_device_attribute attribute;
+	struct device_attribute attribute;
 	char label[PMBUS_NAME_SIZE];	/* label */
 };
+#define to_pmbus_label(_attr) \
+	container_of(_attr, struct pmbus_label, attribute)
 
 struct pmbus_data {
+	struct device *dev;
 	struct device *hwmon_dev;
 
 	u32 flags;		/* from platform data */
@@ -126,20 +129,6 @@ struct pmbus_data {
 	int max_sensors;
 	int num_sensors;
 	struct pmbus_sensor *sensors;
-	/*
-	 * Booleans are used for alarms.
-	 * Values are determined from status registers.
-	 */
-	int max_booleans;
-	int num_booleans;
-	struct pmbus_boolean *booleans;
-	/*
-	 * Labels are used to map generic names (e.g., "in1")
-	 * to PMBus specific names (e.g., "vin" or "vout1").
-	 */
-	int max_labels;
-	int num_labels;
-	struct pmbus_label *labels;
 
 	struct mutex update_lock;
 	bool valid;
@@ -801,12 +790,26 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 static ssize_t pmbus_show_label(struct device *dev,
 				struct device_attribute *da, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct pmbus_label *label = to_pmbus_label(da);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", label->label);
+}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			data->labels[attr->index].label);
+static void pmbus_dev_attr_init(struct device_attribute *dev_attr,
+				const char *name,
+				umode_t mode,
+				ssize_t (*show)(struct device *dev,
+						struct device_attribute *attr,
+						char *buf),
+				ssize_t (*store)(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count))
+{
+	sysfs_attr_init(&dev_attr->attr);
+	dev_attr->attr.name = name;
+	dev_attr->attr.mode = mode;
+	dev_attr->show = show;
+	dev_attr->store = store;
 }
 
 static void pmbus_attr_init(struct sensor_device_attribute *a,
@@ -820,25 +823,23 @@ static void pmbus_attr_init(struct sensor_device_attribute *a,
 					     const char *buf, size_t count),
 			    int idx)
 {
-	sysfs_attr_init(&a->dev_attr.attr);
-	a->dev_attr.attr.name = name;
-	a->dev_attr.attr.mode = mode;
-	a->dev_attr.show = show;
-	a->dev_attr.store = store;
+	pmbus_dev_attr_init(&a->dev_attr, name, mode, show, store);
 	a->index = idx;
 }
 
-static void pmbus_add_boolean(struct pmbus_data *data,
-			      const char *name, const char *type, int seq,
-			      int idx)
+static int pmbus_add_boolean(struct pmbus_data *data,
+			     const char *name, const char *type, int seq,
+			     int idx)
 {
 	struct pmbus_boolean *boolean;
 	struct sensor_device_attribute *a;
 
-	BUG_ON(data->num_booleans >= data->max_booleans ||
-	       data->num_attributes >= data->max_attributes);
+	BUG_ON(data->num_attributes >= data->max_attributes);
+
+	boolean = devm_kzalloc(data->dev, sizeof(*boolean), GFP_KERNEL);
+	if (!boolean)
+		return -ENOMEM;
 
-	boolean = &data->booleans[data->num_booleans];
 	a = &boolean->attribute;
 
 	snprintf(boolean->name, sizeof(boolean->name), "%s%d_%s",
@@ -846,22 +847,23 @@ static void pmbus_add_boolean(struct pmbus_data *data,
 	pmbus_attr_init(a, boolean->name, S_IRUGO, pmbus_show_boolean, NULL,
 			idx);
 	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
-	data->num_booleans++;
+
+	return 0;
 }
 
-static void pmbus_add_boolean_reg(struct pmbus_data *data,
-				  const char *name, const char *type,
-				  int seq, int reg, int bit)
+static int pmbus_add_boolean_reg(struct pmbus_data *data,
+				 const char *name, const char *type,
+				 int seq, int reg, int bit)
 {
-	pmbus_add_boolean(data, name, type, seq, (reg << 8) | bit);
+	return pmbus_add_boolean(data, name, type, seq, (reg << 8) | bit);
 }
 
-static void pmbus_add_boolean_cmp(struct pmbus_data *data,
-				  const char *name, const char *type,
-				  int seq, int i1, int i2, int reg, int mask)
+static int pmbus_add_boolean_cmp(struct pmbus_data *data,
+				 const char *name, const char *type,
+				 int seq, int i1, int i2, int reg, int mask)
 {
-	pmbus_add_boolean(data, name, type, seq,
-			  (i1 << 24) | (i2 << 16) | (reg << 8) | mask);
+	return pmbus_add_boolean(data, name, type, seq,
+				 (i1 << 24) | (i2 << 16) | (reg << 8) | mask);
 }
 
 static void pmbus_add_sensor(struct pmbus_data *data,
@@ -892,17 +894,19 @@ static void pmbus_add_sensor(struct pmbus_data *data,
 	data->num_sensors++;
 }
 
-static void pmbus_add_label(struct pmbus_data *data,
-			    const char *name, int seq,
-			    const char *lstring, int index)
+static int pmbus_add_label(struct pmbus_data *data,
+			   const char *name, int seq,
+			   const char *lstring, int index)
 {
 	struct pmbus_label *label;
-	struct sensor_device_attribute *a;
+	struct device_attribute *a;
 
-	BUG_ON(data->num_labels >= data->max_labels ||
-	       data->num_attributes >= data->max_attributes);
+	BUG_ON(data->num_attributes >= data->max_attributes);
+
+	label = devm_kzalloc(data->dev, sizeof(*label), GFP_KERNEL);
+	if (!label)
+		return -ENOMEM;
 
-	label = &data->labels[data->num_labels];
 	a = &label->attribute;
 
 	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
@@ -912,10 +916,9 @@ static void pmbus_add_label(struct pmbus_data *data,
 		snprintf(label->label, sizeof(label->label), "%s%d", lstring,
 			 index);
 
-	pmbus_attr_init(a, label->name, S_IRUGO, pmbus_show_label, NULL,
-			data->num_labels);
-	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
-	data->num_labels++;
+	pmbus_dev_attr_init(a, label->name, S_IRUGO, pmbus_show_label, NULL);
+	data->attributes[data->num_attributes++] = &a->attr;
+	return 0;
 }
 
 /*
@@ -970,8 +973,6 @@ static void pmbus_find_max_attr(struct i2c_client *client,
 		}
 	}
 	data->max_sensors = max_sensors;
-	data->max_booleans = max_booleans;
-	data->max_labels = max_labels;
 	data->max_attributes = max_sensors + max_booleans + max_labels;
 }
 
@@ -1015,18 +1016,21 @@ struct pmbus_sensor_attr {
 /*
  * Add a set of limit attributes and, if supported, the associated
  * alarm attributes.
+ * returns 0 if no alarm register found, 1 if an alarm register was found,
+ * < 0 on errors.
  */
-static bool pmbus_add_limit_attrs(struct i2c_client *client,
-				  struct pmbus_data *data,
-				  const struct pmbus_driver_info *info,
-				  const char *name, int index, int page,
-				  int cbase,
-				  const struct pmbus_sensor_attr *attr)
+static int pmbus_add_limit_attrs(struct i2c_client *client,
+				 struct pmbus_data *data,
+				 const struct pmbus_driver_info *info,
+				 const char *name, int index, int page,
+				 int cbase,
+				 const struct pmbus_sensor_attr *attr)
 {
 	const struct pmbus_limit_attr *l = attr->limit;
 	int nlimit = attr->nlimit;
-	bool have_alarm = false;
+	int have_alarm = 0;
 	int i, cindex;
+	int ret;
 
 	for (i = 0; i < nlimit; i++) {
 		if (pmbus_check_word_register(client, page, l->reg)) {
@@ -1037,17 +1041,21 @@ static bool pmbus_add_limit_attrs(struct i2c_client *client,
 					 false);
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
 				if (attr->compare) {
-					pmbus_add_boolean_cmp(data, name,
+					ret = pmbus_add_boolean_cmp(data, name,
 						l->alarm, index,
 						l->low ? cindex : cbase,
 						l->low ? cbase : cindex,
 						attr->sbase + page, l->sbit);
+					if (ret)
+						return ret;
 				} else {
-					pmbus_add_boolean_reg(data, name,
+					ret = pmbus_add_boolean_reg(data, name,
 						l->alarm, index,
 						attr->sbase + page, l->sbit);
+					if (ret)
+						return ret;
 				}
-				have_alarm = true;
+				have_alarm = 1;
 			}
 		}
 		l++;
@@ -1055,45 +1063,56 @@ static bool pmbus_add_limit_attrs(struct i2c_client *client,
 	return have_alarm;
 }
 
-static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
-				       struct pmbus_data *data,
-				       const struct pmbus_driver_info *info,
-				       const char *name,
-				       int index, int page,
-				       const struct pmbus_sensor_attr *attr)
+static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
+				      struct pmbus_data *data,
+				      const struct pmbus_driver_info *info,
+				      const char *name,
+				      int index, int page,
+				      const struct pmbus_sensor_attr *attr)
 {
-	bool have_alarm;
 	int cbase = data->num_sensors;
+	int ret;
 
-	if (attr->label)
-		pmbus_add_label(data, name, index, attr->label,
-				attr->paged ? page + 1 : 0);
+	if (attr->label) {
+		ret = pmbus_add_label(data, name, index, attr->label,
+				      attr->paged ? page + 1 : 0);
+		if (ret)
+			return ret;
+	}
 	pmbus_add_sensor(data, name, "input", index, page, attr->reg,
 			 attr->class, true, true);
 	if (attr->sfunc) {
-		have_alarm = pmbus_add_limit_attrs(client, data, info, name,
-						   index, page, cbase, attr);
+		ret = pmbus_add_limit_attrs(client, data, info, name,
+					    index, page, cbase, attr);
+		if (ret < 0)
+			return ret;
 		/*
 		 * Add generic alarm attribute only if there are no individual
 		 * alarm attributes, if there is a global alarm bit, and if
 		 * the generic status register for this page is accessible.
 		 */
-		if (!have_alarm && attr->gbit &&
-		    pmbus_check_byte_register(client, page, PMBUS_STATUS_BYTE))
-			pmbus_add_boolean_reg(data, name, "alarm", index,
-					      PB_STATUS_BASE + page,
-					      attr->gbit);
+		if (!ret && attr->gbit &&
+		    pmbus_check_byte_register(client, page,
+					      PMBUS_STATUS_BYTE)) {
+			ret = pmbus_add_boolean_reg(data, name, "alarm", index,
+						    PB_STATUS_BASE + page,
+						    attr->gbit);
+			if (ret)
+				return ret;
+		}
 	}
+	return 0;
 }
 
-static void pmbus_add_sensor_attrs(struct i2c_client *client,
-				   struct pmbus_data *data,
-				   const char *name,
-				   const struct pmbus_sensor_attr *attrs,
-				   int nattrs)
+static int pmbus_add_sensor_attrs(struct i2c_client *client,
+				  struct pmbus_data *data,
+				  const char *name,
+				  const struct pmbus_sensor_attr *attrs,
+				  int nattrs)
 {
 	const struct pmbus_driver_info *info = data->info;
 	int index, i;
+	int ret;
 
 	index = 1;
 	for (i = 0; i < nattrs; i++) {
@@ -1103,12 +1122,16 @@ static void pmbus_add_sensor_attrs(struct i2c_client *client,
 		for (page = 0; page < pages; page++) {
 			if (!(info->func[page] & attrs->func))
 				continue;
-			pmbus_add_sensor_attrs_one(client, data, info, name,
-						   index, page, attrs);
+			ret = pmbus_add_sensor_attrs_one(client, data, info,
+							 name, index, page,
+							 attrs);
+			if (ret)
+				return ret;
 			index++;
 		}
 		attrs++;
 	}
+	return 0;
 }
 
 static const struct pmbus_limit_attr vin_limit_attrs[] = {
@@ -1563,12 +1586,13 @@ static const u32 pmbus_fan_status_flags[] = {
 };
 
 /* Fans */
-static void pmbus_add_fan_attributes(struct i2c_client *client,
-				     struct pmbus_data *data)
+static int pmbus_add_fan_attributes(struct i2c_client *client,
+				    struct pmbus_data *data)
 {
 	const struct pmbus_driver_info *info = data->info;
 	int index = 1;
 	int page;
+	int ret;
 
 	for (page = 0; page < info->pages; page++) {
 		int f;
@@ -1611,39 +1635,55 @@ static void pmbus_add_fan_attributes(struct i2c_client *client,
 					base = PB_STATUS_FAN34_BASE + page;
 				else
 					base = PB_STATUS_FAN_BASE + page;
-				pmbus_add_boolean_reg(data, "fan", "alarm",
-					index, base,
+				ret = pmbus_add_boolean_reg(data, "fan",
+					"alarm", index, base,
 					PB_FAN_FAN1_WARNING >> (f & 1));
-				pmbus_add_boolean_reg(data, "fan", "fault",
-					index, base,
+				if (ret)
+					return ret;
+				ret = pmbus_add_boolean_reg(data, "fan",
+					"fault", index, base,
 					PB_FAN_FAN1_FAULT >> (f & 1));
+				if (ret)
+					return ret;
 			}
 			index++;
 		}
 	}
+	return 0;
 }
 
-static void pmbus_find_attributes(struct i2c_client *client,
-				  struct pmbus_data *data)
+static int pmbus_find_attributes(struct i2c_client *client,
+				 struct pmbus_data *data)
 {
+	int ret;
+
 	/* Voltage sensors */
-	pmbus_add_sensor_attrs(client, data, "in", voltage_attributes,
-			       ARRAY_SIZE(voltage_attributes));
+	ret = pmbus_add_sensor_attrs(client, data, "in", voltage_attributes,
+				     ARRAY_SIZE(voltage_attributes));
+	if (ret)
+		return ret;
 
 	/* Current sensors */
-	pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
-			       ARRAY_SIZE(current_attributes));
+	ret = pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
+				     ARRAY_SIZE(current_attributes));
+	if (ret)
+		return ret;
 
 	/* Power sensors */
-	pmbus_add_sensor_attrs(client, data, "power", power_attributes,
-			       ARRAY_SIZE(power_attributes));
+	ret = pmbus_add_sensor_attrs(client, data, "power", power_attributes,
+				     ARRAY_SIZE(power_attributes));
+	if (ret)
+		return ret;
 
 	/* Temperature sensors */
-	pmbus_add_sensor_attrs(client, data, "temp", temp_attributes,
-			       ARRAY_SIZE(temp_attributes));
+	ret = pmbus_add_sensor_attrs(client, data, "temp", temp_attributes,
+				     ARRAY_SIZE(temp_attributes));
+	if (ret)
+		return ret;
 
 	/* Fans */
-	pmbus_add_fan_attributes(client, data);
+	ret = pmbus_add_fan_attributes(client, data);
+	return ret;
 }
 
 /*
@@ -1710,6 +1750,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	data->dev = dev;
 
 	/* Bail out if PMBus status register does not exist. */
 	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
@@ -1747,22 +1788,14 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	if (!data->sensors)
 		return -ENOMEM;
 
-	data->booleans = devm_kzalloc(dev, sizeof(struct pmbus_boolean)
-				      * data->max_booleans, GFP_KERNEL);
-	if (!data->booleans)
-		return -ENOMEM;
-
-	data->labels = devm_kzalloc(dev, sizeof(struct pmbus_label)
-				    * data->max_labels, GFP_KERNEL);
-	if (!data->labels)
-		return -ENOMEM;
-
 	data->attributes = devm_kzalloc(dev, sizeof(struct attribute *)
 					* data->max_attributes, GFP_KERNEL);
 	if (!data->attributes)
 		return -ENOMEM;
 
-	pmbus_find_attributes(client, data);
+	ret = pmbus_find_attributes(client, data);
+	if (ret)
+		return ret;
 
 	/*
 	 * If there are no attributes, something is wrong.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
