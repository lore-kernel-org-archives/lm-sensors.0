From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Feb 2014 17:18:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm95245) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <5308DC03.50203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391747559-7601-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391747559-7601-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/22/2014 08:54 AM, Jean Delvare wrote:
> On Sat, 22 Feb 2014 07:52:30 -0800, Guenter Roeck wrote:
>> On 02/22/2014 05:32 AM, Jean Delvare wrote:
>>> On Thu,  6 Feb 2014 20:32:39 -0800, Guenter Roeck wrote:
>>>> @@ -286,8 +286,8 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
>>>>    			     const char *buf, size_t count)
>>>>    {
>>>>    	struct lm95245_data *data = lm95245_update_device(dev);
>>>> -	struct i2c_client *client = to_i2c_client(dev);
>>>>    	int index = to_sensor_dev_attr(attr)->index;
>>>> +	struct i2c_client *client = data->client;
>>>
>>> I'm curious why you're swapping these lines? I can't find a rationale
>>> for it, and it makes the patch (very slightly) larger.
>>
>> Habit I picked up from one of the Intel maintainers ... long variable names
>> first. It makes the code look a bit nicer.
>
> I agree with the idea in general, when writing the code, it indeed
> makes the code easier to read. However moving a declaration along later
> because it is now 4 characters shorter than it used to be... Seems a
> bit difficult to justify ;-)
>
> No big deal anyway. I'm not doing the work so I don't really have my
> say!
>

H Jean,

I just like it neat :-). Other side of the coin would be that keeping it
sorted early on only to let it deteriorate later doesn't sound good either.

I'll resubmit the entire series. After making the change to no longer use
update_device in the set function, the code looked too much different to
just use your Reviewed-by.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
