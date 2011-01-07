From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 07 Jan 2011 09:37:45 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <AANLkTinuwejAgJ+F0e4LFAhR-gL8bfFmyOwHdSEWAsRw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294286200-16446-1-git-send-email-j-keerthy@ti.com>
	<20110106120433.GC17184@sirena.org.uk>
In-Reply-To: <20110106120433.GC17184@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, linux-omap@vger.kernel.org, amit.kucheria@canonical.com, balajitk@ti.com

On Thu, Jan 6, 2011 at 5:34 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jan 06, 2011 at 09:26:40AM +0530, Keerthy wrote:
>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/twl4030-madc.c =A0 =A0 | =A0794 +++++++++++++++++++++++=
+++++++++++++++
>> =A0include/linux/i2c/twl4030-madc.h | =A0118 ++++++
>> =A04 files changed, 924 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/twl4030-madc.c
>> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>
> hwmon drivers are also expected to have a file under Documentation.

I will add a documentation file.
>
>> +struct twl4030_madc_data {
>> + =A0 =A0 struct device *hwmon_dev;
>> + =A0 =A0 struct mutex lock;/* mutex protecting this data structire */
>> + =A0 =A0 struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
>> + =A0 =A0 int imr;
>> + =A0 =A0 int isr;
>> +};
>
>> +static struct twl4030_madc_data *twl4030_madc;
>
> I'd expect this to be per driver instance rather than global (I know
> it's vanishingly unlikely that you'll get multiple twl4030s in a single
> system but it's nicer).
>
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
>> + =A0 =A0 return sprintf(buf, "%ld\n", val);
>
> Does this return data in the appropriate units - milivolts for voltages?

This function returns the raw channel values read and not in terms of the
units.
>
>> +/*
>> + * Enables irq.
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @id - irq number to be enabled
>> + * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
>> + * corresponding to RT, SW1, SW2 conversion requests.
>> + * If the i2c read fails it returns an error else returns 0.
>> + */
>> +static int twl4030_madc_enable_irq(struct twl4030_madc_data *madc, int =
id)
>
> It'd be good to clarify that this is interrupt sources within this
> module rather than Linux interrupt numbers.
Ok.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Disable interrupt failed%d\n"=
, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 madc->requests[i].result_pending =3D 1;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_lock(&madc->lock);
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
>
> In general through the driver your use of blank lines is really odd
> which doesn't help readability.
Ok. I will correct it.
>
>> + =A0 =A0 switch (conv_method) {
>> + =A0 =A0 case TWL4030_MADC_SW1:
>> + =A0 =A0 case TWL4030_MADC_SW2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_SW_START, method-=
>ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write ctrl register=
 0x%X\n", method->ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case TWL4030_MADC_RT:
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This looks odd - the function won't actually do anything for non-SW
> conversions but won't return an error?

Ok. In the case of RT conversion request no software setting is required
and it is signal driven. So the function does nothing in case of RT.
>
>> +/* sysfs nodes to read individual channels from user side */
>> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, madc_read, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
>> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
>> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
>> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
>> +static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
>> +static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
>> +static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, madc_read, NULL, 10);
>> +static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
>> +static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
>> +static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, madc_read, NULL, 13);
>> +static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, madc_read, NULL, 14);
>> +static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
>
> I suspect some of these are temperatures, some are voltages and that
> some are fixed to particular inputs? =A0The temperatures should be temp_
> and if the inputs are from known sources it'd be good to label them.

Yes some are voltages and some are fixed to particular inputs.
I will label them.
>
>> + =A0 =A0 madc->imr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
>> + =A0 =A0 madc->isr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
>
> This looks really odd - what's going on here? =A0Comments might help.

Phoenix provides 2 interrupt lines. The first one is connected to
the OMAP. The other one can be connected to other processor.
So this check. I will add comments.
>
>> +
>> +MODULE_DESCRIPTION("TWL4030 ADC driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("J Keerthy");
>
> A MODULE_ALIAS to enable automatic loading of teh driver would also be
> good.

Ok.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
