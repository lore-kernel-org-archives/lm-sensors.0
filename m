From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 26 Nov 2010 06:44:11 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <AANLkTinkKwj8Mi4zzgrLGqNyfbmwU_KrKLRzr8pXOsFp@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
	<20101111000159.GA22073@ericsson.com>
	<AANLkTiniRxNoNn9bSR+PN8B=m6=YVWS8Na_vJUdi1QhT@mail.gmail.com>
In-Reply-To: <AANLkTiniRxNoNn9bSR+PN8B=m6=YVWS8Na_vJUdi1QhT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: lm-sensors@lm-sensors.org, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, "Balbi, Felipe" <balbi@ti.com>, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Thu, Nov 11, 2010 at 5:31 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Tue, Nov 09, 2010 at 04:20:57AM -0500, Keerthy wrote:
>> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for
> monitoring
>> ADC. This driver monitors the real time conversion of analog signals
> like
>> battery temperature, battery type, battery level etc. User can also ask
> for
>> the conversion on a particular channel using the sysfs nodes.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> Again, I am not sure if this driver belongs into hwmon, since it is not
> really a hardware monitoring chip but a generic adc. We'll have to sort
> that out.

Since hwmon is the place where most of the ADC drivers are residing.
MADC is also an ADC. We feel that hwmon is the right place.

>
> Code looks much better than before. Still not a complete review; you
> should
> have a much closer look at error handling. I am sure I missed several
> cases
> where error returns are ignored.
>
> Thanks,
> Guenter
>
>> ---
>>
>> Several people have contributed to this driver on the linux-omap list.
>>
>> V2:
>>
>> Error path correction in probe function.
>> Return checks added.
>> the_madc pointer could not be removed. The external drivers will not be
> knowing
>> device information of the madc.
>> Added another function which takes the channel number alone and returns
>> the channel reading if the caller wants TWL4030_MADC_SW2 method for ADC
> conversion.
>> IOCTL function is removed.
>> Work struct is completely removed since request_threaded_irq is used.
>>
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/twl4030-madc.c =A0 =A0 | =A0573
> ++++++++++++++++++++++++++++++++++++++
>> =A0include/linux/i2c/twl4030-madc.h | =A0118 ++++++++
>> =A04 files changed, 698 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/twl4030-madc.c
>> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>>
>> V1:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34947.html
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index a56f6ad..fef75f2 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1171,6 +1171,12 @@ config SENSORS_MC13783_ADC
>> =A0 =A0 =A0 =A0 =A0help
>> =A0 =A0 =A0 =A0 =A0 =A0Support for the A/D converter on MC13783 PMIC.
>>
>> +config SENSORS_TWL4030_MADC
>> + =A0 =A0 =A0 tristate
>> + =A0 =A0 =A0 depends on TWL4030_CORE
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This driver provides support for TWL4030-MADC.
>> +
>
> Besides adding a description, you might alwo want to move this to the
> other
> TI chips.
>

I will move this to the other TI Chips.

>> =A0if ACPI
>>
>> =A0comment "ACPI drivers"
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 2479b3d..a54af22 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -100,6 +100,7 @@ obj-$(CONFIG_SENSORS_THMC50) =A0 =A0 =A0 =A0+=3D thm=
c50.o
>> =A0obj-$(CONFIG_SENSORS_TMP102) =A0 +=3D tmp102.o
>> =A0obj-$(CONFIG_SENSORS_TMP401) =A0 +=3D tmp401.o
>> =A0obj-$(CONFIG_SENSORS_TMP421) =A0 +=3D tmp421.o
>> +obj-$(CONFIG_SENSORS_TWL4030_MADC)+=3D twl4030-madc.o
>> =A0obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+=3D via-cputemp.o
>> =A0obj-$(CONFIG_SENSORS_VIA686A) =A0+=3D via686a.o
>> =A0obj-$(CONFIG_SENSORS_VT1211) =A0 +=3D vt1211.o
>> diff --git a/drivers/hwmon/twl4030-madc.c b/drivers/hwmon/twl4030-madc.c
>> new file mode 100644
>> index 0000000..42f7d4a
>> --- /dev/null
>> +++ b/drivers/hwmon/twl4030-madc.c
>> @@ -0,0 +1,573 @@
>> +/*
>> + *
>> + * TWL4030 MADC module driver-This driver monitors the real time
>> + * conversion of analog signals like battery temperature,
>> + * battery type, battery level etc. User can also ask for the
> conversion on a
>> + * particular channel using the sysfs nodes.
>> + *
>> + * Copyright (C) 2010 Texas Instruments Inc.
>> + * J Keerthy <j-keerthy@ti.com>
>> + *
>> + * Based on twl4030-madc.c
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
>> + *
>> + * Amit Kucheria <amit.kucheria@canonical.com>
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
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/i2c/twl.h>
>> +#include <linux/i2c/twl4030-madc.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/uaccess.h>
>> +
>> +struct twl4030_madc_data {
>> + =A0 =A0 =A0 struct device *hwmon_dev;
>> + =A0 =A0 =A0 struct mutex lock;
>> + =A0 =A0 =A0 struct twl4030_madc_request requests[TWL4030_MADC_NUM_METH=
ODS];
>> + =A0 =A0 =A0 int imr;
>> + =A0 =A0 =A0 int isr;
>> +};
>> +
>> +static struct twl4030_madc_data *the_madc;
>> +
>> +static ssize_t madc_read(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute=
 *devattr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct sensor_device_attribute *attr > to_sensor_dev_attr(=
devattr);
>> + =A0 =A0 =A0 struct twl4030_madc_request req;
>> + =A0 =A0 =A0 int status;
>> + =A0 =A0 =A0 long val;
>> +
>> + =A0 =A0 =A0 req.channels =3D (1 << attr->index);
>> + =A0 =A0 =A0 req.method =3D TWL4030_MADC_SW2;
>> + =A0 =A0 =A0 req.func_cb =3D NULL;
>> +
>> + =A0 =A0 =A0 val =3D twl4030_madc_conversion(&req);
>> + =A0 =A0 =A0 if (likely(val >=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D req.rbuf[attr->index];
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val;
>> + =A0 =A0 =A0 status =3D sprintf(buf, "%ld\n", val);
>> + =A0 =A0 =A0 return status;
>
>
> =A0 =A0 =A0 =A0if (unlikely(val < 0))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return val;
>
> =A0 =A0 =A0 =A0return sprintf(buf, "%ld\n", req.rbuf[attr->index]);
>
> should do and would be simpler. status is not needed at all.
>

Ok i will remove.

>> +}
>> +
>> +static
>> +const struct twl4030_madc_conversion_method
> twl4030_conversion_methods[] =3D {
>> + =A0 =A0 =A0 [TWL4030_MADC_RT] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sel =3D TWL403=
0_MADC_RTSELECT_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.avg =3D TWL403=
0_MADC_RTAVERAGE_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.rbase =3D TWL4=
030_MADC_RTCH0_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 [TWL4030_MADC_SW1] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sel =3D TWL40=
30_MADC_SW1SELECT_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .avg =3D TWL40=
30_MADC_SW1AVERAGE_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rbase =3D TWL=
4030_MADC_GPCH0_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =3D TWL4=
030_MADC_CTRL_SW1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 [TWL4030_MADC_SW2] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sel =3D TWL40=
30_MADC_SW2SELECT_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .avg =3D TWL40=
30_MADC_SW2AVERAGE_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rbase =3D TWL=
4030_MADC_GPCH0_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =3D TWL4=
030_MADC_CTRL_SW2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> +};
>> +
>> +static int twl4030_madc_read(struct twl4030_madc_data *madc, u8 reg)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 val;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, reg);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read r=
egister
> 0x%X\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return val;
>> +}
>> +
>> +static void twl4030_madc_write(struct twl4030_madc_data *madc, u8 reg,
> u8 val)
>> +{
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, val, reg);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write register =
0x%X\n", reg);
>> +}
>
> Looking into other uses of twl_i2c_write_u8(), most check and return
> errors.
> Not sure if it is a good idea to ignore all errors as it is done here.
> There
> should at least some comment explaining that and why it is done.
>

Ok. Error check will be in place.

>> +
>> +static int twl4030_madc_channel_raw_read(struct twl4030_madc_data
> *madc, u8 reg)
>> +{
>> + =A0 =A0 =A0 u8 msb, lsb;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* For each ADC channel, we have MSB and LSB register pa=
ir. MSB
> address
>> + =A0 =A0 =A0 =A0* is always LSB address+1. reg parameter is the addr of=
 LSB
> register
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 msb =3D twl4030_madc_read(madc, reg + 1);
>> + =A0 =A0 =A0 lsb =3D twl4030_madc_read(madc, reg);
>> +
> Ignoring returned errors and combining them into a random value doesn't
> make much sense.

Return checks will be added.

>
>> + =A0 =A0 =A0 return (int)(((msb << 8) | lsb) >> 6);
>> +}
>> +
>> +static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 u8 reg_base, u16 channels, int
> *buf)
>> +{
>> + =A0 =A0 =A0 int count =3D 0;
>> + =A0 =A0 =A0 u8 reg, i;
>> +
>> + =A0 =A0 =A0 if (unlikely(!buf))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
> I don't see how this can ever be NULL.

Ok i will remove it.

>
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1 << i)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2 * i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_ch=
annel_raw_read(madc,
> reg);
>
> Content of buf will be more or less random after errors.

Ok i will add a return check for every iteration.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static void twl4030_madc_enable_irq(struct twl4030_madc_data *madc, int
> id)
>> +{
>> + =A0 =A0 =A0 u8 val;
>> +
>> + =A0 =A0 =A0 val =3D twl4030_madc_read(madc, madc->imr);
>
> What if twl4030_madc_read() returned an error ? Try to write a random
> value ?
>
>> + =A0 =A0 =A0 val &=3D ~(1 << id);
>> + =A0 =A0 =A0 twl4030_madc_write(madc, madc->imr, val);
>> +}
>> +
>> +static void twl4030_madc_disable_irq(struct twl4030_madc_data *madc,
> int id)
>> +{
>> + =A0 =A0 =A0 u8 val;
>> +
>> + =A0 =A0 =A0 val =3D twl4030_madc_read(madc, madc->imr);
>
> Returned error ignored.

Return checks will be added for read followed by writes.

>
>> + =A0 =A0 =A0 val |=3D (1 << id);
>> + =A0 =A0 =A0 twl4030_madc_write(madc, madc->imr, val);
>> +}
>> +
>> +static irqreturn_t twl4030_madc_irq_handler(int irq, void *_madc)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 =A0 u8 isr_val, imr_val;
>> + =A0 =A0 =A0 int i, len;
>> + =A0 =A0 =A0 struct twl4030_madc_request *r;
>> +
>> + =A0 =A0 =A0 isr_val =3D twl4030_madc_read(madc, madc->isr);
>> + =A0 =A0 =A0 imr_val =3D twl4030_madc_read(madc, madc->imr);
>> +
> Returned errors ignored.

I will add a check.

>
>> + =A0 =A0 =A0 isr_val &=3D ~imr_val;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(isr_val & (1 << i)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_disable_irq(madc, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->requests[i].result_pending =3D 1;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mutex_lock(&madc->lock);
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No pending results for this method, mov=
e to next one
> */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!r->result_pending)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->=
method];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, m=
ethod->rbase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Return results to caller */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r->func_cb !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb(len, r->channel=
s, r->rbuf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free request */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->result_pending =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->active =3D 0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_unlock(&madc->lock);
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct twl=
4030_madc_request *req)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_request *p;
>> +
>> + =A0 =A0 =A0 p =3D &madc->requests[req->method];
>> +
>> + =A0 =A0 =A0 memcpy(p, req, sizeof *req);
>> +
>> + =A0 =A0 =A0 twl4030_madc_enable_irq(madc, req->method);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static inline void twl4030_madc_start_conversion(struct
> twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0int conv_method)
>> +{
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> +
>> + =A0 =A0 =A0 method =3D &twl4030_conversion_methods[conv_method];
>> +
>> + =A0 =A0 =A0 switch (conv_method) {
>> + =A0 =A0 =A0 case TWL4030_MADC_SW1:
>> + =A0 =A0 =A0 case TWL4030_MADC_SW2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(madc, method->ctrl,
> TWL4030_MADC_SW_START);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case TWL4030_MADC_RT:
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static int twl4030_madc_wait_conversion_ready(struct twl4030_madc_data
> *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 unsigned int timeout_ms,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 u8 status_reg)
>> +{
>> + =A0 =A0 =A0 unsigned long timeout;
>> +
>> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
>> + =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 reg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D twl4030_madc_read(madc, status_reg=
);
>
> Returned error ignored.

Return check will be addded.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & TWL4030_MADC_BUSY) && (reg &
> TWL4030_MADC_EOC_SW))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 } while (!time_after(jiffies, timeout));
>> +
>> + =A0 =A0 =A0 return -EAGAIN;
>> +}
>> +
>> +int twl4030_madc_conversion(struct twl4030_madc_request *req)
>> +{
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 =A0 u8 ch_msb, ch_lsb;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 if (unlikely(!req))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 mutex_lock(&the_madc->lock);
>> +
>> + =A0 =A0 =A0 if (req->method < TWL4030_MADC_RT || req->method >
> TWL4030_MADC_SW2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Do we have a conversion request ongoing */
>> + =A0 =A0 =A0 if (the_madc->requests[req->method].active) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ch_msb =3D (req->channels >> 8) & 0xff;
>> + =A0 =A0 =A0 ch_lsb =3D req->channels & 0xff;
>> +
>> + =A0 =A0 =A0 method =3D &twl4030_conversion_methods[req->method];
>> +
>> + =A0 =A0 =A0 /* Select channels to be converted */
>> + =A0 =A0 =A0 twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
>> + =A0 =A0 =A0 twl4030_madc_write(the_madc, method->sel, ch_lsb);
>> +
>> + =A0 =A0 =A0 /* Select averaging for all channels if do_avg is set */
>> + =A0 =A0 =A0 if (req->do_avg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg +=
 1, ch_msb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg, =
ch_lsb);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (req->type =3D TWL4030_MADC_IRQ_ONESHOT && req->func_cb=
 !> NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_set_irq(the_madc, req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_start_conversion(the_madc, re=
q->method);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 the_madc->requests[req->method].active =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* With RT method we should not be here anymore */
>> + =A0 =A0 =A0 if (req->method =3D TWL4030_MADC_RT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 twl4030_madc_start_conversion(the_madc, req->method);
>> + =A0 =A0 =A0 the_madc->requests[req->method].active =3D 1;
>> +
>> + =A0 =A0 =A0 /* Wait until conversion is ready (ctrl register returns E=
OC) */
>> + =A0 =A0 =A0 ret =3D twl4030_madc_wait_conversion_ready(the_madc, 5,
> method->ctrl);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(the_madc->hwmon_dev, "conversion t=
imeout!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 the_madc->requests[req->method].active =3D=
 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D twl4030_madc_read_channels(the_madc, method->rbase,
> req->channels,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0req->rbuf);
>> +
>> + =A0 =A0 =A0 the_madc->requests[req->method].active =3D 0;
>> +
>> +out:
>> + =A0 =A0 =A0 mutex_unlock(&the_madc->lock);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(twl4030_madc_conversion);
>> +
>> +/*
>> + * Return channel value
>> + * Or < 0 on failure.
>> + */
>> +static int twl4030_get_madc_conversion(int channel_no)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_request req;
>> + =A0 =A0 =A0 int temp =3D 0;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 req.channels =3D (1 << channel_no);
>> + =A0 =A0 =A0 req.method =3D TWL4030_MADC_SW2;
>> + =A0 =A0 =A0 req.active =3D 0;
>> + =A0 =A0 =A0 req.func_cb =3D NULL;
>> + =A0 =A0 =A0 ret =3D twl4030_madc_conversion(&req);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 if (req.rbuf[channel_no] > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D req.rbuf[channel_no];
>> +
>> + =A0 =A0 =A0 return temp;
>> +}
>> +EXPORT_SYMBOL(twl4030_get_madc_conversion);
>> +
>
> EXPORT_SYMBOL and static declaration is a contradiction.
> Actually, this function is not used anywhere. Does this compile without
> warning ?

I will add the function declaration in a header file.

>
>> +static void twl4030_madc_set_current_generator(struct twl4030_madc_data
> *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0int chan, int on)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL40=
30_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read register 0=
x%X\n",
> TWL4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 }
> You detect the error ... then go ahead and use the random regval anyway.
>

I will add a return value check.

>> + =A0 =A0 =A0 if (on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D chan ? TWL4030_BCI_ITHEN : TWL=
4030_BCI_TYPEN;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D chan ? ~TWL4030_BCI_ITHEN :
> ~TWL4030_BCI_TYPEN;
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL=
4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write register =
0x%X\n",
> TWL4030_BCI_BCICTL1);
>> +
> Unnecessary blank line.

I will reomve it.

>
>> +}
>> +
>> +static void twl4030_madc_set_power(struct twl4030_madc_data *madc, int
> on)
>> +{
>> + =A0 =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 =A0 regval =3D twl4030_madc_read(madc, TWL4030_MADC_CTRL1);
>
> Returned error ignored.

Return check will be added.

>
>> + =A0 =A0 =A0 if (on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 twl4030_madc_write(madc, TWL4030_MADC_CTRL1, regval);
>> +}
>> +
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
>> +
>> +static struct attribute *twl4030_madc_attributes[] =3D {
>> + =A0 =A0 =A0 &sensor_dev_attr_in0_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in1_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in2_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in3_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in4_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in5_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in6_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in7_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in8_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in9_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in10_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in11_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in12_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in13_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in14_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_in15_input.dev_attr.attr,
>> + =A0 =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group twl4030_madc_group =3D {
>> + =A0 =A0 =A0 .attrs =3D twl4030_madc_attributes,
>> +};
>> +
>> +static int __devinit twl4030_madc_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc;
>> + =A0 =A0 =A0 struct twl4030_madc_platform_data *pdata > pdev->dev.platf=
orm_data;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 int status;
>> + =A0 =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 =A0 madc =3D kzalloc(sizeof *madc, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!madc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "platform_data not ava=
ilable\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_misc;
>> + =A0 =A0 =A0 }
> You can check that before allocating memory.

Ok i will do that.

>
>> + =A0 =A0 =A0 madc->imr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
>> + =A0 =A0 =A0 madc->isr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
>> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 1);
>> +
>> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 1);
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL40=
30_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read register 0=
x%X\n",
> TWL4030_BCI_BCICTL1);
>
> No action ?

Ok. If read fails subsequent write will not make sense i will return an err=
or.

>
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 regval |=3D TWL4030_BCI_MESBAT;
>> +
> If the read failed above, you are going to write random data.
> Not sure if that makes sense.

Ok i will return an error.

>
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL=
4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write register =
0x%X\n",
> TWL4030_BCI_BCICTL1);
>
> No action ?
>
> It might make sense to bail out if register read/writes fail.

Ok i will return error if it fails.

>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, madc);
>> + =A0 =A0 =A0 mutex_init(&madc->lock);
>> +
>> + =A0 =A0 =A0 ret =3D request_threaded_irq(platform_get_irq(pdev, 0), NU=
LL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl=
4030_madc_irq_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
F_TRIGGER_RISING, "twl4030_madc",
> madc);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "could not request irq=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>
> Jump to release irq for which the request failed.

Ok i will revert only the previously succeeded steps.

>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_=
group);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysfs;
>
> Jump to remove group which wasn't added.

Ok i will revert only the previously succeeded steps.

>
>> +
>> + =A0 =A0 =A0 madc->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 =A0 if (IS_ERR(madc->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register=
 failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(madc->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
>
> This jumps to err_reg where you try to unregister the device for which
> registration failed.
>

Ok i will revert only the previously succeeded steps.

>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 the_madc =3D madc;
>> + =A0 =A0 =A0 return 0;
>> +
>> +err_reg:
>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> +err_sysfs:
>> + =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
>> +err_irq:
>> + =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), madc);
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 0);
>> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 0);
>> +err_misc:
>> + =A0 =A0 =A0 kfree(madc);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit twl4030_madc_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D platform_get_drvdata(pd=
ev);
>> +
>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
>> + =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), madc);
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 0);
>> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 0);
>> + =A0 =A0 =A0 kfree(madc);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver twl4030_madc_driver =3D {
>> + =A0 =A0 =A0 .probe =3D twl4030_madc_probe,
>> + =A0 =A0 =A0 .remove =3D __exit_p(twl4030_madc_remove),
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "twl4030_madc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> +};
>> +
>> +static int __init twl4030_madc_init(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_register(&twl4030_madc_driver);
>> +}
>> +
>> +module_init(twl4030_madc_init);
>> +
>> +static void __exit twl4030_madc_exit(void)
>> +{
>> + =A0 =A0 =A0 platform_driver_unregister(&twl4030_madc_driver);
>> +}
>> +
>> +module_exit(twl4030_madc_exit);
>> +
>> +MODULE_DESCRIPTION("TWL4030 ADC driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("J Keerthy");
>> diff --git a/include/linux/i2c/twl4030-madc.h
> b/include/linux/i2c/twl4030-madc.h
>> new file mode 100644
>> index 0000000..0e4e227
>> --- /dev/null
>> +++ b/include/linux/i2c/twl4030-madc.h
>> @@ -0,0 +1,118 @@
>> +/*
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
>> +#ifndef _TWL4030_MADC_H
>> +#define _TWL4030_MADC_H
>> +
>> +struct twl4030_madc_conversion_method {
>> + =A0 =A0 =A0 u8 sel;
>> + =A0 =A0 =A0 u8 avg;
>> + =A0 =A0 =A0 u8 rbase;
>> + =A0 =A0 =A0 u8 ctrl;
>> +};
>> +
>> +#define TWL4030_MADC_MAX_CHANNELS 16
>> +
>> +struct twl4030_madc_request {
>> + =A0 =A0 =A0 u16 channels;
>> + =A0 =A0 =A0 u16 do_avg;
>> + =A0 =A0 =A0 u16 method;
>> + =A0 =A0 =A0 u16 type;
>> + =A0 =A0 =A0 bool active;
>> + =A0 =A0 =A0 bool result_pending;
>> + =A0 =A0 =A0 int rbuf[TWL4030_MADC_MAX_CHANNELS];
>> + =A0 =A0 =A0 void (*func_cb)(int len, int channels, int *buf);
>> +};
>> +
>> +enum conversion_methods {
>> + =A0 =A0 =A0 TWL4030_MADC_RT,
>> + =A0 =A0 =A0 TWL4030_MADC_SW1,
>> + =A0 =A0 =A0 TWL4030_MADC_SW2,
>> + =A0 =A0 =A0 TWL4030_MADC_NUM_METHODS
>> +};
>> +
>> +enum sample_type {
>> + =A0 =A0 =A0 TWL4030_MADC_WAIT,
>> + =A0 =A0 =A0 TWL4030_MADC_IRQ_ONESHOT,
>> + =A0 =A0 =A0 TWL4030_MADC_IRQ_REARM
>> +};
>> +
>> +#define TWL4030_MADC_CTRL1 =A0 =A0 =A0 =A0 =A0 =A0 0x00
>> +#define TWL4030_MADC_CTRL2 =A0 =A0 =A0 =A0 =A0 =A0 0x01
>> +
>> +#define TWL4030_MADC_RTSELECT_LSB =A0 =A0 =A00x02
>> +#define TWL4030_MADC_SW1SELECT_LSB =A0 =A0 0x06
>> +#define TWL4030_MADC_SW2SELECT_LSB =A0 =A0 0x0A
>> +
>> +#define TWL4030_MADC_RTAVERAGE_LSB =A0 =A0 0x04
>> +#define TWL4030_MADC_SW1AVERAGE_LSB =A0 =A00x08
>> +#define TWL4030_MADC_SW2AVERAGE_LSB =A0 =A00x0C
>> +
>> +#define TWL4030_MADC_CTRL_SW1 =A0 =A0 =A0 =A0 =A00x12
>> +#define TWL4030_MADC_CTRL_SW2 =A0 =A0 =A0 =A0 =A00x13
>> +
>> +#define TWL4030_MADC_RTCH0_LSB =A0 =A0 =A0 =A0 0x17
>> +#define TWL4030_MADC_GPCH0_LSB =A0 =A0 =A0 =A0 0x37
>> +
>> +#define TWL4030_MADC_MADCON =A0 =A0 =A0 =A0 =A0 =A0(1 << 0) =A0 =A0 =A0=
 =A0/* MADC power on
> */
>> +#define TWL4030_MADC_BUSY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0) =A0 =A0 =
=A0 =A0/* MADC busy */
>> +#define TWL4030_MADC_EOC_SW =A0 =A0 =A0 =A0 =A0 =A0(1 << 1) =A0 =A0 =A0=
 =A0/* MADC
> conversion completion */
>> +#define TWL4030_MADC_SW_START =A0 =A0 =A0 =A0 =A0(1 << 5) =A0/* MADC SW=
x start
> conversion */
>> +
> Formatting looks off here, and I am sure lines are > 80 columns.
>

Yes formatting is off. I will format it.

>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 0)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN1 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 1)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN2 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 2)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN3 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 3)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN4 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 4)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN5 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 5)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN6 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 6)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN7 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 7)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN8 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 8)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN9 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 9)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN10 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 10)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN11 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 11)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN12 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 12)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN13 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 13)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN14 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 14)
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN15 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 15)
>> +
> Please no tabs after #define.
>

Ok i will remove the tabs.

>> +/* Fixed channels */
>> +#define TWL4030_MADC_BTEMP =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_ADCIN1
>> +#define TWL4030_MADC_VBUS =A0 =A0 =A0 =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN8
>> +#define TWL4030_MADC_VBKB =A0 =A0 =A0 =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN9
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_ICHG =A0 =A0 =A0 =A0 =A0 =A0 =A0 TW=
L4030_MADC_ADCIN10
>> +#define TWL4030_MADC_VCHG =A0 =A0 =A0 =A0 =A0 =A0 =A0TWL4030_MADC_ADCIN=
11
>> +#define =A0 =A0 =A0 =A0TWL4030_MADC_VBAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 TW=
L4030_MADC_ADCIN12
>> +
>> +#define TWL4030_BCI_BCICTL1 =A0 =A0 =A0 =A0 =A0 =A00x23
>> +#define =A0 =A0 =A0 =A0TWL4030_BCI_MESBAT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1=
 << 1)
>> +#define =A0 =A0 =A0 =A0TWL4030_BCI_TYPEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 4)
>> +#define =A0 =A0 =A0 =A0TWL4030_BCI_ITHEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 3)
>> +
>> +#define TWL4030_MADC_IOC_MAGIC '`'
>> +#define TWL4030_MADC_IOCX_ADC_RAW_READ
> _IO(TWL4030_MADC_IOC_MAGIC, 0)
>> +
>> +struct twl4030_madc_user_parms {
>> + =A0 =A0 =A0 int channel;
>> + =A0 =A0 =A0 int average;
>> + =A0 =A0 =A0 int status;
>> + =A0 =A0 =A0 u16 result;
>> +};
>> +
>> +int twl4030_madc_conversion(struct twl4030_madc_request *conv);
>> +
>> +#endif
>> --
>> 1.7.0.4
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
