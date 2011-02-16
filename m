From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Wed, 16 Feb 2011 18:11:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: twl4030: Hwmon Driver for
Message-Id: <AANLkTimEUA0ifx=FoNL1ACqFveG0pHEJ4fpcFMAQxvxB@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297861017-10057-1-git-send-email-j-keerthy@ti.com>
	<20110216160948.GB14199@ericsson.com>
In-Reply-To: <20110216160948.GB14199@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Guenter,

On Wed, Feb 16, 2011 at 9:39 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Wed, Feb 16, 2011 at 07:56:57AM -0500, Keerthy wrote:
>> This driver exposes the sysfs nodes of the TWL4030 MADC module.
>> All the channel values are expressed in terms of mV. Channel 13
>> and channel 14 are reserved. There are channels which represent
>> temperature and current. Even they output raw voltage in mV.
>>
> Why ?

The conversion to current and temperature in case of MADC depends
on a register in the battery module. Hence battery driver can expose the
converted value. So providing the raw voltage here.
>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> The previous discussion concluded in keeping the generic ADC
>> functionality and the hwmon separate. The discussion can be found here:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
>>
>> =A0Documentation/hwmon/twl4030-madc-hwmon | =A0 45 +++++++++
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 ++
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/twl4030-madc-hwmon.c =A0 =A0 | =A0155 +++++++++++++++++=
+++++++++++++++
>> =A04 files changed, 211 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
>> =A0create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
>>
>> diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwmo=
n/twl4030-madc-hwmon
>> new file mode 100644
>> index 0000000..2cf1cc2
>> --- /dev/null
>> +++ b/Documentation/hwmon/twl4030-madc-hwmon
>> @@ -0,0 +1,45 @@
>> +Kernel driver twl4030-madc
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>> +
>> +Supported chips:
>> + =A0 =A0 * Texas Instruments TWL4030
>> + =A0 =A0 Prefix: 'twl4030-madc'
>> +
>> +
>> +Authors:
>> + =A0 =A0 J Keerthy <j-keerthy@ti.com>
>> +
>> +Description
>> +-----------
>> +
>> +The Texas Instruments TWL4030 is a Power Management and Audio Circuit. =
Among
>> +other things it contains a 10-bit A/D converter MADC. The converter has=
 16
>> +channels which can be used in different modes.
>> +
>> +
>> +See this table for the meaning of the different channels
>> +
>> +Channel Signal
>> +------------------------------------------
>> +0 =A0 =A0Battery type(BTYPE)
>> +1 =A0 =A0BCI: Battery temperature (BTEMP)
>> +2 =A0 =A0GP analog input
>> +3 =A0 =A0GP analog input
>> +4 =A0 =A0GP analog input
>> +5 =A0 =A0GP analog input
>> +6 =A0 =A0GP analog input
>> +7 =A0 =A0GP analog input
>> +8 =A0 =A0BCI: VBUS voltage(VBUS)
>> +9 =A0 =A0Backup Battery voltage (VBKP)
>> +10 =A0 BCI: Battery charger current (ICHG)
>> +11 =A0 BCI: Battery charger voltage (VCHG)
>> +12 =A0 BCI: Main battery voltage (VBAT)
>> +13 =A0 Reserved
>> +14 =A0 Reserved
>> +15 =A0 VRUSB Supply/Speaker left/Speaker right polarization level
>> +
>> +
>> +The Sysfs nodes will represent the voltage in the units of mV,
>> +the temperature channel shows the converted raw voltage in mV.
>> +The Battery charging current channel represents raw voltage mV.
>
> Doesn't really make sense to me to export values known to be current and =
temperature
> as voltages. You'll have to add a lot more information for that to make s=
ense.
>

As mentioned earlier the raw voltage to current conversion depends on the C=
GAIN
bit of the BCICTL1 battery register. Hence i preferrd not to include
the conversion
here.

>> +Channel 13 and 14 are reserved.
>
> You already said that above.

Ok i will remove this.
>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 773e484..11ddde3 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -940,6 +940,16 @@ config SENSORS_TMP421
>> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the=
 module
>> =A0 =A0 =A0 =A0 will be called tmp421.
>>
>> +config SENSORS_TWL4030_MADC
>> + =A0 =A0 tristate "Texas Instruments TWL4030 MADC Hwmon"
>> + =A0 =A0 depends on TWL4030_MADC
>> + =A0 =A0 help
>> + =A0 =A0 This driver provides hwmon support for triton TWL4030-MADC.
>> + =A0 =A0 This driver can be built as part of kernel or can be built
>> + =A0 =A0 as a module.
>
> =A0 =A0 =A0 =A0Kernel is obvious. Please stick with the usual text
>

Ok.
> =A0 =A0 =A0 =A0"This driver can also be built as a module. =A0If so, the =
module
> =A0 =A0 =A0 =A0 will be called XXXX"
>
> At least please tell users how the module is named.
>

Ok. I will add it.
>> + =A0 =A0 =A0 =A0 =A0 =A0 This driver exposes the various voltage values=
 to
>> + =A0 =A0 the user space.
>> +
> Not sure if this provides any value. Either case, it should be before "bu=
ilt as module".
>

Ok.
>> =A0config SENSORS_VIA_CPUTEMP
>> =A0 =A0 =A0 tristate "VIA CPU temperature sensor"
>> =A0 =A0 =A0 depends on X86
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index dde02d9..bc7d740 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -102,6 +102,7 @@ obj-$(CONFIG_SENSORS_THMC50) =A0 =A0 =A0+=3D thmc50.o
>> =A0obj-$(CONFIG_SENSORS_TMP102) +=3D tmp102.o
>> =A0obj-$(CONFIG_SENSORS_TMP401) +=3D tmp401.o
>> =A0obj-$(CONFIG_SENSORS_TMP421) +=3D tmp421.o
>> +obj-$(CONFIG_SENSORS_TWL4030_MADC)+=3D twl4030-madc-hwmon.o
>> =A0obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+=3D via-cputemp.o
>> =A0obj-$(CONFIG_SENSORS_VIA686A) =A0 =A0 =A0 =A0+=3D via686a.o
>> =A0obj-$(CONFIG_SENSORS_VT1211) +=3D vt1211.o
>> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-=
madc-hwmon.c
>> new file mode 100644
>> index 0000000..4a61e8a
>> --- /dev/null
>> +++ b/drivers/hwmon/twl4030-madc-hwmon.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + *
>> + * TWL4030 MADC Hwmon driver-This driver monitors the real time
>> + * conversion of analog signals like battery temperature,
>> + * battery type, battery level etc. User can ask for the conversion on a
>> + * particular channel using the sysfs nodes.
>> + *
>> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.co=
m/
>
> 2011 ?

Oops missed it. I will correct it.
>
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
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c/twl.h>
>> +#include <linux/i2c/twl4030-madc.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +
>> +/*
>> + * sysfs hook function
>> + */
>> +static ssize_t madc_read(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *de=
vattr, char *buf)
>> +{
>> + =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_attr(de=
vattr);
>> + =A0 =A0 struct twl4030_madc_request req;
>> + =A0 =A0 long val;
>> +
>> + =A0 =A0 req.channels =3D (1 << attr->index);
>> + =A0 =A0 req.method =3D TWL4030_MADC_SW2;
>> + =A0 =A0 req.func_cb =3D NULL;
>> + =A0 =A0 val =3D twl4030_madc_conversion(&req);
>> + =A0 =A0 if (val >=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D req.rbuf[attr->index];
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return val;
>> +
> Seems to be a bit complicated.
>
> =A0 =A0 =A0 =A0if (val < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return val;
>
> =A0 =A0 =A0 =A0return sprintf(buf, "%ld\n", req.rbuf[attr->index]);
>
> would be more straightforward.
>

Ok.
>> + =A0 =A0 return sprintf(buf, "%ld\n", val);
>> +}
>> +
>> +/* sysfs nodes to read individual channels from user side */
>> +static SENSOR_DEVICE_ATTR(in0_battery_type, S_IRUGO, madc_read, NULL, 0=
);
>> +static SENSOR_DEVICE_ATTR(in1_battery_temp, S_IRUGO, madc_read, NULL, 1=
);
>
> I don't know why people always try to introduce new sysfs attributes
> for no good reason. Use a label if you want to describe the sensor.
> And use tempX_input for temperatures, and currX_input for currents.
>

Since i was providing the raw voltages i stuck to inX_ naming for even
the cuurent and
temperature attributes. I will change them.

> I am not inclined to accept drivers introducing new sysfs attributes,
> unless the new attribute has either been discussed and added to the ABI,
> or if a _really_ good reason for the non-standard attribute is provided.
> Neither is the case here.
>

Ok. I get the point.
>> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
>> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
>> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
>> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
>> +static SENSOR_DEVICE_ATTR(in8_vbus, S_IRUGO, madc_read, NULL, 8);
>> +static SENSOR_DEVICE_ATTR(in9_vbkp, S_IRUGO, madc_read, NULL, 9);
>> +static SENSOR_DEVICE_ATTR(in10_battery_charger_current,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO, madc_read, NULL, 10);
>> +static SENSOR_DEVICE_ATTR(in11_battery_charger_voltage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO, madc_read, NULL, 11);
>> +static SENSOR_DEVICE_ATTR(in12_main_battery_voltage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO, madc_read, NULL, 12);
>
> ... and again ...

I will correct it.
>
>> +static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
>> +
>
> Number sequence doesn't have to match chip channel number.
> Sure you want to leave a hole here ?

13, 14 channels are reserved. Hence left the gap. Followed with the
chip channel numbers.
>
> Either case, you should describe in the documentation how chip channels
> match attribute names.
>

Ok i will add a description.
>> +static struct attribute *twl4030_madc_attributes[] =3D {
>> + =A0 =A0 &sensor_dev_attr_in0_battery_type.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in1_battery_temp.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in2_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in3_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in4_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in5_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in6_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in7_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in8_vbus.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in9_vbkp.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in10_battery_charger_current.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in11_battery_charger_voltage.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in12_main_battery_voltage.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in15_input.dev_attr.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group twl4030_madc_group =3D {
>> + =A0 =A0 .attrs =3D twl4030_madc_attributes,
>> +};
>> +
>> +static int __devinit twl4030_madc_hwmon_probe(struct platform_device *p=
dev)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 int status;
>> + =A0 =A0 struct device *hwmon;
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_grou=
p);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysfs;
>> + =A0 =A0 hwmon =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 if (IS_ERR(hwmon)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register fai=
led.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(hwmon);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_reg:
>> + =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
>> +err_sysfs:
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit twl4030_madc_hwmon_remove(struct platform_device *=
pdev)
>> +{
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver twl4030_madc_hwmon_driver =3D {
>> + =A0 =A0 .probe =3D twl4030_madc_hwmon_probe,
>> + =A0 =A0 .remove =3D __exit_p(twl4030_madc_hwmon_remove),
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "twl4030_madc_hwmon",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> +};
>> +
>> +static int __init twl4030_madc_hwmon_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&twl4030_madc_hwmon_driver);
>> +}
>> +
>> +module_init(twl4030_madc_hwmon_init);
>> +
>> +static void __exit twl4030_madc_hwmon_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&twl4030_madc_hwmon_driver);
>> +}
>> +
>> +module_exit(twl4030_madc_hwmon_exit);
>> +
>> +MODULE_DESCRIPTION("TWL4030 ADC Hwmon driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("J Keerthy");
>> +MODULE_ALIAS("twl4030_madc_hwmon");
>> --
>> 1.7.0.4
>>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
