From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 24 Aug 2011 17:16:12 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <20110824171612.GA8160@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314196403-8143-7-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1314196403-8143-7-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
> On chip temperature sensor driver. The driver monitors the temperature of
> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> the temperature crosses user defined thresholds via kobject_uevent interface.
> The user is allowed to configure the temperature thresholds vis sysfs nodes
> exposed using hwmon interface.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: lm-sensors@lm-sensors.org

Partial review only. Too many concerns, and after a while I tend to loose track.

> ---
>  Documentation/hwmon/omap_temp_sensor |   27 +
>  drivers/hwmon/Kconfig                |   11 +
>  drivers/hwmon/Makefile               |    1 +
>  drivers/hwmon/omap_temp_sensor.c     |  933 ++++++++++++++++++++++++++++++++++
>  4 files changed, 972 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/omap_temp_sensor
>  create mode 100644 drivers/hwmon/omap_temp_sensor.c
> 
> diff --git a/Documentation/hwmon/omap_temp_sensor b/Documentation/hwmon/omap_temp_sensor
> new file mode 100644
> index 0000000..e01a6d6
> --- /dev/null
> +++ b/Documentation/hwmon/omap_temp_sensor
> @@ -0,0 +1,27 @@
> +Kernel driver omap_temp_sensor
> +===============
> +
> +Supported chips:
> +  * Texas Instruments OMAP4460
> +    Prefix: 'omap_temp_sensor'
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp102.html
> +

I am a bit lost here. What does the TMP102 have to do with the OMAP4460 ?

> +Author:
> +        J Keerthy <j-keerthy@ti.com>
> +
> +Description
> +-----------
> +
> +The Texas Instruments OMAP4 family of chips have a bandgap temperature sensor.
> +The temperature sensor feature is used to convert the temperature of the device
> +into a decimal value coded on 10 bits. An internal ADC is used for conversion.
> +The recommended operating temperatures must be in the range -40 degree Celsius
> +to 123 degree celsius for standard conversion.
> +The thresholds are programmable and upon crossing the thresholds an interrupt
> +is generated. The OMAP temperature sensor has a programmable update rate in
> +milli seconds.
> +(Currently the driver programs a default of 2000 milli seconds).
> +

s/milli seconds/milliseconds/

> +The driver provides the common sysfs-interface for temperatures (see
> +Documentation/hwmon/sysfs-interface under Temperatures).
> +
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5f888f7..9c9cd8b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>           This driver can also be built as a module.  If so, the module
>           will be called f71805f.
> 
> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
> +       bool "OMAP on-die temperature sensor hwmon driver"
> +       depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
> +       help
> +         If you say yes here you get support for hardware
> +         monitoring features of the OMAP on die temperature
> +         sensor.
> +
> +         Continuous conversion programmable delay
> +         mode is used for temperature conversion.
> +
>  config SENSORS_F71882FG
>         tristate "Fintek F71882FG and compatibles"
>         help
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 28061cf..d0f89f5 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) += max6639.o
>  obj-$(CONFIG_SENSORS_MAX6642)  += max6642.o
>  obj-$(CONFIG_SENSORS_MAX6650)  += max6650.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR)  += omap_temp_sensor.o
>  obj-$(CONFIG_SENSORS_PC87360)  += pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)  += pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)  += pcf8591.o
> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_temp_sensor.c
> new file mode 100644
> index 0000000..66fb3a9
> --- /dev/null
> +++ b/drivers/hwmon/omap_temp_sensor.c
> @@ -0,0 +1,933 @@
> +/*
> + * OMAP4 Temperature sensor driver file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Author: J Keerthy <j-keerthy@ti.com>
> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
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
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <plat/omap_device.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/stddef.h>
> +#include <linux/sysfs.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
> +#include <plat/temperature_sensor.h>
> +
> +#define TSHUT_HOT              920     /* 122 deg C */
> +#define TSHUT_COLD             866     /* 100 deg C */
> +#define T_HOT                  800     /* 73 deg C */
> +#define T_COLD                 795     /* 71 deg C */
> +#define OMAP_ADC_START_VALUE   530
> +#define OMAP_ADC_END_VALUE     923
> +#define MAX_FREQ               2000000
> +#define MIN_FREQ               1000000
> +
> +/*
> + * omap_temp_sensor structure
> + * @hwmon_dev - device pointer
> + * @clock - Clock pointer
> + * @registers - Pointer to structure with register offsets and bitfields
> + * @sensor_mutex - Mutex for sysfs, irq and PM
> + * @irq - MPU Irq number for thermal alert
> + * @phy_base - Physical base of the temp I/O
> + * @clk_rate - Holds current clock rate
> + * @temp_sensor_ctrl - temp sensor control register value
> + * @bg_ctrl - bandgap ctrl register value
> + * @bg_counter - bandgap counter value
> + * @bg_threshold - bandgap threshold register value
> + * @temp_sensor_tshut_threshold - bandgap tshut register value
> + * @is_efuse_valid - Flag to determine if efuse is valid or not
> + * @clk_on - Manages the current clock state
> + */
> +struct omap_temp_sensor {
> +       struct device           *hwmon_dev;
> +       struct clk              *clock;
> +       struct omap_temp_sensor_registers *registers;
> +       struct mutex            sensor_mutex; /* Mutex for sysfs, irq and PM */
> +       unsigned int            irq;
> +       void __iomem            *phy_base;
> +       u32                     clk_rate;
> +       u32                     temp_sensor_ctrl;
> +       u32                     bg_ctrl;
> +       u32                     bg_counter;
> +       u32                     bg_threshold;
> +       u32                     temp_sensor_tshut_threshold;
> +       bool                    is_efuse_valid;
> +       bool                    clk_on;
> +};
> +
> +/*
> + * Temperature values in milli degree celsius
> + * ADC code values from 530 to 923
> + */
> +static int adc_to_temp[] = {
> 
This array should have an explicit size.

> 
> +       -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
> +       -37800, -37300, -36800, -36400, -36000, -35600, -35200, -34800,
> +       -34300, -33800, -33400, -33000, -32600, -32200, -31800, -31300,
> +       -30800, -30400, -30000, -29600, -29200, -28700, -28200, -27800,
> +       -27400, -27000, -26600, -26200, -25700, -25200, -24800, -24400,
> +       -24000, -23600, -23200, -22700, -22200, -21800, -21400, -21000,
> +       -20600, -20200, -19700, -19200, -18800, -18400, -18000, -17600,
> +       -17200, -16700, -16200, -15800, -15400, -15000, -14600, -14200,
> +       -13700, -13200, -12800, -12400, -12000, -11600, -11200, -10700,
> +       -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -6800,
> +       -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000,
> +       -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 1600,
> +       2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 6400,
> +       6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600, 11000,
> +       11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800,
> +       15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700,
> +       19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600,
> +       23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400,
> +       26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200,
> +       30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000,
> +       34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800,
> +       38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600,
> +       42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300,
> +       45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000,
> +       49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800,
> +       53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600,
> +       57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400,
> +       60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200,
> +       64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800,
> +       68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600,
> +       72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400,
> +       75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000,
> +       79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800,
> +       83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400,
> +       86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200,
> +       90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800,
> +       94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600,
> +       98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 101200,
> +       101600, 102000, 102400, 102800, 103200, 103600, 104000, 104400,
> +       104800, 105200, 105600, 106100, 106600, 107000, 107400, 107800,
> +       108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
> +       111400, 111800, 112200, 112600, 113000, 113400, 113800, 114200,
> +       114600, 115000, 115400, 115800, 116200, 116600, 117000, 117400,
> +       117800, 118200, 118600, 119000, 119400, 119800, 120200, 120600,
> +       121000, 121400, 121800, 122200, 122600, 123000
> +};
> +
> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
> +                                           *temp_sensor, u32 reg)
> +{
> +       return __raw_readl(temp_sensor->phy_base + reg);
> +}
> +
> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_sensor,
> +                                   u32 val, u32 reg)
> +{
> +       __raw_writel(val, (temp_sensor->phy_base + reg));
 
 		Unnecessary ( )
 
> +}
> +
> +static int adc_to_temp_conversion(int adc_val)
> +{
> +       return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
> +}
> +
> +static int temp_to_adc_conversion(long temp)
> +{
> +       int high, low, mid;
> +
> +       if (temp < adc_to_temp[0] ||
> +               temp > adc_to_temp[OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE])
> +               return -EINVAL;
> +
> +       high = OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;
> +       low = 0;
> +       mid = (high + low) / 2;
> +
> +       while (low < high) {
> +               if (temp < adc_to_temp[mid])
> +                       high = mid - 1;
> +               else
> +                       low = mid + 1;
> +               mid = (low + high) / 2;
> +       }
> +
> +       return OMAP_ADC_START_VALUE + low;
> +}
> +
> +static void omap_configure_temp_sensor_thresholds(struct omap_temp_sensor
> +                                                 *temp_sensor)
> +{
> +       u32 temp;
> +
> +       /* Configure the TALERT thresholds */
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       temp |= (T_HOT << __ffs(temp_sensor->registers->threshold_thot_mask)) |
> +               (T_COLD << __ffs(temp_sensor->registers->threshold_tcold_mask));
> +       omap_temp_sensor_writel(temp_sensor, temp,
> +               temp_sensor->registers->bgap_threshold);
> +
> +       /* Configure the TSHUT thresholds */
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->thsut_threshold);
> +       temp |= (TSHUT_HOT << __ffs(temp_sensor->registers->tshut_hot_mask))
> +           | (TSHUT_COLD << __ffs(temp_sensor->registers->tshut_hot_mask));
> +       omap_temp_sensor_writel(temp_sensor, temp,
> +                       temp_sensor->registers->thsut_threshold);
> +}
> +
> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
> +                                              *temp_sensor, u32 counter)
> +{
> +       u32 val;
> +
> +       val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_counter);
> +       val &= ~temp_sensor->registers->counter_mask;
> +       val |= counter << __ffs(temp_sensor->registers->counter_mask);
> +       omap_temp_sensor_writel(temp_sensor, val,
> +                       temp_sensor->registers->bgap_counter);
> +}
> +
> +static void omap_enable_continuous_mode(struct omap_temp_sensor *temp_sensor,
> +                                       bool enable)

The enable parameter is always 1 when called, and thus unnecessary.

> +{
> +       u32 val;
> +
> +       val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_mode_ctrl);
> +
> +       if (enable)
> +               val |= 1 << __ffs(temp_sensor->registers->mode_ctrl_mask);
> +       else
> +               val &= ~temp_sensor->registers->mode_ctrl_mask;
> +
> +       omap_temp_sensor_writel(temp_sensor, val,
> +                       temp_sensor->registers->bgap_mode_ctrl);
> +}
> +
> +/* Sysfs hook functions */
> +
> +static ssize_t show_temp_max(struct device *dev,
> +                       struct device_attribute *devattr, char *buf)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       int temp;
> +
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       temp = (temp & temp_sensor->registers->threshold_thot_mask)
> +                       >> __ffs(temp_sensor->registers->threshold_thot_mask);
> +
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid value\n");
> +               return -EDOM;

Please don't use EDOM, and drop the error message.

> +       }
> +
> +       temp = adc_to_temp_conversion(temp);
> +
> +       return snprintf(buf, 16, "%d\n", temp);
> +}
> +
> +static ssize_t set_temp_max(struct device *dev,
> +                           struct device_attribute *devattr,
> +                           const char *buf, size_t count)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       long                    val;
> +       u32                     reg_val, t_cold, t_hot, temp;
> +
> +       if (strict_strtol(buf, 10, &val)) {
> +               count = -EINVAL;
> +               goto out;

This will try to release the not-acquired lock.

> +       }
> +
> +       t_hot = temp_to_adc_conversion(val);

Bad error return check. Negative on error. Should be 
	if (t_hot < 0)
		return t_hot;

> +       if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALUE)) {

Unnecessary (( ))

> +               count = -EINVAL;
> +               goto out;

This will try to release the not-acquired lock.

> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       /* obtain the T cold value */
> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> +
> +       if (t_hot < t_cold) {
> +               count = -EINVAL;
> +               goto out;

Context specific limitations like this one are not a good idea, since it assumes an order of changing max
and max_hysteresis which is not necessarily guaranteed by the application making the change, nor is a
change order order well defined or even possible. Applications should not have to bother about this. 

> +       }
> +
> +       /* write the new t_hot value */
> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       reg_val &= ~temp_sensor->registers->threshold_thot_mask;
> +       reg_val |= (t_hot <<
> +                       __ffs(temp_sensor->registers->threshold_thot_mask));
> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> +                       temp_sensor->registers->bgap_threshold);
> +
> +       /* Read the current temperature */
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->temp_sensor_ctrl);
> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> +
> +       /*
> +        * If user sets the HIGH threshold(t_hot) greater than the current
> +        * temperature(temp) unmask the HOT interrupts
> +        */
> +       if (t_hot > temp) {
> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +               reg_val &= ~temp_sensor->registers->mask_cold_mask;
> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +       }
> +
> +       /*
> +        * If current temperature is in-between the hot and cold thresholds,
> +        * Enable both masks.
> +        */
> +       if (temp > t_cold && temp < t_hot) {
> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> +                               OMAP4460_BGAP_CTRL_OFFSET);

Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewhere ?

> +       }
> +       /*
> +        * else no need to do anything since HW will immediately compare
> +        * the new threshold and generate interrupt accordingly
> +        */
> +out:
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +       return count;
> +}
> +
> +static ssize_t show_temp_max_hyst(struct device *dev,
> +               struct device_attribute *devattr, char *buf)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       u32                     temp;
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);

This lock would only make sense if threshold_tcold_mask can change, and if that change
would be protected by the mutex. I don't see that to be the case, thus the lock is unnecessary.
Besides, the code in show_temp_max() is almost the same and does not use the lock.

> +       temp = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_threshold);
> +       temp = (temp & temp_sensor->registers->threshold_tcold_mask) >>
> +               __ffs(temp_sensor->registers->threshold_tcold_mask);
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid value\n");
> +               return -EDOM;

"Math argument out of domain of func" does not make sense.
Unless you don't know anything better, use EIO (I/O Error). Not very specific,
but at least not misleading.

Besides, the log message is unnecessary. The user is informed with -EIO, and the admin 
won't be able to do anything useful with "invalid value".

> +       }
> +
> +       temp = adc_to_temp_conversion(temp);
> +
> +       return snprintf(buf, 16, "%d\n", temp);
> +}
> +
> +static ssize_t set_temp_max_hyst(struct device *dev,
> +                                struct device_attribute *devattr,
> +                                const char *buf, size_t count)
> +{
> +       struct omap_temp_sensor         *temp_sensor = dev_get_drvdata(dev);
> +       u32                             reg_val, t_hot, t_cold, temp;
> +       long                            val;
> +
> +       if (strict_strtol(buf, 10, &val)) {
> +               count = -EINVAL;
> +               goto out;

This will try to release the not acquired lock.

> +       }
> +
> +       t_cold = temp_to_adc_conversion(val);

Bad error return check; same as above.

> +       if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END_VALUE) {
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       /* obtain the T HOT value */
> +       t_hot = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       t_hot = (t_hot & temp_sensor->registers->threshold_thot_mask) >>
> +                       __ffs(temp_sensor->registers->threshold_thot_mask);
> +
> +       if (t_cold > t_hot) {

Same concern as above. Change order is left to application which should not be bothered.

> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* write the new t_cold value */
> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       reg_val &= ~temp_sensor->registers->threshold_tcold_mask;
> +       reg_val |= t_cold <<
> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> +                       temp_sensor->registers->bgap_threshold);
> +
> +       /* Read the current temperature */
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->temp_sensor_ctrl);
> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> +
> +       /*
> +        * If user sets the LOW threshold(t_cold) lower than the current
> +        * temperature(temp) unmask the COLD interrupts
> +        */
> +       if (t_cold < temp) {
> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +               reg_val &= ~temp_sensor->registers->mask_hot_mask;
> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> +                       temp_sensor->registers->bgap_mask_ctrl);
> +       }
> +
> +       /*
> +        * If current temperature is in-between the hot and cold thresholds,
> +        * Enable both masks.
> +        */
> +       if (temp < t_hot && temp > t_cold) {
> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +       }
> +
> +       /*
> +        * else no need to do anything since HW will immediately compare
> +        * the new threshold and generate interrupt accordingly
> +        */

Would be nice if you could unify the interrupt enable code in a single function.

> +
> +out:
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +       return count;
> +}
> +
> +static ssize_t show_update_rate(struct device *dev,
> +                       struct device_attribute *devattr, char *buf)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       u32                     temp = 0, ret = 0;
> +
No need to initialize temp.
ret is u32, which doesn't seem to be a good type to use for negative values.

> +
> +       if (!temp_sensor->clk_rate) {
> +               dev_err(dev, "clk_rate is NULL\n");
> +               ret = -EDOM;

Same comment as above (this is not a math error). And you don't have to check clk_rate anyway,
since it is set in probe, and probe bails out if it is not set.

> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);

As with other show locks, this one would only make sense if counter_mask can change during runtime, 
and if that change would be protected by the mutex. This is not the case, thus the lock is unnecessary.

> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_counter);
> +       temp = (temp & temp_sensor->registers->counter_mask) >>
> +                       __ffs(temp_sensor->registers->counter_mask);
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +       temp = temp * 1000 / temp_sensor->clk_rate;
> +
> +out:
> +       if (!ret)
> +               return sprintf(buf, "%d\n", temp);
> +
> +       return ret;
> +}
> +
> +static ssize_t set_update_rate(struct device *dev,
> +                              struct device_attribute *devattr,
> +                              const char *buf, size_t count)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       u32                     reg_val;
> +       long                    val;
> +
> +       if (strict_strtol(buf, 10, &val)) {
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       val *= temp_sensor->clk_rate / 1000;
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_counter);
> +
> +       reg_val &= ~temp_sensor->registers->counter_mask;
> +       reg_val |= val;

Sure you want to accept any value (including negative ones) here ?
val is not shifted, and not masked against counter_mask, meaning it can write 
all bits of the register. That doesn't sound right.

It would make sense to call omap_configure_temp_sensor_counter() instead of duplicating
the set functionality.

> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> +                       temp_sensor->registers->bgap_counter);
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +out:
> +       return count;
> +}
> +
> +static int omap_temp_sensor_read_temp(struct device *dev,
> +                                     struct device_attribute *devattr,
> +                                     char *buf)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +       int                     temp, ret = 0;
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);

Unless bgap_dtemp_mask can change during runtime, and that change is protected by the mutex,
this lock is unnecessary.

> +       temp = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->temp_sensor_ctrl);
> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> +
> +       /* look up for temperature in the table and return the temperature */
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid adc code reported %d", temp);
> +               ret = -EDOM;

Another wrong use of EDOM, and another value-free error message.

> +               goto out;
> +       }
> +
> +       temp = adc_to_temp[temp - OMAP_ADC_START_VALUE];
> +
> +out:
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +       if (!ret)
> +               return sprintf(buf, "%d\n", temp);
> +
> +       return ret;
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_temp,
> +                         NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +                         set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_max_hyst,
> +                         set_temp_max_hyst, 0);
> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update_rate,
> +                         set_update_rate, 0);
> +

ABI is update_interval. Please use it.

> +static struct attribute *omap_temp_sensor_attributes[] = {
> +       &sensor_dev_attr_temp1_input.dev_attr.attr,
> +       &sensor_dev_attr_temp1_max.dev_attr.attr,
> +       &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +       &sensor_dev_attr_update_rate.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group omap_temp_sensor_group = {
> +       .attrs = omap_temp_sensor_attributes,
> +};
> +
> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_sensor)
> +{
> +       u32 ret = 0;
> +
> +       if (temp_sensor->clk_on) {
> +               dev_err(temp_sensor->hwmon_dev, "clock already on\n");
> +               goto out;
> +       }
> +
> +       ret = pm_runtime_get_sync(temp_sensor->hwmon_dev);
> +       if (ret < 0) {
> +               dev_err(temp_sensor->hwmon_dev, "get sync failed\n");
> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       temp_sensor->clk_on = 1;
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +

Completely unnecessary lock.

> +out:
> +       return ret;
> +}
> +
> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_sensor)

Return code is not used anywhere, why bother providing one ?

> +{
> +       u32 ret = 0;
> +
> +       if (!temp_sensor->clk_on) {
> +               dev_err(temp_sensor->hwmon_dev, "clock already off\n");
> +               goto out;

... and since you ignore the error anyway, why log it ?

> +       }
> +
> +       /* Gate the clock */
> +       ret = pm_runtime_put_sync(temp_sensor->hwmon_dev);
> +       if (ret < 0) {
> +               dev_err(temp_sensor->hwmon_dev, "put sync failed\n");
> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       temp_sensor->clk_on = 0;
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +

Completely unnecessary lock.

> +out:
> +       return ret;
> +}
> +
> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
> +{
> +       struct omap_temp_sensor         *temp_sensor;
> +       int                             t_hot, t_cold, temp;
> +
> +       temp_sensor = data;
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +
> +       /* Read the status of t_hot */
> +       t_hot = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_status)
> +                       & temp_sensor->registers->status_hot_mask;
> +
> +       /* Read the status of t_cold */
> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_status)
> +                       & temp_sensor->registers->status_cold_mask;
> +
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_mask_ctrl);
> +       /*
> +        * One TALERT interrupt: Two sources
> +        * If the interrupt is due to t_hot then mask t_hot and
> +        * and unmask t_cold else mask t_cold and unmask t_hot
> +        */
> +       if (t_hot) {
> +               temp &= ~temp_sensor->registers->mask_hot_mask;
> +               temp |= temp_sensor->registers->mask_cold_mask;
> +       } else if (t_cold) {
> +               temp &= ~temp_sensor->registers->mask_cold_mask;
> +               temp |= temp_sensor->registers->mask_hot_mask;
> +       }
> +
> +       omap_temp_sensor_writel(temp_sensor, temp,
> +               temp_sensor->registers->bgap_mask_ctrl);
> +
> +       /* kobject_uvent to user space telling thermal threshold crossed */
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHANGE);
> +
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)
> +{
> +       struct omap_temp_sensor_pdata   *pdata  = pdev->dev.platform_data;
> +       struct omap_temp_sensor         *temp_sensor;
> +       struct resource                 *mem;
> +       int                             ret = 0;
> +       int                             val, clk_rate;
> +       u32                             max_freq, min_freq;
> +
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "platform data missing\n");
> +               return -EINVAL;
> +       }
> +
> +       temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
> +       if (!temp_sensor)
> +               return -ENOMEM;
> +

You have error messages all over the place, Why not here ?

> +       mutex_init(&temp_sensor->sensor_mutex);
> +
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mem) {
> +               dev_err(&pdev->dev, "no mem resource\n");
> +               ret = -ENOMEM;
> +               goto plat_res_err;
> +       }
> +

If you try to get the resource before allocating the memory, you don't have to release 
the memory if the platform resource is missing.

> +       temp_sensor->irq = platform_get_irq_byname(pdev, "thermal_alert");
> +       if (temp_sensor->irq < 0) {
> +               dev_err(&pdev->dev, "get_irq_byname failed\n");
> +               ret = temp_sensor->irq;
> +               goto plat_res_err;
> +       }
> +
> +       temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> +       temp_sensor->clock = NULL;
> +       temp_sensor->registers = pdata->registers;
> +       temp_sensor->hwmon_dev = &pdev->dev;
> +
> +       if (pdata->max_freq && pdata->min_freq) {
> +               max_freq = pdata->max_freq;
> +               min_freq = pdata->min_freq;
> +       } else {
> +               max_freq = MAX_FREQ;
> +               min_freq = MIN_FREQ;
> +       }
> +
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_irq_safe(&pdev->dev);
> +
> +       /*
> +        * check if the efuse has a non-zero value if not
> +        * it is an untrimmed sample and the temperatures
> +        * may not be accurate
> +        */
> +
> +       if (omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_efuse)) {
> +               temp_sensor->is_efuse_valid = 1;

is_efuse_valid is not used anywhere. Might as well drop it.

> +               dev_dbg(temp_sensor->hwmon_dev,
> +                       "Invalid EFUSE, Non-trimmed BGAP, Temp not accurate\n");

dev_info might be better here.

> +       }
> +
> +       dev_set_drvdata(&pdev->dev, temp_sensor);
> +       temp_sensor->clock = clk_get(temp_sensor->hwmon_dev, "fck");
> +       if (IS_ERR(temp_sensor->clock)) {
> +               ret = PTR_ERR(temp_sensor->clock);
> +               dev_err(temp_sensor->hwmon_dev,
> +                       "unable to get fclk: %d\n", ret);
> +               goto plat_res_err;
> +       }
> +
> +       ret = omap_temp_sensor_clk_enable(temp_sensor);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Cannot enable temp sensor\n");

omap_temp_sensor_clk_enable() already generates error messages.

> +               goto clken_err;
> +       }
> +
> +       clk_rate = clk_round_rate(temp_sensor->clock, max_freq);
> +       if (clk_rate < min_freq || clk_rate = 0xffffffff) {
> +               dev_err(&pdev->dev, "Error round rate\n");
> +               ret = -EDOM;

EDOM is wrong. Please use ENODEV.

The error log doesn't really provide anything useful to the administrator.
Either add parameters, or drop it.

> +               goto clken_err;
> +       }
> +
> +       ret = clk_set_rate(temp_sensor->clock, clk_rate);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Cannot set clock rate\n");
> +               goto clken_err;
> +       }
> +
> +       temp_sensor->clk_rate = clk_rate;
> +       omap_enable_continuous_mode(temp_sensor, 1);
> +       omap_configure_temp_sensor_thresholds(temp_sensor);
> +       /* 1 ms */
> +       omap_configure_temp_sensor_counter(temp_sensor, 1);

If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1 is not 1ms.
1ms would be temp_sensor->clk_rate / 1000.

> +
> +       /* Wait till the first conversion is done wait for at least 1ms */
> +       usleep_range(1000, 2000);
> +
> +       /* Read the temperature once due to hw issue*/
> +       omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->temp_sensor_ctrl);
> +
> +       /* Set 2 seconds time as default counter */
> +       omap_configure_temp_sensor_counter(temp_sensor,
> +                                               temp_sensor->clk_rate * 2);
> +
> +       temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
> +       if (IS_ERR(temp_sensor->hwmon_dev)) {
> +               dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> +               ret = PTR_ERR(temp_sensor->hwmon_dev);
> +               goto hwmon_reg_err;
> +       }
> +
> +       ret = sysfs_create_group(&pdev->dev.kobj,
> +                              &omap_temp_sensor_group);

one line is sufficient here.

> +       if (ret) {
> +               dev_err(&pdev->dev, "could not create sysfs files\n");
> +               goto sysfs_create_err;
> +       }
> +
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> +

No other hwmon driver needs this. Doesn't the sysfs code take care of this ? 

> +       ret = request_threaded_irq(temp_sensor->irq, NULL,
> +               omap_talert_irq_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +                       "temp_sensor", temp_sensor);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Request threaded irq failed.\n");
> +               goto req_irq_err;
> +       }
> +
> +       /* unmask the T_COLD and unmask T_HOT at init */
> +       val = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_mask_ctrl);
> +       val |= temp_sensor->registers->mask_cold_mask
> +               | temp_sensor->registers->mask_hot_mask;
> +
> +       omap_temp_sensor_writel(temp_sensor, val,
> +               temp_sensor->registers->bgap_mask_ctrl);
> +
This is racy. From Documentation/hwmon/submitting-patches:

* Make sure there are no race conditions in the probe function. Specifically,
  completely initialize your chip first, then create sysfs entries and register
  with the hwmon subsystem.

> +       return 0;
> +
> +req_irq_err:
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);

Same as before; why is this needed here but not in any other hwmon driver ? 

> +       sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +                               &omap_temp_sensor_group);
> +sysfs_create_err:
> +       hwmon_device_unregister(&pdev->dev);
> +hwmon_reg_err:
> +       omap_temp_sensor_clk_disable(temp_sensor);
> +clken_err:
> +       clk_put(temp_sensor->clock);
> +plat_res_err:
> +       dev_set_drvdata(&pdev->dev, NULL);
> +       mutex_destroy(&temp_sensor->sensor_mutex);
> +       kfree(temp_sensor);
> +       return ret;
> +}
> +
> +static int __devexit omap_temp_sensor_remove(struct platform_device *pdev)
> +{
> +       struct omap_temp_sensor *temp_sensor = platform_get_drvdata(pdev);
> +
> +       hwmon_device_unregister(&pdev->dev);
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);

... and again.

> +       sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +                       &omap_temp_sensor_group);
> +       omap_temp_sensor_clk_disable(temp_sensor);
> +       free_irq(temp_sensor->irq, temp_sensor);
> +       clk_put(temp_sensor->clock);
> +       dev_set_drvdata(&pdev->dev, NULL);
> +       mutex_destroy(&temp_sensor->sensor_mutex);
> +       kfree(temp_sensor);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor *temp_sensor)
> +{
> +       temp_sensor->temp_sensor_ctrl = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->temp_sensor_ctrl);
> +       temp_sensor->bg_ctrl = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_mask_ctrl);
> +       temp_sensor->bg_counter = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_counter);
> +       temp_sensor->bg_threshold = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_threshold);
> +       temp_sensor->temp_sensor_tshut_threshold > +               omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->thsut_threshold);
> +}
> +
> +static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor *temp_sensor)
> +{
> +       omap_temp_sensor_writel(temp_sensor,
> +                               temp_sensor->temp_sensor_ctrl,
> +                               temp_sensor->registers->temp_sensor_ctrl);
> +       omap_temp_sensor_writel(temp_sensor,
> +                               temp_sensor->bg_ctrl,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +       omap_temp_sensor_writel(temp_sensor,
> +                               temp_sensor->bg_counter,
> +                               temp_sensor->registers->bgap_counter);
> +       omap_temp_sensor_writel(temp_sensor,
> +                               temp_sensor->bg_threshold,
> +                               temp_sensor->registers->bgap_threshold);
> +       omap_temp_sensor_writel(temp_sensor,
> +                               temp_sensor->temp_sensor_tshut_threshold,
> +                               temp_sensor->registers->thsut_threshold);
> +}
> +
> +static int omap_temp_sensor_suspend(struct device *dev)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +
> +       omap_temp_sensor_save_ctxt(temp_sensor);
> +
> +       return 0;
> +}
> +
> +static int omap_temp_sensor_resume(struct device *dev)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +
> +       omap_temp_sensor_restore_ctxt(temp_sensor);
> +
> +       return 0;
> +}
> +
> +static int omap_temp_sensor_runtime_suspend(struct device *dev)
> +{
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +
> +       omap_temp_sensor_save_ctxt(temp_sensor);
> +
> +       return 0;
> +}
> +
> +static int omap_temp_sensor_runtime_resume(struct device *dev)
> +{
> +       static int context_loss_count;
> +       int temp;
> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +
> +       temp = omap_device_get_context_loss_count(to_platform_device(dev));
> +
> +       if (temp != context_loss_count && context_loss_count != 0)
> +               omap_temp_sensor_restore_ctxt(temp_sensor);
> +
> +       context_loss_count = temp;
> +
> +       return 0;
> +}
> +
> +static int omap_temp_sensor_idle(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(omap_temp_sensor_suspend,
> +                       omap_temp_sensor_resume)
> +       SET_RUNTIME_PM_OPS(omap_temp_sensor_runtime_suspend,
> +                       omap_temp_sensor_runtime_resume, omap_temp_sensor_idle)
> +};
> +
> +#define DEV_PM_OPS     (&omap_temp_sensor_dev_pm_ops)
> +#else
> +#define DEV_PM_OPS     NULL
> +#endif
> +
> +static struct platform_driver omap_temp_sensor_driver = {
> +       .probe = omap_temp_sensor_probe,
> +       .remove = omap_temp_sensor_remove,
> +       .driver = {
> +                       .name = "omap_temp_sensor",
> +                       .pm = DEV_PM_OPS,
> +                 },
> +};
> +
> +int __init omap_temp_sensor_init(void)
> +{
> +       return platform_driver_register(&omap_temp_sensor_driver);
> +}
> +module_init(omap_temp_sensor_init);
> +
> +static void __exit omap_temp_sensor_exit(void)
> +{
> +       platform_driver_unregister(&omap_temp_sensor_driver);
> +}
> +module_exit(omap_temp_sensor_exit);
> +
> +MODULE_DESCRIPTION("OMAP446X temperature sensor Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
> --
> 1.7.0.4
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
