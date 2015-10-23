From: Marc Titinger <mtitinger@baylibre.com>
Date: Fri, 23 Oct 2015 20:35:22 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: ina2xx: port to using remap, improve bandwidth.
Message-Id: <562A9A0A.5040503@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <56263973.300@roeck-us.net>
 <1445616800-21329-1-git-send-email-mtitinger@baylibre.com>
 <562A65D3.8090306@roeck-us.net>
In-Reply-To: <562A65D3.8090306@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, bcousson@baylibre.com

Hi Guenter

thanks for the review, answers bellow.

Marc.

Le 23/10/2015 18:52, Guenter Roeck a =E9crit :
> On 10/23/2015 09:13 AM, Marc Titinger wrote:
>> With the current implementation, the driver will prevent a readout at a
>> pace faster than the default conversion time (2ms) times the averaging
>> setting, min AVG being 1:1.
>>
>> Any sysfs "show" read access from the client app faster than 500 Hz=20
>> will be
>
> 500 Hz ?
The current code checks for the elapsed time since the last read. If=20
this time is less than the default Conversion Time (CT =3D 2.2ms) times=20
the averaging setting, then the driver will not actually access the=20
registers.
Hence the user can at best read fresh values every 2.2 x 1 ms, roughly=20
500Hz.

Note that since the driver does bulk-read of all 8 registers (on=20
ina226), it takes about 0.8 x 8 =3D 6.4 ms to update all/any values on=20
BeagleBoneBlack, hence a client app cannot read fresh values faster than=20
160Hz per seconds.
This is the problem that motivates this rework.

>
>
>> 'cached' by the driver, but actually since do_update reads all 8=20
>> registers,
>> the best achievable measurement rate is roughly 8*800 us (for the time
>> spent in i2c-core) i.e. <=3D 156Hz with Beagle Bone Black.
>>
>> Registers are now accessed individually through the regmap facility.
>> For four measurements the readout rate is now around
>>   (1/(4*800us) =3D 312 Hz.
>
> I'll need some time to go through the patch in detail Some quick=20
> comments below.
>
ok
>>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> ---
>>   drivers/hwmon/ina2xx.c | 359=20
>> ++++++++++++++++++++++---------------------------
>>   1 file changed, 159 insertions(+), 200 deletions(-)
>>
>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>> index 4d28150..e7c1aaa 100644
>> --- a/drivers/hwmon/ina2xx.c
>> +++ b/drivers/hwmon/ina2xx.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/of.h>
>>   #include <linux/delay.h>
>>   #include <linux/util_macros.h>
>> +#include <linux/regmap.h>
>>
>>   #include <linux/platform_data/ina2xx.h>
>>
>> @@ -48,32 +49,25 @@
>>   #define INA2XX_CURRENT            0x04 /* readonly */
>>   #define INA2XX_CALIBRATION        0x05
>>
>> -/* INA226 register definitions */
>> -#define INA226_MASK_ENABLE        0x06
>> -#define INA226_ALERT_LIMIT        0x07
>> -#define INA226_DIE_ID            0xFF
>> -
>> -/* register count */
>> -#define INA219_REGISTERS        6
>> -#define INA226_REGISTERS        8
>> -
>> -#define INA2XX_MAX_REGISTERS        8
>> +/* CONFIG register fields */
>> +#define INA2XX_AVG_MASK            0x0E00
>> +#define INA2XX_AVG_SHFT            9
>>
>>   /* settings - depend on use case */
>>   #define INA219_CONFIG_DEFAULT        0x399F    /* PGA=3D8 */
>>   #define INA226_CONFIG_DEFAULT        0x4527    /* averages=3D16 */
>>
>>   /* worst case is 68.10 ms (~14.6Hz, ina219) */
>> -#define INA2XX_CONVERSION_RATE        15
>>   #define INA2XX_MAX_DELAY        69 /* worst case delay in ms */
>>
>>   #define INA2XX_RSHUNT_DEFAULT        10000
>>
>> -/* bit mask for reading the averaging setting in the configuration=20
>> register */
>> -#define INA226_AVG_RD_MASK        0x0E00
>> -
>> -#define INA226_READ_AVG(reg)        (((reg) & INA226_AVG_RD_MASK) >> 9)
>> -#define INA226_SHIFT_AVG(val)        ((val) << 9)
>> +/* Currently only handling common register set */
>> +static const struct regmap_config INA2XX_regmap_config =3D {
>> +    .reg_bits =3D 8,
>> +    .val_bits =3D 16,
>> +    .max_register =3D INA2XX_CALIBRATION,
>> +};
>>
>>   /* common attrs, ina226 attrs and NULL */
>>   #define INA2XX_MAX_ATTRIBUTE_GROUPS    3
>> @@ -89,7 +83,6 @@ enum ina2xx_ids { ina219, ina226 };
>>   struct ina2xx_config {
>>       u16 config_default;
>>       int calibration_factor;
>> -    int registers;
>>       int shunt_div;
>>       int bus_voltage_shift;
>>       int bus_voltage_lsb;    /* uV */
>> @@ -99,25 +92,16 @@ struct ina2xx_config {
>>   struct ina2xx_data {
>>       struct i2c_client *client;
>>       const struct ina2xx_config *config;
>> -
>> +    struct regmap *regmap;
>>       long rshunt;
>> -    u16 curr_config;
>> -
>> -    struct mutex update_lock;
>> -    bool valid;
>> -    unsigned long last_updated;
>> -    int update_interval; /* in jiffies */
>> -
>> -    int kind;
>> +    int valid;
>
> bool, please. But then valid was supposed to be used to indicate
> if the cache is valid, and should no longer be needed since there
> is no more cache. I'll have to spend more time to understand if and
> why it is still needed and how it is used.

Ah yes thanks, re-reading the initial code, I figure I 'invented'=20
another need for this by mistake...
I'm happy to remove it.  Good catch!

>
>>       const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>> -    u16 regs[INA2XX_MAX_REGISTERS];
>>   };
>>
>>   static const struct ina2xx_config ina2xx_config[] =3D {
>>       [ina219] =3D {
>>           .config_default =3D INA219_CONFIG_DEFAULT,
>>           .calibration_factor =3D 40960000,
>> -        .registers =3D INA219_REGISTERS,
>>           .shunt_div =3D 100,
>>           .bus_voltage_shift =3D 3,
>>           .bus_voltage_lsb =3D 4000,
>> @@ -126,7 +110,6 @@ static const struct ina2xx_config ina2xx_config[]=20
>> =3D {
>>       [ina226] =3D {
>>           .config_default =3D INA226_CONFIG_DEFAULT,
>>           .calibration_factor =3D 5120000,
>> -        .registers =3D INA226_REGISTERS,
>>           .shunt_div =3D 400,
>>           .bus_voltage_shift =3D 0,
>>           .bus_voltage_lsb =3D 1250,
>> @@ -142,9 +125,9 @@ static const struct ina2xx_config ina2xx_config[]=20
>> =3D {
>>    */
>>   static const int ina226_avg_tab[] =3D { 1, 4, 16, 64, 128, 256, 512,=20
>> 1024 };
>>
>> -static int ina226_reg_to_interval(u16 config)
>> +static int ina226_field_to_interval(int field)
>>   {
>> -    int avg =3D ina226_avg_tab[INA226_READ_AVG(config)];
>> +    int avg =3D ina226_avg_tab[field];
>>
>>       /*
>>        * Multiply the total conversion time by the number of averages.
>> @@ -153,24 +136,11 @@ static int ina226_reg_to_interval(u16 config)
>>       return DIV_ROUND_CLOSEST(avg * INA226_TOTAL_CONV_TIME_DEFAULT,=20
>> 1000);
>>   }
>>
>> -static u16 ina226_interval_to_reg(int interval, u16 config)
>> -{
>> -    int avg, avg_bits;
>> -
>> -    avg =3D DIV_ROUND_CLOSEST(interval * 1000,
>> -                INA226_TOTAL_CONV_TIME_DEFAULT);
>> -    avg_bits =3D find_closest(avg, ina226_avg_tab,
>> -                ARRAY_SIZE(ina226_avg_tab));
>> -
>> -    return (config & ~INA226_AVG_RD_MASK) | INA226_SHIFT_AVG(avg_bits);
>> -}
>> -
>> -static void ina226_set_update_interval(struct ina2xx_data *data)
>> +static int ina226_interval_to_field(int interval)
>>   {
>> -    int ms;
>> -
>> -    ms =3D ina226_reg_to_interval(data->curr_config);
>> -    data->update_interval =3D msecs_to_jiffies(ms);
>> +    int avg =3D DIV_ROUND_CLOSEST(interval * 1000,
>> +                    INA226_TOTAL_CONV_TIME_DEFAULT);
>> +    return find_closest(avg, ina226_avg_tab,=20
>> ARRAY_SIZE(ina226_avg_tab));
>>   }
>>
>>   static int ina2xx_calibrate(struct ina2xx_data *data)
>> @@ -178,8 +148,7 @@ static int ina2xx_calibrate(struct ina2xx_data=20
>> *data)
>>       u16 val =3D DIV_ROUND_CLOSEST(data->config->calibration_factor,
>>                       data->rshunt);
>>
>> -    return i2c_smbus_write_word_swapped(data->client,
>> -                        INA2XX_CALIBRATION, val);
>> +    return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
>>   }
>>
>>   /*
>> @@ -187,15 +156,10 @@ static int ina2xx_calibrate(struct ina2xx_data=20
>> *data)
>>    */
>>   static int ina2xx_init(struct ina2xx_data *data)
>>   {
>> -    struct i2c_client *client =3D data->client;
>> -    int ret;
>> -
>> -    /* device configuration */
>> -    ret =3D i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
>> -                       data->curr_config);
>> -    if (ret < 0)
>> +    int ret =3D regmap_write(data->regmap, INA2XX_CONFIG,
>> +                   data->config->config_default);
>> +    if (ret)
>>           return ret;
>> -
>>       /*
>>        * Set current LSB to 1mA, shunt is in uOhms
>>        * (equation 13 in datasheet).
>> @@ -203,22 +167,22 @@ static int ina2xx_init(struct ina2xx_data *data)
>>       return ina2xx_calibrate(data);
>>   }
>>
>> -static int ina2xx_do_update(struct device *dev)
>> +static int ina2xx_show_common(struct device *dev, int index, int *val)
>>   {
>>       struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> -    struct i2c_client *client =3D data->client;
>> -    int i, rv, retry;
>> +    int err, retry;
>>
>> -    dev_dbg(&client->dev, "Starting ina2xx update\n");
>> +    if (unlikely(!val))
>> +        return -EINVAL;
>
> Please no unnecessary parameter checks. If val is NULL here,
> something is wrong with the implementation and needs to get fixed.
>
> Besides, the return value is only negative on errors. There is no need
> to pass an extra pointer to the value. Furthermore, regmap_read expects
> a pointer to an unsigned int, not a pointer to an int.
>
> Just return an error or the value returned by regmap. The calling code
> can determine if there is an error by checking if the returned value=20
> is < 0.
>
>>
>>       for (retry =3D 5; retry; retry--) {
>> -        /* Read all registers */
>> -        for (i =3D 0; i < data->config->registers; i++) {
>> -            rv =3D i2c_smbus_read_word_swapped(client, i);
>> -            if (rv < 0)
>> -                return rv;
>> -            data->regs[i] =3D rv;
>> -        }
>> +
>> +        /* Check for remaining registers in mask. */
>> +        err =3D regmap_read(data->regmap, index, val);
>> +        if (err)
>> +            return err;
>> +
>> +        dev_dbg(dev, "read %d, val =3D 0x%04x\n", index, *val);
>>
>>           /*
>>            * If the current value in the calibration register is 0, the
>> @@ -226,24 +190,24 @@ static int ina2xx_do_update(struct device *dev)
>>            * the chip has been reset let's check the calibration
>>            * register and reinitialize if needed.
>>            */
>> -        if (data->regs[INA2XX_CALIBRATION] =3D=3D 0) {
>> -            dev_warn(dev, "chip not calibrated, reinitializing\n");
>> -
>> -            rv =3D ina2xx_init(data);
>> -            if (rv < 0)
>> -                return rv;
>> +        if (!data->valid) {
>> +            dev_warn(dev,
>> +                 "chip needs calibration, reinitializing\n");
>>
>> +            err =3D ina2xx_calibrate(data);
>> +            if (err)
>> +                return err;
>
> Ah, that is the context of "valid". I don't immediately see why moving=20
> its scope
> out of this function, and setting it to false in the calling code, is=20
> beneficial here.
>
> This also changes the dynamic of the driver. Previously it was=20
> specifically able
> to detect if the chip was power cycled (for whatever reason) and it=20
> would re-initialize
> itself. Now you use 'valid' and you defer (re-)initialization until=20
> chip registers
> are read. I don't immediately see if and how this is beneficial.
Agreed, as I said, it "morphed" the use of valid because of my earlier=20
patch...

>>               /*
>>                * Let's make sure the power and current registers
>>                * have been updated before trying again.
>>                */
>>               msleep(INA2XX_MAX_DELAY);
>> +
>> +            /* data valid once we have a cal value. */
>> +            regmap_read(data->regmap, INA2XX_CALIBRATION,
>> +                    &data->valid);
>>               continue;
>>           }
>> -
>> -        data->last_updated =3D jiffies;
>> -        data->valid =3D 1;
>> -
>>           return 0;
>>       }
>>
>> @@ -256,86 +220,89 @@ static int ina2xx_do_update(struct device *dev)
>>       return -ENODEV;
>>   }
>>
>> -static struct ina2xx_data *ina2xx_update_device(struct device *dev)
>> +static ssize_t ina2xx_show_shunt(struct device *dev,
>> +                 struct device_attribute *da, char *buf)
>>   {
>>       struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> -    struct ina2xx_data *ret =3D data;
>> -    unsigned long after;
>> -    int rv;
>> +    int val, err;
>>
>> -    mutex_lock(&data->update_lock);
>> +    err =3D ina2xx_show_common(dev, INA2XX_SHUNT_VOLTAGE, &val);
>> +    if (err)
>> +        return err;
>>
>> -    after =3D data->last_updated + data->update_interval;
>> -    if (time_after(jiffies, after) || !data->valid) {
>> -        rv =3D ina2xx_do_update(dev);
>> -        if (rv < 0)
>> -            ret =3D ERR_PTR(rv);
>> -    }
>> +    val =3D DIV_ROUND_CLOSEST((s16) val, data->config->shunt_div);
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>> +}
>> +
>> +static ssize_t ina2xx_show_bus(struct device *dev,
>> +                   struct device_attribute *da, char *buf)
>> +{
>> +    struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> +    int val, err;
>> +
>> +    err =3D ina2xx_show_common(dev, INA2XX_BUS_VOLTAGE, &val);
>> +    if (err)
>> +        return err;
>>
>> -    mutex_unlock(&data->update_lock);
>> -    return ret;
>> +    val =3D (val >> data->config->bus_voltage_shift)
>> +        * data->config->bus_voltage_lsb;
>> +    val =3D DIV_ROUND_CLOSEST(val, 1000);
>> +
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>
>> -static int ina2xx_get_value(struct ina2xx_data *data, u8 reg)
>> +static ssize_t ina2xx_show_pow(struct device *dev,
>> +                   struct device_attribute *da, char *buf)
>>   {
>> -    int val;
>> -
>> -    switch (reg) {
>> -    case INA2XX_SHUNT_VOLTAGE:
>> -        /* signed register */
>> -        val =3D DIV_ROUND_CLOSEST((s16)data->regs[reg],
>> -                    data->config->shunt_div);
>> -        break;
>> -    case INA2XX_BUS_VOLTAGE:
>> -        val =3D (data->regs[reg] >> data->config->bus_voltage_shift)
>> -          * data->config->bus_voltage_lsb;
>> -        val =3D DIV_ROUND_CLOSEST(val, 1000);
>> -        break;
>> -    case INA2XX_POWER:
>> -        val =3D data->regs[reg] * data->config->power_lsb;
>> -        break;
>> -    case INA2XX_CURRENT:
>> -        /* signed register, LSB=3D1mA (selected), in mA */
>> -        val =3D (s16)data->regs[reg];
>> -        break;
>> -    case INA2XX_CALIBRATION:
>> -        val =3D DIV_ROUND_CLOSEST(data->config->calibration_factor,
>> -                    data->regs[reg]);
>> -        break;
>> -    default:
>> -        /* programmer goofed */
>> -        WARN_ON_ONCE(1);
>> -        val =3D 0;
>> -        break;
>> -    }
>> +    struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> +    int val, err;
>> +
>> +    err =3D ina2xx_show_common(dev, INA2XX_POWER, &val);
>> +    if (err)
>> +        return err;
>> +
>> +    val *=3D data->config->power_lsb;
>>
>> -    return val;
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>
>> -static ssize_t ina2xx_show_value(struct device *dev,
>> -                 struct device_attribute *da, char *buf)
>> +static ssize_t ina2xx_show_curr(struct device *dev,
>> +                struct device_attribute *da, char *buf)
>>   {
>> -    struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
>> -    struct ina2xx_data *data =3D ina2xx_update_device(dev);
>> +    int val, err;
>>
>> -    if (IS_ERR(data))
>> -        return PTR_ERR(data);
>> +    err =3D ina2xx_show_common(dev, INA2XX_CURRENT, &val);
>> +    if (err)
>> +        return err;
>>
>> -    return snprintf(buf, PAGE_SIZE, "%d\n",
>> -            ina2xx_get_value(data, attr->index));
>> +    /* signed register, LSB=3D1mA (selected), in mA */
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>> +}
>> +
>> +static ssize_t ina2xx_show_cal(struct device *dev,
>> +                   struct device_attribute *da, char *buf)
>> +{
>> +    struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> +    int val, err;
>> +
>> +    err =3D ina2xx_show_common(dev, INA2XX_CALIBRATION, &val);
>> +    if (err)
>> +        return err;
>> +
>> +    val =3D DIV_ROUND_CLOSEST(data->config->calibration_factor, val);
>> +
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>
>>   static ssize_t ina2xx_set_shunt(struct device *dev,
>>                   struct device_attribute *da,
>>                   const char *buf, size_t count)
>>   {
>> -    struct ina2xx_data *data =3D ina2xx_update_device(dev);
>> +    struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> +
>>       unsigned long val;
>>       int status;
>>
>> -    if (IS_ERR(data))
>> -        return PTR_ERR(data);
>> -
>>       status =3D kstrtoul(buf, 10, &val);
>>       if (status < 0)
>>           return status;
>> @@ -345,12 +312,8 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
>>           val > data->config->calibration_factor)
>>           return -EINVAL;
>>
>> -    mutex_lock(&data->update_lock);
>>       data->rshunt =3D val;
>> -    status =3D ina2xx_calibrate(data);
>> -    mutex_unlock(&data->update_lock);
>> -    if (status < 0)
>> -        return status;
>> +    data->valid =3D 0;
>>
>>       return count;
>>   }
>> @@ -370,65 +333,58 @@ static ssize_t ina226_set_interval(struct=20
>> device *dev,
>>       if (val > INT_MAX || val =3D=3D 0)
>>           return -EINVAL;
>>
>> -    mutex_lock(&data->update_lock);
>> -    data->curr_config =3D ina226_interval_to_reg(val,
>> -                           data->regs[INA2XX_CONFIG]);
>> -    status =3D i2c_smbus_write_word_swapped(data->client,
>> -                          INA2XX_CONFIG,
>> -                          data->curr_config);
>> +    val =3D ina226_interval_to_field(val);
>>
>> -    ina226_set_update_interval(data);
>> -    /* Make sure the next access re-reads all registers. */
>> -    data->valid =3D 0;
>> -    mutex_unlock(&data->update_lock);
>> +    status =3D regmap_update_bits(data->regmap, INA2XX_CONFIG,
>> +                    INA2XX_AVG_MASK, (val << INA2XX_AVG_SHFT));
>>       if (status < 0)
>>           return status;
>>
>> +    data->valid =3D 0;
>> +
>
> This now causes re-calibration. Why ?
Mistake.
>>       return count;
>>   }
>>
>>   static ssize_t ina226_show_interval(struct device *dev,
>>                       struct device_attribute *da, char *buf)
>>   {
>> -    struct ina2xx_data *data =3D ina2xx_update_device(dev);
>> +    struct ina2xx_data *data =3D dev_get_drvdata(dev);
>> +    int status, val;
>>
>> -    if (IS_ERR(data))
>> -        return PTR_ERR(data);
>> +    status =3D regmap_read(data->regmap, INA2XX_CONFIG, &val);
>> +    if (status)
>> +        return status;
>> +
>> +    val =3D (val & INA2XX_AVG_MASK) >> INA2XX_AVG_SHFT;
>> +    val =3D ina226_field_to_interval(val);
>>
>>       /*
>> -     * We don't use data->update_interval here as we want to display
>> -     * the actual interval used by the chip and jiffies_to_msecs()
>> -     * doesn't seem to be accurate enough.
>> +     * We want to display the actual interval used by the chip.
>>        */
>> -    return snprintf(buf, PAGE_SIZE, "%d\n",
>> - ina226_reg_to_interval(data->regs[INA2XX_CONFIG]));
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>
>>   /* shunt voltage */
>> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
>> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_shunt, NULL,
>>                 INA2XX_SHUNT_VOLTAGE);
>
> If you no longer use the register parameter, there is no need to=20
> provide it.
> But then I'll have to spend some time trying to understand _why_ you=20
> don't
> use it anymore and why you introduced separate show functions.
> Some explanation might help.
>
The interval value is no longer needed to compute a read "gard" delay,=20
but the client Application may still need to set a different averaging=20
value through this interval setting, based on the DUT characteristics.
As of using separate functions, it fits better in the new logic of=20
"per-register" accesses. It does not bloat the code either.

>>
>>   /* bus voltage */
>> -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_value, NULL,
>> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_bus, NULL,
>>                 INA2XX_BUS_VOLTAGE);
>>
>>   /* calculated current */
>> -static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_value,=20
>> NULL,
>> +static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_curr, NULL,
>>                 INA2XX_CURRENT);
>>
>>   /* calculated power */
>> -static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_value,=20
>> NULL,
>> +static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_pow, NULL,
>>                 INA2XX_POWER);
>>
>>   /* shunt resistance */
>>   static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
>> -              ina2xx_show_value, ina2xx_set_shunt,
>> +              ina2xx_show_cal, ina2xx_set_shunt,
>>                 INA2XX_CALIBRATION);
>>
>> -/* update interval (ina226 only) */
>> -static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
>> -              ina226_show_interval, ina226_set_interval, 0);
>> -
>>   /* pointers to created device attributes */
>>   static struct attribute *ina2xx_attrs[] =3D {
>>       &sensor_dev_attr_in0_input.dev_attr.attr,
>> @@ -443,6 +399,10 @@ static const struct attribute_group ina2xx_group=20
>> =3D {
>>       .attrs =3D ina2xx_attrs,
>>   };
>>
>> +/* update interval (ina226 only) */
>> +static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
>> +              ina226_show_interval, ina226_set_interval, 0);
>> +
>
> I don't really see the value of moving this code around.
> Please no unnecessary changes.
>
>>   static struct attribute *ina226_attrs[] =3D {
>>       &sensor_dev_attr_update_interval.dev_attr.attr,
>>       NULL,
>> @@ -452,65 +412,65 @@ static const struct attribute_group=20
>> ina226_group =3D {
>>       .attrs =3D ina226_attrs,
>>   };
>>
>> +
>>   static int ina2xx_probe(struct i2c_client *client,
>>               const struct i2c_device_id *id)
>>   {
>> -    struct i2c_adapter *adapter =3D client->adapter;
>>       struct ina2xx_platform_data *pdata;
>>       struct device *dev =3D &client->dev;
>>       struct ina2xx_data *data;
>>       struct device *hwmon_dev;
>> +    struct regmap *regmap;
>>       u32 val;
>>       int ret, group =3D 0;
>>
>> -    if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> -        return -ENODEV;
>> +    /* Register regmap */
>> +    regmap =3D devm_regmap_init_i2c(client, &INA2XX_regmap_config);
>> +    if (IS_ERR(regmap)) {
>> +        dev_err(dev, "failed to allocate register map\n");
>> +        return PTR_ERR(regmap);
>> +    }
>>
>>       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>       if (!data)
>>           return -ENOMEM;
>>
>> -    if (dev_get_platdata(dev)) {
>> -        pdata =3D dev_get_platdata(dev);
>> -        data->rshunt =3D pdata->shunt_uohms;
>> -    } else if (!of_property_read_u32(dev->of_node,
>> -                     "shunt-resistor", &val)) {
>> -        data->rshunt =3D val;
>> -    } else {
>> -        data->rshunt =3D INA2XX_RSHUNT_DEFAULT;
>> -    }
>> +    data->regmap =3D regmap;
>>
>> -    /* set the device type */
>> -    data->kind =3D id->driver_data;
>> -    data->config =3D &ina2xx_config[data->kind];
>> -    data->curr_config =3D data->config->config_default;
>> +    /* Set config according to device type. */
>> +    data->config =3D &ina2xx_config[id->driver_data];
>>       data->client =3D client;
>>
>> -    /*
>> -     * Ina226 has a variable update_interval. For ina219 we
>> -     * use a constant value.
>> +    /* Check for shunt resistor value.
>> +     * Give precedence to device tree over must-recompile.
>>        */
>> -    if (data->kind =3D=3D ina226)
>> -        ina226_set_update_interval(data);
>> -    else
>> -        data->update_interval =3D HZ / INA2XX_CONVERSION_RATE;
>> +    if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) <=20
>> 0) {
>> +        pdata =3D dev_get_platdata(dev);
>> +        if (pdata)
>> +            val =3D pdata->shunt_uohms;
>> +        else
>> +            val =3D INA2XX_RSHUNT_DEFAULT;
>> +    }
>
> This changes priority from platform data first to devicetree=20
> configuration first.
> As such, it is an unrelated change. If needed, split into a separate=20
> patch, and
Yes I would do a separate patch normaly, agreed.

> explain the reasoning, please.
Changing the platform data requires changes in the kernel code, and=20
hence recompilation. It seems a bit unexpected that setting a new value=20
in the dtb will be ignored because there is a compiled-in platform data.=20
Should'nt the dtb allow to override platform data ?
>
>>
>> -    if (data->rshunt <=3D 0 ||
>> -        data->rshunt > data->config->calibration_factor)
>> +    if (val <=3D 0 || val > data->config->calibration_factor) {
>> +        dev_err(dev, "Invalid shunt resistor value %li", val);
>>           return -ENODEV;
>> +    }
>> +    data->rshunt =3D val;
>>
>> +    /* Write config to chip, and calibrate */
>
> That comment, if needed, would be more appropriate at the top of the=20
> called function.
>
>>       ret =3D ina2xx_init(data);
>> -    if (ret < 0) {
>> -        dev_err(dev, "error configuring the device: %d\n", ret);
>> -        return -ENODEV;
>> +    if (ret) {
>> +        dev_err(dev, "error configuring the device.\n");
>> +        return ret;
>
> Please explain whuy this code is better than before. To me it looks like
> personal preference, and I don't see the improvement.
>
It's not, it came from successive changes, will revert...
>>       }
>>
>> -    mutex_init(&data->update_lock);
>> -
>> +    /* Set sensor group according to device type. */
>
> Seems to be obvious to me.
>
>>       data->groups[group++] =3D &ina2xx_group;
>> -    if (data->kind =3D=3D ina226)
>> +    if (ina226 =3D=3D id->driver_data)
>
> Not likely to accept Yoda programming I am.
>
Appropriate it is, In some instances. Usually I dislike it too, question=20
of style and opinion really I'd say.

>>           data->groups[group++] =3D &ina226_group;
>>
>> +    /* register to hwmon */
>
> Isn't that obvious ? I don't see the value of this comment.
>
>>       hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,=20
>> client->name,
>>                                  data, data->groups);
>>       if (IS_ERR(hwmon_dev))
>> @@ -541,7 +501,6 @@ static struct i2c_driver ina2xx_driver =3D {
>>   };
>>
>>   module_i2c_driver(ina2xx_driver);
>> -
>
> Does this change fix a checkpatch problem ? If so, please submit as=20
> separate patch.
> If not, please no unnecessary whitespace changes.
Ok.
>
>>   MODULE_AUTHOR("Lothar Felten <l-felten@ti.com>");
>>   MODULE_DESCRIPTION("ina2xx driver");
>>   MODULE_LICENSE("GPL");
>>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
