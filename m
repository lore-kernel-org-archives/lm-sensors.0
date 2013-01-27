From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:36 +0000
Subject: [lm-sensors] [PATCH 02/13] hwmon: (pmbus) Fix 'Macros with multiple statements' checkpatch error
Message-Id: <1359253067-11644-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:
ERROR: Macros with multiple statements should be enclosed in a do - while loop

by unwinding the problematic macros.

As a side effect, this patch reduces code size on x86_64 by 160 bytes and bss
size by 64 bytes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   76 +++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index e3eb324..b9ba8ce 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -809,42 +809,43 @@ static ssize_t pmbus_show_label(struct device *dev,
 			data->labels[attr->index].label);
 }
 
-#define PMBUS_ADD_ATTR(data, _name, _idx, _mode, _type, _show, _set)	\
-do {									\
-	struct sensor_device_attribute *a				\
-	    = &data->_type##s[data->num_##_type##s].attribute;		\
-	BUG_ON(data->num_attributes >= data->max_attributes);		\
-	sysfs_attr_init(&a->dev_attr.attr);				\
-	a->dev_attr.attr.name = _name;					\
-	a->dev_attr.attr.mode = _mode;					\
-	a->dev_attr.show = _show;					\
-	a->dev_attr.store = _set;					\
-	a->index = _idx;						\
-	data->attributes[data->num_attributes] = &a->dev_attr.attr;	\
-	data->num_attributes++;						\
-} while (0)
-
-#define PMBUS_ADD_GET_ATTR(data, _name, _type, _idx)			\
-	PMBUS_ADD_ATTR(data, _name, _idx, S_IRUGO, _type,		\
-		       pmbus_show_##_type,  NULL)
-
-#define PMBUS_ADD_SET_ATTR(data, _name, _type, _idx)			\
-	PMBUS_ADD_ATTR(data, _name, _idx, S_IWUSR | S_IRUGO, _type,	\
-		       pmbus_show_##_type, pmbus_set_##_type)
+static void pmbus_attr_init(struct sensor_device_attribute *a,
+			    const char *name,
+			    umode_t mode,
+			    ssize_t (*show)(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count),
+			    int idx)
+{
+	sysfs_attr_init(&a->dev_attr.attr);
+	a->dev_attr.attr.name = name;
+	a->dev_attr.attr.mode = mode;
+	a->dev_attr.show = show;
+	a->dev_attr.store = store;
+	a->index = idx;
+}
 
 static void pmbus_add_boolean(struct pmbus_data *data,
 			      const char *name, const char *type, int seq,
 			      int idx)
 {
 	struct pmbus_boolean *boolean;
+	struct sensor_device_attribute *a;
 
-	BUG_ON(data->num_booleans >= data->max_booleans);
+	BUG_ON(data->num_booleans >= data->max_booleans ||
+	       data->num_attributes >= data->max_attributes);
 
 	boolean = &data->booleans[data->num_booleans];
+	a = &boolean->attribute;
 
 	snprintf(boolean->name, sizeof(boolean->name), "%s%d_%s",
 		 name, seq, type);
-	PMBUS_ADD_GET_ATTR(data, boolean->name, boolean, idx);
+	pmbus_attr_init(a, boolean->name, S_IRUGO, pmbus_show_boolean, NULL,
+			idx);
+	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 	data->num_booleans++;
 }
 
@@ -869,22 +870,25 @@ static void pmbus_add_sensor(struct pmbus_data *data,
 			     bool update, bool readonly)
 {
 	struct pmbus_sensor *sensor;
+	struct sensor_device_attribute *a;
 
-	BUG_ON(data->num_sensors >= data->max_sensors);
+	BUG_ON(data->num_sensors >= data->max_sensors ||
+	       data->num_attributes >= data->max_attributes);
 
 	sensor = &data->sensors[data->num_sensors];
+	a = &sensor->attribute;
+
 	snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
 		 name, seq, type);
 	sensor->page = page;
 	sensor->reg = reg;
 	sensor->class = class;
 	sensor->update = update;
-	if (readonly)
-		PMBUS_ADD_GET_ATTR(data, sensor->name, sensor,
-				   data->num_sensors);
-	else
-		PMBUS_ADD_SET_ATTR(data, sensor->name, sensor,
-				   data->num_sensors);
+	pmbus_attr_init(a, sensor->name,
+			readonly ? S_IRUGO : S_IRUGO | S_IWUSR,
+			pmbus_show_sensor, pmbus_set_sensor, data->num_sensors);
+
+	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 	data->num_sensors++;
 }
 
@@ -893,10 +897,14 @@ static void pmbus_add_label(struct pmbus_data *data,
 			    const char *lstring, int index)
 {
 	struct pmbus_label *label;
+	struct sensor_device_attribute *a;
 
-	BUG_ON(data->num_labels >= data->max_labels);
+	BUG_ON(data->num_labels >= data->max_labels ||
+	       data->num_attributes >= data->max_attributes);
 
 	label = &data->labels[data->num_labels];
+	a = &label->attribute;
+
 	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
 	if (!index)
 		strncpy(label->label, lstring, sizeof(label->label) - 1);
@@ -904,7 +912,9 @@ static void pmbus_add_label(struct pmbus_data *data,
 		snprintf(label->label, sizeof(label->label), "%s%d", lstring,
 			 index);
 
-	PMBUS_ADD_GET_ATTR(data, label->name, label, data->num_labels);
+	pmbus_attr_init(a, label->name, S_IRUGO, pmbus_show_label, NULL,
+			data->num_labels);
+	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 	data->num_labels++;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
