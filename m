From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 14 Jun 2006 15:14:41 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <449027E1.5050600@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Let's get the name right now, so that this future driver upgrade
> doesn't have to change it everywhere.

OK I changed it. Three places total ;)

>>>> +	struct i2c_client *client = to_i2c_client(dev);
>>>> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>>>> +	int nr = sensor_attr->index;
>>>> +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 1);
>>> Using SENSOR_LIMIT here doesn't make sense, as we're not dealing with a
>>> range. Better return -EINVAL if value is neither 0 nor 1.
>> Well yes why not, maybe we should write a note to a docs?
> 
> I think the best we can do is to make it right in our drivers, because
> this is where people look when writing new drivers. If you want to
> extend the sysfs-interface documentation file to describe how invalid
> values should be handled (on write), feel free to do so.

Ok

Well they are handled at least with two different ways.

1) -EINVAL
2) if out of bounds - nearest bound is written

>>> I just realized that you are emulating pwm_enable = 0. I guess the chip
>>> doesn't support it? Then you don't want to implement it in the driver.
>>> This emulation makes your code much more complex with no gain at all.
>>> Drivers must implement what the chip support, they must NOT emulate
>>> features.
>> On the other hand we want consistent interface... I thought that either the file
>> could be present or not, but if present it MUST support 0 and 1 at least.
>>
>> I think you told me that that -EINVAL should do it and I can revert the
>> emulation stuff back. But I think we should FIX this in docs so it cannot be a
>> matter of interpretation.
> 
> Patch welcome :)

OK

>> Anyone will help me?
> 
> I think I already helped much by reviewing so much code in the past.
> Everything I said there is a candidate for your page if you want to
> write it.

Yes I had it in mind. But this was not addressed to you. But to others round here...

Regards
Rudolf


