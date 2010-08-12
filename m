From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 Aug 2010 17:16:09 +0000
Subject: Re: [lm-sensors] [PATCH 3/6] hwmon: (pc87427) Add support for
Message-Id: <1281633369.5745.326.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171059.4fb5813f@hyperion.delvare>
In-Reply-To: <20100811171059.4fb5813f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-08-11 at 11:10 -0400, Jean Delvare wrote:
> Add initial support for PWM outputs of the PC87427 Super-I/O chip.
> Only mode change and manual fan speed control are supported. Automatic
> mode configuration isn't supported, and won't be until at least one
> board is known, which makes uses of the PWM outputs.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Minor question inline.

> ---
>  Documentation/hwmon/pc87427 |   13 +-
>  drivers/hwmon/Kconfig       |    3
>  drivers/hwmon/pc87427.c     |  271 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 282 insertions(+), 5 deletions(-)
> 
> --- linux-2.6.36-rc0.orig/Documentation/hwmon/pc87427   2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc0/Documentation/hwmon/pc87427        2010-08-11 16:27:12.000000000 +0200
> @@ -20,8 +20,8 @@ The National Semiconductor Super I/O chi
>  monitoring capabilities. It can monitor up to 18 voltages, 8 fans and
>  6 temperature sensors. Only the fans are supported at the moment.
> 
> -This chip also has fan controlling features, which are not yet supported
> -by this driver either.
> +This chip also has fan controlling features (up to 4 PWM outputs),
> +which are partly supported by this driver.
> 
>  The driver assumes that no more than one chip is present, which seems
>  reasonable.
> @@ -36,3 +36,12 @@ signal. Speeds down to 83 RPM can be mea
>  An alarm is triggered if the rotation speed drops below a programmable
>  limit. Another alarm is triggered if the speed is too low to be measured
>  (including stalled or missing fan).
> +
> +
> +Fan Speed Control
> +-----------------
> +
> +Fan speed can be controlled by PWM outputs. There are 4 possible modes:
> +always off, always on, manual and automatic. The latter isn't supported
> +by the driver: you can only return to that mode if it was the original
> +setting, and the configuration interface is missing.
> --- linux-2.6.36-rc0.orig/drivers/hwmon/Kconfig 2010-08-11 15:42:11.000000000 +0200
> +++ linux-2.6.36-rc0/drivers/hwmon/Kconfig      2010-08-11 16:27:12.000000000 +0200
> @@ -711,7 +711,8 @@ config SENSORS_PC87427
>           functions of the National Semiconductor PC87427 Super-I/O chip.
>           The chip has two distinct logical devices, one for fan speed
>           monitoring and control, and one for voltage and temperature
> -         monitoring. Only fan speed monitoring is supported right now.
> +         monitoring. Only fan speed monitoring and control is supported
> +         right now.
> 
>           This driver can also be built as a module.  If so, the module
>           will be called pc87427.
> --- linux-2.6.36-rc0.orig/drivers/hwmon/pc87427.c       2010-08-11 16:25:40.000000000 +0200
> +++ linux-2.6.36-rc0/drivers/hwmon/pc87427.c    2010-08-11 16:27:12.000000000 +0200
> @@ -15,10 +15,10 @@
>   *  Supports the following chips:
>   *
>   *  Chip        #vin    #fan    #pwm    #temp   devid
> - *  PC87427     -       8       -       -       0xF2
> + *  PC87427     -       8       4       -       0xF2
>   *
>   *  This driver assumes that no more than one chip is present.
> - *  Only fan inputs are supported so far, although the chip can do much more.
> + *  Only fans are supported so far, although the chip can do much more.
>   */
> 
>  #include <linux/module.h>
> @@ -57,10 +57,16 @@ struct pc87427_data {
>         u16 fan[8];                     /* register values */
>         u16 fan_min[8];                 /* register values */
>         u8 fan_status[8];               /* register values */
> +
> +       u8 pwm_enabled;                 /* bit vector */
> +       u8 pwm_auto_ok;                 /* bit vector */
> +       u8 pwm_enable[4];               /* register values */
> +       u8 pwm[4];                      /* register values */
>  };
> 
>  struct pc87427_sio_data {
>         u8 has_fanin;
> +       u8 has_fanout;
>  };
> 
>  /*
> @@ -72,7 +78,9 @@ struct pc87427_sio_data {
>  #define SIOREG_CF2     0x22    /* Configuration 2 */
>  #define SIOREG_CF3     0x23    /* Configuration 3 */
>  #define SIOREG_CF4     0x24    /* Configuration 4 */
> +#define SIOREG_CF5     0x25    /* Configuration 5 */
>  #define SIOREG_CFB     0x2B    /* Configuration B */
> +#define SIOREG_CFC     0x2C    /* Configuration C */
>  #define SIOREG_CFD     0x2D    /* Configuration D */
>  #define SIOREG_ACT     0x30    /* Device activation */
>  #define SIOREG_MAP     0x50    /* I/O or memory mapping */
> @@ -188,6 +196,61 @@ static inline u16 fan_to_reg(unsigned lo
>  }
> 
>  /*
> + * PWM registers and conversions
> + */
> +
> +#define PC87427_REG_PWM_ENABLE         0x10
> +#define PC87427_REG_PWM_DUTY           0x12
> +
> +#define PWM_ENABLE_MODE_MASK           (7 << 4)
> +#define PWM_ENABLE_CTLEN               (1 << 0)
> +
> +#define PWM_MODE_MANUAL                        (0 << 4)
> +#define PWM_MODE_AUTO                  (1 << 4)
> +#define PWM_MODE_OFF                   (2 << 4)
> +#define PWM_MODE_ON                    (7 << 4)

Just wondering ... ON is 0x01110000, not 0x01000000 ?
No problem with it, only that the OFF overlaps the ON bit which seems a
bit odd.

> +
> +/* Dedicated function to read all registers related to a given PWM output.
> +   This saves us quite a few locks and bank selections.
> +   Must be called with data->lock held.
> +   nr is from 0 to 3 */
> +static void pc87427_readall_pwm(struct pc87427_data *data, u8 nr)
> +{
> +       int iobase = data->address[LD_FAN];
> +
> +       outb(BANK_FC(nr), iobase + PC87427_REG_BANK);
> +       data->pwm_enable[nr] = inb(iobase + PC87427_REG_PWM_ENABLE);
> +       data->pwm[nr] = inb(iobase + PC87427_REG_PWM_DUTY);
> +}
> +
> +static inline int pwm_enable_from_reg(u8 reg)
> +{
> +       switch (reg & PWM_ENABLE_MODE_MASK) {
> +       case PWM_MODE_ON:
> +               return 0;
> +       case PWM_MODE_MANUAL:
> +       case PWM_MODE_OFF:
> +               return 1;
> +       case PWM_MODE_AUTO:
> +               return 2;
> +       default:
> +               return -EPROTO;
> +       }
> +}
> +
> +static inline u8 pwm_enable_to_reg(unsigned long val, u8 pwmval)
> +{
> +       switch (val) {
> +       default:
> +               return PWM_MODE_ON;
> +       case 1:
> +               return pwmval ? PWM_MODE_MANUAL : PWM_MODE_OFF;
> +       case 2:
> +               return PWM_MODE_AUTO;
> +       }
> +}
> +
> +/*
>   * Data interface
>   */
> 
> @@ -207,6 +270,14 @@ static struct pc87427_data *pc87427_upda
>                         continue;
>                 pc87427_readall_fan(data, i);
>         }
> +
> +       /* PWM outputs */
> +       for (i = 0; i < 4; i++) {
> +               if (!(data->pwm_enabled & (1 << i)))
> +                       continue;
> +               pc87427_readall_pwm(data, i);
> +       }
> +
>         data->last_updated = jiffies;
> 
>  done:
> @@ -384,6 +455,145 @@ static const struct attribute_group pc87
>         { .attrs = pc87427_attributes_fan[7] },
>  };
> 
> +/* Must be called with data->lock held and pc87427_readall_pwm() freshly
> +   called */
> +static void update_pwm_enable(struct pc87427_data *data, int nr, u8 mode)
> +{
> +       int iobase = data->address[LD_FAN];
> +       data->pwm_enable[nr] &= ~PWM_ENABLE_MODE_MASK;
> +       data->pwm_enable[nr] |= mode;
> +       outb(data->pwm_enable[nr], iobase + PC87427_REG_PWM_ENABLE);
> +}
> +
> +static ssize_t show_pwm_enable(struct device *dev, struct device_attribute
> +                              *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +       int pwm_enable;
> +
> +       pwm_enable = pwm_enable_from_reg(data->pwm_enable[nr]);
> +       if (pwm_enable < 0)
> +               return pwm_enable;
> +       return sprintf(buf, "%d\n", pwm_enable);
> +}
> +
> +static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
> +                             *devattr, const char *buf, size_t count)
> +{
> +       struct pc87427_data *data = dev_get_drvdata(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +       unsigned long val;
> +
> +       if (strict_strtoul(buf, 10, &val) < 0 || val > 2)
> +               return -EINVAL;
> +       /* Can't go to automatic mode if it isn't configured */
> +       if (val = 2 && !(data->pwm_auto_ok & (1 << nr)))
> +               return -EINVAL;
> +
> +       mutex_lock(&data->lock);
> +       pc87427_readall_pwm(data, nr);
> +       update_pwm_enable(data, nr, pwm_enable_to_reg(val, data->pwm[nr]));
> +       mutex_unlock(&data->lock);
> +
> +       return count;
> +}
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute
> +                       *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%d\n", (int)data->pwm[nr]);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute
> +                      *devattr, const char *buf, size_t count)
> +{
> +       struct pc87427_data *data = dev_get_drvdata(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +       unsigned long val;
> +       int iobase = data->address[LD_FAN];
> +       u8 mode;
> +
> +       if (strict_strtoul(buf, 10, &val) < 0 || val > 0xff)
> +               return -EINVAL;
> +
> +       mutex_lock(&data->lock);
> +       pc87427_readall_pwm(data, nr);
> +       mode = data->pwm_enable[nr] & PWM_ENABLE_MODE_MASK;
> +       if (mode != PWM_MODE_MANUAL && mode != PWM_MODE_OFF) {
> +               dev_notice(dev, "Can't set PWM%d duty cycle while not in "
> +                          "manual mode\n", nr + 1);
> +               mutex_unlock(&data->lock);
> +               return -EPERM;
> +       }
> +
> +       /* We may have to change the mode */
> +       if (mode = PWM_MODE_MANUAL && val = 0) {
> +               /* Transition from Manual to Off */
> +               update_pwm_enable(data, nr, PWM_MODE_OFF);
> +               mode = PWM_MODE_OFF;
> +               dev_dbg(dev, "Switching PWM%d from %s to %s\n", nr + 1,
> +                       "manual", "off");
> +       } else if (mode = PWM_MODE_OFF && val != 0) {
> +               /* Transition from Off to Manual */
> +               update_pwm_enable(data, nr, PWM_MODE_MANUAL);
> +               mode = PWM_MODE_MANUAL;
> +               dev_dbg(dev, "Switching PWM%d from %s to %s\n", nr + 1,
> +                       "off", "manual");
> +       }
> +
> +       data->pwm[nr] = val;
> +       if (mode = PWM_MODE_MANUAL)
> +               outb(val, iobase + PC87427_REG_PWM_DUTY);
> +       mutex_unlock(&data->lock);
> +
> +       return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
> +                         show_pwm_enable, set_pwm_enable, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
> +                         show_pwm_enable, set_pwm_enable, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO,
> +                         show_pwm_enable, set_pwm_enable, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO,
> +                         show_pwm_enable, set_pwm_enable, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
> +static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
> +static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
> +static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
> +
> +static struct attribute *pc87427_attributes_pwm[4][3] = {
> +       {
> +               &sensor_dev_attr_pwm1_enable.dev_attr.attr,
> +               &sensor_dev_attr_pwm1.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_pwm2_enable.dev_attr.attr,
> +               &sensor_dev_attr_pwm2.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_pwm3_enable.dev_attr.attr,
> +               &sensor_dev_attr_pwm3.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_pwm4_enable.dev_attr.attr,
> +               &sensor_dev_attr_pwm4.dev_attr.attr,
> +               NULL
> +       }
> +};
> +
> +static const struct attribute_group pc87427_group_pwm[4] = {
> +       { .attrs = pc87427_attributes_pwm[0] },
> +       { .attrs = pc87427_attributes_pwm[1] },
> +       { .attrs = pc87427_attributes_pwm[2] },
> +       { .attrs = pc87427_attributes_pwm[3] },
> +};
> +
>  static ssize_t show_name(struct device *dev, struct device_attribute
>                          *devattr, char *buf)
>  {
> @@ -431,6 +641,25 @@ static void __devinit pc87427_init_devic
>                 }
>                 data->fan_enabled = sio_data->has_fanin;
>         }
> +
> +       /* Check which PWM outputs are enabled */
> +       for (i = 0; i < 4; i++) {
> +               if (!(sio_data->has_fanout & (1 << i))) /* Not wired */
> +                       continue;
> +               reg = pc87427_read8_bank(data, LD_FAN, BANK_FC(i),
> +                                        PC87427_REG_PWM_ENABLE);
> +               if (reg & PWM_ENABLE_CTLEN)
> +                       data->pwm_enabled |= (1 << i);
> +
> +               /* We don't expose an interface to reconfigure the automatic
> +                  fan control mode, so only allow to return to this mode if
> +                  it was originally set. */
> +               if ((reg & PWM_ENABLE_MODE_MASK) = PWM_MODE_AUTO) {
> +                       dev_dbg(dev, "PWM%d is in automatic control mode\n",
> +                               i + 1);
> +                       data->pwm_auto_ok |= (1 << i);
> +               }
> +       }
>  }
> 
>  static int __devinit pc87427_probe(struct platform_device *pdev)
> @@ -474,6 +703,14 @@ static int __devinit pc87427_probe(struc
>                 if (err)
>                         goto exit_remove_files;
>         }
> +       for (i = 0; i < 4; i++) {
> +               if (!(data->pwm_enabled & (1 << i)))
> +                       continue;
> +               err = sysfs_create_group(&pdev->dev.kobj,
> +                                        &pc87427_group_pwm[i]);
> +               if (err)
> +                       goto exit_remove_files;
> +       }
> 
>         data->hwmon_dev = hwmon_device_register(&pdev->dev);
>         if (IS_ERR(data->hwmon_dev)) {
> @@ -490,6 +727,11 @@ exit_remove_files:
>                         continue;
>                 sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
>         }
> +       for (i = 0; i < 4; i++) {
> +               if (!(data->pwm_enabled & (1 << i)))
> +                       continue;
> +               sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
> +       }
>  exit_release_region:
>         release_region(res->start, resource_size(res));
>  exit_kfree:
> @@ -512,6 +754,11 @@ static int __devexit pc87427_remove(stru
>                         continue;
>                 sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
>         }
> +       for (i = 0; i < 4; i++) {
> +               if (!(data->pwm_enabled & (1 << i)))
> +                       continue;
> +               sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
> +       }
>         platform_set_drvdata(pdev, NULL);
>         kfree(data);
> 
> @@ -648,6 +895,26 @@ static int __init pc87427_find(int sioad
>         if ((cfg & (1 << 3)) && !(cfg_b & (1 << 5)))
>                 sio_data->has_fanin |= (1 << 6);        /* FANIN6 */
> 
> +       /* Check which fan outputs are wired */
> +       sio_data->has_fanout = (1 << 0);                /* FANOUT0 */
> +       if (cfg_b & (1 << 0))
> +               sio_data->has_fanout |= (1 << 3);       /* FANOUT3 */
> +
> +       cfg = superio_inb(sioaddr, SIOREG_CFC);
> +       if (!(cfg & (1 << 4))) {
> +               if (cfg_b & (1 << 1))
> +                       sio_data->has_fanout |= (1 << 1); /* FANOUT1 */
> +               if (cfg_b & (1 << 2))
> +                       sio_data->has_fanout |= (1 << 2); /* FANOUT2 */
> +       }
> +
> +       /* FANOUT1 and FANOUT2 can each be routed to 2 different pins */
> +       cfg = superio_inb(sioaddr, SIOREG_CF5);
> +       if (cfg & (1 << 6))
> +               sio_data->has_fanout |= (1 << 1);       /* FANOUT1 */
> +       if (cfg & (1 << 5))
> +               sio_data->has_fanout |= (1 << 2);       /* FANOUT2 */
> +
>  exit:
>         superio_exit(sioaddr);
>         return err;
> 
> --
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
