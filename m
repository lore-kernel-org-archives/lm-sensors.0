From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 18 Feb 2011 11:58:58 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] mfd: twl4030: Driver for twl4030 madc
Message-Id: <AANLkTi=H9HNONRpqs9ROy=_USr=FHcU7Fb9_MG7aYoWQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297861008-10021-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1297861008-10021-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sameo@linux.intel.com
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, j-keerthy@ti.com, linux-omap@vger.kernel.org

Hello Samuel,

Any comments on this patch?

Regards,
Keerthy

On Wed, Feb 16, 2011 at 6:26 PM, Keerthy <j-keerthy@ti.com> wrote:
> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monitor=
ing
> ADC. This driver monitors the real time conversion of analog signals like
> battery temperature, battery type, battery level etc.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> ---
> The previous discussion concluded in keeping the generic ADC
> functionality and the hwmon separate. The discussion can be found here:
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
>
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 +
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/mfd/twl4030-madc.c =A0 =A0 =A0 | =A0723 ++++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/i2c/twl4030-madc.h | =A0132 +++++++
> =A04 files changed, 866 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/mfd/twl4030-madc.c
> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index fd01836..7d36882 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -167,6 +167,16 @@ config TWL4030_CORE
> =A0 =A0 =A0 =A0 =A0high speed USB OTG transceiver, an audio codec (on most
> =A0 =A0 =A0 =A0 =A0versions) and many other features.
>
> +config TWL4030_MADC
> + =A0 =A0 =A0 tristate "Texas Instruments TWL4030 MADC"
> + =A0 =A0 =A0 depends on TWL4030_CORE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 This driver provides support for triton TWL4030-MADC. The
> + =A0 =A0 =A0 driver supports both RT and SW conversion methods.
> +
> + =A0 =A0 =A0 This driver can be built as part of kernel or can be built
> + =A0 =A0 =A0 as a module.
> +
> =A0config TWL4030_POWER
> =A0 =A0 =A0 =A0bool "Support power resources on TWL4030 family chips"
> =A0 =A0 =A0 =A0depends on TWL4030_CORE && ARM
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a54e2c7..2922cc2 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_TPS6507X) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D tps6507x.o
> =A0obj-$(CONFIG_MENELAUS) =A0 =A0 =A0 =A0 +=3D menelaus.o
>
> =A0obj-$(CONFIG_TWL4030_CORE) =A0 =A0 +=3D twl-core.o twl4030-irq.o twl60=
30-irq.o
> +obj-$(CONFIG_TWL4030_MADC) =A0 =A0 =A0+=3D twl4030-madc.o
> =A0obj-$(CONFIG_TWL4030_POWER) =A0 =A0+=3D twl4030-power.o
> =A0obj-$(CONFIG_TWL4030_CODEC) =A0 =A0+=3D twl4030-codec.o
> =A0obj-$(CONFIG_TWL6030_PWM) =A0 =A0 =A0+=3D twl6030-pwm.o
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> new file mode 100644
> index 0000000..711bfff
> --- /dev/null
> +++ b/drivers/mfd/twl4030-madc.c
> @@ -0,0 +1,723 @@
> +/*
> + *
> + * TWL4030 MADC module driver-This driver monitors the real time
> + * conversion of analog signals like battery temperature,
> + * battery type, battery level etc.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * J Keerthy <j-keerthy@ti.com>
> + *
> + * Based on twl4030-madc.c
> + * Copyright (C) 2008 Nokia Corporation
> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
> + *
> + * Amit Kucheria <amit.kucheria@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/i2c/twl4030-madc.h>
> +
> +/*
> + * struct twl4030_madc_data - a container for madc info
> + * @dev - pointer to device structure for madc
> + * @lock - mutex protecting this data structire
> + * @requests - Array of request struct corresponding to SW1, SW2 and RT
> + * @imr - Interrupt mask register of MADC
> + * @isr - Interrupt status register of MADC
> + */
> +struct twl4030_madc_data {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct mutex lock; =A0 =A0 =A0/* mutex protecting this data=
 structire */
> + =A0 =A0 =A0 struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHO=
DS];
> + =A0 =A0 =A0 int imr;
> + =A0 =A0 =A0 int isr;
> +};
> +
> +static struct twl4030_madc_data *twl4030_madc;
> +
> +struct twl4030_prescale_divider_ratios {
> + =A0 =A0 =A0 s16 numerator;
> + =A0 =A0 =A0 s16 denominator;
> +};
> +
> +static const struct twl4030_prescale_divider_ratios
> +twl4030_divider_ratios[16] =3D {
> + =A0 =A0 =A0 {1, 1}, =A0 =A0 =A0 =A0 /* CHANNEL 0 No Prescaler */
> + =A0 =A0 =A0 {1, 1}, =A0 =A0 =A0 =A0 /* CHANNEL 1 No Prescaler */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 2 */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 3 */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 4 */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 5 */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 6 */
> + =A0 =A0 =A0 {6, 10}, =A0 =A0 =A0 =A0/* CHANNEL 7 */
> + =A0 =A0 =A0 {3, 14}, =A0 =A0 =A0 =A0/* CHANNEL 8 */
> + =A0 =A0 =A0 {1, 3}, =A0 =A0 =A0 =A0 /* CHANNEL 9 */
> + =A0 =A0 =A0 {1, 1}, =A0 =A0 =A0 =A0 /* CHANNEL 10 NA */
> + =A0 =A0 =A0 {15, 100}, =A0 =A0 =A0/* CHANNEL 11 */
> + =A0 =A0 =A0 {1, 4}, =A0 =A0 =A0 =A0 /* CHANNEL 12 */
> + =A0 =A0 =A0 {1, 1}, =A0 =A0 =A0 =A0 /* CHANNEL 13 NA */
> + =A0 =A0 =A0 {1, 1}, =A0 =A0 =A0 =A0 /* CHANNEL 14 NA */
> + =A0 =A0 =A0 {5, 11}, =A0 =A0 =A0 =A0/* CHANNEL 15 */
> +};
> +
> +/*
> + * Structure containing the registers
> + * of different conversion methods supported by MADC.
> + * Hardware or RT real time conversion request intiated by external host
> + * processor for RT Signal conversions.
> + * External host processors can also request for non RT converions
> + * SW1 and SW2 software conversions also called asynchronous or GPC requ=
est.
> + */
> +static
> +const struct twl4030_madc_conversion_method twl4030_conversion_methods[]=
 =3D {
> + =A0 =A0 =A0 [TWL4030_MADC_RT] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sel =3D TWL4030=
_MADC_RTSELECT_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.avg =3D TWL4030=
_MADC_RTAVERAGE_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.rbase =3D TWL40=
30_MADC_RTCH0_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 [TWL4030_MADC_SW1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sel =3D TWL403=
0_MADC_SW1SELECT_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .avg =3D TWL403=
0_MADC_SW1AVERAGE_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rbase =3D TWL4=
030_MADC_GPCH0_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =3D TWL40=
30_MADC_CTRL_SW1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 [TWL4030_MADC_SW2] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sel =3D TWL403=
0_MADC_SW2SELECT_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .avg =3D TWL403=
0_MADC_SW2AVERAGE_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rbase =3D TWL4=
030_MADC_GPCH0_LSB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =3D TWL40=
30_MADC_CTRL_SW2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> +};
> +
> +/*
> + * Function to read a particular channel value.
> + * @madc - pointer to struct twl4030_madc_data struct
> + * @reg - lsb of ADC Channel
> + * If the i2c read fails it returns an error else returns 0.
> + */
> +static int twl4030_madc_channel_raw_read(struct twl4030_madc_data *madc,=
 u8 reg)
> +{
> + =A0 =A0 =A0 u8 msb, lsb;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For each ADC channel, we have MSB and LSB register pai=
r. MSB address
> + =A0 =A0 =A0 =A0* is always LSB address+1. reg parameter is the addr of =
LSB register
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &msb, reg + 1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read MSB regi=
ster 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &lsb, reg);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read LSB regi=
ster 0x%X\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return (int)(((msb << 8) | lsb) >> 6);
> +}
> +
> +/*
> + * Function to read channel values
> + * @madc - pointer to twl4030_madc_data struct
> + * @reg_base - Base address of the first channel
> + * @Channel - 16 bit bitmap. If the bit is set channel value is read
> + * @buf - The channel values are stored here. if read fails error
> + * value is stored
> + * Returns the number of successfully read channels.
> + */
> +static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u8 reg_base, u16 channels, int *buf)
> +{
> + =A0 =A0 =A0 int count =3D 0, count_req =3D 0;
> + =A0 =A0 =A0 u8 reg, i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1 << i)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2 * i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_cha=
nnel_raw_read(madc, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf[i] < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mad=
c->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to =
read register 0x%X\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count_req++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Analog I=
nput (V) =3D conv_result *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0step_size / R
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* conv_r=
esult =3D decimal value
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 of 10-bit conversion
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 result
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* step s=
ize =3D 1.5 / (2 ^ 10 -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* R =3D =
Prescaler ratio for input
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =
=A0 =A0channels
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Result=
 given in mV hence multiplied
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =
=A0 =A0by 1000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D =
(buf[i] * 3 * 1000 *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_div=
ider_ratios[i].denominator)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 / (2 * 1023=
 *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_div=
ider_ratios[i].numerator);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (count_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "%d channel conversion f=
ailed\n", count_req);
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +/*
> + * Enables irq.
> + * @madc - pointer to twl4030_madc_data struct
> + * @id - irq number to be enabled
> + * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
> + * corresponding to RT, SW1, SW2 conversion requests.
> + * If the i2c read fails it returns an error else returns 0.
> + */
> +static int twl4030_madc_enable_irq(struct twl4030_madc_data *madc, u8 id)
> +{
> + =A0 =A0 =A0 u8 val;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, madc->im=
r);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read imr regi=
ster 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 val &=3D ~(1 << id);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, val, madc->im=
r);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write imr regist=
er 0x%X\n", madc->imr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Disables irq.
> + * @madc - pointer to twl4030_madc_data struct
> + * @id - irq number to be disabled
> + * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
> + * corresponding to RT, SW1, SW2 conversion requests.
> + * Returns error if i2c read/write fails.
> + */
> +static int twl4030_madc_disable_irq(struct twl4030_madc_data *madc, u8 i=
d)
> +{
> + =A0 =A0 =A0 u8 val;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, madc->im=
r);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read imr regi=
ster 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 val |=3D (1 << id);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, val, madc->im=
r);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write imr regist=
er 0x%X\n", madc->imr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_mad=
c)
> +{
> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
> + =A0 =A0 =A0 u8 isr_val, imr_val;
> + =A0 =A0 =A0 int i, len, ret;
> + =A0 =A0 =A0 struct twl4030_madc_request *r;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &isr_val, madc=
->isr);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read isr regi=
ster 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->isr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC, &imr_val, madc=
->imr);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to read imr regi=
ster 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->imr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 isr_val &=3D ~imr_val;
> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(isr_val & (1 << i)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_disable_irq(madc, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "Disable=
 interrupt failed%d\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 madc->requests[i].result_pending =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_lock(&madc->lock);
> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No pending results for this method, move=
 to next one */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!r->result_pending)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->m=
ethod];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, me=
thod->rbase,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Return results to caller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r->func_cb !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb(len, r->channels=
, r->rbuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free request */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->result_pending =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->active =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&madc->lock);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +
> +err_i2c:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case of error check whichever is active
> + =A0 =A0 =A0 =A0* and service the same.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mutex_lock(&madc->lock);
> + =A0 =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r->active =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->m=
ethod];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, me=
thod->rbase,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Return results to caller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r->func_cb !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb(len, r->channels=
, r->rbuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free request */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->result_pending =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->active =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&madc->lock);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct twl4=
030_madc_request *req)
> +{
> + =A0 =A0 =A0 struct twl4030_madc_request *p;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 p =3D &madc->requests[req->method];
> + =A0 =A0 =A0 memcpy(p, req, sizeof(*req));
> + =A0 =A0 =A0 ret =3D twl4030_madc_enable_irq(madc, req->method);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "enable irq failed!!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Function which enables the madc conversion
> + * by writing to the control register.
> + * @madc - pointer to twl4030_madc_data struct
> + * @conv_method - can be TWL4030_MADC_RT, TWL4030_MADC_SW2, TWL4030_MADC=
_SW1
> + * corresponding to RT SW1 or SW2 conversion methods.
> + * Returns 0 if succeeds else a negative error value
> + */
> +static int twl4030_madc_start_conversion(struct twl4030_madc_data *madc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int conv_method)
> +{
> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 method =3D &twl4030_conversion_methods[conv_method];
> + =A0 =A0 =A0 switch (conv_method) {
> + =A0 =A0 =A0 case TWL4030_MADC_SW1:
> + =A0 =A0 =A0 case TWL4030_MADC_SW2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAD=
C,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0TWL4030_MADC_SW_START, method->ctrl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to =
write ctrl register 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 method->ctr=
l);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Function that waits for conversion to be ready
> + * @madc - pointer to twl4030_madc_data struct
> + * @timeout_ms - timeout value in mili seconds
> + * @status_reg - ctrl register
> + * returns 0 if succeeds else a negative error value
> + */
> +static int twl4030_madc_wait_conversion_ready(struct twl4030_madc_data *=
madc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 unsigned int timeout_ms,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 status_reg)
> +{
> + =A0 =A0 =A0 unsigned long timeout;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 reg;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MADC=
, &reg, status_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to =
read status register 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & TWL4030_MADC_BUSY) && (reg & TW=
L4030_MADC_EOC_SW))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(500, 2000);
> + =A0 =A0 =A0 } while (!time_after(jiffies, timeout));
> + =A0 =A0 =A0 dev_err(madc->dev, "conversion timeout!\n");
> +
> + =A0 =A0 =A0 return -EAGAIN;
> +}
> +
> +/*
> + * An exported function which can be called from other kernel drivers.
> + * @req twl4030_madc_request structure
> + * req->rbuf will be filled with read values of channels based on the
> + * channel index. If a particular channel reading fails there will
> + * be a negative error value in the correspoding array element.
> + * returns 0 if succeeds else error value
> + */
> +int twl4030_madc_conversion(struct twl4030_madc_request *req)
> +{
> + =A0 =A0 =A0 const struct twl4030_madc_conversion_method *method;
> + =A0 =A0 =A0 u8 ch_msb, ch_lsb;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (!req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 mutex_lock(&twl4030_madc->lock);
> + =A0 =A0 =A0 if (req->method < TWL4030_MADC_RT || req->method > TWL4030_=
MADC_SW2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Do we have a conversion request ongoing */
> + =A0 =A0 =A0 if (twl4030_madc->requests[req->method].active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ch_msb =3D (req->channels >> 8) & 0xff;
> + =A0 =A0 =A0 ch_lsb =3D req->channels & 0xff;
> + =A0 =A0 =A0 method =3D &twl4030_conversion_methods[req->method];
> + =A0 =A0 =A0 /* Select channels to be converted */
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_msb, metho=
d->sel + 1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(twl4030_madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write sel regist=
er 0x%X\n", method->sel + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_lsb, metho=
d->sel);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(twl4030_madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write sel regist=
er 0x%X\n", method->sel + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Select averaging for all channels if do_avg is set */
> + =A0 =A0 =A0 if (req->do_avg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAD=
C,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ch_msb, method->avg + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(twl4030_madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to =
write avg register 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 method->avg=
 + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAD=
C,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ch_lsb, method->avg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(twl4030_madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to =
write sel reg 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 method->sel=
 + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (req->type =3D TWL4030_MADC_IRQ_ONESHOT && req->func_cb =
!=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_set_irq(twl4030_madc, =
req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_madc_start_conversion(twl40=
30_madc, req->method);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc->requests[req->method].active =
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* With RT method we should not be here anymore */
> + =A0 =A0 =A0 if (req->method =3D TWL4030_MADC_RT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D twl4030_madc_start_conversion(twl4030_madc, req->me=
thod);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 twl4030_madc->requests[req->method].active =3D 1;
> + =A0 =A0 =A0 /* Wait until conversion is ready (ctrl register returns EO=
C) */
> + =A0 =A0 =A0 ret =3D twl4030_madc_wait_conversion_ready(twl4030_madc, 5,=
 method->ctrl);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc->requests[req->method].active =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D twl4030_madc_read_channels(twl4030_madc, method->rb=
ase,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0req->channels, req->rbuf);
> + =A0 =A0 =A0 twl4030_madc->requests[req->method].active =3D 0;
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&twl4030_madc->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
> +
> +/*
> + * Return channel value
> + * Or < 0 on failure.
> + */
> +int twl4030_get_madc_conversion(int channel_no)
> +{
> + =A0 =A0 =A0 struct twl4030_madc_request req;
> + =A0 =A0 =A0 int temp =3D 0;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 req.channels =3D (1 << channel_no);
> + =A0 =A0 =A0 req.method =3D TWL4030_MADC_SW2;
> + =A0 =A0 =A0 req.active =3D 0;
> + =A0 =A0 =A0 req.func_cb =3D NULL;
> + =A0 =A0 =A0 ret =3D twl4030_madc_conversion(&req);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 if (req.rbuf[channel_no] > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D req.rbuf[channel_no];
> +
> + =A0 =A0 =A0 return temp;
> +}
> +EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
> +
> +/*
> + * Function to enable or disable bias current for
> + * main battery type reading or temperature sensing
> + * @madc - pointer to twl4030_madc_data struct
> + * @chan - can be one of the two values
> + * TWL4030_BCI_ITHEN - Enables bias current for main battery type reading
> + * TWL4030_BCI_TYPEN - Enables bias current for main battery temperature
> + * sensing
> + * @on - enable or disable chan.
> + */
> +static int twl4030_madc_set_current_generator(struct twl4030_madc_data *=
madc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int chan, int on)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 regval;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL403=
0_BCI_BCICTL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read BCICTL1 reg=
 0x%X", TWL4030_BCI_BCICTL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (on)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D chan ? TWL4030_BCI_ITHEN : TWL4=
030_BCI_TYPEN;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D chan ? ~TWL4030_BCI_ITHEN : ~TW=
L4030_BCI_TYPEN;
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL4=
030_BCI_BCICTL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write BCICTL1 re=
g 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_BCI_BCICTL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Function that sets MADC software power on bit to enable MADC
> + * @madc - pointer to twl4030_madc_data struct
> + * @on - Enable or diable MADC software powen on bit.
> + * returns error if i2c read/write fails else 0
> + */
> +static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
> +{
> + =A0 =A0 =A0 u8 regval;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL403=
0_MADC_CTRL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read madc ctrl1 =
reg 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_CTRL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (on)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_MADC_MADCON;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~TWL4030_MADC_MADCON;
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, regval, TWL40=
30_MADC_CTRL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write madc ctrl1=
 reg 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_CTRL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Initialize MADC and request for threaded irq
> + */
> +static int __devinit twl4030_madc_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct twl4030_madc_data *madc;
> + =A0 =A0 =A0 struct twl4030_madc_platform_data *pdata =3D pdev->dev.plat=
form_data;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 regval;
> +
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "platform_data not avai=
lable\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 madc =3D kzalloc(sizeof(*madc), GFP_KERNEL);
> + =A0 =A0 =A0 if (!madc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Phoenix provides 2 interrupt lines. The first one is c=
onnected to
> + =A0 =A0 =A0 =A0* the OMAP. The other one can be connected to other proc=
essor such
> + =A0 =A0 =A0 =A0* as modem. Hence two separate ISR and IMR registers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 madc->imr =3D (pdata->irq_line =3D 1) ?
> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
> + =A0 =A0 =A0 madc->isr =3D (pdata->irq_line =3D 1) ?
> + =A0 =A0 =A0 =A0 =A0 TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
> + =A0 =A0 =A0 ret =3D twl4030_madc_set_power(madc, 1);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_power;
> + =A0 =A0 =A0 ret =3D twl4030_madc_set_current_generator(madc, 0, 1);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_current_generator;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regval, TWL403=
0_BCI_BCICTL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to read reg BCI CTL=
1 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_BCI_BCICTL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 regval |=3D TWL4030_BCI_MESBAT;
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval, TWL4=
030_BCI_BCICTL1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to write reg BCI Ct=
l1 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_BCI_BCICTL1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 platform_set_drvdata(pdev, madc);
> + =A0 =A0 =A0 mutex_init(&madc->lock);
> + =A0 =A0 =A0 ret =3D request_threaded_irq(platform_get_irq(pdev, 0), NUL=
L,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4=
030_madc_threaded_irq_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF=
_TRIGGER_RISING, "twl4030_madc", madc);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "could not request irq\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 twl4030_madc =3D madc;
> + =A0 =A0 =A0 return 0;
> +err_irq:
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +err_i2c:
> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 0);
> +err_current_generator:
> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 0);
> +err_power:
> + =A0 =A0 =A0 kfree(madc);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit twl4030_madc_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct twl4030_madc_data *madc =3D platform_get_drvdata(pde=
v);
> +
> + =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), madc);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 twl4030_madc_set_current_generator(madc, 0, 0);
> + =A0 =A0 =A0 twl4030_madc_set_power(madc, 0);
> + =A0 =A0 =A0 kfree(madc);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver twl4030_madc_driver =3D {
> + =A0 =A0 =A0 .probe =3D twl4030_madc_probe,
> + =A0 =A0 =A0 .remove =3D __exit_p(twl4030_madc_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "twl4030_madc",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> +};
> +
> +static int __init twl4030_madc_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&twl4030_madc_driver);
> +}
> +
> +module_init(twl4030_madc_init);
> +
> +static void __exit twl4030_madc_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&twl4030_madc_driver);
> +}
> +
> +module_exit(twl4030_madc_exit);
> +
> +MODULE_DESCRIPTION("TWL4030 ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("J Keerthy");
> +MODULE_ALIAS("twl4030_madc");
> diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030=
-madc.h
> new file mode 100644
> index 0000000..8685006
> --- /dev/null
> +++ b/include/linux/i2c/twl4030-madc.h
> @@ -0,0 +1,132 @@
> +/*
> + * twl4030_madc.h - Header for TWL4030 MADC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * J Keerthy <j-keerthy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef _TWL4030_MADC_H
> +#define _TWL4030_MADC_H
> +
> +struct twl4030_madc_conversion_method {
> + =A0 =A0 =A0 u8 sel;
> + =A0 =A0 =A0 u8 avg;
> + =A0 =A0 =A0 u8 rbase;
> + =A0 =A0 =A0 u8 ctrl;
> +};
> +
> +#define TWL4030_MADC_MAX_CHANNELS 16
> +
> +
> +/*
> + * twl4030_madc_request- madc request packet for channel conversion
> + * @channels: =A016 bit bitmap for individual channels
> + * @do_avgP: =A0 sample the input channel for 4 consecutive cycles
> + * @method: =A0 =A0RT, SW1, SW2
> + * @type: =A0 =A0 =A0Polling or interrupt based method
> + */
> +
> +struct twl4030_madc_request {
> + =A0 =A0 =A0 u16 channels; /* 16 bit bitmap for individual channels */
> + =A0 =A0 =A0 u16 do_avg; /* sample the input channel for 4 consecutive c=
ycles
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and provide the average of =
4 conversions */
> + =A0 =A0 =A0 u16 method; /* RT, SW1, SW2 */
> + =A0 =A0 =A0 u16 type; /*polling or interrupt based */
> + =A0 =A0 =A0 bool active;
> + =A0 =A0 =A0 bool result_pending;
> + =A0 =A0 =A0 int rbuf[TWL4030_MADC_MAX_CHANNELS];
> + =A0 =A0 =A0 void (*func_cb)(int len, int channels, int *buf);
> +};
> +
> +enum conversion_methods {
> + =A0 =A0 =A0 TWL4030_MADC_RT,
> + =A0 =A0 =A0 TWL4030_MADC_SW1,
> + =A0 =A0 =A0 TWL4030_MADC_SW2,
> + =A0 =A0 =A0 TWL4030_MADC_NUM_METHODS
> +};
> +
> +enum sample_type {
> + =A0 =A0 =A0 TWL4030_MADC_WAIT,
> + =A0 =A0 =A0 TWL4030_MADC_IRQ_ONESHOT,
> + =A0 =A0 =A0 TWL4030_MADC_IRQ_REARM
> +};
> +
> +#define TWL4030_MADC_CTRL1 =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define TWL4030_MADC_CTRL2 =A0 =A0 =A0 =A0 =A0 =A0 0x01
> +
> +#define TWL4030_MADC_RTSELECT_LSB =A0 =A0 =A00x02
> +#define TWL4030_MADC_SW1SELECT_LSB =A0 =A0 0x06
> +#define TWL4030_MADC_SW2SELECT_LSB =A0 =A0 0x0A
> +
> +#define TWL4030_MADC_RTAVERAGE_LSB =A0 =A0 0x04
> +#define TWL4030_MADC_SW1AVERAGE_LSB =A0 =A00x08
> +#define TWL4030_MADC_SW2AVERAGE_LSB =A0 =A00x0C
> +
> +#define TWL4030_MADC_CTRL_SW1 =A0 =A0 =A0 =A0 =A00x12
> +#define TWL4030_MADC_CTRL_SW2 =A0 =A0 =A0 =A0 =A00x13
> +
> +#define TWL4030_MADC_RTCH0_LSB =A0 =A0 =A0 =A0 0x17
> +#define TWL4030_MADC_GPCH0_LSB =A0 =A0 =A0 =A0 0x37
> +
> +#define TWL4030_MADC_MADCON =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* MADC power=
 on */
> +#define TWL4030_MADC_BUSY =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* MADC bus=
y */
> +/* MADC conversion completion */
> +#define TWL4030_MADC_EOC_SW =A0 =A0(1 << 1)
> +/* MADC SWx start conversion */
> +#define TWL4030_MADC_SW_START =A0(1 << 5)
> +#define TWL4030_MADC_ADCIN0 =A0 =A0(1 << 0)
> +#define TWL4030_MADC_ADCIN1 =A0 =A0(1 << 1)
> +#define TWL4030_MADC_ADCIN2 =A0 =A0(1 << 2)
> +#define TWL4030_MADC_ADCIN3 =A0 =A0(1 << 3)
> +#define TWL4030_MADC_ADCIN4 =A0 =A0(1 << 4)
> +#define TWL4030_MADC_ADCIN5 =A0 =A0(1 << 5)
> +#define TWL4030_MADC_ADCIN6 =A0 =A0(1 << 6)
> +#define TWL4030_MADC_ADCIN7 =A0 =A0(1 << 7)
> +#define TWL4030_MADC_ADCIN8 =A0 =A0(1 << 8)
> +#define TWL4030_MADC_ADCIN9 =A0 =A0(1 << 9)
> +#define TWL4030_MADC_ADCIN10 =A0 (1 << 10)
> +#define TWL4030_MADC_ADCIN11 =A0 (1 << 11)
> +#define TWL4030_MADC_ADCIN12 =A0 (1 << 12)
> +#define TWL4030_MADC_ADCIN13 =A0 (1 << 13)
> +#define TWL4030_MADC_ADCIN14 =A0 (1 << 14)
> +#define TWL4030_MADC_ADCIN15 =A0 (1 << 15)
> +
> +/* Fixed channels */
> +#define TWL4030_MADC_BTEMP =A0 =A0 TWL4030_MADC_ADCIN1
> +#define TWL4030_MADC_VBUS =A0 =A0 =A0TWL4030_MADC_ADCIN8
> +#define TWL4030_MADC_VBKB =A0 =A0 =A0TWL4030_MADC_ADCIN9
> +#define TWL4030_MADC_ICHG =A0 =A0 =A0TWL4030_MADC_ADCIN10
> +#define TWL4030_MADC_VCHG =A0 =A0 =A0TWL4030_MADC_ADCIN11
> +#define TWL4030_MADC_VBAT =A0 =A0 =A0TWL4030_MADC_ADCIN12
> +
> +#define TWL4030_BCI_BCICTL1 =A0 =A00x23
> +#define TWL4030_BCI_MESBAT =A0 =A0 (1 << 1)
> +#define TWL4030_BCI_TYPEN =A0 =A0 =A0(1 << 4)
> +#define TWL4030_BCI_ITHEN =A0 =A0 =A0(1 << 3)
> +
> +struct twl4030_madc_user_parms {
> + =A0 =A0 =A0 int channel;
> + =A0 =A0 =A0 int average;
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 u16 result;
> +};
> +
> +int twl4030_madc_conversion(struct twl4030_madc_request *conv);
> +int twl4030_get_madc_conversion(int channel_no);
> +#endif
> +
> --
> 1.7.0.4
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
