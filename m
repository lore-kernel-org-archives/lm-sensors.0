From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 16 Jun 2009 08:08:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: Add driver tmp421 for TI's
Message-Id: <4A3752FE.8010708@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074320.GB4667@ubuntu>
In-Reply-To: <20090615074320.GB4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 06/16/2009 09:58 AM, Andre Prendel wrote:
> On Mon, Jun 15, 2009 at 10:52:24PM +0200, Jean Delvare wrote:
>> Hi Andre,
>
> Hi again,
>
> There is one remaining question, see below.
>

See below for my answer.

<snip>

>>> +static ssize_t show_temp_value(struct device *dev,
>>> +			       struct device_attribute *devattr, char *buf)
>>> +{
>>> +	int index = to_sensor_dev_attr(devattr)->index;
>>> +	struct tmp421_data *data = tmp421_update_device(dev);
>>> +	int temp;
>>> +
>>> +	if (data->config&  TMP421_CONFIG_RANGE)
>>> +		temp = temp_from_u16(data->temp[index]);
>>> +	else
>>> +		temp = temp_from_s16(data->temp[index]);
>> This lacks protection: you have no guarantee that data->config and
>> data->temp[index] belong to the same read cycle.
>
> The *data pointer comes from tmp421_update_device(dev). So this should
> be from the same cycle, shouldn't be. I don't know how to
> protect. Hardware access is protected in tmp421_update_device(). Maybe
> I misunderstood something.
>

Yes, but 2 sysfs attributes can be read (by different processes / threads) at
the same time, this could lead to the following:

Proc 1:
Read temp1_value
tmp421_update_device() does not do anything as it isn't time yet
Check data->config
<task switch>

Proc 2:
Read temp1_value
tmp421_update_device() reads the entire chip
Calculate temp and return to userspace
<task switch>

Proc 1:
Read data->temp[index] and do calulation.
return temp to userspace

Now Proc 1 has used data->config and data->temp from 2
different read cycles. Since data->config should never
change this is a bit of a theoretical problem here. But
still you should protect against it, even if for no other reason
as to be good example code for people looking for an example.

The way to protect against this is like this:

	mutex_lock(&data->update_lock);
	if (data->config&  TMP421_CONFIG_RANGE)
		temp = temp_from_u16(data->temp[index]);
	else
		temp = temp_from_s16(data->temp[index]);
	mutex_unlock(&data->update_lock);


<snip>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
