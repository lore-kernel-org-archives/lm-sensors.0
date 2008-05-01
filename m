From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 01 May 2008 04:36:00 +0000
Subject: Re: [lm-sensors] [PATCH 02/10 v2] hwmon: (lm85) Coding-style
Message-Id: <191fb4ca0804302136p14370fcdi86f1ee8c985263fe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Acked-by: Juerg Haefliger <juergh at gmail.com>


On Tue, Apr 29, 2008 at 5:03 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Fix most style issues reported by checkpatch, including:
>  * Trailing, missing and extra whitespace
>  * Extra parentheses, curly braces and semi-colons
>  * Broken indentation
>  * Lines too long
>
>  I verified that the generated code is the same before and after
>  these changes.
>
>  Signed-off-by: Jean Delvare <khali@linux-fr.org>
>  ---
>  Updated to include the comments from Juerg Haefliger.
>
>   drivers/hwmon/lm85.c |  505 +++++++++++++++++++++++++-------------------------
>   1 file changed, 255 insertions(+), 250 deletions(-)
>
>  --- linux-2.6.26-rc0.orig/drivers/hwmon/lm85.c  2008-04-29 13:26:33.000000000 +0200
>  +++ linux-2.6.26-rc0/drivers/hwmon/lm85.c       2008-04-29 13:43:54.000000000 +0200
>
>
> @@ -1,7 +1,7 @@
>   /*
>      lm85.c - Part of lm_sensors, Linux kernel modules for hardware
>               monitoring
>  -    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
>  +    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
>      Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
>      Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
>      Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
>  @@ -51,8 +51,8 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
>   #define        LM85_REG_TEMP_MAX(nr)           (0x4f + (nr) * 2)
>
>   /* Fan speeds are LSB, MSB (2 bytes) */
>  -#define        LM85_REG_FAN(nr)                (0x28 + (nr) *2)
>  -#define        LM85_REG_FAN_MIN(nr)            (0x54 + (nr) *2)
>  +#define        LM85_REG_FAN(nr)                (0x28 + (nr) * 2)
>  +#define        LM85_REG_FAN_MIN(nr)            (0x54 + (nr) * 2)
>
>   #define        LM85_REG_PWM(nr)                (0x30 + (nr))
>
>  @@ -68,7 +68,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
>   #define        LM85_DEVICE_ADX                 0x27
>   #define        LM85_COMPANY_NATIONAL           0x01
>   #define        LM85_COMPANY_ANALOG_DEV         0x41
>  -#define        LM85_COMPANY_SMSC               0x5c
>  +#define        LM85_COMPANY_SMSC               0x5c
>   #define        LM85_VERSTEP_VMASK              0xf0
>   #define        LM85_VERSTEP_GENERIC            0x60
>   #define        LM85_VERSTEP_LM85C              0x60
>  @@ -115,34 +115,34 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
>
>   #define EMC6D100_REG_ALARM3             0x7d
>   /* IN5, IN6 and IN7 */
>  -#define        EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
>  -#define        EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
>  -#define        EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
>  +#define        EMC6D100_REG_IN(nr)             (0x70 + ((nr) - 5))
>  +#define        EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr) - 5) * 2)
>  +#define        EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr) - 5) * 2)
>   #define        EMC6D102_REG_EXTEND_ADC1        0x85
>   #define        EMC6D102_REG_EXTEND_ADC2        0x86
>   #define        EMC6D102_REG_EXTEND_ADC3        0x87
>   #define        EMC6D102_REG_EXTEND_ADC4        0x88
>
>
>  -/* Conversions. Rounding and limit checking is only done on the TO_REG
>  +/* Conversions. Rounding and limit checking is only done on the TO_REG
>     variants. Note that you should be a bit careful with which arguments
>     these macros are called: arguments may be evaluated more than once.
>   */
>
>   /* IN are scaled acording to built-in resistors */
>   static int lm85_scaling[] = {  /* .001 Volts */
>  -               2500, 2250, 3300, 5000, 12000,
>  -               3300, 1500, 1800 /*EMC6D100*/
>  -       };
>  -#define SCALE(val,from,to)             (((val)*(to) + ((from)/2))/(from))
>  +       2500, 2250, 3300, 5000, 12000,
>  +       3300, 1500, 1800 /*EMC6D100*/
>  +};
>  +#define SCALE(val, from, to)   (((val) * (to) + ((from) / 2)) / (from))
>
>  -#define INS_TO_REG(n,val)      \
>  -               SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255)
>  +#define INS_TO_REG(n, val)     \
>  +               SENSORS_LIMIT(SCALE(val, lm85_scaling[n], 192), 0, 255)
>
>  -#define INSEXT_FROM_REG(n,val,ext)     \
>  +#define INSEXT_FROM_REG(n, val, ext)   \
>                 SCALE(((val) << 4) + (ext), 192 << 4, lm85_scaling[n])
>
>  -#define INS_FROM_REG(n,val)    SCALE((val), 192, lm85_scaling[n])
>  +#define INS_FROM_REG(n, val)   SCALE((val), 192, lm85_scaling[n])
>
>   /* FAN speed is measured using 90kHz clock */
>   static inline u16 FAN_TO_REG(unsigned long val)
>  @@ -151,16 +151,17 @@ static inline u16 FAN_TO_REG(unsigned lo
>                 return 0xffff;
>         return SENSORS_LIMIT(5400000 / val, 1, 0xfffe);
>   }
>  -#define FAN_FROM_REG(val)      ((val)=0?-1:(val)=0xffff?0:5400000/(val))
>  +#define FAN_FROM_REG(val)      ((val) = 0 ? -1 : (val) = 0xffff ? 0 : \
>  +                                5400000 / (val))
>
>   /* Temperature is reported in .001 degC increments */
>   #define TEMP_TO_REG(val)       \
>  -               SENSORS_LIMIT(SCALE(val,1000,1),-127,127)
>  -#define TEMPEXT_FROM_REG(val,ext)      \
>  +               SENSORS_LIMIT(SCALE(val, 1000, 1), -127, 127)
>  +#define TEMPEXT_FROM_REG(val, ext)     \
>                 SCALE(((val) << 4) + (ext), 16, 1000)
>   #define TEMP_FROM_REG(val)     ((val) * 1000)
>
>  -#define PWM_TO_REG(val)                        (SENSORS_LIMIT(val,0,255))
>  +#define PWM_TO_REG(val)                        SENSORS_LIMIT(val, 0, 255)
>   #define PWM_FROM_REG(val)              (val)
>
>
>  @@ -183,17 +184,17 @@ static inline u16 FAN_TO_REG(unsigned lo
>
>   */
>
>   /* These are the zone temperature range encodings in .001 degree C */
>  -static int lm85_range_map[] = {
>  -               2000,  2500,  3300,  4000,  5000,  6600,
>  -               8000, 10000, 13300, 16000, 20000, 26600,
>  -               32000, 40000, 53300, 80000
>  -       };
>  -static int RANGE_TO_REG( int range )
>  +static int lm85_range_map[] = {
>  +       2000, 2500, 3300, 4000, 5000, 6600, 8000, 10000,
>  +       13300, 16000, 20000, 26600, 32000, 40000, 53300, 80000
>  +};
>  +
>  +static int RANGE_TO_REG(int range)
>   {
>         int i;
>
>         if (range >= lm85_range_map[15])
>  -               return 15 ;
>  +               return 15;
>
>         /* Find the closest match */
>         for (i = 14; i >= 0; --i) {
>  @@ -207,7 +208,7 @@ static int RANGE_TO_REG( int range )
>
>
>         return 0;
>   }
>  -#define RANGE_FROM_REG(val) (lm85_range_map[(val)&0x0f])
>  +#define RANGE_FROM_REG(val)    lm85_range_map[(val) & 0x0f]
>
>   /* These are the Acoustic Enhancement, or Temperature smoothing encodings
>   * NOTE: The enable/disable bit is INCLUDED in these encodings as the
>  @@ -216,19 +217,21 @@ static int RANGE_TO_REG( int range )
>
>   */
>   /* These are the PWM frequency encodings */
>   static int lm85_freq_map[] = { /* .1 Hz */
>  -               100, 150, 230, 300, 380, 470, 620, 940
>  -       };
>  -static int FREQ_TO_REG( int freq )
>  +       100, 150, 230, 300, 380, 470, 620, 940
>  +};
>  +
>  +static int FREQ_TO_REG(int freq)
>   {
>         int i;
>
>  -       if( freq >= lm85_freq_map[7] ) { return 7 ; }
>  -       for( i = 0 ; i < 7 ; ++i )
>  -               if( freq <= lm85_freq_map[i] )
>  -                       break ;
>  -       return( i & 0x07 );
>  +       if (freq >= lm85_freq_map[7])
>  +               return 7;
>  +       for (i = 0; i < 7; ++i)
>  +               if (freq <= lm85_freq_map[i])
>  +                       break;
>  +       return i & 0x07;
>   }
>  -#define FREQ_FROM_REG(val) (lm85_freq_map[(val)&0x07])
>  +#define FREQ_FROM_REG(val)     lm85_freq_map[(val) & 0x07]
>
>   /* Since we can't use strings, I'm abusing these numbers
>   *   to stand in for the following meanings:
>  @@ -243,29 +246,29 @@ static int FREQ_TO_REG( int freq )
>
>
>   */
>
>   static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
>  -#define ZONE_FROM_REG(val) (lm85_zone_map[((val)>>5)&0x07])
>  +#define ZONE_FROM_REG(val)     lm85_zone_map[((val) >> 5) & 0x07]
>
>  -static int ZONE_TO_REG( int zone )
>  +static int ZONE_TO_REG(int zone)
>   {
>         int i;
>
>  -       for( i = 0 ; i <= 7 ; ++i )
>  -               if( zone = lm85_zone_map[i] )
>  -                       break ;
>  -       if( i > 7 )   /* Not found. */
>  +       for (i = 0; i <= 7; ++i)
>  +               if (zone = lm85_zone_map[i])
>  +                       break;
>  +       if (i > 7)   /* Not found. */
>                 i = 3;  /* Always 100% */
>  -       return( (i & 0x07)<<5 );
>  +       return (i & 0x07) << 5;
>   }
>
>  -#define HYST_TO_REG(val) (SENSORS_LIMIT(((val)+500)/1000,0,15))
>  -#define HYST_FROM_REG(val) ((val)*1000)
>  +#define HYST_TO_REG(val)       SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
>  +#define HYST_FROM_REG(val)     ((val) * 1000)
>
>  -#define OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/25,-127,127))
>  -#define OFFSET_FROM_REG(val) ((val)*25)
>  +#define OFFSET_TO_REG(val)     SENSORS_LIMIT((val) / 25, -127, 127)
>  +#define OFFSET_FROM_REG(val)   ((val) * 25)
>
>  -#define PPR_MASK(fan) (0x03<<(fan *2))
>  -#define PPR_TO_REG(val,fan) (SENSORS_LIMIT((val)-1,0,3)<<(fan *2))
>  -#define PPR_FROM_REG(val,fan) ((((val)>>(fan * 2))&0x03)+1)
>  +#define PPR_MASK(fan)          (0x03 << ((fan) * 2))
>  +#define PPR_TO_REG(val, fan)   (SENSORS_LIMIT((val) - 1, 0, 3) << ((fan) * 2))
>  +#define PPR_FROM_REG(val, fan) ((((val) >> ((fan) * 2)) & 0x03) + 1)
>
>   /* Chip sampling rates
>   *
>  @@ -292,11 +295,11 @@ struct lm85_zone {
>
>         u8 hyst;        /* Low limit hysteresis. (0-15) */
>         u8 range;       /* Temp range, encoded */
>         s8 critical;    /* "All fans ON" temp limit */
>  -       u8 off_desired; /* Actual "off" temperature specified.  Preserved
>  +       u8 off_desired; /* Actual "off" temperature specified.  Preserved
>                          * to prevent "drift" as other autofan control
>                          * values change.
>                          */
>  -       u8 max_desired; /* Actual "max" temperature specified.  Preserved
>  +       u8 max_desired; /* Actual "max" temperature specified.  Preserved
>                          * to prevent "drift" as other autofan control
>                          * values change.
>                          */
>  @@ -375,7 +378,7 @@ static ssize_t show_fan(struct device *d
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr]) );
>  +       return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr]));
>   }
>
>   static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
>  @@ -383,7 +386,7 @@ static ssize_t show_fan_min(struct devic
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr]) );
>  +       return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr]));
>   }
>
>   static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
>  @@ -414,7 +417,8 @@ show_fan_offset(4);
>
>
>   /* vid, vrm, alarms */
>
>  -static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  +static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
>  +               char *buf)
>   {
>         struct lm85_data *data = lm85_update_device(dev);
>         int vid;
>  @@ -432,13 +436,15 @@ static ssize_t show_vid_reg(struct devic
>
>
>   static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
>
>  -static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  +static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
>  +               char *buf)
>   {
>         struct lm85_data *data = dev_get_drvdata(dev);
>         return sprintf(buf, "%ld\n", (long) data->vrm);
>   }
>
>  -static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>  +static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
>  +               const char *buf, size_t count)
>   {
>         struct lm85_data *data = dev_get_drvdata(dev);
>         data->vrm = simple_strtoul(buf, NULL, 10);
>  @@ -447,7 +453,8 @@ static ssize_t store_vrm_reg(struct devi
>
>
>   static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
>
>  -static ssize_t show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  +static ssize_t show_alarms_reg(struct device *dev, struct device_attribute
>  +               *attr, char *buf)
>   {
>         struct lm85_data *data = lm85_update_device(dev);
>         return sprintf(buf, "%u\n", data->alarms);
>  @@ -488,7 +495,7 @@ static ssize_t show_pwm(struct device *d
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm[nr]) );
>  +       return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
>   }
>
>   static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
>  @@ -581,17 +588,16 @@ static ssize_t show_in(struct device *de
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf( buf, "%d\n", INSEXT_FROM_REG(nr,
>  -                                                    data->in[nr],
>  -                                                    data->in_ext[nr]));
>  +       return sprintf(buf, "%d\n", INSEXT_FROM_REG(nr, data->in[nr],
>  +                                                   data->in_ext[nr]));
>   }
>
>  -static ssize_t show_in_min(struct device *dev,  struct device_attribute *attr,
>  +static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
>                 char *buf)
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]) );
>  +       return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_min[nr]));
>   }
>
>   static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
>  @@ -614,7 +620,7 @@ static ssize_t show_in_max(struct device
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]) );
>  +       return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_max[nr]));
>   }
>
>   static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
>  @@ -656,8 +662,8 @@ static ssize_t show_temp(struct device *
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMPEXT_FROM_REG(data->temp[nr],
>  -                                                   data->temp_ext[nr]));
>  +       return sprintf(buf, "%d\n", TEMPEXT_FROM_REG(data->temp[nr],
>  +                                                    data->temp_ext[nr]));
>   }
>
>   static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
>  @@ -665,7 +671,7 @@ static ssize_t show_temp_min(struct devi
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]) );
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
>   }
>
>   static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
>  @@ -688,7 +694,7 @@ static ssize_t show_temp_max(struct devi
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]) );
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
>   }
>
>   static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
>  @@ -697,7 +703,7 @@ static ssize_t set_temp_max(struct devic
>
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct i2c_client *client = to_i2c_client(dev);
>         struct lm85_data *data = i2c_get_clientdata(client);
>  -       long val = simple_strtol(buf, NULL, 10);
>  +       long val = simple_strtol(buf, NULL, 10);
>
>         mutex_lock(&data->update_lock);
>         data->temp_max[nr] = TEMP_TO_REG(val);
>  @@ -726,7 +732,7 @@ static ssize_t show_pwm_auto_channels(st
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", ZONE_FROM_REG(data->autofan[nr].config));
>  +       return sprintf(buf, "%d\n", ZONE_FROM_REG(data->autofan[nr].config));
>   }
>
>   static ssize_t set_pwm_auto_channels(struct device *dev,
>  @@ -735,11 +741,11 @@ static ssize_t set_pwm_auto_channels(str
>
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct i2c_client *client = to_i2c_client(dev);
>         struct lm85_data *data = i2c_get_clientdata(client);
>  -       long val = simple_strtol(buf, NULL, 10);
>  +       long val = simple_strtol(buf, NULL, 10);
>
>         mutex_lock(&data->update_lock);
>         data->autofan[nr].config = (data->autofan[nr].config & (~0xe0))
>  -               | ZONE_TO_REG(val) ;
>  +               | ZONE_TO_REG(val);
>         lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
>                 data->autofan[nr].config);
>         mutex_unlock(&data->update_lock);
>  @@ -751,7 +757,7 @@ static ssize_t show_pwm_auto_pwm_min(str
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
>  +       return sprintf(buf, "%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
>   }
>
>   static ssize_t set_pwm_auto_pwm_min(struct device *dev,
>  @@ -775,7 +781,7 @@ static ssize_t show_pwm_auto_pwm_minctl(
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", data->autofan[nr].min_off);
>  +       return sprintf(buf, "%d\n", data->autofan[nr].min_off);
>   }
>
>   static ssize_t set_pwm_auto_pwm_minctl(struct device *dev,
>  @@ -792,8 +798,7 @@ static ssize_t set_pwm_auto_pwm_minctl(s
>
>                 | data->syncpwm3
>                 | (data->autofan[0].min_off ? 0x20 : 0)
>                 | (data->autofan[1].min_off ? 0x40 : 0)
>  -               | (data->autofan[2].min_off ? 0x80 : 0)
>  -       );
>  +               | (data->autofan[2].min_off ? 0x80 : 0));
>         mutex_unlock(&data->update_lock);
>         return count;
>   }
>  @@ -803,7 +808,7 @@ static ssize_t show_pwm_auto_pwm_freq(st
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", FREQ_FROM_REG(data->autofan[nr].freq));
>  +       return sprintf(buf, "%d\n", FREQ_FROM_REG(data->autofan[nr].freq));
>   }
>
>   static ssize_t set_pwm_auto_pwm_freq(struct device *dev,
>  @@ -818,8 +823,7 @@ static ssize_t set_pwm_auto_pwm_freq(str
>
>         data->autofan[nr].freq = FREQ_TO_REG(val);
>         lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
>                 (data->zone[nr].range << 4)
>  -               | data->autofan[nr].freq
>  -       );
>  +               | data->autofan[nr].freq);
>         mutex_unlock(&data->update_lock);
>         return count;
>   }
>  @@ -849,7 +853,7 @@ static ssize_t show_temp_auto_temp_off(s
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
>                 HYST_FROM_REG(data->zone[nr].hyst));
>   }
>
>  @@ -866,15 +870,13 @@ static ssize_t set_temp_auto_temp_off(st
>
>         min = TEMP_FROM_REG(data->zone[nr].limit);
>         data->zone[nr].off_desired = TEMP_TO_REG(val);
>         data->zone[nr].hyst = HYST_TO_REG(min - val);
>  -       if ( nr = 0 || nr = 1 ) {
>  +       if (nr = 0 || nr = 1) {
>                 lm85_write_value(client, LM85_REG_AFAN_HYST1,
>                         (data->zone[0].hyst << 4)
>  -                       | data->zone[1].hyst
>  -                       );
>  +                       | data->zone[1].hyst);
>         } else {
>                 lm85_write_value(client, LM85_REG_AFAN_HYST2,
>  -                       (data->zone[2].hyst << 4)
>  -               );
>  +                       (data->zone[2].hyst << 4));
>         }
>         mutex_unlock(&data->update_lock);
>         return count;
>  @@ -885,7 +887,7 @@ static ssize_t show_temp_auto_temp_min(s
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) );
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit));
>   }
>
>   static ssize_t set_temp_auto_temp_min(struct device *dev,
>  @@ -913,15 +915,13 @@ static ssize_t set_temp_auto_temp_min(st
>
>         data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
>                 data->zone[nr].limit) - TEMP_FROM_REG(
>                 data->zone[nr].off_desired));
>  -       if ( nr = 0 || nr = 1 ) {
>  +       if (nr = 0 || nr = 1) {
>                 lm85_write_value(client, LM85_REG_AFAN_HYST1,
>                         (data->zone[0].hyst << 4)
>  -                       | data->zone[1].hyst
>  -                       );
>  +                       | data->zone[1].hyst);
>         } else {
>                 lm85_write_value(client, LM85_REG_AFAN_HYST2,
>  -                       (data->zone[2].hyst << 4)
>  -               );
>  +                       (data->zone[2].hyst << 4));
>         }
>         mutex_unlock(&data->update_lock);
>         return count;
>  @@ -932,7 +932,7 @@ static ssize_t show_temp_auto_temp_max(s
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
>                 RANGE_FROM_REG(data->zone[nr].range));
>   }
>
>  @@ -962,11 +962,11 @@ static ssize_t show_temp_auto_temp_crit(
>
>  {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct lm85_data *data = lm85_update_device(dev);
>  -       return sprintf(buf,"%d\n", TEMP_FROM_REG(data->zone[nr].critical));
>  +       return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].critical));
>   }
>
>   static ssize_t set_temp_auto_temp_crit(struct device *dev,
>  -               struct device_attribute *attr,const char *buf, size_t count)
>  +               struct device_attribute *attr, const char *buf, size_t count)
>   {
>         int nr = to_sensor_dev_attr(attr)->index;
>         struct i2c_client *client = to_i2c_client(dev);
>  @@ -1130,7 +1130,7 @@ static const struct attribute_group lm85
>
>  static int lm85_detect(struct i2c_adapter *adapter, int address,
>                 int kind)
>   {
>  -       int company, verstep ;
>  +       int company, verstep;
>         struct i2c_client *new_client = NULL;
>         struct lm85_data *data;
>         int err = 0;
>  @@ -1139,8 +1139,8 @@ static int lm85_detect(struct i2c_adapte
>
>         if (!i2c_check_functionality(adapter,
>                                         I2C_FUNC_SMBUS_BYTE_DATA)) {
>                 /* We need to be able to do byte I/O */
>  -               goto ERROR0 ;
>  -       };
>  +               goto ERROR0;
>  +       }
>
>         /* OK. For now, we presume we have a valid client. We now create the
>            client structure, even though we cannot fill it completely yet.
>  @@ -1171,82 +1171,81 @@ static int lm85_detect(struct i2c_adapte
>
>
>         /* If auto-detecting, Determine the chip type. */
>         if (kind <= 0) {
>                 dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
>  -                       i2c_adapter_id(adapter), address );
>  -               if( company = LM85_COMPANY_NATIONAL
>  -                   && verstep = LM85_VERSTEP_LM85C ) {
>  -                       kind = lm85c ;
>  -               } else if( company = LM85_COMPANY_NATIONAL
>  -                   && verstep = LM85_VERSTEP_LM85B ) {
>  -                       kind = lm85b ;
>  -               } else if( company = LM85_COMPANY_NATIONAL
>  -                   && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {
>  +                       i2c_adapter_id(adapter), address);
>  +               if (company = LM85_COMPANY_NATIONAL
>  +                   && verstep = LM85_VERSTEP_LM85C) {
>  +                       kind = lm85c;
>  +               } else if (company = LM85_COMPANY_NATIONAL
>  +                   && verstep = LM85_VERSTEP_LM85B) {
>  +                       kind = lm85b;
>  +               } else if (company = LM85_COMPANY_NATIONAL
>  +                   && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
>                         dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
>                                 " Defaulting to LM85.\n", verstep);
>  -                       kind = any_chip ;
>  -               } else if( company = LM85_COMPANY_ANALOG_DEV
>  -                   && verstep = LM85_VERSTEP_ADM1027 ) {
>  -                       kind = adm1027 ;
>  -               } else if( company = LM85_COMPANY_ANALOG_DEV
>  +                       kind = any_chip;
>  +               } else if (company = LM85_COMPANY_ANALOG_DEV
>  +                   && verstep = LM85_VERSTEP_ADM1027) {
>  +                       kind = adm1027;
>  +               } else if (company = LM85_COMPANY_ANALOG_DEV
>                     && (verstep = LM85_VERSTEP_ADT7463
>  -                        || verstep = LM85_VERSTEP_ADT7463C) ) {
>  -                       kind = adt7463 ;
>  -               } else if( company = LM85_COMPANY_ANALOG_DEV
>  -                   && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {
>  +                        || verstep = LM85_VERSTEP_ADT7463C)) {
>  +                       kind = adt7463;
>  +               } else if (company = LM85_COMPANY_ANALOG_DEV
>  +                   && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
>                         dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
>  -                               " Defaulting to Generic LM85.\n", verstep );
>  -                       kind = any_chip ;
>  -               } else if( company = LM85_COMPANY_SMSC
>  +                               " Defaulting to Generic LM85.\n", verstep);
>  +                       kind = any_chip;
>  +               } else if (company = LM85_COMPANY_SMSC
>                     && (verstep = LM85_VERSTEP_EMC6D100_A0
>  -                        || verstep = LM85_VERSTEP_EMC6D100_A1) ) {
>  +                        || verstep = LM85_VERSTEP_EMC6D100_A1)) {
>                         /* Unfortunately, we can't tell a '100 from a '101
>                          * from the registers.  Since a '101 is a '100
>                          * in a package with fewer pins and therefore no
>                          * 3.3V, 1.5V or 1.8V inputs, perhaps if those
>                          * inputs read 0, then it's a '101.
>                          */
>  -                       kind = emc6d100 ;
>  -               } else if( company = LM85_COMPANY_SMSC
>  +                       kind = emc6d100;
>  +               } else if (company = LM85_COMPANY_SMSC
>                     && verstep = LM85_VERSTEP_EMC6D102) {
>  -                       kind = emc6d102 ;
>  -               } else if( company = LM85_COMPANY_SMSC
>  +                       kind = emc6d102;
>  +               } else if (company = LM85_COMPANY_SMSC
>                     && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
>                         dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
>                         dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
>  -                           " Defaulting to Generic LM85.\n", verstep );
>  -                       kind = any_chip ;
>  -               } else if( kind = any_chip
>  +                           " Defaulting to Generic LM85.\n", verstep);
>  +                       kind = any_chip;
>  +               } else if (kind = any_chip
>                     && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
>                         dev_err(&adapter->dev, "Generic LM85 Version 6 detected\n");
>                         /* Leave kind as "any_chip" */
>                 } else {
>                         dev_dbg(&adapter->dev, "Autodetection failed\n");
>  -                       /* Not an LM85 ... */
>  -                       if( kind = any_chip ) {  /* User used force=x,y */
>  +                       /* Not an LM85... */
>  +                       if (kind = any_chip) {  /* User used force=x,y */
>                                 dev_err(&adapter->dev, "Generic LM85 Version 6 not"
>                                         " found at %d,0x%02x. Try force_lm85c.\n",
>  -                                       i2c_adapter_id(adapter), address );
>  +                                       i2c_adapter_id(adapter), address);
>                         }
>  -                       err = 0 ;
>  +                       err = 0;
>                         goto ERROR1;
>                 }
>         }
>
>         /* Fill in the chip specific driver values */
>  -       if ( kind = any_chip ) {
>  +       if (kind = any_chip)
>                 type_name = "lm85";
>  -       } else if ( kind = lm85b ) {
>  +       else if (kind = lm85b)
>                 type_name = "lm85b";
>  -       } else if ( kind = lm85c ) {
>  +       else if (kind = lm85c)
>                 type_name = "lm85c";
>  -       } else if ( kind = adm1027 ) {
>  +       else if (kind = adm1027)
>                 type_name = "adm1027";
>  -       } else if ( kind = adt7463 ) {
>  +       else if (kind = adt7463)
>                 type_name = "adt7463";
>  -       } else if ( kind = emc6d100){
>  +       else if (kind = emc6d100)
>                 type_name = "emc6d100";
>  -       } else if ( kind = emc6d102 ) {
>  +       else if (kind = emc6d102)
>                 type_name = "emc6d102";
>  -       }
>         strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
>
>         /* Fill in the remaining client fields */
>  @@ -1291,16 +1290,16 @@ static int lm85_detect(struct i2c_adapte
>
>         return 0;
>
>         /* Error out and cleanup code */
>  -    ERROR3:
>  + ERROR3:
>         sysfs_remove_group(&new_client->dev.kobj, &lm85_group);
>         sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in4);
>         if (kind = emc6d100)
>                 sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in567);
>  -    ERROR2:
>  + ERROR2:
>         i2c_detach_client(new_client);
>  -    ERROR1:
>  + ERROR1:
>         kfree(data);
>  -    ERROR0:
>  + ERROR0:
>         return err;
>   }
>
>  @@ -1323,58 +1322,60 @@ static int lm85_read_value(struct i2c_cl
>
>
>         int res;
>
>         /* What size location is it? */
>  -       switch( reg ) {
>  -       case LM85_REG_FAN(0) :  /* Read WORD data */
>  -       case LM85_REG_FAN(1) :
>  -       case LM85_REG_FAN(2) :
>  -       case LM85_REG_FAN(3) :
>  -       case LM85_REG_FAN_MIN(0) :
>  -       case LM85_REG_FAN_MIN(1) :
>  -       case LM85_REG_FAN_MIN(2) :
>  -       case LM85_REG_FAN_MIN(3) :
>  -       case LM85_REG_ALARM1 :  /* Read both bytes at once */
>  -               res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
>  -               res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
>  -               break ;
>  -       case ADT7463_REG_TMIN_CTL1 :  /* Read WORD MSB, LSB */
>  -               res = i2c_smbus_read_byte_data(client, reg) << 8 ;
>  -               res |= i2c_smbus_read_byte_data(client, reg+1) & 0xff ;
>  -               break ;
>  +       switch (reg) {
>  +       case LM85_REG_FAN(0):  /* Read WORD data */
>  +       case LM85_REG_FAN(1):
>  +       case LM85_REG_FAN(2):
>  +       case LM85_REG_FAN(3):
>  +       case LM85_REG_FAN_MIN(0):
>  +       case LM85_REG_FAN_MIN(1):
>  +       case LM85_REG_FAN_MIN(2):
>  +       case LM85_REG_FAN_MIN(3):
>  +       case LM85_REG_ALARM1:   /* Read both bytes at once */
>  +               res = i2c_smbus_read_byte_data(client, reg) & 0xff;
>  +               res |= i2c_smbus_read_byte_data(client, reg + 1) << 8;
>  +               break;
>  +       case ADT7463_REG_TMIN_CTL1:  /* Read WORD MSB, LSB */
>  +               res = i2c_smbus_read_byte_data(client, reg) << 8;
>  +               res |= i2c_smbus_read_byte_data(client, reg + 1) & 0xff;
>  +               break;
>         default:        /* Read BYTE data */
>                 res = i2c_smbus_read_byte_data(client, reg);
>  -               break ;
>  +               break;
>         }
>
>  -       return res ;
>  +       return res;
>   }
>
>   static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
>   {
>  -       int res ;
>  +       int res;
>
>  -       switch( reg ) {
>  -       case LM85_REG_FAN(0) :  /* Write WORD data */
>  -       case LM85_REG_FAN(1) :
>  -       case LM85_REG_FAN(2) :
>  -       case LM85_REG_FAN(3) :
>  -       case LM85_REG_FAN_MIN(0) :
>  -       case LM85_REG_FAN_MIN(1) :
>  -       case LM85_REG_FAN_MIN(2) :
>  -       case LM85_REG_FAN_MIN(3) :
>  +       switch (reg) {
>  +       case LM85_REG_FAN(0):  /* Write WORD data */
>  +       case LM85_REG_FAN(1):
>  +       case LM85_REG_FAN(2):
>  +       case LM85_REG_FAN(3):
>  +       case LM85_REG_FAN_MIN(0):
>  +       case LM85_REG_FAN_MIN(1):
>  +       case LM85_REG_FAN_MIN(2):
>  +       case LM85_REG_FAN_MIN(3):
>         /* NOTE: ALARM is read only, so not included here */
>  -               res = i2c_smbus_write_byte_data(client, reg, value & 0xff) ;
>  -               res |= i2c_smbus_write_byte_data(client, reg+1, (value>>8) & 0xff) ;
>  -               break ;
>  -       case ADT7463_REG_TMIN_CTL1 :  /* Write WORD MSB, LSB */
>  -               res = i2c_smbus_write_byte_data(client, reg, (value>>8) & 0xff);
>  -               res |= i2c_smbus_write_byte_data(client, reg+1, value & 0xff) ;
>  -               break ;
>  +               res = i2c_smbus_write_byte_data(client, reg, value & 0xff);
>  +               res |= i2c_smbus_write_byte_data(client, reg + 1,
>  +                                                (value >> 8) & 0xff);
>  +               break;
>  +       case ADT7463_REG_TMIN_CTL1:  /* Write WORD MSB, LSB */
>  +               res = i2c_smbus_write_byte_data(client, reg,
>  +                                               (value >> 8) & 0xff);
>  +               res |= i2c_smbus_write_byte_data(client, reg + 1, value & 0xff);
>  +               break;
>         default:        /* Write BYTE data */
>                 res = i2c_smbus_write_byte_data(client, reg, value);
>  -               break ;
>  +               break;
>         }
>
>  -       return res ;
>  +       return res;
>   }
>
>   static void lm85_init_client(struct i2c_client *client)
>  @@ -1387,21 +1388,21 @@ static void lm85_init_client(struct i2c_
>
>
>         /* Warn if part was not "READY" */
>         value = lm85_read_value(client, LM85_REG_CONFIG);
>         dev_dbg(&client->dev, "LM85_REG_CONFIG is: 0x%02x\n", value);
>  -       if( value & 0x02 ) {
>  +       if (value & 0x02) {
>                 dev_err(&client->dev, "Client (%d,0x%02x) config is locked.\n",
>  -                           i2c_adapter_id(client->adapter), client->addr );
>  -       };
>  -       if( ! (value & 0x04) ) {
>  +                       i2c_adapter_id(client->adapter), client->addr);
>  +       }
>  +       if (!(value & 0x04)) {
>                 dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
>  -                           i2c_adapter_id(client->adapter), client->addr );
>  -       };
>  -       if( value & 0x10
>  -           && ( data->type = adm1027
>  -               || data->type = adt7463 ) ) {
>  +                       i2c_adapter_id(client->adapter), client->addr);
>  +       }
>  +       if (value & 0x10
>  +           && (data->type = adm1027
>  +               || data->type = adt7463)) {
>                 dev_err(&client->dev, "Client (%d,0x%02x) VxI mode is set.  "
>                         "Please report this to the lm85 maintainer.\n",
>  -                           i2c_adapter_id(client->adapter), client->addr );
>  -       };
>  +                       i2c_adapter_id(client->adapter), client->addr);
>  +       }
>
>         /* WE INTENTIONALLY make no changes to the limits,
>          *   offsets, pwms, fans and zones.  If they were
>  @@ -1414,7 +1415,7 @@ static void lm85_init_client(struct i2c_
>
>         /* Start monitoring */
>         value = lm85_read_value(client, LM85_REG_CONFIG);
>         /* Try to clear LOCK, Set START, save everything else */
>  -       value = (value & ~ 0x02) | 0x01 ;
>  +       value = (value & ~0x02) | 0x01;
>         dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
>         lm85_write_value(client, LM85_REG_CONFIG, value);
>   }
>  @@ -1427,28 +1428,30 @@ static struct lm85_data *lm85_update_dev
>
>
>         mutex_lock(&data->update_lock);
>
>  -       if ( !data->valid ||
>  -            time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL) ) {
>  +       if (!data->valid ||
>  +            time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL)) {
>                 /* Things that change quickly */
>                 dev_dbg(&client->dev, "Reading sensor values\n");
>  -
>  +
>                 /* Have to read extended bits first to "freeze" the
>                  * more significant bits that are read later.
>                  * There are 2 additional resolution bits per channel and we
>                  * have room for 4, so we shift them to the left.
>                  */
>  -               if ( (data->type = adm1027) || (data->type = adt7463) ) {
>  +               if (data->type = adm1027 || data->type = adt7463) {
>                         int ext1 = lm85_read_value(client,
>                                                    ADM1027_REG_EXTEND_ADC1);
>                         int ext2 =  lm85_read_value(client,
>                                                     ADM1027_REG_EXTEND_ADC2);
>                         int val = (ext1 << 8) + ext2;
>
>  -                       for(i = 0; i <= 4; i++)
>  -                               data->in_ext[i] = ((val>>(i * 2))&0x03) << 2;
>  -
>
> -                       for(i = 0; i <= 2; i++)
>  -                               data->temp_ext[i] = (val>>((i + 4) * 2))&0x0c;
>  +                       for (i = 0; i <= 4; i++)
>  +                               data->in_ext[i] >  +                                       ((val >> (i * 2)) & 0x03) << 2;
>  +
>  +                       for (i = 0; i <= 2; i++)
>  +                               data->temp_ext[i] >  +                                       (val >> ((i + 4) * 2)) & 0x0c;
>                 }
>
>
>                 data->vid = lm85_read_value(client, LM85_REG_VID);
>  @@ -1480,21 +1483,21 @@ static struct lm85_data *lm85_update_dev
>
>
>
>                 data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
>
>  -               if ( data->type = adt7463 ) {
>  -                       if( data->therm_total < ULONG_MAX - 256 ) {
>  +               if (data->type = adt7463) {
>  +                       if (data->therm_total < ULONG_MAX - 256) {
>                             data->therm_total +>  -                               lm85_read_value(client, ADT7463_REG_THERM );
>  +                               lm85_read_value(client, ADT7463_REG_THERM);
>                         }
>  -               } else if ( data->type = emc6d100 ) {
>  +               } else if (data->type = emc6d100) {
>                         /* Three more voltage sensors */
>                         for (i = 5; i <= 7; ++i) {
>  -                               data->in[i] >  -                                       lm85_read_value(client, EMC6D100_REG_IN(i));
>  +                               data->in[i] = lm85_read_value(client,
>  +                                                       EMC6D100_REG_IN(i));
>                         }
>                         /* More alarm bits */
>  -                       data->alarms |>  -                               lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
>  -               } else if (data->type = emc6d102 ) {
>  +                       data->alarms |= lm85_read_value(client,
>  +                                               EMC6D100_REG_ALARM3) << 16;
>  +               } else if (data->type = emc6d102) {
>                         /* Have to read LSB bits after the MSB ones because
>                            the reading of the MSB bits has frozen the
>                            LSBs (backward from the ADM1027).
>  @@ -1518,11 +1521,11 @@ static struct lm85_data *lm85_update_dev
>
>                         data->temp_ext[2] = (ext1 >> 4) & 0x0f;
>                 }
>
>  -               data->last_reading = jiffies ;
>  -       };  /* last_reading */
>  +               data->last_reading = jiffies;
>  +       }  /* last_reading */
>
>  -       if ( !data->valid ||
>  -            time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL) ) {
>  +       if (!data->valid ||
>  +            time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL)) {
>                 /* Things that don't change often */
>                 dev_dbg(&client->dev, "Reading config values\n");
>
>  @@ -1540,12 +1543,12 @@ static struct lm85_data *lm85_update_dev
>
>                                           LM85_REG_IN_MAX(4));
>                 }
>
>  -               if ( data->type = emc6d100 ) {
>  +               if (data->type = emc6d100) {
>                         for (i = 5; i <= 7; ++i) {
>  -                               data->in_min[i] >  -                                       lm85_read_value(client, EMC6D100_REG_IN_MIN(i));
>  -                               data->in_max[i] >  -                                       lm85_read_value(client, EMC6D100_REG_IN_MAX(i));
>  +                               data->in_min[i] = lm85_read_value(client,
>  +                                               EMC6D100_REG_IN_MIN(i));
>  +                               data->in_max[i] = lm85_read_value(client,
>  +                                               EMC6D100_REG_IN_MAX(i));
>                         }
>                 }
>
>  @@ -1562,12 +1565,12 @@ static struct lm85_data *lm85_update_dev
>
>                 }
>
>                 for (i = 0; i <= 2; ++i) {
>  -                       int val ;
>  +                       int val;
>                         data->autofan[i].config >                             lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
>                         val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
>  -                       data->autofan[i].freq = val & 0x07 ;
>  -                       data->zone[i].range = (val >> 4) & 0x0f ;
>  +                       data->autofan[i].freq = val & 0x07;
>  +                       data->zone[i].range = (val >> 4) & 0x0f;
>                         data->autofan[i].min_pwm >                             lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
>                         data->zone[i].limit >  @@ -1577,50 +1580,50 @@ static struct lm85_data *lm85_update_dev
>
>
>                 }
>
>                 i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
>  -               data->smooth[0] = i & 0x0f ;
>  -               data->syncpwm3 = i & 0x10 ;  /* Save PWM3 config */
>  -               data->autofan[0].min_off = (i & 0x20) != 0 ;
>  -               data->autofan[1].min_off = (i & 0x40) != 0 ;
>  -               data->autofan[2].min_off = (i & 0x80) != 0 ;
>  +               data->smooth[0] = i & 0x0f;
>  +               data->syncpwm3 = i & 0x10;  /* Save PWM3 config */
>  +               data->autofan[0].min_off = (i & 0x20) != 0;
>  +               data->autofan[1].min_off = (i & 0x40) != 0;
>  +               data->autofan[2].min_off = (i & 0x80) != 0;
>                 i = lm85_read_value(client, LM85_REG_AFAN_SPIKE2);
>  -               data->smooth[1] = (i>>4) & 0x0f ;
>  -               data->smooth[2] = i & 0x0f ;
>  +               data->smooth[1] = (i >> 4) & 0x0f;
>  +               data->smooth[2] = i & 0x0f;
>
>                 i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
>  -               data->zone[0].hyst = (i>>4) & 0x0f ;
>  -               data->zone[1].hyst = i & 0x0f ;
>  +               data->zone[0].hyst = (i >> 4) & 0x0f;
>  +               data->zone[1].hyst = i & 0x0f;
>
>                 i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
>  -               data->zone[2].hyst = (i>>4) & 0x0f ;
>  +               data->zone[2].hyst = (i >> 4) & 0x0f;
>
>  -               if ( (data->type = lm85b) || (data->type = lm85c) ) {
>  +               if (data->type = lm85b || data->type = lm85c) {
>                         data->tach_mode = lm85_read_value(client,
>  -                               LM85_REG_TACH_MODE );
>  +                               LM85_REG_TACH_MODE);
>                         data->spinup_ctl = lm85_read_value(client,
>  -                               LM85_REG_SPINUP_CTL );
>  -               } else if ( (data->type = adt7463) || (data->type = adm1027) ) {
>  -                       if ( data->type = adt7463 ) {
>  +                               LM85_REG_SPINUP_CTL);
>  +               } else if (data->type = adt7463 || data->type = adm1027) {
>  +                       if (data->type = adt7463) {
>                                 for (i = 0; i <= 2; ++i) {
>                                     data->oppoint[i] = lm85_read_value(client,
>  -                                       ADT7463_REG_OPPOINT(i) );
>  +                                       ADT7463_REG_OPPOINT(i));
>                                 }
>                                 data->tmin_ctl = lm85_read_value(client,
>  -                                       ADT7463_REG_TMIN_CTL1 );
>  +                                       ADT7463_REG_TMIN_CTL1);
>                                 data->therm_limit = lm85_read_value(client,
>  -                                       ADT7463_REG_THERM_LIMIT );
>  +                                       ADT7463_REG_THERM_LIMIT);
>                         }
>                         for (i = 0; i <= 2; ++i) {
>  -                           data->temp_offset[i] = lm85_read_value(client,
>  -                               ADM1027_REG_TEMP_OFFSET(i) );
>  +                               data->temp_offset[i] = lm85_read_value(client,
>  +                                               ADM1027_REG_TEMP_OFFSET(i));
>                         }
>                         data->tach_mode = lm85_read_value(client,
>  -                               ADM1027_REG_CONFIG3 );
>  +                               ADM1027_REG_CONFIG3);
>                         data->fan_ppr = lm85_read_value(client,
>  -                               ADM1027_REG_FAN_PPR );
>  +                               ADM1027_REG_FAN_PPR);
>                 }
>  -
>  +
>                 data->last_config = jiffies;
>  -       };  /* last_config */
>  +       }  /* last_config */
>
>         data->valid = 1;
>
>  @@ -1635,7 +1638,7 @@ static int __init sm_lm85_init(void)
>         return i2c_add_driver(&lm85_driver);
>   }
>
>  -static void  __exit sm_lm85_exit(void)
>  +static void __exit sm_lm85_exit(void)
>   {
>         i2c_del_driver(&lm85_driver);
>   }
>  @@ -1645,7 +1648,9 @@ static void  __exit sm_lm85_exit(void)
>
>
>   *     post 2.7.0 CVS changes.
>   */
>   MODULE_LICENSE("GPL");
>  -MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>, Justin Thiessen <jthiessen@penguincomputing.com");
>  +MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, "
>  +       "Margit Schubert-While <margitsw@t-online.de>, "
>  +       "Justin Thiessen <jthiessen@penguincomputing.com");
>   MODULE_DESCRIPTION("LM85-B, LM85-C driver");
>
>   module_init(sm_lm85_init);
>
>  --
>  Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
