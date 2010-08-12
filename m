From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 Aug 2010 17:37:17 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (pc87427) Add temperature
Message-Id: <1281634637.5745.341.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171326.230ae5fd@hyperion.delvare>
In-Reply-To: <20100811171326.230ae5fd@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-08-11 at 11:13 -0400, Jean Delvare wrote:
> Add support for the 6 temperature monitoring channels of the PC87427.
> Note that the sensors resolution can vary, and I couldn't find a way
> to figure it out, so we might have to compensate in user-space.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

One question: You don't sign extend the 16 bit sensor data. Does that
mean negative values will be reported as large positive values, or does
the chip sign extend internally from 8/9 to 16 bit ?

> ---
>  Documentation/hwmon/pc87427 |   14 +
>  drivers/hwmon/Kconfig       |    4
>  drivers/hwmon/pc87427.c     |  368 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 379 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.36-rc0.orig/drivers/hwmon/pc87427.c       2010-08-11 16:35:46.000000000 +0200
> +++ linux-2.6.36-rc0/drivers/hwmon/pc87427.c    2010-08-11 16:39:37.000000000 +0200
> @@ -1,7 +1,7 @@
>  /*
>   *  pc87427.c - hardware monitoring driver for the
>   *              National Semiconductor PC87427 Super-I/O chip
> - *  Copyright (C) 2006, 2008  Jean Delvare <khali@linux-fr.org>
> + *  Copyright (C) 2006, 2008, 2010  Jean Delvare <khali@linux-fr.org>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -15,10 +15,11 @@
>   *  Supports the following chips:
>   *
>   *  Chip        #vin    #fan    #pwm    #temp   devid
> - *  PC87427     -       8       4       -       0xF2
> + *  PC87427     -       8       4       6       0xF2
>   *
>   *  This driver assumes that no more than one chip is present.
> - *  Only fans are supported so far, although the chip can do much more.
> + *  Only fans are fully supported so far. Temperatures are in read-only
> + *  mode, and voltages aren't supported at all.
>   */
> 
>  #include <linux/module.h>
> @@ -62,6 +63,14 @@ struct pc87427_data {
>         u8 pwm_auto_ok;                 /* bit vector */
>         u8 pwm_enable[4];               /* register values */
>         u8 pwm[4];                      /* register values */
> +
> +       u8 temp_enabled;                /* bit vector */
> +       s16 temp[6];                    /* register values */
> +       s8 temp_min[6];                 /* register values */
> +       s8 temp_max[6];                 /* register values */
> +       s8 temp_crit[6];                /* register values */
> +       u8 temp_status[6];              /* register values */
> +       u8 temp_type[6];                /* register values */
>  };
> 
>  struct pc87427_sio_data {
> @@ -120,6 +129,8 @@ static inline void superio_exit(int sioa
>  #define BANK_FM(nr)            (nr)
>  #define BANK_FT(nr)            (0x08 + (nr))
>  #define BANK_FC(nr)            (0x10 + (nr) * 2)
> +#define BANK_TM(nr)            (nr)
> +#define BANK_VM(nr)            (0x08 + (nr))
> 
>  /*
>   * I/O access functions
> @@ -252,6 +263,72 @@ static inline u8 pwm_enable_to_reg(unsig
>  }
> 
>  /*
> + * Temperature registers and conversions
> + */
> +
> +#define PC87427_REG_TEMP_STATUS                0x10
> +#define PC87427_REG_TEMP               0x14
> +#define PC87427_REG_TEMP_MAX           0x18
> +#define PC87427_REG_TEMP_MIN           0x19
> +#define PC87427_REG_TEMP_CRIT          0x1a
> +#define PC87427_REG_TEMP_TYPE          0x1d
> +
> +#define TEMP_STATUS_CHANEN             (1 << 0)
> +#define TEMP_STATUS_LOWFLG             (1 << 1)
> +#define TEMP_STATUS_HIGHFLG            (1 << 2)
> +#define TEMP_STATUS_CRITFLG            (1 << 3)
> +#define TEMP_STATUS_SENSERR            (1 << 5)
> +#define TEMP_TYPE_MASK                 (3 << 5)
> +
> +#define TEMP_TYPE_THERMISTOR           (1 << 5)
> +#define TEMP_TYPE_REMOTE_DIODE         (2 << 5)
> +#define TEMP_TYPE_LOCAL_DIODE          (3 << 5)
> +
> +/* Dedicated function to read all registers related to a given temperature
> +   input. This saves us quite a few locks and bank selections.
> +   Must be called with data->lock held.
> +   nr is from 0 to 5 */
> +static void pc87427_readall_temp(struct pc87427_data *data, u8 nr)
> +{
> +       int iobase = data->address[LD_TEMP];
> +
> +       outb(BANK_TM(nr), iobase + PC87427_REG_BANK);
> +       data->temp[nr] = le16_to_cpu(inw(iobase + PC87427_REG_TEMP));
> +       data->temp_max[nr] = inb(iobase + PC87427_REG_TEMP_MAX);
> +       data->temp_min[nr] = inb(iobase + PC87427_REG_TEMP_MIN);
> +       data->temp_crit[nr] = inb(iobase + PC87427_REG_TEMP_CRIT);
> +       data->temp_type[nr] = inb(iobase + PC87427_REG_TEMP_TYPE);
> +       data->temp_status[nr] = inb(iobase + PC87427_REG_TEMP_STATUS);
> +       /* Clear fan alarm bits */
> +       outb(data->temp_status[nr], iobase + PC87427_REG_TEMP_STATUS);
> +}
> +
> +static inline unsigned int temp_type_from_reg(u8 reg)
> +{
> +       switch (reg & TEMP_TYPE_MASK) {
> +       case TEMP_TYPE_THERMISTOR:
> +               return 4;
> +       case TEMP_TYPE_REMOTE_DIODE:
> +       case TEMP_TYPE_LOCAL_DIODE:
> +               return 3;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +/* We assume 8-bit thermal sensors; 9-bit thermal sensors are possible
> +   too, but I have no idea how to figure out when they are used. */
> +static inline long temp_from_reg(s16 reg)
> +{
> +       return reg * 1000 / 256;
> +}
> +
> +static inline long temp_from_reg8(s8 reg)
> +{
> +       return reg * 1000;
> +}
> +
> +/*
>   * Data interface
>   */
> 
> @@ -279,6 +356,13 @@ static struct pc87427_data *pc87427_upda
>                 pc87427_readall_pwm(data, i);
>         }
> 
> +       /* Temperature channels */
> +       for (i = 0; i < 6; i++) {
> +               if (!(data->temp_enabled & (1 << i)))
> +                       continue;
> +               pc87427_readall_temp(data, i);
> +       }
> +
>         data->last_updated = jiffies;
> 
>  done:
> @@ -595,6 +679,251 @@ static const struct attribute_group pc87
>         { .attrs = pc87427_attributes_pwm[3] },
>  };
> 
> +static ssize_t show_temp_input(struct device *dev, struct device_attribute
> +                              *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%ld\n", temp_from_reg(data->temp[nr]));
> +}
> +
> +static ssize_t show_temp_min(struct device *dev, struct device_attribute
> +                            *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_min[nr]));
> +}
> +
> +static ssize_t show_temp_max(struct device *dev, struct device_attribute
> +                            *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_max[nr]));
> +}
> +
> +static ssize_t show_temp_crit(struct device *dev, struct device_attribute
> +                             *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_crit[nr]));
> +}
> +
> +static ssize_t show_temp_type(struct device *dev, struct device_attribute
> +                             *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%u\n", temp_type_from_reg(data->temp_type[nr]));
> +}
> +
> +static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute
> +                                  *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%d\n", !!(data->temp_status[nr]
> +                                      & TEMP_STATUS_LOWFLG));
> +}
> +
> +static ssize_t show_temp_max_alarm(struct device *dev, struct device_attribute
> +                                  *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%d\n", !!(data->temp_status[nr]
> +                                      & TEMP_STATUS_HIGHFLG));
> +}
> +
> +static ssize_t show_temp_crit_alarm(struct device *dev, struct device_attribute
> +                                  *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%d\n", !!(data->temp_status[nr]
> +                                      & TEMP_STATUS_CRITFLG));
> +}
> +
> +static ssize_t show_temp_fault(struct device *dev, struct device_attribute
> +                              *devattr, char *buf)
> +{
> +       struct pc87427_data *data = pc87427_update_device(dev);
> +       int nr = to_sensor_dev_attr(devattr)->index;
> +
> +       return sprintf(buf, "%d\n", !!(data->temp_status[nr]
> +                                      & TEMP_STATUS_SENSERR));
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp_min, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp_min, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO, show_temp_min, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO, show_temp_min, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_min, S_IRUGO, show_temp_min, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO, show_temp_max, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO, show_temp_crit, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO, show_temp_crit, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_type, S_IRUGO, show_temp_type, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_type, S_IRUGO, show_temp_type, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_type, S_IRUGO, show_temp_type, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_min_alarm, S_IRUGO,
> +                         show_temp_min_alarm, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_max_alarm, S_IRUGO,
> +                         show_temp_max_alarm, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_crit_alarm, S_IRUGO,
> +                         show_temp_crit_alarm, NULL, 5);
> +
> +static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_temp_fault, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_temp_fault, NULL, 5);
> +
> +static struct attribute *pc87427_attributes_temp[6][10] = {
> +       {
> +               &sensor_dev_attr_temp1_input.dev_attr.attr,
> +               &sensor_dev_attr_temp1_min.dev_attr.attr,
> +               &sensor_dev_attr_temp1_max.dev_attr.attr,
> +               &sensor_dev_attr_temp1_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp1_type.dev_attr.attr,
> +               &sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp1_fault.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp2_input.dev_attr.attr,
> +               &sensor_dev_attr_temp2_min.dev_attr.attr,
> +               &sensor_dev_attr_temp2_max.dev_attr.attr,
> +               &sensor_dev_attr_temp2_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp2_type.dev_attr.attr,
> +               &sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp2_fault.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp3_input.dev_attr.attr,
> +               &sensor_dev_attr_temp3_min.dev_attr.attr,
> +               &sensor_dev_attr_temp3_max.dev_attr.attr,
> +               &sensor_dev_attr_temp3_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp3_type.dev_attr.attr,
> +               &sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp3_fault.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp4_input.dev_attr.attr,
> +               &sensor_dev_attr_temp4_min.dev_attr.attr,
> +               &sensor_dev_attr_temp4_max.dev_attr.attr,
> +               &sensor_dev_attr_temp4_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp4_type.dev_attr.attr,
> +               &sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp4_fault.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp5_input.dev_attr.attr,
> +               &sensor_dev_attr_temp5_min.dev_attr.attr,
> +               &sensor_dev_attr_temp5_max.dev_attr.attr,
> +               &sensor_dev_attr_temp5_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp5_type.dev_attr.attr,
> +               &sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp5_fault.dev_attr.attr,
> +               NULL
> +       }, {
> +               &sensor_dev_attr_temp6_input.dev_attr.attr,
> +               &sensor_dev_attr_temp6_min.dev_attr.attr,
> +               &sensor_dev_attr_temp6_max.dev_attr.attr,
> +               &sensor_dev_attr_temp6_crit.dev_attr.attr,
> +               &sensor_dev_attr_temp6_type.dev_attr.attr,
> +               &sensor_dev_attr_temp6_min_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp6_max_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
> +               &sensor_dev_attr_temp6_fault.dev_attr.attr,
> +               NULL
> +       }
> +};
> +
> +static const struct attribute_group pc87427_group_temp[6] = {
> +       { .attrs = pc87427_attributes_temp[0] },
> +       { .attrs = pc87427_attributes_temp[1] },
> +       { .attrs = pc87427_attributes_temp[2] },
> +       { .attrs = pc87427_attributes_temp[3] },
> +       { .attrs = pc87427_attributes_temp[4] },
> +       { .attrs = pc87427_attributes_temp[5] },
> +};
> +
>  static ssize_t show_name(struct device *dev, struct device_attribute
>                          *devattr, char *buf)
>  {
> @@ -659,7 +988,7 @@ static void __devinit pc87427_init_devic
>         /* The FMC module should be ready */
>         reg = pc87427_read8(data, LD_FAN, PC87427_REG_BANK);
>         if (!(reg & 0x80))
> -               dev_warn(dev, "FMC module not ready!\n");
> +               dev_warn(dev, "%s module not ready!\n", "FMC");
> 
>         /* Check which fans are enabled */
>         for (i = 0; i < 8; i++) {
> @@ -701,6 +1030,19 @@ static void __devinit pc87427_init_devic
>                         data->pwm_auto_ok |= (1 << i);
>                 }
>         }
> +
> +       /* The HMC module should be ready */
> +       reg = pc87427_read8(data, LD_TEMP, PC87427_REG_BANK);
> +       if (!(reg & 0x80))
> +               dev_warn(dev, "%s module not ready!\n", "HMC");
> +
> +       /* Check which temperature channels are enabled */
> +       for (i = 0; i < 6; i++) {
> +               reg = pc87427_read8_bank(data, LD_TEMP, BANK_TM(i),
> +                                        PC87427_REG_TEMP_STATUS);
> +               if (reg & TEMP_STATUS_CHANEN)
> +                       data->temp_enabled |= (1 << i);
> +       }
>  }
> 
>  static int __devinit pc87427_probe(struct platform_device *pdev)
> @@ -749,6 +1091,14 @@ static int __devinit pc87427_probe(struc
>                 if (err)
>                         goto exit_remove_files;
>         }
> +       for (i = 0; i < 6; i++) {
> +               if (!(data->temp_enabled & (1 << i)))
> +                       continue;
> +               err = sysfs_create_group(&pdev->dev.kobj,
> +                                        &pc87427_group_temp[i]);
> +               if (err)
> +                       goto exit_remove_files;
> +       }
> 
>         data->hwmon_dev = hwmon_device_register(&pdev->dev);
>         if (IS_ERR(data->hwmon_dev)) {
> @@ -770,6 +1120,11 @@ exit_remove_files:
>                         continue;
>                 sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
>         }
> +       for (i = 0; i < 6; i++) {
> +               if (!(data->temp_enabled & (1 << i)))
> +                       continue;
> +               sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_temp[i]);
> +       }
>  exit_release_region:
>         pc87427_release_regions(pdev, res_count);
>  exit_kfree:
> @@ -798,6 +1153,11 @@ static int __devexit pc87427_remove(stru
>                         continue;
>                 sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
>         }
> +       for (i = 0; i < 6; i++) {
> +               if (!(data->temp_enabled & (1 << i)))
> +                       continue;
> +               sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_temp[i]);
> +       }
>         platform_set_drvdata(pdev, NULL);
>         kfree(data);
> 
> --- linux-2.6.36-rc0.orig/drivers/hwmon/Kconfig 2010-08-11 16:27:12.000000000 +0200
> +++ linux-2.6.36-rc0/drivers/hwmon/Kconfig      2010-08-11 16:39:37.000000000 +0200
> @@ -711,8 +711,8 @@ config SENSORS_PC87427
>           functions of the National Semiconductor PC87427 Super-I/O chip.
>           The chip has two distinct logical devices, one for fan speed
>           monitoring and control, and one for voltage and temperature
> -         monitoring. Only fan speed monitoring and control is supported
> -         right now.
> +         monitoring. Fan speed monitoring and control are supported, as
> +         well as temperature monitoring. Voltages aren't supported yet.
> 
>           This driver can also be built as a module.  If so, the module
>           will be called pc87427.
> --- linux-2.6.36-rc0.orig/Documentation/hwmon/pc87427   2010-08-11 16:27:12.000000000 +0200
> +++ linux-2.6.36-rc0/Documentation/hwmon/pc87427        2010-08-11 16:39:37.000000000 +0200
> @@ -18,7 +18,8 @@ Description
> 
>  The National Semiconductor Super I/O chip includes complete hardware
>  monitoring capabilities. It can monitor up to 18 voltages, 8 fans and
> -6 temperature sensors. Only the fans are supported at the moment.
> +6 temperature sensors. Only the fans and temperatures are supported at
> +the moment, voltages aren't.
> 
>  This chip also has fan controlling features (up to 4 PWM outputs),
>  which are partly supported by this driver.
> @@ -45,3 +46,14 @@ Fan speed can be controlled by PWM outpu
>  always off, always on, manual and automatic. The latter isn't supported
>  by the driver: you can only return to that mode if it was the original
>  setting, and the configuration interface is missing.
> +
> +
> +Temperature Monitoring
> +----------------------
> +
> +The PC87427 relies on external sensors (following the SensorPath
> +standard), so the resolution and range depend on the type of sensor
> +connected. The integer part can be 8-bit or 9-bit, and can be signed or
> +not. I couldn't find a way to figure out the external sensor data
> +temperature format, so user-space adjustment (typically by a factor 2)
> +may be required.
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
