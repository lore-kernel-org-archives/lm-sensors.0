From: Janakiram Sistla <janakiram.sistla@gmail.com>
Date: Wed, 24 Aug 2011 16:36:05 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CACqS6krvH985gDwrD5kVEvbybC80wcYZN2AwV9pZ9=-x8hZAUg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8621861407649915353=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
	<1314196632-8207-7-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1314196632-8207-7-git-send-email-j-keerthy@ti.com>
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

--===============8621861407649915353==
Content-Type: multipart/alternative; boundary=90e6ba6e868e99d85304ab42e8ff

--90e6ba6e868e99d85304ab42e8ff
Content-Type: text/plain; charset=ISO-8859-1

Hi Keerthy,

Can you please point me the TRM of 4430 or 4460 where it reads the on die
temperature sensor used is TMP103. I am referring to public TRM on TI site.

Regards,
Sistla.

On Wed, Aug 24, 2011 at 9:37 AM, Keerthy <j-keerthy@ti.com> wrote:

> On chip temperature sensor driver. The driver monitors the temperature of
> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> the temperature crosses user defined thresholds via kobject_uevent
> interface.
> The user is allowed to configure the temperature thresholds vis sysfs nodes
> exposed using hwmon interface.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: lm-sensors@lm-sensors.org
> ---
>  Documentation/hwmon/omap_temp_sensor |   27 +
>  drivers/hwmon/Kconfig                |   11 +
>  drivers/hwmon/Makefile               |    1 +
>  drivers/hwmon/omap_temp_sensor.c     |  933
> ++++++++++++++++++++++++++++++++++
>  4 files changed, 972 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/omap_temp_sensor
>  create mode 100644 drivers/hwmon/omap_temp_sensor.c
>
> diff --git a/Documentation/hwmon/omap_temp_sensor
> b/Documentation/hwmon/omap_temp_sensor
> new file mode 100644
> index 0000000..e01a6d6
> --- /dev/null
> +++ b/Documentation/hwmon/omap_temp_sensor
> @@ -0,0 +1,27 @@
> +Kernel driver omap_temp_sensor
> +==============================
> +
> +Supported chips:
> +  * Texas Instruments OMAP4460
> +    Prefix: 'omap_temp_sensor'
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp102.html
> +
> +Author:
> +        J Keerthy <j-keerthy@ti.com>
> +
> +Description
> +-----------
> +
> +The Texas Instruments OMAP4 family of chips have a bandgap temperature
> sensor.
> +The temperature sensor feature is used to convert the temperature of the
> device
> +into a decimal value coded on 10 bits. An internal ADC is used for
> conversion.
> +The recommended operating temperatures must be in the range -40 degree
> Celsius
> +to 123 degree celsius for standard conversion.
> +The thresholds are programmable and upon crossing the thresholds an
> interrupt
> +is generated. The OMAP temperature sensor has a programmable update rate
> in
> +milli seconds.
> +(Currently the driver programs a default of 2000 milli seconds).
> +
> +The driver provides the common sysfs-interface for temperatures (see
> +Documentation/hwmon/sysfs-interface under Temperatures).
> +
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5f888f7..9c9cd8b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>          This driver can also be built as a module.  If so, the module
>          will be called f71805f.
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
>        tristate "Fintek F71882FG and compatibles"
>        help
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
> diff --git a/drivers/hwmon/omap_temp_sensor.c
> b/drivers/hwmon/omap_temp_sensor.c
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
> +       struct mutex            sensor_mutex; /* Mutex for sysfs, irq and
> PM */
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
> +       -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600,
> -38200,
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
> +       6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600,
> 11000,
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
> +               temp > adc_to_temp[OMAP_ADC_END_VALUE -
> OMAP_ADC_START_VALUE])
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
> +       temp |= (T_HOT <<
> __ffs(temp_sensor->registers->threshold_thot_mask)) |
> +               (T_COLD <<
> __ffs(temp_sensor->registers->threshold_tcold_mask));
> +       omap_temp_sensor_writel(temp_sensor, temp,
> +               temp_sensor->registers->bgap_threshold);
> +
> +       /* Configure the TSHUT thresholds */
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->thsut_threshold);
> +       temp |= (TSHUT_HOT <<
> __ffs(temp_sensor->registers->tshut_hot_mask))
> +           | (TSHUT_COLD <<
> __ffs(temp_sensor->registers->tshut_hot_mask));
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
> +static void omap_enable_continuous_mode(struct omap_temp_sensor
> *temp_sensor,
> +                                       bool enable)
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
> +                       >>
> __ffs(temp_sensor->registers->threshold_thot_mask);
> +
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid value\n");
> +               return -EDOM;
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
> +       }
> +
> +       t_hot = temp_to_adc_conversion(val);
> +       if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALUE)) {
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
> +       /* obtain the T cold value */
> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> +
> __ffs(temp_sensor->registers->threshold_tcold_mask);
> +
> +       if (t_hot < t_cold) {
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* write the new t_hot value */
> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       reg_val &= ~temp_sensor->registers->threshold_thot_mask;
> +       reg_val |= (t_hot <<
> +
> __ffs(temp_sensor->registers->threshold_thot_mask));
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
> +        * If current temperature is in-between the hot and cold
> thresholds,
> +        * Enable both masks.
> +        */
> +       if (temp > t_cold && temp < t_hot) {
> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> +                               temp_sensor->registers->bgap_mask_ctrl);
> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> +                               OMAP4460_BGAP_CTRL_OFFSET);
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
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_threshold);
> +       temp = (temp & temp_sensor->registers->threshold_tcold_mask) >>
> +               __ffs(temp_sensor->registers->threshold_tcold_mask);
> +       mutex_unlock(&temp_sensor->sensor_mutex);
> +
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid value\n");
> +               return -EDOM;
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
> +       struct omap_temp_sensor         *temp_sensor =
> dev_get_drvdata(dev);
> +       u32                             reg_val, t_hot, t_cold, temp;
> +       long                            val;
> +
> +       if (strict_strtol(buf, 10, &val)) {
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       t_cold = temp_to_adc_conversion(val);
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
> +               count = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* write the new t_cold value */
> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> +                       temp_sensor->registers->bgap_threshold);
> +       reg_val &= ~temp_sensor->registers->threshold_tcold_mask;
> +       reg_val |= t_cold <<
> +
> __ffs(temp_sensor->registers->threshold_tcold_mask);
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
> +        * If current temperature is in-between the hot and cold
> thresholds,
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
> +
> +       if (!temp_sensor->clk_rate) {
> +               dev_err(dev, "clk_rate is NULL\n");
> +               ret = -EDOM;
> +               goto out;
> +       }
> +
> +       mutex_lock(&temp_sensor->sensor_mutex);
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
> +       temp = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->temp_sensor_ctrl);
> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> +
> +       /* look up for temperature in the table and return the temperature
> */
> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> +               dev_err(dev, "invalid adc code reported %d", temp);
> +               ret = -EDOM;
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
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> omap_temp_sensor_read_temp,
> +                         NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +                         set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> show_temp_max_hyst,
> +                         set_temp_max_hyst, 0);
> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO,
> show_update_rate,
> +                         set_update_rate, 0);
> +
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
> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor
> *temp_sensor)
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
> +out:
> +       return ret;
> +}
> +
> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor
> *temp_sensor)
> +{
> +       u32 ret = 0;
> +
> +       if (!temp_sensor->clk_on) {
> +               dev_err(temp_sensor->hwmon_dev, "clock already off\n");
> +               goto out;
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
> +       mutex_init(&temp_sensor->sensor_mutex);
> +
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mem) {
> +               dev_err(&pdev->dev, "no mem resource\n");
> +               ret = -ENOMEM;
> +               goto plat_res_err;
> +       }
> +
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
> +               dev_dbg(temp_sensor->hwmon_dev,
> +                       "Invalid EFUSE, Non-trimmed BGAP, Temp not
> accurate\n");
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
> +               goto clken_err;
> +       }
> +
> +       clk_rate = clk_round_rate(temp_sensor->clock, max_freq);
> +       if (clk_rate < min_freq || clk_rate == 0xffffffff) {
> +               dev_err(&pdev->dev, "Error round rate\n");
> +               ret = -EDOM;
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
> +                                &omap_temp_sensor_group);
> +       if (ret) {
> +               dev_err(&pdev->dev, "could not create sysfs files\n");
> +               goto sysfs_create_err;
> +       }
> +
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> +
> +       ret = request_threaded_irq(temp_sensor->irq, NULL,
> +               omap_talert_irq_handler, IRQF_TRIGGER_RISING |
> IRQF_ONESHOT,
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
> +       return 0;
> +
> +req_irq_err:
> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
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
> +static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor
> *temp_sensor)
> +{
> +       temp_sensor->temp_sensor_ctrl = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->temp_sensor_ctrl);
> +       temp_sensor->bg_ctrl = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_mask_ctrl);
> +       temp_sensor->bg_counter = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_counter);
> +       temp_sensor->bg_threshold = omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->bgap_threshold);
> +       temp_sensor->temp_sensor_tshut_threshold =
> +               omap_temp_sensor_readl(temp_sensor,
> +               temp_sensor->registers->thsut_threshold);
> +}
> +
> +static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor
> *temp_sensor)
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
> +                       omap_temp_sensor_runtime_resume,
> omap_temp_sensor_idle)
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Thanks and Regards,
Janakiram Sistla.

--90e6ba6e868e99d85304ab42e8ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Keerthy,<br><br>Can you please point me the TRM of 4430 or 4460 where it=
 reads the on die temperature sensor used is TMP103. I am referring to publ=
ic TRM on TI site.<br><br>Regards,<br>Sistla.<br><br><div class=3D"gmail_qu=
ote">
On Wed, Aug 24, 2011 at 9:37 AM, Keerthy <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:j-keerthy@ti.com">j-keerthy@ti.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex;">
On chip temperature sensor driver. The driver monitors the temperature of<b=
r>
the MPU subsystem of the OMAP4. It sends notifications to the user space if=
<br>
the temperature crosses user defined thresholds via kobject_uevent interfac=
e.<br>
The user is allowed to configure the temperature thresholds vis sysfs nodes=
<br>
exposed using hwmon interface.<br>
<br>
Signed-off-by: Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-keerthy@ti=
.com</a>&gt;<br>
Cc: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.o=
rg</a>&gt;<br>
Cc: Guenter Roeck &lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter=
.roeck@ericsson.com</a>&gt;<br>
Cc: <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org<=
/a><br>
---<br>
=A0Documentation/hwmon/omap_temp_sensor | =A0 27 +<br>
=A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +<br>
=A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +<br>
=A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0933 ++++++++++++++++++++++=
++++++++++++<br>
=A04 files changed, 972 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 Documentation/hwmon/omap_temp_sensor<br>
=A0create mode 100644 drivers/hwmon/omap_temp_sensor.c<br>
<br>
diff --git a/Documentation/hwmon/omap_temp_sensor b/Documentation/hwmon/oma=
p_temp_sensor<br>
new file mode 100644<br>
index 0000000..e01a6d6<br>
--- /dev/null<br>
+++ b/Documentation/hwmon/omap_temp_sensor<br>
@@ -0,0 +1,27 @@<br>
+Kernel driver omap_temp_sensor<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
+<br>
+Supported chips:<br>
+ =A0* Texas Instruments OMAP4460<br>
+ =A0 =A0Prefix: &#39;omap_temp_sensor&#39;<br>
+ =A0 =A0Datasheet: <a href=3D"http://focus.ti.com/docs/prod/folders/print/=
tmp102.html" target=3D"_blank">http://focus.ti.com/docs/prod/folders/print/=
tmp102.html</a><br>
+<br>
+Author:<br>
+ =A0 =A0 =A0 =A0J Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-keerth=
y@ti.com</a>&gt;<br>
+<br>
+Description<br>
+-----------<br>
+<br>
+The Texas Instruments OMAP4 family of chips have a bandgap temperature sen=
sor.<br>
+The temperature sensor feature is used to convert the temperature of the d=
evice<br>
+into a decimal value coded on 10 bits. An internal ADC is used for convers=
ion.<br>
+The recommended operating temperatures must be in the range -40 degree Cel=
sius<br>
+to 123 degree celsius for standard conversion.<br>
+The thresholds are programmable and upon crossing the thresholds an interr=
upt<br>
+is generated. The OMAP temperature sensor has a programmable update rate i=
n<br>
+milli seconds.<br>
+(Currently the driver programs a default of 2000 milli seconds).<br>
+<br>
+The driver provides the common sysfs-interface for temperatures (see<br>
+Documentation/hwmon/sysfs-interface under Temperatures).<br>
+<br>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<br>
index 5f888f7..9c9cd8b 100644<br>
--- a/drivers/hwmon/Kconfig<br>
+++ b/drivers/hwmon/Kconfig<br>
@@ -323,6 +323,17 @@ config SENSORS_F71805F<br>
 =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, th=
e module<br>
 =A0 =A0 =A0 =A0 =A0will be called f71805f.<br>
<br>
+config SENSORS_OMAP_BANDGAP_TEMP_SENSOR<br>
+ =A0 =A0 =A0 bool &quot;OMAP on-die temperature sensor hwmon driver&quot;<=
br>
+ =A0 =A0 =A0 depends on HWMON &amp;&amp; ARCH_OMAP &amp;&amp; OMAP_TEMP_SE=
NSOR<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0 If you say yes here you get support for hardware<br>
+ =A0 =A0 =A0 =A0 monitoring features of the OMAP on die temperature<br>
+ =A0 =A0 =A0 =A0 sensor.<br>
+<br>
+ =A0 =A0 =A0 =A0 Continuous conversion programmable delay<br>
+ =A0 =A0 =A0 =A0 mode is used for temperature conversion.<br>
+<br>
=A0config SENSORS_F71882FG<br>
 =A0 =A0 =A0 =A0tristate &quot;Fintek F71882FG and compatibles&quot;<br>
 =A0 =A0 =A0 =A0help<br>
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile<br>
index 28061cf..d0f89f5 100644<br>
--- a/drivers/hwmon/Makefile<br>
+++ b/drivers/hwmon/Makefile<br>
@@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) +=3D max6639.o<br>
=A0obj-$(CONFIG_SENSORS_MAX6642) =A0+=3D max6642.o<br>
=A0obj-$(CONFIG_SENSORS_MAX6650) =A0+=3D max6650.o<br>
=A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o<br>
+obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap_temp_sensor.o<=
br>
=A0obj-$(CONFIG_SENSORS_PC87360) =A0+=3D pc87360.o<br>
=A0obj-$(CONFIG_SENSORS_PC87427) =A0+=3D pc87427.o<br>
=A0obj-$(CONFIG_SENSORS_PCF8591) =A0+=3D pcf8591.o<br>
diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_temp_sen=
sor.c<br>
new file mode 100644<br>
index 0000000..66fb3a9<br>
--- /dev/null<br>
+++ b/drivers/hwmon/omap_temp_sensor.c<br>
@@ -0,0 +1,933 @@<br>
+/*<br>
+ * OMAP4 Temperature sensor driver file<br>
+ *<br>
+ * Copyright (C) 2011 Texas Instruments Incorporated - <a href=3D"http://w=
ww.ti.com/" target=3D"_blank">http://www.ti.com/</a><br>
+ * Author: J Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-keerthy@ti.=
com</a>&gt;<br>
+ * Author: Moiz Sonasath &lt;<a href=3D"mailto:m-sonasath@ti.com">m-sonasa=
th@ti.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License<br>
+ * version 2 as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful, but<br>
+ * WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU<br>
+ * General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA<br>
+ * 02110-1301 USA<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/init.h&gt;<br>
+#include &lt;plat/omap_device.h&gt;<br>
+#include &lt;linux/kernel.h&gt;<br>
+#include &lt;linux/device.h&gt;<br>
+#include &lt;linux/jiffies.h&gt;<br>
+#include &lt;linux/hwmon.h&gt;<br>
+#include &lt;linux/hwmon-sysfs.h&gt;<br>
+#include &lt;linux/stddef.h&gt;<br>
+#include &lt;linux/sysfs.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/types.h&gt;<br>
+#include &lt;linux/mutex.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;plat/temperature_sensor.h&gt;<br>
+<br>
+#define TSHUT_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0920 =A0 =A0 /* 122 deg C */<b=
r>
+#define TSHUT_COLD =A0 =A0 =A0 =A0 =A0 =A0 866 =A0 =A0 /* 100 deg C */<br>
+#define T_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0800 =A0 =A0 /* 73 deg C *=
/<br>
+#define T_COLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 795 =A0 =A0 /* 71 deg C */<=
br>
+#define OMAP_ADC_START_VALUE =A0 530<br>
+#define OMAP_ADC_END_VALUE =A0 =A0 923<br>
+#define MAX_FREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 2000000<br>
+#define MIN_FREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000000<br>
+<br>
+/*<br>
+ * omap_temp_sensor structure<br>
+ * @hwmon_dev - device pointer<br>
+ * @clock - Clock pointer<br>
+ * @registers - Pointer to structure with register offsets and bitfields<b=
r>
+ * @sensor_mutex - Mutex for sysfs, irq and PM<br>
+ * @irq - MPU Irq number for thermal alert<br>
+ * @phy_base - Physical base of the temp I/O<br>
+ * @clk_rate - Holds current clock rate<br>
+ * @temp_sensor_ctrl - temp sensor control register value<br>
+ * @bg_ctrl - bandgap ctrl register value<br>
+ * @bg_counter - bandgap counter value<br>
+ * @bg_threshold - bandgap threshold register value<br>
+ * @temp_sensor_tshut_threshold - bandgap tshut register value<br>
+ * @is_efuse_valid - Flag to determine if efuse is valid or not<br>
+ * @clk_on - Manages the current clock state<br>
+ */<br>
+struct omap_temp_sensor {<br>
+ =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;<br>
+ =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;<br>
+ =A0 =A0 =A0 struct omap_temp_sensor_registers *registers;<br>
+ =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* Mutex fo=
r sysfs, irq and PM */<br>
+ =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;<br>
+ =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ctrl;=
<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_tshut=
_threshold;<br>
+ =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_efuse_valid;<b=
r>
+ =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;<br>
+};<br>
+<br>
+/*<br>
+ * Temperature values in milli degree celsius<br>
+ * ADC code values from 530 to 923<br>
+ */<br>
+static int adc_to_temp[] =3D {<br>
+ =A0 =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -3860=
0, -38200,<br>
+ =A0 =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -3480=
0,<br>
+ =A0 =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -3130=
0,<br>
+ =A0 =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -2780=
0,<br>
+ =A0 =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -2440=
0,<br>
+ =A0 =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -2100=
0,<br>
+ =A0 =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -1760=
0,<br>
+ =A0 =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -1420=
0,<br>
+ =A0 =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -1070=
0,<br>
+ =A0 =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -680=
0,<br>
+ =A0 =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000=
,<br>
+ =A0 =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 16=
00,<br>
+ =A0 =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 6=
400,<br>
+ =A0 =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600,=
 11000,<br>
+ =A0 =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800=
,<br>
+ =A0 =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700=
,<br>
+ =A0 =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600=
,<br>
+ =A0 =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400=
,<br>
+ =A0 =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200=
,<br>
+ =A0 =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000=
,<br>
+ =A0 =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800=
,<br>
+ =A0 =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600=
,<br>
+ =A0 =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300=
,<br>
+ =A0 =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000=
,<br>
+ =A0 =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800=
,<br>
+ =A0 =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600=
,<br>
+ =A0 =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400=
,<br>
+ =A0 =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200=
,<br>
+ =A0 =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800=
,<br>
+ =A0 =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600=
,<br>
+ =A0 =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400=
,<br>
+ =A0 =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000=
,<br>
+ =A0 =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800=
,<br>
+ =A0 =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400=
,<br>
+ =A0 =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200=
,<br>
+ =A0 =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800=
,<br>
+ =A0 =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600=
,<br>
+ =A0 =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 10=
1200,<br>
+ =A0 =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 10440=
0,<br>
+ =A0 =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 10780=
0,<br>
+ =A0 =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 11100=
0,<br>
+ =A0 =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 11420=
0,<br>
+ =A0 =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 11740=
0,<br>
+ =A0 =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 12060=
0,<br>
+ =A0 =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000<br>
+};<br>
+<br>
+static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 *temp_sensor, u32 reg)<br>
+{<br>
+ =A0 =A0 =A0 return __raw_readl(temp_sensor-&gt;phy_base + reg);<br>
+}<br>
+<br>
+static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_sensor,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 v=
al, u32 reg)<br>
+{<br>
+ =A0 =A0 =A0 __raw_writel(val, (temp_sensor-&gt;phy_base + reg));<br>
+}<br>
+<br>
+static int adc_to_temp_conversion(int adc_val)<br>
+{<br>
+ =A0 =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];<br>
+}<br>
+<br>
+static int temp_to_adc_conversion(long temp)<br>
+{<br>
+ =A0 =A0 =A0 int high, low, mid;<br>
+<br>
+ =A0 =A0 =A0 if (temp &lt; adc_to_temp[0] ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &gt; adc_to_temp[OMAP_ADC_END_VALUE - OM=
AP_ADC_START_VALUE])<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 high =3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;<br>
+ =A0 =A0 =A0 low =3D 0;<br>
+ =A0 =A0 =A0 mid =3D (high + low) / 2;<br>
+<br>
+ =A0 =A0 =A0 while (low &lt; high) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp &lt; adc_to_temp[mid])<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D mid - 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D mid + 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D (low + high) / 2;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return OMAP_ADC_START_VALUE + low;<br>
+}<br>
+<br>
+static void omap_configure_temp_sensor_thresholds(struct omap_temp_sensor<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 *temp_sensor)<br>
+{<br>
+ =A0 =A0 =A0 u32 temp;<br>
+<br>
+ =A0 =A0 =A0 /* Configure the TALERT thresholds */<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 temp |=3D (T_HOT &lt;&lt; __ffs(temp_sensor-&gt;registers-&gt=
;threshold_thot_mask)) |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (T_COLD &lt;&lt; __ffs(temp_sensor-&gt;regist=
ers-&gt;threshold_tcold_mask));<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_threshold)=
;<br>
+<br>
+ =A0 =A0 =A0 /* Configure the TSHUT thresholds */<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;thsut_threshold);<br>
+ =A0 =A0 =A0 temp |=3D (TSHUT_HOT &lt;&lt; __ffs(temp_sensor-&gt;registers=
-&gt;tshut_hot_mask))<br>
+ =A0 =A0 =A0 =A0 =A0 | (TSHUT_COLD &lt;&lt; __ffs(temp_sensor-&gt;register=
s-&gt;tshut_hot_mask));<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;thsut_threshold);<br>
+}<br>
+<br>
+static void omap_configure_temp_sensor_counter(struct omap_temp_sensor<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)<br>
+{<br>
+ =A0 =A0 =A0 u32 val;<br>
+<br>
+ =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_counter);<br>
+ =A0 =A0 =A0 val &amp;=3D ~temp_sensor-&gt;registers-&gt;counter_mask;<br>
+ =A0 =A0 =A0 val |=3D counter &lt;&lt; __ffs(temp_sensor-&gt;registers-&gt=
;counter_mask);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_counter);<br>
+}<br>
+<br>
+static void omap_enable_continuous_mode(struct omap_temp_sensor *temp_sens=
or,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 bool enable)<br>
+{<br>
+ =A0 =A0 =A0 u32 val;<br>
+<br>
+ =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_mode_ctrl);<br>
+<br>
+ =A0 =A0 =A0 if (enable)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D 1 &lt;&lt; __ffs(temp_sensor-&gt;reg=
isters-&gt;mode_ctrl_mask);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &amp;=3D ~temp_sensor-&gt;registers-&gt;m=
ode_ctrl_mask;<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_mode_ctrl);<br>
+}<br>
+<br>
+/* Sysfs hook functions */<br>
+<br>
+static ssize_t show_temp_max(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *deva=
ttr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 int temp;<br>
+<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 temp =3D (temp &amp; temp_sensor-&gt;registers-&gt;threshold_=
thot_mask)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;&gt; __ffs(temp_sensor-&g=
t;registers-&gt;threshold_thot_mask);<br>
+<br>
+ =A0 =A0 =A0 if (temp &lt; OMAP_ADC_START_VALUE || temp &gt; OMAP_ADC_END_=
VALUE) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;invalid value\n&quot;);<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);<br>
+<br>
+ =A0 =A0 =A0 return snprintf(buf, 16, &quot;%d\n&quot;, temp);<br>
+}<br>
+<br>
+static ssize_t set_temp_max(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribu=
te *devattr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size=
_t count)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, t_cold, =
t_hot, temp;<br>
+<br>
+ =A0 =A0 =A0 if (strict_strtol(buf, 10, &amp;val)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);<br>
+ =A0 =A0 =A0 if ((t_hot &lt; OMAP_ADC_START_VALUE || t_hot &gt; OMAP_ADC_E=
ND_VALUE)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 /* obtain the T cold value */<br>
+ =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 t_cold =3D (t_cold &amp; temp_sensor-&gt;registers-&gt;thresh=
old_tcold_mask) &gt;&gt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registe=
rs-&gt;threshold_tcold_mask);<br>
+<br>
+ =A0 =A0 =A0 if (t_hot &lt; t_cold) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* write the new t_hot value */<br>
+ =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 reg_val &amp;=3D ~temp_sensor-&gt;registers-&gt;threshold_tho=
t_mask;<br>
+ =A0 =A0 =A0 reg_val |=3D (t_hot &lt;&lt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registe=
rs-&gt;threshold_thot_mask));<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+<br>
+ =A0 =A0 =A0 /* Read the current temperature */<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;temp_sensor_ctrl);<br>
+ =A0 =A0 =A0 temp &amp;=3D temp_sensor-&gt;registers-&gt;bgap_dtemp_mask;<=
br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than the =
current<br>
+ =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (t_hot &gt; temp) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_senso=
r,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &amp;=3D ~temp_sensor-&gt;registers-&=
gt;mask_cold_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_hot_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* If current temperature is in-between the hot and cold th=
resholds,<br>
+ =A0 =A0 =A0 =A0* Enable both masks.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (temp &gt; t_cold &amp;&amp; temp &lt; t_hot) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_senso=
r,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_cold_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_hot_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4460_BGAP=
_CTRL_OFFSET);<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* else no need to do anything since HW will immediately co=
mpare<br>
+ =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordingly<br>
+ =A0 =A0 =A0 =A0*/<br>
+out:<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 return count;<br>
+}<br>
+<br>
+static ssize_t show_temp_max_hyst(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)<=
br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_threshold)=
;<br>
+ =A0 =A0 =A0 temp =3D (temp &amp; temp_sensor-&gt;registers-&gt;threshold_=
tcold_mask) &gt;&gt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registers-&gt;threshold=
_tcold_mask);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 if (temp &lt; OMAP_ADC_START_VALUE || temp &gt; OMAP_ADC_END_=
VALUE) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;invalid value\n&quot;);<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);<br>
+<br>
+ =A0 =A0 =A0 return snprintf(buf, 16, &quot;%d\n&quot;, temp);<br>
+}<br>
+<br>
+static ssize_t set_temp_max_hyst(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dev=
ice_attribute *devattr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char=
 *buf, size_t count)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =3D dev_=
get_drvdata(dev);<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r=
eg_val, t_hot, t_cold, temp;<br>
+ =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0v=
al;<br>
+<br>
+ =A0 =A0 =A0 if (strict_strtol(buf, 10, &amp;val)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(val);<br>
+ =A0 =A0 =A0 if (t_cold &lt; OMAP_ADC_START_VALUE || t_cold &gt; OMAP_ADC_=
END_VALUE) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 /* obtain the T HOT value */<br>
+ =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 t_hot =3D (t_hot &amp; temp_sensor-&gt;registers-&gt;threshol=
d_thot_mask) &gt;&gt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registe=
rs-&gt;threshold_thot_mask);<br>
+<br>
+ =A0 =A0 =A0 if (t_cold &gt; t_hot) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* write the new t_cold value */<br>
+ =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+ =A0 =A0 =A0 reg_val &amp;=3D ~temp_sensor-&gt;registers-&gt;threshold_tco=
ld_mask;<br>
+ =A0 =A0 =A0 reg_val |=3D t_cold &lt;&lt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registe=
rs-&gt;threshold_tcold_mask);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_threshold);<br>
+<br>
+ =A0 =A0 =A0 /* Read the current temperature */<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;temp_sensor_ctr=
l);<br>
+ =A0 =A0 =A0 temp &amp;=3D temp_sensor-&gt;registers-&gt;bgap_dtemp_mask;<=
br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than the cu=
rrent<br>
+ =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (t_cold &lt; temp) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_senso=
r,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &amp;=3D ~temp_sensor-&gt;registers-&=
gt;mask_hot_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_cold_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* If current temperature is in-between the hot and cold th=
resholds,<br>
+ =A0 =A0 =A0 =A0* Enable both masks.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (temp &lt; t_hot &amp;&amp; temp &gt; t_cold) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_senso=
r,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_cold_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor-&gt;registers-&gt;ma=
sk_hot_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* else no need to do anything since HW will immediately co=
mpare<br>
+ =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordingly<br>
+ =A0 =A0 =A0 =A0*/<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 return count;<br>
+}<br>
+<br>
+static ssize_t show_update_rate(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *deva=
ttr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 0, ret =
=3D 0;<br>
+<br>
+<br>
+ =A0 =A0 =A0 if (!temp_sensor-&gt;clk_rate) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;clk_rate is NULL\n&quot;);=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_counter);<br>
+ =A0 =A0 =A0 temp =3D (temp &amp; temp_sensor-&gt;registers-&gt;counter_ma=
sk) &gt;&gt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-&gt;registe=
rs-&gt;counter_mask);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp =3D temp * 1000 / temp_sensor-&gt;clk_rate;<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, temp);<=
br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static ssize_t set_update_rate(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_=
attribute *devattr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *bu=
f, size_t count)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;<br>
+ =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;<br>
+<br>
+ =A0 =A0 =A0 if (strict_strtol(buf, 10, &amp;val)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 val *=3D temp_sensor-&gt;clk_rate / 1000;<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_counter);<br>
+<br>
+ =A0 =A0 =A0 reg_val &amp;=3D ~temp_sensor-&gt;registers-&gt;counter_mask;=
<br>
+ =A0 =A0 =A0 reg_val |=3D val;<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_counter);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 return count;<br>
+}<br>
+<br>
+static int omap_temp_sensor_read_temp(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct device_attribute *devattr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c=
har *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret =3D 0;<=
br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;temp_sensor_ctr=
l);<br>
+ =A0 =A0 =A0 temp &amp;=3D temp_sensor-&gt;registers-&gt;bgap_dtemp_mask;<=
br>
+<br>
+ =A0 =A0 =A0 /* look up for temperature in the table and return the temper=
ature */<br>
+ =A0 =A0 =A0 if (temp &lt; OMAP_ADC_START_VALUE || temp &gt; OMAP_ADC_END_=
VALUE) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;invalid adc code reported =
%d&quot;, temp);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, temp);<=
br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_temp=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);<br>
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);<br>
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_max=
_hyst,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);<br=
>
+static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update_rate=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, 0);<br>
+<br>
+static struct attribute *omap_temp_sensor_attributes[] =3D {<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_input.dev_attr.attr,<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_max.dev_attr.attr,<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_max_hyst.dev_attr.attr,<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_update_rate.dev_attr.attr,<br>
+ =A0 =A0 =A0 NULL<br>
+};<br>
+<br>
+static const struct attribute_group omap_temp_sensor_group =3D {<br>
+ =A0 =A0 =A0 .attrs =3D omap_temp_sensor_attributes,<br>
+};<br>
+<br>
+static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_senso=
r)<br>
+{<br>
+ =A0 =A0 =A0 u32 ret =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (temp_sensor-&gt;clk_on) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor-&gt;hwmon_dev, &quot;cloc=
k already on\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor-&gt;hwmon_dev);<br>
+ =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor-&gt;hwmon_dev, &quot;get =
sync failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp_sensor-&gt;clk_on =3D 1;<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_sens=
or)<br>
+{<br>
+ =A0 =A0 =A0 u32 ret =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (!temp_sensor-&gt;clk_on) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor-&gt;hwmon_dev, &quot;cloc=
k already off\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Gate the clock */<br>
+ =A0 =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor-&gt;hwmon_dev);<br>
+ =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor-&gt;hwmon_dev, &quot;put =
sync failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 temp_sensor-&gt;clk_on =3D 0;<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+out:<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static irqreturn_t omap_talert_irq_handler(int irq, void *data)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t=
_hot, t_cold, temp;<br>
+<br>
+ =A0 =A0 =A0 temp_sensor =3D data;<br>
+ =A0 =A0 =A0 mutex_lock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 /* Read the status of t_hot */<br>
+ =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_status)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; temp_sensor-&gt;registe=
rs-&gt;status_hot_mask;<br>
+<br>
+ =A0 =A0 =A0 /* Read the status of t_cold */<br>
+ =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_status)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; temp_sensor-&gt;registe=
rs-&gt;status_cold_mask;<br>
+<br>
+ =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources<br>
+ =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot and<br>
+ =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_hot<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (t_hot) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &amp;=3D ~temp_sensor-&gt;registers-&gt;=
mask_hot_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor-&gt;registers-&gt;mask_=
cold_mask;<br>
+ =A0 =A0 =A0 } else if (t_cold) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &amp;=3D ~temp_sensor-&gt;registers-&gt;=
mask_cold_mask;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor-&gt;registers-&gt;mask_=
hot_mask;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_mask_ctrl)=
;<br>
+<br>
+ =A0 =A0 =A0 /* kobject_uvent to user space telling thermal threshold cros=
sed */<br>
+ =A0 =A0 =A0 kobject_uevent(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj, KOBJ_=
CHANGE);<br>
+<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 return IRQ_HANDLED;<br>
+}<br>
+<br>
+static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)<=
br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev-&gt;dev.=
platform_data;<br>
+ =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;<br>
+ =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r=
et =3D 0;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v=
al, clk_rate;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m=
ax_freq, min_freq;<br>
+<br>
+ =A0 =A0 =A0 if (!pdata) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;platform dat=
a missing\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNEL);<br=
>
+ =A0 =A0 =A0 if (!temp_sensor)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 mutex_init(&amp;temp_sensor-&gt;sensor_mutex);<br>
+<br>
+ =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);<br>
+ =A0 =A0 =A0 if (!mem) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;no mem resou=
rce\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp_sensor-&gt;irq =3D platform_get_irq_byname(pdev, &quot;t=
hermal_alert&quot;);<br>
+ =A0 =A0 =A0 if (temp_sensor-&gt;irq &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;get_irq_byna=
me failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor-&gt;irq;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp_sensor-&gt;phy_base =3D ioremap(mem-&gt;start, resource_=
size(mem));<br>
+ =A0 =A0 =A0 temp_sensor-&gt;clock =3D NULL;<br>
+ =A0 =A0 =A0 temp_sensor-&gt;registers =3D pdata-&gt;registers;<br>
+ =A0 =A0 =A0 temp_sensor-&gt;hwmon_dev =3D &amp;pdev-&gt;dev;<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;max_freq &amp;&amp; pdata-&gt;min_freq) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata-&gt;max_freq;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata-&gt;min_freq;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_enable(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 pm_runtime_irq_safe(&amp;pdev-&gt;dev);<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not<br>
+ =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures<br>
+ =A0 =A0 =A0 =A0* may not be accurate<br>
+ =A0 =A0 =A0 =A0*/<br>
+<br>
+ =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;bgap_efuse)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;is_efuse_valid =3D 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(temp_sensor-&gt;hwmon_dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Invalid EFUSE, Non-trim=
med BGAP, Temp not accurate\n&quot;);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 dev_set_drvdata(&amp;pdev-&gt;dev, temp_sensor);<br>
+ =A0 =A0 =A0 temp_sensor-&gt;clock =3D clk_get(temp_sensor-&gt;hwmon_dev, =
&quot;fck&quot;);<br>
+ =A0 =A0 =A0 if (IS_ERR(temp_sensor-&gt;clock)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor-&gt;clock);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor-&gt;hwmon_dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;unable to get fclk: %d\=
n&quot;, ret);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Cannot enabl=
e temp sensor\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor-&gt;clock, max_freq);=
<br>
+ =A0 =A0 =A0 if (clk_rate &lt; min_freq || clk_rate =3D=3D 0xffffffff) {<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Error round =
rate\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor-&gt;clock, clk_rate);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Cannot set c=
lock rate\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 temp_sensor-&gt;clk_rate =3D clk_rate;<br>
+ =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);<br>
+ =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);<br>
+ =A0 =A0 =A0 /* 1 ms */<br>
+ =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);<br>
+<br>
+ =A0 =A0 =A0 /* Wait till the first conversion is done wait for at least 1=
ms */<br>
+ =A0 =A0 =A0 usleep_range(1000, 2000);<br>
+<br>
+ =A0 =A0 =A0 /* Read the temperature once due to hw issue*/<br>
+ =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt=
;temp_sensor_ctrl);<br>
+<br>
+ =A0 =A0 =A0 /* Set 2 seconds time as default counter */<br>
+ =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;clk_rate * 2);<br>
+<br>
+ =A0 =A0 =A0 temp_sensor-&gt;hwmon_dev =3D hwmon_device_register(&amp;pdev=
-&gt;dev);<br>
+ =A0 =A0 =A0 if (IS_ERR(temp_sensor-&gt;hwmon_dev)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;hwmon_device=
_register failed.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor-&gt;hwmon_dev);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D sysfs_create_group(&amp;pdev-&gt;dev.kobj,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&amp;omap_=
temp_sensor_group);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;could not cr=
eate sysfs files\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 kobject_uevent(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj, KOBJ_=
ADD);<br>
+<br>
+ =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor-&gt;irq, NULL,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_RISING =
| IRQF_ONESHOT,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;temp_sensor&quot;, temp=
_sensor);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Request thre=
aded irq failed.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */<br>
+ =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_mask_ctrl)=
;<br>
+ =A0 =A0 =A0 val |=3D temp_sensor-&gt;registers-&gt;mask_cold_mask<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor-&gt;registers-&gt;mask_hot_mask=
;<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_mask_ctrl)=
;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+<br>
+req_irq_err:<br>
+ =A0 =A0 =A0 kobject_uevent(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj, KOBJ_=
REMOVE);<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj,<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;omap_tem=
p_sensor_group);<br>
+sysfs_create_err:<br>
+ =A0 =A0 =A0 hwmon_device_unregister(&amp;pdev-&gt;dev);<br>
+hwmon_reg_err:<br>
+ =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);<br>
+clken_err:<br>
+ =A0 =A0 =A0 clk_put(temp_sensor-&gt;clock);<br>
+plat_res_err:<br>
+ =A0 =A0 =A0 dev_set_drvdata(&amp;pdev-&gt;dev, NULL);<br>
+ =A0 =A0 =A0 mutex_destroy(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 kfree(temp_sensor);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int __devexit omap_temp_sensor_remove(struct platform_device *pdev)=
<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D platform_get_drvdata=
(pdev);<br>
+<br>
+ =A0 =A0 =A0 hwmon_device_unregister(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 kobject_uevent(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj, KOBJ_=
REMOVE);<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;temp_sensor-&gt;hwmon_dev-&gt;kobj,<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;omap_temp_sensor_group);=
<br>
+ =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);<br>
+ =A0 =A0 =A0 free_irq(temp_sensor-&gt;irq, temp_sensor);<br>
+ =A0 =A0 =A0 clk_put(temp_sensor-&gt;clock);<br>
+ =A0 =A0 =A0 dev_set_drvdata(&amp;pdev-&gt;dev, NULL);<br>
+ =A0 =A0 =A0 mutex_destroy(&amp;temp_sensor-&gt;sensor_mutex);<br>
+ =A0 =A0 =A0 kfree(temp_sensor);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+#ifdef CONFIG_PM<br>
+static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor *temp_senso=
r)<br>
+{<br>
+ =A0 =A0 =A0 temp_sensor-&gt;temp_sensor_ctrl =3D omap_temp_sensor_readl(t=
emp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;temp_sensor_ctr=
l);<br>
+ =A0 =A0 =A0 temp_sensor-&gt;bg_ctrl =3D omap_temp_sensor_readl(temp_senso=
r,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_mask_ctrl)=
;<br>
+ =A0 =A0 =A0 temp_sensor-&gt;bg_counter =3D omap_temp_sensor_readl(temp_se=
nsor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_counter);<=
br>
+ =A0 =A0 =A0 temp_sensor-&gt;bg_threshold =3D omap_temp_sensor_readl(temp_=
sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;bgap_threshold)=
;<br>
+ =A0 =A0 =A0 temp_sensor-&gt;temp_sensor_tshut_threshold =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&gt;registers-&gt;thsut_threshold=
);<br>
+}<br>
+<br>
+static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor *temp_se=
nsor)<br>
+{<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;temp_sensor_ctrl,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;temp_sensor_ctrl);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;bg_ctrl,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_mask_ctrl);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;bg_counter,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_counter);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;bg_threshold,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;bgap_threshold);<br>
+ =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;temp_sensor_tshut_threshold,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor-&=
gt;registers-&gt;thsut_threshold);<br>
+}<br>
+<br>
+static int omap_temp_sensor_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int omap_temp_sensor_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int omap_temp_sensor_runtime_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+<br>
+ =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int omap_temp_sensor_runtime_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 static int context_loss_count;<br>
+ =A0 =A0 =A0 int temp;<br>
+ =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev)=
;<br>
+<br>
+ =A0 =A0 =A0 temp =3D omap_device_get_context_loss_count(to_platform_devic=
e(dev));<br>
+<br>
+ =A0 =A0 =A0 if (temp !=3D context_loss_count &amp;&amp; context_loss_coun=
t !=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);<b=
r>
+<br>
+ =A0 =A0 =A0 context_loss_count =3D temp;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int omap_temp_sensor_idle(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {<br>
+ =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(omap_temp_sensor_suspend,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_resume)<br>
+ =A0 =A0 =A0 SET_RUNTIME_PM_OPS(omap_temp_sensor_runtime_suspend,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_runtime_resu=
me, omap_temp_sensor_idle)<br>
+};<br>
+<br>
+#define DEV_PM_OPS =A0 =A0 (&amp;omap_temp_sensor_dev_pm_ops)<br>
+#else<br>
+#define DEV_PM_OPS =A0 =A0 NULL<br>
+#endif<br>
+<br>
+static struct platform_driver omap_temp_sensor_driver =3D {<br>
+ =A0 =A0 =A0 .probe =3D omap_temp_sensor_probe,<br>
+ =A0 =A0 =A0 .remove =3D omap_temp_sensor_remove,<br>
+ =A0 =A0 =A0 .driver =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D &quot;omap_temp_sen=
sor&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D DEV_PM_OPS,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },<br>
+};<br>
+<br>
+int __init omap_temp_sensor_init(void)<br>
+{<br>
+ =A0 =A0 =A0 return platform_driver_register(&amp;omap_temp_sensor_driver)=
;<br>
+}<br>
+module_init(omap_temp_sensor_init);<br>
+<br>
+static void __exit omap_temp_sensor_exit(void)<br>
+{<br>
+ =A0 =A0 =A0 platform_driver_unregister(&amp;omap_temp_sensor_driver);<br>
+}<br>
+module_exit(omap_temp_sensor_exit);<br>
+<br>
+MODULE_DESCRIPTION(&quot;OMAP446X temperature sensor Driver&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_ALIAS(&quot;platform:&quot; DRIVER_NAME);<br>
+MODULE_AUTHOR(&quot;J Keerthy &lt;<a href=3D"mailto:j-keerthy@ti.com">j-ke=
erthy@ti.com</a>&gt;&quot;);<br>
--<br>
1.7.0.4<br>
<font color=3D"#888888"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-omap&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Thanks and Regar=
ds,<br>Janakiram Sistla.<br>

--90e6ba6e868e99d85304ab42e8ff--


--===============8621861407649915353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8621861407649915353==--
