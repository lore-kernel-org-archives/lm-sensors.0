From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 15 Nov 2010 16:41:53 +0000
Subject: Re: [lm-sensors] [PATCH] intel medfield: thermal_driver
Message-Id: <20101115164153.GA26334@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101115131616.26319.23030.stgit@localhost.localdomain>
In-Reply-To: <20101115131616.26319.23030.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 15, 2010 at 08:16:41AM -0500, Alan Cox wrote:
> From: Durgadoss <durgadoss.r@intel.com>
> 
> [Merged copy for review only: combination of the two patch set]
> 
> This is the basic thermal sensor driver for Intel MID platform using the
> Medfield chipset. It plugs in via the thermal drivers and provides sensor
> readings for the device sensors.
> 
> (Open question: does it go in drivers/hwmon or drivers/thermal - Rui ?)
> 
drivers/thermal seems the most natural choice.

> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> [Massively cleaned up]
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/hwmon/Kconfig             |    7
>  drivers/hwmon/Makefile            |    1
>  drivers/hwmon/intel_mid_thermal.c |  574 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 582 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/intel_mid_thermal.c
> 
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a56f6ad..d20aafd 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1171,6 +1171,13 @@ config SENSORS_MC13783_ADC
>          help
>            Support for the A/D converter on MC13783 PMIC.
> 
> +config SENSORS_THERMAL_MFLD
> +        tristate "Thermal driver for Intel Medfield platform"
> +        depends on INTEL_SCU_IPC && THERMAL
> +        help
> +          Say Y here to enable thermal driver for the  Intel Medfield

	"the  Intel" --> "the Intel"

> +          platform.
> +
>  if ACPI
> 
>  comment "ACPI drivers"
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 2479b3d..e1f42f3 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -109,6 +109,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)     += w83l785ts.o
>  obj-$(CONFIG_SENSORS_W83L786NG)        += w83l786ng.o
>  obj-$(CONFIG_SENSORS_WM831X)   += wm831x-hwmon.o
>  obj-$(CONFIG_SENSORS_WM8350)   += wm8350-hwmon.o
> +obj-$(CONFIG_SENSORS_THERMAL_MFLD)   += intel_mid_thermal.o
> 
This is not in alphabetical order.

>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/hwmon/intel_mid_thermal.c b/drivers/hwmon/intel_mid_thermal.c
> new file mode 100644
> index 0000000..eae58b2
> --- /dev/null
> +++ b/drivers/hwmon/intel_mid_thermal.c
> @@ -0,0 +1,574 @@
> +/*
> + * intel_mid_thermal.c - Intel MID platform thermal driver
> + *
> + * Copyright (C) 2010 Intel Corporation
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * Author: Ananth Krishna <ananth.krishna.r@intel.com>
> + * Author: Durgadoss <durgadoss.r@intel.com>
> + */
> +
> +#define pr_fmt(fmt)  "intel_mid_thermal: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/param.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pm.h>
> +#include <linux/thermal.h>
> +
> +#include <asm/intel_scu_ipc.h>
> +
> +

Extra blank line

> +/* Number of thermal sensors */
> +#define MSIC_THERMAL_SENSORS   4
> +
> +/* ADC1 - thermal registers */
> +#define MSIC_THERM_ADC1CNTL1   0x1C0
> +#define MSIC_ADC_ENBL          0x10
> +#define MSIC_ADC_START         0x08
> +

Those defines reflect masks, so please define as (1 << 4) and (1 << 3).

> +#define MSIC_THERM_ADC1CNTL3   0x1C2
> +#define MSIC_ADCTHERM_ENBL     0x04
> +#define MSIC_ADCRRDATA_ENBL    0x05
> +#define MSIC_CHANL_MASK_VAL    0x0F
> +

This define does not seem to be used anywhere.

> +#define MSIC_STOPBIT_MASK      16
> +#define MSIC_ADCTHERM_MASK     4

Please define as masks.

> +#define ADC_CHANLS_MAX         15 /* Number of ADC channels */

"MAX" and "number of channels" are often not the same, especially if the first
channel has number 0. The usage here is
    for (i = 0; i < ADC_CHANLS_MAX; i++)
indicating that it may not be the maximum, but the number of channels.
If so, ADC_CHANLS_COUNT may be a better define.

> +#define ADC_LOOP_MAX           (ADC_CHANLS_MAX - MSIC_THERMAL_SENSORS)

On the other side, the usage of this define suggests that ADC_CHANLS_MAX might
be the maximum channel number, indicating that there may be 16 sensors, not 15.
Now what is correct ?

> +
> +#define MSIC_VAUDA             0x0DB
> +#define MSIC_VAUDA_VAL         0xFF
> +
> +/* ADC channel code values */
> +#define SKIN_SENSOR0_CODE      0x08
> +#define SKIN_SENSOR1_CODE      0x09
> +#define SYS_SENSOR_CODE                0x0A
> +#define MSIC_DIE_SENSOR_CODE   0x03
> +
> +#define SKIN_THERM_SENSOR0     0
> +#define SKIN_THERM_SENSOR1     1
> +#define SYS_THERM_SENSOR2      2
> +#define MSIC_DIE_THERM_SENSOR3 3
> +
> +/* ADC code range */
> +#define ADC_MAX                        977
> +#define ADC_MIN                        162
> +#define ADC_VAL1               887
> +#define ADC_VAL2               720
> +#define ADC_VAL3               508
> +#define ADC_VAL4               315
> +
> +/* ADC base addresses */
> +#define ADC_CHNL_START_ADDR    0x1C5   /* increments by 1 */
> +#define ADC_DATA_START_ADDR     0x1D4   /* increments by 2 */
> +

Please watch formatting.

> +/* MSIC die attributes */
> +#define MSIC_DIE_ADC_MIN       488
> +#define MSIC_DIE_ADC_MAX       1004
> +
> +/* convert adc_val to die temperature */
> +#define TO_MSIC_DIE_TEMP(adc_val)      ((368 * (adc_val) / 1000) - 220)
> +
> +static int channel_index;
> +
> +struct platform_info {
> +       struct platform_device *pdev;
> +       struct thermal_zone_device *tzd[MSIC_THERMAL_SENSORS];
> +};
> +
> +struct thermal_device_info {
> +       unsigned int chnl_addr;
> +       int direct;
> +       long curr_temp;
> +};
> +
> +

Extra blank line

> +/**
> + * is_valid_adc - checks whether the adc code is within the defined range
> + * @min: minimum value for the sensor
> + * @max: maximum value for the sensor
> + *
> + * Can sleep
> + */
> +static int is_valid_adc(uint16_t adc_val, uint16_t min, uint16_t max)
> +{
> +       return (adc_val >= min) && (adc_val <= max);
> +}
> +
> +/**
> + * adc_to_temp - converts the ADC code to temperature in C
> + * @direct: true if ths channel is direct index
> + * @adc_val: the adc_val that needs to be converted
> + * @tp: temperature return value
> + *
> + * Linear approximation is used to covert the skin adc value into temperature.
> + * This technique is used to avoid very long look-up table to get
> + * the appropriate temp value from ADC value.
> + * The adc code vs sensor temp curve is split into five parts
> + * to achieve very close approximate temp value with less than
> + * 0.5C error
> + */
> +static int adc_to_temp(int direct, uint16_t adc_val, unsigned long *tp)
> +{
> +       int temp;
> +
> +       /* Direct conversion for die temperature */
> +       if (direct) {
> +               if (is_valid_adc(adc_val, MSIC_DIE_ADC_MIN, MSIC_DIE_ADC_MAX)) {
> +                       *tp = (int)(TO_MSIC_DIE_TEMP(adc_val) * 1000);
> +                       return 0;
> +               }
> +               return -ERANGE;
> +       }
> +
> +       if (!is_valid_adc(adc_val, ADC_MIN, ADC_MAX))
> +               return -ERANGE;
> +
> +       /* Linear approximation for skin temperature */
> +       if (adc_val > ADC_VAL1) /* -20 to 0C */
> +               temp = 177 - (adc_val/5);
> +       else if ((adc_val <= ADC_VAL1) && (adc_val > ADC_VAL2)) /* 0C to 20C */
> +               temp = 111 - (adc_val/8);
> +       else if ((adc_val <= ADC_VAL2) && (adc_val > ADC_VAL3)) /* 20C to 40C */
> +               temp = 92 - (adc_val/10);
> +       else if ((adc_val <= ADC_VAL3) && (adc_val > ADC_VAL4)) /* 40C to 60C */
> +               temp = 91 - (adc_val/10);
> +       else
> +               temp = 112 - (adc_val/6); /* 60C to 85C */
> +
> +       /* Convert temperature in celsius to milli degree celsius */
> +       *tp = temp * 1000;
> +       return 0;
> +}
> +
> +/**
> + * mid_read_temp - read sensors for temperature
> + * @temp: holds the current temperature for the sensor after reading
> + *
> + * reads the adc_code from the channel and converts it to real
> + * temperature. The converted value is stored in temp.
> + *
> + * Can sleep
> + */
> +static int mid_read_temp(struct thermal_zone_device *tzd, unsigned long *temp)
> +{
> +       struct thermal_device_info *td_info = tzd->devdata;
> +       uint16_t adc_val, addr;
> +       uint8_t data = 0;
> +       int ret;
> +       unsigned long curr_temp;
> +
> +
Extra blank line

> +       addr = td_info->chnl_addr;
> +
> +       /* Enable the msic for conversion before reading */
> +       ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCRRDATA_ENBL);
> +       if (ret)
> +               return ret;
> +
> +       /* Re-toggle the RRDATARD bit (temporary workaround) */
> +       ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCTHERM_ENBL);
> +       if (ret)
> +               return ret;
> +
> +       /* Read the higher bits of data */
> +       ret = intel_scu_ipc_ioread8(addr, &data);
> +       if (ret)
> +               return ret;
> +
> +       /* Shift bits to accomodate the lower two data bits */
> +       adc_val = (data << 2);
> +       addr++;
> +
> +       ret = intel_scu_ipc_ioread8(addr, &data);/* Read lower bits */
> +       if (ret)
> +               return ret;
> +
> +       /* Adding lower two bits to the higher bits */
> +       data &= 03;
> +       adc_val += data;
> +
> +       /* Convert ADC value to temperature */
> +       ret = adc_to_temp(td_info->direct, adc_val, &curr_temp);
> +       if (ret = 0)
> +               *temp = td_info->curr_temp = curr_temp;
> +       return ret;
> +}
> +
> +/**
> + * configure_adc - enables/disables the ADC for conversion
> + * @val: zero: disables the adc non-zero:enables the ADC
> + *
> + * Enable/Disable the ADC depending on the argument
> + *
> + * Can sleep
> + */
> +static int configure_adc(int val)
> +{
> +       int ret;
> +       uint8_t data;
> +
> +       ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL1, &data);
> +       if (ret)
> +               return ret;
> +
> +       if (val)
> +               /* Enable and start the adc */
> +               data |= (MSIC_ADC_ENBL | MSIC_ADC_START);
> +       else
> +               /* Just stop the adc */
> +               data &= (~MSIC_ADC_START);
> +
> +       return intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL1, data);
> +}
> +
> +/**
> + * set_up_therm_chnl - enable thermal channel for conversion
> + * @base_addr: index of free msic ADC channel
> + *
> + * Enable all the three channels for conversion
> + *
> + * Can sleep
> + */
> +static int set_up_therm_chnl(u16 base_addr)
> +{
> +       int ret;
> +
> +       /* Enable all the sensor channels */
> +       ret = intel_scu_ipc_iowrite8(base_addr, SKIN_SENSOR0_CODE);
> +       if (ret)
> +               return ret;
> +
> +       ret = intel_scu_ipc_iowrite8(base_addr + 1, SKIN_SENSOR1_CODE);
> +       if (ret)
> +               return ret;
> +
> +       ret = intel_scu_ipc_iowrite8(base_addr + 2, SYS_SENSOR_CODE);
> +       if (ret)
> +               return ret;
> +
> +       /* Since this is the last channel, set the stop bit
> +          to 1 by ORing the DIE_SENSOR_CODE with 0x10 */

Please follow guidelines for multi-line comments.

> +       ret = intel_scu_ipc_iowrite8(base_addr + 3,
> +                                       (MSIC_DIE_SENSOR_CODE | 0x10));
> +       if (ret)
> +               return ret;
> +
> +       /* Enable VAUDA line: temporary workaround for MSIC issue */

If this is a temporary workaround, what is the fix, and when will it be
implemented ? And what is the issue ?

> +       ret = intel_scu_ipc_iowrite8(MSIC_VAUDA, MSIC_VAUDA_VAL);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable adc and start it */
> +       ret = configure_adc(1);
> +
> +       return ret;
> +}
> +
> +/**
> + * reset_stopbit - sets the stop bit to 0 on the given channel
> + * @addr: address of the channel
> + *
> + * Can sleep
> + */
> +static int reset_stopbit(uint16_t addr)
> +{
> +       int ret;
> +       uint8_t data;
> +       ret = intel_scu_ipc_ioread8(addr, &data);
> +       if (ret)
> +               return ret;
> +       /* Set the stop bit to zero */
> +       return intel_scu_ipc_iowrite8(addr, (data & 0xEF));
> +}
> +
> +/**
> + * find_free_channel - finds an empty channel for conversion
> + *
> + * If the ADC is not enabled then start using 0th channel
> + * itself. Otherwise find an empty channel by looking for a
> + * channel in which the stopbit is set to 1. returns the index
> + * of the first free channel if succeeds or an error code.
> + *
> + * Context: can sleep

Deviating from other "can sleep" comments.

> + *
> + * FIXME: Ultimately the channel allocator will move into the intel_scu_ipc
> + * code.

Not sure if it is a good idea to have a FIXME in the code. Either fix it,
or make it a note.

> + */
> +static int find_free_channel(void)
> +{
> +       int ret;
> +       int i;
> +       uint8_t data;
> +
> +       /* check whether ADC is enabled */
> +       ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL1, &data);
> +       if (ret)
> +               return ret;
> +
> +       if ((data & MSIC_ADC_ENBL) = 0)
> +               return 0;
> +
> +       /* ADC is already enabled; Looki for an empty channel */

Looki --> Look

> +       for (i = 0; i < ADC_CHANLS_MAX; i++) {
> +               ret = intel_scu_ipc_ioread8(ADC_CHNL_START_ADDR + i, &data);
> +               if (ret)
> +                       return ret;
> +
> +               if (data & MSIC_STOPBIT_MASK) {
> +                       ret = i;
> +                       break;
> +               }
> +       }
> +       return (ret > ADC_LOOP_MAX) ? (-EINVAL) : ret;

	Extra () around -EINVAL

> +}
> +
> +/**
> + * mid_initialize_adc - initializing the ADC
> + * @dev: our device structure
> + *
> + * Initialize the ADC for reading thermistor values. Can sleep.
> + */
> +static int mid_initialize_adc(struct device *dev)
> +{
> +       u16 base_addr;
> +       int ret;
> +
> +       /*
> +        * Ensure that adctherm is disabled before we
> +        * initialize the ADC
> +        */
> +       ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL3, &data);
> +       if (ret)
> +               return ret;
> +
> +       if (data & MSIC_ADCTHERM_MASK)
> +               dev_warn(dev, "ADCTHERM already set");
> +
Is that a problem ? Just wondering if the warning has any value.

> +       /* Index of the first channel in which the stop bit is set */
> +       channel_index = find_free_channel();

The usage and call sequence for channel_index looks odd. I don't see a well defined
relationship between channel_index and the device. channel_index can change
each time mid_initialize_adc() is called, ie each time resume() is called.
Or if it can not change, it does not make sense to re-calculate it.

If channel_index can change, which the code implies, the initialized ADCs may
be different with each resume. However, since initialize_sensor() is only
called in probe, those sensors may not really be used. Maybe that just
happens to work, but it does not look very clean.

It would be much cleaner to select the ADC channel during probe, and then just
re-initialize (start) it in resume. If the whole point of suspend() is to stop
all ADC channels, then resume() might just call configure_adc(1) and not call
mid_initialize_adc() again. The global variable channel_index should not
be needed at all, since it is only used to pass information from here to
initialize_sensor().

Besides all this, configure_adc(0) does not disable the adc, it only stops
it. So find_free_channel() will function differently after the first call.

> +       if (channel_index < 0) {
> +               dev_err(dev, "No free ADC channels");
> +               return channel_index;
> +       }
> +
> +       base_addr = ADC_CHNL_START_ADDR + channel_index;
> +
> +       if (!(channel_index = 0 || channel_index = ADC_LOOP_MAX)) {

This is a bit confusing. I would suggest to use
        if (channel_index != 0 && channel_index != ADC_LOOP_MAX)
instead.

> +               /* Reset stop bit for channels other than 0 and 12 */

The if statement above checks for channels 0 and 11, though.

> +               ret = reset_stopbit(base_addr);
> +               if (ret)
> +                       return ret;
> +
> +               /* Index of the first free channel */
> +               base_addr++;
> +               channel_index++;

This is a bit confusing. Index values are translated as follows
(with ADC_LOOP_MAX = 15-4 = 11).

                0 --> 0
                1 --> 2
                ...
                10 --> 11
                11 --> 11
                12 --> 13
                13 --> 14
                14 --> 15

So index 1 and 10 are never used, and index 11 is used twice.

Is that really what is intended, is it a bug, or do I misread the code ?

> +       }
> +
> +       ret = set_up_therm_chnl(base_addr);
> +       if (ret) {
> +               dev_err(dev, "unable to enable ADC");
> +               return ret;
> +       }
> +       dev_dbg(dev, "ADC initialization successful");
> +       return ret;

Since ret is always 0 here, might as well return 0.

> +}
> +
> +/**
> + * initialize_sensor - sets default temp and timer ranges
> + * @index: index of the sensor
> + *
> + * Context: can sleep

I would suggest to use either "can sleep" or "Context: can sleep" throughout,
but not a mix.

> + */
> +static struct thermal_device_info *initialize_sensor(int index)
> +{
> +       struct thermal_device_info *td_info > +               kzalloc(sizeof(struct thermal_device_info), GFP_KERNEL);
> +
> +       if (!td_info)
> +               return NULL;
> +
> +       /* Set the base addr of the channel for this sensor */
> +       td_info->chnl_addr = ADC_DATA_START_ADDR + 2 * (channel_index + index);
> +       /* Sensor 3 is direct conversion */
> +       if (index = 3)
> +               td_info->direct = 1;
> +       return td_info;
> +}
> +
> +/**
> + * mid_thermal_resume - resume routine
> + * @pdev: platform device structure
> + *
> + * mid thermal resume: re-initializes the adc. Can sleep.
> + */
> +static int mid_thermal_resume(struct platform_device *pdev)
> +{
> +       return mid_initialize_adc(&pdev->dev);
> +}
> +
> +/**
> + * mid_thermal_suspend - suspend routine
> + * @pdev: platform device structure
> + *
> + * mid thermal suspend implements the suspend functionality
> + * by stopping the ADC. Can sleep.
> + */
> +static int mid_thermal_suspend(struct platform_device *pdev, pm_message_t mesg)
> +{
> +       /*
> +        * This just stops the ADC and does not disable it.
> +        * temporary workaround until we have a generic ADC driver.
> +        * If 0 is passed, it disables the ADC.
> +        */
> +       return configure_adc(0);
> +}
> +
> +/**
> + * read_curr_temp - reads the current temperature and stores in temp
> + * @temp: holds the current temperature value after reading
> + *
> + * Can sleep
> + */
> +static int read_curr_temp(struct thermal_zone_device *tzd, unsigned long *temp)
> +{
> +       WARN_ON(tzd = NULL);

Since you access tzd in mid_read_temp(), you'll get a crash anyway,
so this warning seems unnecessary. If you think checking for NULL is
necessary, you should return -EFAULT if it is detected.

> +       return mid_read_temp(tzd, temp);
> +}
> +
> +/* Can't be const */
> +static struct thermal_zone_device_ops tzd_ops = {
> +       .get_temp = read_curr_temp,
> +};
> +
> +
> +/**
> + * mid_thermal_probe - mfld thermal initialize
> + * @pdev: platform device structure
> + *
> + * mid thermal probe initializes the hardware and registers
> + * all the sensors with the generic thermal framework. Can sleep.
> + */
> +static int mid_thermal_probe(struct platform_device *pdev)
> +{
> +       static char *name[MSIC_THERMAL_SENSORS] = {
> +               "skin0", "skin1", "sys", "msicdie"
> +       };
> +
> +       int ret;
> +       int i;
> +       struct platform_info *pinfo;
> +
> +       pinfo = kzalloc(sizeof(struct platform_info), GFP_KERNEL);
> +       if (!pinfo)
> +               return -ENOMEM;
> +
> +       /* Initializing the hardware */
> +       ret = mid_initialize_adc(&pdev->dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "ADC init failed");

Memory leak. Please free pinfo.

> +               return ret;
> +       }
> +
> +       /* Register each sensor with the generic thermal framework */
> +       for (i = 0; i < MSIC_THERMAL_SENSORS; i++) {
> +               pinfo->tzd[i] = thermal_zone_device_register(name[i],
> +                                       0, initialize_sensor(i),
> +                                       &tzd_ops, 0, 0, 0, 0);

Since you don't check the result of initialize_sensor(), you will pass NULL if it fails.
thermal_zone_device_register() will put NULL in tz->devdata, which you then use 
in mid_read_temp() without checking.

I would suggest to make this a two-step process, calling thermal_zone_device_register()
only if initialize_sensor() was successful, and abort otherwise.

> +               if (IS_ERR(pinfo->tzd[i]))
> +                       goto reg_fail;
> +       }
> +
> +       pinfo->pdev = pdev;
> +       platform_set_drvdata(pdev, pinfo);
> +       return 0;
> +
> +reg_fail:
> +       ret = PTR_ERR(pinfo->tzd[i]);

Assigning ret after IS_ERR above might be a bit cleaner.

> +       while (--i >= 0)
> +               thermal_zone_device_unregister(pinfo->tzd[i]);
> +       configure_adc(0);

Memory leak (pinfo).

> +       return ret;
> +}
> +
> +/**
> + * mid_thermal_remove - mfld thermal finalize
> + * @dev: platform device structure
> + *
> + * MLFD thermal remove unregisters all the sensors from the generic
> + * thermal framework. Can sleep
> + */
> +static int mid_thermal_remove(struct platform_device *pdev)
> +{
> +       int i;
> +       struct platform_info *pinfo = platform_get_drvdata(pdev);
> +
> +       for (i = 0; i < MSIC_THERMAL_SENSORS; i++)
> +               thermal_zone_device_unregister(pinfo->tzd[i]);
> +
> +       platform_set_drvdata(pdev, NULL);
> +
> +       /* Stop the ADC */
> +       configure_adc(0);

Memory leak (pinfo).

> +       return 0;
> +}
> +
> +/*********************************************************************
> + *             Driver initialisation and finalization
> + *********************************************************************/
> +
> +#define DRIVER_NAME "msic_sensor"
> +
> +static const struct platform_device_id therm_id_table[] = {
> +       { DRIVER_NAME, 1 },
> +};
> +
> +static struct platform_driver mid_thermal_driver = {
> +       .driver = {
> +               .name = DRIVER_NAME,
> +               .owner = THIS_MODULE,
> +       },
> +       .probe = mid_thermal_probe,
> +       .suspend = mid_thermal_suspend,
> +       .resume = mid_thermal_resume,
> +       .remove = __devexit_p(mid_thermal_remove),
> +       .id_table = therm_id_table,
> +};
> +
> +static int __init mid_thermal_module_init(void)
> +{
> +       return platform_driver_register(&mid_thermal_driver);
> +}
> +
> +static void __exit mid_thermal_module_exit(void)
> +{
> +       platform_driver_unregister(&mid_thermal_driver);
> +}
> +
> +module_init(mid_thermal_module_init);
> +module_exit(mid_thermal_module_exit);
> +
> +MODULE_AUTHOR("Durgadoss <durgadoss.r@intel.com>");

It is customary to use the full name here. No problem with me, but I have
seen reviews where this was suggested.

> +MODULE_DESCRIPTION("Intel Medfield Platform Thermal Driver");
> +MODULE_LICENSE("GPL");
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
