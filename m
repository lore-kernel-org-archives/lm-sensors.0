From: Nishanth Menon <nm@ti.com>
Date: Tue, 01 Dec 2015 13:47:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp102) Force wait for conversion time for the first valid data
Message-Id: <565DA504.4060600@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1448943955-2385-1-git-send-email-nm@ti.com> <565D3513.7050905@roeck-us.net>
In-Reply-To: <565D3513.7050905@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, beagleboard-x15@googlegroups.com, Eduardo Valentin <edubezval@gmail.com>

Hi Guenter,

Thanks for the detailed review..

On 11/30/2015 11:50 PM, Guenter Roeck wrote:
> On 11/30/2015 08:25 PM, Nishanth Menon wrote:
[...]

>>
>> A simpler alternative approach could be to sleep in the probe for the
>> duration required, but that will result in latency that is undesirable
>> that can delay boot sequence un-necessarily.
>>
> A really simpler solution would be to mark when the device is ready
> to be accessed in the probe function, and go to sleep for the remaining
> time
> in the update function if necessary. This would not affect the probe
> function,
> avoid the somewhat awkward -EAGAIN, avoid overloading the value cache,
> and only
> sleep if necessary and as long as needed.

We already have that logic in a different form:
We use last_update to know when to go read the temperature value. Until
the conversion time has elapsed, we keep providing previously cached
value. Trouble is the first time read before conversion time is complete:

On sleep during update:
unfortunately, forcing the delay in update for the first time:
a) Will also cause the latency in the thermal_zone_device_check which
triggers right after tmp102_probe->thermal_zone_of_sensor_register
b) -EAGAIN is used by other hwmon drivers such as
drivers/hwmon/adt7470.c, drivers/hwmon/ltc4245.c, drivers/hwmon/sht15.c,
drivers/hwmon/tc74.c, drivers/hwmon/via-cputemp.c in similar ways when
data cannot be provided back.

Overriding the temp value to indicate first time read:
I can setup a bool in struct tmp102 instead -> but that serves the same
purpose as what we did with override, except increase 1 char footprint -
though I agree, it might be a little more readable.

> 
>> [1] http://www.ti.com/lit/ds/symlink/tmp102.pdf
>>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Reported-by: Aparna Balasubramanian <aparnab@ti.com>
>> Reported-by: Elvita Lobo <elvita@ti.com>
>> Reported-by: Yan Liu <yan-liu@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Example case (from Beagleboard-x15 using an older kernel revision):
>>     http://pastebin.ubuntu.com/13591711/
>> Notice the thermal shutdown trigger:
>>     thermal thermal_zone3: critical temperature reached(108
>> C),shutting down
>>
>>   drivers/hwmon/tmp102.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
>> index 65482624ea2c..145f69108f23 100644
>> --- a/drivers/hwmon/tmp102.c
>> +++ b/drivers/hwmon/tmp102.c
>> @@ -50,6 +50,9 @@
>>   #define    TMP102_TLOW_REG            0x02
>>   #define    TMP102_THIGH_REG        0x03
>>
>> +/* TMP102 range is -55 to 150C -> we use -128 as a default invalid
>> value */
>> +#define TMP102_NOTREADY            -128
>> +
> 
> This is a bit misleading, and also not correct, since the temperature is
> stored in
> milli-degrees C, so a value of -128 reflects -0.128 degreees C. While
> that value
> will not be seen in practice, it is still not a good idea to use it for
> this purpose.
> 
> Even though the chip temperature range is -55 .. 150 C, that doesn't mean
> it never returns a value outside that range, for example if nothing is
> connected
> to an external sensor or if something is broken.
> 
> You should use a value outside the value range, ie outside
> [-128,000 .. 127,999 ] to detect the "not ready" condition.


That is true.. I will just drop this and introduce a bool in tmp102 instead.

>>   struct tmp102 {
>>       struct i2c_client *client;
>>       struct device *hwmon_dev;
>> @@ -102,6 +105,12 @@ static int tmp102_read_temp(void *dev, int *temp)
>>   {
>>       struct tmp102 *tmp102 = tmp102_update_device(dev);
>>
>> +    /* Is it too early even to return a conversion? */
>> +    if (tmp102->temp[0] = TMP102_NOTREADY) {
>> +        dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
>> +        return -EAGAIN;
> 
> Does this cause a hard loop in the calling code, or will the thermal code
> delay before it reads again ?
> 
> If it causes a hard loop, it may be better to go to sleep if needed
> when reading the data, as suggested above.

Thermal framework is capable of handling -EAGAIN without a hard loop
around this (it just seems to reschedule around the polling interval and
comes back to check if data is ready).

If you are ok with the above, then I will send a v2 introducing a bool
to setup a flag for first_time read, but will leave the -EAGAIN alone.

-- 
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
