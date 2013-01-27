From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:39 +0000
Subject: [lm-sensors] [PATCH 05/13] hwmon: (pmbus) Improve boolean handling
Message-Id: <1359253067-11644-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Boolean handling depends on storing the sensor data index in sensor_device_attr
as part of the index variable. This limits the number of sensor attributes to
256, and means the sensor sequence number actually has to be maintained to be
able to access sensor data from boolean functions.

Rework the code to store sensor pointers in the pmbus_boolean data structure
directly. With this approach, the number of supportable sensors is now
unlimited.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |  161 ++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 87 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 0f51cd6..d1792d7 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -98,7 +98,11 @@ struct pmbus_sensor {
 struct pmbus_boolean {
 	char name[PMBUS_NAME_SIZE];	/* sysfs boolean name */
 	struct sensor_device_attribute attribute;
+	struct pmbus_sensor *s1;
+	struct pmbus_sensor *s2;
 };
+#define to_pmbus_boolean(_attr) \
+	container_of(_attr, struct pmbus_boolean, attribute)
 
 struct pmbus_label {
 	char name[PMBUS_NAME_SIZE];	/* sysfs label name */
@@ -673,25 +677,20 @@ static u16 pmbus_data2reg(struct pmbus_data *data,
 
 /*
  * Return boolean calculated from converted data.
- * <index> defines a status register index and mask, and optionally
- * two sensor indexes.
- * The upper half-word references the two sensors,
- * two sensor indices.
- * The upper half-word references the two optional sensors,
- * the lower half word references status register and mask.
- * The function returns true if (status[reg] & mask) is true and,
- * if specified, if v1 >= v2.
- * To determine if an object exceeds upper limits, specify <v, limit>.
- * To determine if an object exceeds lower limits, specify <limit, v>.
+ * <index> defines a status register index and mask.
+ * The mask is in the lower 8 bits, the register index is in bits 8..23.
  *
- * For booleans created with pmbus_add_boolean_reg(), only the lower 16 bits of
- * index are set. s1 and s2 (the sensor index values) are zero in this case.
- * The function returns true if (status[reg] & mask) is true.
+ * The associated pmbus_boolean structure contains optional pointers to two
+ * sensor attributes. If specified, those attributes are compared against each
+ * other to determine if a limit has been exceeded.
  *
- * If the boolean was created with pmbus_add_boolean_cmp(), a comparison against
- * a specified limit has to be performed to determine the boolean result.
+ * If the sensor attribute pointers are NULL, the function returns true if
+ * (status[reg] & mask) is true.
+ *
+ * If sensor attribute pointers are provided, a comparison against a specified
+ * limit has to be performed to determine the boolean result.
  * In this case, the function returns true if v1 >= v2 (where v1 and v2 are
- * sensor values referenced by sensor indices s1 and s2).
+ * sensor values referenced by sensor attribute pointers s1 and s2).
  *
  * To determine if an object exceeds upper limits, specify <s1,s2> = <v,limit>.
  * To determine if an object exceeds lower limits, specify <s1,s2> = <limit,v>.
@@ -699,11 +698,12 @@ static u16 pmbus_data2reg(struct pmbus_data *data,
  * If a negative value is stored in any of the referenced registers, this value
  * reflects an error code which will be returned.
  */
-static int pmbus_get_boolean(struct pmbus_data *data, int index)
+static int pmbus_get_boolean(struct pmbus_data *data, struct pmbus_boolean *b,
+			     int index)
 {
-	u8 s1 = (index >> 24) & 0xff;
-	u8 s2 = (index >> 16) & 0xff;
-	u8 reg = (index >> 8) & 0xff;
+	struct pmbus_sensor *s1 = b->s1;
+	struct pmbus_sensor *s2 = b->s2;
+	u16 reg = (index >> 8) & 0xffff;
 	u8 mask = index & 0xff;
 	int ret, status;
 	u8 regval;
@@ -713,21 +713,21 @@ static int pmbus_get_boolean(struct pmbus_data *data, int index)
 		return status;
 
 	regval = status & mask;
-	if (!s1 && !s2)
+	if (!s1 && !s2) {
 		ret = !!regval;
-	else {
+	} else if (!s1 || !s2) {
+		BUG();
+		return 0;
+	} else {
 		long v1, v2;
-		struct pmbus_sensor *sensor1, *sensor2;
 
-		sensor1 = &data->sensors[s1];
-		if (sensor1->data < 0)
-			return sensor1->data;
-		sensor2 = &data->sensors[s2];
-		if (sensor2->data < 0)
-			return sensor2->data;
+		if (s1->data < 0)
+			return s1->data;
+		if (s2->data < 0)
+			return s2->data;
 
-		v1 = pmbus_reg2data(data, sensor1);
-		v2 = pmbus_reg2data(data, sensor2);
+		v1 = pmbus_reg2data(data, s1);
+		v2 = pmbus_reg2data(data, s2);
 		ret = !!(regval && v1 >= v2);
 	}
 	return ret;
@@ -737,10 +737,11 @@ static ssize_t pmbus_show_boolean(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct pmbus_boolean *boolean = to_pmbus_boolean(attr);
 	struct pmbus_data *data = pmbus_update_device(dev);
 	int val;
 
-	val = pmbus_get_boolean(data, attr->index);
+	val = pmbus_get_boolean(data, boolean, attr->index);
 	if (val < 0)
 		return val;
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
@@ -829,7 +830,9 @@ static void pmbus_attr_init(struct sensor_device_attribute *a,
 
 static int pmbus_add_boolean(struct pmbus_data *data,
 			     const char *name, const char *type, int seq,
-			     int idx)
+			     struct pmbus_sensor *s1,
+			     struct pmbus_sensor *s2,
+			     u16 reg, u8 mask)
 {
 	struct pmbus_boolean *boolean;
 	struct sensor_device_attribute *a;
@@ -844,32 +847,20 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 
 	snprintf(boolean->name, sizeof(boolean->name), "%s%d_%s",
 		 name, seq, type);
+	boolean->s1 = s1;
+	boolean->s2 = s2;
 	pmbus_attr_init(a, boolean->name, S_IRUGO, pmbus_show_boolean, NULL,
-			idx);
+			(reg << 8) | mask);
 	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 
 	return 0;
 }
 
-static int pmbus_add_boolean_reg(struct pmbus_data *data,
-				 const char *name, const char *type,
-				 int seq, int reg, int bit)
-{
-	return pmbus_add_boolean(data, name, type, seq, (reg << 8) | bit);
-}
-
-static int pmbus_add_boolean_cmp(struct pmbus_data *data,
-				 const char *name, const char *type,
-				 int seq, int i1, int i2, int reg, int mask)
-{
-	return pmbus_add_boolean(data, name, type, seq,
-				 (i1 << 24) | (i2 << 16) | (reg << 8) | mask);
-}
-
-static void pmbus_add_sensor(struct pmbus_data *data,
-			     const char *name, const char *type, int seq,
-			     int page, int reg, enum pmbus_sensor_classes class,
-			     bool update, bool readonly)
+static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
+					     const char *name, const char *type,
+					     int seq, int page, int reg,
+					     enum pmbus_sensor_classes class,
+					     bool update, bool readonly)
 {
 	struct pmbus_sensor *sensor;
 	struct sensor_device_attribute *a;
@@ -892,6 +883,8 @@ static void pmbus_add_sensor(struct pmbus_data *data,
 
 	data->attributes[data->num_attributes++] = &a->dev_attr.attr;
 	data->num_sensors++;
+
+	return sensor;
 }
 
 static int pmbus_add_label(struct pmbus_data *data,
@@ -1023,38 +1016,31 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 				 struct pmbus_data *data,
 				 const struct pmbus_driver_info *info,
 				 const char *name, int index, int page,
-				 int cbase,
+				 struct pmbus_sensor *base,
 				 const struct pmbus_sensor_attr *attr)
 {
 	const struct pmbus_limit_attr *l = attr->limit;
 	int nlimit = attr->nlimit;
 	int have_alarm = 0;
-	int i, cindex;
-	int ret;
+	int i, ret;
+	struct pmbus_sensor *curr;
 
 	for (i = 0; i < nlimit; i++) {
 		if (pmbus_check_word_register(client, page, l->reg)) {
-			cindex = data->num_sensors;
-			pmbus_add_sensor(data, name, l->attr, index, page,
-					 l->reg, attr->class,
-					 attr->update || l->update,
-					 false);
+			curr = pmbus_add_sensor(data, name, l->attr, index,
+						page, l->reg, attr->class,
+						attr->update || l->update,
+						false);
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
-				if (attr->compare) {
-					ret = pmbus_add_boolean_cmp(data, name,
-						l->alarm, index,
-						l->low ? cindex : cbase,
-						l->low ? cbase : cindex,
-						attr->sbase + page, l->sbit);
-					if (ret)
-						return ret;
-				} else {
-					ret = pmbus_add_boolean_reg(data, name,
-						l->alarm, index,
-						attr->sbase + page, l->sbit);
-					if (ret)
-						return ret;
-				}
+				ret = pmbus_add_boolean(data, name,
+					l->alarm, index,
+					attr->compare ?  l->low ? curr : base
+						      : NULL,
+					attr->compare ? l->low ? base : curr
+						      : NULL,
+					attr->sbase + page, l->sbit);
+				if (ret)
+					return ret;
 				have_alarm = 1;
 			}
 		}
@@ -1070,7 +1056,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 				      int index, int page,
 				      const struct pmbus_sensor_attr *attr)
 {
-	int cbase = data->num_sensors;
+	struct pmbus_sensor *base;
 	int ret;
 
 	if (attr->label) {
@@ -1079,11 +1065,11 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		if (ret)
 			return ret;
 	}
-	pmbus_add_sensor(data, name, "input", index, page, attr->reg,
-			 attr->class, true, true);
+	base = pmbus_add_sensor(data, name, "input", index, page, attr->reg,
+				attr->class, true, true);
 	if (attr->sfunc) {
 		ret = pmbus_add_limit_attrs(client, data, info, name,
-					    index, page, cbase, attr);
+					    index, page, base, attr);
 		if (ret < 0)
 			return ret;
 		/*
@@ -1094,9 +1080,10 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		if (!ret && attr->gbit &&
 		    pmbus_check_byte_register(client, page,
 					      PMBUS_STATUS_BYTE)) {
-			ret = pmbus_add_boolean_reg(data, name, "alarm", index,
-						    PB_STATUS_BASE + page,
-						    attr->gbit);
+			ret = pmbus_add_boolean(data, name, "alarm", index,
+						NULL, NULL,
+						PB_STATUS_BASE + page,
+						attr->gbit);
 			if (ret)
 				return ret;
 		}
@@ -1635,13 +1622,13 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 					base = PB_STATUS_FAN34_BASE + page;
 				else
 					base = PB_STATUS_FAN_BASE + page;
-				ret = pmbus_add_boolean_reg(data, "fan",
-					"alarm", index, base,
+				ret = pmbus_add_boolean(data, "fan",
+					"alarm", index, NULL, NULL, base,
 					PB_FAN_FAN1_WARNING >> (f & 1));
 				if (ret)
 					return ret;
-				ret = pmbus_add_boolean_reg(data, "fan",
-					"fault", index, base,
+				ret = pmbus_add_boolean(data, "fan",
+					"fault", index, NULL, NULL, base,
 					PB_FAN_FAN1_FAULT >> (f & 1));
 				if (ret)
 					return ret;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
