From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 10 Aug 2011 16:47:54 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E894BB3C@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-7-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1312979122-5896-7-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Cc: "vishwanath.bs@ti.com" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "rnayak@ti.com" <rnayak@ti.com>

Hi,

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Keerthy
> Sent: Wednesday, August 10, 2011 5:55 PM
> To: lm-sensors@lm-sensors.org
> Cc: vishwanath.bs@ti.com; linux-omap@vger.kernel.org; b-cousson@ti.com;
> rnayak@ti.com
> Subject: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor
> driver
>
> On chip temperature sensor driver. The driver monitors the temperature of
> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> the temperature crosses user defined thresholds via kobject_uevent interface.
> The user is allowed to configure the temperature thresholds vis sysfs nodes
> exposed using hwmon interface.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/hwmon/Kconfig            |   11 +
>  drivers/hwmon/Makefile           |    1 +
>  drivers/hwmon/omap_temp_sensor.c |  950 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 962 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/omap_temp_sensor.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5f888f7..9c9cd8b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>         This driver can also be built as a module.  If so, the module
>         will be called f71805f.
>
> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
> +     bool "OMAP on-die temperature sensor hwmon driver"
> +     depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
> +     help
> +       If you say yes here you get support for hardware
> +       monitoring features of the OMAP on die temperature
> +       sensor.
> +
> +       Continuous conversion programmable delay
> +       mode is used for temperature conversion.
> +
>  config SENSORS_F71882FG
>       tristate "Fintek F71882FG and compatibles"
>       help
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 28061cf..d0f89f5 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639)       += max6639.o
>  obj-$(CONFIG_SENSORS_MAX6642)        += max6642.o
>  obj-$(CONFIG_SENSORS_MAX6650)        += max6650.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR)  += omap_temp_sensor.o
>  obj-$(CONFIG_SENSORS_PC87360)        += pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)        += pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)        += pcf8591.o
> diff --git a/drivers/hwmon/omap_temp_sensor.c
> b/drivers/hwmon/omap_temp_sensor.c
> new file mode 100644
> index 0000000..15e2559
> --- /dev/null
> +++ b/drivers/hwmon/omap_temp_sensor.c
> @@ -0,0 +1,950 @@
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
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <plat/omap_device.h>
> +#include <linux/module.h>
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
> +#include <plat/common.h>
> +#include <plat/temperature_sensor.h>
> +#include <mach/ctrl_module_core_44xx.h>
> +#include <mach/gpio.h>
> +
> +#define TSHUT_THRESHOLD_HOT  122000  /* 122 deg C */
> +#define TSHUT_THRESHOLD_COLD 100000  /* 100 deg C */
> +#define BGAP_THRESHOLD_T_HOT 73000   /* 73 deg C */
> +#define BGAP_THRESHOLD_T_COLD        71000   /* 71 deg C */
> +#define OMAP_ADC_START_VALUE 530
> +#define OMAP_ADC_END_VALUE   923
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
> +     struct device           *hwmon_dev;
> +     struct clk              *clock;
> +     struct omap_temp_sensor_registers *registers;
> +     struct mutex            sensor_mutex; /* Mutex for sysfs, irq and PM */
> +     unsigned int            irq;
> +     void __iomem            *phy_base;
> +     u32                     clk_rate;
> +     u32                     temp_sensor_ctrl;
> +     u32                     bg_ctrl;
> +     u32                     bg_counter;
> +     u32                     bg_threshold;
> +     u32                     temp_sensor_tshut_threshold;
> +     bool                    is_efuse_valid;
> +     bool                    clk_on;
> +};
> +
> +/*
> + * Temperature values in milli degree celsius
> + * ADC code values from 530 to 923
> + */
> +static int adc_to_temp[] = {
> +     -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
> +     -37800, -37300, -36800, -36400, -36000, -35600, -35200, -34800,
> +     -34300, -33800, -33400, -33000, -32600, -32200, -31800, -31300,
> +     -30800, -30400, -30000, -29600, -29200, -28700, -28200, -27800,
> +     -27400, -27000, -26600, -26200, -25700, -25200, -24800, -24400,
> +     -24000, -23600, -23200, -22700, -22200, -21800, -21400, -21000,
> +     -20600, -20200, -19700, -19200, -18800, -18400, -18000, -17600,
> +     -17200, -16700, -16200, -15800, -15400, -15000, -14600, -14200,
> +     -13700, -13200, -12800, -12400, -12000, -11600, -11200, -10700,
> +     -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -6800,
> +     -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000,
> +     -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 1600,
> +     2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 6400,
> +     6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600, 11000,
> +     11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800,
> +     15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700,
> +     19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600,
> +     23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400,
> +     26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200,
> +     30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000,
> +     34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800,
> +     38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600,
> +     42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300,
> +     45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000,
> +     49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800,
> +     53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600,
> +     57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400,
> +     60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200,
> +     64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800,
> +     68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600,
> +     72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400,
> +     75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000,
> +     79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800,
> +     83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400,
> +     86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200,
> +     90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800,
> +     94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600,
> +     98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 101200,
> +     101600, 102000, 102400, 102800, 103200, 103600, 104000, 104400,
> +     104800, 105200, 105600, 106100, 106600, 107000, 107400, 107800,
> +     108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
> +     111400, 111800, 112200, 112600, 113000, 113400, 113800, 114200,
> +     114600, 115000, 115400, 115800, 116200, 116600, 117000, 117400,
> +     117800, 118200, 118600, 119000, 119400, 119800, 120200, 120600,
> +     121000, 121400, 121800, 122200, 122600, 123000
> +};
> +
> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
> +                                         *temp_sensor, u32 reg)
> +{
> +     return __raw_readl(temp_sensor->phy_base + reg);
> +}
> +
> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_sensor,
> +                                 u32 val, u32 reg)
> +{
> +     __raw_writel(val, (temp_sensor->phy_base + reg));
> +}
> +
> +static int adc_to_temp_conversion(int adc_val)
> +{
> +     return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
> +}
> +
> +static int temp_to_adc_conversion(long temp)
> +{
> +     int i;
> +
> +     for (i = 0; i <= OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE; i++)
> +             if (temp < adc_to_temp[i])
> +                     return OMAP_ADC_START_VALUE + i - 1;
> +
> +     return -EINVAL;
> +}
> +
> +static void omap_configure_temp_sensor_thresholds(struct omap_temp_sensor
> +                                               *temp_sensor)
> +{
> +     u32 temp, t_hot, t_cold, tshut_hot, tshut_cold;
> +
> +     t_hot = temp_to_adc_conversion(BGAP_THRESHOLD_T_HOT);
> +     t_cold = temp_to_adc_conversion(BGAP_THRESHOLD_T_COLD);
> +
> +     /* Configure the TALERT thresholds */
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     temp |= (t_hot << __ffs(temp_sensor->registers->threshold_thot_mask)) |
> +             (t_cold << __ffs(temp_sensor->registers->threshold_tcold_mask));
> +     omap_temp_sensor_writel(temp_sensor, temp,
> +             temp_sensor->registers->bgap_threshold);
> +
> +     tshut_hot = temp_to_adc_conversion(TSHUT_THRESHOLD_HOT);
> +     tshut_cold = temp_to_adc_conversion(TSHUT_THRESHOLD_COLD);
> +
> +     /* Configure the TSHUT thresholds */
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->thsut_threshold);
> +     temp |= (tshut_hot << __ffs(temp_sensor->registers->tshut_hot_mask))
> +         | (tshut_cold << __ffs(temp_sensor->registers->tshut_hot_mask));
> +     omap_temp_sensor_writel(temp_sensor, temp,
> +                     temp_sensor->registers->thsut_threshold);
> +}
> +
> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
> +                                            *temp_sensor, u32 counter)
> +{
> +     u32 val;
> +
> +     val = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_counter);
> +     val &= ~(temp_sensor->registers->counter_mask);
> +     val |= (counter << __ffs(temp_sensor->registers->counter_mask));
> +     omap_temp_sensor_writel(temp_sensor, val,
> +                     temp_sensor->registers->bgap_counter);
> +}
> +
> +static void omap_enable_continuous_mode(struct omap_temp_sensor *temp_sensor,
> +                                     bool enable)
> +{
> +     u32 val;
> +
> +     val = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_mode_ctrl);
> +
> +     if (enable)
> +             val |= (1 << __ffs(temp_sensor->registers->mode_ctrl_mask));
> +     else
> +             val &= ~(temp_sensor->registers->mode_ctrl_mask);
> +
> +     omap_temp_sensor_writel(temp_sensor, val,
> +                     temp_sensor->registers->bgap_mode_ctrl);
> +}
> +
> +/* Sysfs hook functions */
> +
> +static ssize_t show_temp_max(struct device *dev,
> +                     struct device_attribute *devattr, char *buf)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     int temp;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     temp = (temp & temp_sensor->registers->threshold_thot_mask)
> +                     >> __ffs(temp_sensor->registers->threshold_thot_mask);
> +
> +     if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +             dev_err(dev, "invalid value\n");
> +             goto out;
> +     }
> +     temp = adc_to_temp_conversion(temp);
> +
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +     return snprintf(buf, 16, "%d\n", temp);

Even if it is invalid value, you are printing it.
May be you would have to do unlocking and returning -EINVAL inside the 'if' check.

Moreover, you are just doing a read.
So, do you really need a mutex_lock in this function.. ?

> +}
> +
> +static ssize_t set_temp_max(struct device *dev,
> +                         struct device_attribute *devattr,
> +                         const char *buf, size_t count)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     long                    val;
> +     u32                     reg_val, t_cold, t_hot, temp;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     if (strict_strtol(buf, 10, &val)) {
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     t_hot = temp_to_adc_conversion(val);
> +     if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALUE)) {
> +             dev_err(dev, "invalid range\n");
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     /* obtain the T cold value */
> +     t_cold = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> +                     __ffs(temp_sensor->registers->threshold_tcold_mask);
> +
> +     if (t_hot < t_cold) {
> +             dev_err(dev, "Error! T_HOT value lesser than T_COLD\n");
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     /* write the new t_hot value */
> +     reg_val = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     reg_val &= ~(temp_sensor->registers->threshold_thot_mask);
> +     reg_val |= (t_hot <<
> +                     __ffs(temp_sensor->registers->threshold_thot_mask));
> +     omap_temp_sensor_writel(temp_sensor, reg_val,
> +                     temp_sensor->registers->bgap_threshold);
> +
> +     /* Read the current temperature */
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->temp_sensor_ctrl);
> +     temp &= (temp_sensor->registers->bgap_dtemp_mask);
> +
> +     /*
> +      * If user sets the HIGH threshold(t_hot) greater than the current
> +      * temperature(temp) unmask the HOT interrupts
> +      */
> +     if (t_hot > temp) {
> +             reg_val = omap_temp_sensor_readl(temp_sensor,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +             reg_val &= ~(temp_sensor->registers->mask_cold_mask);
> +             reg_val |= temp_sensor->registers->mask_hot_mask;
> +             omap_temp_sensor_writel(temp_sensor, reg_val,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +     }
> +
> +     /*
> +      * If current temperature is in-between the hot and cold thresholds,
> +      * Enable both masks.
> +      */
> +     if (temp > t_cold && temp < t_hot) {
> +             reg_val = omap_temp_sensor_readl(temp_sensor,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +             reg_val |= temp_sensor->registers->mask_cold_mask;
> +             reg_val |= temp_sensor->registers->mask_hot_mask;
> +             omap_temp_sensor_writel(temp_sensor, reg_val,
> +                             OMAP4460_BGAP_CTRL_OFFSET);
> +     }
> +     /*
> +      * else no need to do anything since HW will immediately compare
> +      * the new threshold and generate interrupt accordingly
> +      */
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +     return count;
> +}
> +
> +static ssize_t show_temp_max_hyst(struct device *dev,
> +             struct device_attribute *devattr, char *buf)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     u32                     temp;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +             temp_sensor->registers->bgap_threshold);
> +     temp = (temp & temp_sensor->registers->threshold_tcold_mask) >>
> +             __ffs(temp_sensor->registers->threshold_tcold_mask);
> +
> +     if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +             dev_err(dev, "invalid value\n");
> +             goto out;

Same case here..
You can do ret = -EINVAL here..

> +     }
> +
> +     temp = adc_to_temp_conversion(temp);

...subsequently,
ret = snprintf(buf, 16, "%d\n", temp);

> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +     return snprintf(buf, 16, "%d\n", temp);

Return ret here..

> +}
> +
> +static ssize_t set_temp_max_hyst(struct device *dev,
> +                              struct device_attribute *devattr,
> +                              const char *buf, size_t count)
> +{
> +     struct omap_temp_sensor         *temp_sensor = dev_get_drvdata(dev);
> +     u32                             reg_val, t_hot, t_cold, temp;
> +     long                            val;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     if (strict_strtol(buf, 10, &val)) {
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     t_cold = temp_to_adc_conversion(val);
> +     if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END_VALUE) {
> +             dev_err(dev, "invalid range");
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     /* obtain the T HOT value */
> +     t_hot = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     t_hot = (t_hot & temp_sensor->registers->threshold_thot_mask) >>
> +                     __ffs(temp_sensor->registers->threshold_thot_mask);
> +
> +     if (t_cold > t_hot) {
> +             dev_err(dev, "Error! T_COLD value greater than T_HOT\n");
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     /* write the new t_cold value */
> +     reg_val = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_threshold);
> +     reg_val &= ~(temp_sensor->registers->threshold_tcold_mask);
> +     reg_val |= (t_cold <<
> +                     __ffs(temp_sensor->registers->threshold_tcold_mask));
> +     omap_temp_sensor_writel(temp_sensor, reg_val,
> +                     temp_sensor->registers->bgap_threshold);
> +
> +     /* Read the current temperature */
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +             temp_sensor->registers->temp_sensor_ctrl);
> +     temp &= (temp_sensor->registers->bgap_dtemp_mask);
> +
> +     /*
> +      * If user sets the LOW threshold(t_cold) lower than the current
> +      * temperature(temp) unmask the COLD interrupts
> +      */
> +     if (t_cold < temp) {
> +             reg_val = omap_temp_sensor_readl(temp_sensor,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +             reg_val &= ~(temp_sensor->registers->mask_hot_mask);
> +             reg_val |= temp_sensor->registers->mask_cold_mask;
> +             omap_temp_sensor_writel(temp_sensor, reg_val,
> +                     temp_sensor->registers->bgap_mask_ctrl);
> +     }
> +
> +     /*
> +      * If current temperature is in-between the hot and cold thresholds,
> +      * Enable both masks.
> +      */
> +     if (temp < t_hot && temp > t_cold) {
> +             reg_val = omap_temp_sensor_readl(temp_sensor,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +             reg_val |= temp_sensor->registers->mask_cold_mask;
> +             reg_val |= temp_sensor->registers->mask_hot_mask;
> +             omap_temp_sensor_writel(temp_sensor, reg_val,
> +                             temp_sensor->registers->bgap_mask_ctrl);
> +     }
> +
> +     /*
> +      * else no need to do anything since HW will immediately compare
> +      * the new threshold and generate interrupt accordingly
> +      */
> +
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +     return count;
> +}
> +
> +static ssize_t show_update_rate(struct device *dev,
> +                     struct device_attribute *devattr, char *buf)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     u32                     temp = 0, ret = 0;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     if (!temp_sensor->clk_rate) {
> +             dev_err(dev, "clk_rate is NULL\n");
> +             ret = -EINVAL;
> +             goto out;
> +     }
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_counter);
> +     temp = (temp & temp_sensor->registers->counter_mask) >>
> +                     __ffs(temp_sensor->registers->counter_mask);
> +     temp = temp * 1000 / (temp_sensor->clk_rate);
> +
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +     if (!ret)
> +             return sprintf(buf, "%d\n", temp);
> +     else

The 'else' is not necessary..

> +             return ret;
> +}
> +
> +static ssize_t set_update_rate(struct device *dev,
> +                            struct device_attribute *devattr,
> +                            const char *buf, size_t count)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     u32                     reg_val;
> +     long                    val;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     if (strict_strtol(buf, 10, &val)) {
> +             count = -EINVAL;
> +             goto out;
> +     }
> +
> +     val *= temp_sensor->clk_rate / 1000;
> +     reg_val = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_counter);
> +
> +     reg_val &= ~(temp_sensor->registers->counter_mask);
> +     reg_val |= val;
> +     omap_temp_sensor_writel(temp_sensor, reg_val,
> +                     temp_sensor->registers->bgap_counter);
> +
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +     return count;
> +}
> +
> +static int omap_temp_sensor_read_temp(struct device *dev,
> +                                   struct device_attribute *devattr,
> +                                   char *buf)
> +{
> +     struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> +     int                     temp, ret = 0;
> +
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +             temp_sensor->registers->temp_sensor_ctrl);
> +     temp &= temp_sensor->registers->bgap_dtemp_mask;
> +
> +     if (!temp_sensor->is_efuse_valid)
> +             dev_err(dev, "Invalid EFUSE, Non-trimmed BGAP, Temp not
> accurate\n");
> +
> +     /* look up for temperature in the table and return the temperature */
> +     if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +             dev_err(dev, "invalid adc code reported %d", temp);
> +             ret = -EINVAL;
> +             goto out;
> +     }
> +
> +     temp = adc_to_temp[temp - OMAP_ADC_START_VALUE];
> +
> +out:
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +     if (!ret)
> +             return sprintf(buf, "%d\n", temp);
> +     else

Same here..

> +             return ret;
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_temp,
> +                       NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +                       set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> show_temp_max_hyst,
> +                       set_temp_max_hyst, 0);
> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update_rate,
> +                       set_update_rate, 0);
> +
> +static struct attribute *omap_temp_sensor_attributes[] = {
> +     &sensor_dev_attr_temp1_input.dev_attr.attr,
> +     &sensor_dev_attr_temp1_max.dev_attr.attr,
> +     &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +     &sensor_dev_attr_update_rate.dev_attr.attr,
> +     NULL
> +};
> +
> +static const struct attribute_group omap_temp_sensor_group = {
> +     .attrs = omap_temp_sensor_attributes,
> +};
> +
> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_sensor)
> +{
> +     u32 ret = 0, temp;
> +
> +     if (temp_sensor->clk_on) {
> +             dev_err(temp_sensor->hwmon_dev, "clock already on\n");
> +             goto out;
> +     }
> +
> +     ret = pm_runtime_get_sync(temp_sensor->hwmon_dev);
> +     if (ret < 0) {
> +             dev_err(temp_sensor->hwmon_dev, "get sync failed\n");
> +             ret = -EINVAL;

Please do not mask the return value.
Let it be whatever returned by the get_sync.
Anyway, you are returning 'ret' in the end...

> +             goto out;
> +     }
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->temp_sensor_ctrl);
> +     temp &= ~(temp_sensor->registers->bgap_tempsoff_mask);
> +     /* BGAP_TEMPSOFF should be reset to 0 */
> +     omap_temp_sensor_writel(temp_sensor, temp,
> +                             temp_sensor->registers->temp_sensor_ctrl);
> +     temp_sensor->clk_on = 1;
> +out:
> +     return ret;
> +}
> +
> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_sensor)
> +{
> +     u32 temp, ret = 0;
> +     unsigned long timeout;
> +
> +     if (!temp_sensor->clk_on) {
> +             dev_err(temp_sensor->hwmon_dev, "clock already off\n");
> +             goto out;
> +     }
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->temp_sensor_ctrl);
> +     temp |= temp_sensor->registers->bgap_tempsoff_mask;
> +
> +     /* BGAP_TEMPSOFF should be set to 1 before gating clock */
> +     omap_temp_sensor_writel(temp_sensor, temp,
> +                     temp_sensor->registers->temp_sensor_ctrl);
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_status);
> +     timeout = jiffies + msecs_to_jiffies(5);
> +
> +     /* wait till the clean stop bit is set or till the timeout exppires */

s/expires/expires

> +     while (!(temp | temp_sensor->registers->status_clean_stop_mask) &&
> +             !(time_after(jiffies, timeout))) {
> +             temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_status);
> +             usleep_range(500, 2000);
> +     }
> +
> +     if (time_after(jiffies, timeout))
> +             dev_err(temp_sensor->hwmon_dev, "Clean stop bit not set\n");
> +     /* Gate the clock */
> +     ret = pm_runtime_put_sync(temp_sensor->hwmon_dev);
> +     if (ret < 0) {
> +             dev_err(temp_sensor->hwmon_dev, "put sync failed\n");
> +             ret = -EINVAL;

Same case as get_sync. Don't mask the return value.

> +             goto out;
> +     }
> +     temp_sensor->clk_on = 0;
> +out:
> +     return ret;
> +}
> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
> +{
> +     struct omap_temp_sensor         *temp_sensor;
> +     int                             t_hot, t_cold, temp;
> +
> +     temp_sensor = data;
> +     mutex_lock(&temp_sensor->sensor_mutex);
> +
> +     /* Read the status of t_hot */
> +     t_hot = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_status)
> +                     & temp_sensor->registers->status_hot_mask;
> +
> +     /* Read the status of t_cold */
> +     t_cold = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_status)
> +                     & temp_sensor->registers->status_cold_mask;
> +
> +     temp = omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_mask_ctrl);
> +     /*
> +      * One TALERT interrupt: Two sources
> +      * If the interrupt is due to t_hot then mask t_hot and
> +      * and unmask t_cold else mask t_cold and unmask t_hot
> +      */
> +     if (t_hot) {
> +             temp &= ~(temp_sensor->registers->mask_hot_mask);
> +             temp |= temp_sensor->registers->mask_cold_mask;
> +     } else if (t_cold) {
> +             temp &= ~(temp_sensor->registers->mask_cold_mask);
> +             temp |= temp_sensor->registers->mask_hot_mask;
> +     }
> +
> +     omap_temp_sensor_writel(temp_sensor, temp,
> +             temp_sensor->registers->bgap_mask_ctrl);
> +
> +     /* kobject_uvent to user space telling thermal threshold crossed */
> +     kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHANGE);
> +
> +     mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +     return IRQ_HANDLED;
> +}
> +
> +static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)
> +{
> +     struct omap_temp_sensor_pdata   *pdata  = pdev->dev.platform_data;
> +     struct omap_temp_sensor         *temp_sensor;
> +     struct resource                 *mem;
> +     int                             ret = 0;
> +     int                             val, clk_rate;
> +
> +     if (!pdata) {
> +             dev_err(&pdev->dev, "platform data missing\n");
> +             return -EINVAL;
> +     }
> +
> +     temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
> +     if (!temp_sensor)
> +             return -ENOMEM;
> +
> +     mutex_init(&temp_sensor->sensor_mutex);
> +
> +     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +     if (!mem) {
> +             dev_err(&pdev->dev, "no mem resource\n");
> +             ret = -EINVAL;

You can do PTR_ERR(mem) to get the return error value as an integer.
Otherwise, it makes more sense to be -ENOMEM

> +             goto plat_res_err;
> +     }
> +
> +     temp_sensor->irq = platform_get_irq_byname(pdev, "thermal_alert");
> +     if (temp_sensor->irq = -ENXIO) {
> +             dev_err(&pdev->dev, "get_irq_byname failed\n");
> +             ret = temp_sensor->irq;
> +             goto plat_res_err;
> +     }
> +

This flow can better be:
ret = platform_get_irq_byname(...)
if (ret < 0) //because it is an IRQ number
{ ... }

Then assign ret to temp_sensor->irq

> +     temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> +     temp_sensor->clock = NULL;
> +     temp_sensor->registers = pdata->registers;
> +     temp_sensor->hwmon_dev = &pdev->dev;
> +
> +     pm_runtime_enable(&pdev->dev);
> +     pm_runtime_irq_safe(&pdev->dev);
> +
> +     /*
> +      * check if the efuse has a non-zero value if not
> +      * it is an untrimmed sample and the temperatures
> +      * may not be accurate
> +      */
> +
> +     if (omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->bgap_efuse))
> +             temp_sensor->is_efuse_valid = 1;
> +
> +     platform_set_drvdata(pdev, temp_sensor);
> +     dev_set_drvdata(&pdev->dev, temp_sensor);
> +     temp_sensor->clock = clk_get(temp_sensor->hwmon_dev, "fck");
> +     if (IS_ERR(temp_sensor->clock)) {
> +             ret = PTR_ERR(temp_sensor->clock);
> +             dev_err(temp_sensor->hwmon_dev,
> +                     "unable to get fclk: %d\n", ret);
> +             ret = -EINVAL;

Same case here. Do not assign -EINVAL to ret

> +             goto plat_res_err;
> +     }
> +
> +     ret = omap_temp_sensor_clk_enable(temp_sensor);
> +     if (ret) {
> +             dev_err(&pdev->dev, "Cannot enable temp sensor\n");
> +             goto clken_err;
> +     }
> +
> +     clk_rate = clk_round_rate(temp_sensor->clock, 2000000);
> +     if (clk_rate < 1000000 || clk_rate = 0xffffffff) {
> +             dev_err(&pdev->dev, "Error round rate\n");

You might want to assign something to 'ret' here.

> +             goto clken_err;
> +     }
> +
> +     ret = clk_set_rate(temp_sensor->clock, clk_rate);
> +     if (ret) {
> +             dev_err(&pdev->dev, "Cannot set clock rate\n");
> +             goto clken_err;
> +     }
> +
> +     temp_sensor->clk_rate = clk_rate;
> +     omap_enable_continuous_mode(temp_sensor, 1);
> +     omap_configure_temp_sensor_thresholds(temp_sensor);
> +     /* 1 ms */
> +     omap_configure_temp_sensor_counter(temp_sensor, 1);
> +
> +     /* Wait till the first conversion is done wait for at least 1ms */
> +     usleep_range(1000, 2000);
> +
> +     /* Read the temperature once due to hw issue*/
> +     omap_temp_sensor_readl(temp_sensor,
> +                     temp_sensor->registers->temp_sensor_ctrl);
> +
> +     /* Set 2 seconds time as default counter */
> +     omap_configure_temp_sensor_counter(temp_sensor,
> +                                             temp_sensor->clk_rate * 2);
> +
> +     temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
> +     if (IS_ERR(temp_sensor->hwmon_dev)) {
> +             dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> +             ret = PTR_ERR(temp_sensor->hwmon_dev);
> +             goto hwmon_reg_err;
> +     }
> +
> +     ret = sysfs_create_group(&pdev->dev.kobj,
> +                              &omap_temp_sensor_group);
> +     if (ret) {
> +             dev_err(&pdev->dev, "could not create sysfs files\n");
> +             goto sysfs_create_err;
> +     }
> +
> +     kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> +
> +     ret = request_threaded_irq(temp_sensor->irq, NULL,
> +             omap_talert_irq_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +                     "temp_sensor", temp_sensor);
> +     if (ret) {
> +             dev_err(&pdev->dev, "Request threaded irq failed.\n");
> +             goto req_irq_err;
> +     }
> +
> +     /* unmask the T_COLD and unmask T_HOT at init */
> +     val = omap_temp_sensor_readl(temp_sensor,
> +             temp_sensor->registers->bgap_mask_ctrl);
> +     val |= temp_sensor->registers->mask_cold_mask
> +             | temp_sensor->registers->mask_hot_mask;
> +
> +     omap_temp_sensor_writel(temp_sensor, val,
> +             temp_sensor->registers->bgap_mask_ctrl);
> +
> +     return 0;
> +
> +req_irq_err:
> +     kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
> +     sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +                             &omap_temp_sensor_group);
> +sysfs_create_err:
> +     hwmon_device_unregister(&pdev->dev);
> +hwmon_reg_err:
> +     omap_temp_sensor_clk_disable(temp_sensor);
> +clken_err:
> +     if (temp_sensor->clock)

Looking at the probe flow, this 'if' check seems unnecessary.

Thanks,
Durga


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
