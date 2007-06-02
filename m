From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sat, 02 Jun 2007 22:28:29 +0000
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Message-Id: <20070602222829.GA11893@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070513223329.GA29207@dreamland.darkstar.lan> <46520F36.4080006@assembler.cz> <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com> <46528B6F.3050701@assembler.cz>
In-Reply-To: <46528B6F.3050701@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Il Tue, May 22, 2007 at 08:19:27AM +0200, Rudolf Marek ha scritto:=20
> Hi,
>=20
> I have following readings:
>=20
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.52 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:      +12.30 V  (min =3D +13.46 V, max =3D +13.04 V) ALARM
> AVCC:      +3.36 V  (min =3D  +4.08 V, max =3D  +3.95 V) ALARM
> 3VCC:      +3.36 V  (min =3D  +4.05 V, max =3D  +3.06 V) ALARM
> in4:       +2.04 V  (min =3D  +1.78 V, max =3D  +2.04 V)
> in5:       +1.60 V  (min =3D  +2.04 V, max =3D  +2.02 V) ALARM
> in6:       +5.12 V  (min =3D  +6.12 V, max =3D  +6.53 V) ALARM
> VSB:       +3.36 V  (min =3D  +4.08 V, max =3D  +4.08 V) ALARM
> VBAT:      +3.30 V  (min =3D  +4.08 V, max =3D  +3.04 V) ALARM
> in9:       +1.65 V  (min =3D  +0.98 V, max =3D  +2.04 V)
> Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 8)
> CPU Fan:  1638 RPM  (min =3D    0 RPM, div =3D 4)
> Aux Fan:  1436 RPM  (min =3D 4272 RPM, div =3D 4) ALARM
> fan5:        0 RPM  (min =3D    0 RPM, div =3D 16)
> Sys Temp:    +28=B0C  (high =3D   -65=B0C, hyst =3D   -34=B0C)   ALARM
> CPU Temp:  +34.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> AUX Temp:  +38.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>=20
> Fan4 is disabled in the chip. I think the board has 4 connectors. I dont =

> have time right now to check the manual.

Ok, it makes sense :)

Name (FBUF, Package (0x06)
{
    0x03,
    CPUF,
    CHAF,
    PWRF,
    CHPF,
    CH2F
})

Clearly the first number is not the number of available readings (though
it matches the count in the other DSDTs I've seen); don't know what it
is :|

The last field of the individual fan packages is far more interesting: 0
means disabled, anything else means enabled. In your DSDT "CHIPSET FAN
Speed" is marked as disabled and there's no AML code to read the
rotation.
This may be true also for the other packages (temp and voltage), but for
now I've modified only the fan code.

Here's another iteration of the driver, please give it a try:

/*
 * Copyright (C) 2007 Luca Tettamanti <kronos.it@gmail.com>
 * Distribute under GPLv2.
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
	struct class_device *class_dev;
	acpi_handle atk_handle;
	struct acpi_device *device;

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
	attr->attr.name =3D name;
	attr->attr.mode =3D mode;
	attr->show =3D show;
	attr->store =3D store;
}

#define ATTR_NAME_SIZE 16 /* Worst case is "tempN_input" */

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
	acpi_handle handle;
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
	struct atk_temp *a =3D input_to_atk_temp(attr);
	unsigned long temp;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;
	ssize_t count;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D a->id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_integer(atk_data.rtmp_handle, NULL, &params, &tem=
p);
	if (status !=3D AE_OK) {
		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	/* ACPI returns centidegree */
	count =3D sprintf(buf, "%lu\n", temp * 10);

	return count;
}

#define label_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, label_attr)

static ssize_t atk_temp_label_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a =3D label_to_atk_temp(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

enum atk_temp_pack_id {
	ATK_TEMP_PACK_MAX =3D 2,
	ATK_TEMP_PACK_CRIT =3D 3,
};

static int atk_temp_pack_read(acpi_handle handle, int pack_id,
		enum atk_temp_pack_id temp_id, unsigned long *temp)
{
	struct acpi_buffer ret;
	struct acpi_object_list params;
	union acpi_object id;
	union acpi_object *pack;
	union acpi_object *obj;
	acpi_status status;
	int err =3D 0;

	ret.length =3D ACPI_ALLOCATE_BUFFER;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D pack_id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_object_typed(handle, NULL, &params,
			&ret, ACPI_TYPE_PACKAGE);
	if (status !=3D AE_OK) {
		dev_warn(&atk_data.device->dev, "%s: ACPI exception: %s\n",
				__func__, acpi_format_exception(status));
		return -EIO;
	}

	pack =3D ret.pointer;

	if (pack->package.count !=3D 5) {
		dev_warn(&atk_data.device->dev, "%s: unexpected package size: %d\n",
				__func__, pack->package.count);
		err =3D -EIO;
		goto out;
	}

	obj =3D &pack->package.elements[temp_id];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_warn(&atk_data.device->dev, "%s: unexepected object type "
				"for element %d: %d\n", __func__, temp_id, obj->type);
		err =3D -EIO;
		goto out;
	}

	*temp =3D obj->integer.value;

out:
	ACPI_FREE(ret.pointer);

	return err;
}

#define max_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, max_attr)

static ssize_t atk_temp_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a =3D max_to_atk_temp(attr);
	unsigned long temp;

	if (atk_temp_pack_read(a->handle, a->id, ATK_TEMP_PACK_MAX, &temp))
		return -EIO;

	return sprintf(buf, "%ld\n", temp * 10);
}

#define crit_to_atk_temp(attr) \
	container_of(attr, struct atk_temp, crit_attr)

static ssize_t atk_temp_crit_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_temp *a =3D crit_to_atk_temp(attr);
	unsigned long temp;

	if (atk_temp_pack_read(a->handle, a->id, ATK_TEMP_PACK_CRIT, &temp))
		return -EIO;

	return sprintf(buf, "%ld\n", temp * 10);
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
	acpi_handle handle;
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
	struct atk_voltage *a =3D label_to_atk_voltage(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

#define input_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, input_attr)

static ssize_t atk_voltage_input_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a =3D input_to_atk_voltage(attr);
	unsigned long voltage;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D a->id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_integer(atk_data.rvlt_handle, NULL, &params, &vol=
tage);
	if (status !=3D AE_OK) {
		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	return sprintf(buf, "%lu\n", voltage);
}

enum atk_voltage_pack_id {
	ATK_VOLTAGE_PACK_MIN =3D 2,
	ATK_VOLTAGE_PACK_MAX =3D 3,
};

static int atk_voltage_pack_read(acpi_handle handle, int pack_id,
		enum atk_voltage_pack_id volt_id, unsigned long *voltage)
{
	struct acpi_buffer ret;
	struct acpi_object_list params;
	union acpi_object id;
	union acpi_object *pack;
	union acpi_object *obj;
	acpi_status status;
	int err =3D 0;

	ret.length =3D ACPI_ALLOCATE_BUFFER;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D pack_id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_object_typed(handle, NULL, &params,
			&ret, ACPI_TYPE_PACKAGE);
	if (status !=3D AE_OK) {
		dev_warn(&atk_data.device->dev, "%s: ACPI exception %s\n", __func__,
				acpi_format_exception(status));
		return -EIO;
	}

	pack =3D ret.pointer;

	if (pack->package.count !=3D 5) {
		dev_warn(&atk_data.device->dev, "%s: unexpected package size: %d\n",
				__func__, pack->package.count);
		err =3D -EIO;
		goto out;
	}

	obj =3D &pack->package.elements[volt_id];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_warn(&atk_data.device->dev, "%s: unexepected object type "
				"for element %d: %d\n", __func__, volt_id, obj->type);
		err =3D -EIO;
		goto out;
	}

	*voltage =3D obj->integer.value;

out:
	ACPI_FREE(ret.pointer);

	return err;
}

#define max_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, max_attr)

static ssize_t atk_voltage_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a =3D max_to_atk_voltage(attr);
	unsigned long volt;

	if (atk_voltage_pack_read(a->handle, a->id, ATK_VOLTAGE_PACK_MAX, &volt))
		return -EIO;

	return sprintf(buf, "%lu\n", volt);
}

#define min_to_atk_voltage(attr) \
	container_of(attr, struct atk_voltage, min_attr)

static ssize_t atk_voltage_min_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_voltage *a =3D min_to_atk_voltage(attr);
	unsigned long volt;

	if (atk_voltage_pack_read(a->handle, a->id, ATK_VOLTAGE_PACK_MIN, &volt))
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
	acpi_handle handle;
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
	struct atk_fan *a =3D input_to_atk_fan(attr);
	unsigned long rotation;
	struct acpi_object_list params;
	union acpi_object id;
	acpi_status status;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D a->id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_integer(atk_data.rfan_handle, NULL, &params, &rot=
ation);
	if (status !=3D AE_OK) {
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
	struct atk_fan *a =3D label_to_atk_fan(attr);

	return sprintf(buf, "%s\n", a->acpi_name);
}

enum atk_fan_pack_id {
	ATK_FAN_PACK_MIN =3D 2,
	ATK_FAN_PACK_MAX =3D 3,
};


static int atk_fan_pack_read(acpi_handle handle, int pack_id,
		enum atk_fan_pack_id fan_id, unsigned long *rot)
{
	struct acpi_buffer ret;
	struct acpi_object_list params;
	union acpi_object id;
	union acpi_object *pack;
	union acpi_object *obj;
	acpi_status status;
	int err =3D 0;

	ret.length =3D ACPI_ALLOCATE_BUFFER;

	id.type =3D ACPI_TYPE_INTEGER;
	id.integer.value =3D pack_id;

	params.count =3D 1;
	params.pointer =3D &id;

	status =3D acpi_evaluate_object_typed(handle, NULL, &params,
			&ret, ACPI_TYPE_PACKAGE);
	if (status !=3D AE_OK) {
		dev_warn(&atk_data.device->dev, "%s: ACPI exception: %s\n",
				__func__, acpi_format_exception(status));
		return -EIO;
	}
	pack =3D ret.pointer;

	if (pack->package.count !=3D 5) {
		dev_warn(&atk_data.device->dev, "%s: unexpected package size: %d\n",
				__func__, pack->package.count);
		err =3D -EIO;
		goto out;
	}

	obj =3D &pack->package.elements[fan_id];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_warn(&atk_data.device->dev, "%s: unexepected object type "
				"for element %d: %d\n", __func__, fan_id, obj->type);
		err =3D -EIO;
		goto out;
	}

	*rot =3D obj->integer.value;

out:
	ACPI_FREE(ret.pointer);

	return err;
}

#define min_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, min_attr)

static ssize_t atk_fan_min_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a =3D min_to_atk_fan(attr);
	unsigned long rot;

	if (atk_fan_pack_read(a->handle, a->id, ATK_FAN_PACK_MIN, &rot))
		return -EIO;

	return sprintf(buf, "%ld\n", rot);
}

#define max_to_atk_fan(attr) \
	container_of(attr, struct atk_fan, max_attr)

static ssize_t atk_fan_max_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct atk_fan *a =3D max_to_atk_fan(attr);
	unsigned long rot;

	if (atk_fan_pack_read(a->handle, a->id, ATK_FAN_PACK_MAX, &rot))
		return -EIO;

	return sprintf(buf, "%ld\n", rot);;
}

static ssize_t atk_name_show(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	return sprintf(buf, "atk0110-0\n");
}

static struct device_attribute atk_name_attr =3D __ATTR(name, 0444, atk_nam=
e_show, NULL);

struct atk_temp_list *temp_list;
struct atk_voltage_list *voltage_list;
struct atk_fan_list *fan_list;

static int atk_add(struct acpi_device *device);
static int atk_remove(struct acpi_device *device, int type);

static struct acpi_driver atk_driver =3D {
	.name	=3D ATK_HID,
	.class	=3D "hwmon",
	.ids	=3D ATK_HID,
	.ops	=3D {
		.add	=3D atk_add,
		.remove	=3D atk_remove,
	},
};

static int atk_create_files(struct device *dev)
{
	int i;
	int ret;

	/* Temperatures */
	for (i =3D 0; i < temp_list->count; i++) {
		ret =3D device_create_file(dev, &temp_list->temp[i].input_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &temp_list->temp[i].label_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &temp_list->temp[i].max_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &temp_list->temp[i].crit_attr);
		if (ret)
			return ret;
	}

	/* Voltages */
	for (i =3D 0; i < voltage_list->count; i++) {
		ret =3D device_create_file(dev, &voltage_list->voltage[i].input_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &voltage_list->voltage[i].label_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &voltage_list->voltage[i].min_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &voltage_list->voltage[i].max_attr);
		if (ret)
			return ret;
	}

	/* Fans */
	for (i =3D 0; i < fan_list->count; i++) {
		ret =3D device_create_file(dev, &fan_list->fan[i].input_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &fan_list->fan[i].label_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &fan_list->fan[i].min_attr);
		if (ret)
			return ret;
		ret =3D device_create_file(dev, &fan_list->fan[i].max_attr);
		if (ret)
			return ret;
	}

	ret =3D device_create_file(dev, &atk_name_attr);

	return ret;
}

static void atk_remove_files(struct device *dev)
{
	int i;

	/* Temperatures */
	if (temp_list) {
		for (i =3D 0; i < temp_list->count; i++) {
			device_remove_file(dev, &temp_list->temp[i].input_attr);
			device_remove_file(dev, &temp_list->temp[i].label_attr);
			kfree(temp_list->temp[i].acpi_name);
			device_remove_file(dev, &temp_list->temp[i].max_attr);
			device_remove_file(dev, &temp_list->temp[i].crit_attr);
		}
	}
	kfree(temp_list);
	temp_list =3D NULL;

	/* Voltages */
	if (voltage_list) {
		for (i =3D 0; i < voltage_list->count; i++) {
			device_remove_file(dev, &voltage_list->voltage[i].input_attr);
			device_remove_file(dev, &voltage_list->voltage[i].label_attr);
			kfree(voltage_list->voltage[i].acpi_name);
			device_remove_file(dev, &voltage_list->voltage[i].min_attr);
			device_remove_file(dev, &voltage_list->voltage[i].max_attr);
		}
	}
	kfree(voltage_list);
	voltage_list =3D NULL;

	/* Fans */
	if (fan_list) {
		for (i =3D 0; i < fan_list->count; i++) {
			device_remove_file(dev, &fan_list->fan[i].input_attr);
			device_remove_file(dev, &fan_list->fan[i].label_attr);
			kfree(fan_list->fan[i].acpi_name);
			device_remove_file(dev, &fan_list->fan[i].min_attr);
			device_remove_file(dev, &fan_list->fan[i].max_attr);
		}
	}
	kfree(fan_list);
	voltage_list =3D NULL;

	device_remove_file(dev, &atk_name_attr);
}

static int atk_enumerate_temp(struct acpi_buffer *temp_buf)
{
	struct atk_temp_list *tmp;
	union acpi_object *pack;
	union acpi_object *obj;
	struct device *dev =3D &atk_data.device->dev;
	int i, ret;

	/* Result must be a package */
	pack =3D temp_buf->pointer;

	if (pack->package.count < 1) {
		dev_dbg(dev, "%s: temp package is too small: %d\n", __func__,
				pack->package.count);
		return -EINVAL;
	}

	/* First field is the number of available readings */
	obj =3D &pack->package.elements[0];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_dbg(dev, "%s: temp package: invalid type for "
				"element 0: %d\n", __func__, obj->type);
		return -EINVAL;
	}

	/* Sanity check */
	if (pack->package.count !=3D obj->integer.value + 1) {
		dev_dbg(dev, "%s: temperature count (%llu) differs "
				"from package count (%u)\n", __func__,
				obj->integer.value, pack->package.count);
		return -EINVAL;
	}

	tmp =3D kzalloc(sizeof(*tmp) + sizeof(*tmp->temp) * obj->integer.value, GF=
P_KERNEL);
	if (!tmp)
		return -ENOMEM;

	tmp->count =3D obj->integer.value;
	for (i =3D 0; i < pack->package.count - 1; i++) {
		struct acpi_buffer buf;
		union acpi_object *temp_pack;
		union acpi_object *name;
		union acpi_object *tmax;
		union acpi_object *tcrit;
		union acpi_object *acpi_id;
		acpi_status status;

		obj =3D &pack->package.elements[i + 1];

		/* obj is a handle to the temperature package */
		if (obj->type !=3D ACPI_TYPE_ANY) {
			dev_warn(dev, "%s: invalid type for element %d: %d\n",
					__func__, i, obj->type);
			ret =3D -EINVAL;
			goto cleanup;
		}

		buf.length =3D ACPI_ALLOCATE_BUFFER;
		status =3D acpi_evaluate_object_typed(obj->reference.handle, NULL, NULL,
				&buf, ACPI_TYPE_PACKAGE);
		if (status !=3D AE_OK) {
			dev_dbg(dev, "%s: ACPI exception on object %u: %s\n",
					__func__, i + 1, acpi_format_exception(status));
			ret =3D -EINVAL;
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
		 * unknown
		 */
		temp_pack =3D buf.pointer;

		if (temp_pack->package.count !=3D 5) {
			dev_dbg(dev, "%s: invalid package count "
					"for object %d: %u\n", __func__,
					i + 1, temp_pack->package.count);
			ACPI_FREE(buf.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		acpi_id =3D &temp_pack->package.elements[0];
		name =3D &temp_pack->package.elements[1];
		tmax =3D &temp_pack->package.elements[2];
		tcrit =3D &temp_pack->package.elements[3];

		if (acpi_id->type !=3D ACPI_TYPE_INTEGER) {
			dev_dbg(dev, "%s: object %d, int expected (id), got: %d\n",
					__func__, i, acpi_id->type);
			ACPI_FREE(buf.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (name->type !=3D ACPI_TYPE_STRING) {
			dev_dbg(dev, "%s: object %d, string expected, got %d\n",
					__func__, i, name->type);
			ACPI_FREE(buf.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (tmax->type !=3D ACPI_TYPE_INTEGER) {
			dev_dbg(dev, "%s: object %d, int expected (tmax), got: %d\n",
					__func__, i, name->type);
			ACPI_FREE(buf.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (tcrit->type !=3D ACPI_TYPE_INTEGER) {
			dev_dbg(dev, "%s: object %d, int expected (tcrit), got: %d\n",
					__func__, i, name->type);
			ACPI_FREE(buf.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		tmp->temp[i].id =3D acpi_id->integer.value;
		tmp->temp[i].handle =3D obj->reference.handle;

		snprintf(tmp->temp[i].input_attr_name, ATTR_NAME_SIZE, "temp%d_input", i);
		atk_init_attribute(&tmp->temp[i].input_attr, tmp->temp[i].input_attr_name,
				0444, atk_temp_input_show, NULL);

		tmp->temp[i].acpi_name =3D kstrdup(name->string.pointer, GFP_KERNEL);
		snprintf(tmp->temp[i].label_attr_name, ATTR_NAME_SIZE, "temp%d_label", i);
		atk_init_attribute(&tmp->temp[i].label_attr, tmp->temp[i].label_attr_name,
				0444, atk_temp_label_show, NULL);

		snprintf(tmp->temp[i].max_attr_name, ATTR_NAME_SIZE, "temp%d_max", i);
		atk_init_attribute(&tmp->temp[i].max_attr, tmp->temp[i].max_attr_name,
				0444, atk_temp_max_show, NULL);

		snprintf(tmp->temp[i].crit_attr_name, ATTR_NAME_SIZE, "temp%d_crit", i);
		atk_init_attribute(&tmp->temp[i].crit_attr, tmp->temp[i].crit_attr_name,
				0444, atk_temp_crit_show, NULL);

		dev_dbg(dev, "temp %d: %#llx %s [%llu-%llu]\n", i, tmp->temp[i].id,
				tmp->temp[i].acpi_name,
				tmax->integer.value, tcrit->integer.value);

		ACPI_FREE(buf.pointer);
	}

	temp_list =3D tmp;

	return 0;
cleanup:
	for (i =3D 0; i < tmp->count; i++)
		kfree(tmp->temp[i].acpi_name);
	kfree(tmp);

	return ret;
}

static int atk_enumerate_voltage(struct acpi_buffer *vlt_buf)
{
	struct device *dev =3D &atk_data.device->dev;
	union acpi_object *pack;
	union acpi_object *obj;
	struct atk_voltage_list *vlt;
	int ret, i;

	pack =3D vlt_buf->pointer;

	/* At least one element is expected */
	if (pack->package.count < 1) {
		dev_warn(dev, "%s: voltage pack is too small: %d\n", __func__,
				pack->package.count);
		return -EINVAL;
	}

	/* First field is the number of available readings */
	obj =3D &pack->package.elements[0];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: voltage pack: invalid type for element 0: %d\n",
				__func__, obj->type);
	}

	if (obj->integer.value + 1 !=3D pack->package.count) {
		dev_warn(dev, "%s: invalid voltage count %llu (should be %d)\n", __func__,
			obj->integer.value, pack->package.count - 1);
		return -EINVAL;
	}

	vlt =3D kzalloc(sizeof(*vlt) + sizeof(*vlt->voltage) * obj->integer.value,=
 GFP_KERNEL);
	if (!vlt)
		return -ENOMEM;

	vlt->count =3D obj->integer.value;
	for (i =3D 0; i < pack->package.count - 1; i++) {
		struct acpi_buffer buffer;
		union acpi_object *voltage_pack;
		union acpi_object *name;
		union acpi_object *vmax;
		union acpi_object *vmin;
		union acpi_object *acpi_id;
		acpi_status status;

		obj =3D &pack->package.elements[i + 1];

		/* handle to voltage package */
		if (obj->type !=3D ACPI_TYPE_ANY) {
			dev_warn(dev, "%s: invalid type for element %d: %d\n",
					__func__, i, obj->type);
			ret =3D -EINVAL;
			goto cleanup;
		}

		buffer.length =3D ACPI_ALLOCATE_BUFFER;
		status =3D acpi_evaluate_object_typed(obj->reference.handle, NULL, NULL,
				&buffer, ACPI_TYPE_PACKAGE);
		if (status !=3D AE_OK) {
			dev_warn(dev, "%s: ACPI exception while evaluating object %d: %s\n",
					__func__, i, acpi_format_exception(status));
			ret =3D -EINVAL;
			goto cleanup;
		}

		/* Package:
		 * id
		 * description
		 * min
		 * max
		 * One
		 */
		voltage_pack =3D buffer.pointer;

		if (voltage_pack->package.count !=3D 5) {
			dev_warn(dev, "%s: invalid package for object %d: %d\n",
					__func__, i, voltage_pack->package.count);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		acpi_id =3D &voltage_pack->package.elements[0];
		name =3D &voltage_pack->package.elements[1];
		vmin =3D &voltage_pack->package.elements[2];
		vmax =3D &voltage_pack->package.elements[3];

		if (acpi_id->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (id), got: %d\n",
					__func__, i, acpi_id->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (name->type !=3D ACPI_TYPE_STRING) {
			dev_warn(dev, "%s: object %d, string expected, got %d\n",
					__func__, i, name->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (vmax->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (vmax), got: %d\n",
					__func__, i, vmax->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (vmin->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (vmin), got: %d\n",
					__func__, i, vmin->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		vlt->voltage[i].id =3D acpi_id->integer.value;
		vlt->voltage[i].handle =3D obj->reference.handle;
		vlt->voltage[i].acpi_name =3D kstrdup(name->string.pointer, GFP_KERNEL);

		snprintf(vlt->voltage[i].input_attr_name, ATTR_NAME_SIZE, "in%d_input", i=
);
		atk_init_attribute(&vlt->voltage[i].input_attr,
				vlt->voltage[i].input_attr_name,
				0444, atk_voltage_input_show, NULL);

		snprintf(vlt->voltage[i].label_attr_name, ATTR_NAME_SIZE, "in%d_label", i=
);
		atk_init_attribute(&vlt->voltage[i].label_attr,
				vlt->voltage[i].label_attr_name,
				0444, atk_voltage_label_show, NULL);

		snprintf(vlt->voltage[i].max_attr_name, ATTR_NAME_SIZE, "in%d_max", i);
		atk_init_attribute(&vlt->voltage[i].max_attr,
				vlt->voltage[i].max_attr_name,
				0444, atk_voltage_max_show, NULL);

		snprintf(vlt->voltage[i].min_attr_name, ATTR_NAME_SIZE, "in%d_min", i);
		atk_init_attribute(&vlt->voltage[i].min_attr,
				vlt->voltage[i].min_attr_name,
				0444, atk_voltage_min_show, NULL);

		dev_dbg(dev, "voltage %d: %#llx %s [%llu-%llu]\n", i, vlt->voltage[i].id,
				vlt->voltage[i].acpi_name, vmin->integer.value,
				vmax->integer.value);
		ACPI_FREE(buffer.pointer);
	}

	voltage_list =3D vlt;

	return 0;

cleanup:
	for (i =3D 0; i < vlt->count; i++)
		kfree(vlt->voltage[i].acpi_name);
	kfree(vlt);

	return ret;
}

static int atk_enumerate_fan(struct acpi_buffer *fan_buf)
{
	struct device *dev =3D &atk_data.device->dev;
	union acpi_object *pack;
	union acpi_object *obj;
	struct atk_fan_list *fan;
	int ret, i;
	int count, next;

	pack =3D fan_buf->pointer;

	if (pack->package.count < 1) {
		dev_warn(dev, "%s: fan package is too small: %d\n",
				__func__, pack->package.count);
		return -EINVAL;
	}

	obj =3D &pack->package.elements[0];
	if (obj->type !=3D ACPI_TYPE_INTEGER) {
		dev_warn(dev, "%s: fan package: invalid type for element 0: %d\n",
				__func__, obj->type);
		return -EINVAL;
	}

	/* Don't fail, it's not fatal */
	if (obj->integer.value + 1 !=3D pack->package.count) {
		dev_dbg(dev, "%s: invalid fan count? %llu (should be %d)\n",
				__func__, obj->integer.value, pack->package.count - 1);
	}

	count =3D pack->package.count - 1;

	fan =3D kzalloc(sizeof(*fan) + sizeof(*fan->fan) * count, GFP_KERNEL);
	if (!fan)
		return -ENOMEM;

	fan->count =3D count;
	next =3D 0;
	for (i =3D 0; i < pack->package.count - 1; i++) {
		struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
		union acpi_object *fan_pack;
		union acpi_object *acpi_id;
		union acpi_object *name;
		union acpi_object *fmin;
		union acpi_object *fmax;
		union acpi_object *enable;
		acpi_status status;

		/* handle to fan package */
		obj =3D &pack->package.elements[i + 1];

		if (obj->type !=3D ACPI_TYPE_ANY) {
			dev_warn(dev, "%s: invalid type type for element %d: %d\n",
					__func__, i + 1, obj->type);
			ret =3D -EINVAL;
			goto cleanup;
		}

		status =3D acpi_evaluate_object_typed(obj->reference.handle, NULL, NULL,
				&buffer, ACPI_TYPE_PACKAGE);
		if (status !=3D AE_OK) {
			dev_warn(dev, "%s: ACPI exception while evaluating object %d: %s\n",
					__func__, i + 1, acpi_format_exception(status));
			ret =3D -EINVAL;
			goto cleanup;
		}

		/* Fan package:
		 * id (usual stuff)
		 * description
		 * min
		 * max
		 * enable bit (disabled =3D 0, enabled otherwise)
		 */
		fan_pack =3D buffer.pointer;

		if (fan_pack->package.count !=3D 5) {
			dev_warn(dev, "%s: invalid package len for object %d: %d\n",
					__func__, i + 1, fan_pack->package.count);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		acpi_id =3D &fan_pack->package.elements[0];
		name =3D &fan_pack->package.elements[1];
		fmin =3D &fan_pack->package.elements[2];
		fmax =3D &fan_pack->package.elements[3];
		enable =3D &fan_pack->package.elements[4];

		if (acpi_id->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (id), got: %d\n",
					__func__, i, acpi_id->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (name->type !=3D ACPI_TYPE_STRING) {
			dev_warn(dev, "%s: object %d, string expected, got %d\n",
					__func__, i + 1, name->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (fmin->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (fmin), got %d\n",
					__func__, i + 1, fmin->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (fmax->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (fmax), got %d\n",
					__func__, i + 1, fmax->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}
		if (enable->type !=3D ACPI_TYPE_INTEGER) {
			dev_warn(dev, "%s: object %d, int expected (en), got %d\n",
					__func__, i + 1, enable->type);
			ACPI_FREE(buffer.pointer);
			ret =3D -EINVAL;
			goto cleanup;
		}

		dev_dbg(dev, "fan %d: %#llx %s [%llu-%llu] %s\n", i, acpi_id->integer.val=
ue,
				name->string.pointer, fmin->integer.value,
				fmax->integer.value,
				enable->integer.value ? "enabled" : "disabled");

		if (!enable->integer.value) {
			fan->count--;
			continue;
		}

		fan->fan[next].id =3D acpi_id->integer.value;
		fan->fan[next].handle =3D obj->reference.handle;
		fan->fan[next].acpi_name =3D kstrdup(name->string.pointer, GFP_KERNEL);

		snprintf(fan->fan[next].input_attr_name, ATTR_NAME_SIZE, "fan%d_input", n=
ext);
		atk_init_attribute(&fan->fan[next].input_attr,
				fan->fan[next].input_attr_name,
				0444, atk_fan_input_show, NULL);

		snprintf(fan->fan[next].label_attr_name, ATTR_NAME_SIZE, "fan%d_label", n=
ext);
		atk_init_attribute(&fan->fan[next].label_attr,
				fan->fan[next].label_attr_name,
				0444, atk_fan_label_show, NULL);

		snprintf(fan->fan[next].min_attr_name, ATTR_NAME_SIZE, "fan%d_min", next);
		atk_init_attribute(&fan->fan[next].min_attr,
				fan->fan[next].min_attr_name,
				0444, atk_fan_min_show, NULL);

		snprintf(fan->fan[next].max_attr_name, ATTR_NAME_SIZE, "fan%d_max", next);
		atk_init_attribute(&fan->fan[next].max_attr,
				fan->fan[next].max_attr_name,
				0444, atk_fan_max_show, NULL);

		next++;
		ACPI_FREE(buffer.pointer);
	}

	fan_list =3D fan;

	return 0;
cleanup:
	for (i =3D 0; i < fan->count; i++)
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

	atk_data.device =3D device;
	atk_data.atk_handle =3D device->handle;

	buf.length =3D ACPI_ALLOCATE_BUFFER;
	ret =3D acpi_evaluate_object_typed(atk_data.atk_handle, "MBIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret !=3D AE_OK) {
		dev_dbg(&device->dev, "atk: method MBIF not found\n");
		return -ENODEV;
	}

	obj =3D buf.pointer;
	if (obj->package.count >=3D 2 && obj->package.elements[1].type =3D ACPI_TY=
PE_STRING) {
		dev_dbg(&device->dev, "board ID =3D %s\n",
				obj->package.elements[1].string.pointer);
	}
	ACPI_FREE(buf.pointer);

	/* Check for hwmon methods */
	search_ns =3D acpi_ns_map_handle_to_node(device->handle);
	if (!search_ns)
		return -ENODEV;

	/* RTMP: read temperature */
	ret =3D acpi_ns_get_node(search_ns, "RTMP", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret !=3D AE_OK) {
		dev_dbg(&device->dev, "method RTMP not found\n");
		return -ENODEV;
	}
	atk_data.rtmp_handle =3D acpi_ns_convert_entry_to_handle(ns);

	/* RVLT: read voltage */
	ret =3D acpi_ns_get_node(search_ns, "RVLT", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret !=3D AE_OK) {
		dev_dbg(&device->dev, "method RVLT not found\n");
		return -ENODEV;
	}
	atk_data.rvlt_handle =3D acpi_ns_convert_entry_to_handle(ns);

	/* RFAN: read fan status */
	ret =3D acpi_ns_get_node(search_ns, "RFAN", ACPI_NS_NO_UPSEARCH, &ns);
	if (ret !=3D AE_OK) {
		dev_dbg(&device->dev, "method RFAN not found\n");
		return -ENODEV;
	}
	atk_data.rfan_handle =3D acpi_ns_convert_entry_to_handle(ns);

	/* Enumerate temp data - TSIF */
	buf.length =3D ACPI_ALLOCATE_BUFFER;
	ret =3D acpi_evaluate_object_typed(atk_data.atk_handle, "TSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret !=3D AE_OK) {
		dev_warn(&device->dev, "TSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));
		return -ENODEV;
	}

	err =3D atk_enumerate_temp(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		return err;

	/* Enumerate voltage data - VSIF */
	buf.length =3D ACPI_ALLOCATE_BUFFER;
	ret =3D acpi_evaluate_object_typed(atk_data.atk_handle, "VSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret !=3D AE_OK) {
		dev_warn(&device->dev, "VSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));

		err =3D -ENODEV;
		goto cleanup;
	}

	err =3D atk_enumerate_voltage(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		goto cleanup;

	/* Enumerate fan data - FSIF */
	buf.length =3D ACPI_ALLOCATE_BUFFER;
	ret =3D acpi_evaluate_object_typed(atk_data.atk_handle, "FSIF", NULL,
			&buf, ACPI_TYPE_PACKAGE);
	if (ret !=3D AE_OK) {
		dev_warn(&device->dev, "TSIF: ACPI exception: %s\n",
				acpi_format_exception(ret));

		err =3D -ENODEV;
		goto cleanup;
	}

	err =3D atk_enumerate_fan(&buf);
	ACPI_FREE(buf.pointer);
	if (err)
		goto cleanup;

	dev_dbg(&atk_data.device->dev, "registering hwmon device\n");
	atk_data.class_dev =3D hwmon_device_register(&atk_data.device->dev);
	if (IS_ERR(atk_data.class_dev)) {
		err =3D PTR_ERR(atk_data.class_dev);
		goto cleanup;
	}

	dev_dbg(&atk_data.device->dev, "populating sysfs directory\n");
	err =3D atk_create_files(&atk_data.device->dev);
	if (err)
		goto remove;

	acpi_driver_data(device) =3D &atk_data;

	return 0;
remove:
	atk_remove_files(&atk_data.device->dev);
	hwmon_device_unregister(atk_data.class_dev);

	return err;
cleanup:
	if (temp_list) {
		for (i =3D 0; i < temp_list->count; i++)
			kfree(temp_list->temp[i].acpi_name);
	}
	kfree(temp_list);

	if (voltage_list) {
		for (i =3D 0; i < voltage_list->count; i++)
			kfree(voltage_list->voltage[i].acpi_name);
	}
	kfree(voltage_list);

	if (fan_list) {
		for (i =3D 0; i < fan_list->count; i++)
			kfree(fan_list->fan[i].acpi_name);
	}
	kfree(fan_list);

	temp_list =3D NULL;
	voltage_list =3D NULL;
	fan_list =3D NULL;

	return err;
}

static int atk_remove(struct acpi_device *device, int type)
{
	dev_dbg(&device->dev, "removing...\n");

	acpi_driver_data(device) =3D NULL;

	hwmon_device_unregister(atk_data.class_dev);
	atk_remove_files(&atk_data.device->dev);

	return 0;
}

int atk_init(void)
{
	int ret;

	ret =3D acpi_bus_register_driver(&atk_driver);
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



Luca
--=20
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
