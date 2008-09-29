From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Sep 2008 08:25:01 +0000
Subject: Re: [lm-sensors] Add a driver for the ADT7475 thermal sensor
Message-Id: <20080929102501.3355e038@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080926232036.GH22230@cosmic.amd.com>
In-Reply-To: <20080926232036.GH22230@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hand, Jordan,

On Sat, 27 Sep 2008 16:04:13 +0200, Hans de Goede wrote:
> Hi Jordan,
> 
> This time I've done a more thorough review, here is a quite long list of 
> remarks I would like you to take care of in one last revision, then this can go 
> upstream (through Jean or Andrew, Jean ?).

Thanks a lot for doing that, Hans. I wanted to do it myself during my
trip to Portland, but in the end I could never find the time. I only
took a couple notes on the driver.

When ready, this patch can go though either myself or Andrew, that
doesn't really matter. Whatever works. I'm pretty busy myself these
days, if you couldn't tell.

> 
> 1) As Andrew Morten already noted as comment to some other patch, its better to
>     make complex macros like this one:
> +#define TEMP2REG(val) ((val) <= -128000 ? -128 : \
> +       (val) >= 127000 ? 127 : \
> +       (val) < 0 ? ((val) - 500) / 1000 : \
> +       ((val) + 500) / 1000)
> 
>     static functions rather then macros all the ? constructions will lead to
>     interesting code and if you make it a function the compiler will usually
>     create significant smaller code
> 

I totally second this.

> 2) This ofcourse is wrong:
> +       data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
> +       data->temp[HYSTERSIS][1] = data->temp[HYSTERSIS][0];
> +       data->temp[HYSTERSIS][1] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
> +       data->temp[HYSTERSIS][2] = (u16) adt7475_read(REG_REMOTE2_HYSTERSIS);
> 
>     The second line starting with "data->temp[HYSTERSIS][1]" should be removed.

This is of course correct.

> 
> 3) This macro isn't used anywhere:
> +#define RANGE     7
> 
>     And you may want to split the macro's in 2 blocks with comments that the
>     first ones are used as array indices for various arrays, and the second ones
>     are for special cases (and must be higher then the max array index).
> 
> 

And this isn't the only one. See this local patch I applied on top of
Jordan's patch:
---
 drivers/hwmon/adt7475.c |   23 -----------------------
 1 file changed, 23 deletions(-)

--- linux-2.6.27-rc6.orig/drivers/hwmon/adt7475.c
+++ linux-2.6.27-rc6/drivers/hwmon/adt7475.c
@@ -25,10 +25,8 @@
 #define CONTROL   3
 #define OFFSET    3
 #define AUTOMIN   4
-#define FREQ      4
 #define THERM     5
 #define HYSTERSIS 6
-#define RANGE     7
 #define ALARM     9
 #define CRIT_ALARM 10
 #define FAULT      11
@@ -45,13 +43,9 @@
 #define REG_DEVID               0x3D
 #define REG_VENDID              0x3E
 
-#define REG_CONFIG1             0x40
 #define REG_STATUS1             0x41
 #define REG_STATUS2             0x42
 
-/* Not all the alarm bits are enabled - mask the ones we don't use */
-#define ALARM_MASK              0xFE76
-
 #define REG_VOLTAGE_MIN_BASE    0x46
 #define REG_VOLTAGE_MAX_BASE    0x47
 
@@ -64,9 +58,6 @@
 
 #define REG_TEMP_TRANGE_BASE    0x5F
 
-#define REG_ACOUSTICS1          0x62
-#define REG_ACOUSTICS2          0x63
-
 #define REG_PWM_MIN_BASE        0x64
 
 #define REG_TEMP_TMIN_BASE      0x67
@@ -77,22 +68,13 @@
 
 #define REG_TEMP_OFFSET_BASE    0x70
 
-#define REG_CONFIG2             0x73
-#define REG_INTERRUPT_MASK1     0x74
-#define REG_INTERRUPT_MASK2     0x75
 #define REG_EXTEND1             0x76
 #define REG_EXTEND2             0x77
-#define REG_CONFIG3             0x78
-#define REG_THERM_TIMER_STATUS  0x79
-#define REG_THERM_TIMER_LIMIT   0x7A
-#define REG_TACH_PULSES         0x7B
 #define REG_CONFIG5             0x7C
 
 #define CONFIG5_TWOSCOMP        0x01
 #define CONFIG5_TEMPOFFSET      0x02
 
-#define REG_CONFIG4             0x7D
-
 /* ADT7475 Settings */
 
 #define ADT7475_VOLTAGE_COUNT   2
@@ -100,11 +82,6 @@
 #define ADT7475_TACH_COUNT	4
 #define ADT7475_PWM_COUNT       3
 
-/* 7475 specific registers */
-
-#define REG_CONFIG6             0x10
-#define REG_CONFIG7             0x11
-
 
 /* Macro to read the registers */
 
And the driver still builds! So, 23 unused defines total.

> 4) The order in which you read/write the low and high byte is different for
>     read/write word:
> 
> +static u16 adt7475_read_word(struct i2c_client *client, int reg)
> +{
> +       u16 val;
> +
> +       val = i2c_smbus_read_byte_data(client, reg);
> +       val |= (i2c_smbus_read_byte_data(client, reg + 1) << 8);
> +
> +       return val;
> +}
> +
> +static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)
> +{
> +       i2c_smbus_write_byte_data(client, reg + 1, val >> 8);
> +       i2c_smbus_write_byte_data(client, reg, val & 0xFF);
> +}
> 
>     The datasheet mandates the order as done in read, and says nothing about
>     write, so I would like to suggest to use the read order for write too.

I don't think we care about write order. Read order matters on
registers which are continuously updated by the chip. Reading in the
recommended order allows the chip to latch the register values to
ensure consistent readings. But for writes, there is no such problem,
so any order should do.

> 
> 
> 5) Your find_nearest function is wrong:
> 
> +static int find_nearest(int val, int *array, int size)
> +{
> +       int i;
> +
> +       if (val < array[0])
> +               return 0;
> +
> +       if (val > array[size - 1])
> +               return array[size - 1];
> +
> +       for (i = 0; i < size - 1; i++) {
> +               int a, b;
> +
> +               if (val > array[i + 1])
> +               return array[size - 1];
> +
> +       for (i = 0; i < size - 1; i++) {
> +               int a, b;
> +
> +               if (val > array[i + 1])
> +                       continue;
> +
> +               a = val - array[i];
> +               b = array[i + 1] - val;
> +
> +               return (a >= b) ? i : i + 1;
> +       }
> +
> +       return 0;
> +}
> 
> Now lets assume that this gets called with an array which contains 1, 5 and 10 
> and that val = 7, then when i = 1 we get beyond the if "(val > array[i + 1])" 
> check, then a becomes 7 - 5 = 2 and b becomes 10 - 7 = 3, since ! (2 >= 3) it 
> will return i + 1 = 2, which corresponds to 10, but it should have returned 1 
> as 7 is closer to 5 then to 10, if we make val 8 it will return 1 where it 
> should have returned 2 this time, so you need the reverse the a >= b check.
> 
> 
> 6) In quite a few functions you are addressing arrays out of bounds:
> +static ssize_t show_voltage(struct device *dev, struct device_attribute *attr,
> +                           char *buf)
> +{
> +       struct adt7475_data *data = adt7475_update_device(dev);
> +       struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +       unsigned short val = data->voltage[sattr->nr][sattr->index];
> +
> +       switch (sattr->nr) {
> +       case ALARM:
> 
> The problem here is that:
> +       unsigned short val = data->voltage[sattr->nr][sattr->index];
> 
> Will get executed even if sattr->nr = ALARM (which it can be) and ALARM is 9 
> soe you are addressing a 3x3 array with [9][x], which is out of bounds. Now in 
> this case this cannot hurt as you cannot get outside of you device data struct 
> here, but you *really* shouldn't be relying on stuff like that, you should 
> never, *ever* address an array out of bounds.

Yes, I had noticed this problem too. This needs to be fixed everywhere.

> 
> 
> 7) In many set functions you do not clamp the value gotten from the user before 
> converting it, so during conversion it could wrap (multiple times) resulting in 
> some almost random value getting set, example:
> 
> +static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
> +                          const char *buf, size_t count) {
> +
> +       struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct adt7475_data *data = i2c_get_clientdata(client);
> +       long val = simple_strtol(buf, NULL, 10);
> +       unsigned char reg;
> +
> +       mutex_lock(&data->lock);
> +
> +       data->voltage[sattr->nr][sattr->index] > +               sattr->index ? VCC2REG(val) : VCCP2REG(val);
> 
> Please clamp val here using SENSORS_LIMIT, note you must use SENSORS_LIMIT 
> return value, example:
> v = SENSORS_LIMIT(v, -128, 127);
> 
> Also in the few places where you do already clamp, please replace your own 
> clamping code with SENSORS_LIMIT
> 
> 
> 8) Please check that you are using the same basic unit everywhere, for example 
> with temp hysteresis in the show function you correcty do:
> +               ret = sprintf(buf, "%d\n",
> +                       CONV2TEMP(data->temp[THERM][sattr->index])
> +                       - (out * 1000));
> 
> Where out is the register value.
> But in the temp hysteresis store you do:
> +               val = CONV2TEMP(data->temp[THERM][sattr->index]) - val;
> +
> +               if (sattr->index != 1) {
> +                       data->temp[HYSTERSIS][sattr->index] &= 0xF0;
> +                       data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4
> +               } else {
> 
> So here the value written by the user has to be the current THERM setting in 
> millidegrees minus the hysteresis he wants in normal celciuses so lets say 
> THERM is 75 degrees so 75000, and he wants to set a hysteris of 5 degrees he 
> should pass in 74995, which should of course be 70000.
> 
> And again you need to clamp here, and clamp intelligently given the 
> substraction involved.
> 
> 
> 9) In some set_xxx functions you do not use update_device to get the data but
>     instead write:
> +       struct adt7475_data *data = i2c_get_clientdata(client);
> 
>     1) Please be consistent about which one you use in set_xxx functions

Set functions should never call the update_device function.

>     2) if you use i2c_get_clientdata() you must make sure that update_device()
>        has been called atleast once before registering any sysfs files, so that
>        the set_xxxx functions can never work on the basis of uninitialised data

This is discouraged as well (makes loading the driver slow.) The
recommended practice is to initialize the few registers values that may
be needed during initialization. There typically aren't that many so it
doesn't duplicate too much code. But even then, relying on potentially
old cached values is not so good, so the best thing "set" functions can
do is read everything they need directly from the chip.

> 
> 
> 10) in show_temp() all reported values should be in millidegrees celcius,
>      currently offset is not in millidegrees celcius
> 
> 
> 11) set_pwm_ctrl set_pwm_chan need better error checking. They should check the
>      value they get passed is not negative, and set_pwm_chan should check for
>      unsupported combos. I guess the best would be to do no checking and just
>      pass the old chan and the new ctrl or vica versa to hw_set_pwm()
>      and then return -EINVAL from hw_set_pwm on not valid combo's (and do
>      storing of the values in the data struct also in hw_set_pwm when
>      things are ok).

12) 

+ /* Convert the tach reading into RPMs */
+ 
+ #define TACH2RPM(val) ((90000 * 60) / (val))
+ #define RPM2TACH(val) ((90000 * 60) / (val))

What happens if val = 0?

13)

+ #define OFF64_REG2TEMP(val) (((((val) >> 2) - 64) * 1000) + (((val) & 3) * 250))

Is it just me or is this strictly equivalent to the much simpler:

#define OFF64_REG2TEMP(val) (((val) - (64 << 2)) * 250)

(Which should be an inline function anyway - see 1))

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
