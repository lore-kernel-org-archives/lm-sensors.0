From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 08 Dec 2011 21:10:00 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: add new hwmon-core interface
Message-Id: <1323378601-6930-2-git-send-email-dev@lynxeye.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This adds a new hwmon-core interface to centralize sysfs handling
and enable cooperation with other in-kernel drivers.

v3:
- checkpatch clean

v4:
- more flexible interface to allow different capabilities for
  every sensor and holes in sensor numbering
- corrected a few oversights
- split out vid and vrm handling as separate feature
- support 2d attributes for trip point and treshold handling

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/hwmon/Makefile     |    1 +
 drivers/hwmon/hwmon-core.c |  511 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-core.h |  229 ++++++++++++++++++++
 3 files changed, 741 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/hwmon-core.c
 create mode 100644 include/linux/hwmon-core.h

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8251ce8..c7bb343 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_HWMON)		+= hwmon.o
+obj-$(CONFIG_HWMON)		+= hwmon-core.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
 # APCI drivers
diff --git a/drivers/hwmon/hwmon-core.c b/drivers/hwmon/hwmon-core.c
new file mode 100644
index 0000000..3d044ad
--- /dev/null
+++ b/drivers/hwmon/hwmon-core.c
@@ -0,0 +1,511 @@
+/*
+ * hwmon-core.c
+ * Copyright (C) 2011 Lucas Stach <dev@lynxeye.de>
+ *
+ * hwmon-core interface implementation
+ *
+ * Provides functions to create/destroy a sysfs interface out of a
+ * hwmon_device_instance definition. The hwmon_device_instance interface could
+ * also be used to communicate with other drivers within the kernel.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/hwmon-core.h>
+#include <linux/hwmon-sysfs.h>
+
+/* building blocks */
+#define HWMON_NAME_SIZE 32
+
+struct hwmon_device_attribute {
+	struct sensor_device_attribute_2 sensor_dev;
+	struct device *hw_device;
+	enum hwmon_feature feature;
+	u32 subfeature;
+	char name[HWMON_NAME_SIZE];
+	struct list_head node;
+};
+
+enum entry_type {
+	value,
+	text
+};
+
+enum entry_count {
+	single,
+	multi,
+	trip,
+	thre
+};
+
+struct caps_info {
+	char *format;
+	mode_t mode;
+	u32 subfeature;
+	enum entry_type type;
+	enum entry_count count;
+};
+
+/* caps_info structs are used to define how the sysfs interface looks like*/
+static struct caps_info generic_caps_info[] = {
+	[generic_name] =	{"name", S_IRUGO,
+				generic_name, text, single},
+	[generic_update_interval] =	{"update_interval", S_IRUGO|S_IWUGO,
+					generic_update_interval,
+					value, single}
+};
+
+static struct caps_info in_caps_info[] = {
+	[in_input] =	{"in%u_input", S_IRUGO,
+			in_input, value, multi},
+	[in_min] =	{"in%u_min", S_IRUGO|S_IWUGO,
+			in_min, value, multi},
+	[in_max] =	{"in%u_max", S_IRUGO|S_IWUGO,
+			in_max, value, multi},
+	[in_lcrit] =	{"in%u_lcrit", S_IRUGO|S_IWUGO,
+			in_lcrit, value, multi},
+	[in_crit] =	{"in%u_crit", S_IRUGO|S_IWUGO,
+			in_crit, value, multi},
+	[in_average] =	{"in%u_average", S_IRUGO,
+			in_average, value, multi},
+	[in_lowest] =	{"in%u_lowest", S_IRUGO,
+			in_lowest, value, multi},
+	[in_highest] =	{"in%u_highest", S_IRUGO,
+			in_highest, value, multi},
+	[in_reset_history] =	{"in%u_reset_history", S_IWUGO,
+				in_reset_history, value, multi},
+	[in_reset_history_glob] =	{"in_reset_history", S_IWUGO,
+					in_reset_history_glob,
+					value, single},
+	[in_label] =	{"in%u_label", S_IRUGO,
+			in_label, text, multi},
+	[in_alarm] =	{"in%u_alarm", S_IRUGO,
+			in_alarm, value, multi},
+	[in_min_alarm] =	{"in%u_min_alarm", S_IRUGO,
+				in_min_alarm, value, multi},
+	[in_max_alarm] =	{"in%u_max_alarm", S_IRUGO,
+				in_max_alarm, value, multi},
+	[in_lcrit_alarm] =	{"in%u_lcrit_alarm", S_IRUGO,
+				in_lcrit_alarm, value, multi},
+	[in_crit_alarm] =	{"in%u_crit_alarm", S_IRUGO,
+				in_crit_alarm, value, multi},
+	[in_beep] =	{"in%u_beep", S_IRUGO|S_IWUGO,
+			in_beep, value, multi}
+};
+
+static struct caps_info cpu_caps_info[] = {
+	[in_vid] =	{"cpu%u_vid", S_IRUGO,
+			in_vid, value, multi},
+	[in_vrm] =	{"vrm", S_IRUGO|S_IWUGO,
+			in_vrm, value, single},
+};
+
+static struct caps_info fan_caps_info[] = {
+	[fan_input] =	{"fan%u_input", S_IRUGO,
+			fan_input, value, multi},
+	[fan_min] =	{"fan%u_min", S_IRUGO|S_IWUGO,
+			fan_min, value, multi},
+	[fan_max] =	{"fan%u_max", S_IRUGO|S_IWUGO,
+			fan_max, value, multi},
+	[fan_div] =	{"fan%u_div", S_IRUGO|S_IWUGO,
+			fan_div, value, multi},
+	[fan_pulses] =	{"fan%u_pulses", S_IRUGO|S_IWUGO,
+			fan_pulses, value, multi},
+	[fan_target] =	{"fan%u_target", S_IRUGO|S_IWUGO,
+			fan_target, value, multi},
+	[fan_label] =	{"fan%u_label", S_IRUGO,
+			fan_label, text, multi},
+	[fan_alarm] =	{"fan%u_alarm", S_IRUGO,
+			fan_alarm, value, multi},
+	[fan_beep] =	{"fan%u_beep", S_IRUGO|S_IWUGO,
+			fan_beep, value, multi},
+	[fan_fault] =	{"fan%u_fault", S_IRUGO,
+			fan_fault, value, multi}
+};
+
+static struct caps_info pwm_caps_info[] = {
+	[pwm_input] =		{"pwm%u", S_IRUGO|S_IWUGO,
+			pwm_input, value, multi},
+	[pwm_enable] =  {"pwm%u_enable", S_IRUGO|S_IWUGO,
+			pwm_enable, value, multi},
+	[pwm_mode] =	{"pwm%u_mode", S_IRUGO|S_IWUGO,
+			pwm_mode, value, multi},
+	[pwm_freq] =	{"pwm%u_freq", S_IRUGO|S_IWUGO,
+			pwm_freq, value, multi},
+	[pwm_auto_channels_temp] =	{"pwm%u_auto_channels_temp",
+					S_IRUGO|S_IWUGO, pwm_freq,
+					value, multi},
+	[pwm_auto_point_pwm] =	{"pwm%u_auto_point%u_pwm", S_IRUGO|S_IWUGO,
+				pwm_auto_point_pwm, value, trip},
+	[pwm_auto_point_temp] =	{"pwm%u_auto_point%u_temp", S_IRUGO|S_IWUGO,
+				pwm_auto_point_temp, value, trip},
+	[pwm_auto_point_temp_hyst] =	{"pwm%u_auto_point%u_temp",
+					S_IRUGO|S_IWUGO, pwm_auto_point_temp,
+					value, trip},
+};
+
+static struct caps_info temp_caps_info[] = {
+	[temp_type] =		{"temp%u_type,", S_IRUGO|S_IWUGO,
+				temp_type, value, multi},
+	[temp_input] =		{"temp%u_input", S_IRUGO,
+				temp_input, value, multi},
+	[temp_min] =		{"temp%u_min", S_IRUGO|S_IWUGO,
+				temp_min, value, multi},
+	[temp_max] =		{"temp%u_max", S_IRUGO|S_IWUGO,
+				temp_max, value, multi},
+	[temp_max_hyst] =	{"temp%u_max_hyst", S_IRUGO|S_IWUGO,
+				temp_max_hyst, value, multi},
+	[temp_lcrit] =		{"temp%u_lcrit", S_IRUGO|S_IWUGO,
+				temp_lcrit, value, multi},
+	[temp_crit] =		{"temp%u_crit", S_IRUGO|S_IWUGO,
+				temp_crit, value, multi},
+	[temp_crit_hyst] =	{"temp%u_crit_hyst", S_IRUGO|S_IWUGO,
+				temp_crit_hyst, value, multi},
+	[temp_emergency] =	{"temp%u_emergency", S_IRUGO|S_IWUGO,
+				temp_emergency, value, multi},
+	[temp_emergency_hyst] =	{"temp%u_emergency_hyst", S_IRUGO|S_IWUGO,
+				temp_emergency_hyst, value, multi},
+	[temp_offset] =		{"temp%u_offset", S_IRUGO|S_IWUGO,
+				temp_offset, value, multi},
+	[temp_label] =		{"temp%u_label", S_IRUGO,
+				temp_label, text, multi},
+	[temp_lowest] =		{"temp%u_lowest", S_IRUGO,
+				temp_lowest, value, multi},
+	[temp_highest] =	{"temp%u_highest", S_IRUGO,
+				temp_highest, value, multi},
+	[temp_reset_history] =	{"temp%u_reset_history", S_IWUGO,
+				temp_reset_history, value, multi},
+	[temp_reset_history_glob] =	{"temp_reset_history", S_IWUGO,
+					temp_reset_history_glob,
+					value, single},
+	[temp_alarm] =		{"temp%u_alarm", S_IRUGO,
+				temp_alarm, value, multi},
+	[temp_min_alarm] =	{"temp%u_min_alarm", S_IRUGO,
+				temp_min_alarm, value, multi},
+	[temp_max_alarm] =	{"temp%u_max_alarm", S_IRUGO,
+				temp_max_alarm, value, multi},
+	[temp_lcrit_alarm] =	{"temp%u_lcrit_alarm", S_IRUGO,
+				temp_lcrit_alarm, value, multi},
+	[temp_crit_alarm] =	{"temp%u_crit_alarm", S_IRUGO,
+				temp_crit_alarm, value, multi},
+	[temp_emergency_alarm] =	{"temp%u_emergency_alarm", S_IRUGO,
+					temp_emergency_alarm,
+					value, multi},
+	[temp_beep] =		{"temp%u_beep", S_IRUGO|S_IWUGO,
+				temp_beep, value, multi},
+	[temp_fault] =		{"temp%u_fault", S_IRUGO,
+				temp_fault, value, multi},
+	[temp_threshold] =	{"temp%u_threshold%u", S_IRUGO|S_IWUGO,
+				temp_threshold, value, thre},
+	[temp_threshold_triggered] =	{"temp%u_threshold%u_triggered",
+					S_IRUGO, temp_threshold_triggered,
+					value, thre},
+	[temp_auto_point_pwm] = {"temp%u_auto_point%u_pwm", S_IRUGO|S_IWUGO,
+				temp_auto_point_pwm, value, trip},
+	[temp_auto_point_temp] =	 {"temp%u_auto_point%u_temp",
+					 S_IRUGO|S_IWUGO,
+					 temp_auto_point_temp, value, trip},
+	[temp_auto_point_temp_hyst] =	 {"temp%u_auto_point%u_temp_hyst",
+					 S_IRUGO|S_IWUGO,
+					 temp_auto_point_temp_hyst, value, trip}
+};
+
+static struct caps_info curr_caps_info[] = {
+	[curr_input] =		{"curr%u_input", S_IRUGO,
+				curr_input, value, multi},
+	[curr_min] =		{"curr%u_min", S_IRUGO|S_IWUGO,
+				curr_min, value, multi},
+	[curr_max] =		{"curr%u_max", S_IRUGO|S_IWUGO,
+				curr_max, value, multi},
+	[curr_lcrit] =		{"curr%u_lcrit", S_IRUGO|S_IWUGO,
+				curr_lcrit, value, multi},
+	[curr_crit] =		{"curr%u_crit", S_IRUGO|S_IWUGO,
+				curr_crit, value, multi},
+	[curr_average] =	{"curr%u_average", S_IRUGO,
+				curr_average, value, multi},
+	[curr_lowest] =		{"curr%u_lowest", S_IRUGO,
+				curr_lowest, value, multi},
+	[curr_highest] =	{"curr%u_highest", S_IRUGO,
+				curr_highest, value, multi},
+	[curr_reset_history] =	{"curr%u_reset_history", S_IWUGO,
+				curr_reset_history, value, multi},
+	[curr_reset_history_glob] =	{"curr_reset_history", S_IWUGO,
+					curr_reset_history_glob,
+					value, single},
+	[curr_alarm] =		{"curr%u_alarm", S_IRUGO,
+				curr_alarm, value, multi},
+	[curr_min_alarm] =	{"curr%u_min_alarm", S_IRUGO,
+				curr_min_alarm, value, multi},
+	[curr_max_alarm] =	{"curr%u_max_alarm", S_IRUGO,
+				curr_max_alarm, value, multi},
+	[curr_lcrit_alarm] =	{"curr%u_lcrit_alarm", S_IRUGO,
+				curr_lcrit_alarm, value, multi},
+	[curr_crit_alarm] =	{"curr%u_crit_alarm", S_IRUGO,
+				curr_crit_alarm, value, multi},
+	[curr_beep] =		{"curr%u_beep", S_IRUGO|S_IWUGO,
+				curr_beep, value, multi}
+};
+
+static struct caps_info power_caps_info[] = {
+	[power_input] =		{"power%u_input", S_IRUGO,
+				power_input, value, multi},
+	[power_input_lowest] =	{"power%u_input_lowest", S_IRUGO,
+				power_input_lowest, value, multi},
+	[power_input_highest] =	{"power%u_input_highest", S_IRUGO,
+				power_input_highest, value, multi},
+	[power_reset_history] =	{"power%u_reset_history", S_IWUGO,
+				power_reset_history, value, multi},
+	[power_reset_history_glob] =	{"power_reset_history", S_IWUGO,
+					power_reset_history_glob,
+					value, multi},
+	[power_accuracy] =	{"power%u_accuracy", S_IRUGO,
+				power_accuracy, value, multi},
+	[power_average]	=	{"power%u_average", S_IRUGO,
+				power_average, value, multi},
+	[power_average_interval] = {"power%u_average_interval", S_IRUGO|S_IWUGO,
+				   power_average_interval,
+				   value, multi},
+	[power_average_interval_min] = {"power%u_average_interval_min", S_IRUGO,
+				       power_average_min,
+				       value, multi},
+	[power_average_interval_max] = {"power%u_average_interval_max", S_IRUGO,
+				       power_average_max,
+				       value, multi},
+	[power_average_min] =	{"power%u_average_min", S_IRUGO|S_IWUGO,
+				power_average_min, value, multi},
+	[power_average_max] =	{"power%u_average_max", S_IRUGO|S_IWUGO,
+				power_average_max, value, multi},
+	[power_average_lowest] =	{"power%u_average_lowest", S_IRUGO,
+					power_average_lowest,
+					value, multi},
+	[power_average_highest] =	{"power%u_average_highest", S_IRUGO,
+					power_average_highest,
+					value, multi},
+	[power_cap] =		{"power%u_cap", S_IRUGO|S_IWUGO,
+				power_cap, value, multi},
+	[power_cap_hyst] =	{"power%u_cap_hyst", S_IRUGO|S_IWUGO,
+				power_cap_hyst, value, multi},
+	[power_cap_min] =	{"power%u_cap_min", S_IRUGO,
+				power_cap_min, value, multi},
+	[power_cap_max] =	{"power%u_cap_max", S_IRUGO,
+				power_cap_max, value, multi},
+	[power_max] =		{"power%u_max", S_IRUGO|S_IWUGO,
+				power_max, value, multi},
+	[power_crit] =		{"power%u_crit", S_IRUGO|S_IWUGO,
+				power_crit, value, multi},
+	[power_alarm] =		{"power%u_alarm", S_IRUGO,
+				power_alarm, value, multi},
+	[power_cap_alarm] =	{"power%u_cap_alarm", S_IRUGO,
+				power_cap_alarm, value, multi},
+	[power_max_alarm] =	{"power%u_max_alarm", S_IRUGO,
+				power_max_alarm, value, multi},
+	[power_crit_alarm] =	{"power%u_crit_alarm", S_IRUGO,
+				power_crit_alarm, value, multi}
+};
+
+static struct caps_info energy_caps_info[] = {
+	[energy_input] =	{"energy%u_input", S_IRUGO,
+				energy_input, value, multi}
+};
+
+static struct caps_info humidity_caps_info[] = {
+	[humidity_input] =	{"humidity%u_input", S_IRUGO,
+				humidity_input, value, multi}
+};
+
+static struct caps_info intrusion_caps_info[] = {
+	[intrusion_alarm] =	{"intrusion%u_alarm", S_IRUGO|S_IWUGO,
+				intrusion_alarm, value, multi},
+	[intrusion_beep] =	{"intrusion%u_beep", S_IRUGO|S_IWUGO,
+				intrusion_beep, value, multi}
+};
+
+static struct caps_info *caps_lookup[] = {
+	generic_caps_info,
+	in_caps_info,
+	cpu_caps_info,
+	fan_caps_info,
+	pwm_caps_info,
+	temp_caps_info,
+	curr_caps_info,
+	power_caps_info,
+	energy_caps_info,
+	humidity_caps_info,
+	intrusion_caps_info
+};
+
+/* basic building block functions */
+
+#define to_hwmon_device_attr(_sensor_attr) \
+	container_of(_sensor_attr, struct hwmon_device_attribute, sensor_dev)
+
+static ssize_t get_text(struct device *dev,
+			struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev +			dev_get_drvdata(hw_attr->hw_device);
+	return hw_dev->get_text_attr(hw_attr->hw_device, hw_attr->feature,
+			hw_attr->subfeature, attr->index, buf);
+}
+
+static ssize_t get_num(struct device *dev,
+		       struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev +			dev_get_drvdata(hw_attr->hw_device);
+	int value, ret;
+	ret = hw_dev->get_numeric_attr(hw_attr->hw_device, hw_attr->feature,
+			hw_attr->subfeature, attr->index, attr->nr, &value);
+	if (ret)
+		return ret;
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", value);
+	return ret;
+}
+
+static ssize_t set_num(struct device *dev, struct device_attribute *devattr,
+		       const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev +			dev_get_drvdata(hw_attr->hw_device);
+	int ret;
+	long value;
+	if (kstrtol(buf, 10, &value))
+		return -EINVAL;
+	ret = hw_dev->set_numeric_attr(hw_attr->hw_device, hw_attr->feature,
+			hw_attr->subfeature, attr->index, attr->nr, value);
+	if (ret)
+		return ret;
+	return count;
+}
+
+/* functions to build/destroy sysfs */
+static int new_sysfs_entry(const char *name, mode_t mode,
+		enum hwmon_feature feature, u32 subfeature,
+		enum entry_type type, u8 index, u8 nr, struct list_head *list,
+		struct device *dev)
+{
+	struct hwmon_device_attribute *hw_dev_attr;
+	int ret = 0;
+
+	hw_dev_attr = kzalloc(sizeof(struct hwmon_device_attribute),
+			      GFP_KERNEL);
+	if (!hw_dev_attr)
+		return -ENOMEM;
+
+	strlcpy(hw_dev_attr->name, name, HWMON_NAME_SIZE);
+
+	hw_dev_attr->sensor_dev.dev_attr.attr.mode = mode;
+	if (mode && S_IRUGO) {
+		if (type = value)
+			hw_dev_attr->sensor_dev.dev_attr.show = &get_num;
+		else
+			hw_dev_attr->sensor_dev.dev_attr.show = &get_text;
+	}
+	if (mode && S_IWUGO)
+		hw_dev_attr->sensor_dev.dev_attr.store = &set_num;
+
+	hw_dev_attr->sensor_dev.dev_attr.attr.name = hw_dev_attr->name;
+	hw_dev_attr->sensor_dev.index = index;
+	hw_dev_attr->sensor_dev.nr = nr;
+	hw_dev_attr->hw_device = dev;
+	hw_dev_attr->feature = feature;
+	hw_dev_attr->subfeature = subfeature;
+	sysfs_attr_init(&hw_dev_attr->sensor_dev.dev_attr.attr);
+
+	ret = device_create_file(dev->parent,
+				 &hw_dev_attr->sensor_dev.dev_attr);
+	if (ret) {
+		kfree(hw_dev_attr);
+		return ret;
+	}
+
+	list_add(&hw_dev_attr->node, list);
+
+	return 0;
+}
+
+int hwmon_create_sysfs(struct device *dev)
+{
+	struct hwmon_device_instance *hw_dev = dev_get_drvdata(dev);
+	struct hwmon_device_caps *caps = &hw_dev->caps;
+	char attr_name[HWMON_NAME_SIZE];
+	int i, j, k, count;
+	unsigned long bit;
+
+	INIT_LIST_HEAD(&hw_dev->sysfs_node);
+
+	for (i = 0; i < hwmon_feature_size; i++) {
+		if (!caps->num_channels[i])
+			continue;
+
+		for (j = 1; j <= caps->num_channels[i]; j++) {
+			if (!caps->subfeature_caps[i][j-1])
+				continue;
+
+			for_each_set_bit(bit,
+			(long *)&caps->subfeature_caps[i][j-1], 32) {
+				struct caps_info info = caps_lookup[i][bit];
+				if ((info.count = single) && (j > 1))
+					continue;
+
+				if (info.count = trip)
+					count = caps->num_trippoints[i][j-1];
+				else if (info.count = thre)
+					count = caps->num_thresholds[i][j-1];
+				else
+					count = 1;
+
+				for (k = 1; k <= count; k++) {
+					snprintf(attr_name, HWMON_NAME_SIZE,
+						 info.format, j, k);
+
+					if (new_sysfs_entry(attr_name,
+							info.mode, i,
+							info.subfeature,
+							info.type, j, k,
+							&hw_dev->sysfs_node,
+							dev))
+						goto fail;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+fail:
+	hwmon_destroy_sysfs(dev);
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(hwmon_create_sysfs);
+
+void hwmon_destroy_sysfs(struct device *dev)
+{
+	struct hwmon_device_instance *hw_dev = dev_get_drvdata(dev);
+	struct hwmon_device_attribute *hw_dev_attr, *tmp;
+
+	list_for_each_entry_safe(hw_dev_attr, tmp, &hw_dev->sysfs_node, node) {
+		device_remove_file(dev->parent,
+				&hw_dev_attr->sensor_dev.dev_attr);
+		list_del(&hw_dev_attr->node);
+		kfree(hw_dev_attr);
+	}
+}
+EXPORT_SYMBOL_GPL(hwmon_destroy_sysfs);
+
+MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
+MODULE_DESCRIPTION("Hardware monitoring core API");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hwmon-core.h b/include/linux/hwmon-core.h
new file mode 100644
index 0000000..c065d67
--- /dev/null
+++ b/include/linux/hwmon-core.h
@@ -0,0 +1,229 @@
+/**
+ * hwmon-core.h
+ * Copyright (C) 2011 Lucas Stach <dev@lynxeye.de>
+ *
+ * hwmon-core interface definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef HWMON_CORE_H_
+#define HWMON_CORE_H_
+
+int hwmon_create_sysfs(struct device *dev);
+
+void hwmon_destroy_sysfs(struct device *dev);
+
+/*
+ * enum hwmon_feature: used as a lookup into the channel and subfeature array
+ */
+enum hwmon_feature {
+	hwmon_feature_generic,
+	hwmon_feature_in,
+	hwmon_feature_cpu,
+	hwmon_feature_fan,
+	hwmon_feature_pwm,
+	hwmon_feature_temp,
+	hwmon_feature_curr,
+	hwmon_feature_power,
+	hwmon_feature_energy,
+	hwmon_feature_humidity,
+	hwmon_feature_intrusion,
+
+	hwmon_feature_size /* dummy entry */
+};
+
+/*
+ * enums to describe the position of the subfeature caps in their
+ * respective bitfields and for use in the query api
+ */
+enum generic_attr {
+	generic_name,
+	generic_update_interval
+};
+
+enum in_attr {
+	in_input,
+	in_min,
+	in_max,
+	in_lcrit,
+	in_crit,
+	in_average,
+	in_lowest,
+	in_highest,
+	in_reset_history,
+	in_reset_history_glob,
+	in_label,
+	in_alarm,
+	in_min_alarm,
+	in_max_alarm,
+	in_lcrit_alarm,
+	in_crit_alarm,
+	in_vid,
+	in_vrm,
+	in_beep
+};
+
+enum cpu_attr {
+	cpu_vid,
+	cpu_vrm
+};
+
+enum fan_attr {
+	fan_input,
+	fan_min,
+	fan_max,
+	fan_div,
+	fan_pulses,
+	fan_target,
+	fan_label,
+	fan_alarm,
+	fan_beep,
+	fan_fault
+};
+
+enum pwm_attr {
+	pwm_input,
+	pwm_enable,
+	pwm_mode,
+	pwm_freq,
+	pwm_auto_channels_temp,
+	pwm_auto_point_pwm,
+	pwm_auto_point_temp,
+	pwm_auto_point_temp_hyst
+};
+
+enum temp_attr {
+	temp_type,
+	temp_input,
+	temp_min,
+	temp_max,
+	temp_max_hyst,
+	temp_lcrit,
+	temp_crit,
+	temp_crit_hyst,
+	temp_emergency,
+	temp_emergency_hyst,
+	temp_offset,
+	temp_label,
+	temp_lowest,
+	temp_highest,
+	temp_reset_history,
+	temp_reset_history_glob,
+	temp_alarm,
+	temp_min_alarm,
+	temp_max_alarm,
+	temp_lcrit_alarm,
+	temp_crit_alarm,
+	temp_emergency_alarm,
+	temp_beep,
+	temp_fault,
+	temp_auto_point_pwm,
+	temp_auto_point_temp,
+	temp_auto_point_temp_hyst,
+	temp_threshold,
+	temp_threshold_triggered
+};
+
+enum curr_attr {
+	curr_input,
+	curr_min,
+	curr_max,
+	curr_lcrit,
+	curr_crit,
+	curr_average,
+	curr_lowest,
+	curr_highest,
+	curr_reset_history,
+	curr_reset_history_glob,
+	curr_alarm,
+	curr_min_alarm,
+	curr_max_alarm,
+	curr_lcrit_alarm,
+	curr_crit_alarm,
+	curr_beep
+};
+
+enum power_attr {
+	power_input,
+	power_input_lowest,
+	power_input_highest,
+	power_reset_history,
+	power_reset_history_glob,
+	power_accuracy,
+	power_average,
+	power_average_interval,
+	power_average_interval_min,
+	power_average_interval_max,
+	power_average_min,
+	power_average_max,
+	power_average_lowest,
+	power_average_highest,
+	power_cap,
+	power_cap_hyst,
+	power_cap_min,
+	power_cap_max,
+	power_max,
+	power_crit,
+	power_alarm,
+	power_cap_alarm,
+	power_max_alarm,
+	power_crit_alarm
+};
+
+enum energy_attr {
+	energy_input
+};
+
+enum humidity_attr {
+	humidity_input
+};
+
+enum intrusion_attr {
+	intrusion_alarm,
+	intrusion_beep
+};
+
+/* the core interface */
+struct hwmon_device_caps {
+	/*
+	 * number of channels
+	 * (feature to index mapping through enum hwmon_feature)
+	 * a channel count of 0 denotes an unsupported feature
+	 */
+	u8 num_channels[hwmon_feature_size];
+
+	/*
+	 * attach your num_channels[feature] sized arrays of bitfields here
+	 * to indicate subfeature capabilities, a zero bitfield denotes an
+	 * unsupported sensor
+	 */
+	u32 *subfeature_caps[hwmon_feature_size];
+	u8 *num_trippoints[hwmon_feature_size];
+	/* XXX: we have only temp thresholds at this point, so we are wasting a
+	 * few pointers here, but better be future safe
+	 */
+	u8 *num_thresholds[hwmon_feature_size];
+};
+
+struct hwmon_device_instance {
+	struct hwmon_device_caps caps;
+	int (*get_numeric_attr) (struct device *hw_device,
+			enum hwmon_feature feature, u32 subfeature, u8 index,
+			u8 nr, int *value);
+	int (*set_numeric_attr) (struct device *hw_device,
+			enum hwmon_feature feature, u32 subfeature, u8 index,
+			u8 nr, int value);
+	int (*get_text_attr) (struct device *hw_device,
+			enum hwmon_feature feature, u32 subfeature, u8 index,
+			char *buf);
+	struct list_head sysfs_node;
+	void *inst_data;
+};
+
+/* helper function to assist filling the subfeature bitfields */
+#define HWMON_CAP(_cap_enum) (u32)BIT(_cap_enum)
+
+#endif /* HWMON_CORE_H_ */
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
