From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 29 Dec 2008 20:55:37 +0000
Subject: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <20081229205537.GA11072@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I'm once again submitting my driver for ASUS ATK0110 sensor interface,
re-based against kernel v2.6.28. Comments are welcome :)

Asus boards have an ACPI interface for interacting with the hwmon (fan,
temperatures, voltages) subsystem; this driver exposes the relevant
information via the standard sysfs interface.

There are two different ACPI interfaces:
- an old one (based on RVLT/RFAN/RTMP)
- a new one (GGRP/GITM)
Both may be present but there a few cases (my board, sigh) where the
new interface is just an empty stub; the driver defaults to the old one
when both are present.
The old interface has received a considerable testing, but I'm still
awaiting confirmation from my tester that the new one is working as
expected (hence the debug code is still enabled).

Currently all the attributes are read-only, though a (partial) control
should be possible with a bit more work.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

---
 drivers/acpi/namespace/nsutils.c  |    3 
 drivers/acpi/namespace/nsxfeval.c |    3 
 drivers/hwmon/Kconfig             |   12 
 drivers/hwmon/Makefile            |    1 
 drivers/hwmon/asus_atk0110.c      | 1297 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h             |    2 
 6 files changed, 1314 insertions(+), 4 deletions(-)

Index: linux-2.6.git/drivers/acpi/namespace/nsutils.c
=================================--- linux-2.6.git.orig/drivers/acpi/namespace/nsutils.c	2008-12-26 18:59:30.000000000 +0100
+++ linux-2.6.git/drivers/acpi/namespace/nsutils.c	2008-12-26 18:59:38.000000000 +0100
@@ -700,6 +700,7 @@
 
 	return (ACPI_CAST_PTR(struct acpi_namespace_node, handle));
 }
+EXPORT_SYMBOL(acpi_ns_map_handle_to_node);
 
 /*******************************************************************************
  *
@@ -736,6 +737,7 @@
 	return ((acpi_handle) Node);
 ------------------------------------------------------*/
 }
+EXPORT_SYMBOL(acpi_ns_convert_entry_to_handle);
 
 /*******************************************************************************
  *
@@ -875,6 +877,7 @@
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
+EXPORT_SYMBOL(acpi_ns_get_node);
 
 /*******************************************************************************
  *
Index: linux-2.6.git/drivers/acpi/namespace/nsxfeval.c
=================================--- linux-2.6.git.orig/drivers/acpi/namespace/nsxfeval.c	2008-12-26 18:59:30.000000000 +0100
+++ linux-2.6.git/drivers/acpi/namespace/nsxfeval.c	2008-12-26 18:59:38.000000000 +0100
@@ -52,7 +52,6 @@
 /* Local prototypes */
 static void acpi_ns_resolve_references(struct acpi_evaluate_info *info);
 
-#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object_typed
@@ -146,7 +145,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_evaluate_object_typed)
-#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object
Index: linux-2.6.git/include/acpi/acpixf.h
=================================--- linux-2.6.git.orig/include/acpi/acpixf.h	2008-12-26 18:59:30.000000000 +0100
+++ linux-2.6.git/include/acpi/acpixf.h	2008-12-26 18:59:38.000000000 +0100
@@ -169,14 +169,12 @@
 		     struct acpi_object_list *parameter_objects,
 		     struct acpi_buffer *return_object_buffer);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed(acpi_handle object,
 			   acpi_string pathname,
 			   struct acpi_object_list *external_params,
 			   struct acpi_buffer *return_buffer,
 			   acpi_object_type return_type);
-#endif
 
 acpi_status
 acpi_get_object_info(acpi_handle handle, struct acpi_buffer *return_buffer);
Index: linux-2.6.git/drivers/hwmon/asus_atk0110.c
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.git/drivers/hwmon/asus_atk0110.c	2008-12-29 21:46:33.000000000 +0100
@@ -0,0 +1,1297 @@
+/*
+ * Copyright (C) 2007-2009 Luca Tettamanti <kronos.it@gmail.com>
+ *
+ * This file is released under the GPLv2
+ * See COPYING in the top level directory of the kernel tree.
+ */
+
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/hwmon.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+#include <acpi/acpi.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
+
+
+#define ATK_HID "ATK0110"
+#define ATK_DRV "atk-hwmon"
+#define ASOC "_SB.PCI0.SBRG.ASOC"
+
+#define BOARD_ID		"MBIF"
+#define METHOD_ENUMERATE	"GGRP"
+#define METHOD_READ		"GITM"
+#define METHOD_WRITE		"SITM"
+#define METHOD_OLD_READ_TMP	"RTMP"
+#define METHOD_OLD_READ_VLT	"RVLT"
+#define METHOD_OLD_READ_FAN	"RFAN"
+#define METHOD_OLD_ENUM_TMP	"TSIF"
+#define METHOD_OLD_ENUM_VLT	"VSIF"
+#define METHOD_OLD_ENUM_FAN	"FSIF"
+
+#define ATK_MUX_HWMON		0x00000006ULL
+
+#define ATK_CLASS_MASK		0xff000000ULL
+#define ATK_CLASS_FREQ_CTL	0x03000000ULL
+#define ATK_CLASS_FAN_CTL	0x04000000ULL
+#define ATK_CLASS_HWMON		0x06000000ULL
+
+#define ATK_TYPE_MASK		0x00ff0000ULL
+#define HWMON_TYPE_VOLT		0x00020000ULL
+#define HWMON_TYPE_TEMP		0x00030000ULL
+#define HWMON_TYPE_FAN		0x00040000ULL
+
+#define HWMON_SENSORS_ID_MASK	0x0000ffffULL
+
+enum atk_pack_member {
+	HWMON_PACK_FLAGS,
+	HWMON_PACK_NAME,
+	HWMON_PACK_LIMIT1,
+	HWMON_PACK_LIMIT2,
+	HWMON_PACK_ENABLE
+};
+
+/* New package format */
+#define _HWMON_NEW_PACK_SIZE	7
+#define _HWMON_NEW_PACK_FLAGS	0
+#define _HWMON_NEW_PACK_NAME	1
+#define _HWMON_NEW_PACK_UNK1	2
+#define _HWMON_NEW_PACK_UNK2	3
+#define _HWMON_NEW_PACK_LIMIT1	4
+#define _HWMON_NEW_PACK_LIMIT2	5
+#define _HWMON_NEW_PACK_ENABLE	6
+
+/* Old package format */
+#define _HWMON_OLD_PACK_SIZE	5
+#define _HWMON_OLD_PACK_FLAGS	0
+#define _HWMON_OLD_PACK_NAME	1
+#define _HWMON_OLD_PACK_LIMIT1	2
+#define _HWMON_OLD_PACK_LIMIT2	3
+#define _HWMON_OLD_PACK_ENABLE	4
+
+
+struct atk_data {
+	struct device *hwmon_dev;
+	acpi_handle atk_handle;
+	struct acpi_device *acpi_dev;
+
+	bool old_interface;
+
+	/* old interface */
+	acpi_handle rtmp_handle;
+	acpi_handle rvlt_handle;
+	acpi_handle rfan_handle;
+	/* new inteface */
+	acpi_handle enumerate_handle;
+	acpi_handle read_handle;
+
+	struct list_head voltage_list;
+	int voltage_count;
+	struct list_head temperature_list;
+	int temperature_count;
+	struct list_head fan_list;
+	int fan_count;
+};
+
+
+typedef ssize_t (*sysfs_show_func)(struct device *dev,
+			struct device_attribute *attr, char *buf);
+
+typedef ssize_t (*sysfs_store_func)(struct device *dev,
+			struct device_attribute *attr, const char *buf,
+			size_t count);
+
+static const struct acpi_device_id atk_ids[] = {
+	{ATK_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, atk_ids);
+
+#define ATTR_NAME_SIZE 16 /* Worst case is "tempN_input" */
+
+struct atk_sensor_data {
+	struct list_head list;
+	struct atk_data *data;
+	struct device_attribute label_attr;
+	struct device_attribute input_attr;
+	struct device_attribute limit1_attr;
+	struct device_attribute limit2_attr;
+	char label_attr_name[ATTR_NAME_SIZE];
+	char input_attr_name[ATTR_NAME_SIZE];
+	char limit1_attr_name[ATTR_NAME_SIZE];
+	char limit2_attr_name[ATTR_NAME_SIZE];
+	u64 id;
+	u64 limit1;
+	u64 limit2;
+	char const *acpi_name;
+};
+
+struct atk_acpi_buffer_u64 {
+	union acpi_object buf;
+	u64 value;
+};
+
+static int atk_add(struct acpi_device *device);
+static int atk_remove(struct acpi_device *device, int type);
+static void atk_print_sensor(struct atk_data *data, union acpi_object *obj);
+static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value);
+static int atk_read_value_old(struct atk_sensor_data *sensor, int type, u64 *value);
+static void atk_free_sensors(struct atk_data *data);
+
+static struct acpi_driver atk_driver = {
+	.name	= ATK_HID,
+	.class	= "hwmon",
+	.ids	= atk_ids,
+	.ops	= {
+		.add	= atk_add,
+		.remove	= atk_remove,
+	},
+};
+
+#define input_to_atk_sensor(attr) \
+	container_of(attr, struct atk_sensor_data, input_attr)
+
+#define label_to_atk_sensor(attr) \
+	container_of(attr, struct atk_sensor_data, label_attr)
+
+#define limit1_to_atk_sensor(attr) \
+	container_of(attr, struct atk_sensor_data, limit1_attr)
+
+#define limit2_to_atk_sensor(attr) \
+	container_of(attr, struct atk_sensor_data, limit2_attr)
+
+/* Voltages */
+
+static ssize_t atk_volt_input_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = input_to_atk_sensor(attr);
+	u64 voltage;
+	int err;
+
+	if (s->data->old_interface)
+		err = atk_read_value_old(s, HWMON_TYPE_VOLT, &voltage);
+	else
+		err = atk_read_value_new(s, &voltage);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%llu\n", voltage);
+}
+
+static ssize_t atk_volt_label_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = label_to_atk_sensor(attr);
+
+	return sprintf(buf, "%s\n", s->acpi_name);
+}
+
+static ssize_t atk_volt_min_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit1_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit1);
+}
+
+static ssize_t atk_volt_max_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit2_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit2);
+}
+
+/* Temperatures */
+
+static ssize_t atk_temp_input_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = input_to_atk_sensor(attr);
+	u64 temp;
+	ssize_t count;
+	int err;
+
+	if (s->data->old_interface)
+		err = atk_read_value_old(s, HWMON_TYPE_TEMP, &temp);
+	else
+		err = atk_read_value_new(s, &temp);
+	if (err)
+		return err;
+
+	/* ACPI returns decidegree */
+	count = sprintf(buf, "%llu\n", temp * 100);
+
+	return count;
+}
+
+static ssize_t atk_temp_label_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = label_to_atk_sensor(attr);
+
+	return sprintf(buf, "%s\n", s->acpi_name);
+}
+
+static ssize_t atk_temp_max_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit1_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit1 * 100);
+}
+
+static ssize_t atk_temp_crit_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit2_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit2 * 100);
+}
+
+/* Fans */
+
+static ssize_t atk_fan_input_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = input_to_atk_sensor(attr);
+	u64 rot;
+	int err;
+
+	if (s->data->old_interface)
+		err = atk_read_value_old(s, HWMON_TYPE_FAN, &rot);
+	else
+		err = atk_read_value_new(s, &rot);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%llu\n", rot);
+}
+
+static ssize_t atk_fan_label_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = label_to_atk_sensor(attr);
+
+	return sprintf(buf, "%s\n", s->acpi_name);
+}
+
+static ssize_t atk_fan_min_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit1_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit1);
+}
+
+static ssize_t atk_fan_max_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct atk_sensor_data *s = limit2_to_atk_sensor(attr);
+
+	return sprintf(buf, "%lld\n", s->limit2);
+}
+
+static ssize_t atk_name_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "atk0110\n");
+}
+static struct device_attribute atk_name_attr = __ATTR(name, 0444, atk_name_show, NULL);
+
+static void atk_init_attribute(struct device_attribute *attr, char *name,
+		mode_t mode, sysfs_show_func show, sysfs_store_func store)
+{
+	attr->attr.name = name;
+	attr->attr.mode = mode;
+	attr->show = show;
+	attr->store = store;
+}
+
+
+static union acpi_object *atk_get_pack_member(struct atk_data *data,
+						union acpi_object *pack,
+						enum atk_pack_member m)
+{
+	bool old_if = data->old_interface;
+	int offset;
+
+	switch (m) {
+	case HWMON_PACK_FLAGS:
+		offset = old_if ? _HWMON_OLD_PACK_FLAGS : _HWMON_NEW_PACK_FLAGS;
+		break;
+	case HWMON_PACK_NAME:
+		offset = old_if ? _HWMON_OLD_PACK_NAME : _HWMON_NEW_PACK_NAME;
+		break;
+	case HWMON_PACK_LIMIT1:
+		offset = old_if ? _HWMON_OLD_PACK_LIMIT1 : _HWMON_NEW_PACK_LIMIT1;
+		break;
+	case HWMON_PACK_LIMIT2:
+		offset = old_if ? _HWMON_OLD_PACK_LIMIT2 : _HWMON_NEW_PACK_LIMIT2;
+		break;
+	case HWMON_PACK_ENABLE:
+		offset = old_if ? _HWMON_OLD_PACK_ENABLE : _HWMON_NEW_PACK_ENABLE;
+		break;
+	default:
+		return NULL;
+	}
+
+	return &pack->package.elements[offset];
+}
+
+
+/* New package format is:
+ * - flag (int)
+ *	class - used for de-muxing the request to the correct GITn
+ *	type (volt, temp, fan)
+ *	sensor id |
+ *	sensor id - used for de-muxing the request _inside_ the GITn
+ * - name (str)
+ * - unknown (int)
+ * - unknown (int)
+ * - limit1 (int)
+ * - limit2 (int)
+ * - enable (int)
+ *
+ * The old package has the same format but it's missing the two unknown fields.
+ */
+static int validate_hwmon_pack(struct atk_data *data, union acpi_object *obj)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *tmp;
+	bool old_if = data->old_interface;
+	int const expected_size = old_if ? _HWMON_OLD_PACK_SIZE : _HWMON_NEW_PACK_SIZE;
+
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		dev_warn(dev, "Invalid type: %d\n", obj->type);
+		return -EINVAL;
+	}
+
+	if (obj->package.count != expected_size) {
+		dev_warn(dev, "Invalid package size: %d, expected: %d\n",
+				obj->package.count, expected_size);
+		return -EINVAL;
+	}
+
+	tmp = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS);
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (flag): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	tmp = atk_get_pack_member(data, obj, HWMON_PACK_NAME);
+	if (tmp->type != ACPI_TYPE_STRING) {
+		dev_warn(dev, "Invalid type (name): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	/* Don't check... we don't know what they're useful for anyway */
+#if 0
+	tmp = &obj->package.elements[HWMON_PACK_UNK1];
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (unk1): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	tmp = &obj->package.elements[HWMON_PACK_UNK2];
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (unk2): %d\n", tmp->type);
+		return -EINVAL;
+	}
+#endif
+
+	tmp = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (limit1): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	tmp = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (limit2): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	tmp = atk_get_pack_member(data, obj, HWMON_PACK_ENABLE);
+	if (tmp->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "Invalid type (enable): %d\n", tmp->type);
+		return -EINVAL;
+	}
+
+	atk_print_sensor(data, obj);
+
+	return 0;
+}
+
+static char const *atk_sensor_type(union acpi_object *flags)
+{
+	u64 type = flags->integer.value & ATK_TYPE_MASK;
+	char const *what;
+
+	switch (type) {
+	case HWMON_TYPE_VOLT:
+		what = "voltage";
+		break;
+	case HWMON_TYPE_TEMP:
+		what = "temperature";
+		break;
+	case HWMON_TYPE_FAN:
+		what = "fan";
+		break;
+	default:
+		what = "unknown";
+		break;
+	}
+
+	return what;
+}
+
+#ifdef DEBUG
+
+static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *flags;
+	union acpi_object *name;
+	union acpi_object *limit1;
+	union acpi_object *limit2;
+	union acpi_object *enable;
+	char const *what;
+
+	flags = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS);
+	name = atk_get_pack_member(data, obj, HWMON_PACK_NAME);
+	limit1 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
+	limit2 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
+	enable = atk_get_pack_member(data, obj, HWMON_PACK_ENABLE);
+
+	what = atk_sensor_type(flags);
+
+	dev_dbg(dev, "%s: %#llx %s [%llu-%llu] %s\n", what,
+			flags->integer.value,
+			name->string.pointer,
+			limit1->integer.value, limit2->integer.value,
+			enable->integer.value ? "enabled" : "disabled");
+}
+
+#else
+
+static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
+{
+}
+
+#endif
+
+static int atk_read_value_old(struct atk_sensor_data *sensor, int type, u64 *value)
+{
+	struct atk_data *data = sensor->data;
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_object_list params;
+	union acpi_object id;
+	acpi_status status;
+	acpi_handle method;
+
+	switch (type) {
+	case HWMON_TYPE_VOLT:
+		method = data->rvlt_handle;
+		break;
+	case HWMON_TYPE_TEMP:
+		method = data->rtmp_handle;
+		break;
+	case HWMON_TYPE_FAN:
+		method = data->rfan_handle;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	id.type = ACPI_TYPE_INTEGER;
+	id.integer.value = sensor->id;
+
+	params.count = 1;
+	params.pointer = &id;
+
+	status = acpi_evaluate_integer(method, NULL, &params, value);
+	if (status != AE_OK) {
+		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
+				acpi_format_exception(status));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
+{
+	struct atk_data *data = sensor->data;
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_object_list params;
+	struct acpi_buffer ret;
+	union acpi_object id;
+	struct atk_acpi_buffer_u64 tmp;
+	acpi_status status;
+	union acpi_object *o;
+	int i;
+
+	id.type = ACPI_TYPE_INTEGER;
+	id.integer.value = sensor->id;
+
+	params.count = 1;
+	params.pointer = &id;
+
+	tmp.buf.type = ACPI_TYPE_BUFFER;
+	tmp.buf.buffer.pointer = (u8 *)&tmp.value;
+	tmp.buf.buffer.length = sizeof(u64);
+	ret.length = sizeof(tmp);
+	ret.pointer = &tmp;
+
+	status = acpi_evaluate_object_typed(data->read_handle, NULL, &params,
+			&ret, ACPI_TYPE_BUFFER);
+	if (status != AE_OK) {
+		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
+				acpi_format_exception(status));
+		return -EIO;
+	}
+
+	o = ret.pointer;
+	dev_dbg(dev, "type = %d\n", o->type);
+	dev_dbg(dev, "size = %d\n", o->buffer.length);
+
+	for (i = 0; i < o->buffer.length; i++)
+		dev_dbg(dev, "  [%#x] %d\n", (u32)(o->buffer.pointer[i]),
+				(u32)(o->buffer.pointer[i]));
+
+	/* Return buffer format:
+	 * [0-3] "value" is valid flag
+	 * [4-7] value
+	 */
+	if (!(tmp.value & 0xffffffff)) {
+		/* The reading is not valid, possible causes:
+		 * - sensor failure
+		 * - enumeration was FUBAR (and we didn't notice)
+		 */
+		dev_info(dev, "Failure: %#llx\n", tmp.value);
+		return -EIO;
+	}
+
+	*value = (tmp.value & 0xffffffff00000000ULL) >> 32;
+
+	return 0;
+}
+
+
+static int atk_add_voltage(struct atk_data *data, union acpi_object *obj, int cnt)
+{
+	union acpi_object *flags;
+	union acpi_object *name;
+	union acpi_object *limit1;
+	union acpi_object *limit2;
+	union acpi_object *enable;
+	struct atk_sensor_data *sensor;
+	int err;
+
+	enable = atk_get_pack_member(data, obj, HWMON_PACK_ENABLE);
+	if (!enable->integer.value)
+		return 0;
+
+	flags = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS);
+	name = atk_get_pack_member(data, obj, HWMON_PACK_NAME);
+	limit1 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
+	limit2 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
+
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);
+	if (!sensor->acpi_name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&sensor->list);
+	sensor->data = data;
+	sensor->id = flags->integer.value;
+	sensor->limit1 = limit1->integer.value;
+	sensor->limit2 = limit2->integer.value;
+
+	snprintf(sensor->input_attr_name, ATTR_NAME_SIZE,
+			"in%d_input", cnt);
+	atk_init_attribute(&sensor->input_attr,
+			sensor->input_attr_name,
+			0444, atk_volt_input_show, NULL);
+
+	snprintf(sensor->label_attr_name, ATTR_NAME_SIZE,
+			"in%d_label", cnt);
+	atk_init_attribute(&sensor->label_attr,
+			sensor->label_attr_name,
+			0444, atk_volt_label_show, NULL);
+
+	snprintf(sensor->limit1_attr_name, ATTR_NAME_SIZE,
+			"in%d_min", cnt);
+	atk_init_attribute(&sensor->limit1_attr,
+			sensor->limit1_attr_name,
+			0444, atk_volt_min_show, NULL);
+
+	snprintf(sensor->limit2_attr_name, ATTR_NAME_SIZE,
+			"in%d_max", cnt);
+	atk_init_attribute(&sensor->limit2_attr,
+			sensor->limit2_attr_name,
+			0444, atk_volt_max_show, NULL);
+
+	list_add(&sensor->list, &data->voltage_list);
+
+	return 1;
+out:
+	kfree(sensor->acpi_name);
+	kfree(sensor);
+	return err;
+}
+
+static int atk_add_temperature(struct atk_data *data, union acpi_object *obj, int cnt)
+{
+	union acpi_object *flags;
+	union acpi_object *name;
+	union acpi_object *limit1;
+	union acpi_object *limit2;
+	union acpi_object *enable;
+	struct atk_sensor_data *sensor;
+	int err;
+
+	enable = atk_get_pack_member(data, obj, HWMON_PACK_ENABLE);
+	if (!enable->integer.value)
+		return 0;
+
+	flags = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS);
+	name = atk_get_pack_member(data, obj, HWMON_PACK_NAME);
+	limit1 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
+	limit2 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
+
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);
+	if (!sensor->acpi_name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&sensor->list);
+	sensor->data = data;
+	sensor->id = flags->integer.value;
+	sensor->limit1 = limit1->integer.value;
+	sensor->limit2 = limit2->integer.value;
+
+	snprintf(sensor->input_attr_name, ATTR_NAME_SIZE,
+			"temp%d_input", cnt);
+	atk_init_attribute(&sensor->input_attr,
+			sensor->input_attr_name,
+			0444, atk_temp_input_show, NULL);
+
+	snprintf(sensor->label_attr_name, ATTR_NAME_SIZE,
+			"temp%d_label", cnt);
+	atk_init_attribute(&sensor->label_attr,
+			sensor->label_attr_name,
+			0444, atk_temp_label_show, NULL);
+
+	snprintf(sensor->limit1_attr_name, ATTR_NAME_SIZE,
+			"temp%d_max", cnt);
+	atk_init_attribute(&sensor->limit1_attr,
+			sensor->limit1_attr_name,
+			0444, atk_temp_max_show, NULL);
+
+	snprintf(sensor->limit2_attr_name, ATTR_NAME_SIZE,
+			"temp%d_crit", cnt);
+	atk_init_attribute(&sensor->limit2_attr,
+			sensor->limit2_attr_name,
+			0444, atk_temp_crit_show, NULL);
+
+	list_add(&sensor->list, &data->temperature_list);
+
+	return 1;
+out:
+	kfree(sensor->acpi_name);
+	kfree(sensor);
+	return err;
+}
+
+static int atk_add_fan(struct atk_data *data, union acpi_object *obj, int cnt)
+{
+	union acpi_object *flags;
+	union acpi_object *name;
+	union acpi_object *limit1;
+	union acpi_object *limit2;
+	union acpi_object *enable;
+	struct atk_sensor_data *sensor;
+	int err;
+
+	enable = atk_get_pack_member(data, obj, HWMON_PACK_ENABLE);
+	if (!enable->integer.value)
+		return 0;
+
+	flags = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS);
+	name = atk_get_pack_member(data, obj, HWMON_PACK_NAME);
+	limit1 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
+	limit2 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
+
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);
+	if (!sensor->acpi_name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&sensor->list);
+	sensor->data = data;
+	sensor->id = flags->integer.value;
+	sensor->limit1 = limit1->integer.value;
+	sensor->limit2 = limit2->integer.value;
+
+	snprintf(sensor->input_attr_name, ATTR_NAME_SIZE,
+			"fan%d_input", cnt);
+	atk_init_attribute(&sensor->input_attr,
+			sensor->input_attr_name,
+			0444, atk_fan_input_show, NULL);
+
+	snprintf(sensor->label_attr_name, ATTR_NAME_SIZE,
+			"fan%d_label", cnt);
+	atk_init_attribute(&sensor->label_attr,
+			sensor->label_attr_name,
+			0444, atk_fan_label_show, NULL);
+
+	snprintf(sensor->limit1_attr_name, ATTR_NAME_SIZE,
+			"fan%d_min", cnt);
+	atk_init_attribute(&sensor->limit1_attr,
+			sensor->limit1_attr_name,
+			0444, atk_fan_min_show, NULL);
+
+	snprintf(sensor->limit2_attr_name, ATTR_NAME_SIZE,
+			"fan%d_max", cnt);
+	atk_init_attribute(&sensor->limit2_attr,
+			sensor->limit2_attr_name,
+			0444, atk_fan_max_show, NULL);
+
+	list_add(&sensor->list, &data->fan_list);
+
+	return 1;
+out:
+	kfree(sensor->acpi_name);
+	kfree(sensor);
+	return err;
+}
+
+static int atk_add_sensor(struct atk_data *data, union acpi_object *obj, int i)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	unsigned long long type;
+	int ret;
+
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		/* wft is this? */
+		dev_warn(dev, "Unknown type for element %d: (%d)\n",
+				i, obj->type);
+		return -EINVAL;
+	}
+
+	ret = validate_hwmon_pack(data, obj);
+	if (ret)
+		return ret;
+
+	/* Ok, we have a valid hwmon package */
+	type = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS)->integer.value & ATK_TYPE_MASK;
+	dev_dbg(dev, "Sensor %d is valid, type %#llx\n", i, type >> 16);
+
+	switch (type) {
+	case HWMON_TYPE_VOLT:
+		ret = atk_add_voltage(data, obj, data->voltage_count);
+		if (ret > 0)
+			data->voltage_count++;
+		break;
+	case HWMON_TYPE_TEMP:
+		/* temp%d entries are numbered starting from 1 */
+		ret = atk_add_temperature(data, obj, data->temperature_count + 1);
+		if (ret > 0)
+			data->temperature_count++;
+		break;
+	case HWMON_TYPE_FAN:
+		/* fan%d entries are numbered starting from 1 */
+		ret = atk_add_fan(data, obj, data->fan_count + 1);
+		if (ret > 0)
+			data->fan_count++;
+		break;
+	default:
+		dev_warn(dev, "Unknown sensor type: %#llx\n", type);
+		break;
+	}
+
+	return ret;
+}
+
+static int atk_enumerate_old_hwmon(struct atk_data *data)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_buffer buf;
+	union acpi_object *pack;
+	acpi_status status;
+	int i, ret;
+	int count = 0;
+	int num = 0;
+
+	/* Voltages */
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	status = acpi_evaluate_object_typed(data->atk_handle, METHOD_OLD_ENUM_VLT, NULL,
+			&buf, ACPI_TYPE_PACKAGE);
+	if (status != AE_OK) {
+		dev_warn(dev, METHOD_OLD_ENUM_VLT ": ACPI exception: %s\n",
+				acpi_format_exception(status));
+
+		return -ENODEV;
+	}
+
+	pack = buf.pointer;
+	for (i = 1; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+
+		ret = atk_add_sensor(data, obj, num);
+		if (ret > 0)
+			count++;
+		num++;
+	}
+	ACPI_FREE(buf.pointer);
+
+	/* Temperatures */
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	status = acpi_evaluate_object_typed(data->atk_handle, METHOD_OLD_ENUM_TMP, NULL,
+			&buf, ACPI_TYPE_PACKAGE);
+	if (status != AE_OK) {
+		dev_warn(dev, METHOD_OLD_ENUM_TMP ": ACPI exception: %s\n",
+				acpi_format_exception(status));
+
+		ret = -ENODEV;
+		goto cleanup;
+	}
+
+	pack = buf.pointer;
+	for (i = 1; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+
+		ret = atk_add_sensor(data, obj, num);
+		if (ret > 0)
+			count++;
+		num++;
+	}
+	ACPI_FREE(buf.pointer);
+
+	/* Fans */
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	status = acpi_evaluate_object_typed(data->atk_handle, METHOD_OLD_ENUM_FAN, NULL,
+			&buf, ACPI_TYPE_PACKAGE);
+	if (status != AE_OK) {
+		dev_warn(dev, METHOD_OLD_ENUM_FAN ": ACPI exception: %s\n",
+				acpi_format_exception(status));
+
+		ret = -ENODEV;
+		goto cleanup;
+	}
+
+	pack = buf.pointer;
+	for (i = 1; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+
+		ret = atk_add_sensor(data, obj, num);
+		if (ret > 0)
+			count++;
+		num++;
+	}
+	ACPI_FREE(buf.pointer);
+
+	return count;
+cleanup:
+	atk_free_sensors(data);
+	return ret;
+}
+
+static int atk_enumerate_new_hwmon(struct atk_data *data)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_buffer buf;
+	acpi_status ret;
+	struct acpi_object_list params;
+	union acpi_object id;
+	union acpi_object *pack;
+	int err;
+	int i;
+
+	dev_dbg(dev, "Enumerating hwmon sensors\n");
+
+	id.type = ACPI_TYPE_INTEGER;
+	id.integer.value = ATK_MUX_HWMON;
+	params.count = 1;
+	params.pointer = &id;
+
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	ret = acpi_evaluate_object_typed(data->enumerate_handle, NULL, &params,
+			&buf, ACPI_TYPE_PACKAGE);
+	if (ret != AE_OK) {
+		dev_warn(dev, METHOD_ENUMERATE ": ACPI exception: %s\n",
+				acpi_format_exception(ret));
+		return -ENODEV;
+	}
+
+	/* Result must be a package */
+	pack = buf.pointer;
+
+	if (pack->package.count < 1) {
+		dev_dbg(dev, "%s: hwmon package is too small: %d\n", __func__,
+				pack->package.count);
+		err = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+		unsigned long long type;
+
+		if (obj->type != ACPI_TYPE_PACKAGE) {
+			/* wft is this? */
+			dev_warn(dev, "Unknown type for element %d: (%d)\n",
+					i, obj->type);
+			continue;
+		}
+
+		err = validate_hwmon_pack(data, obj);
+		if (err)
+			continue;
+
+		/* Ok, we have a valid hwmon package */
+		type = atk_get_pack_member(data, obj, HWMON_PACK_FLAGS)->integer.value & ATK_TYPE_MASK;
+		dev_dbg(dev, "Sensor %d is valid, type %#llx\n", i, type >> 16);
+
+		switch (type) {
+		case HWMON_TYPE_VOLT:
+			ret = atk_add_voltage(data, obj, data->voltage_count);
+			if (ret > 0)
+				data->voltage_count++;
+			break;
+		case HWMON_TYPE_TEMP:
+			ret = atk_add_temperature(data, obj, data->temperature_count + 1);
+			if (ret > 0)
+				data->temperature_count++;
+			break;
+		case HWMON_TYPE_FAN:
+			ret = atk_add_fan(data, obj, data->fan_count + 1);
+			if (ret > 0)
+				data->fan_count++;
+			break;
+		default:
+			dev_warn(dev, "Unknown sensor type: %#llx\n", type);
+			break;
+		}
+	}
+
+	err = data->voltage_count + data->temperature_count + data->fan_count;
+
+out:
+	ACPI_FREE(buf.pointer);
+	return err;
+}
+
+static int atk_create_file_list(struct atk_data *data, struct list_head *head)
+{
+	struct device *hwmon_dev = data->hwmon_dev;
+	struct atk_sensor_data *s;
+	int ret;
+
+	list_for_each_entry(s, head, list) {
+		ret = device_create_file(hwmon_dev, &s->input_attr);
+		if (ret)
+			return ret;
+		ret = device_create_file(hwmon_dev, &s->label_attr);
+		if (ret)
+			return ret;
+		ret = device_create_file(hwmon_dev, &s->limit1_attr);
+		if (ret)
+			return ret;
+		ret = device_create_file(hwmon_dev, &s->limit2_attr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int atk_create_files(struct atk_data *data)
+{
+	int err;
+
+	err = atk_create_file_list(data, &data->voltage_list);
+	if (err)
+		return err;
+
+	err = atk_create_file_list(data, &data->temperature_list);
+	if (err)
+		return err;
+
+	err = atk_create_file_list(data, &data->fan_list);
+	if (err)
+		return err;
+
+	err = device_create_file(data->hwmon_dev, &atk_name_attr);
+
+	return err;
+}
+
+static void atk_remove_file_list(struct atk_data *data, struct list_head *head)
+{
+	struct device *hwmon_dev = data->hwmon_dev;
+	struct atk_sensor_data *s;
+
+	list_for_each_entry(s, head, list) {
+		device_remove_file(hwmon_dev, &s->input_attr);
+		device_remove_file(hwmon_dev, &s->label_attr);
+		device_remove_file(hwmon_dev, &s->limit1_attr);
+		device_remove_file(hwmon_dev, &s->limit2_attr);
+	}
+}
+
+static void atk_remove_files(struct atk_data *data)
+{
+	atk_remove_file_list(data, &data->voltage_list);
+	atk_remove_file_list(data, &data->temperature_list);
+	atk_remove_file_list(data, &data->fan_list);
+	device_remove_file(data->hwmon_dev, &atk_name_attr);
+}
+
+static void atk_free_sensor_list(struct list_head *head)
+{
+	struct atk_sensor_data *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, head, list) {
+		kfree(s->acpi_name);
+		kfree(s);
+	}
+}
+
+static void atk_free_sensors(struct atk_data *data)
+{
+	atk_free_sensor_list(&data->voltage_list);
+	atk_free_sensor_list(&data->temperature_list);
+	atk_free_sensor_list(&data->fan_list);
+}
+
+static int atk_register_hwmon(struct atk_data *data)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	int err;
+
+	dev_dbg(dev, "registering hwmon device\n");
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);
+
+	dev_dbg(dev, "populating sysfs directory\n");
+	err = atk_create_files(data);
+	if (err)
+		goto remove;
+
+	return 0;
+remove:
+	/* Cleanup the registered files */
+	atk_remove_files(data);
+	hwmon_device_unregister(data->hwmon_dev);
+	return err;
+}
+
+static int atk_check_old_if(struct atk_data *data, struct acpi_namespace_node *ns)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_namespace_node *ret;
+	acpi_status status;
+
+	/* RTMP: read temperature */
+	status = acpi_ns_get_node(ns, METHOD_OLD_READ_TMP, ACPI_NS_NO_UPSEARCH, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_OLD_READ_TMP " not found: %s\n",
+				acpi_format_exception(status));
+		return -ENODEV;
+	}
+	data->rtmp_handle = acpi_ns_convert_entry_to_handle(ret);
+
+	/* RVLT: read voltage */
+	status = acpi_ns_get_node(ns, METHOD_OLD_READ_VLT, ACPI_NS_NO_UPSEARCH, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_OLD_READ_VLT " not found: %s\n",
+				acpi_format_exception(status));
+		return -ENODEV;
+	}
+	data->rvlt_handle = acpi_ns_convert_entry_to_handle(ret);
+
+	/* RFAN: read fan status */
+	status = acpi_ns_get_node(ns, METHOD_OLD_READ_FAN, ACPI_NS_NO_UPSEARCH, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_OLD_READ_FAN " not found: %s\n",
+				acpi_format_exception(status));
+		return -ENODEV;
+	}
+	data->rfan_handle = acpi_ns_convert_entry_to_handle(ret);
+
+	return 0;
+}
+
+static int atk_check_new_if(struct atk_data *data, struct acpi_namespace_node *ns)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_namespace_node *ret;
+	acpi_status status;
+
+	/* Enumeration */
+	status = acpi_ns_get_node(ns, METHOD_ENUMERATE, ACPI_NS_NO_UPSEARCH, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_ENUMERATE " not found\n");
+		return -ENODEV;
+	}
+	data->enumerate_handle = acpi_ns_convert_entry_to_handle(ret);
+
+	/* De-multiplexer (read) */
+	status = acpi_ns_get_node(ns, METHOD_READ, ACPI_NS_NO_UPSEARCH, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_READ " not found\n");
+		return -ENODEV;
+	}
+	data->read_handle = acpi_ns_convert_entry_to_handle(ret);
+
+	return 0;
+}
+
+static int atk_add(struct acpi_device *device)
+{
+	acpi_status ret;
+	int err;
+	struct acpi_buffer buf;
+	union acpi_object *obj;
+	struct acpi_namespace_node *search_ns;
+	struct atk_data *data;
+
+	dev_dbg(&device->dev, "adding...\n");
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->acpi_dev = device;
+	data->atk_handle = device->handle;
+	INIT_LIST_HEAD(&data->voltage_list);
+	INIT_LIST_HEAD(&data->temperature_list);
+	INIT_LIST_HEAD(&data->fan_list);
+
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	ret = acpi_evaluate_object_typed(data->atk_handle, BOARD_ID, NULL,
+			&buf, ACPI_TYPE_PACKAGE);
+	if (ret != AE_OK) {
+		dev_dbg(&device->dev, "atk: method MBIF not found\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	obj = buf.pointer;
+	if (obj->package.count >= 2 &&
+			obj->package.elements[1].type = ACPI_TYPE_STRING) {
+		dev_dbg(&device->dev, "board ID = %s\n",
+				obj->package.elements[1].string.pointer);
+	}
+	ACPI_FREE(buf.pointer);
+
+	/* Check for hwmon methods */
+	search_ns = acpi_ns_map_handle_to_node(device->handle);
+	if (!search_ns) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	/* First check "old" style methods; note that both may be present: in
+	 * this case we stick to the old interface; analysis of multiple DSDTs
+	 * indicates that when both interfaces are present the new one
+	 * (GGRP/GITM) is not functional.
+	 */
+	err = atk_check_old_if(data, search_ns);
+	if (!err) {
+		dev_dbg(&device->dev, "Using old hwmon interface\n");
+		data->old_interface = true;
+	} else {
+		err = atk_check_new_if(data, search_ns);
+		if (err)
+			goto out;
+
+		dev_dbg(&device->dev, "Using new hwmon interface\n");
+		data->old_interface = false;
+	}
+
+	if (data->old_interface)
+		err = atk_enumerate_old_hwmon(data);
+	else
+		err = atk_enumerate_new_hwmon(data);
+	if (err < 0)
+		goto out;
+	if (err = 0) {
+		dev_info(&device->dev, "No usable sensor detected, bailing out\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	err = atk_register_hwmon(data);
+	if (err)
+		goto cleanup;
+
+	device->driver_data = data;
+	return 0;
+cleanup:
+	atk_free_sensors(data);
+out:
+	kfree(data);
+	return err;
+}
+
+static int atk_remove(struct acpi_device *device, int type)
+{
+	struct atk_data *data = device->driver_data;
+	dev_dbg(&device->dev, "removing...\n");
+
+	device->driver_data = NULL;
+
+	atk_remove_files(data);
+	atk_free_sensors(data);
+	hwmon_device_unregister(data->hwmon_dev);
+
+	kfree(data);
+
+	return 0;
+}
+
+int atk0110_init(void)
+{
+	int ret;
+
+	ret = acpi_bus_register_driver(&atk_driver);
+	if (ret)
+		pr_info("atk: acpi_bus_register_driver failed: %d\n", ret);
+
+	return ret;
+}
+
+void atk0110_exit(void)
+{
+	acpi_bus_unregister_driver(&atk_driver);
+}
+
+module_init(atk0110_init);
+module_exit(atk0110_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6.git/drivers/hwmon/Kconfig
=================================--- linux-2.6.git.orig/drivers/hwmon/Kconfig	2008-12-26 18:59:30.000000000 +0100
+++ linux-2.6.git/drivers/hwmon/Kconfig	2008-12-26 18:59:38.000000000 +0100
@@ -238,6 +238,18 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
+config SENSORS_ATK0110
+	tristate "ASUS ATK0110 ACPI hwmon"
+	depends on X86 && ACPI && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the ACPI hardware
+	  monitoring interface found in many ASUS motherboards. This
+	  driver will provide readings of fans, voltages and temperatures
+	  through the system firmware.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus_atk0110.
+
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
Index: linux-2.6.git/drivers/hwmon/Makefile
=================================--- linux-2.6.git.orig/drivers/hwmon/Makefile	2008-12-26 18:59:30.000000000 +0100
+++ linux-2.6.git/drivers/hwmon/Makefile	2008-12-26 18:59:38.000000000 +0100
@@ -30,6 +30,7 @@
 obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
+obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o

Luca
-- 
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
