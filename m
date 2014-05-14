From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 May 2014 17:09:33 +0000
Subject: Re: [lm-sensors] [PATCH] powerpc/powernv: hwmon driver for power values, fan rpm and temperature
Message-Id: <20140514170933.GB18032@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140514055859.16148.35534.stgit@neelegup-tp-t420.in.ibm.com>
In-Reply-To: <20140514055859.16148.35534.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: lm-sensors@lm-sensors.org, sbhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de

On Wed, May 14, 2014 at 11:31:53AM +0530, Neelesh Gupta wrote:
> This patch adds basic kernel enablement for reading power values, fan
> speed rpm and temperature values on powernv platforms which will
> be exported to user space through sysfs interface.
>=20
> Test results:
> -------------
> [root@tul163p1 ~]# sensors
> ibmpowernv-isa-0000
> Adapter: ISA adapter
> fan1:        5294 RPM  (min =3D    0 RPM)
> fan2:        4945 RPM  (min =3D    0 RPM)
> fan3:        5831 RPM  (min =3D    0 RPM)
> fan4:        5212 RPM  (min =3D    0 RPM)
> fan5:           0 RPM  (min =3D    0 RPM)
> fan6:           0 RPM  (min =3D    0 RPM)
> fan7:        7472 RPM  (min =3D    0 RPM)
> fan8:        7920 RPM  (min =3D    0 RPM)
> temp1:        +39.0=B0C  (high =3D  +0.0=B0C)
> power1:      192.00 W =20
>=20
> [root@tul163p1 ~]#=20
> [root@tul163p1 ~]# ls /sys/devices/platform/ibmpowernv.0/
> driver      fan2_min    fan4_min    fan6_min    fan8_min   modalias      =
uevent
> fan1_fault  fan3_fault  fan5_fault  fan7_fault  hwmon      name
> fan1_input  fan3_input  fan5_input  fan7_input  in1_fault  power1_input
> fan1_min    fan3_min    fan5_min    fan7_min    in2_fault  subsystem
> fan2_fault  fan4_fault  fan6_fault  fan8_fault  in3_fault  temp1_input
> fan2_input  fan4_input  fan6_input  fan8_input  in4_fault  temp1_max
> [root@tul163p1 ~]#=20
> [root@tul163p1 ~]# ls /sys/class/hwmon/hwmon0/device/
> driver      fan2_min    fan4_min    fan6_min    fan8_min   modalias      =
uevent
> fan1_fault  fan3_fault  fan5_fault  fan7_fault  hwmon      name
> fan1_input  fan3_input  fan5_input  fan7_input  in1_fault  power1_input
> fan1_min    fan3_min    fan5_min    fan7_min    in2_fault  subsystem
> fan2_fault  fan4_fault  fan6_fault  fan8_fault  in3_fault  temp1_input
> fan2_input  fan4_input  fan6_input  fan8_input  in4_fault  temp1_max
> [root@tul163p1 ~]#
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
>  drivers/hwmon/Kconfig      |    8 +
>  drivers/hwmon/Makefile     |    1=20
>  drivers/hwmon/ibmpowernv.c |  386 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 395 insertions(+)
>  create mode 100644 drivers/hwmon/ibmpowernv.c
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index bc196f4..3e308fa 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -554,6 +554,14 @@ config SENSORS_IBMPEX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ibmpex.
> =20
> +config SENSORS_IBMPOWERNV
> +	tristate "IBM POWERNV platform sensors"
> +	depends on PPC_POWERNV
> +	default y
> +	help
> +	  If you say yes here you get support for the temperature/fan/power
> +	  sensors on your platform.
> +
>  config SENSORS_IIO_HWMON
>  	tristate "Hwmon driver that uses channels specified via iio maps"
>  	depends on IIO
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index c48f987..199c401 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+=3D ultra45_env.o
>  obj-$(CONFIG_SENSORS_I5K_AMB)	+=3D i5k_amb.o
>  obj-$(CONFIG_SENSORS_IBMAEM)	+=3D ibmaem.o
>  obj-$(CONFIG_SENSORS_IBMPEX)	+=3D ibmpex.o
> +obj-$(CONFIG_SENSORS_IBMPOWERNV)+=3D ibmpowernv.o
>  obj-$(CONFIG_SENSORS_IIO_HWMON) +=3D iio_hwmon.o
>  obj-$(CONFIG_SENSORS_INA209)	+=3D ina209.o
>  obj-$(CONFIG_SENSORS_INA2XX)	+=3D ina2xx.o
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> new file mode 100644
> index 0000000..e5cffce
> --- /dev/null
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -0,0 +1,386 @@
> +/*
> + * IBM PowerNV platform sensors for temperature/fan/power
> + * Copyright (C) 2014 IBM
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA

Please drop the FSF address; it can change, and we don't want to update the
driver each time it does.

> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include <linux/platform_device.h>
> +#include <asm/opal.h>
> +#include <linux/err.h>
> +
> +#define DRVNAME		"ibmpowernv"
> +#define MAX_ATTR_LEN	32
> +
> +/* Sensor suffix name from DT */
> +#define DT_FAULT_ATTR_SUFFIX		"faulted"
> +#define DT_DATA_ATTR_SUFFIX		"data"
> +#define DT_THRESHOLD_ATTR_SUFFIX	"thrs"
> +
> +/* Enumerates all the sensors in the POWERNV platform and also index into
> + * 'struct sensor_name'

Comment coding style, please (this is not the networking subsystem ;-)

> + */
> +enum sensors {
> +	FAN,
> +	AMBIENT_TEMP,
> +	POWERSUPPLY,
> +	POWER,
> +	MAX_SENSOR_TYPE,
> +};
> +
> +static struct sensor_name {

const ?

> +	char *name;
> +	char *compatible;
> +} sensor_names[] =3D {
> +	{"fan", "ibm,opal-sensor-cooling-fan"},
> +	{"temp", "ibm,opal-sensor-amb-temp"},
> +	{"in", "ibm,opal-sensor-power-supply"},
> +	{"power", "ibm,opal-sensor-power"}
> +};
> +
> +struct platform_data {
> +	struct device *hwmon_dev;

Not needed.

> +	struct device_attribute name_attr;
> +	struct list_head attr_list;
> +};
> +
> +struct sensor_data {
> +	u32 id;
> +	enum sensors stype;
> +	char name[MAX_ATTR_LEN];
> +	struct sensor_device_attribute sd_attr;
> +	struct list_head list;
> +};
> +
> +/* Platform device representing all the ibmpowernv sensors */
> +static struct platform_device *pdevice;
> +
> +static void get_sensor_index_attr(const char *name, u32 *index, char *at=
tr)
> +{
> +	char *hash_pos =3D strchr(name, '#');
> +	char *dash_pos;
> +	u32 copy_len;
> +	char buf[8];
> +
> +	memset(buf, 0, sizeof(buf));
> +	*index =3D 0;
> +	*attr =3D '\0';
> +
> +	if (hash_pos) {
> +		dash_pos =3D strchr(hash_pos, '-');
> +		if (dash_pos) {
> +			copy_len =3D dash_pos - hash_pos - 1;
> +			if (copy_len < sizeof(buf)) {
> +				strncpy(buf, hash_pos + 1, copy_len);
> +				sscanf(buf, "%d", index);
> +			}
> +
> +			strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
> +		}
> +	}
> +}
> +
> +/*
> + * This function translates the DT node name into the 'hwmon' attribute =
name.
> + * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thr=
s etc.
> + * which need to be mapped as fan2_input, temp1_max respectively before
> + * populating them inside hwmon device class..
> + */
> +static int create_hwmon_attr_name(enum sensors stype, const char *node_n=
ame,
> +		char *hwmon_attr_name)

Please follow CodingStyle for continuation line alignment.

> +{
> +	char attr_suffix[MAX_ATTR_LEN];
> +	char *attr_name;
> +	u32 index;
> +
> +	get_sensor_index_attr(node_name, &index, attr_suffix);
> +	if (!index || !strlen(attr_suffix)) {
> +		pr_info("%s: Sensor device node name is invalid, name: %s\n",
> +				__func__, node_name);
> +		return -EINVAL;
> +	}
> +
> +	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX))
> +		attr_name =3D "fault";
> +	else if(!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX))
> +		attr_name =3D "input";
> +	else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
> +		if (stype =3D=3D AMBIENT_TEMP)
> +			attr_name =3D "max";
> +		else if (stype =3D=3D FAN)
> +			attr_name =3D "min";
> +		else
> +			return -ENOENT;
> +	} else
> +		return -ENOENT;
> +
> +	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
> +			sensor_names[stype].name, index, attr_name);
> +	return 0;
> +}
> +
> +static ssize_t show_sensor(struct device *dev, struct device_attribute *=
devattr,
> +		char *buf)
> +{
> +	struct sensor_device_attribute *sd_attr =3D to_sensor_dev_attr(devattr);
> +	struct sensor_data *sdata =3D container_of(sd_attr, struct sensor_data,
> +			sd_attr);
> +	int err;
> +	u32 x;
> +
> +	err =3D opal_get_sensor_data(sdata->id, &x);
> +	if (err) {
> +		pr_err("%s: Failed to get opal sensor data\n", __func__);
> +		x =3D -1;

Unusual. Why not report the error to user space ?
Reporting <maxuint> on error doesn't seem to be very useful.

> +	}
> +
> +	/* Convert temperature to milli-degrees */
> +	if (sdata->stype =3D=3D AMBIENT_TEMP && x > 0)
> +		x *=3D 1000;
> +	/* Convert power to micro-watts */
> +	else if (sdata->stype =3D=3D POWER && x > 0)
> +		x *=3D 1000000;
> +
Is there an overflow concern ? Guess not ... overflow happens at ~17KW.
Just wondering.

> +	return sprintf(buf, "%d\n", x);
> +}
> +
> +static void remove_device_attrs(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata =3D platform_get_drvdata(pdev);
> +	struct device *dev =3D &pdev->dev;
> +	struct sensor_data *s, *next;
> +
> +	list_for_each_entry_safe(s, next, &pdata->attr_list, list) {
> +		device_remove_file(dev, &s->sd_attr.dev_attr);
> +		list_del(&s->list);

This is unnecessary since you always remove the entire list anyway.
Actually, I don't think you need the list in the first place.
You only use it to delete entries, but that can be handled automatically
by the infrastructure. All you really need is an array pointing to the devi=
ce
attributes so you can create all attribute files with a single operation.

> +		kfree(s);
> +	}
> +}
> +
> +/*
> + * Iterate through the device tree and for each child of sensor node, cr=
eate
> + * a sysfs attribute file, the file is named by translating the DT node =
name
> + * to the name required by the higher 'hwmon' driver like fan1_input, te=
mp1_max
> + * etc..
> + */
> +static int create_device_attrs(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata =3D platform_get_drvdata(pdev);
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *opal, *np;
> +	struct sensor_data *sdata;
> +	const u32 *sensor_id;
> +	enum sensors stype;
> +	int err;
> +
> +	opal =3D of_find_node_by_path("/ibm,opal/sensors");
> +        if (!opal) {
> +		pr_err("%s: Opal 'sensors' node not found\n", __func__);
> +		err =3D -ENXIO;

	ENODEV ?

> +		goto exit;

	I would suggest to simply return here.

> +        }
> +
> +	for_each_child_of_node(opal, np) {
> +                if (np->name =3D=3D NULL)
> +                        continue;
> +
> +		for (stype =3D 0; stype < MAX_SENSOR_TYPE; stype++)
> +			if (of_device_is_compatible(np,
> +					sensor_names[stype].compatible))
> +				break;
> +
> +		if (stype =3D=3D MAX_SENSOR_TYPE)
> +			continue;
> +
> +		sensor_id =3D of_get_property(np, "sensor-id", NULL);
> +		if (!sensor_id) {
> +			pr_info("%s: %s doesn't have sensor-id\n", __func__,
> +					np->name);
> +			continue;
> +		}
> +
> +		sdata =3D kzalloc(sizeof(*sdata), GFP_KERNEL);

Can you use devm_kzalloc() ?

> +		if (!sdata) {
> +			pr_err("%s: Failed to allocate memory for sensor_data",
> +					__func__);
> +			err =3D -ENOMEM;
> +			goto exit_put_node;
> +		}
> +
> +		sdata->id =3D *sensor_id;
> +		sdata->stype =3D stype;
> +		err =3D create_hwmon_attr_name(stype, np->name, sdata->name);
> +		if (err) {
> +			pr_err("%s: Failed to create the hwmon attribute name\n",
> +					__func__);

create_hwmon_attr_name() (sometimes) already creates an error message.
Would be nice if you can avoid duplicate error messages.

> +			goto exit_free_sdata;
> +		}
> +
> +		sysfs_attr_init(&sdata->sd_attr.dev_attr.attr);
> +		sdata->sd_attr.dev_attr.attr.name =3D sdata->name;
> +		sdata->sd_attr.dev_attr.attr.mode =3D S_IRUGO;
> +		sdata->sd_attr.dev_attr.show =3D show_sensor;

Since you are not using the index value from sensor_device_attribute,
but use your own 'id' variable instead, you don't need sensor_device_attrib=
ute
but can use device_attribute instead (or drop 'id' and use
sd_attr.index instead).

> +
> +		/* Create sysfs attribute file */
> +		err =3D device_create_file(dev, &sdata->sd_attr.dev_attr);
> +		if (err)
> +			goto exit_free_sdata;
> +
Please don't create the attribute files here but just a list of attributes
instead. See below for more details.

> +		list_add_tail(&sdata->list, &pdata->attr_list);
> +	}
> +
> +	of_node_put(opal);
> +	return 0;
> +
> +exit_free_sdata:
> +	kfree(sdata);
> +exit_put_node:
> +	of_node_put(opal);
> +	remove_device_attrs(pdev);
> +exit:
> +	return err;
> +}
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute *de=
vattr,
> +		char *buf)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	return sprintf(buf, "%s\n", pdev->name);
> +}
Not necessary; see below.

> +
> +static int ibmpowernv_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct platform_data *pdata;
> +	int err;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	INIT_LIST_HEAD(&pdata->attr_list);
> +	platform_set_drvdata(pdev, pdata);
> +
> +	/* Create platform device 'name' attribute */
> +	sysfs_attr_init(&pdata->name_attr.attr);
> +	pdata->name_attr.attr.name =3D "name";
> +	pdata->name_attr.attr.mode =3D S_IRUGO;
> +	pdata->name_attr.show =3D show_name;
> +	err =3D device_create_file(dev, &pdata->name_attr);

You don't need to create a name attribute.
devm_hwmon_device_register_with_groups does it for you (from the second
argument).

> +	if (err)
> +		goto exit;
> +
> +	/* Create sysfs attribute file for each sensor found in the DT */
> +	err =3D create_device_attrs(pdev);

That defeats the purpose of using devm_hwmon_device_register_with_groups.
The idea here is to build a list of attributes, which you can do in
create_device_attrs(), but not create the actual device entries.
Then also create an attribute_group as well as a list of groups,
and pass that as last argument to devm_hwmon_device_register_with_groups().

drivers/hwmon/pmbus/pmbus_core.c does something similar; maybe you can
use a similar approach.

With that, you also don't need the remove functions, since the hwmon
subsystem will auto-remove the attributes. If you do it correctly=20
(ie use devm_kzalloc() for allocating memory) you should not need a
remove function at all.

> +	if (err) {
> +		pr_err("%s: Failed to create the device attributes\n",
> +				__func__);
> +		goto exit_remove_name;
> +	}
> +
> +	/* Finally, register with hwmon */
> +	pdata->hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, DRVNAM=
E,
> +			pdata, NULL);
> +	if (IS_ERR(pdata->hwmon_dev)) {
> +		err =3D PTR_ERR(pdata->hwmon_dev);
> +		goto exit_remove_devattrs;
> +	}
> +
> +	return 0;
> +
> +exit_remove_devattrs:
> +	remove_device_attrs(pdev);
> +exit_remove_name:
> +	device_remove_file(dev, &pdata->name_attr);
> +exit:
> +	return err;

If you do it right you should be able to reduce this to something like

	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, DRVNAME, pdata,
							   pdata->attr_groups);
	return PTR_ERR_OR_ZERO(hwmon_dev);

...

> +}
> +
> +static int ibmpowernv_remove(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata =3D platform_get_drvdata(pdev);
> +	struct device *dev =3D &pdev->dev;
> +
> +	remove_device_attrs(pdev);
> +	device_remove_file(dev, &pdata->name_attr);
> +
> +	return 0;
> +}

... and you should be able to remove this entire function.

> +
> +
No double empty lines please.

> +static struct platform_driver ibmpowernv_driver =3D {
> +	.driver =3D {
> +		.owner =3D THIS_MODULE,
> +		.name =3D DRVNAME,
> +	},
> +	.probe =3D ibmpowernv_probe,
> +	.remove =3D ibmpowernv_remove,
> +};
> +
> +
Excessive empty lines.

> +static int __init ibmpowernv_init(void)
> +{
> +	int err;
> +
> +
Excessive empty lines.

> +	err =3D platform_driver_register(&ibmpowernv_driver);
> +	if (err)
> +		goto exit;

Sometimes you create an error message, sometimes not. I'd prefer no error
message to start with (the module loader will create one anyway), but
at least please be consistent.

> +
> +
Excessive empty lines.

> +	pdevice =3D platform_device_alloc(DRVNAME, 0);
> +	if (!pdevice) {
> +		pr_err("%s: Device allocation failed\n", __func__);
> +		err =3D -ENOMEM;
> +		goto exit_driver_unreg;
> +	}
> +
> +	err =3D platform_device_add(pdevice);
> +	if (err) {
> +		pr_err("%s: Device addition failed (%d)\n", __func__, err);
> +		goto exit_device_put;
> +	}
> +
Can you use platform_driver_probe() here ?

> +	return 0;
> +
> +exit_device_put:
> +	platform_device_put(pdevice);
> +exit_driver_unreg:
> +	platform_driver_unregister(&ibmpowernv_driver);
> +exit:
> +	return err;
> +}
> +
> +static void __exit ibmpowernv_exit(void)
> +{
> +	platform_device_unregister(pdevice);
> +	platform_driver_unregister(&ibmpowernv_driver);
> +}
> +
> +MODULE_DESCRIPTION("IBM POWERNV platform sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(ibmpowernv_init);
> +module_exit(ibmpowernv_exit);
>=20
>=20
Empty lines at end.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
