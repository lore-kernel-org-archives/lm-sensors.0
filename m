From: Juerg Haefliger <juergh@gmail.com>
Date: Fri, 09 Apr 2010 17:20:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add sch5127 support to dme1737
Message-Id: <x2t191fb4ca1004091020i87779471t9716a45601672660@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
In-Reply-To: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry for the slow response. The past few months have been quite hectic..


> Hi Juerg,
>
> On Tue, 19 Jan 2010 21:15:43 -0800, Juerg Haefliger wrote:
>> This patch adds support for the hardware monitoring capabilities of
>> the sch5127 chip to the dme1737 driver.
>
> Thanks for doing this. Review:
>
>> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>> (...)
>> Index: linux-2.6.33-rc2/Documentation/hwmon/dme1737
>> =================================>> --- linux-2.6.33-rc2.orig/Documentation/hwmon/dme1737 2009-12-26 12:37:20.000000000 -0800
>> +++ linux-2.6.33-rc2/Documentation/hwmon/dme1737      2010-01-03 13:47:26.000000000 -0800
>> @@ -9,11 +9,15 @@
>>    * SMSC SCH3112, SCH3114, SCH3116
>>      Prefix: 'sch311x'
>>      Addresses scanned: none, address read from Super-I/O config space
>> -    Datasheet: http://www.nuhorizons.com/FeaturedProducts/Volume1/SMSC/311x.pdf
>> +    Datasheet: http://www.google.com/search?q=sch311x+pdf
>
> I don't think it makes sense to provide such links... there's no
> guarantee the search will return anything relevant in the future. And
> people can use whatever search engine they like...

Ok. Will just add a not that it's available from the web.


>>    * SMSC SCH5027
>>      Prefix: 'sch5027'
>>      Addresses scanned: I2C 0x2c, 0x2d, 0x2e
>>      Datasheet: Provided by SMSC upon request and under NDA
>> +  * SMSC SCH5127
>> +    Prefix: 'sch5127'
>> +    Addresses scanned: none, address read from Super-I/O config space
>> +    Datasheet: Provided by SMSC upon request and under NDA
>>
>>  Authors:
>>      Juerg Haefliger <juergh@gmail.com>
>> @@ -36,8 +40,8 @@
>>  -----------
>>
>>  This driver implements support for the hardware monitoring capabilities of the
>> -SMSC DME1737 and Asus A8000 (which are the same), SMSC SCH5027, and SMSC
>> -SCH311x Super-I/O chips. These chips feature monitoring of 3 temp sensors
>> +SMSC DME1737 and Asus A8000 (which are the same), SMSC SCH5027, SCH311x,
>> +and SCH5127 Super-I/O chips. These chips feature monitoring of 3 temp sensors
>>  temp[1-3] (2 remote diodes and 1 internal), 7 voltages in[0-6] (6 external and
>>  1 internal) and up to 6 fan speeds fan[1-6]. Additionally, the chips implement
>>  up to 5 PWM outputs pwm[1-3,5-6] for controlling fan speeds both manually and
>> @@ -48,14 +52,14 @@
>>  the configuration of the chip. The driver will detect which features are
>>  present during initialization and create the sysfs attributes accordingly.
>>
>> -For the SCH311x, fan[1-3] and pwm[1-3] are always present and fan[4-6] and
>> -pwm[5-6] don't exist.
>> +For the SCH311x and SCH5127, fan[1-3] and pwm[1-3] are always present and
>> +fan[4-6] and pwm[5-6] don't exist.
>>
>>  The hardware monitoring features of the DME1737, A8000, and SCH5027 are only
>> -accessible via SMBus, while the SCH311x only provides access via the ISA bus.
>> -The driver will therefore register itself as an I2C client driver if it detects
>> -a DME1737, A8000, or SCH5027 and as a platform driver if it detects a SCH311x
>> -chip.
>> +accessible via SMBus, while the SCH311x and SCH5127 only provide access via
>> +the ISA bus. The driver will therefore register itself as an I2C client driver
>> +if it detects a DME1737, A8000, or SCH5027 and as a platform driver if it
>> +detects a SCH311x or SCH5127 chip.
>>
>>
>>  Voltage Monitoring
>> @@ -76,7 +80,7 @@
>>       in6: Vbat       (+3.0V)                 0V - 4.38V
>>
>>  SCH311x:
>> -     in0: +2.5V                              0V - 6.64V
>> +     in0: +2.5V                              0V - 3.32V
>>       in1: Vccp       (processor core)        0V - 2V
>>       in2: VCC        (internal +3.3V)        0V - 4.38V
>>       in3: +5V                                0V - 6.64V
>> @@ -93,6 +97,15 @@
>>       in5: VTR        (+3.3V standby)         0V - 4.38V
>>       in6: Vbat       (+3.0V)                 0V - 4.38V
>>
>> +SCH5127:
>> +     in0: +2.5                               0V - 3.32V
>> +     in1: Vccp       (processor core)        0V - 3V
>> +     in2: VCC        (internal +3.3V)        0V - 4.38V
>> +     in3: V2_IN                              0V - 1.5V
>> +     in4: V1_IN                              0V - 1.5V
>> +     in5: VTR        (+3.3V standby)         0V - 4.38V
>> +     in6: Vbat       (+3.0V)                 0V - 4.38V
>> +
>>  Each voltage input has associated min and max limits which trigger an alarm
>>  when crossed.
>>
>> @@ -293,3 +306,21 @@
>>  pwm[1-3]_auto_point2_pwm     RO      Auto PWM pwm point. Auto_point2 is the
>>                                       full-speed duty-cycle which is hard-
>>                                       wired to 255 (100% duty-cycle).
>> +
>> +Chip Differences
>> +----------------
>> +
>> +Feature                      dme1737 sch311x sch5027 sch5127
>> +-------------------------------------------------------
>> +temp[1-3]_offset     yes     yes
>> +vid                  yes
>> +zone3                        yes     yes     yes
>> +zone[1-3]_hyst               yes     yes
>> +pwm min/off          yes     yes
>> +fan3                 opt     yes     opt     yes
>> +pwm3                 opt     yes     opt     yes
>> +fan4                 opt             opt
>> +fan5                 opt             opt
>> +pwm5                 opt             opt
>> +fan6                 opt             opt
>> +pwm6                 opt             opt
>> Index: linux-2.6.33-rc2/drivers/hwmon/dme1737.c
>> =================================>> --- linux-2.6.33-rc2.orig/drivers/hwmon/dme1737.c     2009-12-26 12:37:21.000000000 -0800
>> +++ linux-2.6.33-rc2/drivers/hwmon/dme1737.c  2010-01-03 13:37:14.000000000 -0800
>> @@ -1,12 +1,14 @@
>>  /*
>> - * dme1737.c - Driver for the SMSC DME1737, Asus A8000, SMSC SCH311x and
>> - *             SCH5027 Super-I/O chips integrated hardware monitoring features.
>> - * Copyright (c) 2007, 2008 Juerg Haefliger <juergh@gmail.com>
>> + * dme1737.c - Driver for the SMSC DME1737, Asus A8000, SMSC SCH311x, SCH5027,
>> + *             and SCH5127 Super-I/O chips integrated hardware monitoring
>> + *             features.
>> + * Copyright (c) 2007, 2008, 2009 Juerg Haefliger <juergh@gmail.com>
>
> You might want to add 2010...

Will do.


>>   *
>>   * This driver is an I2C/ISA hybrid, meaning that it uses the I2C bus to access
>>   * the chip registers if a DME1737, A8000, or SCH5027 is found and the ISA bus
>> - * if a SCH311x chip is found. Both types of chips have very similar hardware
>> - * monitoring capabilities but differ in the way they can be accessed.
>> + * if a SCH311x or SCH5127 chip is found. Both types of chips have very
>> + * similar hardware monitoring capabilities but differ in the way they can be
>> + * accessed.
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -57,7 +59,7 @@
>>  /* Addresses to scan */
>>  static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
>>
>> -enum chips { dme1737, sch5027, sch311x };
>> +enum chips { dme1737, sch5027, sch311x, sch5127 };
>>
>>  /* ---------------------------------------------------------------------
>>   * Registers
>> @@ -164,10 +166,29 @@
>>  #define DME1737_VERSTEP_MASK 0xf8
>>  #define SCH311X_DEVICE               0x8c
>>  #define SCH5027_VERSTEP              0x69
>> +#define SCH5127_DEVICE               0x8e
>> +
>> +/* Device ID values (global configuration register index 0x20) */
>> +#define DME1737_ID_1 0x77
>> +#define DME1737_ID_2 0x78
>> +#define SCH3112_ID   0x7c
>> +#define SCH3114_ID   0x7d
>> +#define SCH3116_ID   0x7f
>> +#define SCH5027_ID   0x89
>> +#define SCH5127_ID   0x86
>>
>>  /* Length of ISA address segment */
>>  #define DME1737_EXTENT       2
>>
>> +/* chip-dependent features */
>> +#define HAS_TEMP_OFFSET              (1 << 0)                /* bit 0 */
>> +#define HAS_VID                      (1 << 1)                /* bit 1 */
>> +#define HAS_ZONE3            (1 << 2)                /* bit 2 */
>> +#define HAS_ZONE_HYST                (1 << 3)                /* bit 3 */
>> +#define HAS_PWM_MIN          (1 << 4)                /* bit 4 */
>> +#define HAS_FAN(ix)          (1 << ((ix) + 5))       /* bits 5-10 */
>> +#define HAS_PWM(ix)          (1 << ((ix) + 11))      /* bits 11-16 */
>> +
>>  /* ---------------------------------------------------------------------
>>   * Data structures and manipulation thereof
>>   * --------------------------------------------------------------------- */
>> @@ -187,8 +208,7 @@
>>
>>       u8 vid;
>>       u8 pwm_rr_en;
>> -     u8 has_pwm;
>> -     u8 has_fan;
>> +     u32 has_features;
>
> Hmm. While I'm generally fine with the idea of having feature flags, I
> don't think that including has_pwm and has_fan in has_features was
> really necessary. This causes code changes which would have been avoided
> otherwise, for no benefit that I can see. The only benefit I could see
> would be if you shifted all the indexes by 1 so that for example
> HAS_FAN(2) refers to fan2 and not fan3, but you didn't even do that...

I just like to have it all in one place. Makes it easier for me to maintain it.
Regarding the fan/pwm index: Yes, it's not pretty but it matches the
array index (rather than the number in the attribute name). I had to
pick on or the other and chose the array.


>>
>>       /* Register values */
>>       u16 in[7];
>> @@ -224,8 +244,11 @@
>>                                        3300};
>>  static const int IN_NOMINAL_SCH5027[] = {5000, 2250, 3300, 1125, 1125, 3300,
>>                                        3300};
>> +static const int IN_NOMINAL_SCH5127[] = {2500, 2250, 3300, 1125, 1125, 3300,
>> +                                      3300};
>>  #define IN_NOMINAL(type)     ((type) = sch311x ? IN_NOMINAL_SCH311x : \
>>                                (type) = sch5027 ? IN_NOMINAL_SCH5027 : \
>> +                              (type) = sch5127 ? IN_NOMINAL_SCH5127 : \
>>                                IN_NOMINAL_DME1737)
>>
>>  /* Voltage input
>> @@ -568,7 +591,7 @@
>>
>>       /* Sample register contents every 1 sec */
>>       if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
>> -             if (data->type = dme1737) {
>> +             if (data->has_features & HAS_VID) {
>>                       data->vid = dme1737_read(data, DME1737_REG_VID) &
>>                               0x3f;
>>               }
>> @@ -599,7 +622,7 @@
>>                                       DME1737_REG_TEMP_MIN(ix));
>>                       data->temp_max[ix] = dme1737_read(data,
>>                                       DME1737_REG_TEMP_MAX(ix));
>> -                     if (data->type != sch5027) {
>> +                     if (data->has_features & HAS_TEMP_OFFSET) {
>>                               data->temp_offset[ix] = dme1737_read(data,
>>                                               DME1737_REG_TEMP_OFFSET(ix));
>>                       }
>> @@ -626,7 +649,7 @@
>>               for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
>>                       /* Skip reading registers if optional fans are not
>>                        * present */
>> -                     if (!(data->has_fan & (1 << ix))) {
>> +                     if (!(data->has_features & HAS_FAN(ix))) {
>>                               continue;
>>                       }
>>                       data->fan[ix] = dme1737_read(data,
>> @@ -650,7 +673,7 @@
>>               for (ix = 0; ix < ARRAY_SIZE(data->pwm); ix++) {
>>                       /* Skip reading registers if optional PWMs are not
>>                        * present */
>> -                     if (!(data->has_pwm & (1 << ix))) {
>> +                     if (!(data->has_features & HAS_PWM(ix))) {
>>                               continue;
>>                       }
>>                       data->pwm[ix] = dme1737_read(data,
>> @@ -672,12 +695,24 @@
>>
>>               /* Thermal zone registers */
>>               for (ix = 0; ix < ARRAY_SIZE(data->zone_low); ix++) {
>> -                     data->zone_low[ix] = dme1737_read(data,
>> -                                     DME1737_REG_ZONE_LOW(ix));
>> -                     data->zone_abs[ix] = dme1737_read(data,
>> -                                     DME1737_REG_ZONE_ABS(ix));
>> +                     /* Skip reading registers if zone3 is not present */
>> +                     if ((ix = 2) && !(data->has_features & HAS_ZONE3)) {
>> +                             continue;
>> +                     }
>> +                     /* sch5127 zone2 registers are special */
>> +                     if ((ix = 1) && (data->type = sch5127)) {
>> +                             data->zone_low[1] = dme1737_read(data,
>> +                                             DME1737_REG_ZONE_LOW(2));
>> +                             data->zone_abs[1] = dme1737_read(data,
>> +                                             DME1737_REG_ZONE_ABS(2));
>> +                     } else {
>> +                             data->zone_low[ix] = dme1737_read(data,
>> +                                             DME1737_REG_ZONE_LOW(ix));
>> +                             data->zone_abs[ix] = dme1737_read(data,
>> +                                             DME1737_REG_ZONE_ABS(ix));
>> +                     }
>>               }
>> -             if (data->type != sch5027) {
>> +             if (data->has_features & HAS_ZONE_HYST) {
>>                       for (ix = 0; ix < ARRAY_SIZE(data->zone_hyst); ix++) {
>>                               data->zone_hyst[ix] = dme1737_read(data,
>>                                               DME1737_REG_ZONE_HYST(ix));
>> @@ -1594,10 +1629,6 @@
>>       &sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone2_auto_channels_temp.dev_attr.attr,
>> -     &sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
>> -     &sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
>> -     &sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
>> -     &sensor_dev_attr_zone3_auto_channels_temp.dev_attr.attr,
>>       NULL
>>  };
>>
>> @@ -1605,27 +1636,23 @@
>>       .attrs = dme1737_attr,
>>  };
>>
>> -/* The following struct holds misc attributes, which are not available in all
>> - * chips. Their creation depends on the chip type which is determined during
>> - * module load. */
>> -static struct attribute *dme1737_misc_attr[] = {
>> -     /* Temperatures */
>> +/* The following struct holds temp offset attributes, which are not available
>> + * in all chips. The following chips support them:
>> + * DME1737, SCH311x */
>> +static struct attribute *dme1737_temp_offset_attr[] = {
>>       &sensor_dev_attr_temp1_offset.dev_attr.attr,
>>       &sensor_dev_attr_temp2_offset.dev_attr.attr,
>>       &sensor_dev_attr_temp3_offset.dev_attr.attr,
>> -     /* Zones */
>> -     &sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
>> -     &sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
>> -     &sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
>>       NULL
>>  };
>>
>> -static const struct attribute_group dme1737_misc_group = {
>> -     .attrs = dme1737_misc_attr,
>> +static const struct attribute_group dme1737_temp_offset_group = {
>> +     .attrs = dme1737_temp_offset_attr,
>>  };
>>
>> -/* The following struct holds VID-related attributes. Their creation
>> -   depends on the chip type which is determined during module load. */
>> +/* The following struct holds VID related attributes, which are not available
>> + * in all chips. The following chips support them:
>> + * DME1737 */
>>  static struct attribute *dme1737_vid_attr[] = {
>>       &dev_attr_vrm.attr,
>>       &dev_attr_cpu0_vid.attr,
>> @@ -1636,6 +1663,36 @@
>>       .attrs = dme1737_vid_attr,
>>  };
>>
>> +/* The following struct holds temp zone 3 related attributes, which are not
>> + * available in all chips. The following chips support them:
>> + * DME1737, SCH311x, SCH5027 */
>> +static struct attribute *dme1737_zone3_attr[] = {
>> +     &sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
>> +     &sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
>> +     &sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
>> +     &sensor_dev_attr_zone3_auto_channels_temp.dev_attr.attr,
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group dme1737_zone3_group = {
>> +     .attrs = dme1737_zone3_attr,
>> +};
>> +
>> +
>> +/* The following struct holds temp zone hysteresis  related attributes, which
>> + * are not available in all chips. The following chips support them:
>> + * DME1737, SCH311x */
>> +static struct attribute *dme1737_zone_hyst_attr[] = {
>> +     &sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
>> +     &sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group dme1737_zone_hyst_group = {
>> +     .attrs = dme1737_zone_hyst_attr,
>> +};
>> +
>>  /* The following structs hold the PWM attributes, some of which are optional.
>>   * Their creation depends on the chip configuration which is determined during
>>   * module load. */
>> @@ -1691,10 +1748,10 @@
>>       { .attrs = dme1737_pwm6_attr },
>>  };
>>
>> -/* The following struct holds misc PWM attributes, which are not available in
>> - * all chips. Their creation depends on the chip type which is determined
>> +/* The following struct holds auto PWM min attributes, which are not available
>> + * in all chips. Their creation depends on the chip type which is determined
>>   * during module load. */
>> -static struct attribute *dme1737_pwm_misc_attr[] = {
>> +static struct attribute *dme1737_auto_pwm_min_attr[] = {
>>       &sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
>>       &sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
>>       &sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
>> @@ -1764,14 +1821,25 @@
>>       &sensor_dev_attr_zone2_auto_point1_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group dme1737_zone_chmod_group = {
>> +     .attrs = dme1737_zone_chmod_attr,
>> +};
>> +
>> +
>> +/* The permissions of the following zone 3 attributes are changed to read-
>> + * writeable if the chip is *not* locked. Otherwise they stay read-only. */
>> +static struct attribute *dme1737_zone3_chmod_attr[] = {
>>       &sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
>>       &sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
>>       NULL
>>  };
>>
>> -static const struct attribute_group dme1737_zone_chmod_group = {
>> -     .attrs = dme1737_zone_chmod_attr,
>> +static const struct attribute_group dme1737_zone3_chmod_group = {
>> +     .attrs = dme1737_zone3_chmod_attr,
>>  };
>>
>>  /* The permissions of the following PWM attributes are changed to read-
>> @@ -1887,30 +1955,35 @@
>>       int ix;
>>
>>       for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
>> -             if (data->has_fan & (1 << ix)) {
>> +             if (data->has_features & HAS_FAN(ix)) {
>>                       sysfs_remove_group(&dev->kobj,
>>                                          &dme1737_fan_group[ix]);
>>               }
>>       }
>>
>>       for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_group); ix++) {
>> -             if (data->has_pwm & (1 << ix)) {
>> +             if (data->has_features & HAS_PWM(ix)) {
>>                       sysfs_remove_group(&dev->kobj,
>>                                          &dme1737_pwm_group[ix]);
>> -                     if (data->type != sch5027 && ix < 3) {
>> +                     if (data->has_features & HAS_PWM_MIN) {
>
> It doesn't seem right to me to remove the condition "ix < 3".
> dme1737_pwm_group has 6 elements, dme1737_auto_pwm_min_attr has only 3.

That's a defect. Good catch.


>>                               sysfs_remove_file(&dev->kobj,
>> -                                               dme1737_pwm_misc_attr[ix]);
>> +                                             dme1737_auto_pwm_min_attr[ix]);
>>                       }
>>               }
>>       }
>>
>> -     if (data->type != sch5027) {
>> -             sysfs_remove_group(&dev->kobj, &dme1737_misc_group);
>> +     if (data->has_features & HAS_TEMP_OFFSET) {
>> +             sysfs_remove_group(&dev->kobj, &dme1737_temp_offset_group);
>>       }
>> -     if (data->type = dme1737) {
>> +     if (data->has_features & HAS_VID) {
>>               sysfs_remove_group(&dev->kobj, &dme1737_vid_group);
>>       }
>> -
>> +     if (data->has_features & HAS_ZONE3) {
>> +             sysfs_remove_group(&dev->kobj, &dme1737_zone3_group);
>> +     }
>> +     if (data->has_features & HAS_ZONE_HYST) {
>> +             sysfs_remove_group(&dev->kobj, &dme1737_zone_hyst_group);
>> +     }
>>       sysfs_remove_group(&dev->kobj, &dme1737_group);
>>
>>       if (!data->client) {
>> @@ -1934,23 +2007,31 @@
>>               goto exit_remove;
>>       }
>>
>> -     /* Create misc sysfs attributes */
>> -     if ((data->type != sch5027) &&
>> +     /* Create chip-dependent sysfs attributes */
>> +     if ((data->has_features & HAS_TEMP_OFFSET) &&
>>           (err = sysfs_create_group(&dev->kobj,
>> -                                   &dme1737_misc_group))) {
>> +                                   &dme1737_temp_offset_group))) {
>>               goto exit_remove;
>>       }
>> -
>> -     /* Create VID-related sysfs attributes */
>> -     if ((data->type = dme1737) &&
>> +     if ((data->has_features & HAS_VID) &&
>>           (err = sysfs_create_group(&dev->kobj,
>>                                     &dme1737_vid_group))) {
>>               goto exit_remove;
>>       }
>> +     if ((data->has_features & HAS_ZONE3) &&
>> +         (err = sysfs_create_group(&dev->kobj,
>> +                                   &dme1737_zone3_group))) {
>> +             goto exit_remove;
>> +     }
>> +     if ((data->has_features & HAS_ZONE_HYST) &&
>> +         (err = sysfs_create_group(&dev->kobj,
>> +                                   &dme1737_zone_hyst_group))) {
>> +             goto exit_remove;
>> +     }
>>
>>       /* Create fan sysfs attributes */
>>       for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
>> -             if (data->has_fan & (1 << ix)) {
>> +             if (data->has_features & HAS_FAN(ix)) {
>>                       if ((err = sysfs_create_group(&dev->kobj,
>>                                               &dme1737_fan_group[ix]))) {
>>                               goto exit_remove;
>> @@ -1960,14 +2041,14 @@
>>
>>       /* Create PWM sysfs attributes */
>>       for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_group); ix++) {
>> -             if (data->has_pwm & (1 << ix)) {
>> +             if (data->has_features & HAS_PWM(ix)) {
>>                       if ((err = sysfs_create_group(&dev->kobj,
>>                                               &dme1737_pwm_group[ix]))) {
>>                               goto exit_remove;
>>                       }
>> -                     if (data->type != sch5027 && ix < 3 &&
>> +                     if ((data->has_features & HAS_PWM_MIN) &&
>>                           (err = sysfs_create_file(&dev->kobj,
>> -                                             dme1737_pwm_misc_attr[ix]))) {
>> +                                     dme1737_auto_pwm_min_attr[ix]))) {
>>                               goto exit_remove;
>>                       }
>>               }
>> @@ -1983,21 +2064,29 @@
>>               dme1737_chmod_group(dev, &dme1737_zone_chmod_group,
>>                                   S_IRUGO | S_IWUSR);
>>
>> -             /* Change permissions of misc sysfs attributes */
>> -             if (data->type != sch5027) {
>> -                     dme1737_chmod_group(dev, &dme1737_misc_group,
>> +             /* Change permissions of chip-dependent sysfs attributes */
>> +             if (data->has_features & HAS_TEMP_OFFSET) {
>> +                     dme1737_chmod_group(dev, &dme1737_temp_offset_group,
>> +                                         S_IRUGO | S_IWUSR);
>> +             }
>> +             if (data->has_features & HAS_ZONE3) {
>> +                     dme1737_chmod_group(dev, &dme1737_zone3_chmod_group,
>> +                                         S_IRUGO | S_IWUSR);
>> +             }
>> +             if (data->has_features & HAS_ZONE_HYST) {
>> +                     dme1737_chmod_group(dev, &dme1737_zone_hyst_group,
>>                                           S_IRUGO | S_IWUSR);
>>               }
>>
>>               /* Change permissions of PWM sysfs attributes */
>>               for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_chmod_group); ix++) {
>> -                     if (data->has_pwm & (1 << ix)) {
>> +                     if (data->has_features & HAS_PWM(ix)) {
>>                               dme1737_chmod_group(dev,
>>                                               &dme1737_pwm_chmod_group[ix],
>>                                               S_IRUGO | S_IWUSR);
>> -                             if (data->type != sch5027 && ix < 3) {
>> +                             if (data->has_features & HAS_PWM_MIN) {
>
> Same here.

Ditto.


>>                                       dme1737_chmod_file(dev,
>> -                                             dme1737_pwm_misc_attr[ix],
>> +                                             dme1737_auto_pwm_min_attr[ix],
>>                                               S_IRUGO | S_IWUSR);
>>                               }
>>                       }
>> @@ -2005,7 +2094,7 @@
>>
>>               /* Change permissions of pwm[1-3] if in manual mode */
>>               for (ix = 0; ix < 3; ix++) {
>> -                     if ((data->has_pwm & (1 << ix)) &&
>> +                     if ((data->has_features & HAS_PWM(ix)) &&
>>                           (PWM_EN_FROM_REG(data->pwm_config[ix]) = 1)) {
>>                               dme1737_chmod_file(dev,
>>                                               dme1737_pwm_chmod_attr[ix],
>> @@ -2052,20 +2141,20 @@
>>               return -EFAULT;
>>       }
>>
>> -     /* Determine which optional fan and pwm features are enabled/present */
>> +     /* Determine which optional fan and pwm features are enabled (only
>> +     * valid for I2C devices) */
>
> Missing space for star alignment.

OK.


>>       if (client) {   /* I2C chip */
>>               data->config2 = dme1737_read(data, DME1737_REG_CONFIG2);
>>               /* Check if optional fan3 input is enabled */
>>               if (data->config2 & 0x04) {
>> -                     data->has_fan |= (1 << 2);
>> +                     data->has_features |= HAS_FAN(2);
>>               }
>>
>>               /* Fan4 and pwm3 are only available if the client's I2C address
>>                * is the default 0x2e. Otherwise the I/Os associated with
>>                * these functions are used for addr enable/select. */
>>               if (client->addr = 0x2e) {
>> -                     data->has_fan |= (1 << 3);
>> -                     data->has_pwm |= (1 << 2);
>> +                     data->has_features |= HAS_FAN(3) | HAS_PWM(2);
>>               }
>>
>>               /* Determine which of the optional fan[5-6] and pwm[5-6]
>> @@ -2077,26 +2166,40 @@
>>                       dev_warn(dev, "Failed to query Super-IO for optional "
>>                                "features.\n");
>>               }
>> -     } else {   /* ISA chip */
>> -             /* Fan3 and pwm3 are always available. Fan[4-5] and pwm[5-6]
>> -              * don't exist in the ISA chip. */
>> -             data->has_fan |= (1 << 2);
>> -             data->has_pwm |= (1 << 2);
>>       }
>>
>> -     /* Fan1, fan2, pwm1, and pwm2 are always present */
>> -     data->has_fan |= 0x03;
>> -     data->has_pwm |= 0x03;
>> +     /* Fan[1-2] and pwm[1-2] are present in all chips */
>> +     data->has_features |= HAS_FAN(0) | HAS_FAN(1) | HAS_PWM(0) | HAS_PWM(1);
>> +
>> +     /* Chip-dependent features */
>> +     switch (data->type) {
>> +     case dme1737:
>> +             data->has_features |= HAS_TEMP_OFFSET | HAS_VID | HAS_ZONE3 |
>> +                     HAS_ZONE_HYST | HAS_PWM_MIN;
>> +             break;
>> +     case sch311x:
>> +             data->has_features |= HAS_TEMP_OFFSET | HAS_ZONE3 |
>> +                     HAS_ZONE_HYST | HAS_PWM_MIN | HAS_FAN(2) | HAS_PWM(2);
>> +             break;
>> +     case sch5027:
>> +             data->has_features |= HAS_ZONE3;
>> +             break;
>> +     case sch5127:
>> +             data->has_features |= HAS_FAN(2) | HAS_PWM(2);
>> +             break;
>> +     default:
>> +             break;
>> +     }
>>
>>       dev_info(dev, "Optional features: pwm3=%s, pwm5=%s, pwm6=%s, "
>>                "fan3=%s, fan4=%s, fan5=%s, fan6=%s.\n",
>> -              (data->has_pwm & (1 << 2)) ? "yes" : "no",
>> -              (data->has_pwm & (1 << 4)) ? "yes" : "no",
>> -              (data->has_pwm & (1 << 5)) ? "yes" : "no",
>> -              (data->has_fan & (1 << 2)) ? "yes" : "no",
>> -              (data->has_fan & (1 << 3)) ? "yes" : "no",
>> -              (data->has_fan & (1 << 4)) ? "yes" : "no",
>> -              (data->has_fan & (1 << 5)) ? "yes" : "no");
>> +              (data->has_features & HAS_PWM(2)) ? "yes" : "no",
>> +              (data->has_features & HAS_PWM(4)) ? "yes" : "no",
>> +              (data->has_features & HAS_PWM(5)) ? "yes" : "no",
>> +              (data->has_features & HAS_FAN(2)) ? "yes" : "no",
>> +              (data->has_features & HAS_FAN(3)) ? "yes" : "no",
>> +              (data->has_features & HAS_FAN(4)) ? "yes" : "no",
>> +              (data->has_features & HAS_FAN(5)) ? "yes" : "no");
>>
>>       reg = dme1737_read(data, DME1737_REG_TACH_PWM);
>>       /* Inform if fan-to-pwm mapping differs from the default */
>> @@ -2122,7 +2225,7 @@
>>               for (ix = 0; ix < 3; ix++) {
>>                       data->pwm_config[ix] = dme1737_read(data,
>>                                               DME1737_REG_PWM_CONFIG(ix));
>> -                     if ((data->has_pwm & (1 << ix)) &&
>> +                     if ((data->has_features & HAS_PWM(ix)) &&
>>                           (PWM_EN_FROM_REG(data->pwm_config[ix]) = -1)) {
>>                               dev_info(dev, "Switching pwm%d to "
>>                                        "manual mode.\n", ix + 1);
>> @@ -2142,7 +2245,7 @@
>>       data->pwm_acz[2] = 4;   /* pwm3 -> zone3 */
>>
>>       /* Set VRM */
>> -     if (data->type = dme1737) {
>> +     if (data->has_features & HAS_VID) {
>>               data->vrm = vid_which_vrm();
>>       }
>>
>> @@ -2163,10 +2266,10 @@
>>       dme1737_sio_enter(sio_cip);
>>
>>       /* Check device ID
>> -      * The DME1737 can return either 0x78 or 0x77 as its device ID.
>> -      * The SCH5027 returns 0x89 as its device ID. */
>> +      * We currently know about two kinds of DME1737 and SCH5027. */
>>       reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
>> -     if (!(reg = 0x77 || reg = 0x78 || reg = 0x89)) {
>> +     if (!(reg = DME1737_ID_1 || reg = DME1737_ID_2 ||
>> +           reg = SCH5027_ID)) {
>>               err = -ENODEV;
>>               goto exit;
>>       }
>> @@ -2185,16 +2288,16 @@
>>        * are enabled and available. Bits [3:2] of registers 0x43-0x46 are set
>>        * to '10' if the respective feature is enabled. */
>>       if ((inb(addr + 0x43) & 0x0c) = 0x08) { /* fan6 */
>> -             data->has_fan |= (1 << 5);
>> +             data->has_features |= HAS_FAN(5);
>>       }
>>       if ((inb(addr + 0x44) & 0x0c) = 0x08) { /* pwm6 */
>> -             data->has_pwm |= (1 << 5);
>> +             data->has_features |= HAS_PWM(5);
>>       }
>>       if ((inb(addr + 0x45) & 0x0c) = 0x08) { /* fan5 */
>> -             data->has_fan |= (1 << 4);
>> +             data->has_features |= HAS_FAN(4);
>>       }
>>       if ((inb(addr + 0x46) & 0x0c) = 0x08) { /* pwm5 */
>> -             data->has_pwm |= (1 << 4);
>> +             data->has_features |= HAS_PWM(4);
>>       }
>>
>>  exit:
>> @@ -2222,7 +2325,6 @@
>>       if (company = DME1737_COMPANY_SMSC &&
>>           verstep = SCH5027_VERSTEP) {
>>               name = "sch5027";
>> -
>>       } else if (company = DME1737_COMPANY_SMSC &&
>>                  (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
>>               name = "dme1737";
>> @@ -2329,10 +2431,10 @@
>>       dme1737_sio_enter(sio_cip);
>>
>>       /* Check device ID
>> -      * We currently know about SCH3112 (0x7c), SCH3114 (0x7d), and
>> -      * SCH3116 (0x7f). */
>> +      * We currently know about SCH3112, SCH3114, SCH3116, and SCH5127 */
>>       reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
>> -     if (!(reg = 0x7c || reg = 0x7d || reg = 0x7f)) {
>> +     if (!(reg = SCH3112_ID || reg = SCH3114_ID || reg = SCH3116_ID ||
>> +           reg = SCH5127_ID)) {
>>               err = -ENODEV;
>>               goto exit;
>>       }
>> @@ -2428,19 +2530,31 @@
>>               company = dme1737_read(data, DME1737_REG_COMPANY);
>>               device = dme1737_read(data, DME1737_REG_DEVICE);
>>
>> -             if (!((company = DME1737_COMPANY_SMSC) &&
>> -                   (device = SCH311X_DEVICE))) {
>> +             if ((company = DME1737_COMPANY_SMSC) &&
>> +                 (device = SCH311X_DEVICE)) {
>> +                     force_id = SCH3112_ID;
>> +             } else if ((company = DME1737_COMPANY_SMSC) &&
>> +                        (device = SCH5127_DEVICE)) {
>> +                     force_id = SCH5127_ID;
>> +             } else {
>
> I'm not fond of abusing force_id that way. I admit that it should work
> in practice, however it could break in theory, for example if more than
> one chip were present on a given system. I don't expect to see this any
> time soon, but this shows the danger of writing to a global variable
> that way. I'd rather do force_id => data->type => data->name, this is
> cleaner and shouldn't require much mode code.

I don't understand your proposal. Could you elaborate?


>>                       err = -ENODEV;
>>                       goto exit_kfree;
>>               }
>>       }
>> -     data->type = sch311x;
>>
>> -     /* Fill in the remaining client fields and initialize the mutex */
>> -     data->name = "sch311x";
>> +     if (force_id = SCH5127_ID) {
>> +             data->type = sch5127;
>> +             data->name = "sch5127";
>> +     } else {
>> +             data->type = sch311x;
>> +             data->name = "sch311x";
>> +     }
>
> This assumes that force_id MUST be either SCH5127_ID or any of
> SCH311x_ID. This is true, but this is enforced in a different function
> (dme1737_isa_detect), so it's hard to guarantee that it will always be
> the case in the future.

Is this just a comment or do you want me to make changes? What would
be your suggestion?


>> +
>> +     /* Initialize the mutex */
>>       mutex_init(&data->update_lock);
>>
>> -     dev_info(dev, "Found a SCH311x chip at 0x%04x\n", data->addr);
>> +     dev_info(dev, "Found a %s chip at 0x%04x\n",
>> +              data->type = sch5127 ? "SCH5127" : "SCH311x", data->addr);
>>
>>       /* Initialize the chip */
>>       if ((err = dme1737_init_device(dev))) {
>
>
> --
> Jean Delvare
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
