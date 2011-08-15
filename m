From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Mon, 15 Aug 2011 06:34:02 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13Z3JKCqd_WX4YjqG3e04n0mayD1f7K3MWyCSn=uhKzYMQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<D6D887BA8C9DFF48B5233887EF04654109E894BB3C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654109E894BB3C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "vishwanath.bs@ti.com" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "rnayak@ti.com" <rnayak@ti.com>

Hi,

Thanks for the Review Durga.

On Wed, Aug 10, 2011 at 10:05 PM, R, Durgadoss <durgadoss.r@intel.com> wrot=
e:
> Hi,
>
>> -----Original Message-----
>> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
>> sensors.org] On Behalf Of Keerthy
>> Sent: Wednesday, August 10, 2011 5:55 PM
>> To: lm-sensors@lm-sensors.org
>> Cc: vishwanath.bs@ti.com; linux-omap@vger.kernel.org; b-cousson@ti.com;
>> rnayak@ti.com
>> Subject: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature s=
ensor
>> driver
>>
>> On chip temperature sensor driver. The driver monitors the temperature of
>> the MPU subsystem of the OMAP4. It sends notifications to the user space=
 if
>> the temperature crosses user defined thresholds via kobject_uevent inter=
face.
>> The user is allowed to configure the temperature thresholds vis sysfs no=
des
>> exposed using hwmon interface.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hwmon/omap_temp_sensor.c | =A0950 +++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 962 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 5f888f7..9c9cd8b 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the=
 module
>> =A0 =A0 =A0 =A0 will be called f71805f.
>>
>> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
>> + =A0 =A0 bool "OMAP on-die temperature sensor hwmon driver"
>> + =A0 =A0 depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
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
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 28061cf..d0f89f5 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) =A0 =A0 =A0 +=3D max6639=
.o
>> =A0obj-$(CONFIG_SENSORS_MAX6642) =A0 =A0 =A0 =A0+=3D max6642.o
>> =A0obj-$(CONFIG_SENSORS_MAX6650) =A0 =A0 =A0 =A0+=3D max6650.o
>> =A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
>> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap_temp_sensor=
.o
>> =A0obj-$(CONFIG_SENSORS_PC87360) =A0 =A0 =A0 =A0+=3D pc87360.o
>> =A0obj-$(CONFIG_SENSORS_PC87427) =A0 =A0 =A0 =A0+=3D pc87427.o
>> =A0obj-$(CONFIG_SENSORS_PCF8591) =A0 =A0 =A0 =A0+=3D pcf8591.o
>> diff --git a/drivers/hwmon/omap_temp_sensor.c
>> b/drivers/hwmon/omap_temp_sensor.c
>> new file mode 100644
>> index 0000000..15e2559
>> --- /dev/null
>> +++ b/drivers/hwmon/omap_temp_sensor.c
>> @@ -0,0 +1,950 @@
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
>> +#include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/init.h>
>> +#include <plat/omap_device.h>
>> +#include <linux/module.h>
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
>> +#include <plat/common.h>
>> +#include <plat/temperature_sensor.h>
>> +#include <mach/ctrl_module_core_44xx.h>
>> +#include <mach/gpio.h>
>> +
>> +#define TSHUT_THRESHOLD_HOT =A0122000 =A0/* 122 deg C */
>> +#define TSHUT_THRESHOLD_COLD 100000 =A0/* 100 deg C */
>> +#define BGAP_THRESHOLD_T_HOT 73000 =A0 /* 73 deg C */
>> +#define BGAP_THRESHOLD_T_COLD =A0 =A0 =A0 =A071000 =A0 /* 71 deg C */
>> +#define OMAP_ADC_START_VALUE 530
>> +#define OMAP_ADC_END_VALUE =A0 923
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
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
>> + =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;
>> + =A0 =A0 struct omap_temp_sensor_registers *registers;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* Mutex for=
 sysfs, irq and PM */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ctrl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_tshut_=
threshold;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_efuse_valid;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;
>> +};
>> +
>> +/*
>> + * Temperature values in milli degree celsius
>> + * ADC code values from 530 to 923
>> + */
>> +static int adc_to_temp[] =3D {
>> + =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600=
, -38200,
>> + =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -34800,
>> + =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -31300,
>> + =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -27800,
>> + =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -24400,
>> + =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -21000,
>> + =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -17600,
>> + =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -14200,
>> + =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -10700,
>> + =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -6800,
>> + =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000,
>> + =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 160=
0,
>> + =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 64=
00,
>> + =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600, =
11000,
>> + =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800,
>> + =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700,
>> + =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600,
>> + =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400,
>> + =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200,
>> + =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000,
>> + =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800,
>> + =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600,
>> + =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300,
>> + =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000,
>> + =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800,
>> + =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600,
>> + =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400,
>> + =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200,
>> + =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800,
>> + =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600,
>> + =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400,
>> + =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000,
>> + =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800,
>> + =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400,
>> + =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200,
>> + =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800,
>> + =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600,
>> + =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 101=
200,
>> + =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 104400,
>> + =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 107800,
>> + =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
>> + =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 114200,
>> + =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 117400,
>> + =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 120600,
>> + =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
>> +};
>> +
>> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 *temp_sensor, u32 reg)
>> +{
>> + =A0 =A0 return __raw_readl(temp_sensor->phy_base + reg);
>> +}
>> +
>> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_senso=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 va=
l, u32 reg)
>> +{
>> + =A0 =A0 __raw_writel(val, (temp_sensor->phy_base + reg));
>> +}
>> +
>> +static int adc_to_temp_conversion(int adc_val)
>> +{
>> + =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
>> +}
>> +
>> +static int temp_to_adc_conversion(long temp)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i <=3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE=
; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_ADC_START_VALUE + =
i - 1;
>> +
>> + =A0 =A0 return -EINVAL;
>> +}
>> +
>> +static void omap_configure_temp_sensor_thresholds(struct omap_temp_sens=
or
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 *temp_sensor)
>> +{
>> + =A0 =A0 u32 temp, t_hot, t_cold, tshut_hot, tshut_cold;
>> +
>> + =A0 =A0 t_hot =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_HOT);
>> + =A0 =A0 t_cold =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_COLD);
>> +
>> + =A0 =A0 /* Configure the TALERT thresholds */
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 temp |=3D (t_hot << __ffs(temp_sensor->registers->threshold_th=
ot_mask)) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (t_cold << __ffs(temp_sensor->registers->thres=
hold_tcold_mask));
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> +
>> + =A0 =A0 tshut_hot =3D temp_to_adc_conversion(TSHUT_THRESHOLD_HOT);
>> + =A0 =A0 tshut_cold =3D temp_to_adc_conversion(TSHUT_THRESHOLD_COLD);
>> +
>> + =A0 =A0 /* Configure the TSHUT thresholds */
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsut_=
threshold);
>> + =A0 =A0 temp |=3D (tshut_hot << __ffs(temp_sensor->registers->tshut_ho=
t_mask))
>> + =A0 =A0 =A0 =A0 | (tshut_cold << __ffs(temp_sensor->registers->tshut_h=
ot_mask));
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsut_=
threshold);
>> +}
>> +
>> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)
>> +{
>> + =A0 =A0 u32 val;
>> +
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> + =A0 =A0 val &=3D ~(temp_sensor->registers->counter_mask);
>> + =A0 =A0 val |=3D (counter << __ffs(temp_sensor->registers->counter_mas=
k));
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> +}
>> +
>> +static void omap_enable_continuous_mode(struct omap_temp_sensor *temp_s=
ensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 bool enable)
>> +{
>> + =A0 =A0 u32 val;
>> +
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ode_ctrl);
>> +
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (1 << __ffs(temp_sensor->registers->m=
ode_ctrl_mask));
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(temp_sensor->registers->mode_ctrl_m=
ask);
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ode_ctrl);
>> +}
>> +
>> +/* Sysfs hook functions */
>> +
>> +static ssize_t show_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devat=
tr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_thot_mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->register=
s->threshold_thot_mask);
>> +
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>
> Even if it is invalid value, you are printing it.
> May be you would have to do unlocking and returning -EINVAL inside the 'i=
f' check.

Ok

>
> Moreover, you are just doing a read.
> So, do you really need a mutex_lock in this function.. ?

These values are RW. So the user can write a new value
while you are reading. To be consistent mutex_lock is needed.

>
>> +}
>> +
>> +static ssize_t set_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribut=
e *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_=
t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, t_cold, t=
_hot, temp;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALU=
E)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* obtain the T cold value */
>> + =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshold_tcold_m=
ask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_tcold_mask);
>> +
>> + =A0 =A0 if (t_hot < t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_HOT value lesser than T=
_COLD\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_thot_mask);
>> + =A0 =A0 reg_val |=3D (t_hot <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_thot_mask));
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> +
>> + =A0 =A0 /* Read the current temperature */
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> + =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than the c=
urrent
>> + =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (t_hot > temp) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->mask_co=
ld_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_hot_=
mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If current temperature is in-between the hot and cold thr=
esholds,
>> + =A0 =A0 =A0* Enable both masks.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (temp > t_cold && temp < t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_cold=
_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_hot_=
mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4460_BGAP_=
CTRL_OFFSET);
>> + =A0 =A0 }
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* else no need to do anything since HW will immediately com=
pare
>> + =A0 =A0 =A0* the new threshold and generate interrupt accordingly
>> + =A0 =A0 =A0*/
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tcold_mask)=
 >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold_tcold_=
mask);
>> +
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> Same case here..
> You can do ret =3D -EINVAL here..

Ok

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>
> ...subsequently,
> ret =3D snprintf(buf, 16, "%d\n", temp);
>
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>
> Return ret here..

Ok

>
>> +}
>> +
>> +static ssize_t set_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devi=
ce_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char =
*buf, size_t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =3D dev_g=
et_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
g_val, t_hot, t_cold, temp;
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0va=
l;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END_VAL=
UE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range");
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* obtain the T HOT value */
>> + =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshold_thot_mask=
) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_thot_mask);
>> +
>> + =A0 =A0 if (t_cold > t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_COLD value greater than=
 T_HOT\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* write the new t_cold value */
>> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_tcold_mask);
>> + =A0 =A0 reg_val |=3D (t_cold <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_tcold_mask));
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> +
>> + =A0 =A0 /* Read the current temperature */
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than the cur=
rent
>> + =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (t_cold < temp) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->mask_ho=
t_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_cold=
_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ask_ctrl);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If current temperature is in-between the hot and cold thr=
esholds,
>> + =A0 =A0 =A0* Enable both masks.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (temp < t_hot && temp > t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_cold=
_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_hot_=
mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* else no need to do anything since HW will immediately com=
pare
>> + =A0 =A0 =A0* the new threshold and generate interrupt accordingly
>> + =A0 =A0 =A0*/
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_update_rate(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devat=
tr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 0, ret =
=3D 0;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 if (!temp_sensor->clk_rate) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
counter_mask);
>> + =A0 =A0 temp =3D temp * 1000 / (temp_sensor->clk_rate);
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> + =A0 =A0 else
>
> The 'else' is not necessary..

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static ssize_t set_update_rate(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_a=
ttribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *buf=
, size_t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> +
>> + =A0 =A0 reg_val &=3D ~(temp_sensor->registers->counter_mask);
>> + =A0 =A0 reg_val |=3D val;
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 return count;
>> +}
>> +
>> +static int omap_temp_sensor_read_temp(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct device_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch=
ar *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret =3D 0;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 if (!temp_sensor->is_efuse_valid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid EFUSE, Non-trimmed BGAP,=
 Temp not
>> accurate\n");
>> +
>> + =A0 =A0 /* look up for temperature in the table and return the tempera=
ture */
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code reported %d", t=
emp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> + =A0 =A0 else
>
> Same here..

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_t=
emp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
>> show_temp_max_hyst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);
>> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update_r=
ate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, 0);
>> +
>> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>> + =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group omap_temp_sensor_group =3D {
>> + =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>> +};
>> +
>> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_se=
nsor)
>> +{
>> + =A0 =A0 u32 ret =3D 0, temp;
>> +
>> + =A0 =A0 if (temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock already=
 on\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get sync fail=
ed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>
> Please do not mask the return value.
> Let it be whatever returned by the get_sync.
> Anyway, you are returning 'ret' in the end...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> + =A0 =A0 temp &=3D ~(temp_sensor->registers->bgap_tempsoff_mask);
>> + =A0 =A0 /* BGAP_TEMPSOFF should be reset to 0 */
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->temp_sensor_ctrl);
>> + =A0 =A0 temp_sensor->clk_on =3D 1;
>> +out:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_s=
ensor)
>> +{
>> + =A0 =A0 u32 temp, ret =3D 0;
>> + =A0 =A0 unsigned long timeout;
>> +
>> + =A0 =A0 if (!temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock already=
 off\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> + =A0 =A0 temp |=3D temp_sensor->registers->bgap_tempsoff_mask;
>> +
>> + =A0 =A0 /* BGAP_TEMPSOFF should be set to 1 before gating clock */
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus);
>> + =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(5);
>> +
>> + =A0 =A0 /* wait till the clean stop bit is set or till the timeout exp=
pires */
>
> s/expires/expires

I will correct this.

>
>> + =A0 =A0 while (!(temp | temp_sensor->registers->status_clean_stop_mask=
) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 !(time_after(jiffies, timeout))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(500, 2000);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (time_after(jiffies, timeout))
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "Clean stop bi=
t not set\n");
>> + =A0 =A0 /* Gate the clock */
>> + =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "put sync fail=
ed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>
> Same case as get_sync. Don't mask the return value.

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 temp_sensor->clk_on =3D 0;
>> +out:
>> + =A0 =A0 return ret;
>> +}
>> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>> +{
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_=
hot, t_cold, temp;
>> +
>> + =A0 =A0 temp_sensor =3D data;
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 /* Read the status of t_hot */
>> + =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->stat=
us_hot_mask;
>> +
>> + =A0 =A0 /* Read the status of t_cold */
>> + =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->stat=
us_cold_mask;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ask_ctrl);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* One TALERT interrupt: Two sources
>> + =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot and
>> + =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_hot
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(temp_sensor->registers->mask_hot_m=
ask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_cold_ma=
sk;
>> + =A0 =A0 } else if (t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(temp_sensor->registers->mask_cold_=
mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_hot_mas=
k;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 /* kobject_uvent to user space telling thermal threshold cross=
ed */
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHANGE);
>> +
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit omap_temp_sensor_probe(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev->dev.plat=
form_data;
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
t =3D 0;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 va=
l, clk_rate;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data missing\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
>> + =A0 =A0 if (!temp_sensor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>
> You can do PTR_ERR(mem) to get the return error value as an integer.
> Otherwise, it makes more sense to be -ENOMEM

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "thermal_al=
ert");
>> + =A0 =A0 if (temp_sensor->irq =3D -ENXIO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>
> This flow can better be:
> ret =3D platform_get_irq_byname(...)
> if (ret < 0) //because it is an IRQ number
> { ... }
>

Ok


> Then assign ret to temp_sensor->irq

Ok

>
>> + =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resource_size(me=
m));
>> + =A0 =A0 temp_sensor->clock =3D NULL;
>> + =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> + =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> +
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> + =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> + =A0 =A0 =A0* may not be accurate
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_e=
fuse))
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, temp_sensor);
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> + =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev, "fck");
>> + =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: %d\n", re=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>
> Same case here. Do not assign -EINVAL to ret

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable temp sensor=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, 2000000);
>> + =A0 =A0 if (clk_rate < 1000000 || clk_rate =3D 0xffffffff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate\n");
>
> You might want to assign something to 'ret' here.

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> + =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> + =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> + =A0 =A0 /* 1 ms */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> +
>> + =A0 =A0 /* Wait till the first conversion is done wait for at least 1m=
s */
>> + =A0 =A0 usleep_range(1000, 2000);
>> +
>> + =A0 =A0 /* Read the temperature once due to hw issue*/
>> + =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> +
>> + =A0 =A0 /* Set 2 seconds time as default counter */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> +
>> + =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register fai=
led.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap_temp_=
sensor_group);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create sysfs fi=
les\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
>> +
>> + =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_RISING |=
 IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_sensor);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded irq fail=
ed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> + =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> + =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_mask;
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 return 0;
>> +
>> +req_irq_err:
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
>> + =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sen=
sor_group);
>> +sysfs_create_err:
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> +hwmon_reg_err:
>> + =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> +clken_err:
>> + =A0 =A0 if (temp_sensor->clock)
>
> Looking at the probe flow, this 'if' check seems unnecessary.

Ok

>
> Thanks,
> Durga
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
