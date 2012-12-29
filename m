From: Chris Verges <kg4ysn@gmail.com>
Date: Sat, 29 Dec 2012 08:58:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' and 'alarm' attributes
Message-Id: <CAG4_upSp=Ddt4urbBaayst7+kC6cEfuHvYsfTkSvWgErXYc9Dw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 29, 2012 at 12:56 AM, Chris Verges <kg4ysn@gmail.com> wrote:
> *snip*

I was able to test the 'update_interval' attribute fully, but was only
able to partially test the alarm-related attributes.  If anyone else
has an lm73 with access to the ALERT pin and can do live testing,
feedback would be outstanding.

Thanks,
Chris


> The LM73 supports four A/D conversion resolutions.  The default used by
> the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
> This patch enables changing of this resolution from userspace via the
> temp1_update_interval attribute.
>
> The LM73 also supports a basic over-temperature indicator.  When the
> measured temperature goes above the high temperature limit, temp1_max,
> the alarm is triggered.  When it drops below the low temperature limit,
> temp1_min, the alarm is ended.
>
> Full details on use of these mechanisms are described in
> Documentation/hwmon/lm73.
>
> Signed-off-by: Chris Verges <kg4ysn@gmail.com>
> ---
>  Documentation/hwmon/lm73           |  108 +++++++++++++++
>  drivers/hwmon/lm73.c               |  263 +++++++++++++++++++++++++++++++++++-
>  include/linux/platform_data/lm73.h |   38 ++++++
>  3 files changed, 405 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/hwmon/lm73
>  create mode 100644 include/linux/platform_data/lm73.h
>
> diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
> new file mode 100644
> index 0000000..24dfd8a
> --- /dev/null
> +++ b/Documentation/hwmon/lm73
> @@ -0,0 +1,108 @@
> +Kernel driver lm73
> +=========
> +
> +Supported chips:
> +  * Texas Instruments LM73
> +    Prefix: 'lm73'
> +    Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4c, 0x4d, and 0x4e
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/product/lm73
> +
> +Author: Chris Verges <kg4ysn@gmail.com>
> +
> +
> +Description
> +-----------
> +
> +The LM73 is a digital temperature sensor.  All temperature values are
> +given in degrees Celsius.
> +
> +Measurement Resolution Support
> +------------------------------
> +
> +The LM73 supports four resolutions, defined in terms of degrees C per
> +LSB: 0.25, 0.125, 0.0625, and 0.3125.  Changing the resolution mode
> +affects the conversion time of the LM73's analog-to-digital converter.
> +From userspace, the desired resolution can be specified as a function of
> +conversion time via the 'update_interval' sysfs attribute for the
> +device.  This attribute will normalize ranges of input values to the
> +maximum times defined for the resolution in the datasheet.
> +
> +    Resolution    Conv. Time    Input Range
> +    (C/LSB)       (msec)        (msec)
> +    --------------------------------------
> +    0.25          14             0..21
> +    0.125         28            22..42
> +    0.0625        56            43..84
> +    0.03125       112           85..infinity
> +    --------------------------------------
> +
> +The following examples show how the 'update_interval' attribute can be
> +used to change the conversion time:
> +
> +    $ echo 0 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    14
> +    $ cat temp1_input
> +    24250
> +
> +    $ echo 36 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    28
> +    $ cat temp1_input
> +    24125
> +
> +    $ echo 56 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    56
> +    $ cat temp1_input
> +    24062
> +
> +    $ echo 85 > temp1_update_interval
> +    $ cat temp1_update_interval
> +    112
> +    $ cat temp1_input
> +    24031
> +
> +As shown here, the lm73 driver automatically adjusts any user input for
> +'update_interval' via a step function.  Reading back the
> +'update_interval' value after a write operation will confirm the
> +conversion time actively in use.
> +
> +Mathematically, the resolution can be derived from the conversion time
> +via the following function:
> +
> +   g(x) = 0.250 * [log(x/14) / log(2)]
> +
> +where 'x' is the output from 'update_interval' and 'g(x)' is the
> +resolution in degrees C per LSB.
> +
> +Alarm Support
> +-------------
> +
> +The LM73 features a simple over-temperature alarm mechanism.  This
> +feature is exposed via the sysfs attributes and (optionally) via
> +platform device interrupt handling hooks.
> +
> +The primary attribute is 'temp1_alarm.'  When the measured temperature
> +exceeds the value stored in 'temp1_max', the alarm triggers.  When the
> +measured temperature drops below the value stored in 'temp1_min', the
> +alarm is cleared.  The alarm can also be cleared by writing a '0' to the
> +'temp1_alarm' attribute.
> +
> +The attributes 'temp1_max_alarm' and 'temp1_min_alarm' are flags
> +provided by the LM73 that indicate whether the measured temperature has
> +passed the 'temp1_max' and 'temp1_min' thresholds, respectively.  These
> +values _must_ be read to clear the registers on the LM73.
> +
> +If the lm73 driver is provided a struct lm73_platform_data during
> +initialization, interrupt handling is enabled.  The platform must define
> +the IRQ number and IRQ flags at a minimum, and can optionally also
> +define a callback function to supplement the IRQ handler provided by the
> +lm73 driver.  This internal IRQ handler enables use of epoll() on the
> +'temp1_alarm' attribute via the sysfs_notify() method.
> +
> +Finally, the LM73 can set the polarity of the ALERT interrupt to either
> +active-high or active-low (default).  If the platform desired the
> +polarity to be switched to active-high, it can declare this in the
> +struct lm73_platform_data used during initialization.
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 7272176..4acb0e2 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -20,7 +20,8 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
> -
> +#include <linux/interrupt.h>
> +#include <linux/platform_data/lm73.h>
>
>  /* Addresses scanned */
>  static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
> @@ -39,8 +40,91 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  #define LM73_TEMP_MIN          (-40)
>  #define LM73_TEMP_MAX          150
>
> +#define LM73_CTRL_RES_SHIFT    5
> +#define LM73_CTRL_RES_SIZE     2
> +#define LM73_CTRL_RES_MASK \
> +       (((1 << LM73_CTRL_RES_SIZE) - 1) << LM73_CTRL_RES_SHIFT)
> +
> +#define LM73_CTRL_ALERT_SHIFT  3
> +#define LM73_CTRL_ALERT_SIZE   1
> +#define LM73_CTRL_ALERT_MASK \
> +       (((1 << LM73_CTRL_ALERT_SIZE) - 1) << LM73_CTRL_ALERT_SHIFT)
> +
> +#define LM73_CTRL_HI_SHIFT     2
> +#define LM73_CTRL_HI_SIZE      1
> +#define LM73_CTRL_HI_MASK \
> +       (((1 << LM73_CTRL_HI_SIZE) - 1) << LM73_CTRL_HI_SHIFT)
> +
> +#define LM73_CTRL_LO_SHIFT     1
> +#define LM73_CTRL_LO_SIZE      1
> +#define LM73_CTRL_LO_MASK \
> +       (((1 << LM73_CTRL_LO_SIZE) - 1) << LM73_CTRL_LO_SHIFT)
> +
> +#define LM73_CTRL_HILO_MASK \
> +       (LM73_CTRL_HI_MASK | LM73_CTRL_LO_MASK)
> +
> +#define LM73_CONF_POL_SHIFT    4
> +#define LM73_CONF_POL_SIZE     1
> +#define LM73_CONF_POL_MASK \
> +       (((1 << LM73_CONF_POL_SIZE) - 1) << LM73_CONF_POL_SHIFT)
> +
> +#define LM73_CONF_RESET_SHIFT  3
> +#define LM73_CONF_RESET_SIZE   1
> +#define LM73_CONF_RESET_MASK \
> +       (((1 << LM73_CONF_RESET_SIZE) - 1) << LM73_CONF_RESET_SHIFT)
> +
> +#define SCALE_150_PERCENT(x)   ((x) + (x)/2)
> +
> +static const unsigned short lm73_valid_convrates[] = {
> +       14,     /* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
> +       28,     /* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
> +       56,     /* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
> +       112,    /* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
> +};
> +
>  /*-----------------------------------------------------------------------*/
>
> +/* utility functions */
> +
> +static inline s32 lm73_read(struct i2c_client *client, u8 reg)
> +{
> +       return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static inline s32 lm73_write(struct i2c_client *client, u8 reg,
> +                            u8 clear, u8 enable)
> +{
> +       s32 tmp = lm73_read(client, reg);
> +       u8 value;
> +       if (tmp < 0)
> +               return tmp;
> +       value = tmp;
> +       value &= ~clear;
> +       value |= enable;
> +       return i2c_smbus_write_byte_data(client, reg, value);
> +}
> +
> +static inline s32 lm73_write_conf(struct i2c_client *client, u8 clear,
> +                                 u8 enable)
> +{
> +       /* always clear bits 1:0 and set bit 6 */
> +       enable &= ~(3 << 0);
> +       return lm73_write(client, LM73_REG_CONF,
> +                         clear  | (3 << 0),
> +                         enable | (1 << 6));
> +}
> +
> +static inline s32 lm73_write_ctrl(struct i2c_client *client, u8 clear,
> +                                 u8 enable)
> +{
> +       /* always clear bits 4:3 and 0 */
> +       enable &= ~((3 << 3) | (1 << 0));
> +       return lm73_write(client, LM73_REG_CTRL,
> +                         clear | (3 << 3) | (1 << 0),
> +                         enable);
> +}
> +
> +/*-----------------------------------------------------------------------*/
>
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>                         const char *buf, size_t count)
> @@ -59,7 +143,9 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>         value = (short) SENSORS_LIMIT(temp/250, (LM73_TEMP_MIN*4),
>                 (LM73_TEMP_MAX*4)) << 5;
>         err = i2c_smbus_write_word_swapped(client, attr->index, value);
> -       return (err < 0) ? err : count;
> +       if (err < 0)
> +               return err;
> +       return count;
>  }
>
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> @@ -79,6 +165,121 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>         return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
>  }
>
> +static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
> +                           const char *buf, size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       unsigned long convrate;
> +       s32 err;
> +       u8 res_bits = 0;
> +
> +       err = kstrtoul(buf, 10, &convrate);
> +       if (err < 0)
> +               return err;
> +
> +       /* Convert the desired conversion rate into register bits */
> +       if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[0]))
> +               res_bits = 0;
> +       else if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[1]))
> +               res_bits = 1;
> +       else if (convrate < SCALE_150_PERCENT(lm73_valid_convrates[2]))
> +               res_bits = 2;
> +       else
> +               res_bits = 3;
> +
> +       err = lm73_write_ctrl(client, LM73_CTRL_RES_MASK,
> +                             res_bits << LM73_CTRL_RES_SHIFT);
> +       if (err < 0)
> +               return err;
> +
> +       return count;
> +}
> +
> +static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
> +                            char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       s32 ctrl;
> +       u8 res_bits = 0;
> +
> +       /* Read existing control value */
> +       ctrl = lm73_read(client, LM73_REG_CTRL);
> +       if (ctrl < 0)
> +               return ctrl;
> +
> +       res_bits = (ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
> +       return scnprintf(buf, PAGE_SIZE, "%hu\n",
> +                       lm73_valid_convrates[res_bits]);
> +}
> +
> +static ssize_t reset_alarm(struct device *dev, struct device_attribute *da,
> +                          const char *buf, size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       unsigned long input;
> +       s32 err;
> +
> +       err = kstrtoul(buf, 10, &input);
> +       if (err < 0)
> +               return err;
> +
> +       /* ignore everything but a reset request */
> +       if (input)
> +               return -EINVAL;
> +
> +       err = lm73_write_conf(client, 0, LM73_CONF_RESET_MASK);
> +       if (err < 0)
> +               return err;
> +       return count;
> +}
> +
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
> +                         char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       s32 ctrl;
> +       s32 conf;
> +
> +       ctrl = lm73_read(client, LM73_REG_CTRL);
> +       if (ctrl < 0)
> +               return ctrl;
> +
> +       conf = lm73_read(client, LM73_REG_CONF);
> +       if (conf < 0)
> +               return conf;
> +
> +       /* strip out just the ALERT bit */
> +       ctrl &= LM73_CTRL_ALERT_MASK;
> +       ctrl >>= LM73_CTRL_ALERT_SHIFT;
> +
> +       /*
> +        * If ALERT's polarity is active-low, the bit needs to be
> +        * flipped to match the semantics of the 'alarm' attribute.
> +        */
> +       if (!(conf & LM73_CONF_POL_MASK))
> +               ctrl = !ctrl;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", ctrl);
> +}
> +
> +static ssize_t show_maxmin_alarm(struct device *dev,
> +                                struct device_attribute *da,
> +                                char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +       s32 ctrl;
> +
> +       ctrl = lm73_read(client, LM73_REG_CTRL);
> +       if (ctrl < 0)
> +               return ctrl;
> +
> +       /* strip out just the temperature hi/lo flag */
> +       ctrl >>= attr->index;
> +       ctrl &= 0x1;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", ctrl);
> +}
>
>  /*-----------------------------------------------------------------------*/
>
> @@ -90,13 +291,23 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
>                         show_temp, set_temp, LM73_REG_MIN);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>                         show_temp, NULL, LM73_REG_INPUT);
> -
> +static SENSOR_DEVICE_ATTR(temp1_update_interval, S_IWUSR | S_IRUGO,
> +                       show_convrate, set_convrate, 0);
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IWUSR | S_IRUGO,
> +                       show_alarm, reset_alarm, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
> +                       show_maxmin_alarm, NULL, LM73_CTRL_HI_SHIFT);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
> +                       show_maxmin_alarm, NULL, LM73_CTRL_LO_SHIFT);
>
>  static struct attribute *lm73_attributes[] = {
>         &sensor_dev_attr_temp1_input.dev_attr.attr,
>         &sensor_dev_attr_temp1_max.dev_attr.attr,
>         &sensor_dev_attr_temp1_min.dev_attr.attr,
> -
> +       &sensor_dev_attr_temp1_update_interval.dev_attr.attr,
> +       &sensor_dev_attr_temp1_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +       &sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
>         NULL
>  };
>
> @@ -106,11 +317,25 @@ static const struct attribute_group lm73_group = {
>
>  /*-----------------------------------------------------------------------*/
>
> +static irqreturn_t lm73_alarm_irq(int irq, void *arg)
> +{
> +       struct i2c_client *client = arg;
> +       struct lm73_platform_data *data = client->dev.platform_data;
> +
> +       sysfs_notify(&client->dev.kobj, NULL, "temp1_alarm");
> +       if (data && data->handler)
> +               return data->handler(irq, arg);
> +       return IRQ_HANDLED;
> +}
> +
> +/*-----------------------------------------------------------------------*/
> +
>  /* device probe and removal */
>
>  static int
>  lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> +       struct lm73_platform_data *data = client->dev.platform_data;
>         struct device *hwmon_dev;
>         int status;
>
> @@ -126,6 +351,32 @@ lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         }
>         i2c_set_clientdata(client, hwmon_dev);
>
> +       if (data && data->alert_polarity_high) {
> +               status = lm73_write_conf(client, 0, LM73_CONF_POL_MASK);
> +               if (status < 0) {
> +                       dev_err(&client->dev,
> +                               "%s: unable to set ALERT polarity\n",
> +                               dev_name(hwmon_dev));
> +                       status = -EIO;
> +                       goto exit_remove;
> +               }
> +       }
> +
> +       if (data && data->use_irq) {
> +               status = devm_request_irq(&client->dev,
> +                                         data->irq,
> +                                         lm73_alarm_irq,
> +                                         data->irqflags,
> +                                         dev_name(hwmon_dev),
> +                                         client);
> +               if (status < 0) {
> +                       dev_err(&client->dev,
> +                               "%s: unable to assign IRQ %d\n",
> +                               dev_name(hwmon_dev), data->irq);
> +                       goto exit_remove;
> +               }
> +       }
> +
>         dev_info(&client->dev, "%s: sensor '%s'\n",
>                  dev_name(hwmon_dev), client->name);
>
> @@ -139,7 +390,11 @@ exit_remove:
>  static int lm73_remove(struct i2c_client *client)
>  {
>         struct device *hwmon_dev = i2c_get_clientdata(client);
> +       struct lm73_platform_data *data = client->dev.platform_data;
>
> +       if (data && data->use_irq)
> +               devm_free_irq(&client->dev, data->use_irq,
> +                             data->handler);
>         hwmon_device_unregister(hwmon_dev);
>         sysfs_remove_group(&client->dev.kobj, &lm73_group);
>         return 0;
> diff --git a/include/linux/platform_data/lm73.h b/include/linux/platform_data/lm73.h
> new file mode 100644
> index 0000000..bfe9382
> --- /dev/null
> +++ b/include/linux/platform_data/lm73.h
> @@ -0,0 +1,38 @@
> +/*
> + * LM73 Sensor driver
> + * Based on LM75
> + *
> + * Copyright (C) 2007, CenoSYS (www.cenosys.com).
> + * Copyright (C) 2009, Bollore telecom (www.bolloretelecom.eu).
> + *
> + * Guillaume Ligneul <guillaume.ligneul@gmail.com>
> + * Adrien Demarez <adrien.demarez@bolloretelecom.eu>
> + * Jeremy Laine <jeremy.laine@bolloretelecom.eu>
> + *
> + * This software program is licensed subject to the GNU General Public License
> + * (GPL).Version 2,June 1991, available at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
> + */
> +#ifndef _LINUX_LM73_H
> +#define _LINUX_LM73_H
> +
> +/**
> + * struct lm73_platform_data - static configuration settings for the
> + * LM73 temperature sensor.
> + *
> + * @alert_polarity_high:  0 if ALERT is active-high, 1 if active-low
> + * @use_irq:              0 if ALERT is wired to an active interrupt pin
> + * @irq:                  the interrupt to use
> + * @irqflags:             the interrupt flags (see IRQF_*)
> + * @handler:              the platform handler function
> + */
> +struct lm73_platform_data {
> +       int alert_polarity_high;
> +
> +       int use_irq;
> +       unsigned int irq;
> +       unsigned long irqflags;
> +       irq_handler_t handler;
> +};
> +
> +#endif /* _LINUX_LM73_H */
> --
> 1.7.9.5
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
