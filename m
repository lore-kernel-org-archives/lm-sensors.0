From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 18 Jun 2008 21:26:29 +0000
Subject: Re: [lm-sensors] Asus atk0110 driver
Message-Id: <20080618212629.GA7917@dreamland.darkstar.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Il Mon, Jun 16, 2008 at 09:32:27AM +0200, Jean Delvare ha scritto: 
> Hi Luca,
> 
> On Mon, 2 Jun 2008 01:25:30 +0200, Luca Tettamanti wrote:
> > Hi Thomas,
> > I'm attaching a new version of my driver; I've done some refactoring &
> > cleanup and I should I've addresses all the comments from the last time.
> > 
> > A few reminders:
> > - asus_acpi claims the same ID, so the two are exclusive (but should be ok
> >   since notebooks doesn't have the ACPI hw monitoring stuff)
> > - the driver is read only, i.e. it's not possible to control fan speed
> >   (and other overclocking stuff) though the hw is capable of doing it
> > - I exported a few ACPI functions: acpi_ns_map_handle_to_node,
> >   acpi_ns_convert_entry_to_handle and acpi_ns_get_node for inspecting
> >   ACPI methods and ensure that all the expected stuff is there;
> >   acpi_evaluate_object_typed since it's very handy to let it do the
> >   check on the returned data instead of open-coding it all over the
> >   driver
> 
> Apparently your post was not archived on acpi4asus-user. Can you please
> post your driver again, on the lm-sensors list this time? I'd like it
> to be archived publicly so that we can point users to it and it doesn't
> get lost.

Sure. This is the patch for in-kernel ACPI (diff against vanilla
952f4a0a, somewhere after 2.6.26-rc6):

diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/namespace/nsutils.c
index 64c0398..56e806b 100644
--- a/drivers/acpi/namespace/nsutils.c
+++ b/drivers/acpi/namespace/nsutils.c
@@ -700,6 +700,7 @@ struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle)
 
 	return (ACPI_CAST_PTR(struct acpi_namespace_node, handle));
 }
+EXPORT_SYMBOL(acpi_ns_map_handle_to_node);
 
 /*******************************************************************************
  *
@@ -736,6 +737,7 @@ acpi_handle acpi_ns_convert_entry_to_handle(struct acpi_namespace_node *node)
 	return ((acpi_handle) Node);
 ------------------------------------------------------*/
 }
+EXPORT_SYMBOL(acpi_ns_convert_entry_to_handle);
 
 /*******************************************************************************
  *
@@ -875,6 +877,7 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
+EXPORT_SYMBOL(acpi_ns_get_node);
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index a8d5491..141f9e3 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -48,7 +48,7 @@
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
-#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object_typed
@@ -141,7 +141,7 @@ acpi_evaluate_object_typed(acpi_handle handle,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_evaluate_object_typed)
-#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2c3806e..76372a0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -169,14 +169,12 @@ acpi_evaluate_object(acpi_handle object,
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


The source of the driver is attached (text/plain).

Luca
-- 
Not an editor command: Wq

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atk.c"

/*
 * Copyright (C) 2007 Luca Tettamanti <kronos.it@gmail.com>
 * See COPYING in the top level directory of the kernel tree.
 */

#define DEBUG

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/hwmon.h>

#include <acpi/acpi.h>
#include <acpi/acnamesp.h>
#include <acpi/acpi_drivers.h>
#include <acpi/acpi_bus.h>


#define ATK_HID "ATK0110"
#define ATK_DRV "atk-hwmon"
#define ASOC "_SB.PCI0.SBRG.ASOC"

struct atk_data {
	struct device *dev;
	acpi_handle atk_handle;
	struct acpi_device *acpi_dev;

	acpi_handle rtmp_handle;
	acpi_handle rvlt_handle;
	acpi_handle rfan_handle;
} atk_data;


typedef ssize_t (*sysfs_show_func)(struct device *dev,
			struct device_attribute *attr, char *buf);

typedef ssize_t (*sysfs_store_func)(struct device *dev,
			struct device_attribute *attr, const char *buf,
			size_t count);


static void atk_init_attribute(struct device_attribute *attr, char *name,
		mode_t mode, sysfs_show_func show, sysfs_store_func store)
{
	attr->attr.name = name;
	attr->attr.mode = mode;
	attr->show = show;
	attr->store = store;
}

#define ATTR_NAME_SIZE 16 /* Worst case is "tempN_input" */

enum atk_pack_value_id {
	ATK_PACK_VALUE_MIN = 2,
	ATK_PACK_VALUE_MAX = 3,
};

static int atk_pack_read(char *name, int pack_id,
		enum atk_pack_value_id value_id, unsigned long *out)
{
	struct acpi_buffer ret;
	union acpi_object *id;
	union acpi_object *pack;
	union acpi_object *obj;
	union acpi_object *val;
	acpi_status status;
	int err = 0;
	int i;

	ret.length = ACPI_ALLOCATE_BUFFER;

	status = acpi_evaluate_object_typed(atk_data.atk_handle, name, NULL,
			&ret, ACPI_TYPE_PACKAGE);
	if (status != AE_OK) {
		dev_warn(&atk_data.acpi_dev->dev, "%s: ACPI exception: %s\n",
				__func__, acpi_format_exception(status));
		return -EIO;
	}

	obj = ret.pointer;

	err = -ENOENT;
	for (i = 1; i < obj->package.count; i++) {
		pack = &obj->package.elements[i];
		id = &pack->package.elements[0];
		val = &pack->package.elements[value_id];

		if (pack_id == id->integer.value) {
			*out = val->integer.value;
			err = 0;
			break;
		}
	}

	ACPI_FREE(ret.pointer);

	return err;
}

struct atk_temp {
	struct device_attribute label_attr;
	struct device_attribute input_attr;
	struct device_attribute max_attr;
	struct device_attribute crit_attr;
	char label_attr_name[ATTR_NAME_SIZE];
	char input_attr_name[ATTR_NAME_SIZE];
	char max_attr_name[ATTR_NAME_SIZE];
	char crit_attr_name[ATTR_NAME_SIZE];
	u64 id;
	char *acpi_name;
};

struct atk_temp_list {
	int count;
	struct atk_temp temp[];
};

#define input_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, input_attr)

static ssize_t atk_temp_input_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a = input_to_atk_temp(attr);
	unsigned long temp;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;
	ssize_t count;

	id.type = ACPI_TYPE_INTEGER;
	id.integer.value = a->id;

	params.count = 1;
	params.pointer = &id;

	status = acpi_evaluate_integer(atk_data.rtmp_handle, NULL, &params, &temp);
	if (status != AE_OK) {
		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	/* ACPI returns decidegree */
	count = sprintf(buf, "%lu\n", temp * 100);

	return count;
}

#define label_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, label_attr)

static ssize_t atk_temp_label_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a = label_to_atk_temp(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

#define max_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, max_attr)

static ssize_t atk_temp_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a = max_to_atk_temp(attr);
	unsigned long temp;

	/* Yes, this is correct... tmax is the first value */
	if (atk_pack_read("TSIF", a->id, ATK_PACK_VALUE_MIN, &temp))
		return -EIO;

	return sprintf(buf, "%ld\n", temp * 100);
}

#define crit_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, crit_attr)

static ssize_t atk_temp_crit_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a = crit_to_atk_temp(attr);
	unsigned long temp;

	if (atk_pack_read("TSIF", a->id, ATK_PACK_VALUE_MAX, &temp))
		return -EIO;

	return sprintf(buf, "%ld\n", temp * 100);
}

struct atk_voltage {
	struct device_attribute input_attr;
	struct device_attribute label_attr;
	struct device_attribute min_attr;
	struct device_attribute max_attr;
	char label_attr_name[ATTR_NAME_SIZE];
	char input_attr_name[ATTR_NAME_SIZE];
	char min_attr_name[ATTR_NAME_SIZE];
	char max_attr_name[ATTR_NAME_SIZE];
	u64 id;
	char const *acpi_name;
};

struct atk_voltage_list {
	int count;
	struct atk_voltage voltage[];
};

#define label_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, label_attr)

static ssize_t atk_voltage_label_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a = label_to_atk_voltage(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

#define input_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, input_attr)

static ssize_t atk_voltage_input_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a = input_to_atk_voltage(attr);
	unsigned long voltage;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;

	id.type = ACPI_TYPE_INTEGER;
	id.integer.value = a->id;

	params.count = 1;
	params.pointer = &id;

	status = acpi_evaluate_integer(atk_data.rvlt_handle, NULL, &params, &voltage);
	if (status != AE_OK) {
		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	return sprintf(buf, "%lu\n", voltage);
}

#define max_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, max_attr)

static ssize_t atk_voltage_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a = max_to_atk_voltage(attr);
	unsigned long volt;

	if (atk_pack_read("VSIF", a->id, ATK_PACK_VALUE_MAX, &volt))
		return -EIO;

	return sprintf(buf, "%lu\n", volt);
}

#define min_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, min_attr)

static ssize_t atk_voltage_min_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a = min_to_atk_voltage(attr);
	unsigned long volt;

	if (atk_pack_read("VSIF", a->id, ATK_PACK_VALUE_MIN, &volt))
		return -EIO;

	return sprintf(buf, "%lu\n", volt);
}

struct atk_fan {
	struct device_attribute input_attr;
	struct device_attribute label_attr;
	struct device_attribute min_attr;
	struct device_attribute max_attr;
	char input_attr_name[ATTR_NAME_SIZE];
	char label_attr_name[ATTR_NAME_SIZE];
	char min_attr_name[ATTR_NAME_SIZE];
	char max_attr_name[ATTR_NAME_SIZE];
	u64 id;
	char const *acpi_name;
};

struct atk_fan_list {
	int count;
	struct atk_fan fan[];
};

#define input_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, input_attr)

static ssize_t atk_fan_input_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a = input_to_atk_fan(attr);
	unsigned long rotation;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;

	id.type = ACPI_TYPE_INTEGER;
	id.integer.value = a->id;

	params.count = 1;
	params.pointer = &id;

	status = acpi_evaluate_integer(atk_data.rfan_handle, NULL, &params, &rotation);
	if (status != AE_OK) {
		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	return sprintf(buf, "%lu\n", rotation);
}

#define label_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, label_attr)

static ssize_t atk_fan_label_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a = label_to_atk_fan(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

#define min_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, min_attr)

static ssize_t atk_fan_min_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a = min_to_atk_fan(attr);
	unsigned long rot;
	int err;

	err = atk_pack_read("FSIF", a->id, ATK_PACK_VALUE_MIN, &rot);
	if (err)
		return err;

	return sprintf(buf, "%ld\n", rot);
}

#define max_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, max_attr)

static ssize_t atk_fan_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a = max_to_atk_fan(attr);
	unsigned long rot;

	if (atk_pack_read("FSIF", a->id, ATK_PACK_VALUE_MAX, &rot))
		return -EIO;

	return sprintf(buf, "%ld\n", rot);;
}

static ssize_t atk_name_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	return sprintf(buf, "atk0110-0\n");
}

static struct device_attribute atk_name_attr = __ATTR(name, 0444, atk_name_show, NULL);

struct atk_temp_list *temp_list;
struct atk_voltage_list *voltage_list;
struct atk_fan_list *fan_list;

static int atk_add(struct acpi_device *device);
static int atk_remove(struct acpi_device *device, int type);

static const struct acpi_device_id atk_ids[] = {
	{ATK_HID, 0},
	{"", 0},
};
MODULE_DEVICE_TABLE(acpi, atk_ids);

static struct acpi_driver atk_driver = {
	.name	= ATK_HID,
	.class	= "hwmon",
	.ids	= atk_ids,
	.ops	= {
		.add	= atk_add,
		.remove	= atk_remove,
	},
};

static int atk_create_files(struct device *dev)
{
	int i;
	int ret;

	/* Temperatures */
	for (i = 0; i < temp_list->count; i++) {
		ret = device_create_file(dev, &temp_list->temp[i].input_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &temp_list->temp[i].label_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &temp_list->temp[i].max_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &temp_list->temp[i].crit_attr);
		if (ret)
			return ret;
	}

	/* Voltages */
	for (i = 0; i < voltage_list->count; i++) {
		ret = device_create_file(dev, &voltage_list->voltage[i].input_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &voltage_list->voltage[i].label_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &voltage_list->voltage[i].min_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &voltage_list->voltage[i].max_attr);
		if (ret)
			return ret;
	}

	/* Fans */
	for (i = 0; i < fan_list->count; i++) {
		ret = device_create_file(dev, &fan_list->fan[i].input_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &fan_list->fan[i].label_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &fan_list->fan[i].min_attr);
		if (ret)
			return ret;
		ret = device_create_file(dev, &fan_list->fan[i].max_attr);
		if (ret)
			return ret;
	}

	ret = device_create_file(dev, &atk_name_attr);

	return ret;
}

static void atk_remove_files(struct device *dev)
{
	int i;

	/* Temperatures */
	if (temp_list) {
		for (i = 0; i < temp_list->count; i++) {
			device_remove_file(dev, &temp_list->temp[i].input_attr);
			device_remove_file(dev, &temp_list->temp[i].label_attr);
			kfree(temp_list->temp[i].acpi_name);
			device_remove_file(dev, &temp_list->temp[i].max_attr);
			device_remove_file(dev, &temp_list->temp[i].crit_attr);
		}
	}
	kfree(temp_list);
	temp_list = NULL;

	/* Voltages */
	if (voltage_list) {
		for (i = 0; i < voltage_list->count; i++) {
			device_remove_file(dev, &voltage_list->voltage[i].input_attr);
			device_remove_file(dev, &voltage_list->voltage[i].label_attr);
			kfree(voltage_list->voltage[i].acpi_name);
			device_remove_file(dev, &voltage_list->voltage[i].min_attr);
			device_remove_file(dev, &voltage_list->voltage[i].max_attr);
		}
	}
	kfree(voltage_list);
	voltage_list = NULL;

	/* Fans */
	if (fan_list) {
		for (i = 0; i < fan_list->count; i++) {
			device_remove_file(dev, &fan_list->fan[i].input_attr);
			device_remove_file(dev, &fan_list->fan[i].label_attr);
			kfree(fan_list->fan[i].acpi_name);
			device_remove_file(dev, &fan_list->fan[i].min_attr);
			device_remove_file(dev, &fan_list->fan[i].max_attr);
		}
	}
	kfree(fan_list);
	voltage_list = NULL;

	device_remove_file(dev, &atk_name_attr);
}

static int atk_check_package(struct device *dev, char const *fn, int i,
		union acpi_object *pack)
{
	union acpi_object *obj;

	/* Expected format:
	 *
	 * ACPI_TYPE_INTEGER (id)
	 * ACPI_TYPE_STRING (name)
	 * ACPI_TYPE_INTEGER (min or max)
	 * ACPI_TYPE_INTEGER (max or crit)
	 * ACPI_TYPE_INTEGER (enable)
	 */

	obj = &pack->package.elements[0];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: object %d, int expected (id), got: %d\n",
				fn, i, obj->type);
		return -EINVAL;
	}

	obj = &pack->package.elements[1];
	if (obj->type != ACPI_TYPE_STRING) {
		dev_warn(dev, "%s: object %d, string expected, got: %d\n",
				fn, i, obj->type);
		return -EINVAL;
	}

	obj = &pack->package.elements[2];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: object %d, int expected (l1), got: %d\n",
				fn, i, obj->type);
		return -EINVAL;
	}

	obj = &pack->package.elements[3];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: object %d, int expected (l2), got: %d\n",
				fn, i, obj->type);
		return -EINVAL;
	}

	obj = &pack->package.elements[4];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: object %d, int expected (en), got: %d\n",
				fn, i, obj->type);
		return -EINVAL;
	}

	return 0;
}

static int atk_enumerate_temp(struct acpi_buffer *temp_buf)
{
	struct atk_temp_list *tmp;
	union acpi_object *pack;
	union acpi_object *obj;
	struct device *dev = &atk_data.acpi_dev->dev;
	int i, ret;
	int next;

	/* Result must be a package */
	pack = temp_buf->pointer;

	if (pack->package.count < 1) {
		dev_dbg(dev, "%s: temp package is too small: %d\n", __func__,
				pack->package.count);
		return -EINVAL;
	}

	/* First field is the number of available readings */
	obj = &pack->package.elements[0];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_dbg(dev, "%s: temp package: invalid type for "
				"element 0: %d\n", __func__, obj->type);
		return -EINVAL;
	}

	/* The count may differ in case one or more sensors are disabled */
	if (pack->package.count != obj->integer.value + 1) {
		dev_dbg(dev, "%s: temperature count (%llu) differs "
				"from package count (%u)\n", __func__,
				obj->integer.value, pack->package.count);
	}

	tmp = kzalloc(sizeof(*tmp) + sizeof(*tmp->temp) * obj->integer.value, GFP_KERNEL);
	if (!tmp)
		return -ENOMEM;

	tmp->count = obj->integer.value;
	next = 0;
	for (i = 0; i < pack->package.count - 1; i++) {
		union acpi_object *temp_pack;
		union acpi_object *name;
		union acpi_object *tmax;
		union acpi_object *tcrit;
		union acpi_object *acpi_id;
		union acpi_object *enable;

		temp_pack = &pack->package.elements[i + 1];

		/* object should be a temperature package */
		if (temp_pack->type != ACPI_TYPE_PACKAGE) {
			dev_warn(dev, "%s: invalid type for element %d: %d\n",
					__func__, i, temp_pack->type);
			ret = -EINVAL;
			goto cleanup;
		}

		/* Temperature package:
		 * byte buffer?
		 *   [3]: used by GITM/SITM to locate correct GITx/SITx,
		 *        method, same as the other package (GPID)
		 *   [2]: same as the other package, seems unused in
		 *        GITM/STIM
		 *   [1]: type?
		 *        1: cpu freq?
		 *        2: voltage
		 *        3: temperature
		 *        4: fan
		 *        7: Q-FAN (alarm?)
		 *        8: NOS
		 *   [0]: used by GITx/SITx for demux; selects the
		 *        value stored in ASB1 (PRM0)
		 * description
		 * max
		 * critical
		 * enable
		 */

		if (temp_pack->package.count != 5) {
			dev_dbg(dev, "%s: invalid package count "
					"for object %d: %u\n", __func__,
					i + 1, temp_pack->package.count);
			ret = -EINVAL;
			goto cleanup;
		}

		if (atk_check_package(dev, __func__, i, temp_pack)) {
			ret = -EINVAL;
			goto cleanup;
		}

		acpi_id = &temp_pack->package.elements[0];
		name = &temp_pack->package.elements[1];
		tmax = &temp_pack->package.elements[2];
		tcrit = &temp_pack->package.elements[3];
		enable = &temp_pack->package.elements[4];

		dev_dbg(dev, "temp %d: %#llx %s [%llu-%llu] %s\n", next,
				acpi_id->integer.value,
				name->string.pointer,
				tmax->integer.value, tcrit->integer.value,
				enable->integer.value ? "enabled" : "disabled");

		if (!enable->integer.value) {
			tmp->count--;
			continue;
		}

		tmp->temp[next].id = acpi_id->integer.value;

		snprintf(tmp->temp[next].input_attr_name, ATTR_NAME_SIZE,
				"temp%d_input", next + 1);
		atk_init_attribute(&tmp->temp[next].input_attr,
				tmp->temp[next].input_attr_name,
				0444, atk_temp_input_show, NULL);

		tmp->temp[next].acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);
		snprintf(tmp->temp[next].label_attr_name, ATTR_NAME_SIZE,
				"temp%d_label", next + 1);
		atk_init_attribute(&tmp->temp[next].label_attr,
				tmp->temp[next].label_attr_name,
				0444, atk_temp_label_show, NULL);

		snprintf(tmp->temp[next].max_attr_name, ATTR_NAME_SIZE,
				"temp%d_max", next + 1);
		atk_init_attribute(&tmp->temp[next].max_attr,
				tmp->temp[next].max_attr_name,
				0444, atk_temp_max_show, NULL);

		snprintf(tmp->temp[next].crit_attr_name, ATTR_NAME_SIZE,
				"temp%d_crit", next + 1);
		atk_init_attribute(&tmp->temp[next].crit_attr,
				tmp->temp[next].crit_attr_name,
				0444, atk_temp_crit_show, NULL);

		next++;
	}

	temp_list = tmp;

	return 0;
cleanup:
	for (i = 0; i < tmp->count; i++)
		kfree(tmp->temp[i].acpi_name);
	kfree(tmp);

	return ret;
}

static int atk_enumerate_voltage(struct acpi_buffer *vlt_buf)
{
	struct device *dev = &atk_data.acpi_dev->dev;
	union acpi_object *pack;
	union acpi_object *obj;
	struct atk_voltage_list *vlt;
	int ret, i;
	int next;

	pack = vlt_buf->pointer;

	/* At least one element is expected */
	if (pack->package.count < 1) {
		dev_warn(dev, "%s: voltage pack is too small: %d\n", __func__,
				pack->package.count);
		return -EINVAL;
	}

	/* First field is the number of available readings */
	obj = &pack->package.elements[0];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: voltage pack: invalid type for element 0: %d\n",
				__func__, obj->type);
	}

	/* The count may differ in case one or more sensors are disabled */
	if (obj->integer.value + 1 != pack->package.count) {
		dev_warn(dev, "%s: invalid voltage count %llu (should be %d)\n",
			__func__, obj->integer.value, pack->package.count - 1);
	}

	vlt = kzalloc(sizeof(*vlt) + sizeof(*vlt->voltage) * obj->integer.value, GFP_KERNEL);
	if (!vlt)
		return -ENOMEM;

	vlt->count = obj->integer.value;
	next = 0;
	for (i = 0; i < pack->package.count - 1; i++) {
		union acpi_object *voltage_pack;
		union acpi_object *name;
		union acpi_object *vmax;
		union acpi_object *vmin;
		union acpi_object *acpi_id;
		union acpi_object *enable;

		voltage_pack = &pack->package.elements[i + 1];

		/*  voltage package */
		if (voltage_pack->type != ACPI_TYPE_PACKAGE) {
			dev_warn(dev, "%s: invalid type for element %d: %d\n",
					__func__, i, voltage_pack->type);
			ret = -EINVAL;
			goto cleanup;
		}

		/* Package:
		 * id
		 * description
		 * min
		 * max
		 * enable
		 */

		if (voltage_pack->package.count != 5) {
			dev_warn(dev, "%s: invalid package for object %d: %d\n",
				__func__, i, voltage_pack->package.count);
			ret = -EINVAL;
			goto cleanup;
		}

		if (atk_check_package(dev, __func__, i, voltage_pack)) {
			ret = -EINVAL;
			goto cleanup;
		}

		acpi_id = &voltage_pack->package.elements[0];
		name = &voltage_pack->package.elements[1];
		vmin = &voltage_pack->package.elements[2];
		vmax = &voltage_pack->package.elements[3];
		enable = &voltage_pack->package.elements[4];

		dev_dbg(dev, "voltage %d: %#llx %s [%llu-%llu] %s\n", next,
				acpi_id->integer.value,
				name->string.pointer, vmin->integer.value,
				vmax->integer.value,
				enable->integer.value ? "enabled" : "disbaled");

		if (!enable->integer.value) {
			vlt->count--;
			continue;
		}

		vlt->voltage[next].id = acpi_id->integer.value;
		vlt->voltage[next].acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);

		snprintf(vlt->voltage[next].input_attr_name, ATTR_NAME_SIZE,
				"in%d_input", next);
		atk_init_attribute(&vlt->voltage[next].input_attr,
				vlt->voltage[next].input_attr_name,
				0444, atk_voltage_input_show, NULL);

		snprintf(vlt->voltage[next].label_attr_name, ATTR_NAME_SIZE,
				"in%d_label", next);
		atk_init_attribute(&vlt->voltage[next].label_attr,
				vlt->voltage[next].label_attr_name,
				0444, atk_voltage_label_show, NULL);

		snprintf(vlt->voltage[next].max_attr_name, ATTR_NAME_SIZE,
				"in%d_max", next);
		atk_init_attribute(&vlt->voltage[next].max_attr,
				vlt->voltage[next].max_attr_name,
				0444, atk_voltage_max_show, NULL);

		snprintf(vlt->voltage[next].min_attr_name, ATTR_NAME_SIZE,
				"in%d_min", next);
		atk_init_attribute(&vlt->voltage[next].min_attr,
				vlt->voltage[next].min_attr_name,
				0444, atk_voltage_min_show, NULL);

		next++;
	}

	voltage_list = vlt;

	return 0;

cleanup:
	for (i = 0; i < vlt->count; i++)
		kfree(vlt->voltage[i].acpi_name);
	kfree(vlt);

	return ret;
}

static int atk_enumerate_fan(struct acpi_buffer *fan_buf)
{
	struct device *dev = &atk_data.acpi_dev->dev;
	union acpi_object *pack;
	union acpi_object *obj;
	struct atk_fan_list *fan;
	int ret, i;
	int count, next;

	pack = fan_buf->pointer;

	if (pack->package.count < 1) {
		dev_warn(dev, "%s: fan package is too small: %d\n",
				__func__, pack->package.count);
		return -EINVAL;
	}

	obj = &pack->package.elements[0];
	if (obj->type != ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: fan package: invalid type for element 0: %d\n",
				__func__, obj->type);
		return -EINVAL;
	}

	/* Don't fail, it's not fatal */
	if (obj->integer.value + 1 != pack->package.count) {
		dev_dbg(dev, "%s: invalid fan count? %llu (should be %d)\n",
			__func__, obj->integer.value, pack->package.count - 1);
	}

	count = pack->package.count - 1;

	fan = kzalloc(sizeof(*fan) + sizeof(*fan->fan) * count, GFP_KERNEL);
	if (!fan)
		return -ENOMEM;

	fan->count = count;
	next = 0;
	for (i = 0; i < pack->package.count - 1; i++) {
		union acpi_object *fan_pack;
		union acpi_object *acpi_id;
		union acpi_object *name;
		union acpi_object *fmin;
		union acpi_object *fmax;
		union acpi_object *enable;

		/* fan package */
		fan_pack = &pack->package.elements[i + 1];

		if (fan_pack->type != ACPI_TYPE_PACKAGE) {
			dev_warn(dev, "%s: invalid type type for element %d: %d\n",
					__func__, i + 1, fan_pack->type);
			ret = -EINVAL;
			goto cleanup;
		}

		/* Fan package:
		 * id (usual stuff)
		 * description
		 * min
		 * max
		 * enable bit (disabled = 0, enabled otherwise)
		 */

		if (fan_pack->package.count != 5) {
			dev_warn(dev, "%s: invalid package len for object %d: %d\n",
				__func__, i + 1, fan_pack->package.count);
			ret = -EINVAL;
			goto cleanup;
		}

		if (atk_check_package(dev, __func__, i, fan_pack)) {
			ret = -EINVAL;
			goto cleanup;
		}

		acpi_id = &fan_pack->package.elements[0];
		name = &fan_pack->package.elements[1];
		fmin = &fan_pack->package.elements[2];
		fmax = &fan_pack->package.elements[3];
		enable = &fan_pack->package.elements[4];

		dev_dbg(dev, "fan %d: %#llx %s [%llu-%llu] %s\n", i,
				acpi_id->integer.value, name->string.pointer,
				fmin->integer.value, fmax->integer.value,
				enable->integer.value ? "enabled" : "disabled");

		if (!enable->integer.value) {
			fan->count--;
			continue;
		}

		fan->fan[next].id = acpi_id->integer.value;
		fan->fan[next].acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);

		snprintf(fan->fan[next].input_attr_name, ATTR_NAME_SIZE,
				"fan%d_input", next + 1);
		atk_init_attribute(&fan->fan[next].input_attr,
				fan->fan[next].input_attr_name,
				0444, atk_fan_input_show, NULL);

		snprintf(fan->fan[next].label_attr_name, ATTR_NAME_SIZE,
				"fan%d_label", next + 1);
		atk_init_attribute(&fan->fan[next].label_attr,
				fan->fan[next].label_attr_name,
				0444, atk_fan_label_show, NULL);

		snprintf(fan->fan[next].min_attr_name, ATTR_NAME_SIZE,
				"fan%d_min", next + 1);
		atk_init_attribute(&fan->fan[next].min_attr,
				fan->fan[next].min_attr_name,
				0444, atk_fan_min_show, NULL);

		snprintf(fan->fan[next].max_attr_name, ATTR_NAME_SIZE,
				"fan%d_max", next + 1);
		atk_init_attribute(&fan->fan[next].max_attr,
				fan->fan[next].max_attr_name,
				0444, atk_fan_max_show, NULL);

		next++;
	}

	fan_list = fan;

	return 0;
cleanup:
	for (i = 0; i < fan->count; i++)
		kfree(fan->fan[i].acpi_name);
	kfree(fan);

	return ret;
}

static int atk_add(struct acpi_device *device)
{
	acpi_status ret;
	int err, i;
	struct acpi_buffer buf;
	union acpi_object *obj;
	struct acpi_namespace_node *search_ns;
	struct acpi_namespace_node *ns;

	dev_dbg(&device->dev, "atk: adding...\n");

	atk_data.acpi_dev = device;
	atk_data.atk_handle = device->handle;

	buf.length = ACPI_ALLOCATE_BUFFER;
	ret = acpi_evaluate_object_typed(atk_data.atk_handle, "MBIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret != AE_OK) {
		dev_dbg(&device->dev, "atk: method MBIF not found\n");
		return -ENODEV;
	}

	obj = buf.pointer;
	if (obj->package.count >= 2 &&
			obj->package.elements[1].type == ACPI_TYPE_STRING) {
		dev_dbg(&device->dev, "board ID = %s\n",
				obj->package.elements[1].string.pointer);
	}
	ACPI_FREE(buf.pointer);

	/* Check for hwmon methods */
	search_ns = acpi_ns_map_handle_to_node(device->handle);
	if (!search_ns)
		return -ENODEV;

	/* RTMP: read temperature */
	ret = acpi_ns_get_node(search_ns, "RTMP", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret != AE_OK) {
		dev_dbg(&device->dev, "method RTMP not found\n");
		return -ENODEV;
	}
	atk_data.rtmp_handle = acpi_ns_convert_entry_to_handle(ns);

	/* RVLT: read voltage */
	ret = acpi_ns_get_node(search_ns, "RVLT", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret != AE_OK) {
		dev_dbg(&device->dev, "method RVLT not found\n");
		return -ENODEV;
	}
	atk_data.rvlt_handle = acpi_ns_convert_entry_to_handle(ns);

	/* RFAN: read fan status */
	ret = acpi_ns_get_node(search_ns, "RFAN", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret != AE_OK) {
		dev_dbg(&device->dev, "method RFAN not found\n");
		return -ENODEV;
	}
	atk_data.rfan_handle = acpi_ns_convert_entry_to_handle(ns);

	/* Enumerate temp data - TSIF */
	buf.length = ACPI_ALLOCATE_BUFFER;
	ret = acpi_evaluate_object_typed(atk_data.atk_handle, "TSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret != AE_OK) {
		dev_warn(&device->dev, "TSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));
		return -ENODEV;
	}

	err = atk_enumerate_temp(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		return err;

	/* Enumerate voltage data - VSIF */
	buf.length = ACPI_ALLOCATE_BUFFER;
	ret = acpi_evaluate_object_typed(atk_data.atk_handle, "VSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret != AE_OK) {
		dev_warn(&device->dev, "VSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));

		err = -ENODEV;
		goto cleanup;
	}

	err = atk_enumerate_voltage(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		goto cleanup;

	/* Enumerate fan data - FSIF */
	buf.length = ACPI_ALLOCATE_BUFFER;
	ret = acpi_evaluate_object_typed(atk_data.atk_handle, "FSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret != AE_OK) {
		dev_warn(&device->dev, "TSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));

		err = -ENODEV;
		goto cleanup;
	}

	err = atk_enumerate_fan(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		goto cleanup;

	dev_dbg(&atk_data.acpi_dev->dev, "registering hwmon device\n");
	atk_data.dev = hwmon_device_register(&atk_data.acpi_dev->dev);
	if (IS_ERR(atk_data.dev)) {
		err = PTR_ERR(atk_data.dev);
		goto cleanup;
	}

	dev_dbg(&atk_data.acpi_dev->dev, "populating sysfs directory\n");
	err = atk_create_files(&atk_data.acpi_dev->dev);
	if (err)
		goto remove;

	acpi_driver_data(device) = &atk_data;

	return 0;
remove:
	atk_remove_files(&atk_data.acpi_dev->dev);
	hwmon_device_unregister(atk_data.dev);

	return err;
cleanup:
	if (temp_list) {
		for (i = 0; i < temp_list->count; i++)
			kfree(temp_list->temp[i].acpi_name);
	}
	kfree(temp_list);

	if (voltage_list) {
		for (i = 0; i < voltage_list->count; i++)
			kfree(voltage_list->voltage[i].acpi_name);
	}
	kfree(voltage_list);

	if (fan_list) {
		for (i = 0; i < fan_list->count; i++)
			kfree(fan_list->fan[i].acpi_name);
	}
	kfree(fan_list);

	temp_list = NULL;
	voltage_list = NULL;
	fan_list = NULL;

	return err;
}

static int atk_remove(struct acpi_device *device, int type)
{
	dev_dbg(&device->dev, "removing...\n");

	acpi_driver_data(device) = NULL;

	hwmon_device_unregister(atk_data.dev);
	atk_remove_files(&atk_data.acpi_dev->dev);

	return 0;
}

int atk_init(void)
{
	int ret;

	ret = acpi_bus_register_driver(&atk_driver);
	if (ret)
		pr_info("atk: acpi_bus_register_driver failed: %d\n", ret);

	return ret;
}

void atk_exit(void)
{
	acpi_bus_unregister_driver(&atk_driver);
}

module_init(atk_init);
module_exit(atk_exit);

MODULE_LICENSE("GPL");

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--W/nzBZO5zC0uMSeA--
