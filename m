From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 08 Jan 2016 15:09:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add LTC2990 sensor driver
Message-Id: <568FD131.4080308@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1452067627-24939-1-git-send-email-mike.looijmans@topic.nl>
 <568D3127.5090901@roeck-us.net> <568EB58C.3090701@topic.nl>
In-Reply-To: <568EB58C.3090701@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Looijmans <mike.looijmans@topic.nl>, lm-sensors@lm-sensors.org
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org

On 01/07/2016 10:59 AM, Mike Looijmans wrote:
> Thank you very much for your review comments, I'll update the driver and post a v2 patch.
>
> Inlined some replies below. Assume that I "will do" for all comments I didn't comment on inline...
>
> On 06-01-16 16:22, Guenter Roeck wrote:
>> Hello Mike,
>>
>> On 01/06/2016 12:07 AM, Mike Looijmans wrote:
>>> This adds support for the Linear Technology LTC2990  I2C System Monitor.
>>
>> s/  / /
>>
>>> The LTC2990 supports a combination of voltage, current and temperature
>>> monitoring, but this driver currently only supports reading two currents
>>> by measuring two differential voltages across series resistors.
>>>
>> Plus VCC, plus the internal temperature.
>
> Yeah, I should give myself more credit :) I'll add that in Kconfig too.
>
>>> This is sufficient to support the Topic Miami SOM which uses this chip
>>> to monitor the currents flowing into the FPGA and the CPU parts.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>   drivers/hwmon/Kconfig   |  15 +++
>>>   drivers/hwmon/Makefile  |   1 +
>>>   drivers/hwmon/ltc2990.c | 273
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>

[ ... ]

>>> +}
>>> +
>>> +static struct ltc2990_data *ltc2990_update_device(struct device *dev)
>>> +{
>>> +    struct i2c_client *i2c = to_i2c_client(dev);
>>> +    struct ltc2990_data *data = i2c_get_clientdata(i2c);
>>> +    struct ltc2990_data *ret = data;
>>> +    unsigned int timeout;
>>> +
>>> +    mutex_lock(&data->update_lock);
>>> +
>>> +    /* Update about 4 times per second max */
>>> +    if (time_after(jiffies, data->last_updated + HZ / 4) ||
>>> !data->valid) {
>>> +        int val;
>>> +        int i;
>>> +
>>
>> Please consider using continuous conversion. This would simplify the
>> code significantly
>> and reduce read delays.
>
> It might increase power consumption though, as typically some user program would poll this every 10 seconds or so. I'll check the data sheet.
>

I suspect that the power savings will be less than the added power
consumed by the CPU due to the more complex code.

Really, unless you have an application where a few mW power savings
are essential and warrant the additional code complexity, this is
the wrong approach.

>>> +        /* Trigger ADC, any value will do */
>>> +        val = ltc2990_write(i2c, LTC2990_TRIGGER, 1);
>>> +        if (unlikely(val < 0)) {
>>> +            ret = ERR_PTR(val);
>>> +            goto abort;
>>> +        }
>>> +
>>> +        /* Wait for conversion complete */
>>> +        timeout = 200;
>>> +        for (;;) {
>>> +            usleep_range(2000, 4000);
>>> +            val = ltc2990_read_byte(i2c, LTC2990_STATUS);
>>> +            if (unlikely(val < 0)) {
>>> +                ret = ERR_PTR(val);
>>> +                goto abort;
>>> +            }
>>> +            /* Single-shot mode, wait for conversion to complete */
>>> +            if ((val & LTC2990_STATUS_BUSY) = 0)
>>
>>              if (!(...))
>>
>>> +                break;
>>> +            if (--timeout = 0) {
>>> +                ret = ERR_PTR(-ETIMEDOUT);
>>> +                goto abort;
>>> +            }
>>> +        }
>>
>> Again, please consider using continuous conversion mode.
>>
>> If this is not feasible for some reason, you might as well just wait for
>> the
>> minimum conversion time before trying to read for the first time. If so,
>> please use a fixed timeout by comparing the elapsed time instead of looping
>> for a maximum number of times. Not even counting the time for executing the
>> code, the maximum delay is between 400 ms and 800 ms, which is way too high
>> (chip spec says 167 ms worst case, if three temperature sensors are
>> configured).
>
> Or maybe I should just sleep for 167ms and be done with it. Though I think I'l got with your minimal time first suggestion.
>

Keep in mind that any user space program using this driver would effectively
go to sleep for the wait time. Maybe that doesn't matter in your application,
but it may be a problem for others. A fixed large delay would make the situation
even worse.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
