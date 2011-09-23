From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 23 Sep 2011 02:12:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: OMAP4460+: On die temperature
Message-Id: <CAJ6a13a_YbEUtrYFztYw-piaEQOmsky=-ZTeuv48oCSuuBdgDQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316713013-14751-1-git-send-email-j-keerthy@ti.com>
	<1316713841.3888.6.camel@groeck-laptop>
In-Reply-To: <1316713841.3888.6.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

Thanks for your quick review comments.

On Thu, Sep 22, 2011 at 11:20 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, 2011-09-22 at 13:36 -0400, Keerthy wrote:
>> On chip temperature sensor driver. The driver monitors the temperature of
>> on die subsystems. It sends notifications to the user space if
>> the temperature crosses user defined thresholds via kobject_uevent inter=
face.
>> The user is allowed to configure the temperature thresholds vis sysfs no=
des
>> exposed using hwmon interface.
>>
>> The patch depends on the the following series:
>> http://comments.gmane.org/gmane.linux.ports.arm.omap/64436
>> and
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/64446
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>> =A0Documentation/hwmon/omap_temp_sensor =A0 =A0 | =A0 25 +++
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11=
 ++
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01=
 +
>> =A0drivers/hwmon/omap4460plus_temp_sensor.c | =A0244 +++++++++++++++++++=
+++++++++++
>> =A04 files changed, 281 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>> =A0create mode 100644 drivers/hwmon/omap4460plus_temp_sensor.c
>>
>> Index: linux-omap-2.6/Documentation/hwmon/omap_temp_sensor
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- /dev/null 1970-01-01 00:00:00.000000000 +=
0000
>> +++ linux-omap-2.6/Documentation/hwmon/omap_temp_sensor =A0 =A0 =A0 2011=
-09-22 18:57:23.180918857 +0530
>> @@ -0,0 +1,25 @@
>> +Kernel driver omap_temp_sensor
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Supported chips:
>> + =A0* Texas Instruments OMAP4460
>> + =A0 =A0Prefix: 'omap_temp_sensor'
>> +
>> +Author:
>> + =A0 =A0 =A0 =A0J Keerthy <j-keerthy@ti.com>
>> +
>> +Description
>> +-----------
>> +
>> +The Texas Instruments OMAP4 family of chips have a bandgap temperature =
sensor.
>> +The temperature sensor feature is used to convert the temperature of th=
e device
>> +into a decimal value coded on 10 bits. An internal ADC is used for conv=
ersion.
>> +The recommended operating temperatures must be in the range -40 degree =
Celsius
>> +to 123 degree celsius for standard conversion.
>> +The thresholds are programmable and upon crossing the thresholds an int=
errupt
>> +is generated. The OMAP temperature sensor has a programmable update rat=
e in
>> +milli seconds.
>> +(Currently the driver programs a default of 2000 milliseconds).
>> +
>> +The driver provides the common sysfs-interface for temperatures (see
>> +Documentation/hwmon/sysfs-interface under Temperatures).
>> Index: linux-omap-2.6/drivers/hwmon/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- linux-omap-2.6.orig/drivers/hwmon/Kconfig=
 2011-09-22 17:48:38.032575702 +0530
>> +++ linux-omap-2.6/drivers/hwmon/Kconfig =A0 =A0 =A02011-09-22 19:02:28.=
744575604 +0530
>> @@ -323,6 +323,17 @@
>> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the=
 module
>> =A0 =A0 =A0 =A0 will be called f71805f.
>>
>> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
>> + =A0 =A0 bool "OMAP on-die temperature sensor hwmon driver"
>> + =A0 =A0 depends on HWMON && ARCH_OMAP && OMAP4460PLUS_SCM
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you say yes here you get support for hardware
>> + =A0 =A0 =A0 monitoring features of the OMAP on die temperature
>> + =A0 =A0 =A0 sensor.
>> +
>> + =A0 =A0 =A0 Continuous conversion programmable delay
>> + =A0 =A0 =A0 mode is used for temperature conversion.
>> +
>> =A0config SENSORS_F71882FG
>> =A0 =A0 =A0 tristate "Fintek F71882FG and compatibles"
>> =A0 =A0 =A0 help
>> Index: linux-omap-2.6/drivers/hwmon/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- linux-omap-2.6.orig/drivers/hwmon/Makefil=
e =A0 =A0 =A0 =A02011-09-22 17:48:38.020575728 +0530
>> +++ linux-omap-2.6/drivers/hwmon/Makefile =A0 =A0 2011-09-22 18:57:23.19=
2574712 +0530
>> @@ -93,6 +93,7 @@
>> =A0obj-$(CONFIG_SENSORS_MAX6642) =A0 =A0 =A0 =A0+=3D max6642.o
>> =A0obj-$(CONFIG_SENSORS_MAX6650) =A0 =A0 =A0 =A0+=3D max6650.o
>> =A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
>> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap4460plus_tem=
p_sensor.o
>> =A0obj-$(CONFIG_SENSORS_NTC_THERMISTOR) +=3D ntc_thermistor.o
>> =A0obj-$(CONFIG_SENSORS_PC87360) =A0 =A0 =A0 =A0+=3D pc87360.o
>> =A0obj-$(CONFIG_SENSORS_PC87427) =A0 =A0 =A0 =A0+=3D pc87427.o
>> Index: linux-omap-2.6/drivers/hwmon/omap4460plus_temp_sensor.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- /dev/null 1970-01-01 00:00:00.000000000 +=
0000
>> +++ linux-omap-2.6/drivers/hwmon/omap4460plus_temp_sensor.c =A0 2011-09-=
22 19:02:11.096575567 +0530
>> @@ -0,0 +1,242 @@
>> +/*
>> + *
>> + * OMAP4460 Plus bandgap on die sensor hwmon driver.
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.co=
m/
>> + * J Keerthy <j-keerthy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/i2c/twl.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c/twl4030-madc.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/stddef.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/err.h>
>> +#include <linux/types.h>
>> +#include <plat/scm.h>
>> +
>> +static ssize_t show_name(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *at=
tr, char *buf)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 return sprintf(buf, tsh->name);
>> +}
>> +
>> +static ssize_t show_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attri=
bute *devattr, char *buf)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id;
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 temp =3D omap4460plus_scm_show_temp_max(tsh->scm_ptr, id);
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribut=
e *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_=
t count)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id, ret;
>> + =A0 =A0 long val;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 ret =3D omap4460plus_scm_set_temp_max(tsh->scm_ptr, id, val);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev=
ice_attribute *devattr, char *buf)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id;
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 temp =3D omap4460plus_scm_show_temp_max_hyst(tsh->scm_ptr, id);
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devi=
ce_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char =
*buf, size_t count)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id, ret;
>> + =A0 =A0 long val;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Value range [-MAXLONG, MAXLONG] is ok for set functions ? Or does the
> called functions check the range ?

It is checked in the called function. I will enforce a more stringent check
in the called function.

>
>> + =A0 =A0 ret =3D omap4460plus_scm_set_temp_max_hyst(tsh->scm_ptr, id, v=
al);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_update_interval(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 device_attribute *devattr, char *buf)
>> +{
>> + =A0 =A0 int time =3D 0;
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id;
>> +
>> + =A0 =A0 time =3D omap4460plus_scm_show_update_interval(tsh->scm_ptr, i=
d);
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", time);
>> +}
>> +
>> +static ssize_t set_update_interval(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
device_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const c=
har *buf, size_t count)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id;
>> + =A0 =A0 long val;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> +
> This is really odd. You are going to return an error, yet set the update
> interval to whatever happens to be in val even if it was not set (unless
> that value is < 0).
>
> You should directly return -EINVAL here. Also, since you don't accept
> negative values, you might as well use strict_strtoul() instead.

Ok. I will return -EINVAL.

>
>> +
>> + =A0 =A0 if (val < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> The value range [0, MAXLONG] is ok ?

I will define an thresholds for this.

>
>> + =A0 =A0 omap4460plus_scm_set_update_interval(tsh->scm_ptr, val, id);
>> + =A0 =A0 return count;
>> +}
>> +
>> +static int read_temp(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *devattr, c=
har *buf)
>> +{
>> + =A0 =A0 struct temp_sensor_hwmon *tsh =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct platform_device, dev);
>> + =A0 =A0 int id =3D pdev->id;
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 temp =3D omap4460plus_scm_read_temp(tsh->scm_ptr, id);
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +}
>> +
>> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, read_temp, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_=
max_hyst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);
>> +static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_update_interval, set_=
update_interval, 0);
>> +
>> +static struct attribute *temp_sensor_attributes[] =3D {
>> + =A0 =A0 &dev_attr_name.attr,
>> +
>> + =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_update_interval.dev_attr.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group temp_sensor_group =3D {
>> + =A0 =A0 .attrs =3D temp_sensor_attributes,
>> +};
>> +
>> +static int __devinit omap4460plus_temp_sensor_probe(struct platform_dev=
ice
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pdev)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct device *hwmon;
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj, &temp_sensor_group=
);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysfs;
>> + =A0 =A0 hwmon =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 if (IS_ERR(hwmon)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register fai=
led.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(hwmon);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_reg:
>> + =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &temp_sensor_group);
>> +err_sysfs:
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit omap4460plus_temp_sensor_remove(struct platform_de=
vice
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pdev)
>> +{
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &temp_sensor_group);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap4460plus_temp_sensor_driver =3D {
>> + =A0 =A0 .probe =3D omap4460plus_temp_sensor_probe,
>> + =A0 =A0 .remove =3D omap4460plus_temp_sensor_remove,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "temp_sensor_hwmon",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> +};
>> +
>> +int __init omap4460plus_temp_sensor_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap4460plus_temp_sensor_driv=
er);
>> +}
>> +
>> +module_init(omap4460plus_temp_sensor_init);
>> +
>> +static void __exit omap4460plus_temp_sensor_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&omap4460plus_temp_sensor_driver);
>> +}
>> +
>> +module_exit(omap4460plus_temp_sensor_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP446X temperature sensor Hwmon Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
