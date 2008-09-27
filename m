From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 27 Sep 2008 14:04:13 +0000
Subject: Re: [lm-sensors] Add a driver for the ADT7475 thermal sensor
Message-Id: <48DE3D5D.9010100@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080926232036.GH22230@cosmic.amd.com>
In-Reply-To: <20080926232036.GH22230@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

This time I've done a more thorough review, here is a quite long list of 
remarks I would like you to take care of in one last revision, then this can go 
upstream (through Jean or Andrew, Jean ?).

1) As Andrew Morten already noted as comment to some other patch, its better to
    make complex macros like this one:
+#define TEMP2REG(val) ((val) <= -128000 ? -128 : \
+       (val) >= 127000 ? 127 : \
+       (val) < 0 ? ((val) - 500) / 1000 : \
+       ((val) + 500) / 1000)

    static functions rather then macros all the ? constructions will lead to
    interesting code and if you make it a function the compiler will usually
    create significant smaller code

2) This ofcourse is wrong:
+       data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
+       data->temp[HYSTERSIS][1] = data->temp[HYSTERSIS][0];
+       data->temp[HYSTERSIS][1] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
+       data->temp[HYSTERSIS][2] = (u16) adt7475_read(REG_REMOTE2_HYSTERSIS);

    The second line starting with "data->temp[HYSTERSIS][1]" should be removed.

3) This macro isn't used anywhere:
+#define RANGE     7

    And you may want to split the macro's in 2 blocks with comments that the
    first ones are used as array indices for various arrays, and the second ones
    are for special cases (and must be higher then the max array index).


4) The order in which you read/write the low and high byte is different for
    read/write word:

+static u16 adt7475_read_word(struct i2c_client *client, int reg)
+{
+       u16 val;
+
+       val = i2c_smbus_read_byte_data(client, reg);
+       val |= (i2c_smbus_read_byte_data(client, reg + 1) << 8);
+
+       return val;
+}
+
+static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)
+{
+       i2c_smbus_write_byte_data(client, reg + 1, val >> 8);
+       i2c_smbus_write_byte_data(client, reg, val & 0xFF);
+}

    The datasheet mandates the order as done in read, and says nothing about
    write, so I would like to suggest to use the read order for write too.


5) Your find_nearest function is wrong:

+static int find_nearest(int val, int *array, int size)
+{
+       int i;
+
+       if (val < array[0])
+               return 0;
+
+       if (val > array[size - 1])
+               return array[size - 1];
+
+       for (i = 0; i < size - 1; i++) {
+               int a, b;
+
+               if (val > array[i + 1])
+               return array[size - 1];
+
+       for (i = 0; i < size - 1; i++) {
+               int a, b;
+
+               if (val > array[i + 1])
+                       continue;
+
+               a = val - array[i];
+               b = array[i + 1] - val;
+
+               return (a >= b) ? i : i + 1;
+       }
+
+       return 0;
+}

Now lets assume that this gets called with an array which contains 1, 5 and 10 
and that val = 7, then when i = 1 we get beyond the if "(val > array[i + 1])" 
check, then a becomes 7 - 5 = 2 and b becomes 10 - 7 = 3, since ! (2 >= 3) it 
will return i + 1 = 2, which corresponds to 10, but it should have returned 1 
as 7 is closer to 5 then to 10, if we make val 8 it will return 1 where it 
should have returned 2 this time, so you need the reverse the a >= b check.


6) In quite a few functions you are addressing arrays out of bounds:
+static ssize_t show_voltage(struct device *dev, struct device_attribute *attr,
+                           char *buf)
+{
+       struct adt7475_data *data = adt7475_update_device(dev);
+       struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+       unsigned short val = data->voltage[sattr->nr][sattr->index];
+
+       switch (sattr->nr) {
+       case ALARM:

The problem here is that:
+       unsigned short val = data->voltage[sattr->nr][sattr->index];

Will get executed even if sattr->nr = ALARM (which it can be) and ALARM is 9 
soe you are addressing a 3x3 array with [9][x], which is out of bounds. Now in 
this case this cannot hurt as you cannot get outside of you device data struct 
here, but you *really* shouldn't be relying on stuff like that, you should 
never, *ever* address an array out of bounds.


7) In many set functions you do not clamp the value gotten from the user before 
converting it, so during conversion it could wrap (multiple times) resulting in 
some almost random value getting set, example:

+static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
+                          const char *buf, size_t count) {
+
+       struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+       struct i2c_client *client = to_i2c_client(dev);
+       struct adt7475_data *data = i2c_get_clientdata(client);
+       long val = simple_strtol(buf, NULL, 10);
+       unsigned char reg;
+
+       mutex_lock(&data->lock);
+
+       data->voltage[sattr->nr][sattr->index] +               sattr->index ? VCC2REG(val) : VCCP2REG(val);

Please clamp val here using SENSORS_LIMIT, note you must use SENSORS_LIMIT 
return value, example:
v = SENSORS_LIMIT(v, -128, 127);

Also in the few places where you do already clamp, please replace your own 
clamping code with SENSORS_LIMIT


8) Please check that you are using the same basic unit everywhere, for example 
with temp hysteresis in the show function you correcty do:
+               ret = sprintf(buf, "%d\n",
+                       CONV2TEMP(data->temp[THERM][sattr->index])
+                       - (out * 1000));

Where out is the register value.
But in the temp hysteresis store you do:
+               val = CONV2TEMP(data->temp[THERM][sattr->index]) - val;
+
+               if (sattr->index != 1) {
+                       data->temp[HYSTERSIS][sattr->index] &= 0xF0;
+                       data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4
+               } else {

So here the value written by the user has to be the current THERM setting in 
millidegrees minus the hysteresis he wants in normal celciuses so lets say 
THERM is 75 degrees so 75000, and he wants to set a hysteris of 5 degrees he 
should pass in 74995, which should of course be 70000.

And again you need to clamp here, and clamp intelligently given the 
substraction involved.


9) In some set_xxx functions you do not use update_device to get the data but
    instead write:
+       struct adt7475_data *data = i2c_get_clientdata(client);

    1) Please be consistent about which one you use in set_xxx functions
    2) if you use i2c_get_clientdata() you must make sure that update_device()
       has been called atleast once before registering any sysfs files, so that
       the set_xxxx functions can never work on the basis of uninitialised data


10) in show_temp() all reported values should be in millidegrees celcius,
     currently offset is not in millidegrees celcius


11) set_pwm_ctrl set_pwm_chan need better error checking. They should check the
     value they get passed is not negative, and set_pwm_chan should check for
     unsupported combos. I guess the best would be to do no checking and just
     pass the old chan and the new ctrl or vica versa to hw_set_pwm()
     and then return -EINVAL from hw_set_pwm on not valid combo's (and do
     storing of the values in the data struct also in hw_set_pwm when
     things are ok).


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
