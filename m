From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Mar 2013 16:07:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Allocate attributes dynamically from templates
Message-Id: <1363882052-13540-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Static attribute allocation is large and very repetitive.
Allocate attributes and attribute groups dynamically instead.
This reduces the size of the driver source by more than 600 lines,
and object size by more than 20k (more than 30%).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Dynamic attribute allocation might be a useful addition to the hwmon API.

 drivers/hwmon/nct6775.c | 1607 +++++++++++++++--------------------------------
 1 file changed, 500 insertions(+), 1107 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 896f231..01c92ca 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -554,6 +554,10 @@ struct nct6775_data {
 	const char *name;
 
 	struct device *hwmon_dev;
+	struct attribute_group *group_in;
+	struct attribute_group *group_fan;
+	struct attribute_group *group_temp;
+	struct attribute_group *group_pwm;
 
 	u16 reg_temp[4][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
 				    * 3=temp_crit
@@ -671,6 +675,8 @@ struct nct6775_data {
 	u8 vid;
 	u8 vrm;
 
+	bool have_vid;
+
 	u16 have_temp;
 	u16 have_temp_fixed;
 	u16 have_in;
@@ -687,6 +693,132 @@ struct nct6775_sio_data {
 	enum kinds kind;
 };
 
+struct sensor_device_template {
+	struct device_attribute dev_attr;
+	union {
+		struct {
+			u8 nr;
+			u8 index;
+		} s;
+		int index;
+	} u;
+	bool s2;	/* true if both index and nr are used */
+};
+
+struct sensor_device_attr_u {
+	union {
+		struct sensor_device_attribute a1;
+		struct sensor_device_attribute_2 a2;
+	} u;
+	char name[32];
+};
+
+#define SENSOR_DEVICE_TEMPLATE(_name, _mode, _show, _store, _index)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .u.index = _index,						\
+	  .s2 = false }
+
+#define SENSOR_DEVICE_TEMPLATE_2(_name, _mode, _show, _store,		\
+				 _nr, _index)				\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .u.s.index = _index,						\
+	  .u.s.nr = _nr,						\
+	  .s2 = true }
+
+#define SENSOR_TEMPLATE(_name, _template, _mode, _show, _store, _index)	\
+static struct sensor_device_template sensor_dev_template_##_name	\
+	= SENSOR_DEVICE_TEMPLATE(_template, _mode, _show, _store,	\
+				 _index)
+
+#define SENSOR_TEMPLATE_2(_name, _template, _mode, _show, _store,	\
+			  _nr, _index)					\
+static struct sensor_device_template sensor_dev_template_##_name	\
+	= SENSOR_DEVICE_TEMPLATE_2(_template, _mode, _show, _store,	\
+				 _nr, _index)
+
+struct sensor_template_group {
+	struct sensor_device_template **templates;
+	umode_t (*is_visible)(struct kobject *, struct attribute *, int);
+	int base;
+};
+
+static struct attribute_group *
+nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
+			  int repeat)
+{
+	struct attribute_group *group;
+	struct sensor_device_attr_u *su;
+	struct sensor_device_attribute *a;
+	struct sensor_device_attribute_2 *a2;
+	struct attribute **attrs;
+	struct sensor_device_template **t;
+	int err, i, j, count;
+
+	if (repeat <= 0)
+		return ERR_PTR(-EINVAL);
+
+	t = tg->templates;
+	for (count = 0; *t; t++, count++)
+		;
+
+	if (count = 0)
+		return ERR_PTR(-EINVAL);
+
+	group = devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
+	if (group = NULL)
+		return ERR_PTR(-ENOMEM);
+
+	attrs = devm_kzalloc(dev, sizeof(*attrs) * (repeat * count + 1),
+			     GFP_KERNEL);
+	if (attrs = NULL)
+		return ERR_PTR(-ENOMEM);
+
+	su = devm_kzalloc(dev, sizeof(*su) * repeat * count,
+			       GFP_KERNEL);
+	if (su = NULL)
+		return ERR_PTR(-ENOMEM);
+
+	group->attrs = attrs;
+	group->is_visible = tg->is_visible;
+
+	for (i = 0; i < repeat; i++) {
+		t = tg->templates;
+		for (j = 0; *t != NULL; j++) {
+			snprintf(su->name, sizeof(su->name),
+				 (*t)->dev_attr.attr.name, tg->base + i);
+			if ((*t)->s2) {
+				a2 = &su->u.a2;
+				a2->dev_attr.attr.name = su->name;
+				a2->nr = (*t)->u.s.nr + i;
+				a2->index = (*t)->u.s.index;
+				a2->dev_attr.attr.mode +				  (*t)->dev_attr.attr.mode;
+				a2->dev_attr.show = (*t)->dev_attr.show;
+				a2->dev_attr.store = (*t)->dev_attr.store;
+				*attrs = &a2->dev_attr.attr;
+			} else {
+				a = &su->u.a1;
+				a->dev_attr.attr.name = su->name;
+				a->index = (*t)->u.index + i;
+				a->dev_attr.attr.mode +				  (*t)->dev_attr.attr.mode;
+				a->dev_attr.show = (*t)->dev_attr.show;
+				a->dev_attr.store = (*t)->dev_attr.store;
+				*attrs = &a->dev_attr.attr;
+			}
+			attrs++;
+			su++;
+			t++;
+		}
+	}
+
+	err = sysfs_create_group(&dev->kobj, group);
+	if (err)
+		return ERR_PTR(-ENOMEM);
+
+	return group;
+}
+
 static bool is_word_sized(struct nct6775_data *data, u16 reg)
 {
 	switch (data->kind) {
@@ -1193,224 +1325,42 @@ show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 		       (unsigned int)((data->alarms >> nr) & 0x01));
 }
 
-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in_reg, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in_reg, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in_reg, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in_reg, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in_reg, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in_reg, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in_reg, NULL, 6, 0);
-static SENSOR_DEVICE_ATTR_2(in7_input, S_IRUGO, show_in_reg, NULL, 7, 0);
-static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in_reg, NULL, 8, 0);
-static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in_reg, NULL, 9, 0);
-static SENSOR_DEVICE_ATTR_2(in10_input, S_IRUGO, show_in_reg, NULL, 10, 0);
-static SENSOR_DEVICE_ATTR_2(in11_input, S_IRUGO, show_in_reg, NULL, 11, 0);
-static SENSOR_DEVICE_ATTR_2(in12_input, S_IRUGO, show_in_reg, NULL, 12, 0);
-static SENSOR_DEVICE_ATTR_2(in13_input, S_IRUGO, show_in_reg, NULL, 13, 0);
-static SENSOR_DEVICE_ATTR_2(in14_input, S_IRUGO, show_in_reg, NULL, 14, 0);
-
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in11_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(in12_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(in13_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(in14_alarm, S_IRUGO, show_alarm, NULL, 14);
-
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 0, 1);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 1, 1);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 2, 1);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 3, 1);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 4, 1);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 5, 1);
-static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 6, 1);
-static SENSOR_DEVICE_ATTR_2(in7_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 7, 1);
-static SENSOR_DEVICE_ATTR_2(in8_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 8, 1);
-static SENSOR_DEVICE_ATTR_2(in9_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 9, 1);
-static SENSOR_DEVICE_ATTR_2(in10_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 10, 1);
-static SENSOR_DEVICE_ATTR_2(in11_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 11, 1);
-static SENSOR_DEVICE_ATTR_2(in12_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 12, 1);
-static SENSOR_DEVICE_ATTR_2(in13_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 13, 1);
-static SENSOR_DEVICE_ATTR_2(in14_min, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 14, 1);
-
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 0, 2);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 1, 2);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 2, 2);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 3, 2);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 4, 2);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 5, 2);
-static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 6, 2);
-static SENSOR_DEVICE_ATTR_2(in7_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 7, 2);
-static SENSOR_DEVICE_ATTR_2(in8_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 8, 2);
-static SENSOR_DEVICE_ATTR_2(in9_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 9, 2);
-static SENSOR_DEVICE_ATTR_2(in10_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 10, 2);
-static SENSOR_DEVICE_ATTR_2(in11_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 11, 2);
-static SENSOR_DEVICE_ATTR_2(in12_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 12, 2);
-static SENSOR_DEVICE_ATTR_2(in13_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 13, 2);
-static SENSOR_DEVICE_ATTR_2(in14_max, S_IWUSR | S_IRUGO, show_in_reg,
-			    store_in_reg, 14, 2);
-
-static struct attribute *nct6775_attributes_in[15][5] = {
-	{
-		&sensor_dev_attr_in0_input.dev_attr.attr,
-		&sensor_dev_attr_in0_min.dev_attr.attr,
-		&sensor_dev_attr_in0_max.dev_attr.attr,
-		&sensor_dev_attr_in0_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in1_input.dev_attr.attr,
-		&sensor_dev_attr_in1_min.dev_attr.attr,
-		&sensor_dev_attr_in1_max.dev_attr.attr,
-		&sensor_dev_attr_in1_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in2_input.dev_attr.attr,
-		&sensor_dev_attr_in2_min.dev_attr.attr,
-		&sensor_dev_attr_in2_max.dev_attr.attr,
-		&sensor_dev_attr_in2_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in3_input.dev_attr.attr,
-		&sensor_dev_attr_in3_min.dev_attr.attr,
-		&sensor_dev_attr_in3_max.dev_attr.attr,
-		&sensor_dev_attr_in3_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in4_input.dev_attr.attr,
-		&sensor_dev_attr_in4_min.dev_attr.attr,
-		&sensor_dev_attr_in4_max.dev_attr.attr,
-		&sensor_dev_attr_in4_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in5_input.dev_attr.attr,
-		&sensor_dev_attr_in5_min.dev_attr.attr,
-		&sensor_dev_attr_in5_max.dev_attr.attr,
-		&sensor_dev_attr_in5_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in6_input.dev_attr.attr,
-		&sensor_dev_attr_in6_min.dev_attr.attr,
-		&sensor_dev_attr_in6_max.dev_attr.attr,
-		&sensor_dev_attr_in6_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in7_input.dev_attr.attr,
-		&sensor_dev_attr_in7_min.dev_attr.attr,
-		&sensor_dev_attr_in7_max.dev_attr.attr,
-		&sensor_dev_attr_in7_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in8_input.dev_attr.attr,
-		&sensor_dev_attr_in8_min.dev_attr.attr,
-		&sensor_dev_attr_in8_max.dev_attr.attr,
-		&sensor_dev_attr_in8_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in9_input.dev_attr.attr,
-		&sensor_dev_attr_in9_min.dev_attr.attr,
-		&sensor_dev_attr_in9_max.dev_attr.attr,
-		&sensor_dev_attr_in9_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in10_input.dev_attr.attr,
-		&sensor_dev_attr_in10_min.dev_attr.attr,
-		&sensor_dev_attr_in10_max.dev_attr.attr,
-		&sensor_dev_attr_in10_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in11_input.dev_attr.attr,
-		&sensor_dev_attr_in11_min.dev_attr.attr,
-		&sensor_dev_attr_in11_max.dev_attr.attr,
-		&sensor_dev_attr_in11_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in12_input.dev_attr.attr,
-		&sensor_dev_attr_in12_min.dev_attr.attr,
-		&sensor_dev_attr_in12_max.dev_attr.attr,
-		&sensor_dev_attr_in12_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in13_input.dev_attr.attr,
-		&sensor_dev_attr_in13_min.dev_attr.attr,
-		&sensor_dev_attr_in13_max.dev_attr.attr,
-		&sensor_dev_attr_in13_alarm.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_in14_input.dev_attr.attr,
-		&sensor_dev_attr_in14_min.dev_attr.attr,
-		&sensor_dev_attr_in14_max.dev_attr.attr,
-		&sensor_dev_attr_in14_alarm.dev_attr.attr,
-		NULL
-	},
+static umode_t nct6775_in_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int in = index / 4;	/* voltage index */
+
+	if (!(data->have_in & (1 << in)))
+		return 0;
+
+	return attr->mode;
+}
+
+SENSOR_TEMPLATE_2(in_input, in%d_input, S_IRUGO, show_in_reg, NULL, 0, 0);
+SENSOR_TEMPLATE(in_alarm, in%d_alarm, S_IRUGO, show_alarm, NULL, 0);
+SENSOR_TEMPLATE_2(in_min, in%d_min, S_IWUSR | S_IRUGO, show_in_reg,
+		  store_in_reg, 0, 1);
+SENSOR_TEMPLATE_2(in_max, in%d_max, S_IWUSR | S_IRUGO, show_in_reg,
+		  store_in_reg, 0, 2);
+
+/*
+ * nct6775_in_is_visible uses the index into the following array
+ * to determine if attributes should be created or not.
+ * Any change in order or content must be matched.
+ */
+static struct sensor_device_template *nct6775_attributes_in_template[] = {
+	&sensor_dev_template_in_input,
+	&sensor_dev_template_in_alarm,
+	&sensor_dev_template_in_min,
+	&sensor_dev_template_in_max,
+	NULL
 };
 
-static const struct attribute_group nct6775_group_in[15] = {
-	{ .attrs = nct6775_attributes_in[0] },
-	{ .attrs = nct6775_attributes_in[1] },
-	{ .attrs = nct6775_attributes_in[2] },
-	{ .attrs = nct6775_attributes_in[3] },
-	{ .attrs = nct6775_attributes_in[4] },
-	{ .attrs = nct6775_attributes_in[5] },
-	{ .attrs = nct6775_attributes_in[6] },
-	{ .attrs = nct6775_attributes_in[7] },
-	{ .attrs = nct6775_attributes_in[8] },
-	{ .attrs = nct6775_attributes_in[9] },
-	{ .attrs = nct6775_attributes_in[10] },
-	{ .attrs = nct6775_attributes_in[11] },
-	{ .attrs = nct6775_attributes_in[12] },
-	{ .attrs = nct6775_attributes_in[13] },
-	{ .attrs = nct6775_attributes_in[14] },
+static struct sensor_template_group nct6775_in_template_group = {
+	.templates = nct6775_attributes_in_template,
+	.is_visible = nct6775_in_is_visible,
 };
 
 static ssize_t
@@ -1571,54 +1521,52 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static struct sensor_device_attribute sda_fan_input[] = {
-	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
-	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
-	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
-	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
-	SENSOR_ATTR(fan5_input, S_IRUGO, show_fan, NULL, 4),
-};
+static umode_t nct6775_fan_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int fan = index / 5;	/* fan index */
+	int nr = index % 5;	/* attribute index */
 
-static struct sensor_device_attribute sda_fan_alarm[] = {
-	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE),
-	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 1),
-	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 2),
-	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 3),
-	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, FAN_ALARM_BASE + 4),
-};
+	if (!(data->has_fan & (1 << fan)))
+		return 0;
 
-static struct sensor_device_attribute sda_fan_min[] = {
-	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    store_fan_min, 0),
-	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    store_fan_min, 1),
-	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    store_fan_min, 2),
-	SENSOR_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    store_fan_min, 3),
-	SENSOR_ATTR(fan5_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    store_fan_min, 4),
-};
+	if (nr = 3 && !(data->has_fan_min & (1 << fan)))
+		return 0;
+	if (nr = 4 && data->kind != nct6775)
+		return 0;
+
+	return attr->mode;
+}
 
-static struct sensor_device_attribute sda_fan_pulses[] = {
-	SENSOR_ATTR(fan1_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-		    store_fan_pulses, 0),
-	SENSOR_ATTR(fan2_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-		    store_fan_pulses, 1),
-	SENSOR_ATTR(fan3_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-		    store_fan_pulses, 2),
-	SENSOR_ATTR(fan4_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-		    store_fan_pulses, 3),
-	SENSOR_ATTR(fan5_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-		    store_fan_pulses, 4),
+SENSOR_TEMPLATE(fan_input, fan%d_input, S_IRUGO, show_fan, NULL, 0);
+SENSOR_TEMPLATE(fan_alarm, fan%d_alarm, S_IRUGO, show_alarm, NULL,
+		FAN_ALARM_BASE);
+SENSOR_TEMPLATE(fan_pulses, fan%d_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
+		store_fan_pulses, 0);
+SENSOR_TEMPLATE(fan_min, fan%d_min, S_IWUSR | S_IRUGO, show_fan_min,
+		store_fan_min, 0);
+SENSOR_TEMPLATE(fan_div, fan%d_div, S_IRUGO, show_fan_div, NULL, 0);
+
+/*
+ * nct6775_fan_is_visible uses the index into the following array
+ * to determine if attributes should be created or not.
+ * Any change in order or content must be matched.
+ */
+static struct sensor_device_template *nct6775_attributes_fan_template[] = {
+	&sensor_dev_template_fan_input,
+	&sensor_dev_template_fan_alarm,
+	&sensor_dev_template_fan_pulses,
+	&sensor_dev_template_fan_min,	/* 3 */
+	&sensor_dev_template_fan_div,	/* 4 */
+	NULL
 };
 
-static struct sensor_device_attribute sda_fan_div[] = {
-	SENSOR_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
-	SENSOR_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
-	SENSOR_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
-	SENSOR_ATTR(fan4_div, S_IRUGO, show_fan_div, NULL, 3),
-	SENSOR_ATTR(fan5_div, S_IRUGO, show_fan_div, NULL, 4),
+static struct sensor_template_group nct6775_fan_template_group = {
+	.templates = nct6775_attributes_fan_template,
+	.is_visible = nct6775_fan_is_visible,
+	.base = 1,
 };
 
 static ssize_t
@@ -1748,147 +1696,72 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static struct sensor_device_attribute_2 sda_temp_input[] = {
-	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
-	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0),
-	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0),
-	SENSOR_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 3, 0),
-	SENSOR_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 4, 0),
-	SENSOR_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 5, 0),
-	SENSOR_ATTR_2(temp7_input, S_IRUGO, show_temp, NULL, 6, 0),
-	SENSOR_ATTR_2(temp8_input, S_IRUGO, show_temp, NULL, 7, 0),
-	SENSOR_ATTR_2(temp9_input, S_IRUGO, show_temp, NULL, 8, 0),
-	SENSOR_ATTR_2(temp10_input, S_IRUGO, show_temp, NULL, 9, 0),
-};
+static umode_t nct6775_temp_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int temp = index / 8;	/* temp index */
+	int nr = index % 8;	/* attribute index */
 
-static struct sensor_device_attribute sda_temp_label[] = {
-	SENSOR_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL, 0),
-	SENSOR_ATTR(temp2_label, S_IRUGO, show_temp_label, NULL, 1),
-	SENSOR_ATTR(temp3_label, S_IRUGO, show_temp_label, NULL, 2),
-	SENSOR_ATTR(temp4_label, S_IRUGO, show_temp_label, NULL, 3),
-	SENSOR_ATTR(temp5_label, S_IRUGO, show_temp_label, NULL, 4),
-	SENSOR_ATTR(temp6_label, S_IRUGO, show_temp_label, NULL, 5),
-	SENSOR_ATTR(temp7_label, S_IRUGO, show_temp_label, NULL, 6),
-	SENSOR_ATTR(temp8_label, S_IRUGO, show_temp_label, NULL, 7),
-	SENSOR_ATTR(temp9_label, S_IRUGO, show_temp_label, NULL, 8),
-	SENSOR_ATTR(temp10_label, S_IRUGO, show_temp_label, NULL, 9),
-};
+	if (!(data->have_temp & (1 << temp)))
+		return 0;
 
-static struct sensor_device_attribute_2 sda_temp_max[] = {
-	SENSOR_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      0, 1),
-	SENSOR_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      1, 1),
-	SENSOR_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      2, 1),
-	SENSOR_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      3, 1),
-	SENSOR_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      4, 1),
-	SENSOR_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      5, 1),
-	SENSOR_ATTR_2(temp7_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      6, 1),
-	SENSOR_ATTR_2(temp8_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      7, 1),
-	SENSOR_ATTR_2(temp9_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      8, 1),
-	SENSOR_ATTR_2(temp10_max, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      9, 1),
-};
+	if (nr = 2 && !data->reg_temp[1][temp])	/* max */
+		return 0;
 
-static struct sensor_device_attribute_2 sda_temp_max_hyst[] = {
-	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      0, 2),
-	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      1, 2),
-	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      2, 2),
-	SENSOR_ATTR_2(temp4_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      3, 2),
-	SENSOR_ATTR_2(temp5_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      4, 2),
-	SENSOR_ATTR_2(temp6_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      5, 2),
-	SENSOR_ATTR_2(temp7_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      6, 2),
-	SENSOR_ATTR_2(temp8_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      7, 2),
-	SENSOR_ATTR_2(temp9_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      8, 2),
-	SENSOR_ATTR_2(temp10_max_hyst, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      9, 2),
-};
+	if (nr = 3 && !data->reg_temp[2][temp])	/* max_hyst */
+		return 0;
 
-static struct sensor_device_attribute_2 sda_temp_crit[] = {
-	SENSOR_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      0, 3),
-	SENSOR_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      1, 3),
-	SENSOR_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      2, 3),
-	SENSOR_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      3, 3),
-	SENSOR_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      4, 3),
-	SENSOR_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      5, 3),
-	SENSOR_ATTR_2(temp7_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      6, 3),
-	SENSOR_ATTR_2(temp8_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      7, 3),
-	SENSOR_ATTR_2(temp9_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      8, 3),
-	SENSOR_ATTR_2(temp10_crit, S_IRUGO | S_IWUSR, show_temp, store_temp,
-		      9, 3),
-};
+	if (nr = 4 && !data->reg_temp[3][temp])	/* crit */
+		return 0;
 
-static struct sensor_device_attribute sda_temp_offset[] = {
-	SENSOR_ATTR(temp1_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 0),
-	SENSOR_ATTR(temp2_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 1),
-	SENSOR_ATTR(temp3_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 2),
-	SENSOR_ATTR(temp4_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 3),
-	SENSOR_ATTR(temp5_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 4),
-	SENSOR_ATTR(temp6_offset, S_IRUGO | S_IWUSR, show_temp_offset,
-		    store_temp_offset, 5),
-};
+	if (nr > 4 && !(data->have_temp_fixed & (1 << temp)))
+		return 0;
 
-static struct sensor_device_attribute sda_temp_type[] = {
-	SENSOR_ATTR(temp1_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 0),
-	SENSOR_ATTR(temp2_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 1),
-	SENSOR_ATTR(temp3_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 2),
-	SENSOR_ATTR(temp4_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 3),
-	SENSOR_ATTR(temp5_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 4),
-	SENSOR_ATTR(temp6_type, S_IRUGO | S_IWUSR, show_temp_type,
-		    store_temp_type, 5),
-};
+	if (nr = 7 && data->ALARM_BITS[TEMP_ALARM_BASE + temp] < 0)
+		return 0;
+
+	return attr->mode;
+}
 
-static struct sensor_device_attribute sda_temp_alarm[] = {
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
+SENSOR_TEMPLATE_2(temp_input, temp%d_input, S_IRUGO, show_temp, NULL, 0, 0);
+SENSOR_TEMPLATE(temp_label, temp%d_label, S_IRUGO, show_temp_label, NULL, 0);
+SENSOR_TEMPLATE_2(temp_max, temp%d_max, S_IRUGO | S_IWUSR, show_temp,
+		  store_temp, 0, 1);
+SENSOR_TEMPLATE_2(temp_max_hyst, temp%d_max_hyst, S_IRUGO | S_IWUSR, show_temp,
+		  store_temp, 0, 2);
+SENSOR_TEMPLATE_2(temp_crit, temp%d_crit, S_IRUGO | S_IWUSR, show_temp,
+		  store_temp, 0, 3);
+SENSOR_TEMPLATE(temp_offset, temp%d_offset, S_IRUGO | S_IWUSR, show_temp_offset,
+		store_temp_offset, 0);
+SENSOR_TEMPLATE(temp_type, temp%d_type, S_IRUGO | S_IWUSR, show_temp_type,
+		store_temp_type, 0);
+SENSOR_TEMPLATE(temp_alarm, temp%d_alarm, S_IRUGO, show_alarm, NULL,
+		TEMP_ALARM_BASE);
+
+/*
+ * nct6775_temp_is_visible uses the index into the following array
+ * to determine if attributes should be created or not.
+ * Any change in order or content must be matched.
+ */
+static struct sensor_device_template *nct6775_attributes_temp_template[] = {
+	&sensor_dev_template_temp_input,
+	&sensor_dev_template_temp_label,
+	&sensor_dev_template_temp_max,		/* 2 */
+	&sensor_dev_template_temp_max_hyst,	/* 3 */
+	&sensor_dev_template_temp_crit,		/* 4 */
+	&sensor_dev_template_temp_offset,	/* 5 */
+	&sensor_dev_template_temp_type,		/* 6 */
+	&sensor_dev_template_temp_alarm,	/* 7 */
+	NULL
 };
 
-#define NUM_TEMP_ALARM	ARRAY_SIZE(sda_temp_alarm)
+static struct sensor_template_group nct6775_temp_template_group = {
+	.templates = nct6775_attributes_temp_template,
+	.is_visible = nct6775_temp_is_visible,
+	.base = 1,
+};
 
 static ssize_t
 show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
@@ -2389,77 +2262,19 @@ store_speed_tolerance(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR_2(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4, 0);
-
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
-			  store_pwm_mode, 0);
-static SENSOR_DEVICE_ATTR(pwm2_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
-			  store_pwm_mode, 1);
-static SENSOR_DEVICE_ATTR(pwm3_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
-			  store_pwm_mode, 2);
-static SENSOR_DEVICE_ATTR(pwm4_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
-			  store_pwm_mode, 3);
-static SENSOR_DEVICE_ATTR(pwm5_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
-			  store_pwm_mode, 4);
-
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
-			  store_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
-			  store_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
-			  store_pwm_enable, 2);
-static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
-			  store_pwm_enable, 3);
-static SENSOR_DEVICE_ATTR(pwm5_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
-			  store_pwm_enable, 4);
-
-static SENSOR_DEVICE_ATTR(pwm1_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_temp_sel, store_pwm_temp_sel, 0);
-static SENSOR_DEVICE_ATTR(pwm2_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_temp_sel, store_pwm_temp_sel, 1);
-static SENSOR_DEVICE_ATTR(pwm3_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_temp_sel, store_pwm_temp_sel, 2);
-static SENSOR_DEVICE_ATTR(pwm4_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_temp_sel, store_pwm_temp_sel, 3);
-static SENSOR_DEVICE_ATTR(pwm5_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_temp_sel, store_pwm_temp_sel, 4);
-
-static SENSOR_DEVICE_ATTR(pwm1_target_temp, S_IWUSR | S_IRUGO, show_target_temp,
-			  store_target_temp, 0);
-static SENSOR_DEVICE_ATTR(pwm2_target_temp, S_IWUSR | S_IRUGO, show_target_temp,
-			  store_target_temp, 1);
-static SENSOR_DEVICE_ATTR(pwm3_target_temp, S_IWUSR | S_IRUGO, show_target_temp,
-			  store_target_temp, 2);
-static SENSOR_DEVICE_ATTR(pwm4_target_temp, S_IWUSR | S_IRUGO, show_target_temp,
-			  store_target_temp, 3);
-static SENSOR_DEVICE_ATTR(pwm5_target_temp, S_IWUSR | S_IRUGO, show_target_temp,
-			  store_target_temp, 4);
-
-static SENSOR_DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, show_target_speed,
-			  store_target_speed, 0);
-static SENSOR_DEVICE_ATTR(fan2_target, S_IWUSR | S_IRUGO, show_target_speed,
-			  store_target_speed, 1);
-static SENSOR_DEVICE_ATTR(fan3_target, S_IWUSR | S_IRUGO, show_target_speed,
-			  store_target_speed, 2);
-static SENSOR_DEVICE_ATTR(fan4_target, S_IWUSR | S_IRUGO, show_target_speed,
-			  store_target_speed, 3);
-static SENSOR_DEVICE_ATTR(fan5_target, S_IWUSR | S_IRUGO, show_target_speed,
-			  store_target_speed, 4);
-
-static SENSOR_DEVICE_ATTR(fan1_tolerance, S_IWUSR | S_IRUGO,
-			    show_speed_tolerance, store_speed_tolerance, 0);
-static SENSOR_DEVICE_ATTR(fan2_tolerance, S_IWUSR | S_IRUGO,
-			    show_speed_tolerance, store_speed_tolerance, 1);
-static SENSOR_DEVICE_ATTR(fan3_tolerance, S_IWUSR | S_IRUGO,
-			    show_speed_tolerance, store_speed_tolerance, 2);
-static SENSOR_DEVICE_ATTR(fan4_tolerance, S_IWUSR | S_IRUGO,
-			    show_speed_tolerance, store_speed_tolerance, 3);
-static SENSOR_DEVICE_ATTR(fan5_tolerance, S_IWUSR | S_IRUGO,
-			    show_speed_tolerance, store_speed_tolerance, 4);
+SENSOR_TEMPLATE_2(pwm, pwm%d, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0, 0);
+SENSOR_TEMPLATE(pwm_mode, pwm%d_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+		store_pwm_mode, 0);
+SENSOR_TEMPLATE(pwm_enable, pwm%d_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+		store_pwm_enable, 0);
+SENSOR_TEMPLATE(pwm_temp_sel, pwm%d_temp_sel, S_IWUSR | S_IRUGO,
+		show_pwm_temp_sel, store_pwm_temp_sel, 0);
+SENSOR_TEMPLATE(pwm_target_temp, pwm%d_target_temp, S_IWUSR | S_IRUGO,
+		show_target_temp, store_target_temp, 0);
+SENSOR_TEMPLATE(fan_target, fan%d_target, S_IWUSR | S_IRUGO, show_target_speed,
+		store_target_speed, 0);
+SENSOR_TEMPLATE(fan_tolerance, fan%d_tolerance, S_IWUSR | S_IRUGO,
+		show_speed_tolerance, store_speed_tolerance, 0);
 
 /* Smart Fan registers */
 
@@ -2498,79 +2313,18 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR(pwm1_weight_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
-			    0);
-static SENSOR_DEVICE_ATTR(pwm2_weight_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
-			    1);
-static SENSOR_DEVICE_ATTR(pwm3_weight_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
-			    2);
-static SENSOR_DEVICE_ATTR(pwm4_weight_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
-			    3);
-static SENSOR_DEVICE_ATTR(pwm5_weight_temp_sel, S_IWUSR | S_IRUGO,
-			    show_pwm_weight_temp_sel, store_pwm_weight_temp_sel,
-			    4);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 4, 0);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_tol, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_tol, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_tol, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_tol, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 3, 1);
-static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_tol, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 4, 1);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_weight_temp_step_base, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_weight_temp_step_base, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_weight_temp_step_base, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm4_weight_temp_step_base, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 3, 2);
-static SENSOR_DEVICE_ATTR_2(pwm5_weight_temp_step_base, S_IWUSR | S_IRUGO,
-			    show_weight_temp, store_weight_temp, 4, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_weight_duty_step, S_IWUSR | S_IRUGO,
-			    show_pwm, store_pwm, 0, 5);
-static SENSOR_DEVICE_ATTR_2(pwm2_weight_duty_step, S_IWUSR | S_IRUGO,
-			    show_pwm, store_pwm, 1, 5);
-static SENSOR_DEVICE_ATTR_2(pwm3_weight_duty_step, S_IWUSR | S_IRUGO,
-			    show_pwm, store_pwm, 2, 5);
-static SENSOR_DEVICE_ATTR_2(pwm4_weight_duty_step, S_IWUSR | S_IRUGO,
-			    show_pwm, store_pwm, 3, 5);
-static SENSOR_DEVICE_ATTR_2(pwm5_weight_duty_step, S_IWUSR | S_IRUGO,
-			    show_pwm, store_pwm, 4, 5);
-
-/* duty_base is not supported on all chips */
-static struct sensor_device_attribute_2 sda_weight_duty_base[] = {
-	SENSOR_ATTR_2(pwm1_weight_duty_base, S_IWUSR | S_IRUGO,
-		      show_pwm, store_pwm, 0, 6),
-	SENSOR_ATTR_2(pwm2_weight_duty_base, S_IWUSR | S_IRUGO,
-		      show_pwm, store_pwm, 1, 6),
-	SENSOR_ATTR_2(pwm3_weight_duty_base, S_IWUSR | S_IRUGO,
-		      show_pwm, store_pwm, 2, 6),
-	SENSOR_ATTR_2(pwm4_weight_duty_base, S_IWUSR | S_IRUGO,
-		      show_pwm, store_pwm, 3, 6),
-	SENSOR_ATTR_2(pwm5_weight_duty_base, S_IWUSR | S_IRUGO,
-		      show_pwm, store_pwm, 4, 6),
-};
+SENSOR_TEMPLATE(pwm_weight_temp_sel, pwm%d_weight_temp_sel, S_IWUSR | S_IRUGO,
+		  show_pwm_weight_temp_sel, store_pwm_weight_temp_sel, 0);
+SENSOR_TEMPLATE_2(pwm_weight_temp_step, pwm%d_weight_temp_step,
+		  S_IWUSR | S_IRUGO, show_weight_temp, store_weight_temp, 0, 0);
+SENSOR_TEMPLATE_2(pwm_weight_temp_step_tol, pwm%d_weight_temp_step_tol,
+		  S_IWUSR | S_IRUGO, show_weight_temp, store_weight_temp, 0, 1);
+SENSOR_TEMPLATE_2(pwm_weight_temp_step_base, pwm%d_weight_temp_step_base,
+		  S_IWUSR | S_IRUGO, show_weight_temp, store_weight_temp, 0, 2);
+SENSOR_TEMPLATE_2(pwm_weight_duty_step, pwm%d_weight_duty_step,
+		  S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0, 5);
+SENSOR_TEMPLATE_2(pwm_weight_duty_base, pwm%d_weight_duty_base,
+		  S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0, 6);
 
 static ssize_t
 show_fan_time(struct device *dev, struct device_attribute *attr, char *buf)
@@ -2618,227 +2372,6 @@ show_name(struct device *dev, struct device_attribute *attr, char *buf)
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static SENSOR_DEVICE_ATTR_2(pwm1_stop_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_stop_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm5_stop_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 4, 0);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_step_up_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_step_up_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_step_up_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm4_step_up_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 3, 1);
-static SENSOR_DEVICE_ATTR_2(pwm5_step_up_time, S_IWUSR | S_IRUGO, show_fan_time,
-			    store_fan_time, 4, 1);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_step_down_time, S_IWUSR | S_IRUGO,
-			    show_fan_time, store_fan_time, 0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_step_down_time, S_IWUSR | S_IRUGO,
-			    show_fan_time, store_fan_time, 1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_step_down_time, S_IWUSR | S_IRUGO,
-			    show_fan_time, store_fan_time, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm4_step_down_time, S_IWUSR | S_IRUGO,
-			    show_fan_time, store_fan_time, 3, 2);
-static SENSOR_DEVICE_ATTR_2(pwm5_step_down_time, S_IWUSR | S_IRUGO,
-			    show_fan_time, store_fan_time, 4, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_start, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_start, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_start, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm4_start, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 3, 1);
-static SENSOR_DEVICE_ATTR_2(pwm5_start, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 4, 1);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_floor, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_floor, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_floor, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm4_floor, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 3, 2);
-static SENSOR_DEVICE_ATTR_2(pwm5_floor, S_IWUSR | S_IRUGO, show_pwm,
-			    store_pwm, 4, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm4_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm5_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 4, 0);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_crit_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_crit_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_crit_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm4_crit_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 3, 1);
-static SENSOR_DEVICE_ATTR_2(pwm5_crit_temp_tolerance, S_IWUSR | S_IRUGO,
-			    show_temp_tolerance, store_temp_tolerance, 4, 1);
-
-/* pwm_max is not supported on all chips */
-static struct sensor_device_attribute_2 sda_pwm_max[] = {
-	SENSOR_ATTR_2(pwm1_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
-		      0, 3),
-	SENSOR_ATTR_2(pwm2_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
-		      1, 3),
-	SENSOR_ATTR_2(pwm3_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
-		      2, 3),
-	SENSOR_ATTR_2(pwm4_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
-		      3, 3),
-	SENSOR_ATTR_2(pwm5_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
-		      4, 3),
-};
-
-/* pwm_step is not supported on all chips */
-static struct sensor_device_attribute_2 sda_pwm_step[] = {
-	SENSOR_ATTR_2(pwm1_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0, 4),
-	SENSOR_ATTR_2(pwm2_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1, 4),
-	SENSOR_ATTR_2(pwm3_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2, 4),
-	SENSOR_ATTR_2(pwm4_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3, 4),
-	SENSOR_ATTR_2(pwm5_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4, 4),
-};
-
-static struct attribute *nct6775_attributes_pwm[5][20] = {
-	{
-		&sensor_dev_attr_pwm1.dev_attr.attr,
-		&sensor_dev_attr_pwm1_mode.dev_attr.attr,
-		&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-		&sensor_dev_attr_pwm1_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm1_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm1_crit_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm1_target_temp.dev_attr.attr,
-		&sensor_dev_attr_fan1_target.dev_attr.attr,
-		&sensor_dev_attr_fan1_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm1_stop_time.dev_attr.attr,
-		&sensor_dev_attr_pwm1_step_up_time.dev_attr.attr,
-		&sensor_dev_attr_pwm1_step_down_time.dev_attr.attr,
-		&sensor_dev_attr_pwm1_start.dev_attr.attr,
-		&sensor_dev_attr_pwm1_floor.dev_attr.attr,
-		&sensor_dev_attr_pwm1_weight_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm1_weight_temp_step.dev_attr.attr,
-		&sensor_dev_attr_pwm1_weight_temp_step_tol.dev_attr.attr,
-		&sensor_dev_attr_pwm1_weight_temp_step_base.dev_attr.attr,
-		&sensor_dev_attr_pwm1_weight_duty_step.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_pwm2.dev_attr.attr,
-		&sensor_dev_attr_pwm2_mode.dev_attr.attr,
-		&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-		&sensor_dev_attr_pwm2_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm2_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm2_crit_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm2_target_temp.dev_attr.attr,
-		&sensor_dev_attr_fan2_target.dev_attr.attr,
-		&sensor_dev_attr_fan2_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm2_stop_time.dev_attr.attr,
-		&sensor_dev_attr_pwm2_step_up_time.dev_attr.attr,
-		&sensor_dev_attr_pwm2_step_down_time.dev_attr.attr,
-		&sensor_dev_attr_pwm2_start.dev_attr.attr,
-		&sensor_dev_attr_pwm2_floor.dev_attr.attr,
-		&sensor_dev_attr_pwm2_weight_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm2_weight_temp_step.dev_attr.attr,
-		&sensor_dev_attr_pwm2_weight_temp_step_tol.dev_attr.attr,
-		&sensor_dev_attr_pwm2_weight_temp_step_base.dev_attr.attr,
-		&sensor_dev_attr_pwm2_weight_duty_step.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_pwm3.dev_attr.attr,
-		&sensor_dev_attr_pwm3_mode.dev_attr.attr,
-		&sensor_dev_attr_pwm3_enable.dev_attr.attr,
-		&sensor_dev_attr_pwm3_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm3_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm3_crit_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm3_target_temp.dev_attr.attr,
-		&sensor_dev_attr_fan3_target.dev_attr.attr,
-		&sensor_dev_attr_fan3_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm3_stop_time.dev_attr.attr,
-		&sensor_dev_attr_pwm3_step_up_time.dev_attr.attr,
-		&sensor_dev_attr_pwm3_step_down_time.dev_attr.attr,
-		&sensor_dev_attr_pwm3_start.dev_attr.attr,
-		&sensor_dev_attr_pwm3_floor.dev_attr.attr,
-		&sensor_dev_attr_pwm3_weight_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm3_weight_temp_step.dev_attr.attr,
-		&sensor_dev_attr_pwm3_weight_temp_step_tol.dev_attr.attr,
-		&sensor_dev_attr_pwm3_weight_temp_step_base.dev_attr.attr,
-		&sensor_dev_attr_pwm3_weight_duty_step.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_pwm4.dev_attr.attr,
-		&sensor_dev_attr_pwm4_mode.dev_attr.attr,
-		&sensor_dev_attr_pwm4_enable.dev_attr.attr,
-		&sensor_dev_attr_pwm4_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm4_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm4_crit_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm4_target_temp.dev_attr.attr,
-		&sensor_dev_attr_fan4_target.dev_attr.attr,
-		&sensor_dev_attr_fan4_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm4_stop_time.dev_attr.attr,
-		&sensor_dev_attr_pwm4_step_up_time.dev_attr.attr,
-		&sensor_dev_attr_pwm4_step_down_time.dev_attr.attr,
-		&sensor_dev_attr_pwm4_start.dev_attr.attr,
-		&sensor_dev_attr_pwm4_floor.dev_attr.attr,
-		&sensor_dev_attr_pwm4_weight_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm4_weight_temp_step.dev_attr.attr,
-		&sensor_dev_attr_pwm4_weight_temp_step_tol.dev_attr.attr,
-		&sensor_dev_attr_pwm4_weight_temp_step_base.dev_attr.attr,
-		&sensor_dev_attr_pwm4_weight_duty_step.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_pwm5.dev_attr.attr,
-		&sensor_dev_attr_pwm5_mode.dev_attr.attr,
-		&sensor_dev_attr_pwm5_enable.dev_attr.attr,
-		&sensor_dev_attr_pwm5_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm5_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm5_crit_temp_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm5_target_temp.dev_attr.attr,
-		&sensor_dev_attr_fan5_target.dev_attr.attr,
-		&sensor_dev_attr_fan5_tolerance.dev_attr.attr,
-		&sensor_dev_attr_pwm5_stop_time.dev_attr.attr,
-		&sensor_dev_attr_pwm5_step_up_time.dev_attr.attr,
-		&sensor_dev_attr_pwm5_step_down_time.dev_attr.attr,
-		&sensor_dev_attr_pwm5_start.dev_attr.attr,
-		&sensor_dev_attr_pwm5_floor.dev_attr.attr,
-		&sensor_dev_attr_pwm5_weight_temp_sel.dev_attr.attr,
-		&sensor_dev_attr_pwm5_weight_temp_step.dev_attr.attr,
-		&sensor_dev_attr_pwm5_weight_temp_step_tol.dev_attr.attr,
-		&sensor_dev_attr_pwm5_weight_temp_step_base.dev_attr.attr,
-		&sensor_dev_attr_pwm5_weight_duty_step.dev_attr.attr,
-		NULL
-	},
-};
-
-static const struct attribute_group nct6775_group_pwm[5] = {
-	{ .attrs = nct6775_attributes_pwm[0] },
-	{ .attrs = nct6775_attributes_pwm[1] },
-	{ .attrs = nct6775_attributes_pwm[2] },
-	{ .attrs = nct6775_attributes_pwm[3] },
-	{ .attrs = nct6775_attributes_pwm[4] },
-};
-
 static ssize_t
 show_auto_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -2959,155 +2492,140 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct6775_data *data = dev_get_drvdata(dev);
+	int pwm = index / 36;	/* pwm index */
+	int nr = index % 36;	/* attribute index */
+
+	if (!(data->has_pwm & (1 << pwm)))
+		return 0;
+
+	if (nr = 19 && data->REG_PWM[3] = NULL) /* pwm_max */
+		return 0;
+	if (nr = 20 && data->REG_PWM[4] = NULL) /* pwm_step */
+		return 0;
+	if (nr = 21 && data->REG_PWM[6] = NULL) /* weight_duty_base */
+		return 0;
+
+	if (nr >= 22 && nr <= 35) {		/* auto point */
+		int api = (nr - 22) / 2;	/* auto point index */
+
+		if (api > data->auto_pwm_num)
+			return 0;
+	}
+	return attr->mode;
+}
+
+SENSOR_TEMPLATE_2(pwm_stop_time, pwm%d_stop_time, S_IWUSR | S_IRUGO,
+		  show_fan_time, store_fan_time, 0, 0);
+SENSOR_TEMPLATE_2(pwm_step_up_time, pwm%d_step_up_time, S_IWUSR | S_IRUGO,
+		  show_fan_time, store_fan_time, 0, 1);
+SENSOR_TEMPLATE_2(pwm_step_down_time, pwm%d_step_down_time, S_IWUSR | S_IRUGO,
+		  show_fan_time, store_fan_time, 0, 2);
+SENSOR_TEMPLATE_2(pwm_start, pwm%d_start, S_IWUSR | S_IRUGO, show_pwm,
+		  store_pwm, 0, 1);
+SENSOR_TEMPLATE_2(pwm_floor, pwm%d_floor, S_IWUSR | S_IRUGO, show_pwm,
+		  store_pwm, 0, 2);
+SENSOR_TEMPLATE_2(pwm_temp_tolerance, pwm%d_temp_tolerance, S_IWUSR | S_IRUGO,
+		  show_temp_tolerance, store_temp_tolerance, 0, 0);
+SENSOR_TEMPLATE_2(pwm_crit_temp_tolerance, pwm%d_crit_temp_tolerance,
+		  S_IWUSR | S_IRUGO, show_temp_tolerance, store_temp_tolerance,
+		  0, 1);
+
+SENSOR_TEMPLATE_2(pwm_max, pwm%d_max, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		  0, 3);
+
+SENSOR_TEMPLATE_2(pwm_step, pwm%d_step, S_IWUSR | S_IRUGO, show_pwm, store_pwm,
+		  0, 4);
+
+SENSOR_TEMPLATE_2(pwm_auto_point1_pwm, pwm%d_auto_point1_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 0);
+SENSOR_TEMPLATE_2(pwm_auto_point1_temp, pwm%d_auto_point1_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 0);
+
+SENSOR_TEMPLATE_2(pwm_auto_point2_pwm, pwm%d_auto_point2_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 1);
+SENSOR_TEMPLATE_2(pwm_auto_point2_temp, pwm%d_auto_point2_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 1);
+
+SENSOR_TEMPLATE_2(pwm_auto_point3_pwm, pwm%d_auto_point3_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 2);
+SENSOR_TEMPLATE_2(pwm_auto_point3_temp, pwm%d_auto_point3_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 2);
+
+SENSOR_TEMPLATE_2(pwm_auto_point4_pwm, pwm%d_auto_point4_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 3);
+SENSOR_TEMPLATE_2(pwm_auto_point4_temp, pwm%d_auto_point4_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 3);
+
+SENSOR_TEMPLATE_2(pwm_auto_point5_pwm, pwm%d_auto_point5_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 4);
+SENSOR_TEMPLATE_2(pwm_auto_point5_temp, pwm%d_auto_point5_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 4);
+
+SENSOR_TEMPLATE_2(pwm_auto_point6_pwm, pwm%d_auto_point6_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 5);
+SENSOR_TEMPLATE_2(pwm_auto_point6_temp, pwm%d_auto_point6_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 5);
+
+SENSOR_TEMPLATE_2(pwm_auto_point7_pwm, pwm%d_auto_point7_pwm, S_IWUSR | S_IRUGO,
+		  show_auto_pwm, store_auto_pwm, 0, 6);
+SENSOR_TEMPLATE_2(pwm_auto_point7_temp, pwm%d_auto_point7_temp,
+		  S_IWUSR | S_IRUGO, show_auto_temp, store_auto_temp, 0, 6);
+
 /*
- * The number of auto-point trip points is chip dependent.
- * Need to check support while generating/removing attribute files.
+ * nct6775_pwm_is_visible uses the index into the following array
+ * to determine if attributes should be created or not.
+ * Any change in order or content must be matched.
  */
-static struct sensor_device_attribute_2 sda_auto_pwm_arrays[] = {
-	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 0),
-	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 0),
-	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 1),
-	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 1),
-	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 2),
-	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 2),
-	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 3),
-	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 3),
-	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 4),
-	SENSOR_ATTR_2(pwm1_auto_point5_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 4),
-	SENSOR_ATTR_2(pwm1_auto_point6_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 5),
-	SENSOR_ATTR_2(pwm1_auto_point6_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 5),
-	SENSOR_ATTR_2(pwm1_auto_point7_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 0, 6),
-	SENSOR_ATTR_2(pwm1_auto_point7_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 0, 6),
-
-	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 0),
-	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 0),
-	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 1),
-	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 1),
-	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 2),
-	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 2),
-	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 3),
-	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 3),
-	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 4),
-	SENSOR_ATTR_2(pwm2_auto_point5_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 4),
-	SENSOR_ATTR_2(pwm2_auto_point6_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 5),
-	SENSOR_ATTR_2(pwm2_auto_point6_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 5),
-	SENSOR_ATTR_2(pwm2_auto_point7_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 1, 6),
-	SENSOR_ATTR_2(pwm2_auto_point7_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 1, 6),
-
-	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 0),
-	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 0),
-	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 1),
-	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 1),
-	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 2),
-	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 2),
-	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 3),
-	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 3),
-	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 4),
-	SENSOR_ATTR_2(pwm3_auto_point5_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 4),
-	SENSOR_ATTR_2(pwm3_auto_point6_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 5),
-	SENSOR_ATTR_2(pwm3_auto_point6_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 5),
-	SENSOR_ATTR_2(pwm3_auto_point7_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 2, 6),
-	SENSOR_ATTR_2(pwm3_auto_point7_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 2, 6),
-
-	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 0),
-	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 0),
-	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 1),
-	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 1),
-	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 2),
-	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 2),
-	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 3),
-	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 3),
-	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 4),
-	SENSOR_ATTR_2(pwm4_auto_point5_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 4),
-	SENSOR_ATTR_2(pwm4_auto_point6_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 5),
-	SENSOR_ATTR_2(pwm4_auto_point6_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 5),
-	SENSOR_ATTR_2(pwm4_auto_point7_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 3, 6),
-	SENSOR_ATTR_2(pwm4_auto_point7_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 3, 6),
-
-	SENSOR_ATTR_2(pwm5_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 0),
-	SENSOR_ATTR_2(pwm5_auto_point1_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 0),
-	SENSOR_ATTR_2(pwm5_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 1),
-	SENSOR_ATTR_2(pwm5_auto_point2_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 1),
-	SENSOR_ATTR_2(pwm5_auto_point3_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 2),
-	SENSOR_ATTR_2(pwm5_auto_point3_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 2),
-	SENSOR_ATTR_2(pwm5_auto_point4_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 3),
-	SENSOR_ATTR_2(pwm5_auto_point4_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 3),
-	SENSOR_ATTR_2(pwm5_auto_point5_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 4),
-	SENSOR_ATTR_2(pwm5_auto_point5_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 4),
-	SENSOR_ATTR_2(pwm5_auto_point6_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 5),
-	SENSOR_ATTR_2(pwm5_auto_point6_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 5),
-	SENSOR_ATTR_2(pwm5_auto_point7_pwm, S_IWUSR | S_IRUGO,
-		      show_auto_pwm, store_auto_pwm, 4, 6),
-	SENSOR_ATTR_2(pwm5_auto_point7_temp, S_IWUSR | S_IRUGO,
-		      show_auto_temp, store_auto_temp, 4, 6),
+static struct sensor_device_template *nct6775_attributes_pwm_template[] = {
+	&sensor_dev_template_pwm,
+	&sensor_dev_template_pwm_mode,
+	&sensor_dev_template_pwm_enable,
+	&sensor_dev_template_pwm_temp_sel,
+	&sensor_dev_template_pwm_temp_tolerance,
+	&sensor_dev_template_pwm_crit_temp_tolerance,
+	&sensor_dev_template_pwm_target_temp,
+	&sensor_dev_template_fan_target,
+	&sensor_dev_template_fan_tolerance,
+	&sensor_dev_template_pwm_stop_time,
+	&sensor_dev_template_pwm_step_up_time,
+	&sensor_dev_template_pwm_step_down_time,
+	&sensor_dev_template_pwm_start,
+	&sensor_dev_template_pwm_floor,
+	&sensor_dev_template_pwm_weight_temp_sel,
+	&sensor_dev_template_pwm_weight_temp_step,
+	&sensor_dev_template_pwm_weight_temp_step_tol,
+	&sensor_dev_template_pwm_weight_temp_step_base,
+	&sensor_dev_template_pwm_weight_duty_step,
+	&sensor_dev_template_pwm_max,			/* 19 */
+	&sensor_dev_template_pwm_step,			/* 20 */
+	&sensor_dev_template_pwm_weight_duty_base,	/* 21 */
+	&sensor_dev_template_pwm_auto_point1_pwm,	/* 22 */
+	&sensor_dev_template_pwm_auto_point1_temp,
+	&sensor_dev_template_pwm_auto_point2_pwm,
+	&sensor_dev_template_pwm_auto_point2_temp,
+	&sensor_dev_template_pwm_auto_point3_pwm,
+	&sensor_dev_template_pwm_auto_point3_temp,
+	&sensor_dev_template_pwm_auto_point4_pwm,
+	&sensor_dev_template_pwm_auto_point4_temp,
+	&sensor_dev_template_pwm_auto_point5_pwm,
+	&sensor_dev_template_pwm_auto_point5_temp,
+	&sensor_dev_template_pwm_auto_point6_pwm,
+	&sensor_dev_template_pwm_auto_point6_temp,
+	&sensor_dev_template_pwm_auto_point7_pwm,
+	&sensor_dev_template_pwm_auto_point7_temp,	/* 35 */
+
+	NULL
+};
+
+static struct sensor_template_group nct6775_pwm_template_group = {
+	.templates = nct6775_attributes_pwm_template,
+	.is_visible = nct6775_pwm_is_visible,
+	.base = 1,
 };
 
 static ssize_t
@@ -3162,73 +2680,65 @@ error:
 	return count;
 }
 
-static struct sensor_device_attribute sda_caseopen[] = {
-	SENSOR_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm,
-		    clear_caseopen, INTRUSION_ALARM_BASE),
-	SENSOR_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
-		    clear_caseopen, INTRUSION_ALARM_BASE + 1),
-};
+static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm,
+			  clear_caseopen, INTRUSION_ALARM_BASE);
+static SENSOR_DEVICE_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
+			  clear_caseopen, INTRUSION_ALARM_BASE + 1);
 
-/*
- * Driver and device management
- */
-
-static void nct6775_device_remove_files(struct device *dev)
+static umode_t nct6775_other_is_visible(struct kobject *kobj,
+					struct attribute *attr, int index)
 {
-	/*
-	 * some entries in the following arrays may not have been used in
-	 * device_create_file(), but device_remove_file() will ignore them
-	 */
-	int i;
+	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 
-	for (i = 0; i < data->pwm_num; i++)
-		sysfs_remove_group(&dev->kobj, &nct6775_group_pwm[i]);
+	if (index = 1 && !data->have_vid)
+		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(sda_pwm_max); i++)
-		device_remove_file(dev, &sda_pwm_max[i].dev_attr);
+	if (index = 2 || index = 3) {
+		if (data->ALARM_BITS[INTRUSION_ALARM_BASE + index - 2] < 0)
+			return 0;
+	}
+
+	return attr->mode;
+}
 
-	for (i = 0; i < ARRAY_SIZE(sda_pwm_step); i++)
-		device_remove_file(dev, &sda_pwm_step[i].dev_attr);
+/*
+ * nct6775_other_is_visible uses the index into the following array
+ * to determine if attributes should be created or not.
+ * Any change in order or content must be matched.
+ */
+static struct attribute *nct6775_attributes_other[] = {
+	&dev_attr_name.attr,
+	&dev_attr_cpu0_vid.attr,				/* 1 */
+	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,	/* 2 */
+	&sensor_dev_attr_intrusion1_alarm.dev_attr.attr,	/* 3 */
 
-	for (i = 0; i < ARRAY_SIZE(sda_weight_duty_base); i++)
-		device_remove_file(dev, &sda_weight_duty_base[i].dev_attr);
+	NULL
+};
 
-	for (i = 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++)
-		device_remove_file(dev, &sda_auto_pwm_arrays[i].dev_attr);
+static const struct attribute_group nct6775_group_other = {
+	.attrs = nct6775_attributes_other,
+	.is_visible = nct6775_other_is_visible,
+};
 
-	for (i = 0; i < data->in_num; i++)
-		sysfs_remove_group(&dev->kobj, &nct6775_group_in[i]);
+/*
+ * Driver and device management
+ */
 
-	for (i = 0; i < 5; i++) {
-		device_remove_file(dev, &sda_fan_input[i].dev_attr);
-		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
-		device_remove_file(dev, &sda_fan_div[i].dev_attr);
-		device_remove_file(dev, &sda_fan_min[i].dev_attr);
-		device_remove_file(dev, &sda_fan_pulses[i].dev_attr);
-	}
-	for (i = 0; i < NUM_TEMP; i++) {
-		if (!(data->have_temp & (1 << i)))
-			continue;
-		device_remove_file(dev, &sda_temp_input[i].dev_attr);
-		device_remove_file(dev, &sda_temp_label[i].dev_attr);
-		device_remove_file(dev, &sda_temp_max[i].dev_attr);
-		device_remove_file(dev, &sda_temp_max_hyst[i].dev_attr);
-		device_remove_file(dev, &sda_temp_crit[i].dev_attr);
-		if (!(data->have_temp_fixed & (1 << i)))
-			continue;
-		device_remove_file(dev, &sda_temp_type[i].dev_attr);
-		device_remove_file(dev, &sda_temp_offset[i].dev_attr);
-		if (i >= NUM_TEMP_ALARM)
-			continue;
-		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
-	}
+static void nct6775_device_remove_files(struct device *dev)
+{
+	struct nct6775_data *data = dev_get_drvdata(dev);
 
-	device_remove_file(dev, &sda_caseopen[0].dev_attr);
-	device_remove_file(dev, &sda_caseopen[1].dev_attr);
+	if (data->group_pwm)
+		sysfs_remove_group(&dev->kobj, data->group_pwm);
+	if (data->group_in)
+		sysfs_remove_group(&dev->kobj, data->group_in);
+	if (data->group_fan)
+		sysfs_remove_group(&dev->kobj, data->group_fan);
+	if (data->group_temp)
+		sysfs_remove_group(&dev->kobj, data->group_temp);
 
-	device_remove_file(dev, &dev_attr_name);
-	device_remove_file(dev, &dev_attr_cpu0_vid);
+	sysfs_remove_group(&dev->kobj, &nct6775_group_other);
 }
 
 /* Get the monitoring functions started */
@@ -3273,18 +2783,13 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 	}
 }
 
-static int
+static void
 nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 			 struct nct6775_data *data)
 {
 	int regval;
 	bool fan3pin, fan3min, fan4pin, fan4min, fan5pin;
 	bool pwm3pin, pwm4pin, pwm5pin;
-	int ret;
-
-	ret = superio_enter(sio_data->sioreg);
-	if (ret)
-		return ret;
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind = nct6775) {
@@ -3341,8 +2846,6 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		fan4min = fan4pin;
 	}
 
-	superio_exit(sio_data->sioreg);
-
 	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */
 	data->has_fan |= fan3pin << 2;
 	data->has_fan_min |= fan3min << 2;
@@ -3351,8 +2854,6 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 	data->has_fan_min |= (fan4min << 3) | (fan5pin << 4);
 
 	data->has_pwm = 0x03 | (pwm3pin << 2) | (pwm4pin << 3) | (pwm5pin << 4);
-
-	return 0;
 }
 
 static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
@@ -3392,8 +2893,8 @@ static int nct6775_probe(struct platform_device *pdev)
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
 	const u16 *reg_temp_alternate, *reg_temp_crit;
 	int num_reg_temp;
-	bool have_vid = false;
 	u8 cr2a;
+	struct attribute_group *group;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
@@ -3768,10 +3269,10 @@ static int nct6775_probe(struct platform_device *pdev)
 	cr2a = superio_inb(sio_data->sioreg, 0x2a);
 	switch (data->kind) {
 	case nct6775:
-		have_vid = (cr2a & 0x40);
+		data->have_vid = (cr2a & 0x40);
 		break;
 	case nct6776:
-		have_vid = (cr2a & 0x60) = 0x40;
+		data->have_vid = (cr2a & 0x60) = 0x40;
 		break;
 	case nct6779:
 		break;
@@ -3781,7 +3282,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	 * Read VID value
 	 * We can get the VID input values directly at logical device D 0xe3.
 	 */
-	if (have_vid) {
+	if (data->have_vid) {
 		superio_select(sio_data->sioreg, NCT6775_LD_VID);
 		data->vid = superio_inb(sio_data->sioreg, 0xe3);
 		data->vrm = vid_which_vrm();
@@ -3808,155 +3309,47 @@ static int nct6775_probe(struct platform_device *pdev)
 			 data->name);
 	}
 
-	superio_exit(sio_data->sioreg);
-
-	if (have_vid) {
-		err = device_create_file(dev, &dev_attr_cpu0_vid);
-		if (err)
-			return err;
-	}
+	nct6775_check_fan_inputs(sio_data, data);
 
-	err = nct6775_check_fan_inputs(sio_data, data);
-	if (err)
-		goto exit_remove;
+	superio_exit(sio_data->sioreg);
 
 	/* Read fan clock dividers immediately */
 	nct6775_init_fan_common(dev, data);
 
 	/* Register sysfs hooks */
-	for (i = 0; i < data->pwm_num; i++) {
-		if (!(data->has_pwm & (1 << i)))
-			continue;
-
-		err = sysfs_create_group(&dev->kobj, &nct6775_group_pwm[i]);
-		if (err)
-			goto exit_remove;
-
-		if (data->REG_PWM[3]) {
-			err = device_create_file(dev,
-					&sda_pwm_max[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (data->REG_PWM[4]) {
-			err = device_create_file(dev,
-					&sda_pwm_step[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (data->REG_PWM[6]) {
-			err = device_create_file(dev,
-					&sda_weight_duty_base[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(sda_auto_pwm_arrays); i++) {
-		struct sensor_device_attribute_2 *attr -			&sda_auto_pwm_arrays[i];
-
-		if (!(data->has_pwm & (1 << attr->nr)))
-			continue;
-		if (attr->index > data->auto_pwm_num)
-			continue;
-		err = device_create_file(dev, &attr->dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	for (i = 0; i < data->in_num; i++) {
-		if (!(data->have_in & (1 << i)))
-			continue;
-		err = sysfs_create_group(&dev->kobj, &nct6775_group_in[i]);
-		if (err)
-			goto exit_remove;
+	group = nct6775_create_attr_group(dev, &nct6775_pwm_template_group,
+					  data->pwm_num);
+	if (IS_ERR(group)) {
+		err = PTR_ERR(group);
+		goto exit_remove;
 	}
+	data->group_pwm = group;
 
-	for (i = 0; i < 5; i++) {
-		if (data->has_fan & (1 << i)) {
-			err = device_create_file(dev,
-						 &sda_fan_input[i].dev_attr);
-			if (err)
-				goto exit_remove;
-			err = device_create_file(dev,
-						 &sda_fan_alarm[i].dev_attr);
-			if (err)
-				goto exit_remove;
-			if (data->kind != nct6776 &&
-			    data->kind != nct6779) {
-				err = device_create_file(dev,
-						&sda_fan_div[i].dev_attr);
-				if (err)
-					goto exit_remove;
-			}
-			if (data->has_fan_min & (1 << i)) {
-				err = device_create_file(dev,
-						&sda_fan_min[i].dev_attr);
-				if (err)
-					goto exit_remove;
-			}
-			err = device_create_file(dev,
-						&sda_fan_pulses[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
+	group = nct6775_create_attr_group(dev, &nct6775_in_template_group,
+					  fls(data->have_in));
+	if (IS_ERR(group)) {
+		err = PTR_ERR(group);
+		goto exit_remove;
 	}
+	data->group_in = group;
 
-	for (i = 0; i < NUM_TEMP; i++) {
-		if (!(data->have_temp & (1 << i)))
-			continue;
-		err = device_create_file(dev, &sda_temp_input[i].dev_attr);
-		if (err)
-			goto exit_remove;
-		if (data->temp_label) {
-			err = device_create_file(dev,
-						 &sda_temp_label[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (data->reg_temp[1][i]) {
-			err = device_create_file(dev,
-						 &sda_temp_max[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (data->reg_temp[2][i]) {
-			err = device_create_file(dev,
-					&sda_temp_max_hyst[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (data->reg_temp[3][i]) {
-			err = device_create_file(dev,
-						 &sda_temp_crit[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-		if (!(data->have_temp_fixed & (1 << i)))
-			continue;
-		err = device_create_file(dev, &sda_temp_type[i].dev_attr);
-		if (err)
-			goto exit_remove;
-		err = device_create_file(dev, &sda_temp_offset[i].dev_attr);
-		if (err)
-			goto exit_remove;
-		if (i >= NUM_TEMP_ALARM ||
-		    data->ALARM_BITS[TEMP_ALARM_BASE + i] < 0)
-			continue;
-		err = device_create_file(dev, &sda_temp_alarm[i].dev_attr);
-		if (err)
-			goto exit_remove;
+	group = nct6775_create_attr_group(dev, &nct6775_fan_template_group,
+					  fls(data->has_fan));
+	if (IS_ERR(group)) {
+		err = PTR_ERR(group);
+		goto exit_remove;
 	}
+	data->group_fan = group;
 
-	for (i = 0; i < ARRAY_SIZE(sda_caseopen); i++) {
-		if (data->ALARM_BITS[INTRUSION_ALARM_BASE + i] < 0)
-			continue;
-		err = device_create_file(dev, &sda_caseopen[i].dev_attr);
-		if (err)
-			goto exit_remove;
+	group = nct6775_create_attr_group(dev, &nct6775_temp_template_group,
+					  fls(data->have_temp));
+	if (IS_ERR(group)) {
+		err = PTR_ERR(group);
+		goto exit_remove;
 	}
+	data->group_temp = group;
 
-	err = device_create_file(dev, &dev_attr_name);
+	err = sysfs_create_group(&dev->kobj, &nct6775_group_other);
 	if (err)
 		goto exit_remove;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
