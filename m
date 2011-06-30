From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 30 Jun 2011 23:44:23 +0000
Subject: [lm-sensors] [RFC 1/2] add new hwmon core interface
Message-Id: <1309477463.18912.27.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From 94262a505a888fdb04cb1f37ffb33e240a58484f Mon Sep 17 00:00:00 2001
From: Lucas Stach <dev@lynxeye.de>
Date: Fri, 1 Jul 2011 00:55:30 +0200
Subject: [PATCH 1/2] hwmon: add hwmon-core interface

This adds an interface to easily access attributes from hwmon drivers and
a way to generically build sysfs entries for supported attributes.
---
 drivers/hwmon/hwmon-core.c |  656 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-core.h |  211 ++++++++++++++
 2 files changed, 867 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/hwmon-core.c
 create mode 100644 include/linux/hwmon-core.h

diff --git a/drivers/hwmon/hwmon-core.c b/drivers/hwmon/hwmon-core.c
new file mode 100644
index 0000000..eb39a45
--- /dev/null
+++ b/drivers/hwmon/hwmon-core.c
@@ -0,0 +1,656 @@
+/*
+ * hwmon-core.c
+ * Copyright (C) 2011 Lucas Stach
+ *
+ * hwmon-core interface implementation
+ *
+ * Provides functions to create/destroy a sysfs interface out of a
+ * hwmon_device_instance.
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
+#define HWMON_NAME_SIZE 32
+
+struct hwmon_device_attribute {
+	struct sensor_device_attribute sensor_dev;
+	struct hwmon_device_instance *hw_dev_inst;
+	char name[HWMON_NAME_SIZE];
+	struct list_head node;
+};
+
+#define to_hwmon_device_attr(_sensor_attr) \
+	container_of(_sensor_attr, struct hwmon_device_attribute, sensor_dev)
+
+#define HWMON_GET_TEXT_ACCESSOR(_name, _enum) \
+	static ssize_t _name(struct device *dev, \
+		struct device_attribute *devattr, char *buf) \
+	{ \
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
+		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
+		return hw_dev->get_text_attr(hw_dev->inst_data, \
+			_enum, attr->index, buf); \
+	}
+
+#define HWMON_GET_NUM_ACCESSOR(_name, _enum) \
+	static ssize_t _name(struct device *dev, \
+		struct device_attribute *devattr, char *buf) \
+	{ \
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
+		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
+		int value, ret; \
+		ret = hw_dev->get_numeric_attr(hw_dev->inst_data, \
+				_enum, attr->index, &value); \
+		if(ret) \
+			return ret; \
+		ret = snprintf(buf, PAGE_SIZE, "%u\n", value); \
+		return ret; \
+	}
+
+#define HWMON_SET_NUM_ACCESSOR(_name, _enum) \
+	static ssize_t _name(struct device *dev, \
+		struct device_attribute *devattr, const char *buf, size_t count) \
+	{ \
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+		struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr); \
+		struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst; \
+		long value; \
+		if(strict_strtol(buf, 10, &value)) \
+			return -EINVAL; \
+		hw_dev->set_numeric_attr(hw_dev->inst_data, \
+			_enum, attr->index, value); \
+		return count; \
+	}
+
+/* accessor functions to route sysfs to hwmon core api */
+
+HWMON_GET_TEXT_ACCESSOR(show_name, hwmon_attr_name)
+HWMON_GET_NUM_ACCESSOR(show_update_interval, hwmon_attr_update_interval)
+
+HWMON_GET_NUM_ACCESSOR(show_in_min, hwmon_attr_volt_min)
+HWMON_SET_NUM_ACCESSOR(set_in_min, hwmon_attr_volt_min)
+HWMON_GET_NUM_ACCESSOR(show_in_lcrit, hwmon_attr_volt_lcrit)
+HWMON_SET_NUM_ACCESSOR(set_in_lcrit, hwmon_attr_volt_lcrit)
+HWMON_GET_NUM_ACCESSOR(show_in_max, hwmon_attr_volt_max)
+HWMON_SET_NUM_ACCESSOR(set_in_max, hwmon_attr_volt_max)
+HWMON_GET_NUM_ACCESSOR(show_in_crit, hwmon_attr_volt_crit)
+HWMON_SET_NUM_ACCESSOR(set_in_crit, hwmon_attr_volt_crit)
+HWMON_GET_NUM_ACCESSOR(show_in_vid, hwmon_attr_volt_vid)
+HWMON_GET_TEXT_ACCESSOR(show_in_label, hwmon_attr_volt_label)
+HWMON_GET_NUM_ACCESSOR(show_in_input, hwmon_attr_volt_input)
+HWMON_GET_NUM_ACCESSOR(show_in_vrm, hwmon_attr_volt_vrm)
+
+HWMON_GET_NUM_ACCESSOR(show_fan_min, hwmon_attr_fan_min)
+HWMON_SET_NUM_ACCESSOR(set_fan_min, hwmon_attr_fan_min)
+HWMON_GET_NUM_ACCESSOR(show_fan_max, hwmon_attr_fan_max)
+HWMON_SET_NUM_ACCESSOR(set_fan_max, hwmon_attr_fan_max)
+HWMON_GET_NUM_ACCESSOR(show_fan_div, hwmon_attr_fan_div)
+HWMON_SET_NUM_ACCESSOR(set_fan_div, hwmon_attr_fan_div)
+HWMON_GET_NUM_ACCESSOR(show_fan_pulses, hwmon_attr_fan_pulses)
+HWMON_SET_NUM_ACCESSOR(set_fan_pulses, hwmon_attr_fan_pulses)
+HWMON_GET_NUM_ACCESSOR(show_fan_target, hwmon_attr_fan_target)
+HWMON_SET_NUM_ACCESSOR(set_fan_target, hwmon_attr_fan_target)
+HWMON_GET_TEXT_ACCESSOR(show_fan_label, hwmon_attr_fan_label)
+HWMON_GET_NUM_ACCESSOR(show_fan_input, hwmon_attr_fan_input)
+
+HWMON_GET_NUM_ACCESSOR(show_pwm, hwmon_attr_pwm)
+HWMON_SET_NUM_ACCESSOR(set_pwm, hwmon_attr_pwm)
+HWMON_GET_NUM_ACCESSOR(show_pwm_enable, hwmon_attr_pwm_enable)
+HWMON_SET_NUM_ACCESSOR(set_pwm_enable, hwmon_attr_pwm_enable)
+HWMON_GET_NUM_ACCESSOR(show_pwm_mode, hwmon_attr_pwm_mode)
+HWMON_SET_NUM_ACCESSOR(set_pwm_mode, hwmon_attr_pwm_mode)
+HWMON_GET_NUM_ACCESSOR(show_pwm_freq, hwmon_attr_pwm_freq)
+HWMON_SET_NUM_ACCESSOR(set_pwm_freq, hwmon_attr_pwm_freq)
+HWMON_GET_NUM_ACCESSOR(show_pwm_auto_ct, hwmon_attr_pwm_auto_channels_temp)
+HWMON_SET_NUM_ACCESSOR(set_pwm_auto_ct, hwmon_attr_pwm_auto_channels_temp)
+
+HWMON_GET_NUM_ACCESSOR(show_temp_input, hwmon_attr_temp_input)
+HWMON_GET_NUM_ACCESSOR(show_temp_type, hwmon_attr_temp_type)
+HWMON_SET_NUM_ACCESSOR(set_temp_type, hwmon_attr_temp_type)
+HWMON_GET_NUM_ACCESSOR(show_temp_max, hwmon_attr_temp_max)
+HWMON_SET_NUM_ACCESSOR(set_temp_max, hwmon_attr_temp_max)
+HWMON_GET_NUM_ACCESSOR(show_temp_min, hwmon_attr_temp_min)
+HWMON_SET_NUM_ACCESSOR(set_temp_min, hwmon_attr_temp_min)
+HWMON_GET_NUM_ACCESSOR(show_temp_max_hyst, hwmon_attr_temp_max_hyst)
+HWMON_SET_NUM_ACCESSOR(set_temp_max_hyst, hwmon_attr_temp_max_hyst)
+HWMON_GET_NUM_ACCESSOR(show_temp_crit, hwmon_attr_temp_crit)
+HWMON_SET_NUM_ACCESSOR(set_temp_crit, hwmon_attr_temp_crit)
+HWMON_GET_NUM_ACCESSOR(show_temp_crit_hyst, hwmon_attr_temp_crit_hyst)
+HWMON_SET_NUM_ACCESSOR(set_temp_crit_hyst, hwmon_attr_temp_crit_hyst)
+HWMON_GET_NUM_ACCESSOR(show_temp_emergency, hwmon_attr_temp_emergency)
+HWMON_SET_NUM_ACCESSOR(set_temp_emergency, hwmon_attr_temp_emergency)
+HWMON_GET_NUM_ACCESSOR(show_temp_emergency_hyst, hwmon_attr_temp_emergency_hyst)
+HWMON_SET_NUM_ACCESSOR(set_temp_emergency_hyst, hwmon_attr_temp_emergency_hyst)
+HWMON_GET_NUM_ACCESSOR(show_temp_lcrit, hwmon_attr_temp_lcrit)
+HWMON_SET_NUM_ACCESSOR(set_temp_lcrit, hwmon_attr_temp_lcrit)
+HWMON_GET_NUM_ACCESSOR(show_temp_offset, hwmon_attr_temp_offset)
+HWMON_SET_NUM_ACCESSOR(set_temp_offset, hwmon_attr_temp_offset)
+HWMON_GET_TEXT_ACCESSOR(show_temp_label, hwmon_attr_temp_label)
+HWMON_GET_NUM_ACCESSOR(show_temp_lowest, hwmon_attr_temp_lowest)
+HWMON_GET_NUM_ACCESSOR(show_temp_highest, hwmon_attr_temp_highest)
+HWMON_SET_NUM_ACCESSOR(set_temp_reset_hist, hwmon_attr_temp_reset_history)
+HWMON_SET_NUM_ACCESSOR(set_temp_reset_hist_glob,
+		hwmon_attr_temp_reset_history_glob)
+
+HWMON_GET_NUM_ACCESSOR(show_curr_max, hwmon_attr_curr_max)
+HWMON_SET_NUM_ACCESSOR(set_curr_max, hwmon_attr_curr_max)
+HWMON_GET_NUM_ACCESSOR(show_curr_min, hwmon_attr_curr_min)
+HWMON_SET_NUM_ACCESSOR(set_curr_min, hwmon_attr_curr_min)
+HWMON_GET_NUM_ACCESSOR(show_curr_lcrit, hwmon_attr_curr_lcrit)
+HWMON_SET_NUM_ACCESSOR(set_curr_lcrit, hwmon_attr_curr_lcrit)
+HWMON_GET_NUM_ACCESSOR(show_curr_crit, hwmon_attr_curr_crit)
+HWMON_SET_NUM_ACCESSOR(set_curr_crit, hwmon_attr_curr_crit)
+HWMON_GET_NUM_ACCESSOR(show_curr_input, hwmon_attr_curr_input)
+
+HWMON_GET_NUM_ACCESSOR(show_pow_average, hwmon_attr_pow_average)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_int, hwmon_attr_pow_average_interval)
+HWMON_SET_NUM_ACCESSOR(set_pow_average_int, hwmon_attr_pow_average_interval)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_int_max,
+		hwmon_attr_pow_average_interval_max)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_int_min,
+		hwmon_attr_pow_average_interval_min)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_highest,
+		hwmon_attr_pow_average_highest)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_lowest,
+		hwmon_attr_pow_average_lowest)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_max, hwmon_attr_pow_average_max)
+HWMON_SET_NUM_ACCESSOR(set_pow_average_max, hwmon_attr_pow_average_max)
+HWMON_GET_NUM_ACCESSOR(show_pow_average_min, hwmon_attr_pow_average_min)
+HWMON_SET_NUM_ACCESSOR(set_pow_average_min, hwmon_attr_pow_average_min)
+HWMON_GET_NUM_ACCESSOR(show_pow_input, hwmon_attr_pow_input)
+HWMON_GET_NUM_ACCESSOR(show_pow_input_highest, hwmon_attr_pow_input_highest)
+HWMON_GET_NUM_ACCESSOR(show_pow_input_lowest, hwmon_attr_pow_input_lowest)
+HWMON_SET_NUM_ACCESSOR(set_pow_reset_history, hwmon_attr_pow_reset_history)
+HWMON_GET_NUM_ACCESSOR(show_pow_accuracy, hwmon_attr_pow_accuracy)
+HWMON_GET_NUM_ACCESSOR(show_pow_cap, hwmon_attr_pow_cap)
+HWMON_SET_NUM_ACCESSOR(set_pow_cap, hwmon_attr_pow_cap)
+HWMON_GET_NUM_ACCESSOR(show_pow_cap_hyst, hwmon_attr_pow_cap_hyst)
+HWMON_SET_NUM_ACCESSOR(set_pow_cap_hyst, hwmon_attr_pow_cap_hyst)
+HWMON_GET_NUM_ACCESSOR(show_pow_cap_max, hwmon_attr_pow_cap_max)
+HWMON_GET_NUM_ACCESSOR(show_pow_cap_min, hwmon_attr_pow_cap_min)
+HWMON_GET_NUM_ACCESSOR(show_pow_max, hwmon_attr_pow_max)
+HWMON_SET_NUM_ACCESSOR(set_pow_max, hwmon_attr_pow_max)
+HWMON_GET_NUM_ACCESSOR(show_pow_crit, hwmon_attr_pow_crit)
+HWMON_SET_NUM_ACCESSOR(set_pow_crit, hwmon_attr_pow_crit)
+
+HWMON_GET_NUM_ACCESSOR(show_energy_input, hwmon_attr_ener_input)
+
+HWMON_GET_NUM_ACCESSOR(show_humidity_input, hwmon_attr_humi_input)
+
+/* functions to build/destroy sysfs entries from given hwmon caps */
+
+static int new_sysfs_entry(const char *name, mode_t mode,
+		ssize_t (*show)(struct device *, struct device_attribute *, char *),
+		ssize_t (*store)(struct device *, struct device_attribute *,
+				const char *, size_t),
+		int index, struct list_head *list, struct device *dev)
+{
+	struct hwmon_device_attribute *hw_dev_attr;
+	int ret = 0;
+
+	hw_dev_attr = kzalloc(sizeof(struct hwmon_device_attribute), GFP_KERNEL);
+	if(!hw_dev_attr)
+		return -ENOMEM;
+
+	strlcpy(hw_dev_attr->name, name, 32);
+
+	hw_dev_attr->sensor_dev.dev_attr.attr.name = hw_dev_attr->name;
+	hw_dev_attr->sensor_dev.dev_attr.attr.mode = mode;
+	hw_dev_attr->sensor_dev.dev_attr.show = show;
+	hw_dev_attr->sensor_dev.dev_attr.store = store;
+	hw_dev_attr->sensor_dev.index = index;
+	hw_dev_attr->hw_dev_inst = dev_get_drvdata(dev);
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
+	struct hwmon_device_caps *caps = &hw_dev->caps;
+	char attr_name[HWMON_NAME_SIZE];
+	int i;
+
+	INIT_LIST_HEAD(&hw_dev->sysfs_node);
+
+	new_sysfs_entry("name", S_IRUGO, &show_name, NULL, 0,
+			&hw_dev->sysfs_node, dev);
+	new_sysfs_entry("update_interval", S_IRUGO, &show_update_interval, NULL, 0,
+			&hw_dev->sysfs_node, dev);
+
+	/* voltage sysfs entries */
+	for(i = 1; i <= caps->num_voltage; i++) {
+		if(caps->volt_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "in%u_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_in_min,
+					&set_in_min, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->volt_lcrit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "in%u_lcrit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_in_lcrit,
+					&set_in_lcrit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->volt_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "in%u_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_in_max,
+					&set_in_max, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->volt_crit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "in%u_crit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_in_crit,
+					&set_in_crit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->volt_vid) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "cpu%u_vid", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_in_vid,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->volt_label) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "in%u_label", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_in_label,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		snprintf(attr_name, HWMON_NAME_SIZE, "in%u_input", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO, &show_in_input,
+				NULL, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+	}
+	if(caps->num_voltage && caps->volt_vrm) {
+		if(new_sysfs_entry("in_vrm", S_IRUGO, &show_in_vrm,
+				NULL, 0, &hw_dev->sysfs_node, dev))
+			goto fail;
+	}
+
+	/* fan sysfs entries */
+	for(i = 1; i <= caps->num_fan; i++) {
+		if(caps->fan_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_fan_min,
+					&set_fan_min, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->fan_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_fan_max,
+					&set_fan_max, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->fan_div) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_div", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_fan_div,
+					&set_fan_div, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->fan_pulses) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_pulses", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_fan_pulses,
+					&set_fan_pulses, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->fan_target) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_target", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_fan_target,
+					&set_fan_target, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->fan_label) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_label", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_fan_label,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		snprintf(attr_name, HWMON_NAME_SIZE, "fan%u_input", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO, &show_fan_input,
+				NULL, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+	}
+
+	/* pwm sysfs entries */
+	for(i = 1; i <= caps->num_pwm; i++) {
+		snprintf(attr_name, HWMON_NAME_SIZE, "pwm%u", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pwm,
+				&set_pwm, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+		snprintf(attr_name, HWMON_NAME_SIZE, "pwm%u_enable", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pwm_enable,
+				&set_pwm_enable, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+		snprintf(attr_name, HWMON_NAME_SIZE, "pwm%u_mode", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pwm_mode,
+				&set_pwm_mode, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+		if(caps->pwm_freq) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "pwm%u_freq", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pwm_freq,
+					&set_pwm_freq, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pwm_auto_channels_temp) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "pwm%u_auto_channels_temp", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pwm_auto_ct,
+					&set_pwm_auto_ct, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+	}
+
+	/* temp sysfs entries */
+	for(i = 1; i <= caps->num_temp; i++) {
+		snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_input", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO, &show_temp_input,
+				NULL, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+		if(caps->temp_type) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_type", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_type,
+					&set_temp_type, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_max,
+					&set_temp_max, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_min,
+					&set_temp_min, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_max_hyst) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_max_hyst", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_max_hyst,
+					&set_temp_max_hyst, i, &hw_dev->sysfs_node, dev))
+					goto fail;
+		}
+		if(caps->temp_crit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_crit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_crit,
+					&set_temp_crit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_crit_hyst) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_crit_hyst", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_temp_crit_hyst, &set_temp_crit_hyst, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_emergency) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_emergency", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_temp_emergency, &set_temp_emergency, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_emergency_hyst) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_emergency_hyst", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_temp_emergency_hyst, &set_temp_emergency_hyst, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_lcrit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_lcrit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_lcrit,
+					&set_temp_lcrit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_offset) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_offset", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_temp_offset,
+					&set_temp_offset, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_label) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_label", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_temp_label,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_lowest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_lowest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_temp_lowest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_highest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_highest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_temp_highest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->temp_reset_history) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "temp%u_reset_history", i);
+			if(new_sysfs_entry(attr_name, S_IWUGO, NULL,
+					&set_temp_reset_hist, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+	}
+	if(caps->num_temp && caps->temp_reset_history) {
+		if(new_sysfs_entry("temp_reset_history", S_IWUGO, NULL,
+				&set_temp_reset_hist_glob, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+	}
+
+	/* current sysfs entries */
+	for(i = 1; i <= caps->num_current; i++) {
+		if(caps->curr_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "curr%u_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_curr_max,
+					&set_curr_max, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->curr_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "curr%u_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_curr_min,
+					&set_curr_min, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->curr_lcrit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "curr%u_lcrit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_curr_lcrit,
+					&set_curr_lcrit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->curr_crit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "curr%u_crit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_curr_crit,
+					&set_curr_crit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		snprintf(attr_name, HWMON_NAME_SIZE, "curr%u_input", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO, &show_curr_input,
+				NULL, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+	}
+
+	/* power sysfs entries */
+	for(i = 1; i <= caps->num_power; i++) {
+		snprintf(attr_name, HWMON_NAME_SIZE, "power%u_input", i);
+		if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_input,
+				NULL, i, &hw_dev->sysfs_node, dev))
+			goto fail;
+		if(caps->pow_average) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_average,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_interval) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average_interval", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_pow_average_int, &set_pow_average_int, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_interval_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE,
+					"power%u_average_interval_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_average_int_max,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_interval_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE,
+					"power%u_average_interval_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_average_int_min,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_highest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average_highest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_average_highest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_lowest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average_lowest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_average_lowest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_pow_average_max, &set_pow_average_max, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_average_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_average_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO,
+					&show_pow_average_min, &set_pow_average_min, i,
+					&hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_input_highest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_input_highest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_input_highest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_input_lowest) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_input_lowest", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_input_lowest,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_reset_history) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_reset_history", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, NULL,
+					&set_pow_reset_history, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_accuracy) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_accuracy", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_accuracy,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_cap) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_cap", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pow_cap,
+					&set_pow_cap, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_cap_hyst) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_cap_hyst", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pow_cap_hyst,
+					&set_pow_cap_hyst, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_cap_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_cap_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_cap_max,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_cap_min) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_cap_min", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_pow_cap_min,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_max) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_max", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pow_max,
+					&set_pow_max, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+		if(caps->pow_crit) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "power%u_crit", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO|S_IWUGO, &show_pow_crit,
+					&set_pow_crit, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+
+		/* energy sysfs entries */
+		for(i = 1; i <= caps->num_energy; i++) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "energy%u_input", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_energy_input,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
+		}
+
+		/* humidity sysfs entries */
+		for(i = 1; i <= caps->num_humidity; i++) {
+			snprintf(attr_name, HWMON_NAME_SIZE, "humidity%u_input", i);
+			if(new_sysfs_entry(attr_name, S_IRUGO, &show_humidity_input,
+					NULL, i, &hw_dev->sysfs_node, dev))
+				goto fail;
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
+MODULE_DESCRIPTION("hardware monitoring core api support");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hwmon-core.h b/include/linux/hwmon-core.h
new file mode 100644
index 0000000..270ad67
--- /dev/null
+++ b/include/linux/hwmon-core.h
@@ -0,0 +1,211 @@
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
+struct hwmon_device;
+
+int hwmon_create_sysfs(struct device *dev);
+
+void hwmon_destroy_sysfs(struct device *dev);
+
+enum hwmon_numeric_attr {
+	hwmon_attr_volt_min,
+	hwmon_attr_volt_lcrit,
+	hwmon_attr_volt_max,
+	hwmon_attr_volt_crit,
+	hwmon_attr_volt_input,
+	hwmon_attr_volt_vid,
+	hwmon_attr_volt_vrm,
+
+	hwmon_attr_fan_min,
+	hwmon_attr_fan_max,
+	hwmon_attr_fan_input,
+	hwmon_attr_fan_div,
+	hwmon_attr_fan_pulses,
+	hwmon_attr_fan_target,
+
+	hwmon_attr_pwm,
+	hwmon_attr_pwm_enable,
+	hwmon_attr_pwm_mode,
+	hwmon_attr_pwm_freq,
+	hwmon_attr_pwm_auto_channels_temp,
+	hwmon_attr_pwm_auto_point_pwm,
+	hwmon_attr_pwm_auto_point_temp,
+	hwmon_attr_pwm_auto_point_temp_hyst,
+
+	hwmon_attr_temp_type,
+	hwmon_attr_temp_max,
+	hwmon_attr_temp_max_hyst,
+	hwmon_attr_temp_min,
+	hwmon_attr_temp_input,
+	hwmon_attr_temp_crit,
+	hwmon_attr_temp_crit_hyst,
+	hwmon_attr_temp_emergency,
+	hwmon_attr_temp_emergency_hyst,
+	hwmon_attr_temp_lcrit,
+	hwmon_attr_temp_offset,
+	hwmon_attr_temp_lowest,
+	hwmon_attr_temp_highest,
+	hwmon_attr_temp_reset_history,
+	hwmon_attr_temp_reset_history_glob,
+	hwmon_attr_temp_auto_point_pwm,
+	hwmon_attr_temp_auto_point_temp,
+	hwmon_attr_temp_auto_point_hyst,
+
+	hwmon_attr_curr_max,
+	hwmon_attr_curr_min,
+	hwmon_attr_curr_lcrit,
+	hwmon_attr_curr_crit,
+	hwmon_attr_curr_input,
+
+	hwmon_attr_pow_average,
+	hwmon_attr_pow_average_interval,
+	hwmon_attr_pow_average_interval_max,
+	hwmon_attr_pow_average_interval_min,
+	hwmon_attr_pow_average_highest,
+	hwmon_attr_pow_average_lowest,
+	hwmon_attr_pow_average_max,
+	hwmon_attr_pow_average_min,
+	hwmon_attr_pow_input,
+	hwmon_attr_pow_input_highest,
+	hwmon_attr_pow_input_lowest,
+	hwmon_attr_pow_reset_history,
+	hwmon_attr_pow_accuracy,
+	hwmon_attr_pow_cap,
+	hwmon_attr_pow_cap_hyst,
+	hwmon_attr_pow_cap_min,
+	hwmon_attr_pow_cap_max,
+	hwmon_attr_pow_max,
+	hwmon_attr_pow_crit,
+
+	hwmon_attr_ener_input,
+
+	hwmon_attr_humi_input,
+
+	hwmon_attr_intr_alarm,
+	hwmon_attr_intr_beep,
+
+	hwmon_attr_beep,
+
+	hwmon_attr_update_interval
+};
+
+enum hwmon_text_attr {
+	hwmon_attr_name,
+	hwmon_attr_volt_label,
+	hwmon_attr_fan_label,
+	hwmon_attr_temp_label,
+};
+
+struct hwmon_device_caps {
+	/* number of inputs */
+	unsigned int num_voltage:4;
+	unsigned int num_fan:4;
+	unsigned int num_pwm:4;
+	unsigned int num_temp:4;
+	unsigned int num_current:4;
+	unsigned int num_power:4;
+	unsigned int num_energy:4;
+	unsigned int num_humidity:4;
+	unsigned int num_intrusion:4;
+
+	unsigned int num_trip_points:4;
+
+	/* voltage caps */
+	unsigned int volt_min:1;
+	unsigned int volt_lcrit:1;
+	unsigned int volt_max:1;
+	unsigned int volt_crit:1;
+	unsigned int volt_label:1;
+	unsigned int volt_vid:1;
+	unsigned int volt_vrm:1;
+
+	/* fan caps */
+	unsigned int fan_min:1;
+	unsigned int fan_max:1;
+	unsigned int fan_div:1;
+	unsigned int fan_pulses:1;
+	unsigned int fan_target:1;
+	unsigned int fan_label:1;
+
+	/* pwm caps */
+	unsigned int pwm_freq:1;
+	unsigned int pwm_auto_channels_temp:1;
+	unsigned int pwm_auto_point_pwm:1;
+	unsigned int pwm_auto_point_temp:1;
+	unsigned int pwm_auto_point_temp_hyst:1;
+
+	/* temp caps */
+	unsigned int temp_type:1;
+	unsigned int temp_min:1;
+	unsigned int temp_max:1;
+	unsigned int temp_max_hyst:1;
+	unsigned int temp_crit:1;
+	unsigned int temp_crit_hyst:1;
+	unsigned int temp_emergency:1;
+	unsigned int temp_emergency_hyst:1;
+	unsigned int temp_lcrit:1;
+	unsigned int temp_offset:1;
+	unsigned int temp_label:1;
+	unsigned int temp_lowest:1;
+	unsigned int temp_highest:1;
+	unsigned int temp_reset_history:1;
+	unsigned int temp_auto_point_pwm:1;
+	unsigned int temp_auto_point_temp:1;
+	unsigned int temp_auto_point_temp_hyst:1;
+
+	/* current caps */
+	unsigned int curr_max:1;
+	unsigned int curr_min:1;
+	unsigned int curr_lcrit:1;
+	unsigned int curr_crit:1;
+
+	/* power caps */
+	unsigned int pow_average:1;
+	unsigned int pow_average_interval:1;
+	unsigned int pow_average_interval_min:1;
+	unsigned int pow_average_interval_max:1;
+	unsigned int pow_average_min:1;
+	unsigned int pow_average_max:1;
+	unsigned int pow_average_lowest:1;
+	unsigned int pow_average_highest:1;
+	unsigned int pow_input_lowest:1;
+	unsigned int pow_input_highest:1;
+	unsigned int pow_reset_history:1;
+	unsigned int pow_accuracy:1;
+	unsigned int pow_cap:1;
+	unsigned int pow_cap_hyst:1;
+	unsigned int pow_cap_min:1;
+	unsigned int pow_cap_max:1;
+	unsigned int pow_max:1;
+	unsigned int pow_crit:1;
+
+	/* alarm caps */
+	unsigned int alarm_channel:1;
+	unsigned int alarm_limit:1;
+};
+
+
+struct hwmon_device_instance {
+	struct hwmon_device_caps caps;
+	int (*get_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
+			unsigned int index, int *value);
+	int (*get_text_attr) (void * inst_data, enum hwmon_text_attr attr,
+			unsigned int index, char *buf);
+	int (*set_numeric_attr) (void * inst_data, enum hwmon_numeric_attr attr,
+			unsigned int index, int value);
+	struct list_head sysfs_node;
+	void *inst_data;
+};
+
+#endif /* HWMON_CORE_H_ */
-- 
1.7.5.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
