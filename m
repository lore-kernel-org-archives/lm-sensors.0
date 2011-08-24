From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Wed, 24 Aug 2011 18:30:59 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13a1dDQ5Axv2MX1hf1dNH3BeEBjrkEibW8WpxMrJGhmO3g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
	<1314196632-8207-7-git-send-email-j-keerthy@ti.com>
	<CACqS6krvH985gDwrD5kVEvbybC80wcYZN2AwV9pZ9=-x8hZAUg@mail.gmail.com>
In-Reply-To: <CACqS6krvH985gDwrD5kVEvbybC80wcYZN2AwV9pZ9=-x8hZAUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Janakiram Sistla <janakiram.sistla@gmail.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Wed, Aug 24, 2011 at 10:06 PM, Janakiram Sistla
<janakiram.sistla@gmail.com> wrote:
> Hi Keerthy,
>
> Can you please point me the TRM of 4430 or 4460 where it reads the on die
> temperature sensor used is TMP103. I am referring to public TRM on TI sit=
e.

Sorry my bad! I shall remove that.

>
> Regards,
> Sistla.
>
> On Wed, Aug 24, 2011 at 9:37 AM, Keerthy <j-keerthy@ti.com> wrote:
>>
>> On chip temperature sensor driver. The driver monitors the temperature of
>> the MPU subsystem of the OMAP4. It sends notifications to the user space
>> if
>> the temperature crosses user defined thresholds via kobject_uevent
>> interface.
>> The user is allowed to configure the temperature thresholds vis sysfs
>> nodes
>> exposed using hwmon interface.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>> =A0Documentation/hwmon/omap_temp_sensor | =A0 27 +
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0933
>> ++++++++++++++++++++++++++++++++++
>> =A04 files changed, 972 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>>
>> diff --git a/Documentation/hwmon/omap_temp_sensor
>> b/Documentation/hwmon/omap_temp_sensor
>> new file mode 100644
>> index 0000000..e01a6d6
>> --- /dev/null
>> +++ b/Documentation/hwmon/omap_temp_sensor
>> @@ -0,0 +1,27 @@
>> +Kernel driver omap_temp_sensor
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Supported chips:
>> + =A0* Texas Instruments OMAP4460
>> + =A0 =A0Prefix: 'omap_temp_sensor'
>> + =A0 =A0Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp102.h=
tml
>> +
>> +Author:
>> + =A0 =A0 =A0 =A0J Keerthy <j-keerthy@ti.com>
>> +
>> +Description
>> +-----------
>> +
>> +The Texas Instruments OMAP4 family of chips have a bandgap temperature
>> sensor.
>> +The temperature sensor feature is used to convert the temperature of the
>> device
>> +into a decimal value coded on 10 bits. An internal ADC is used for
>> conversion.
>> +The recommended operating temperatures must be in the range -40 degree
>> Celsius
>> +to 123 degree celsius for standard conversion.
>> +The thresholds are programmable and upon crossing the thresholds an
>> interrupt
>> +is generated. The OMAP temperature sensor has a programmable update rate
>> in
>> +milli seconds.
>> +(Currently the driver programs a default of 2000 milli seconds).
>> +
>> +The driver provides the common sysfs-interface for temperatures (see
>> +Documentation/hwmon/sysfs-interface under Temperatures).
>> +
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 5f888f7..9c9cd8b 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, =
the module
>> =A0 =A0 =A0 =A0 =A0will be called f71805f.
>>
>> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
>> + =A0 =A0 =A0 bool "OMAP on-die temperature sensor hwmon driver"
>> + =A0 =A0 =A0 depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 If you say yes here you get support for hardware
>> + =A0 =A0 =A0 =A0 monitoring features of the OMAP on die temperature
>> + =A0 =A0 =A0 =A0 sensor.
>> +
>> + =A0 =A0 =A0 =A0 Continuous conversion programmable delay
>> + =A0 =A0 =A0 =A0 mode is used for temperature conversion.
>> +
>> =A0config SENSORS_F71882FG
>> =A0 =A0 =A0 =A0tristate "Fintek F71882FG and compatibles"
>> =A0 =A0 =A0 =A0help
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 28061cf..d0f89f5 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) +=3D max6639.o
>> =A0obj-$(CONFIG_SENSORS_MAX6642) =A0+=3D max6642.o
>> =A0obj-$(CONFIG_SENSORS_MAX6650) =A0+=3D max6650.o
>> =A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
>> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap_temp_sensor=
.o
>> =A0obj-$(CONFIG_SENSORS_PC87360) =A0+=3D pc87360.o
>> =A0obj-$(CONFIG_SENSORS_PC87427) =A0+=3D pc87427.o
>> =A0obj-$(CONFIG_SENSORS_PCF8591) =A0+=3D pcf8591.o
>> diff --git a/drivers/hwmon/omap_temp_sensor.c
>> b/drivers/hwmon/omap_temp_sensor.c
>> new file mode 100644
>> index 0000000..66fb3a9
>> --- /dev/null
>> +++ b/drivers/hwmon/omap_temp_sensor.c
>> @@ -0,0 +1,933 @@
>> +/*
>> + * OMAP4 Temperature sensor driver file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.co=
m/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + * Author: Moiz Sonasath <m-sonasath@ti.com>
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
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <plat/omap_device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/device.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/stddef.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/err.h>
>> +#include <linux/types.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/delay.h>
>> +#include <plat/temperature_sensor.h>
>> +
>> +#define TSHUT_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0920 =A0 =A0 /* 122 deg C */
>> +#define TSHUT_COLD =A0 =A0 =A0 =A0 =A0 =A0 866 =A0 =A0 /* 100 deg C */
>> +#define T_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0800 =A0 =A0 /* 73 deg =
C */
>> +#define T_COLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 795 =A0 =A0 /* 71 deg C =
*/
>> +#define OMAP_ADC_START_VALUE =A0 530
>> +#define OMAP_ADC_END_VALUE =A0 =A0 923
>> +#define MAX_FREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 2000000
>> +#define MIN_FREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000000
>> +
>> +/*
>> + * omap_temp_sensor structure
>> + * @hwmon_dev - device pointer
>> + * @clock - Clock pointer
>> + * @registers - Pointer to structure with register offsets and bitfields
>> + * @sensor_mutex - Mutex for sysfs, irq and PM
>> + * @irq - MPU Irq number for thermal alert
>> + * @phy_base - Physical base of the temp I/O
>> + * @clk_rate - Holds current clock rate
>> + * @temp_sensor_ctrl - temp sensor control register value
>> + * @bg_ctrl - bandgap ctrl register value
>> + * @bg_counter - bandgap counter value
>> + * @bg_threshold - bandgap threshold register value
>> + * @temp_sensor_tshut_threshold - bandgap tshut register value
>> + * @is_efuse_valid - Flag to determine if efuse is valid or not
>> + * @clk_on - Manages the current clock state
>> + */
>> +struct omap_temp_sensor {
>> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
>> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;
>> + =A0 =A0 =A0 struct omap_temp_sensor_registers *registers;
>> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* Mutex=
 for sysfs, irq and
>> PM */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
>> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ct=
rl;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ts=
hut_threshold;
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_efuse_valid;
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;
>> +};
>> +
>> +/*
>> + * Temperature values in milli degree celsius
>> + * ADC code values from 530 to 923
>> + */
>> +static int adc_to_temp[] =3D {
>> + =A0 =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -3=
8600,
>> -38200,
>> + =A0 =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -3=
4800,
>> + =A0 =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -3=
1300,
>> + =A0 =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -2=
7800,
>> + =A0 =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -2=
4400,
>> + =A0 =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -2=
1000,
>> + =A0 =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -1=
7600,
>> + =A0 =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -1=
4200,
>> + =A0 =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -1=
0700,
>> + =A0 =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -=
6800,
>> + =A0 =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3=
000,
>> + =A0 =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200,=
 1600,
>> + =A0 =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000=
, 6400,
>> + =A0 =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 106=
00,
>> 11000,
>> + =A0 =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14=
800,
>> + =A0 =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18=
700,
>> + =A0 =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22=
600,
>> + =A0 =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26=
400,
>> + =A0 =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30=
200,
>> + =A0 =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34=
000,
>> + =A0 =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37=
800,
>> + =A0 =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41=
600,
>> + =A0 =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45=
300,
>> + =A0 =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49=
000,
>> + =A0 =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52=
800,
>> + =A0 =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56=
600,
>> + =A0 =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60=
400,
>> + =A0 =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64=
200,
>> + =A0 =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67=
800,
>> + =A0 =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71=
600,
>> + =A0 =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75=
400,
>> + =A0 =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79=
000,
>> + =A0 =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82=
800,
>> + =A0 =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86=
400,
>> + =A0 =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90=
200,
>> + =A0 =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93=
800,
>> + =A0 =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97=
600,
>> + =A0 =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800,=
 101200,
>> + =A0 =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 10=
4400,
>> + =A0 =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 10=
7800,
>> + =A0 =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 11=
1000,
>> + =A0 =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 11=
4200,
>> + =A0 =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 11=
7400,
>> + =A0 =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 12=
0600,
>> + =A0 =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
>> +};
>> +
>> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 *temp_sensor, u32 reg)
>> +{
>> + =A0 =A0 =A0 return __raw_readl(temp_sensor->phy_base + reg);
>> +}
>> +
>> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_senso=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u3=
2 val, u32 reg)
>> +{
>> + =A0 =A0 =A0 __raw_writel(val, (temp_sensor->phy_base + reg));
>> +}
>> +
>> +static int adc_to_temp_conversion(int adc_val)
>> +{
>> + =A0 =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
>> +}
>> +
>> +static int temp_to_adc_conversion(long temp)
>> +{
>> + =A0 =A0 =A0 int high, low, mid;
>> +
>> + =A0 =A0 =A0 if (temp < adc_to_temp[0] ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp > adc_to_temp[OMAP_ADC_END_VALUE -
>> OMAP_ADC_START_VALUE])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 high =3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;
>> + =A0 =A0 =A0 low =3D 0;
>> + =A0 =A0 =A0 mid =3D (high + low) / 2;
>> +
>> + =A0 =A0 =A0 while (low < high) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[mid])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D mid - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D mid + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D (low + high) / 2;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return OMAP_ADC_START_VALUE + low;
>> +}
>> +
>> +static void omap_configure_temp_sensor_thresholds(struct omap_temp_sens=
or
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 *temp_sensor)
>> +{
>> + =A0 =A0 =A0 u32 temp;
>> +
>> + =A0 =A0 =A0 /* Configure the TALERT thresholds */
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 temp |=3D (T_HOT <<
>> __ffs(temp_sensor->registers->threshold_thot_mask)) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (T_COLD <<
>> __ffs(temp_sensor->registers->threshold_tcold_mask));
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> +
>> + =A0 =A0 =A0 /* Configure the TSHUT thresholds */
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->th=
sut_threshold);
>> + =A0 =A0 =A0 temp |=3D (TSHUT_HOT <<
>> __ffs(temp_sensor->registers->tshut_hot_mask))
>> + =A0 =A0 =A0 =A0 =A0 | (TSHUT_COLD <<
>> __ffs(temp_sensor->registers->tshut_hot_mask));
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->th=
sut_threshold);
>> +}
>> +
>> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)
>> +{
>> + =A0 =A0 =A0 u32 val;
>> +
>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_counter);
>> + =A0 =A0 =A0 val &=3D ~temp_sensor->registers->counter_mask;
>> + =A0 =A0 =A0 val |=3D counter << __ffs(temp_sensor->registers->counter_=
mask);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_counter);
>> +}
>> +
>> +static void omap_enable_continuous_mode(struct omap_temp_sensor
>> *temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 bool enable)
>> +{
>> + =A0 =A0 =A0 u32 val;
>> +
>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_mode_ctrl);
>> +
>> + =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D 1 << __ffs(temp_sensor->registers=
->mode_ctrl_mask);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~temp_sensor->registers->mode_ctr=
l_mask;
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_mode_ctrl);
>> +}
>> +
>> +/* Sysfs hook functions */
>> +
>> +static ssize_t show_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *d=
evattr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 int temp;
>> +
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_thot_ma=
sk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >>
>> __ffs(temp_sensor->registers->threshold_thot_mask);
>> +
>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VAL=
UE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attr=
ibute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, s=
ize_t count)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, t_col=
d, t_hot, temp;
>> +
>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> + =A0 =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_=
VALUE))
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 /* obtain the T cold value */
>> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshold_tco=
ld_mask)
>> >>
>> +
>> __ffs(temp_sensor->registers->threshold_tcold_mask);
>> +
>> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_thot_mask;
>> + =A0 =A0 =A0 reg_val |=3D (t_hot <<
>> +
>> __ffs(temp_sensor->registers->threshold_thot_mask));
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> +
>> + =A0 =A0 =A0 /* Read the current temperature */
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->te=
mp_sensor_ctrl);
>> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than t=
he current
>> + =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (t_hot > temp) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_se=
nsor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->mask=
_cold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
hot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_v=
al,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and cold
>> thresholds,
>> + =A0 =A0 =A0 =A0* Enable both masks.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (temp > t_cold && temp < t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_se=
nsor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
cold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
hot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_v=
al,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4460_B=
GAP_CTRL_OFFSET);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immediately=
 compare
>> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordingly
>> + =A0 =A0 =A0 =A0*/
>> +out:
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *bu=
f)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tcold_m=
ask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold_tc=
old_mask);
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VAL=
UE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
device_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const c=
har *buf, size_t count)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor >> de=
v_get_drvdata(dev);
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 reg_val, t_hot, t_cold, temp;
>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0val;
>> +
>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> + =A0 =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END=
_VALUE)
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 /* obtain the T HOT value */
>> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshold_thot_=
mask) >>
>> +
>> __ffs(temp_sensor->registers->threshold_thot_mask);
>> +
>> + =A0 =A0 =A0 if (t_cold > t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* write the new t_cold value */
>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_tcold_mask;
>> + =A0 =A0 =A0 reg_val |=3D t_cold <<
>> +
>> __ffs(temp_sensor->registers->threshold_tcold_mask);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_threshold);
>> +
>> + =A0 =A0 =A0 /* Read the current temperature */
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than the=
 current
>> + =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (t_cold < temp) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_se=
nsor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->mask=
_hot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
cold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_v=
al,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_mask_ctrl);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and cold
>> thresholds,
>> + =A0 =A0 =A0 =A0* Enable both masks.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (temp < t_hot && temp > t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_se=
nsor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
cold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_=
hot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_v=
al,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immediately=
 compare
>> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordingly
>> + =A0 =A0 =A0 =A0*/
>> +
>> +out:
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_update_rate(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *d=
evattr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 0, re=
t =3D 0;
>> +
>> +
>> + =A0 =A0 =A0 if (!temp_sensor->clk_rate) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_counter);
>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registe=
rs->counter_mask);
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp =3D temp * 1000 / temp_sensor->clk_rate;
>> +
>> +out:
>> + =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static ssize_t set_update_rate(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devi=
ce_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char =
*buf, size_t count)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;
>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> +
>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_counter);
>> +
>> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->counter_mask;
>> + =A0 =A0 =A0 reg_val |=3D val;
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_counter);
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> +out:
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static int omap_temp_sensor_read_temp(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct device_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 char *buf)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret =3D =
0;
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 =A0 /* look up for temperature in the table and return the tem=
perature
>> */
>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VAL=
UE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code reported %d=
", temp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>> +
>> +out:
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>> omap_temp_sensor_read_temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
>> show_temp_max_hyst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);
>> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO,
>> show_update_rate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, 0);
>> +
>> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> + =A0 =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
>> + =A0 =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group omap_temp_sensor_group =3D {
>> + =A0 =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>> +};
>> +
>> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor
>> *temp_sensor)
>> +{
>> + =A0 =A0 =A0 u32 ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock alr=
eady on\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get sync =
failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp_sensor->clk_on =3D 1;
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor
>> *temp_sensor)
>> +{
>> + =A0 =A0 =A0 u32 ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (!temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock alr=
eady off\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Gate the clock */
>> + =A0 =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "put sync =
failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 temp_sensor->clk_on =3D 0;
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 t_hot, t_cold, temp;
>> +
>> + =A0 =A0 =A0 temp_sensor =3D data;
>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 /* Read the status of t_hot */
>> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->=
status_hot_mask;
>> +
>> + =A0 =A0 =A0 /* Read the status of t_cold */
>> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->=
status_cold_mask;
>> +
>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_mask_ctrl);
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources
>> + =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot and
>> + =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_hot
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask_ho=
t_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_col=
d_mask;
>> + =A0 =A0 =A0 } else if (t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask_co=
ld_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_hot=
_mask;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 =A0 /* kobject_uvent to user space telling thermal threshold c=
rossed
>> */
>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHANGE);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit omap_temp_sensor_probe(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev->dev.=
platform_data;
>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ret =3D 0;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 val, clk_rate;
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 max_freq, min_freq;
>> +
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data missing=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!temp_sensor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "therma=
l_alert");
>> + =A0 =A0 =A0 if (temp_sensor->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname failed=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resource_siz=
e(mem));
>> + =A0 =A0 =A0 temp_sensor->clock =3D NULL;
>> + =A0 =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> +
>> + =A0 =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> + =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> + =A0 =A0 =A0 =A0* may not be accurate
>> + =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bg=
ap_efuse)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(temp_sensor->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid EFUSE, Non-trimme=
d BGAP, Temp not
>> accurate\n");
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> + =A0 =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev, "fc=
k");
>> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: %d\n"=
, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable temp se=
nsor\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, max_freq);
>> + =A0 =A0 =A0 if (clk_rate < min_freq || clk_rate =3D 0xffffffff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock rate=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> + =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> + =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> + =A0 =A0 =A0 /* 1 ms */
>> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> +
>> + =A0 =A0 =A0 /* Wait till the first conversion is done wait for at leas=
t 1ms */
>> + =A0 =A0 =A0 usleep_range(1000, 2000);
>> +
>> + =A0 =A0 =A0 /* Read the temperature once due to hw issue*/
>> + =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->te=
mp_sensor_ctrl);
>> +
>> + =A0 =A0 =A0 /* Set 2 seconds time as default counter */
>> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate *
>> 2);
>> +
>> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev->de=
v);
>> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register=
 failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap_t=
emp_sensor_group);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create sysf=
s files\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
>> +
>> + =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_RISI=
NG |
>> IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_sensor=
);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded irq =
failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_mask;
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +req_irq_err:
>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
>> + =A0 =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp=
_sensor_group);
>> +sysfs_create_err:
>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> +hwmon_reg_err:
>> + =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> +clken_err:
>> + =A0 =A0 =A0 clk_put(temp_sensor->clock);
>> +plat_res_err:
>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 kfree(temp_sensor);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit omap_temp_sensor_remove(struct platform_device
>> *pdev)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D platform_get_drvd=
ata(pdev);
>> +
>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
>> + =A0 =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sensor_group);
>> + =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> + =A0 =A0 =A0 free_irq(temp_sensor->irq, temp_sensor);
>> + =A0 =A0 =A0 clk_put(temp_sensor->clock);
>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 =A0 kfree(temp_sensor);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor
>> *temp_sensor)
>> +{
>> + =A0 =A0 =A0 temp_sensor->temp_sensor_ctrl >> omap_temp_sensor_readl(te=
mp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 =A0 temp_sensor->bg_ctrl =3D omap_temp_sensor_readl(temp_senso=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 temp_sensor->bg_counter =3D omap_temp_sensor_readl(temp_se=
nsor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_counter);
>> + =A0 =A0 =A0 temp_sensor->bg_threshold =3D omap_temp_sensor_readl(temp_=
sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 =A0 temp_sensor->temp_sensor_tshut_threshold >> + =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsut_threshold);
>> +}
>> +
>> +static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor
>> *temp_sensor)
>> +{
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->temp_sensor_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->temp_sensor_ctrl);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->bg_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_mask_ctrl);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->bg_counter,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_counter);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->bg_threshold,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->bgap_threshold);
>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->temp_sensor_tshut_threshold,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_senso=
r->registers->thsut_threshold);
>> +}
>> +
>> +static int omap_temp_sensor_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_resume(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> +
>> + =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 =A0 static int context_loss_count;
>> + =A0 =A0 =A0 int temp;
>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(d=
ev);
>> +
>> + =A0 =A0 =A0 temp >> omap_device_get_context_loss_count(to_platform_dev=
ice(dev));
>> +
>> + =A0 =A0 =A0 if (temp !=3D context_loss_count && context_loss_count !=
=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);
>> +
>> + =A0 =A0 =A0 context_loss_count =3D temp;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_idle(struct device *dev)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {
>> + =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(omap_temp_sensor_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_resume)
>> + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(omap_temp_sensor_runtime_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_runtime_r=
esume,
>> omap_temp_sensor_idle)
>> +};
>> +
>> +#define DEV_PM_OPS =A0 =A0 (&omap_temp_sensor_dev_pm_ops)
>> +#else
>> +#define DEV_PM_OPS =A0 =A0 NULL
>> +#endif
>> +
>> +static struct platform_driver omap_temp_sensor_driver =3D {
>> + =A0 =A0 =A0 .probe =3D omap_temp_sensor_probe,
>> + =A0 =A0 =A0 .remove =3D omap_temp_sensor_remove,
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap_temp_senso=
r",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D DEV_PM_OPS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> +};
>> +
>> +int __init omap_temp_sensor_init(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_register(&omap_temp_sensor_driver);
>> +}
>> +module_init(omap_temp_sensor_init);
>> +
>> +static void __exit omap_temp_sensor_exit(void)
>> +{
>> + =A0 =A0 =A0 platform_driver_unregister(&omap_temp_sensor_driver);
>> +}
>> +module_exit(omap_temp_sensor_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP446X temperature sensor Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Thanks and Regards,
> Janakiram Sistla.
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
