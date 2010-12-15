From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 15 Dec 2010 10:04:15 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <AANLkTinLAhzhErzGLzSBXKUBsrNMK46yFCpj7gAGPojR@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> Hi Juerg,

Hi Jean,

Thanks for the review. It wasn't really ready for your consumption but
thanks anyways :-)


> On Fri, 10 Dec 2010 10:43:57 +0100, Juerg Haefliger wrote:
>> Attached is a modified driver with support for Vtrip monitoring (1.5V,
>> in7). Could you give it a try and let me know how it goes? The new
>> driver should expose the following new sysfs files: in7_input,
>> in7_min, in7_max, in7_alarm. No user-level scaling is required. The
>> nominal voltage is 1.5V.
>
> The changes look overall good to me, but I have a few comments if you
> are interested:
>
>> --- dme1737.c 2010-08-02 00:11:14.000000000 +0200
>> +++ /home/khali/dme1737.c     2010-12-10 14:39:04.000000000 +0100
>> @@ -75,16 +75,20 @@
>>   * in4   +12V
>>   * in5   VTR   (+3.3V stby)
>>   * in6   Vbat
>> + * in7   Vtrip (sch5127 only)
>>   *
>>   * --------------------------------------------------------------------- */
>>
>> -/* Voltages (in) numbered 0-6 (ix) */
>> -#define      DME1737_REG_IN(ix)              ((ix) < 5 ? 0x20 + (ix) \
>> -                                               : 0x94 + (ix))
>> -#define      DME1737_REG_IN_MIN(ix)          ((ix) < 5 ? 0x44 + (ix) * 2 \
>> -                                               : 0x91 + (ix) * 2)
>> -#define      DME1737_REG_IN_MAX(ix)          ((ix) < 5 ? 0x45 + (ix) * 2 \
>> -                                               : 0x92 + (ix) * 2)
>> +/* Voltages (in) numbered 0-7 (ix) */
>> +#define      DME1737_REG_IN(ix)              ((ix) < 5 ? 0x20 + (ix) : \
>> +                                      (ix) < 7 ? 0x94 + (ix) : \
>> +                                                 0x1f)
>> +#define      DME1737_REG_IN_MIN(ix)          ((ix) < 5 ? 0x44 + (ix) * 2 : \
>> +                                      (ix) < 7 ? 0x91 + (ix) * 2 : \
>> +                                                 0x9f)
>> +#define      DME1737_REG_IN_MAX(ix)          ((ix) < 5 ? 0x45 + (ix) * 2 : \
>> +                                      (ix) < 7 ? 0x92 + (ix) * 2 : \
>> +                                                 0xa0)
>
> Maybe it is time to give up macros and go with const arrays? The macros
> are never called with a constant parameters so the compiler can't
> optimize the calls.

I thought about that too. I keep it for now for the REG_IN for
consistency reasons (since MIN and MAX don't need any modification as
you pointed out in a subsequent email. duh!).


>>
>>  /* Temperatures (temp) numbered 0-2 (ix) */
>>  #define DME1737_REG_TEMP(ix)         (0x25 + (ix))
>> @@ -99,10 +103,11 @@
>>   *    IN_TEMP_LSB(1) = [temp3, temp1]
>>   *    IN_TEMP_LSB(2) = [in4, temp2]
>>   *    IN_TEMP_LSB(3) = [in3, in0]
>> - *    IN_TEMP_LSB(4) = [in2, in1] */
>> + *    IN_TEMP_LSB(4) = [in2, in1]
>> + *    IN_TEMP_LSB(5) = [res, in7] */
>>  #define DME1737_REG_IN_TEMP_LSB(ix)  (0x84 + (ix))
>> -static const u8 DME1737_REG_IN_LSB[] = {3, 4, 4, 3, 2, 0, 0};
>> -static const u8 DME1737_REG_IN_LSB_SHL[] = {4, 4, 0, 0, 0, 0, 4};
>> +static const u8 DME1737_REG_IN_LSB[] = {3, 4, 4, 3, 2, 0, 0, 5};
>> +static const u8 DME1737_REG_IN_LSB_SHL[] = {4, 4, 0, 0, 0, 0, 4, 4};
>>  static const u8 DME1737_REG_TEMP_LSB[] = {1, 2, 1};
>>  static const u8 DME1737_REG_TEMP_LSB_SHL[] = {4, 4, 0};
>>
>> @@ -143,7 +148,7 @@
>>  #define DME1737_REG_ALARM1           0x41
>>  #define DME1737_REG_ALARM2           0x42
>>  #define DME1737_REG_ALARM3           0x83
>> -static const u8 DME1737_BIT_ALARM_IN[] = {0, 1, 2, 3, 8, 16, 17};
>> +static const u8 DME1737_BIT_ALARM_IN[] = {0, 1, 2, 3, 8, 16, 17, 18};
>>  static const u8 DME1737_BIT_ALARM_TEMP[] = {4, 5, 6};
>>  static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
>>
>> @@ -188,6 +193,7 @@
>>  #define HAS_PWM_MIN          (1 << 4)                /* bit 4 */
>>  #define HAS_FAN(ix)          (1 << ((ix) + 5))       /* bits 5-10 */
>>  #define HAS_PWM(ix)          (1 << ((ix) + 11))      /* bits 11-16 */
>> +#define HAS_IN7                      (1 << 17)               /* bit 17 */
>>
>>  /* ---------------------------------------------------------------------
>>   * Data structures and manipulation thereof
>> @@ -245,7 +251,7 @@
>>  static const int IN_NOMINAL_SCH5027[] = {5000, 2250, 3300, 1125, 1125, 3300,
>>                                        3300};
>>  static const int IN_NOMINAL_SCH5127[] = {2500, 2250, 3300, 1125, 1125, 3300,
>> -                                      3300};
>> +                                      3300, 1500};
>>  #define IN_NOMINAL(type)     ((type) = sch311x ? IN_NOMINAL_SCH311x : \
>>                                (type) = sch5027 ? IN_NOMINAL_SCH5027 : \
>>                                (type) = sch5127 ? IN_NOMINAL_SCH5127 : \
>> @@ -578,7 +584,7 @@
>>  {
>>       struct dme1737_data *data = dev_get_drvdata(dev);
>>       int ix;
>> -     u8 lsb[5];
>> +     u8 lsb[6];
>>
>>       mutex_lock(&data->update_lock);
>>
>> @@ -601,12 +607,14 @@
>>                       /* Voltage inputs are stored as 16 bit values even
>>                        * though they have only 12 bits resolution. This is
>>                        * to make it consistent with the temp inputs. */
>> -                     data->in[ix] = dme1737_read(data,
>> +                     if (ix != 7 || (data->has_features & HAS_IN7)) {
>
> It is less intrusive to do the opposite test:
>
>                        if (ix = 7 && !(data->has_features & HAS_IN7))
>                                continue;

Agreed.


> This avoids reindenting the whole block.
>
>> +                             data->in[ix] = dme1737_read(data,
>>                                       DME1737_REG_IN(ix)) << 8;
>> -                     data->in_min[ix] = dme1737_read(data,
>> +                             data->in_min[ix] = dme1737_read(data,
>>                                       DME1737_REG_IN_MIN(ix));
>> -                     data->in_max[ix] = dme1737_read(data,
>> +                             data->in_max[ix] = dme1737_read(data,
>>                                       DME1737_REG_IN_MAX(ix));
>> +                     }
>>               }
>>
>>               /* Temp registers */
>> @@ -633,12 +641,16 @@
>>                * which the registers are read (MSB first, then LSB) is
>>                * important! */
>>               for (ix = 0; ix < ARRAY_SIZE(lsb); ix++) {
>> -                     lsb[ix] = dme1737_read(data,
>> +                     if (ix != 5 || (data->has_features & HAS_IN7)) {
>> +                             lsb[ix] = dme1737_read(data,
>>                                       DME1737_REG_IN_TEMP_LSB(ix));
>> +                     }
>>               }
>>               for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
>> -                     data->in[ix] |= (lsb[DME1737_REG_IN_LSB[ix]] <<
>> +                     if (ix != 7 || (data->has_features & HAS_IN7)) {
>> +                             data->in[ix] |= (lsb[DME1737_REG_IN_LSB[ix]] <<
>>                                       DME1737_REG_IN_LSB_SHL[ix]) & 0xf0;
>> +                     }
>>               }
>>               for (ix = 0; ix < ARRAY_SIZE(data->temp); ix++) {
>>                       data->temp[ix] |= (lsb[DME1737_REG_TEMP_LSB[ix]] <<
>> @@ -760,7 +772,7 @@
>>
>>  /* ---------------------------------------------------------------------
>>   * Voltage sysfs attributes
>> - * ix = [0-5]
>> + * ix = [0-6]
>
> Shouldn't this be [0-7]?


Yes. And increasing the actual in[] array in the 'data' structure
might be a good thing too to prevent array overruns :-) Duh! No wonder
Jeff's min/max values behave weird.



>>   * --------------------------------------------------------------------- */
>>
>>  #define SYS_IN_INPUT 0
>> @@ -1437,7 +1449,7 @@
>>   * Sysfs device attribute defines and structs
>>   * --------------------------------------------------------------------- */
>>
>> -/* Voltages 0-6 */
>> +/* Voltages 0-7 */
>>
>>  #define SENSOR_DEVICE_ATTR_IN(ix) \
>>  static SENSOR_DEVICE_ATTR_2(in##ix##_input, S_IRUGO, \
>> @@ -1456,6 +1468,7 @@
>>  SENSOR_DEVICE_ATTR_IN(4);
>>  SENSOR_DEVICE_ATTR_IN(5);
>>  SENSOR_DEVICE_ATTR_IN(6);
>> +SENSOR_DEVICE_ATTR_IN(7);
>>
>>  /* Temperatures 1-3 */
>>
>> @@ -1678,8 +1691,7 @@
>>       .attrs = dme1737_zone3_attr,
>>  };
>>
>> -
>> -/* The following struct holds temp zone hysteresis  related attributes, which
>> +/* The following struct holds temp zone hysteresis related attributes, which
>
> Cleanups are preferred as separate patches (makes backporting easier.)

OK. Will send a separate patch.


>>   * are not available in all chips. The following chips support them:
>>   * DME1737, SCH311x */
>>  static struct attribute *dme1737_zone_hyst_attr[] = {
>> @@ -1693,6 +1705,21 @@
>>       .attrs = dme1737_zone_hyst_attr,
>>  };
>>
>> +/* The following struct holds voltage in7 related attributes, which
>> + * are not available in all chips. The following chips support them:
>> + * SCH5127 */
>> +static struct attribute *dme1737_in7_attr[] = {
>> +     &sensor_dev_attr_in7_input.dev_attr.attr,
>> +     &sensor_dev_attr_in7_min.dev_attr.attr,
>> +     &sensor_dev_attr_in7_max.dev_attr.attr,
>> +     &sensor_dev_attr_in7_alarm.dev_attr.attr,
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group dme1737_in7_group = {
>> +     .attrs = dme1737_in7_attr,
>> +};
>> +
>>  /* The following structs hold the PWM attributes, some of which are optional.
>>   * Their creation depends on the chip configuration which is determined during
>>   * module load. */
>> @@ -1984,6 +2011,9 @@
>>       if (data->has_features & HAS_ZONE_HYST) {
>>               sysfs_remove_group(&dev->kobj, &dme1737_zone_hyst_group);
>>       }
>> +     if (data->has_features & HAS_IN7) {
>> +             sysfs_remove_group(&dev->kobj, &dme1737_in7_group);
>> +     }
>>       sysfs_remove_group(&dev->kobj, &dme1737_group);
>>
>>       if (!data->client) {
>> @@ -2028,6 +2058,11 @@
>>                                     &dme1737_zone_hyst_group))) {
>>               goto exit_remove;
>>       }
>> +     if ((data->has_features & HAS_IN7) &&
>> +         (err = sysfs_create_group(&dev->kobj,
>> +                                   &dme1737_in7_group))) {
>> +             goto exit_remove;
>> +     }
>
> checkpatch.pl will complain. It wants:
>
>        if (data->has_features & HAS_IN7) {
>                err = sysfs_create_group(&dev->kobj, &dme1737_in7_group);
>                if (err)
>                        goto exit_remove;
>        }

OK. Assignments in if statements are being used all over the place in
this driver. I guess I should clean those up, shouldn't I?


>>
>>       /* Create fan sysfs attributes */
>>       for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
>> @@ -2186,7 +2221,7 @@
>>               data->has_features |= HAS_ZONE3;
>>               break;
>>       case sch5127:
>> -             data->has_features |= HAS_FAN(2) | HAS_PWM(2);
>> +             data->has_features |= HAS_FAN(2) | HAS_PWM(2) | HAS_IN7;
>>               break;
>>       default:
>>               break;
>>
>
> Thanks,
> --
> Jean Delvare


...Juerg
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
