From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 07 Jan 2011 08:52:46 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <AANLkTikh82xXO1paA+qWHG=0X4gWiY+zEYKvGpPCycs2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
	<AANLkTimrUYdy5aZsEheP-iHctET198ms+H7MXJYQnSn=@mail.gmail.com>
In-Reply-To: <AANLkTimrUYdy5aZsEheP-iHctET198ms+H7MXJYQnSn=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, balajitk@ti.com

On Thu, Jan 6, 2011 at 11:28 AM, Kalliguddi, Hema <hemahk@ti.com> wrote:
> Keerthy,
>
> Minor comments...
>
> Regards,
> Hema
>
> On Thu, Jan 6, 2011 at 9:47 AM, Keerthy <j-keerthy@ti.com> wrote:
>> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monito=
ring
>> ADC. This driver monitors the real time conversion of analog signals like
>> battery temperature, battery type, battery level etc. User can also ask =
for
>> the conversion on a particular channel using the sysfs nodes. Tested the
>> conversion through sysfs nodes. Tested with DEBUG_LOCKDEP enabled.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Several people have contributed to this driver on the linux-omap list.
>> V3:
>>
>> Return check added to all the functions reading and writing via i2c.
>> In probe function reverting all the steps succeded before a failure
>> and not reverting the step which failed.
>> Added the declaration of twl4030_get_madc_conversion function in the
>> header file.
>> Formatting the header file.
>> Comments added.
>> likely occurance removed since it is not in the hot path.
>> Renamed the_madc to twl4030_madc.
>> Added sleep command to avoid busy wait in conversion ready function.
>>
>> V2:
>>
>> Error path correction in probe function.
>> Return checks added.
>> the_madc pointer could not be removed. The external drivers will not be =
knowing
>> device information of the madc.
>> Added another function which takes the channel number alone and returns
>> the channel reading if the caller wants TWL4030_MADC_SW2 method for ADC =
conversion.
>> IOCTL function is removed.
>> Work struct is completely removed since request_threaded_irq is used.
>>
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/twl4030-madc.c =A0 =A0 | =A0794 +++++++++++++++++++++++=
+++++++++++++++
>> =A0include/linux/i2c/twl4030-madc.h | =A0118 ++++++
>> =A04 files changed, 924 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/twl4030-madc.c
>> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>>
>> V1:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34947.html
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index a56f6ad..eec1258 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -920,6 +920,17 @@ config SENSORS_TMP421
>> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, =
the module
>> =A0 =A0 =A0 =A0 =A0will be called tmp421.
>>
>> +config SENSORS_TWL4030_MADC
>> + =A0 =A0 =A0 tristate "Texas Instrments TWL4030 MADC"
>> + =A0 =A0 =A0 depends on TWL4030_CORE
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 This driver provides support for triton TWL4030-MADC. The
>> + =A0 =A0 =A0 driver supports both RT and SW conversion methods.
>> +
>> + =A0 =A0 =A0 This driver can be built as part of kernel or can be built
>> + =A0 =A0 =A0 as a module.
>> +
>> +
> Only on new line is enough
Ok
>
>> =A0config SENSORS_VIA_CPUTEMP
>> =A0 =A0 =A0 =A0tristate "VIA CPU temperature sensor"
>> =A0 =A0 =A0 =A0depends on X86
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
>> index 0000000..523f19a
>> --- /dev/null
>> +++ b/drivers/hwmon/twl4030-madc.c
>> @@ -0,0 +1,794 @@
>> +/*
>> + *
>> + * TWL4030 MADC module driver-This driver monitors the real time
>> + * conversion of analog signals like battery temperature,
>> + * battery type, battery level etc. User can also ask for the conversio=
n on a
>> + * particular channel using the sysfs nodes.
>> + *
>> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.co=
m/
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
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/i2c/twl.h>
>> +#include <linux/i2c/twl4030-madc.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +
>> +/*
>> + * struct twl4030_madc_data - a container for madc info
>> + * @hwmon_dev - pointer to device structure for madc
>> + * @lock - mutex protecting this data structire
>> + * @requests - Array of request struct corresponding to SW1, SW2 and RT
>> + * @imr - Interrupt mask register of MADC
>> + * @isr - Interrupt status register of MADC
>> + */
>> +struct twl4030_madc_data {
>> + =A0 =A0 =A0 struct device *hwmon_dev;
>> + =A0 =A0 =A0 struct mutex lock;/* mutex protecting this data structire =
*/
>> + =A0 =A0 =A0 struct twl4030_madc_request requests[TWL4030_MADC_NUM_METH=
ODS];
>> + =A0 =A0 =A0 int imr;
>> + =A0 =A0 =A0 int isr;
>> +};
>> +
>> +static struct twl4030_madc_data *twl4030_madc;
>> +
>> +/*
>> + * sysfs hook function
>> + */
>> +static ssize_t madc_read(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute=
 *devattr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_att=
r(devattr);
>> + =A0 =A0 =A0 struct twl4030_madc_request req;
>> + =A0 =A0 =A0 long val;
>> +
>> + =A0 =A0 =A0 req.channels =3D (1 << attr->index);
>> + =A0 =A0 =A0 req.method =3D TWL4030_MADC_SW2;
>> + =A0 =A0 =A0 req.func_cb =3D NULL;
>> + =A0 =A0 =A0 val =3D twl4030_madc_conversion(&req);
>> + =A0 =A0 =A0 if (val >=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D req.rbuf[attr->index];
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val;
>> + =A0 =A0 =A0 return sprintf(buf, "%ld\n", val);
>> +}
>> +
>> +/*
>> + * Structure containing the registers
>> + * of different conversion methods supported by MADC.
>> + * Hardware or RT real time conversion request intiated by external host
>> + * processor for RT Signal conversions.
>> + * External host processors can also request for non RT converions
>> + * SW1 and SW2 software conversions also called asynchronous or GPC req=
uest.
>> + */
>> +static
>> +const struct twl4030_madc_conversion_method twl4030_conversion_methods[=
] =3D {
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
>> +/*
>> + * Function to read a particular channel value.
>> + * @madc - pointer to struct twl4030_madc_data struct
>> + * @reg - lsb of ADC Channel
>> + * If the i2c read fails it returns an error else returns 0.
>> + */
>> +static int twl4030_madc_channel_raw_read(struct twl4030_madc_data *madc=
, u8 reg)
>> +{
>> + =A0 =A0 =A0 u8 msb, lsb;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* For each ADC channel, we have MSB and LSB register pa=
ir. MSB address
>> + =A0 =A0 =A0 =A0* is always LSB address+1. reg parameter is the addr of=
 LSB register
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &msb, reg + 1=
);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read M=
SB register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg + 1);
>
> It is better if you use dev_err for all the i2c read and write failure.
Ok. I get the point. I will replace dev_dbg with dev_err.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &lsb, reg);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read LSB register 0x%X\n", reg);
> Ditto.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return (int)(((msb << 8) | lsb) >> 6);
>> +}
>> +
>> +/*
>> + * Function to read channel values
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @reg_base - Base address of the first channel
>> + * @Channel - 16 bit bitmap. If the bit is set channel value is read
>> + * @buf - The channel values are stored here. if read fails error
>> + * value is stored
>> + * Returns the number of successfully read channels.
>> + */
>> +static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 u8 reg_base, u16 channels, int *buf)
>> +{
>> + =A0 =A0 =A0 int count =3D 0, count_req =3D 0;
>> + =A0 =A0 =A0 u8 reg, i;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1 << i)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2 * i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_ch=
annel_raw_read(madc, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf[i] < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(ma=
dc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "Unable to read register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count_req+=
+;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (count_req) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d channel conversion fai=
led\n", count_req);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return count;
>> +}
>> +
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
>> +{
>> + =A0 =A0 =A0 u8 val;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, madc->i=
mr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read i=
mr register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 val &=3D ~(1 << id);
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, val, madc->i=
mr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write imr regis=
ter 0x%X\n", madc->imr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Disables irq.
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @id - irq number to be disabled
>> + * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
>> + * corresponding to RT, SW1, SW2 conversion requests.
>> + * Returns error if i2c read/write fails.
>> + */
>> +static int twl4030_madc_disable_irq(struct twl4030_madc_data *madc, int=
 id)
>> +{
>> + =A0 =A0 =A0 u8 val;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, madc->i=
mr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read i=
mr register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 val |=3D (1 << id);
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, val, madc->i=
mr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write imr regis=
ter 0x%X\n", madc->imr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_ma=
dc)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 =A0 u8 isr_val, imr_val;
>> + =A0 =A0 =A0 int i, len, ret;
>> + =A0 =A0 =A0 struct twl4030_madc_request *r;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &isr_val, mad=
c->isr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read i=
sr register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->isr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &imr_val, mad=
c->imr);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "unable to read i=
mr register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 isr_val &=3D ~imr_val;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(isr_val & (1 << i)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_disable_irq(madc, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Disable interrupt failed%=
d\n", i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->requests[i].result_pending =3D 1;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mutex_lock(&madc->lock);
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No pending results for this method, mov=
e to next one */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!r->result_pending)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->=
method];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, m=
ethod->rbase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
>> +
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
>> + =A0 =A0 =A0 mutex_unlock(&madc->lock);
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +
>> +err_i2c:
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* =A0In case of error check whichever is active
>> + =A0 =A0 =A0 =A0* =A0 and service the same.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mutex_lock(&madc->lock);
>> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r->active =3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->=
method];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, m=
ethod->rbase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->channels, r->rbuf);
>> +
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
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 p =3D &madc->requests[req->method];
>> +
>> + =A0 =A0 =A0 memcpy(p, req, sizeof *req);
>> +
>> + =A0 =A0 =A0 ret =3D twl4030_madc_enable_irq(madc, req->method);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "enable irq faile=
d!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Function which enables the madc conversion
>> + * by writing to the control register.
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @conv_method - can be TWL4030_MADC_RT, TWL4030_MADC_SW2, TWL4030_MAD=
C_SW1
>> + * corresponding to RT SW1 or SW2 conversion methods.
>> + * Returns 0 if succeeds else a negative error value
>> + */
>> +static int twl4030_madc_start_conversion(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0int conv_method)
>> +{
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 method =3D &twl4030_conversion_methods[conv_method];
>> +
>> + =A0 =A0 =A0 switch (conv_method) {
>> + =A0 =A0 =A0 case TWL4030_MADC_SW1:
>> + =A0 =A0 =A0 case TWL4030_MADC_SW2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MA=
DC,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_SW_START, met=
hod->ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write ctrl regi=
ster 0x%X\n", method->ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case TWL4030_MADC_RT:
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Function that waits for conversion to be ready
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @timeout_ms - timeout value in mili seconds
>> + * @status_reg - ctrl register
>> + * returns 0 if succeeds else a negative error value
>> + */
>> +static int twl4030_madc_wait_conversion_ready(struct twl4030_madc_data =
*madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 unsigned int timeout_ms,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 u8 status_reg)
>> +{
>> + =A0 =A0 =A0 unsigned long timeout;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
>> + =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 reg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAD=
C, &reg, status_reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to=
 read status register 0x%X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_reg=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & TWL4030_MADC_BUSY) && (reg & T=
WL4030_MADC_EOC_SW))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(500, 2000);
>> + =A0 =A0 =A0 } while (!time_after(jiffies, timeout));
>> + =A0 =A0 =A0 dev_dbg(madc->hwmon_dev, "conversion timeout!\n");
>> +
>> + =A0 =A0 =A0 return -EAGAIN;
>> +}
>> +
>> +/*
>> + * An exported function which can be called from other kernel drivers.
>> + * @req twl4030_madc_request structure
>> + * req->rbuf will be filled with read values of channels based on the
>> + * channel index. If a particular channel reading fails there will
>> + * be a negative error value in the correspoding array element.
>> + * retuns 0 is succeeds else error value
>> + */
>> +int twl4030_madc_conversion(struct twl4030_madc_request *req)
>> +{
>> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 =A0 u8 ch_msb, ch_lsb;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 if (!req)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 mutex_lock(&twl4030_madc->lock);
>> +
>> + =A0 =A0 =A0 if (req->method < TWL4030_MADC_RT || req->method > TWL4030=
_MADC_SW2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Do we have a conversion request ongoing */
>> + =A0 =A0 =A0 if (twl4030_madc->requests[req->method].active) {
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
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_msb, meth=
od->sel + 1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(twl4030_madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write sel register 0x%X\n", met=
hod->sel + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_lsb, meth=
od->sel);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(twl4030_madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write sel register 0x%X\n", met=
hod->sel + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Select averaging for all channels if do_avg is set */
>> + =A0 =A0 =A0 if (req->do_avg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MA=
DC,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch_msb, method->avg + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(twl4030_madc->hwmo=
n_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write avg regis=
ter 0x%X\n", method->avg + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MA=
DC,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch_lsb, method->avg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(twl4030_madc->hwmo=
n_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write sel reg 0=
x%X\n", method->sel + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (req->type =3D TWL4030_MADC_IRQ_ONESHOT && req->func_cb=
 !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_set_irq(twl4030_madc,=
 req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_start_conversion(twl4=
030_madc, req->method);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc->requests[req->method].active=
 =3D 1;
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
>> + =A0 =A0 =A0 ret =3D twl4030_madc_start_conversion(twl4030_madc, req->m=
ethod);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 twl4030_madc->requests[req->method].active =3D 1;
>> +
>> + =A0 =A0 =A0 /* Wait until conversion is ready (ctrl register returns E=
OC) */
>> + =A0 =A0 =A0 ret =3D twl4030_madc_wait_conversion_ready(twl4030_madc, 5=
, method->ctrl);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc->requests[req->method].active=
 =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D twl4030_madc_read_channels(twl4030_madc, method->r=
base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->channels, req->rbuf);
>> + =A0 =A0 =A0 twl4030_madc->requests[req->method].active =3D 0;
>> +
>> +out:
>> + =A0 =A0 =A0 mutex_unlock(&twl4030_madc->lock);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
>> +
>> +/*
>> + * Return channel value
>> + * Or < 0 on failure.
>> + */
>> +int twl4030_get_madc_conversion(int channel_no)
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
>> +EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
>> +
>> +/*
>> + * Function to enable or disble bias current for
>> + * main battery type reading or temperature sensing
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @chan - cab be one of the two values
>> + * TWL4030_BCI_ITHEN - Enables bias current for main battery type readi=
ng
>> + * TWL4030_BCI_TYPEN - Enables bias current for main battery temperature
>> + * sensing
>> + * @on - enable or disable chan.
>> + */
>> +static int twl4030_madc_set_current_generator(struct twl4030_madc_data =
*madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int chan, int on)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL40=
30_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read BCICTL1 reg 0x%X", TWL4030=
_BCI_BCICTL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D chan ? TWL4030_BCI_ITHEN : TWL=
4030_BCI_TYPEN;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D chan ? ~TWL4030_BCI_ITHEN : ~T=
WL4030_BCI_TYPEN;
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL=
4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write BCICTL1 reg 0x%X\n", TWL4=
030_BCI_BCICTL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Function that sets MADC software power on bit to enable MADC
>> + * @madc - pointer to twl4030_madc_data struct
>> + * @on - Enable or diable MADC software powen on bit.
>> + * returns error if i2c read/write fails else 0
>> + */
>> +static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int o=
n)
>> +{
>> + =A0 =A0 =A0 u8 regval;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL40=
30_MADC_CTRL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read madc ctrl1 reg 0x%X\n", TW=
L4030_MADC_CTRL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, regval, TWL4=
030_MADC_CTRL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write madc ctrl1 reg 0x%X\n", T=
WL4030_MADC_CTRL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
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
>> +/*
>> + * Initialize MADC and request for threaded irq
>> + * and register as a hwmon device
>> + */
>> +static int __devinit twl4030_madc_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc;
>> + =A0 =A0 =A0 struct twl4030_madc_platform_data *pdata =3D pdev->dev.pla=
tform_data;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 int status;
>> + =A0 =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "platform_data not ava=
ilable\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 madc =3D kzalloc(sizeof *madc, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!madc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 madc->imr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
>> + =A0 =A0 =A0 madc->isr =3D (pdata->irq_line =3D 1) ?
>> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
>> + =A0 =A0 =A0 ret =3D twl4030_madc_set_power(madc, 1);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_power;
>> + =A0 =A0 =A0 ret =3D twl4030_madc_set_current_generator(madc, 0, 1);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_current_generator;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL40=
30_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read reg BCI CTL1 0x%X\n", TWL4=
030_BCI_BCICTL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 regval |=3D TWL4030_BCI_MESBAT;
>> +
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL=
4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write reg BCI Ctl1 0x%X\n", TWL=
4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, madc);
>> + =A0 =A0 =A0 mutex_init(&madc->lock);
>> +
>> + =A0 =A0 =A0 ret =3D request_threaded_irq(platform_get_irq(pdev, 0), NU=
LL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl=
4030_madc_threaded_irq_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
F_TRIGGER_RISING, "twl4030_madc", madc);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "could not request irq=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_=
group);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysfs;
>> +
>> + =A0 =A0 =A0 madc->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 =A0 if (IS_ERR(madc->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register=
 failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(madc->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 twl4030_madc =3D madc;
>> + =A0 =A0 =A0 return 0;
>> +
>> +err_reg:
>> + =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
>> +
>> +err_sysfs:
>> + =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), madc);
>> +err_irq:
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> +
>> +err_i2c:
>> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 0);
>> +
>> +err_current_generator:
>> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 0);
>> +err_power:
>> + =A0 =A0 =A0 kfree(madc);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit twl4030_madc_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D platform_get_drvdata(pd=
ev);
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
>> diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl403=
0-madc.h
>> new file mode 100644
>> index 0000000..5bc9e8c
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
>> + =A0 =A0 =A0 u16 channels; /* 16 bit bitmap for individual channels */
>> + =A0 =A0 =A0 u16 do_avg; /* sample the input channel for 4 consecutive =
cycles
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and provide the average of=
 4 conversions */
>> + =A0 =A0 =A0 u16 method; /* RT, SW1, SW2 */
>> + =A0 =A0 =A0 u16 type; /*polling or interrupt based */
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
>> +#define TWL4030_MADC_MADCON =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* MADC powe=
r on */
>> +#define TWL4030_MADC_BUSY =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* MADC bu=
sy */
>> +/* MADC conversion completion */
>> +#define TWL4030_MADC_EOC_SW =A0 =A0(1 << 1)
>> +/* MADC SWx start conversion */
>> +#define TWL4030_MADC_SW_START =A0(1 << 5)
>> +#define TWL4030_MADC_ADCIN0 =A0 =A0(1 << 0)
>> +#define TWL4030_MADC_ADCIN1 =A0 =A0(1 << 1)
>> +#define TWL4030_MADC_ADCIN2 =A0 =A0(1 << 2)
>> +#define TWL4030_MADC_ADCIN3 =A0 =A0(1 << 3)
>> +#define TWL4030_MADC_ADCIN4 =A0 =A0(1 << 4)
>> +#define TWL4030_MADC_ADCIN5 =A0 =A0(1 << 5)
>> +#define TWL4030_MADC_ADCIN6 =A0 =A0(1 << 6)
>> +#define TWL4030_MADC_ADCIN7 =A0 =A0(1 << 7)
>> +#define TWL4030_MADC_ADCIN8 =A0 =A0(1 << 8)
>> +#define TWL4030_MADC_ADCIN9 =A0 =A0(1 << 9)
>> +#define TWL4030_MADC_ADCIN10 =A0 (1 << 10)
>> +#define TWL4030_MADC_ADCIN11 =A0 (1 << 11)
>> +#define TWL4030_MADC_ADCIN12 =A0 (1 << 12)
>> +#define TWL4030_MADC_ADCIN13 =A0 (1 << 13)
>> +#define TWL4030_MADC_ADCIN14 =A0 (1 << 14)
>> +#define TWL4030_MADC_ADCIN15 =A0 (1 << 15)
>> +
>> +/* Fixed channels */
>> +#define TWL4030_MADC_BTEMP =A0 =A0 TWL4030_MADC_ADCIN1
>> +#define TWL4030_MADC_VBUS =A0 =A0 =A0TWL4030_MADC_ADCIN8
>> +#define TWL4030_MADC_VBKB =A0 =A0 =A0TWL4030_MADC_ADCIN9
>> +#define TWL4030_MADC_ICHG =A0 =A0 =A0TWL4030_MADC_ADCIN10
>> +#define TWL4030_MADC_VCHG =A0 =A0 =A0TWL4030_MADC_ADCIN11
>> +#define TWL4030_MADC_VBAT =A0 =A0 =A0TWL4030_MADC_ADCIN12
>> +
>> +#define TWL4030_BCI_BCICTL1 =A0 =A00x23
>> +#define TWL4030_BCI_MESBAT =A0 =A0 (1 << 1)
>> +#define TWL4030_BCI_TYPEN =A0 =A0 =A0(1 << 4)
>> +#define TWL4030_BCI_ITHEN =A0 =A0 =A0(1 << 3)
>> +
>> +
>> +struct twl4030_madc_user_parms {
>> + =A0 =A0 =A0 int channel;
>> + =A0 =A0 =A0 int average;
>> + =A0 =A0 =A0 int status;
>> + =A0 =A0 =A0 u16 result;
>> +};
>> +
>> +int twl4030_madc_conversion(struct twl4030_madc_request *conv);
>> +int twl4030_get_madc_conversion(int channel_no);
>> +#endif
>
> Regards,
> Hema
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
