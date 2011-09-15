From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 15 Sep 2011 20:45:50 +0000
Subject: [lm-sensors] [RFC 1/2] add new hwmon-core interface v2
Message-Id: <1316119550.25490.14.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guenter and others,

I reworked my first proposal of the hwmon-core API and would like to get
some feedback.

After switching to a table based approach, as suggested by Jonathan
Cameron, the actual code is pretty minimal, most of the code are
definitions on how the sysfs has to look like and enums for the
interface. It got a lot cleaner and maintainable this way.

All in all it's about 800 LOC and should enable a noticeable reduction
in code size for drivers using it; quantity could be named after porting
the first drivers.

Please review and give some feedback if you find the time. I want to
bring this forward and port over the adt7475 driver, but first I have to
know if you think the new API has a chance to take off. In a second mail
you will find some stupid dummy driver which shows how to use the new
API.

Thanks,
Lucas
---

This adds a new hwmon-core interface to centralize sysfs handling
and enable cooperation with other in-kernel drivers.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/hwmon/Makefile     |    1 +
 drivers/hwmon/hwmon-core.c |  479 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-core.h |  321 +++++++++++++++++++++++++++++
 3 files changed, 801 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/hwmon-core.c
 create mode 100644 include/linux/hwmon-core.h

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3c9ccef..3d5b395 100644
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
index 0000000..e875d3a
--- /dev/null
+++ b/drivers/hwmon/hwmon-core.c
@@ -0,0 +1,479 @@
+/*
+ * hwmon-core.c
+ * Copyright (C) 2011 Lucas Stach
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
+
+#define HWMON_NAME_SIZE 32
+
+struct hwmon_device_attribute {
+	struct sensor_device_attribute sensor_dev;
+	struct hwmon_device_instance *hw_dev_inst;
+	enum hwmon_attr attr_enum;
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
+	multi
+};
+
+struct caps_info {
+	char *format;
+	mode_t mode;
+	enum hwmon_attr attr;
+	enum entry_type type;
+	enum entry_count count;
+};
+
+/* caps_info structs are used to define how the sysfs interface looks like*/
+
+static struct caps_info generic_caps_info[] = {
+	[generic_name] +		{"name", S_IRUGO, hwmon_attr_generic_name, text, single},
+	[generic_update_interval] +		{"update_interval", S_IRUGO|S_IWUGO, hwmon_attr_generic_update_interval,
+		value, single}
+};
+
+static struct caps_info in_caps_info[] = {
+	[in_input] +		{"in%u_input", S_IRUGO, hwmon_attr_in_input, value, multi},
+	[in_min] +		{"in%u_min", S_IRUGO|S_IWUGO, hwmon_attr_in_min, value, multi},
+	[in_max] +		{"in%u_max", S_IRUGO|S_IWUGO, hwmon_attr_in_max, value, multi},
+	[in_lcrit] +		{"in%u_lcrit", S_IRUGO|S_IWUGO, hwmon_attr_in_lcrit, value, multi},
+	[in_crit] +		{"in%u_crit", S_IRUGO|S_IWUGO,hwmon_attr_in_crit, value, multi},
+	[in_average] +		{"in%u_average", S_IRUGO, hwmon_attr_in_average, value, multi},
+	[in_lowest] +		{"in%u_lowest", S_IRUGO, hwmon_attr_in_lowest, value, multi},
+	[in_highest] +		{"in%u_highest", S_IRUGO, hwmon_attr_in_highest, value, multi},
+	[in_reset_history] +		{"in%u_reset_history", S_IWUGO, hwmon_attr_in_reset_history,
+		value, multi},
+	[in_reset_history_glob] +		{"in_reset_history", S_IWUGO, hwmon_attr_in_reset_history_glob,
+		value, single},
+	[in_label] +		{"in%u_label", S_IRUGO, hwmon_attr_in_label, text, multi},
+	[in_alarm] +		{"in%u_alarm", S_IRUGO, hwmon_attr_in_alarm, value, multi},
+	[in_min_alarm] +		{"in%u_min_alarm", S_IRUGO, hwmon_attr_in_min_alarm, value, multi},
+	[in_max_alarm] +		{"in%u_max_alarm", S_IRUGO, hwmon_attr_in_max_alarm, value, multi},
+	[in_lcrit_alarm] +		{"in%u_lcrit_alarm", S_IRUGO, hwmon_attr_in_lcrit_alarm, value, multi},
+	[in_crit_alarm] +		{"in%u_crit_alarm", S_IRUGO, hwmon_attr_in_crit_alarm, value, multi},
+	[in_vid] +		{"cpu%u_vid", S_IRUGO, hwmon_attr_in_vid, value, multi},
+	[in_vrm] +		{"vrm", S_IRUGO|S_IWUGO, hwmon_attr_in_vrm, value, single},
+	[in_beep] +		{"in%u_beep", S_IRUGO|S_IWUGO, hwmon_attr_in_beep, value, multi}
+};
+
+static struct caps_info fan_caps_info[] = {
+	[fan_input]	+		{"fan%u_input", S_IRUGO, hwmon_attr_fan_input, value, multi},
+	[fan_min] +		{"fan%u_min", S_IRUGO|S_IWUGO, hwmon_attr_fan_min, value, multi},
+	[fan_max] +		{"fan%u_max", S_IRUGO|S_IWUGO, hwmon_attr_fan_max, value, multi},
+	[fan_div] +		{"fan%u_div", S_IRUGO|S_IWUGO, hwmon_attr_fan_div, value, multi},
+	[fan_pulses] +		{"fan%u_pulses", S_IRUGO|S_IWUGO, hwmon_attr_fan_pulses, value, multi},
+	[fan_target] +		{"fan%u_target", S_IRUGO|S_IWUGO, hwmon_attr_fan_target, value, multi},
+	[fan_label]	+		{"fan%u_label", S_IRUGO, hwmon_attr_fan_label, text, multi},
+	[fan_alarm] +		{"fan%u_alarm", S_IRUGO, hwmon_attr_fan_alarm, value, multi},
+	[fan_beep] +		{"fan%u_beep", S_IRUGO|S_IWUGO, hwmon_attr_fan_beep, value, multi},
+	[fan_fault] +		{"fan%u_fault", S_IRUGO, hwmon_attr_fan_fault, value, multi}
+};
+
+static struct caps_info pwm_caps_info[] = {
+	[pwm] +		{"pwm%u", S_IRUGO|S_IWUGO, hwmon_attr_pwm, value, multi},
+	[pwm_enable] +		{"pwm%u_enable", S_IRUGO|S_IWUGO, hwmon_attr_pwm_enable, value, multi},
+	[pwm_mode] +		{"pwm%u_mode", S_IRUGO|S_IWUGO, hwmon_attr_pwm_mode, value, multi},
+	[pwm_freq] +		{"pwm%u_freq", S_IRUGO|S_IWUGO, hwmon_attr_pwm_freq, value, multi},
+	[pwm_auto_channels_temp] +		{"pwm%u_auto_channels_temp", S_IRUGO|S_IWUGO, hwmon_attr_pwm_freq,
+		value, multi}
+};
+
+static struct caps_info temp_caps_info[] = {
+	[temp_type] +		{"temp%u_type,", S_IRUGO|S_IWUGO, hwmon_attr_temp_type, value, multi},
+	[temp_input] +		{"temp%u_input", S_IRUGO, hwmon_attr_temp_input, value, multi},
+	[temp_min] +		{"temp%u_min", S_IRUGO|S_IWUGO, hwmon_attr_temp_min, value, multi},
+	[temp_max] +		{"temp%u_max", S_IRUGO|S_IWUGO, hwmon_attr_temp_max, value, multi},
+	[temp_max_hyst] +		{"temp%u_max_hyst", S_IRUGO|S_IWUGO, hwmon_attr_temp_max_hyst,
+		value, multi},
+	[temp_lcrit] +		{"temp%u_lcrit", S_IRUGO|S_IWUGO, hwmon_attr_temp_lcrit, value, multi},
+	[temp_crit] +		{"temp%u_crit", S_IRUGO|S_IWUGO, hwmon_attr_temp_crit, value, multi},
+	[temp_crit_hyst] +		{"temp%u_crit_hyst", S_IRUGO|S_IWUGO, hwmon_attr_temp_crit_hyst,
+		value, multi},
+	[temp_emergency] +		{"temp%u_emergency", S_IRUGO|S_IWUGO, hwmon_attr_temp_emergency,
+		value, multi},
+	[temp_emergency_hyst] +		{"temp%u_emergency_hyst", S_IRUGO|S_IWUGO,
+		hwmon_attr_temp_emergency_hyst, value, multi},
+	[temp_offset] +		{"temp%u_offset", S_IRUGO|S_IWUGO, hwmon_attr_temp_offset,
+		value, multi},
+	[temp_label] +		{"temp%u_label", S_IRUGO, hwmon_attr_temp_label, text, multi},
+	[temp_lowest] +		{"temp%u_lowest", S_IRUGO, hwmon_attr_temp_lowest, value, multi},
+	[temp_highest] +		{"temp%u_highest", S_IRUGO, hwmon_attr_temp_highest, value, multi},
+	[temp_reset_history] +		{"temp%u_reset_history", S_IWUGO, hwmon_attr_temp_reset_history,
+		value, multi},
+	[temp_reset_history_glob] +		{"temp_reset_history", S_IWUGO, hwmon_attr_temp_reset_history_glob,
+		value, single},
+	[temp_alarm] +		{"temp%u_alarm", S_IRUGO, hwmon_attr_temp_alarm, value, multi},
+	[temp_min_alarm] +		{"temp%u_min_alarm", S_IRUGO, hwmon_attr_temp_min_alarm, value, multi},
+	[temp_max_alarm] +		{"temp%u_max_alarm", S_IRUGO, hwmon_attr_temp_max_alarm, value, multi},
+	[temp_lcrit_alarm] +		{"temp%u_lcrit_alarm", S_IRUGO, hwmon_attr_temp_lcrit_alarm,
+		value, multi},
+	[temp_crit_alarm] +		{"temp%u_crit_alarm", S_IRUGO, hwmon_attr_temp_crit_alarm,
+		value, multi},
+	[temp_emergency_alarm] +		{"temp%u_emergency_alarm", S_IRUGO, hwmon_attr_temp_emergency_alarm,
+		value, multi},
+	[temp_beep] +		{"temp%u_beep", S_IRUGO|S_IWUGO, hwmon_attr_temp_beep, value, multi},
+	[temp_fault] +		{"temp%u_fault", S_IRUGO, hwmon_attr_temp_fault, value, multi}
+};
+
+static struct caps_info curr_caps_info[] = {
+	[curr_input] +		{"curr%u_input", S_IRUGO, hwmon_attr_curr_input, value, multi},
+	[curr_min] +		{"curr%u_min", S_IRUGO|S_IWUGO, hwmon_attr_curr_min, value, multi},
+	[curr_max] +		{"curr%u_max", S_IRUGO|S_IWUGO, hwmon_attr_curr_max, value, multi},
+	[curr_lcrit] +		{"curr%u_lcrit", S_IRUGO|S_IWUGO, hwmon_attr_curr_lcrit, value, multi},
+	[curr_crit] +		{"curr%u_crit", S_IRUGO|S_IWUGO, hwmon_attr_curr_crit, value, multi},
+	[curr_average] +		{"curr%u_average", S_IRUGO, hwmon_attr_curr_average, value, multi},
+	[curr_lowest] +		{"curr%u_lowest", S_IRUGO, hwmon_attr_curr_lowest, value, multi},
+	[curr_highest] +		{"curr%u_highest", S_IRUGO, hwmon_attr_curr_highest, value, multi},
+	[curr_reset_history] +		{"curr%u_reset_history", S_IWUGO, hwmon_attr_curr_reset_history,
+		value, multi},
+	[curr_reset_history_glob] +		{"curr_reset_history", S_IWUGO, hwmon_attr_curr_reset_history_glob,
+		value, single},
+	[curr_alarm] +		{"curr%u_alarm", S_IRUGO, hwmon_attr_curr_alarm, value, multi},
+	[curr_min_alarm] +		{"curr%u_min_alarm", S_IRUGO, hwmon_attr_curr_min_alarm, value, multi},
+	[curr_max_alarm] +		{"curr%u_max_alarm", S_IRUGO, hwmon_attr_curr_max_alarm, value, multi},
+	[curr_lcrit_alarm] +		{"curr%u_lcrit_alarm", S_IRUGO, hwmon_attr_curr_lcrit_alarm,
+		value, multi},
+	[curr_crit_alarm] +		{"curr%u_crit_alarm", S_IRUGO, hwmon_attr_curr_crit_alarm,
+		value, multi},
+	[curr_beep] +		{"curr%u_beep", S_IRUGO|S_IWUGO, hwmon_attr_curr_beep, value, multi}
+};
+
+static struct caps_info power_caps_info[] = {
+	[power_input] +		{"power%u_input", S_IRUGO, hwmon_attr_power_input, value, multi},
+	[power_input_lowest] +		{"power%u_input_lowest", S_IRUGO, hwmon_attr_power_input_lowest,
+		value, multi},
+	[power_input_highest] +		{"power%u_input_highest", S_IRUGO, hwmon_attr_power_input_highest,
+		value, multi},
+	[power_reset_history] +		{"power%u_reset_history", S_IWUGO, hwmon_attr_power_reset_history,
+		value, multi},
+	[power_reset_history_glob] +		{"power_reset_history", S_IWUGO, hwmon_attr_power_reset_history_glob,
+		value, multi},
+	[power_accuracy] +		{"power%u_accuracy", S_IRUGO, hwmon_attr_power_accuracy, value, multi},
+	[power_average]	+		{"power%u_average", S_IRUGO, hwmon_attr_power_average, value, multi},
+	[power_average_interval] +		{"power%u_average_interval", S_IRUGO|S_IWUGO,
+		hwmon_attr_power_average_interval, value, multi},
+	[power_average_interval_min] +		{"power%u_average_interval_min", S_IRUGO, hwmon_attr_power_average_min,
+		value, multi},
+	[power_average_interval_max] +		{"power%u_average_interval_max", S_IRUGO, hwmon_attr_power_average_max,
+		value, multi},
+	[power_average_min] +		{"power%u_average_min", S_IRUGO|S_IWUGO, hwmon_attr_power_average_min,
+		value, multi},
+	[power_average_max] +		{"power%u_average_max", S_IRUGO|S_IWUGO, hwmon_attr_power_average_max,
+		value, multi},
+	[power_average_lowest] +		{"power%u_average_lowest", S_IRUGO, hwmon_attr_power_average_lowest,
+		value, multi},
+	[power_average_highest] +		{"power%u_average_highest", S_IRUGO, hwmon_attr_power_average_highest,
+		value, multi},
+	[power_cap] +		{"power%u_cap", S_IRUGO|S_IWUGO, hwmon_attr_power_cap, value, multi},
+	[power_cap_hyst] +		{"power%u_cap_hyst", S_IRUGO|S_IWUGO, hwmon_attr_power_cap_hyst,
+		value, multi},
+	[power_cap_min] +		{"power%u_cap_min", S_IRUGO, hwmon_attr_power_cap_min, value, multi},
+	[power_cap_max] +		{"power%u_cap_max", S_IRUGO, hwmon_attr_power_cap_max, value, multi},
+	[power_max] +		{"power%u_max", S_IRUGO|S_IWUGO, hwmon_attr_power_max, value, multi},
+	[power_crit] +		{"power%u_crit", S_IRUGO|S_IWUGO, hwmon_attr_power_crit, value, multi},
+	[power_alarm] +		{"power%u_alarm", S_IRUGO, hwmon_attr_power_alarm, value, multi},
+	[power_cap_alarm] +		{"power%u_cap_alarm", S_IRUGO, hwmon_attr_power_cap_alarm,
+		value, multi},
+	[power_max_alarm] +		{"power%u_max_alarm", S_IRUGO, hwmon_attr_power_max_alarm,
+		value, multi},
+	[power_crit_alarm] +		{"power%u_crit_alarm", S_IRUGO, hwmon_attr_power_crit_alarm,
+		value, multi}
+};
+
+static struct caps_info energy_caps_info[] = {
+	[energy_input] +		{"energy%u_input", S_IRUGO, hwmon_attr_energy_input, value, multi}
+};
+
+static struct caps_info humidity_caps_info[] = {
+	[humidity_input] +		{"humidity%u_input", S_IRUGO, hwmon_attr_humidity_input, value, multi}
+};
+
+static struct caps_info intrusion_caps_info[] = {
+	[intrusion_alarm] +		{"intrusion%u_alarm", S_IRUGO|S_IWUGO, hwmon_attr_intrusion_alarm,
+		value, multi},
+	[intrusion_beep] +		{"intrusion%u_beep", S_IRUGO|S_IWUGO, hwmon_attr_intrusion_beep,
+		value, multi}
+};
+
+static struct caps_info *caps_lookup[] = {
+	generic_caps_info,
+	in_caps_info,
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
+                        struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst;
+	return hw_dev->get_text_attr(hw_dev->inst_data,
+                                 hw_attr->attr_enum, attr->index, buf);
+}
+
+static ssize_t get_num(struct device *dev,
+                       struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst;
+	int value, ret;
+	ret = hw_dev->get_numeric_attr(hw_dev->inst_data,
+                                   hw_attr->attr_enum, attr->index, &value);
+	if(ret)
+		return ret;
+	ret = snprintf(buf, PAGE_SIZE, "%u\n", value);
+	return ret;
+}
+
+static ssize_t set_num(struct device *dev, struct device_attribute *devattr,
+                       const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
+	struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst;
+	long value;
+	if(strict_strtol(buf, 10, &value))
+		return -EINVAL;
+	hw_dev->set_numeric_attr(hw_dev->inst_data,
+                             hw_attr->attr_enum, attr->index, value);
+	return count;
+}
+
+/* functions to build/destroy sysfs */
+
+static int new_sysfs_entry(const char *name, mode_t mode, enum hwmon_attr attr,
+		enum entry_type type, int index, struct list_head *list,
+		struct device *dev)
+{
+	struct hwmon_device_attribute *hw_dev_attr;
+	int ret = 0;
+
+	hw_dev_attr = kzalloc(sizeof(struct hwmon_device_attribute), GFP_KERNEL);
+	if(!hw_dev_attr)
+		return -ENOMEM;
+
+	strlcpy(hw_dev_attr->name, name, HWMON_NAME_SIZE);
+
+	hw_dev_attr->sensor_dev.dev_attr.attr.mode = mode;
+	if(mode && S_IRUGO) {
+		if(type = value) {
+			hw_dev_attr->sensor_dev.dev_attr.show = &get_num;
+		} else {
+			hw_dev_attr->sensor_dev.dev_attr.show = &get_text;
+		}
+	}
+	if(mode && S_IWUGO)
+		hw_dev_attr->sensor_dev.dev_attr.store = &set_num;
+
+	hw_dev_attr->sensor_dev.dev_attr.attr.name = hw_dev_attr->name;
+	hw_dev_attr->sensor_dev.index = index;
+	hw_dev_attr->hw_dev_inst = dev_get_drvdata(dev);
+	hw_dev_attr->attr_enum = attr;
+	sysfs_attr_init(&hw_dev_attr->sensor_dev.dev_attr.attr);
+
+	ret = device_create_file(dev->parent, &hw_dev_attr->sensor_dev.dev_attr);
+	if(ret) {
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
+	struct hwmon_device_caps *caps = hw_dev->caps;
+	char attr_name[HWMON_NAME_SIZE];
+	int i, j, count;
+	unsigned long bit;
+
+	INIT_LIST_HEAD(&hw_dev->sysfs_node);
+
+	for(i = 0; i < hwmon_feature_size; i++) {
+		if(!caps->num_channels[i])
+			continue;
+
+		for_each_set_bit(bit, (long *)&caps->subfeature_caps[i], 32) {
+			struct caps_info info = caps_lookup[i][bit];
+			count = (info.count = single) ? 1 : caps->num_channels[i];
+			for(j = 1; j <= count; j++) {
+				snprintf(attr_name, HWMON_NAME_SIZE, info.format, j);
+				if(new_sysfs_entry(attr_name, info.mode, info.attr,
+				info.type, j, &hw_dev->sysfs_node, dev))
+					goto fail;
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
+
+void hwmon_destroy_sysfs(struct device *dev)
+{
+	struct hwmon_device_instance *hw_dev = dev_get_drvdata(dev);
+	struct hwmon_device_attribute *hw_dev_attr, *tmp;
+
+	list_for_each_entry_safe(hw_dev_attr, tmp, &hw_dev->sysfs_node, node) {
+		device_remove_file(dev, &hw_dev_attr->sensor_dev.dev_attr);
+		list_del(&hw_dev_attr->node);
+		kfree(hw_dev_attr);
+	}
+}
+
+EXPORT_SYMBOL_GPL(hwmon_create_sysfs);
+EXPORT_SYMBOL_GPL(hwmon_destroy_sysfs);
+
+MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
+MODULE_DESCRIPTION("Hardware monitoring core API");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hwmon-core.h b/include/linux/hwmon-core.h
new file mode 100644
index 0000000..664f27a
--- /dev/null
+++ b/include/linux/hwmon-core.h
@@ -0,0 +1,321 @@
+/**
+ * hwmon-core.h
+ * Copyright (C) 2011 Lucas Stach
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
+ * enum hwmon_attr: used as central index to get/set attribute functions
+ */
+enum hwmon_attr {
+	hwmon_attr_generic_name,
+	hwmon_attr_generic_update_interval,
+
+	hwmon_attr_in_input,
+	hwmon_attr_in_min,
+	hwmon_attr_in_max,
+	hwmon_attr_in_lcrit,
+	hwmon_attr_in_crit,
+	hwmon_attr_in_average,
+	hwmon_attr_in_lowest,
+	hwmon_attr_in_highest,
+	hwmon_attr_in_reset_history,
+	hwmon_attr_in_reset_history_glob,
+	hwmon_attr_in_label,
+	hwmon_attr_in_alarm,
+	hwmon_attr_in_min_alarm,
+	hwmon_attr_in_max_alarm,
+	hwmon_attr_in_lcrit_alarm,
+	hwmon_attr_in_crit_alarm,
+	hwmon_attr_in_vid,
+	hwmon_attr_in_vrm,
+	hwmon_attr_in_beep,
+
+	hwmon_attr_fan_input,
+	hwmon_attr_fan_min,
+	hwmon_attr_fan_max,
+	hwmon_attr_fan_div,
+	hwmon_attr_fan_pulses,
+	hwmon_attr_fan_target,
+	hwmon_attr_fan_label,
+	hwmon_attr_fan_alarm,
+	hwmon_attr_fan_beep,
+	hwmon_attr_fan_fault,
+
+	hwmon_attr_pwm,
+	hwmon_attr_pwm_enable,
+	hwmon_attr_pwm_mode,
+	hwmon_attr_pwm_freq,
+	hwmon_attr_pwm_auto_channels_temp,
+
+	hwmon_attr_temp_type,
+	hwmon_attr_temp_input,
+	hwmon_attr_temp_min,
+	hwmon_attr_temp_max,
+	hwmon_attr_temp_max_hyst,
+	hwmon_attr_temp_lcrit,
+	hwmon_attr_temp_crit,
+	hwmon_attr_temp_crit_hyst,
+	hwmon_attr_temp_emergency,
+	hwmon_attr_temp_emergency_hyst,
+	hwmon_attr_temp_offset,
+	hwmon_attr_temp_label,
+	hwmon_attr_temp_lowest,
+	hwmon_attr_temp_highest,
+	hwmon_attr_temp_reset_history,
+	hwmon_attr_temp_reset_history_glob,
+	hwmon_attr_temp_alarm,
+	hwmon_attr_temp_min_alarm,
+	hwmon_attr_temp_max_alarm,
+	hwmon_attr_temp_lcrit_alarm,
+	hwmon_attr_temp_crit_alarm,
+	hwmon_attr_temp_emergency_alarm,
+	hwmon_attr_temp_beep,
+	hwmon_attr_temp_fault,
+
+	hwmon_attr_curr_input,
+	hwmon_attr_curr_min,
+	hwmon_attr_curr_max,
+	hwmon_attr_curr_lcrit,
+	hwmon_attr_curr_crit,
+	hwmon_attr_curr_average,
+	hwmon_attr_curr_lowest,
+	hwmon_attr_curr_highest,
+	hwmon_attr_curr_reset_history,
+	hwmon_attr_curr_reset_history_glob,
+	hwmon_attr_curr_alarm,
+	hwmon_attr_curr_min_alarm,
+	hwmon_attr_curr_max_alarm,
+	hwmon_attr_curr_lcrit_alarm,
+	hwmon_attr_curr_crit_alarm,
+	hwmon_attr_curr_beep,
+
+	hwmon_attr_power_input,
+	hwmon_attr_power_input_lowest,
+	hwmon_attr_power_input_highest,
+	hwmon_attr_power_reset_history,
+	hwmon_attr_power_reset_history_glob,
+	hwmon_attr_power_accuracy,
+	hwmon_attr_power_average,
+	hwmon_attr_power_average_interval,
+	hwmon_attr_power_average_interval_min,
+	hwmon_attr_power_average_interval_max,
+	hwmon_attr_power_average_min,
+	hwmon_attr_power_average_max,
+	hwmon_attr_power_average_lowest,
+	hwmon_attr_power_average_highest,
+	hwmon_attr_power_cap,
+	hwmon_attr_power_cap_hyst,
+	hwmon_attr_power_cap_min,
+	hwmon_attr_power_cap_max,
+	hwmon_attr_power_max,
+	hwmon_attr_power_crit,
+	hwmon_attr_power_alarm,
+	hwmon_attr_power_cap_alarm,
+	hwmon_attr_power_max_alarm,
+	hwmon_attr_power_crit_alarm,
+
+	hwmon_attr_energy_input,
+
+	hwmon_attr_humidity_input,
+
+	hwmon_attr_intrusion_alarm,
+	hwmon_attr_intrusion_beep
+};
+
+/*
+ * enum hwmon_feature: used as a lookup into the channel and subfeature array
+ */
+enum hwmon_feature {
+	hwmon_feature_generic,
+	hwmon_feature_in,
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
+ * respective bitfields
+ */
+enum generic_caps {
+	generic_name,
+	generic_update_interval
+};
+
+enum in_caps {
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
+enum fan_caps {
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
+enum pwm_caps {
+	pwm,
+	pwm_enable,
+	pwm_mode,
+	pwm_freq,
+	pwm_auto_channels_temp
+};
+
+enum temp_caps {
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
+	temp_fault
+};
+
+enum curr_caps {
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
+enum power_caps {
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
+enum energy_caps {
+	energy_input
+};
+
+enum humidity_caps {
+	humidity_input
+};
+
+enum intrusion_caps {
+	intrusion_alarm,
+	intrusion_beep
+};
+
+/* the core interface */
+
+struct hwmon_device_caps {
+	/* number of channels (feature to index mapping through enum hwmon_feature)
+	 * a channel count of 0 denotes an unsupported feature
+	 */
+	u8 num_channels[hwmon_feature_size];
+
+	/* array of bitfields to advertise supported subfeatures */
+	u32 subfeature_caps[hwmon_feature_size];
+};
+
+struct hwmon_device_instance {
+	struct hwmon_device_caps *caps;
+	int (*get_numeric_attr) (void * inst_data, enum hwmon_attr attr,
+			unsigned int index, int *value);
+	int (*get_text_attr) (void * inst_data, enum hwmon_attr attr,
+			unsigned int index, char *buf);
+	int (*set_numeric_attr) (void * inst_data, enum hwmon_attr attr,
+			unsigned int index, int value);
+	struct list_head sysfs_node;
+	void *inst_data;
+};
+
+/* helper function to assist filling the subfeature bitfields */
+#define HWMON_CAP(_cap_enum) (u32)BIT(_cap_enum)
+
+#endif /* HWMON_CORE_H_ */
-- 
1.7.6



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
