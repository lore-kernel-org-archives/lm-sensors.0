From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Tue, 21 Jun 2011 05:59:07 +0000
Subject: Re: [lm-sensors] [PATCH v10] drivers/hwmon NTC Thermistor Initial
Message-Id: <BANLkTim5BY2P244+d4+tAqnhRScyR+-9Hg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6750463226802066989=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1308556099-26761-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308556099-26761-1-git-send-email-dg77.kim@samsung.com>
To: lm-sensors@vger.kernel.org

--===============6750463226802066989==
Content-Type: multipart/alternative; boundary=000325558342e437c204a6326179

--000325558342e437c204a6326179
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jun 20, 2011 at 1:18 PM, Donggeun Kim <dg77.kim@samsung.com> wrote:

> This patch adds support for NTC Thermistor series. In this release, the
> following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
> and NCP15WL333. This driver is based on the datasheet of MURATA.
>
> The driver in the patch does conversion from the raw ADC value
> (either voltage or resistence) to temperature. In order to use
> voltage values as input, the circuit schematics should be provided
> with the platform data. A compensation table for each type of thermistor
> is provided for the conversion.
>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
>
> Looks good feel free to add
my reviewed by : Shubhrajyoti D <shubhrajyoti@ti.com >

> --
> Updates
> v10
> - return error code passed from function of platform data
> v9
> - remove unnecessary variables(mintemp, maxtemp) and checking lines for
> them
> v8
> - remove compiler warning message
> - update Documentation/hwmon/ntc_thermistor
> - add EXPERIMENTAL Kconfig dependency
> v7
> - move header file location
> - rename header and driver file
> - style fixes
> v6
> - updated Documentation/hwmon/ntc
> - style fixes
> v5
> - use binary search on sorted table
> - removed unnecessary attributes
> - style fixes
> v4
> - put in alphabetic order in Kconfig/Makefile
> - handle additional error cases
> - remove the exported function
> v3
> - style fixes
> - removed symbol exports
> - avoid divide-by-zero
> - omitted files added (Kconfig/Makefile)
> - removed unnecessary codes
> - return error values, not default values for errors.
> v2
> - added Documentation/hwmon/ntc
> - followed hwmon sysfs
> - detached the monitoring service
> (thank you for the comments, Guenter Roeck)
> ---
>  Documentation/hwmon/ntc_thermistor           |   93 ++++++
>  drivers/hwmon/Kconfig                        |   14 +
>  drivers/hwmon/Makefile                       |    1 +
>  drivers/hwmon/ntc_thermistor.c               |  453
> ++++++++++++++++++++++++++
>  include/linux/platform_data/ntc_thermistor.h |   53 +++
>  5 files changed, 614 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ntc_thermistor
>  create mode 100644 drivers/hwmon/ntc_thermistor.c
>  create mode 100644 include/linux/platform_data/ntc_thermistor.h
>
> diff --git a/Documentation/hwmon/ntc_thermistor
> b/Documentation/hwmon/ntc_thermistor
> new file mode 100644
> index 0000000..3bfda94
> --- /dev/null
> +++ b/Documentation/hwmon/ntc_thermistor
> @@ -0,0 +1,93 @@
> +Kernel driver ntc_thermistor
> +=================
> +
> +Supported thermistors:
> +* Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473,
> NCP15WL333
> +  Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473',
> 'ncp15wl333'
> +  Datasheet: Publicly available at Murata
> +
> +Other NTC thermistors can be supported simply by adding compensation
> +tables; e.g., NCP15WL333 support is added by the table ncpXXwl333.
> +
> +Authors:
> +       MyungJoo Ham <myungjoo.ham@samsung.com>
> +
> +Description
> +-----------
> +
> +The NTC thermistor is a simple thermistor that requires users to provide
> the
> +resistance and lookup the corresponding compensation table to get the
> +temperature input.
> +
> +The NTC driver provides lookup tables with a linear approximation function
> +and four circuit models with an option not to use any of the four models.
> +
> +The four circuit models provided are:
> +
> +       $: resister, [TH]: the thermistor
> +
> + 1. connect = NTC_CONNECTED_POSITIVE, pullup_ohm > 0
> +
> +   [pullup_uV]
> +       |    |
> +      [TH]  $ (pullup_ohm)
> +       |    |
> +       +----+-----------------------[read_uV]
> +       |
> +       $ (pulldown_ohm)
> +       |
> +      --- (ground)
> +
> + 2. connect = NTC_CONNECTED_POSITIVE, pullup_ohm = 0 (not-connected)
> +
> +   [pullup_uV]
> +       |
> +      [TH]
> +       |
> +       +----------------------------[read_uV]
> +       |
> +       $ (pulldown_ohm)
> +       |
> +      --- (ground)
> +
> + 3. connect = NTC_CONNECTED_GROUND, pulldown_ohm > 0
> +
> +   [pullup_uV]
> +       |
> +       $ (pullup_ohm)
> +       |
> +       +----+-----------------------[read_uV]
> +       |    |
> +      [TH]  $ (pulldown_ohm)
> +       |    |
> +      -------- (ground)
> +
> + 4. connect = NTC_CONNECTED_GROUND, pulldown_ohm = 0 (not-connected)
> +
> +   [pullup_uV]
> +       |
> +       $ (pullup_ohm)
> +       |
> +       +----------------------------[read_uV]
> +       |
> +      [TH]
> +       |
> +      --- (ground)
> +
> +When one of the four circuit models is used, read_uV, pullup_uV,
> pullup_ohm,
> +pulldown_ohm, and connect should be provided. When none of the four models
> +are suitable or the user can get the resistance directly, the user should
> +provide read_ohm and _not_ provide the others.
> +
> +Sysfs Interface
> +---------------
> +name           the mandatory global attribute, the thermistor name.
> +
> +temp1_type     always 4 (thermistor)
> +               RO
> +
> +temp1_input    measure the temperature and provide the measured value.
> +               (reading this file initiates the reading procedure.)
> +               RO
> +
> +Note that each NTC thermistor has only _one_ thermistor; thus, only temp1
> exists.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 16db83c..1e6e8a0 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -767,6 +767,20 @@ config SENSORS_MAX6650
>          This driver can also be built as a module.  If so, the module
>          will be called max6650.
>
> +config SENSORS_NTC_THERMISTOR
> +       tristate "NTC thermistor support"
> +       depends on EXPERIMENTAL
> +       help
> +         This driver supports NTC thermistors sensor reading and its
> +         interpretation. The driver can also monitor the temperature and
> +         send notifications about the temperature.
> +
> +         Currently, this driver supports
> +         NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called ntc-thermistor.
> +
>  config SENSORS_PC87360
>        tristate "National Semiconductor PC87360 family"
>        select HWMON_VID
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 28061cf..e4ab597 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) += max6639.o
>  obj-$(CONFIG_SENSORS_MAX6642)  += max6642.o
>  obj-$(CONFIG_SENSORS_MAX6650)  += max6650.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> +obj-$(CONFIG_SENSORS_NTC_THERMISTOR)   += ntc_thermistor.o
>  obj-$(CONFIG_SENSORS_PC87360)  += pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)  += pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)  += pcf8591.o
> diff --git a/drivers/hwmon/ntc_thermistor.c
> b/drivers/hwmon/ntc_thermistor.c
> new file mode 100644
> index 0000000..d7926f4
> --- /dev/null
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -0,0 +1,453 @@
> +/*
> + * ntc_thermistor.c - NTC Thermistors
> + *
> + *  Copyright (C) 2010 Samsung Electronics
> + *  MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
>  USA
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/math64.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +
> +#include <linux/platform_data/ntc_thermistor.h>
> +
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +struct ntc_compensation {
> +       int             temp_C;
> +       unsigned int    ohm;
> +};
> +
> +/*
> + * A compensation table should be sorted by the values of .ohm
> + * in descending order.
> + * The following compensation tables are from the specification of Murata
> NTC
> + * Thermistors Datasheet
> + */
> +const struct ntc_compensation ncpXXwb473[] = {
> +       { .temp_C       = -40, .ohm     = 1747920 },
> +       { .temp_C       = -35, .ohm     = 1245428 },
> +       { .temp_C       = -30, .ohm     = 898485 },
> +       { .temp_C       = -25, .ohm     = 655802 },
> +       { .temp_C       = -20, .ohm     = 483954 },
> +       { .temp_C       = -15, .ohm     = 360850 },
> +       { .temp_C       = -10, .ohm     = 271697 },
> +       { .temp_C       = -5, .ohm      = 206463 },
> +       { .temp_C       = 0, .ohm       = 158214 },
> +       { .temp_C       = 5, .ohm       = 122259 },
> +       { .temp_C       = 10, .ohm      = 95227 },
> +       { .temp_C       = 15, .ohm      = 74730 },
> +       { .temp_C       = 20, .ohm      = 59065 },
> +       { .temp_C       = 25, .ohm      = 47000 },
> +       { .temp_C       = 30, .ohm      = 37643 },
> +       { .temp_C       = 35, .ohm      = 30334 },
> +       { .temp_C       = 40, .ohm      = 24591 },
> +       { .temp_C       = 45, .ohm      = 20048 },
> +       { .temp_C       = 50, .ohm      = 16433 },
> +       { .temp_C       = 55, .ohm      = 13539 },
> +       { .temp_C       = 60, .ohm      = 11209 },
> +       { .temp_C       = 65, .ohm      = 9328 },
> +       { .temp_C       = 70, .ohm      = 7798 },
> +       { .temp_C       = 75, .ohm      = 6544 },
> +       { .temp_C       = 80, .ohm      = 5518 },
> +       { .temp_C       = 85, .ohm      = 4674 },
> +       { .temp_C       = 90, .ohm      = 3972 },
> +       { .temp_C       = 95, .ohm      = 3388 },
> +       { .temp_C       = 100, .ohm     = 2902 },
> +       { .temp_C       = 105, .ohm     = 2494 },
> +       { .temp_C       = 110, .ohm     = 2150 },
> +       { .temp_C       = 115, .ohm     = 1860 },
> +       { .temp_C       = 120, .ohm     = 1615 },
> +       { .temp_C       = 125, .ohm     = 1406 },
> +};
> +const struct ntc_compensation ncpXXwl333[] = {
> +       { .temp_C       = -40, .ohm     = 1610154 },
> +       { .temp_C       = -35, .ohm     = 1130850 },
> +       { .temp_C       = -30, .ohm     = 802609 },
> +       { .temp_C       = -25, .ohm     = 575385 },
> +       { .temp_C       = -20, .ohm     = 416464 },
> +       { .temp_C       = -15, .ohm     = 304219 },
> +       { .temp_C       = -10, .ohm     = 224193 },
> +       { .temp_C       = -5, .ohm      = 166623 },
> +       { .temp_C       = 0, .ohm       = 124850 },
> +       { .temp_C       = 5, .ohm       = 94287 },
> +       { .temp_C       = 10, .ohm      = 71747 },
> +       { .temp_C       = 15, .ohm      = 54996 },
> +       { .temp_C       = 20, .ohm      = 42455 },
> +       { .temp_C       = 25, .ohm      = 33000 },
> +       { .temp_C       = 30, .ohm      = 25822 },
> +       { .temp_C       = 35, .ohm      = 20335 },
> +       { .temp_C       = 40, .ohm      = 16115 },
> +       { .temp_C       = 45, .ohm      = 12849 },
> +       { .temp_C       = 50, .ohm      = 10306 },
> +       { .temp_C       = 55, .ohm      = 8314 },
> +       { .temp_C       = 60, .ohm      = 6746 },
> +       { .temp_C       = 65, .ohm      = 5503 },
> +       { .temp_C       = 70, .ohm      = 4513 },
> +       { .temp_C       = 75, .ohm      = 3721 },
> +       { .temp_C       = 80, .ohm      = 3084 },
> +       { .temp_C       = 85, .ohm      = 2569 },
> +       { .temp_C       = 90, .ohm      = 2151 },
> +       { .temp_C       = 95, .ohm      = 1809 },
> +       { .temp_C       = 100, .ohm     = 1529 },
> +       { .temp_C       = 105, .ohm     = 1299 },
> +       { .temp_C       = 110, .ohm     = 1108 },
> +       { .temp_C       = 115, .ohm     = 949 },
> +       { .temp_C       = 120, .ohm     = 817 },
> +       { .temp_C       = 125, .ohm     = 707 },
> +};
> +
> +struct ntc_data {
> +       struct device *hwmon_dev;
> +       struct ntc_thermistor_platform_data *pdata;
> +       const struct ntc_compensation *comp;
> +       struct device *dev;
> +       int n_comp;
> +       char name[PLATFORM_NAME_SIZE];
> +};
> +
> +static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
> +{
> +       if (divisor == 0 && dividend == 0)
> +               return 0;
> +       if (divisor == 0)
> +               return UINT_MAX;
> +       return div64_u64(dividend, divisor);
> +}
> +
> +static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
> +               unsigned int uV)
> +{
> +       struct ntc_thermistor_platform_data *pdata = data->pdata;
> +       u64 mV = uV / 1000;
> +       u64 pmV = pdata->pullup_uV / 1000;
> +       u64 N, puO, pdO;
> +       puO = pdata->pullup_ohm;
> +       pdO = pdata->pulldown_ohm;
> +
> +       if (mV == 0) {
> +               if (pdata->connect == NTC_CONNECTED_POSITIVE)
> +                       return UINT_MAX;
> +               return 0;
> +       }
> +       if (mV >= pmV)
> +               return (pdata->connect == NTC_CONNECTED_POSITIVE) ?
> +                       0 : UINT_MAX;
> +
> +       if (pdata->connect == NTC_CONNECTED_POSITIVE && puO == 0)
> +               N = div64_u64_safe(pdO * (pmV - mV), mV);
> +       else if (pdata->connect == NTC_CONNECTED_GROUND && pdO == 0)
> +               N = div64_u64_safe(puO * mV, pmV - mV);
> +       else if (pdata->connect == NTC_CONNECTED_POSITIVE)
> +               N = div64_u64_safe(pdO * puO * (pmV - mV),
> +                               puO * mV - pdO * (pmV - mV));
> +       else
> +               N = div64_u64_safe(pdO * puO * mV, pdO * (pmV - mV) - puO *
> mV);
> +
> +       return (unsigned int) N;
> +}
> +
> +static int lookup_comp(struct ntc_data *data,
> +               unsigned int ohm, int *i_low, int *i_high)
> +{
> +       int start, end, mid = -1;
> +
> +       /* Do a binary search on compensation table */
> +       start = 0;
> +       end = data->n_comp;
> +
> +       while (end > start) {
> +               mid = start + (end - start) / 2;
> +               if (data->comp[mid].ohm < ohm)
> +                       end = mid;
> +               else if (data->comp[mid].ohm > ohm)
> +                       start = mid + 1;
> +               else
> +                       break;
> +       }
> +
> +       if (mid == 0) {
> +               if (data->comp[mid].ohm > ohm) {
> +                       *i_high = mid;
> +                       *i_low = mid + 1;
> +                       return 0;
> +               } else {
> +                       *i_low = mid;
> +                       *i_high = -1;
> +                       return -EINVAL;
> +               }
> +       }
> +       if (mid == (data->n_comp - 1)) {
> +               if (data->comp[mid].ohm <= ohm) {
> +                       *i_low = mid;
> +                       *i_high = mid - 1;
> +                       return 0;
> +               } else {
> +                       *i_low = -1;
> +                       *i_high = mid;
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (data->comp[mid].ohm <= ohm) {
> +               *i_low = mid;
> +               *i_high = mid - 1;
> +       }
> +       if (data->comp[mid].ohm > ohm) {
> +               *i_low = mid + 1;
> +               *i_high = mid;
> +       }
> +
> +       return 0;
> +}
> +
> +static int get_temp_mC(struct ntc_data *data, unsigned int ohm, int *temp)
> +{
> +       int low, high;
> +       int ret;
> +
> +       ret = lookup_comp(data, ohm, &low, &high);
> +       if (ret) {
> +               /* Unable to use linear approximation */
> +               if (low != -1)
> +                       *temp = data->comp[low].temp_C * 1000;
> +               else if (high != -1)
> +                       *temp = data->comp[high].temp_C * 1000;
> +               else
> +                       return ret;
> +       } else {
> +               *temp = data->comp[low].temp_C * 1000 +
> +                       ((data->comp[high].temp_C - data->comp[low].temp_C)
> *
> +                        1000 * ((int)ohm - (int)data->comp[low].ohm)) /
> +                       ((int)data->comp[high].ohm -
> (int)data->comp[low].ohm);
> +       }
> +
> +       return 0;
> +}
> +
> +static int ntc_thermistor_read(struct ntc_data *data, int *temp)
> +{
> +       int ret;
> +       int read_ohm, read_uV;
> +       unsigned int ohm = 0;
> +
> +       if (data->pdata->read_ohm) {
> +               read_ohm = data->pdata->read_ohm();
> +               if (read_ohm < 0)
> +                       return read_ohm;
> +               ohm = (unsigned int)read_ohm;
> +       }
> +
> +       if (data->pdata->read_uV) {
> +               read_uV = data->pdata->read_uV();
> +               if (read_uV < 0)
> +                       return read_uV;
> +               ohm = get_ohm_of_thermistor(data, (unsigned int)read_uV);
> +       }
> +
> +       ret = get_temp_mC(data, ohm, temp);
> +       if (ret) {
> +               dev_dbg(data->dev, "Sensor reading function not
> available.\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static ssize_t ntc_show_name(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct ntc_data *data = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%s\n", data->name);
> +}
> +
> +static ssize_t ntc_show_type(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "4\n");
> +}
> +
> +static ssize_t ntc_show_temp(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct ntc_data *data = dev_get_drvdata(dev);
> +       int temp, ret;
> +
> +       ret = ntc_thermistor_read(data, &temp);
> +       if (ret)
> +               return ret;
> +       return sprintf(buf, "%d\n", temp);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
> +static DEVICE_ATTR(name, S_IRUGO, ntc_show_name, NULL);
> +
> +static struct attribute *ntc_attributes[] = {
> +       &dev_attr_name.attr,
> +       &sensor_dev_attr_temp1_type.dev_attr.attr,
> +       &sensor_dev_attr_temp1_input.dev_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group ntc_attr_group = {
> +       .attrs = ntc_attributes,
> +};
> +
> +static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
> +{
> +       struct ntc_data *data;
> +       struct ntc_thermistor_platform_data *pdata =
> pdev->dev.platform_data;
> +       int ret = 0;
> +
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "No platform init data supplied.\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Either one of the two is required. */
> +       if (!pdata->read_uV && !pdata->read_ohm) {
> +               dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
> +                               "Need either one of the two.\n");
> +               return -EINVAL;
> +       }
> +
> +       if (pdata->read_uV && pdata->read_ohm) {
> +               dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
> +                               "is needed; ignoring read_uV.\n");
> +               pdata->read_uV = NULL;
> +       }
> +
> +       if (pdata->read_uV && (pdata->pullup_uV == 0 ||
> +                               (pdata->pullup_ohm == 0 && pdata->connect
> ==
> +                                NTC_CONNECTED_GROUND) ||
> +                               (pdata->pulldown_ohm == 0 && pdata->connect
> ==
> +                                NTC_CONNECTED_POSITIVE) ||
> +                               (pdata->connect != NTC_CONNECTED_POSITIVE
> &&
> +                                pdata->connect != NTC_CONNECTED_GROUND)))
> {
> +               dev_err(&pdev->dev, "Required data to use read_uV not "
> +                               "supplied.\n");
> +               return -EINVAL;
> +       }
> +
> +       data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->dev = &pdev->dev;
> +       data->pdata = pdata;
> +       strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
> +
> +       switch (pdev->id_entry->driver_data) {
> +       case TYPE_NCPXXWB473:
> +               data->comp = ncpXXwb473;
> +               data->n_comp = ARRAY_SIZE(ncpXXwb473);
> +               break;
> +       case TYPE_NCPXXWL333:
> +               data->comp = ncpXXwl333;
> +               data->n_comp = ARRAY_SIZE(ncpXXwl333);
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
> +                               pdev->id_entry->driver_data,
> +                               pdev->id_entry->name);
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
> +       if (ret) {
> +               dev_err(data->dev, "unable to create sysfs files\n");
> +               goto err;
> +       }
> +
> +       data->hwmon_dev = hwmon_device_register(data->dev);
> +       if (IS_ERR_OR_NULL(data->hwmon_dev)) {
> +               dev_err(data->dev, "unable to register as hwmon
> device.\n");
> +               ret = -EINVAL;
> +               goto err_after_sysfs;
> +       }
> +
> +       dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully
> probed.\n",
> +                       pdev->name, pdev->id, pdev->id_entry->name,
> +                       pdev->id_entry->driver_data);
> +       return 0;
> +err_after_sysfs:
> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
> +err:
> +       kfree(data);
> +       return ret;
> +}
> +
> +static int __devexit ntc_thermistor_remove(struct platform_device *pdev)
> +{
> +       struct ntc_data *data = platform_get_drvdata(pdev);
> +
> +       hwmon_device_unregister(data->hwmon_dev);
> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       kfree(data);
> +
> +       return 0;
> +}
> +
> +static const struct platform_device_id ntc_thermistor_id[] = {
> +       { "ncp15wb473", TYPE_NCPXXWB473 },
> +       { "ncp18wb473", TYPE_NCPXXWB473 },
> +       { "ncp21wb473", TYPE_NCPXXWB473 },
> +       { "ncp03wb473", TYPE_NCPXXWB473 },
> +       { "ncp15wl333", TYPE_NCPXXWL333 },
> +       { },
> +};
> +
> +static struct platform_driver ntc_thermistor_driver = {
> +       .driver = {
> +               .name = "ntc-thermistor",
> +               .owner = THIS_MODULE,
> +       },
> +       .probe = ntc_thermistor_probe,
> +       .remove = __devexit_p(ntc_thermistor_remove),
> +       .id_table = ntc_thermistor_id,
> +};
> +
> +static int __init ntc_thermistor_init(void)
> +{
> +       return platform_driver_register(&ntc_thermistor_driver);
> +}
> +
> +module_init(ntc_thermistor_init);
> +
> +static void __exit ntc_thermistor_cleanup(void)
> +{
> +       platform_driver_unregister(&ntc_thermistor_driver);
> +}
> +
> +module_exit(ntc_thermistor_cleanup);
> +
> +MODULE_DESCRIPTION("NTC Thermistor Driver");
> +MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ntc-thermistor");
> diff --git a/include/linux/platform_data/ntc_thermistor.h
> b/include/linux/platform_data/ntc_thermistor.h
> new file mode 100644
> index 0000000..abd2862
> --- /dev/null
> +++ b/include/linux/platform_data/ntc_thermistor.h
> @@ -0,0 +1,53 @@
> +/*
> + * ntc_thermistor.h - NTC Thermistors
> + *
> + *  Copyright (C) 2010 Samsung Electronics
> + *  MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
>  USA
> + */
> +#ifndef _LINUX_NTC_H
> +#define _LINUX_NTC_H
> +
> +enum ntc_thermistor_type {
> +       TYPE_NCPXXWB473,
> +       TYPE_NCPXXWL333,
> +};
> +
> +struct ntc_thermistor_platform_data {
> +       /*
> +        * One (not both) of read_uV and read_ohm should be provided and
> only
> +        * one of the two should be provided.
> +        * Both functions should return negative value for an error case.
> +        *
> +        * pullup_uV, pullup_ohm, pulldown_ohm, and connect are required to
> use
> +        * read_uV()
> +        *
> +        * How to setup pullup_ohm, pulldown_ohm, and connect is
> +        * described at Documentation/hwmon/ntc
> +        *
> +        * pullup/down_ohm: 0 for infinite / not-connected
> +        */
> +       int (*read_uV)(void);
> +       unsigned int pullup_uV;
> +
> +       unsigned int pullup_ohm;
> +       unsigned int pulldown_ohm;
> +       enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect;
> +
> +       int (*read_ohm)(void);
> +};
> +
> +#endif /* _LINUX_NTC_H */
> --
> 1.7.4.1
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--000325558342e437c204a6326179
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jun 20, 2011 at 1:18 PM, Donggeu=
n Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:dg77.kim@samsung.com">dg77.ki=
m@samsung.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
This patch adds support for NTC Thermistor series. In this release, the<br>
following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,<br=
>
and NCP15WL333. This driver is based on the datasheet of MURATA.<br>
<br>
The driver in the patch does conversion from the raw ADC value<br>
(either voltage or resistence) to temperature. In order to use<br>
voltage values as input, the circuit schematics should be provided<br>
with the platform data. A compensation table for each type of thermistor<br=
>
is provided for the conversion.<br>
<br>
Signed-off-by: Donggeun Kim &lt;<a href=3D"mailto:dg77.kim@samsung.com">dg7=
7.kim@samsung.com</a>&gt;<br>
Signed-off-by: MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com"=
>myungjoo.ham@samsung.com</a>&gt;<br>
Signed-off-by: KyungMin Park &lt;<a href=3D"mailto:kyungmin.park@samsung.co=
m">kyungmin.park@samsung.com</a>&gt;<br>
<br></blockquote><div>Looks good feel free to add <br>my reviewed by : Shub=
hrajyoti D &lt;<a href=3D"mailto:shubhrajyoti@ti.com">shubhrajyoti@ti.com</=
a> &gt; <br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0p=
t 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"=
>

--<br>
Updates<br>
v10<br>
- return error code passed from function of platform data<br>
v9<br>
- remove unnecessary variables(mintemp, maxtemp) and checking lines for the=
m<br>
v8<br>
- remove compiler warning message<br>
- update Documentation/hwmon/ntc_thermistor<br>
- add EXPERIMENTAL Kconfig dependency<br>
v7<br>
- move header file location<br>
- rename header and driver file<br>
- style fixes<br>
v6<br>
- updated Documentation/hwmon/ntc<br>
- style fixes<br>
v5<br>
- use binary search on sorted table<br>
- removed unnecessary attributes<br>
- style fixes<br>
v4<br>
- put in alphabetic order in Kconfig/Makefile<br>
- handle additional error cases<br>
- remove the exported function<br>
v3<br>
- style fixes<br>
- removed symbol exports<br>
- avoid divide-by-zero<br>
- omitted files added (Kconfig/Makefile)<br>
- removed unnecessary codes<br>
- return error values, not default values for errors.<br>
v2<br>
- added Documentation/hwmon/ntc<br>
- followed hwmon sysfs<br>
- detached the monitoring service<br>
(thank you for the comments, Guenter Roeck)<br>
---<br>
=A0Documentation/hwmon/ntc_thermistor =A0 =A0 =A0 =A0 =A0 | =A0 93 ++++++<b=
r>
=A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 14 +<br>
=A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +<br>
=A0drivers/hwmon/ntc_thermistor.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0453 ++++=
++++++++++++++++++++++<br>
=A0include/linux/platform_data/ntc_thermistor.h | =A0 53 +++<br>
=A05 files changed, 614 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 Documentation/hwmon/ntc_thermistor<br>
=A0create mode 100644 drivers/hwmon/ntc_thermistor.c<br>
=A0create mode 100644 include/linux/platform_data/ntc_thermistor.h<br>
<br>
diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_t=
hermistor<br>
new file mode 100644<br>
index 0000000..3bfda94<br>
--- /dev/null<br>
+++ b/Documentation/hwmon/ntc_thermistor<br>
@@ -0,0 +1,93 @@<br>
+Kernel driver ntc_thermistor<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+Supported thermistors:<br>
+* Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, N=
CP15WL333<br>
+ =A0Prefixes: &#39;ncp15wb473&#39;, &#39;ncp18wb473&#39;, &#39;ncp21wb473&=
#39;, &#39;ncp03wb473&#39;, &#39;ncp15wl333&#39;<br>
+ =A0Datasheet: Publicly available at Murata<br>
+<br>
+Other NTC thermistors can be supported simply by adding compensation<br>
+tables; e.g., NCP15WL333 support is added by the table ncpXXwl333.<br>
+<br>
+Authors:<br>
+ =A0 =A0 =A0 MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com">=
myungjoo.ham@samsung.com</a>&gt;<br>
+<br>
+Description<br>
+-----------<br>
+<br>
+The NTC thermistor is a simple thermistor that requires users to provide t=
he<br>
+resistance and lookup the corresponding compensation table to get the<br>
+temperature input.<br>
+<br>
+The NTC driver provides lookup tables with a linear approximation function=
<br>
+and four circuit models with an option not to use any of the four models.<=
br>
+<br>
+The four circuit models provided are:<br>
+<br>
+ =A0 =A0 =A0 $: resister, [TH]: the thermistor<br>
+<br>
+ 1. connect =3D NTC_CONNECTED_POSITIVE, pullup_ohm &gt; 0<br>
+<br>
+ =A0 [pullup_uV]<br>
+ =A0 =A0 =A0 | =A0 =A0|<br>
+ =A0 =A0 =A0[TH] =A0$ (pullup_ohm)<br>
+ =A0 =A0 =A0 | =A0 =A0|<br>
+ =A0 =A0 =A0 +----+-----------------------[read_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 $ (pulldown_ohm)<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0--- (ground)<br>
+<br>
+ 2. connect =3D NTC_CONNECTED_POSITIVE, pullup_ohm =3D 0 (not-connected)<b=
r>
+<br>
+ =A0 [pullup_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0[TH]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 +----------------------------[read_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 $ (pulldown_ohm)<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0--- (ground)<br>
+<br>
+ 3. connect =3D NTC_CONNECTED_GROUND, pulldown_ohm &gt; 0<br>
+<br>
+ =A0 [pullup_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 $ (pullup_ohm)<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 +----+-----------------------[read_uV]<br>
+ =A0 =A0 =A0 | =A0 =A0|<br>
+ =A0 =A0 =A0[TH] =A0$ (pulldown_ohm)<br>
+ =A0 =A0 =A0 | =A0 =A0|<br>
+ =A0 =A0 =A0-------- (ground)<br>
+<br>
+ 4. connect =3D NTC_CONNECTED_GROUND, pulldown_ohm =3D 0 (not-connected)<b=
r>
+<br>
+ =A0 [pullup_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 $ (pullup_ohm)<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0 +----------------------------[read_uV]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0[TH]<br>
+ =A0 =A0 =A0 |<br>
+ =A0 =A0 =A0--- (ground)<br>
+<br>
+When one of the four circuit models is used, read_uV, pullup_uV, pullup_oh=
m,<br>
+pulldown_ohm, and connect should be provided. When none of the four models=
<br>
+are suitable or the user can get the resistance directly, the user should<=
br>
+provide read_ohm and _not_ provide the others.<br>
+<br>
+Sysfs Interface<br>
+---------------<br>
+name =A0 =A0 =A0 =A0 =A0 the mandatory global attribute, the thermistor na=
me.<br>
+<br>
+temp1_type =A0 =A0 always 4 (thermistor)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 RO<br>
+<br>
+temp1_input =A0 =A0measure the temperature and provide the measured value.=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (reading this file initiates the reading proc=
edure.)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 RO<br>
+<br>
+Note that each NTC thermistor has only _one_ thermistor; thus, only temp1 =
exists.<br>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<br>
index 16db83c..1e6e8a0 100644<br>
--- a/drivers/hwmon/Kconfig<br>
+++ b/drivers/hwmon/Kconfig<br>
@@ -767,6 +767,20 @@ config SENSORS_MAX6650<br>
 =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, th=
e module<br>
 =A0 =A0 =A0 =A0 =A0will be called max6650.<br>
<br>
+config SENSORS_NTC_THERMISTOR<br>
+ =A0 =A0 =A0 tristate &quot;NTC thermistor support&quot;<br>
+ =A0 =A0 =A0 depends on EXPERIMENTAL<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0 This driver supports NTC thermistors sensor reading and i=
ts<br>
+ =A0 =A0 =A0 =A0 interpretation. The driver can also monitor the temperatu=
re and<br>
+ =A0 =A0 =A0 =A0 send notifications about the temperature.<br>
+<br>
+ =A0 =A0 =A0 =A0 Currently, this driver supports<br>
+ =A0 =A0 =A0 =A0 NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15=
WL333.<br>
+<br>
+ =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the =
module<br>
+ =A0 =A0 =A0 =A0 will be called ntc-thermistor.<br>
+<br>
=A0config SENSORS_PC87360<br>
 =A0 =A0 =A0 =A0tristate &quot;National Semiconductor PC87360 family&quot;<=
br>
 =A0 =A0 =A0 =A0select HWMON_VID<br>
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile<br>
index 28061cf..e4ab597 100644<br>
--- a/drivers/hwmon/Makefile<br>
+++ b/drivers/hwmon/Makefile<br>
@@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) +=3D max6639.o<br>
=A0obj-$(CONFIG_SENSORS_MAX6642) =A0+=3D max6642.o<br>
=A0obj-$(CONFIG_SENSORS_MAX6650) =A0+=3D max6650.o<br>
=A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o<br>
+obj-$(CONFIG_SENSORS_NTC_THERMISTOR) =A0 +=3D ntc_thermistor.o<br>
=A0obj-$(CONFIG_SENSORS_PC87360) =A0+=3D pc87360.o<br>
=A0obj-$(CONFIG_SENSORS_PC87427) =A0+=3D pc87427.o<br>
=A0obj-$(CONFIG_SENSORS_PCF8591) =A0+=3D pcf8591.o<br>
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.=
c<br>
new file mode 100644<br>
index 0000000..d7926f4<br>
--- /dev/null<br>
+++ b/drivers/hwmon/ntc_thermistor.c<br>
@@ -0,0 +1,453 @@<br>
+/*<br>
+ * ntc_thermistor.c - NTC Thermistors<br>
+ *<br>
+ * =A0Copyright (C) 2010 Samsung Electronics<br>
+ * =A0MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com">myungjo=
o.ham@samsung.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-1307 =
=A0USA<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
+#include &lt;linux/math64.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+<br>
+#include &lt;linux/platform_data/ntc_thermistor.h&gt;<br>
+<br>
+#include &lt;linux/hwmon.h&gt;<br>
+#include &lt;linux/hwmon-sysfs.h&gt;<br>
+<br>
+struct ntc_compensation {<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 temp_C;<br>
+ =A0 =A0 =A0 unsigned int =A0 =A0ohm;<br>
+};<br>
+<br>
+/*<br>
+ * A compensation table should be sorted by the values of .ohm<br>
+ * in descending order.<br>
+ * The following compensation tables are from the specification of Murata =
NTC<br>
+ * Thermistors Datasheet<br>
+ */<br>
+const struct ntc_compensation ncpXXwb473[] =3D {<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -40, .ohm =A0 =A0 =3D 1747920 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -35, .ohm =A0 =A0 =3D 1245428 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -30, .ohm =A0 =A0 =3D 898485 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -25, .ohm =A0 =A0 =3D 655802 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -20, .ohm =A0 =A0 =3D 483954 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -15, .ohm =A0 =A0 =3D 360850 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -10, .ohm =A0 =A0 =3D 271697 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -5, .ohm =A0 =A0 =A0=3D 206463 },<b=
r>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 0, .ohm =A0 =A0 =A0 =3D 158214 },<b=
r>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 5, .ohm =A0 =A0 =A0 =3D 122259 },<b=
r>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 10, .ohm =A0 =A0 =A0=3D 95227 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 15, .ohm =A0 =A0 =A0=3D 74730 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 20, .ohm =A0 =A0 =A0=3D 59065 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 25, .ohm =A0 =A0 =A0=3D 47000 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 30, .ohm =A0 =A0 =A0=3D 37643 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 35, .ohm =A0 =A0 =A0=3D 30334 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 40, .ohm =A0 =A0 =A0=3D 24591 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 45, .ohm =A0 =A0 =A0=3D 20048 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 50, .ohm =A0 =A0 =A0=3D 16433 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 55, .ohm =A0 =A0 =A0=3D 13539 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 60, .ohm =A0 =A0 =A0=3D 11209 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 65, .ohm =A0 =A0 =A0=3D 9328 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 70, .ohm =A0 =A0 =A0=3D 7798 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 75, .ohm =A0 =A0 =A0=3D 6544 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 80, .ohm =A0 =A0 =A0=3D 5518 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 85, .ohm =A0 =A0 =A0=3D 4674 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 90, .ohm =A0 =A0 =A0=3D 3972 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 95, .ohm =A0 =A0 =A0=3D 3388 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 100, .ohm =A0 =A0 =3D 2902 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 105, .ohm =A0 =A0 =3D 2494 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 110, .ohm =A0 =A0 =3D 2150 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 115, .ohm =A0 =A0 =3D 1860 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 120, .ohm =A0 =A0 =3D 1615 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 125, .ohm =A0 =A0 =3D 1406 },<br>
+};<br>
+const struct ntc_compensation ncpXXwl333[] =3D {<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -40, .ohm =A0 =A0 =3D 1610154 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -35, .ohm =A0 =A0 =3D 1130850 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -30, .ohm =A0 =A0 =3D 802609 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -25, .ohm =A0 =A0 =3D 575385 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -20, .ohm =A0 =A0 =3D 416464 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -15, .ohm =A0 =A0 =3D 304219 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -10, .ohm =A0 =A0 =3D 224193 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D -5, .ohm =A0 =A0 =A0=3D 166623 },<b=
r>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 0, .ohm =A0 =A0 =A0 =3D 124850 },<b=
r>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 5, .ohm =A0 =A0 =A0 =3D 94287 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 10, .ohm =A0 =A0 =A0=3D 71747 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 15, .ohm =A0 =A0 =A0=3D 54996 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 20, .ohm =A0 =A0 =A0=3D 42455 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 25, .ohm =A0 =A0 =A0=3D 33000 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 30, .ohm =A0 =A0 =A0=3D 25822 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 35, .ohm =A0 =A0 =A0=3D 20335 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 40, .ohm =A0 =A0 =A0=3D 16115 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 45, .ohm =A0 =A0 =A0=3D 12849 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 50, .ohm =A0 =A0 =A0=3D 10306 },<br=
>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 55, .ohm =A0 =A0 =A0=3D 8314 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 60, .ohm =A0 =A0 =A0=3D 6746 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 65, .ohm =A0 =A0 =A0=3D 5503 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 70, .ohm =A0 =A0 =A0=3D 4513 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 75, .ohm =A0 =A0 =A0=3D 3721 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 80, .ohm =A0 =A0 =A0=3D 3084 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 85, .ohm =A0 =A0 =A0=3D 2569 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 90, .ohm =A0 =A0 =A0=3D 2151 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 95, .ohm =A0 =A0 =A0=3D 1809 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 100, .ohm =A0 =A0 =3D 1529 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 105, .ohm =A0 =A0 =3D 1299 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 110, .ohm =A0 =A0 =3D 1108 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 115, .ohm =A0 =A0 =3D 949 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 120, .ohm =A0 =A0 =3D 817 },<br>
+ =A0 =A0 =A0 { .temp_C =A0 =A0 =A0 =3D 125, .ohm =A0 =A0 =3D 707 },<br>
+};<br>
+<br>
+struct ntc_data {<br>
+ =A0 =A0 =A0 struct device *hwmon_dev;<br>
+ =A0 =A0 =A0 struct ntc_thermistor_platform_data *pdata;<br>
+ =A0 =A0 =A0 const struct ntc_compensation *comp;<br>
+ =A0 =A0 =A0 struct device *dev;<br>
+ =A0 =A0 =A0 int n_comp;<br>
+ =A0 =A0 =A0 char name[PLATFORM_NAME_SIZE];<br>
+};<br>
+<br>
+static inline u64 div64_u64_safe(u64 dividend, u64 divisor)<br>
+{<br>
+ =A0 =A0 =A0 if (divisor =3D=3D 0 &amp;&amp; dividend =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 if (divisor =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return UINT_MAX;<br>
+ =A0 =A0 =A0 return div64_u64(dividend, divisor);<br>
+}<br>
+<br>
+static unsigned int get_ohm_of_thermistor(struct ntc_data *data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int uV)<br>
+{<br>
+ =A0 =A0 =A0 struct ntc_thermistor_platform_data *pdata =3D data-&gt;pdata=
;<br>
+ =A0 =A0 =A0 u64 mV =3D uV / 1000;<br>
+ =A0 =A0 =A0 u64 pmV =3D pdata-&gt;pullup_uV / 1000;<br>
+ =A0 =A0 =A0 u64 N, puO, pdO;<br>
+ =A0 =A0 =A0 puO =3D pdata-&gt;pullup_ohm;<br>
+ =A0 =A0 =A0 pdO =3D pdata-&gt;pulldown_ohm;<br>
+<br>
+ =A0 =A0 =A0 if (mV =3D=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata-&gt;connect =3D=3D NTC_CONNECTED_PO=
SITIVE)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return UINT_MAX;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (mV &gt;=3D pmV)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (pdata-&gt;connect =3D=3D NTC_CONNECTE=
D_POSITIVE) ?<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 : UINT_MAX;<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;connect =3D=3D NTC_CONNECTED_POSITIVE &amp;&amp=
; puO =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 N =3D div64_u64_safe(pdO * (pmV - mV), mV);<b=
r>
+ =A0 =A0 =A0 else if (pdata-&gt;connect =3D=3D NTC_CONNECTED_GROUND &amp;&=
amp; pdO =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 N =3D div64_u64_safe(puO * mV, pmV - mV);<br>
+ =A0 =A0 =A0 else if (pdata-&gt;connect =3D=3D NTC_CONNECTED_POSITIVE)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 N =3D div64_u64_safe(pdO * puO * (pmV - mV),<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 puO * mV - pd=
O * (pmV - mV));<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 N =3D div64_u64_safe(pdO * puO * mV, pdO * (p=
mV - mV) - puO * mV);<br>
+<br>
+ =A0 =A0 =A0 return (unsigned int) N;<br>
+}<br>
+<br>
+static int lookup_comp(struct ntc_data *data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ohm, int *i_low, int *i_high)<br=
>
+{<br>
+ =A0 =A0 =A0 int start, end, mid =3D -1;<br>
+<br>
+ =A0 =A0 =A0 /* Do a binary search on compensation table */<br>
+ =A0 =A0 =A0 start =3D 0;<br>
+ =A0 =A0 =A0 end =3D data-&gt;n_comp;<br>
+<br>
+ =A0 =A0 =A0 while (end &gt; start) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D start + (end - start) / 2;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;comp[mid].ohm &lt; ohm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (data-&gt;comp[mid].ohm &gt; ohm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D mid + 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (mid =3D=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;comp[mid].ohm &gt; ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D mid + 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D -1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (mid =3D=3D (data-&gt;n_comp - 1)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;comp[mid].ohm &lt;=3D ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D mid - 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D -1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;comp[mid].ohm &lt;=3D ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D mid;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D mid - 1;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (data-&gt;comp[mid].ohm &gt; ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_low =3D mid + 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *i_high =3D mid;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int get_temp_mC(struct ntc_data *data, unsigned int ohm, int *temp)=
<br>
+{<br>
+ =A0 =A0 =A0 int low, high;<br>
+ =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 ret =3D lookup_comp(data, ohm, &amp;low, &amp;high);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unable to use linear approximation */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (low !=3D -1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D data-&gt;comp[low].=
temp_C * 1000;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (high !=3D -1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D data-&gt;comp[high]=
.temp_C * 1000;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *temp =3D data-&gt;comp[low].temp_C * 1000 +<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((data-&gt;comp[high].temp_C =
- data-&gt;comp[low].temp_C) *<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01000 * ((int)ohm - (int)da=
ta-&gt;comp[low].ohm)) /<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((int)data-&gt;comp[high].ohm=
 - (int)data-&gt;comp[low].ohm);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int ntc_thermistor_read(struct ntc_data *data, int *temp)<br>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 int read_ohm, read_uV;<br>
+ =A0 =A0 =A0 unsigned int ohm =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_ohm =3D data-&gt;pdata-&gt;read_ohm();<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read_ohm &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return read_ohm;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohm =3D (unsigned int)read_ohm;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;pdata-&gt;read_uV) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_uV =3D data-&gt;pdata-&gt;read_uV();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read_uV &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return read_uV;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohm =3D get_ohm_of_thermistor(data, (unsigned=
 int)read_uV);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D get_temp_mC(data, ohm, temp);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;dev, &quot;Sensor reading fu=
nction not available.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static ssize_t ntc_show_name(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data =3D dev_get_drvdata(dev);<br>
+<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%s\n&quot;, data-&gt;name);<br>
+}<br>
+<br>
+static ssize_t ntc_show_type(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;4\n&quot;);<br>
+}<br>
+<br>
+static ssize_t ntc_show_temp(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 int temp, ret;<br>
+<br>
+ =A0 =A0 =A0 ret =3D ntc_thermistor_read(data, &amp;temp);<br>
+ =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, temp);<br>
+}<br>
+<br>
+static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);<br=
>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);<b=
r>
+static DEVICE_ATTR(name, S_IRUGO, ntc_show_name, NULL);<br>
+<br>
+static struct attribute *ntc_attributes[] =3D {<br>
+ =A0 =A0 =A0 &amp;dev_attr_name.attr,<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_type.dev_attr.attr,<br>
+ =A0 =A0 =A0 &amp;sensor_dev_attr_temp1_input.dev_attr.attr,<br>
+ =A0 =A0 =A0 NULL,<br>
+};<br>
+<br>
+static const struct attribute_group ntc_attr_group =3D {<br>
+ =A0 =A0 =A0 .attrs =3D ntc_attributes,<br>
+};<br>
+<br>
+static int __devinit ntc_thermistor_probe(struct platform_device *pdev)<br=
>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data;<br>
+ =A0 =A0 =A0 struct ntc_thermistor_platform_data *pdata =3D pdev-&gt;dev.p=
latform_data;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (!pdata) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;No platform =
init data supplied.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Either one of the two is required. */<br>
+ =A0 =A0 =A0 if (!pdata-&gt;read_uV &amp;&amp; !pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Both read_uV=
 and read_ohm missing.&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Need ei=
ther one of the two.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;read_uV &amp;&amp; pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&amp;pdev-&gt;dev, &quot;Only one of=
 read_uV and read_ohm &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;is need=
ed; ignoring read_uV.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata-&gt;read_uV =3D NULL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;read_uV &amp;&amp; (pdata-&gt;pullup_uV =3D=3D =
0 ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;pu=
llup_ohm =3D=3D 0 &amp;&amp; pdata-&gt;connect =3D=3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NTC_CONNEC=
TED_GROUND) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;pu=
lldown_ohm =3D=3D 0 &amp;&amp; pdata-&gt;connect =3D=3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NTC_CONNEC=
TED_POSITIVE) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;co=
nnect !=3D NTC_CONNECTED_POSITIVE &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata-&gt;=
connect !=3D NTC_CONNECTED_GROUND))) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Required dat=
a to use read_uV not &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;supplie=
d.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 data =3D kzalloc(sizeof(struct ntc_data), GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!data)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 data-&gt;dev =3D &amp;pdev-&gt;dev;<br>
+ =A0 =A0 =A0 data-&gt;pdata =3D pdata;<br>
+ =A0 =A0 =A0 strncpy(data-&gt;name, pdev-&gt;id_entry-&gt;name, PLATFORM_N=
AME_SIZE);<br>
+<br>
+ =A0 =A0 =A0 switch (pdev-&gt;id_entry-&gt;driver_data) {<br>
+ =A0 =A0 =A0 case TYPE_NCPXXWB473:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;comp =3D ncpXXwb473;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;n_comp =3D ARRAY_SIZE(ncpXXwb473);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case TYPE_NCPXXWL333:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;comp =3D ncpXXwl333;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;n_comp =3D ARRAY_SIZE(ncpXXwl333);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Unknown devi=
ce type: %lu(%s)\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_e=
ntry-&gt;driver_data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_e=
ntry-&gt;name);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, data);<br>
+<br>
+ =A0 =A0 =A0 ret =3D sysfs_create_group(&amp;data-&gt;dev-&gt;kobj, &amp;n=
tc_attr_group);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;dev, &quot;unable to create =
sysfs files\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 data-&gt;hwmon_dev =3D hwmon_device_register(data-&gt;dev);<b=
r>
+ =A0 =A0 =A0 if (IS_ERR_OR_NULL(data-&gt;hwmon_dev)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;dev, &quot;unable to registe=
r as hwmon device.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_after_sysfs;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 dev_info(&amp;pdev-&gt;dev, &quot;Thermistor %s:%d (type: %s/=
%lu) successfully probed.\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;name, pdev-&gt;id, p=
dev-&gt;id_entry-&gt;name,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_entry-&gt;driver_=
data);<br>
+ =A0 =A0 =A0 return 0;<br>
+err_after_sysfs:<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;data-&gt;dev-&gt;kobj, &amp;ntc_attr_=
group);<br>
+err:<br>
+ =A0 =A0 =A0 kfree(data);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int __devexit ntc_thermistor_remove(struct platform_device *pdev)<b=
r>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data =3D platform_get_drvdata(pdev);<br>
+<br>
+ =A0 =A0 =A0 hwmon_device_unregister(data-&gt;hwmon_dev);<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;data-&gt;dev-&gt;kobj, &amp;ntc_attr_=
group);<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);<br>
+<br>
+ =A0 =A0 =A0 kfree(data);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static const struct platform_device_id ntc_thermistor_id[] =3D {<br>
+ =A0 =A0 =A0 { &quot;ncp15wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp18wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp21wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp03wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp15wl333&quot;, TYPE_NCPXXWL333 },<br>
+ =A0 =A0 =A0 { },<br>
+};<br>
+<br>
+static struct platform_driver ntc_thermistor_driver =3D {<br>
+ =A0 =A0 =A0 .driver =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D &quot;ntc-thermistor&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 .probe =3D ntc_thermistor_probe,<br>
+ =A0 =A0 =A0 .remove =3D __devexit_p(ntc_thermistor_remove),<br>
+ =A0 =A0 =A0 .id_table =3D ntc_thermistor_id,<br>
+};<br>
+<br>
+static int __init ntc_thermistor_init(void)<br>
+{<br>
+ =A0 =A0 =A0 return platform_driver_register(&amp;ntc_thermistor_driver);<=
br>
+}<br>
+<br>
+module_init(ntc_thermistor_init);<br>
+<br>
+static void __exit ntc_thermistor_cleanup(void)<br>
+{<br>
+ =A0 =A0 =A0 platform_driver_unregister(&amp;ntc_thermistor_driver);<br>
+}<br>
+<br>
+module_exit(ntc_thermistor_cleanup);<br>
+<br>
+MODULE_DESCRIPTION(&quot;NTC Thermistor Driver&quot;);<br>
+MODULE_AUTHOR(&quot;MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsun=
g.com">myungjoo.ham@samsung.com</a>&gt;&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_ALIAS(&quot;platform:ntc-thermistor&quot;);<br>
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/p=
latform_data/ntc_thermistor.h<br>
new file mode 100644<br>
index 0000000..abd2862<br>
--- /dev/null<br>
+++ b/include/linux/platform_data/ntc_thermistor.h<br>
@@ -0,0 +1,53 @@<br>
+/*<br>
+ * ntc_thermistor.h - NTC Thermistors<br>
+ *<br>
+ * =A0Copyright (C) 2010 Samsung Electronics<br>
+ * =A0MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com">myungjo=
o.ham@samsung.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-1307 =
=A0USA<br>
+ */<br>
+#ifndef _LINUX_NTC_H<br>
+#define _LINUX_NTC_H<br>
+<br>
+enum ntc_thermistor_type {<br>
+ =A0 =A0 =A0 TYPE_NCPXXWB473,<br>
+ =A0 =A0 =A0 TYPE_NCPXXWL333,<br>
+};<br>
+<br>
+struct ntc_thermistor_platform_data {<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* One (not both) of read_uV and read_ohm should be provide=
d and only<br>
+ =A0 =A0 =A0 =A0* one of the two should be provided.<br>
+ =A0 =A0 =A0 =A0* Both functions should return negative value for an error=
 case.<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* pullup_uV, pullup_ohm, pulldown_ohm, and connect are req=
uired to use<br>
+ =A0 =A0 =A0 =A0* read_uV()<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* How to setup pullup_ohm, pulldown_ohm, and connect is<br=
>
+ =A0 =A0 =A0 =A0* described at Documentation/hwmon/ntc<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* pullup/down_ohm: 0 for infinite / not-connected<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 int (*read_uV)(void);<br>
+ =A0 =A0 =A0 unsigned int pullup_uV;<br>
+<br>
+ =A0 =A0 =A0 unsigned int pullup_ohm;<br>
+ =A0 =A0 =A0 unsigned int pulldown_ohm;<br>
+ =A0 =A0 =A0 enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect=
;<br>
+<br>
+ =A0 =A0 =A0 int (*read_ohm)(void);<br>
+};<br>
+<br>
+#endif /* _LINUX_NTC_H */<br>
<font color=3D"#888888">--<br>
1.7.4.1<br>
<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</font></blockquote></div><br>

--000325558342e437c204a6326179--


--===============6750463226802066989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6750463226802066989==--
