From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Aug 2011 10:36:59 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <20110811103658.GG27742@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5167984133878038933=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-7-git-send-email-j-keerthy@ti.com>
 <20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
 <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
In-Reply-To: <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: balbi@ti.com, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com


--===============5167984133878038933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 03:27:26PM +0530, J, KEERTHY wrote:
> On Wed, Aug 10, 2011 at 6:16 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > (why aren't below in Cc ?
>=20
> I will add them.
>=20
> >
> > HARDWARE MONITORING
> > M: =A0 =A0 =A0Jean Delvare <khali@linux-fr.org>
> > M: =A0 =A0 =A0Guenter Roeck <guenter.roeck@ericsson.com>
> > L: =A0 =A0 =A0lm-sensors@lm-sensors.org
> > W: =A0 =A0 =A0http://www.lm-sensors.org/
> > T: =A0 =A0 =A0quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2=
=2E6/jdelvare-hwmon/
> > T: =A0 =A0 =A0git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/=
linux-staging.git
> > S: =A0 =A0 =A0Maintained
> > F: =A0 =A0 =A0Documentation/hwmon/
> > F: =A0 =A0 =A0drivers/hwmon/
> > F: =A0 =A0 =A0include/linux/hwmon*.h)
> >
> > On Wed, Aug 10, 2011 at 05:55:22PM +0530, Keerthy wrote:
> >> On chip temperature sensor driver. The driver monitors the temperature=
 of
> >> the MPU subsystem of the OMAP4. It sends notifications to the user spa=
ce if
> >> the temperature crosses user defined thresholds via kobject_uevent int=
erface.
> >> The user is allowed to configure the temperature thresholds vis sysfs =
nodes
> >> exposed using hwmon interface.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> ---
> >> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
> >> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> =A0drivers/hwmon/omap_temp_sensor.c | =A0950 +++++++++++++++++++++++++=
+++++++++++++
> >> =A03 files changed, 962 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
> >>
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 5f888f7..9c9cd8b 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -323,6 +323,17 @@ config SENSORS_F71805F
> >> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, t=
he module
> >> =A0 =A0 =A0 =A0 will be called f71805f.
> >>
> >> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
> >> + =A0 =A0 bool "OMAP on-die temperature sensor hwmon driver"
> >> + =A0 =A0 depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 If you say yes here you get support for hardware
> >> + =A0 =A0 =A0 monitoring features of the OMAP on die temperature
> >> + =A0 =A0 =A0 sensor.
> >> +
> >> + =A0 =A0 =A0 Continuous conversion programmable delay
> >> + =A0 =A0 =A0 mode is used for temperature conversion.
> >> +
> >> =A0config SENSORS_F71882FG
> >> =A0 =A0 =A0 tristate "Fintek F71882FG and compatibles"
> >> =A0 =A0 =A0 help
> >> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> >> index 28061cf..d0f89f5 100644
> >> --- a/drivers/hwmon/Makefile
> >> +++ b/drivers/hwmon/Makefile
> >> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) =A0 =A0 =A0 +=3D max66=
39.o
> >> =A0obj-$(CONFIG_SENSORS_MAX6642) =A0 =A0 =A0 =A0+=3D max6642.o
> >> =A0obj-$(CONFIG_SENSORS_MAX6650) =A0 =A0 =A0 =A0+=3D max6650.o
> >> =A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
> >> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap_temp_sens=
or.o
> >> =A0obj-$(CONFIG_SENSORS_PC87360) =A0 =A0 =A0 =A0+=3D pc87360.o
> >> =A0obj-$(CONFIG_SENSORS_PC87427) =A0 =A0 =A0 =A0+=3D pc87427.o
> >> =A0obj-$(CONFIG_SENSORS_PCF8591) =A0 =A0 =A0 =A0+=3D pcf8591.o
> >> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_tem=
p_sensor.c
> >> new file mode 100644
> >> index 0000000..15e2559
> >> --- /dev/null
> >> +++ b/drivers/hwmon/omap_temp_sensor.c
> >> @@ -0,0 +1,950 @@
> >> +/*
> >> + * OMAP4 Temperature sensor driver file
> >> + *
> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.=
com/
> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License
> >> + * version 2 as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> + * 02110-1301 USA
> >> + *
> >> + */
> >> +
> >> +#include <linux/interrupt.h>
> >> +#include <linux/clk.h>
> >
> > why ??
>=20
> Clock rate setting functions.

you shouldn't need in drivers.

> >> +#include <linux/io.h>
> >> +#include <linux/debugfs.h>
> >
> > why ??
>=20
> It will be removed.
>=20
> >
> >> +#include <linux/delay.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/init.h>
> >> +#include <plat/omap_device.h>
> >
> > why ??
> >
>=20
> Context loss count

shouldn't use in drivers.

> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/device.h>
> >> +#include <linux/jiffies.h>
> >> +#include <linux/hwmon.h>
> >> +#include <linux/hwmon-sysfs.h>
> >> +#include <linux/stddef.h>
> >> +#include <linux/sysfs.h>
> >> +#include <linux/err.h>
> >> +#include <linux/types.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <plat/common.h>
> >
> > why ?
>=20
> usleep_range function.

plat/common for usleep_range ?? usleep_range is defined in
<linux/delay.h>

> >> +#include <plat/temperature_sensor.h>
> >
>=20
> It is the header file with the structure definitions
> used in the driver.

why don't you put in <linux/platform_data/....> ??

> >> +#include <mach/ctrl_module_core_44xx.h>
> >
> > why ?
>=20
> It will be removed
>=20
> >
> >> +#include <mach/gpio.h>
> >
> > linux/gpio.h for crying out loud... how many times Russell has to say
> > the exact same thing ??????
> >
>=20
> It will be removed

oh, you don't even use any gpio ? Why do you blindly add so many headers
if you don't need them ???

> >> +#define TSHUT_THRESHOLD_HOT =A0122000 =A0/* 122 deg C */
> >> +#define TSHUT_THRESHOLD_COLD 100000 =A0/* 100 deg C */
> >> +#define BGAP_THRESHOLD_T_HOT 73000 =A0 /* 73 deg C */
> >> +#define BGAP_THRESHOLD_T_COLD =A0 =A0 =A0 =A071000 =A0 /* 71 deg C */
> >> +#define OMAP_ADC_START_VALUE 530
> >> +#define OMAP_ADC_END_VALUE =A0 923
> >> +
> >> +/*
> >> + * omap_temp_sensor structure
> >> + * @hwmon_dev - device pointer
> >> + * @clock - Clock pointer
> >> + * @registers - Pointer to structure with register offsets and bitfie=
lds
> >> + * @sensor_mutex - Mutex for sysfs, irq and PM
> >> + * @irq - MPU Irq number for thermal alert
> >> + * @phy_base - Physical base of the temp I/O
> >> + * @clk_rate - Holds current clock rate
> >> + * @temp_sensor_ctrl - temp sensor control register value
> >> + * @bg_ctrl - bandgap ctrl register value
> >> + * @bg_counter - bandgap counter value
> >> + * @bg_threshold - bandgap threshold register value
> >> + * @temp_sensor_tshut_threshold - bandgap tshut register value
> >> + * @is_efuse_valid - Flag to determine if efuse is valid or not
> >> + * @clk_on - Manages the current clock state
> >> + */
> >> +struct omap_temp_sensor {
> >> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
> >> + =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;
> >> + =A0 =A0 struct omap_temp_sensor_registers *registers;
> >> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* Mutex f=
or sysfs, irq and PM */
> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
> >> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ctrl;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_tshu=
t_threshold;
> >> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_efuse_valid;
> >> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;
> >> +};
> >> +
> >> +/*
> >> + * Temperature values in milli degree celsius
> >> + * ADC code values from 530 to 923
> >> + */
> >> +static int adc_to_temp[] =3D {
> >> + =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -386=
00, -38200,
> >> + =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -348=
00,
> >> + =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -313=
00,
> >> + =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -278=
00,
> >> + =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -244=
00,
> >> + =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -210=
00,
> >> + =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -176=
00,
> >> + =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -142=
00,
> >> + =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -107=
00,
> >> + =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -68=
00,
> >> + =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -300=
0,
> >> + =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 1=
600,
> >> + =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, =
6400,
> >> + =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600=
, 11000,
> >> + =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 1480=
0,
> >> + =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 1870=
0,
> >> + =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 2260=
0,
> >> + =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 2640=
0,
> >> + =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 3020=
0,
> >> + =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 3400=
0,
> >> + =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 3780=
0,
> >> + =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 4160=
0,
> >> + =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 4530=
0,
> >> + =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 4900=
0,
> >> + =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 5280=
0,
> >> + =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 5660=
0,
> >> + =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 6040=
0,
> >> + =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 6420=
0,
> >> + =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 6780=
0,
> >> + =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 7160=
0,
> >> + =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 7540=
0,
> >> + =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 7900=
0,
> >> + =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 8280=
0,
> >> + =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 8640=
0,
> >> + =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 9020=
0,
> >> + =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 9380=
0,
> >> + =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 9760=
0,
> >> + =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 1=
01200,
> >> + =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 1044=
00,
> >> + =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 1078=
00,
> >> + =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 1110=
00,
> >> + =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 1142=
00,
> >> + =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 1174=
00,
> >> + =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 1206=
00,
> >> + =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
> >> +};
> >> +
> >> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 *temp_sensor, u32 reg)
> >> +{
> >> + =A0 =A0 return __raw_readl(temp_sensor->phy_base + reg);
> >> +}
> >> +
> >> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_sen=
sor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 =
val, u32 reg)
> >> +{
> >> + =A0 =A0 __raw_writel(val, (temp_sensor->phy_base + reg));
> >> +}
> >> +
> >> +static int adc_to_temp_conversion(int adc_val)
> >> +{
> >> + =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
> >> +}
> >> +
> >> +static int temp_to_adc_conversion(long temp)
> >> +{
> >> + =A0 =A0 int i;
> >> +
> >> + =A0 =A0 for (i =3D 0; i <=3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VAL=
UE; i++)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[i])
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_ADC_START_VALUE =
+ i - 1;
> >> +
> >> + =A0 =A0 return -EINVAL;
> >> +}
> >> +
> >> +static void omap_configure_temp_sensor_thresholds(struct omap_temp_se=
nsor
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 *temp_sensor)
> >> +{
> >> + =A0 =A0 u32 temp, t_hot, t_cold, tshut_hot, tshut_cold;
> >> +
> >> + =A0 =A0 t_hot =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_HOT);
> >> + =A0 =A0 t_cold =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_COLD);
> >> +
> >> + =A0 =A0 /* Configure the TALERT thresholds */
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 temp |=3D (t_hot << __ffs(temp_sensor->registers->threshold_=
thot_mask)) |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 (t_cold << __ffs(temp_sensor->registers->thr=
eshold_tcold_mask));
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
> >> +
> >> + =A0 =A0 tshut_hot =3D temp_to_adc_conversion(TSHUT_THRESHOLD_HOT);
> >> + =A0 =A0 tshut_cold =3D temp_to_adc_conversion(TSHUT_THRESHOLD_COLD);
> >> +
> >> + =A0 =A0 /* Configure the TSHUT thresholds */
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsu=
t_threshold);
> >> + =A0 =A0 temp |=3D (tshut_hot << __ffs(temp_sensor->registers->tshut_=
hot_mask))
> >> + =A0 =A0 =A0 =A0 | (tshut_cold << __ffs(temp_sensor->registers->tshut=
_hot_mask));
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsu=
t_threshold);
> >> +}
> >> +
> >> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)
> >> +{
> >> + =A0 =A0 u32 val;
> >> +
> >> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_counter);
> >> + =A0 =A0 val &=3D ~(temp_sensor->registers->counter_mask);
> >> + =A0 =A0 val |=3D (counter << __ffs(temp_sensor->registers->counter_m=
ask));
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_counter);
> >> +}
> >> +
> >> +static void omap_enable_continuous_mode(struct omap_temp_sensor *temp=
_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 bool enable)
> >> +{
> >> + =A0 =A0 u32 val;
> >> +
> >> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_mode_ctrl);
> >> +
> >> + =A0 =A0 if (enable)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (1 << __ffs(temp_sensor->registers-=
>mode_ctrl_mask));
> >> + =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(temp_sensor->registers->mode_ctrl=
_mask);
> >> +
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_mode_ctrl);
> >> +}
> >> +
> >> +/* Sysfs hook functions */
> >> +
> >> +static ssize_t show_temp_max(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *dev=
attr, char *buf)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 int temp;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_thot_mask)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->regist=
ers->threshold_thot_mask);
> >> +
> >> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE=
) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
> >> +
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
> >> +}
> >> +
> >> +static ssize_t set_temp_max(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attrib=
ute *devattr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, siz=
e_t count)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, t_cold,=
 t_hot, temp;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
> >> + =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VA=
LUE)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* obtain the T cold value */
> >> + =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshold_tcold=
_mask) >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers=
->threshold_tcold_mask);
> >> +
> >> + =A0 =A0 if (t_hot < t_cold) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_HOT value lesser than=
 T_COLD\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* write the new t_hot value */
> >> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_thot_mask);
> >> + =A0 =A0 reg_val |=3D (t_hot <<
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers=
->threshold_thot_mask));
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> +
> >> + =A0 =A0 /* Read the current temperature */
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp=
_sensor_ctrl);
> >> + =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than the=
 current
> >> + =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (t_hot > temp) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sens=
or,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->mask_=
cold_mask);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_ho=
t_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* If current temperature is in-between the hot and cold t=
hresholds,
> >> + =A0 =A0 =A0* Enable both masks.
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (temp > t_cold && temp < t_hot) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sens=
or,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_co=
ld_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_ho=
t_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4460_BGA=
P_CTRL_OFFSET);
> >> + =A0 =A0 }
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* else no need to do anything since HW will immediately c=
ompare
> >> + =A0 =A0 =A0* the new threshold and generate interrupt accordingly
> >> + =A0 =A0 =A0*/
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> + =A0 =A0 return count;
> >> +}
> >> +
> >> +static ssize_t show_temp_max_hyst(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
> >> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tcold_mas=
k) >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold_tcol=
d_mask);
> >> +
> >> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE=
) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
> >> +}
> >> +
> >> +static ssize_t set_temp_max_hyst(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct de=
vice_attribute *devattr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const cha=
r *buf, size_t count)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =3D dev=
_get_drvdata(dev);
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
reg_val, t_hot, t_cold, temp;
> >> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
val;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
> >> + =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END_V=
ALUE) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* obtain the T HOT value */
> >> + =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshold_thot_ma=
sk) >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers=
->threshold_thot_mask);
> >> +
> >> + =A0 =A0 if (t_cold > t_hot) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_COLD value greater th=
an T_HOT\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* write the new t_cold value */
> >> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_tcold_mask);
> >> + =A0 =A0 reg_val |=3D (t_cold <<
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers=
->threshold_tcold_mask));
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_threshold);
> >> +
> >> + =A0 =A0 /* Read the current temperature */
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
> >> + =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than the c=
urrent
> >> + =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (t_cold < temp) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sens=
or,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->mask_=
hot_mask);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_co=
ld_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_mask_ctrl);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* If current temperature is in-between the hot and cold t=
hresholds,
> >> + =A0 =A0 =A0* Enable both masks.
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (temp < t_hot && temp > t_cold) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sens=
or,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_co=
ld_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_ho=
t_mask;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->bgap_mask_ctrl);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* else no need to do anything since HW will immediately c=
ompare
> >> + =A0 =A0 =A0* the new threshold and generate interrupt accordingly
> >> + =A0 =A0 =A0*/
> >> +
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> + =A0 =A0 return count;
> >> +}
> >> +
> >> +static ssize_t show_update_rate(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *dev=
attr, char *buf)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 0, ret =
=3D 0;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 if (!temp_sensor->clk_rate) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_counter);
> >> + =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask) >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers=
->counter_mask);
> >
> > =A0 =A0 =A0 =A0temp &=3D ??
> >
> >> + =A0 =A0 temp =3D temp * 1000 / (temp_sensor->clk_rate);
> >
> > =A0 =A0 =A0 =A0temp *=3D ??
>=20
> Need to multiply the temp with 1000 before dividing.
> temp *=3D evaluates the RHS first and then multiplies LHS.

temp *=3D 1000;
temp /=3D clk_rate;

> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> + =A0 =A0 if (!ret)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
> >> + =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> +}
> >> +
> >> +static ssize_t set_update_rate(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device=
_attribute *devattr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *b=
uf, size_t count)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;
> >> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
> >> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_counter);
> >> +
> >> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->counter_mask);
> >> + =A0 =A0 reg_val |=3D val;
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_counter);
> >> +
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> + =A0 =A0 return count;
> >> +}
> >> +
> >> +static int omap_temp_sensor_read_temp(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
struct device_attribute *devattr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
char *buf)
> >> +{
> >> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev=
);
> >> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret =3D 0;
> >> +
> >> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
> >> + =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
> >> +
> >> + =A0 =A0 if (!temp_sensor->is_efuse_valid)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid EFUSE, Non-trimmed BGA=
P, Temp not accurate\n");
> >> +
> >> + =A0 =A0 /* look up for temperature in the table and return the tempe=
rature */
> >> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE=
) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code reported %d",=
 temp);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
> >> +
> >> +out:
> >> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
> >> + =A0 =A0 if (!ret)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
> >> + =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> +}
> >> +
> >> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read=
_temp,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
> >> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
> >> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_tem=
p_max_hyst,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);
> >> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update=
_rate,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, 0);
> >> +
> >> +static struct attribute *omap_temp_sensor_attributes[] =3D {
> >> + =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
> >> + =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
> >> + =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> >> + =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
> >> + =A0 =A0 NULL
> >> +};
> >> +
> >> +static const struct attribute_group omap_temp_sensor_group =3D {
> >> + =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
> >> +};
> >> +
> >> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_=
sensor)
> >> +{
> >> + =A0 =A0 u32 ret =3D 0, temp;
> >> +
> >> + =A0 =A0 if (temp_sensor->clk_on) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock alrea=
dy on\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
> >> + =A0 =A0 if (ret < 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get sync fa=
iled\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp=
_sensor_ctrl);
> >> + =A0 =A0 temp &=3D ~(temp_sensor->registers->bgap_tempsoff_mask);
> >> + =A0 =A0 /* BGAP_TEMPSOFF should be reset to 0 */
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-=
>registers->temp_sensor_ctrl);
> >> + =A0 =A0 temp_sensor->clk_on =3D 1;
> >
> > why isn't pm_runtime_get_sync() enough ??
>=20
> This is the programming sequence indicated. BGAP_TEMPSOFF should be set
> to 0 to enable the temperature sensor.

why isn't this done as part of your runtime_resume() function ??

> >> +out:
> >> + =A0 =A0 return ret;
> >> +}
> >> +
> >> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp=
_sensor)
> >> +{
> >> + =A0 =A0 u32 temp, ret =3D 0;
> >> + =A0 =A0 unsigned long timeout;
> >> +
> >> + =A0 =A0 if (!temp_sensor->clk_on) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock alrea=
dy off\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp=
_sensor_ctrl);
> >> + =A0 =A0 temp |=3D temp_sensor->registers->bgap_tempsoff_mask;
> >> +
> >> + =A0 =A0 /* BGAP_TEMPSOFF should be set to 1 before gating clock */
> >> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp=
_sensor_ctrl);
> >> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_status);
> >> + =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(5);
> >> +
> >> + =A0 =A0 /* wait till the clean stop bit is set or till the timeout e=
xppires */
> >> + =A0 =A0 while (!(temp | temp_sensor->registers->status_clean_stop_ma=
sk) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 !(time_after(jiffies, timeout))) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap=
_status);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(500, 2000);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (time_after(jiffies, timeout))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "Clean stop =
bit not set\n");
> >> + =A0 =A0 /* Gate the clock */
> >> + =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev);
> >> + =A0 =A0 if (ret < 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "put sync fa=
iled\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> + =A0 =A0 temp_sensor->clk_on =3D 0;
> >> +out:
> >> + =A0 =A0 return ret;
> >> +}

add a blank line here.

--=20
balbi

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQ7DKAAoJEAv8Txj19kN1GfAH/0iP82X4zYhtSArGaX8FDKeR
HzdrcAvfj8CwE/9a5YctiEUwQY6guPMuSKaWVYPDwpIWqZMQSZ/By9inN93skbkW
aJjSMF/CXzFUq1u0Tphwsh6DGkgmJ8zQ59UZVjCZMHndzK894/yoiNmWdlGiB1B9
2I2EKnoMGDt7PSIe44IuDJEl9Or2Xk51zeZasS6n8WbdgtsvS/B2sdgFUgtlA63z
DTz8QbVKbIHgtYboKHkgzpUBAiyMLzMePgmyHJebrm6GPbvT0gJP5gF39U+2XaSH
aUzIEQSf8b9HPGXXcxjUBsg7B8zrtUAApr8uC7WZJ0tOvGub7NXY8ZuIVU8bUO8=
=gsMC
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--


--===============5167984133878038933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5167984133878038933==--
