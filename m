From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 19 Feb 2013 12:05:42 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (adt7x10) Add alarm interrupt support
Message-Id: <51236A96.3040000@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de> <1361194739-16525-3-git-send-email-lars@metafoo.de> <20130219013933.GD25124@roeck-us.net>
In-Reply-To: <20130219013933.GD25124@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On 02/19/2013 02:39 AM, Guenter Roeck wrote:
> On Mon, Feb 18, 2013 at 02:38:58PM +0100, Lars-Peter Clausen wrote:
>> This allows a userspace application to poll() on the alarm files to get notified
>> in case of an temperature threshold event.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>
[...]
>>  
>> +static irqreturn_t adt7410_irq_handler(int irq, void *private)
>> +{
>> +	struct device *dev = private;
>> +	int status;
>> +
>> +	status = adt7410_read_byte(dev, ADT7410_STATUS);
>> +	if (status < 0)
>> +		return IRQ_HANDLED;
>> +
>> +	if (status & ADT7410_STAT_T_HIGH)
>> +		sysfs_notify(&dev->kobj, NULL, "temp1_max_alarm");
>> +	if (status & ADT7410_STAT_T_LOW)
>> +		sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
>> +	if (status & ADT7410_STAT_T_CRIT)
>> +		sysfs_notify(&dev->kobj, NULL, "temp1_crit_alarm");
>> +
> Question about semantics: Do you want a notification on all attributes each time
> one is set during an interrupt, or do you want a notification each time an
> attribute changes state ? With the above code, the 1->0 transition does not
> result in a notification. Is that on purpose ?
> 

Now that the code uses an edge triggered IRQ and comparator mode it would
actually be possible to also generate an event for a 1->0 transition, but
I'm not sure how much sense that makes. Usually you'd only want to respond
quickly to the case where a threshold event happens.

>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int adt7410_temp_ready(struct device *dev)
>>  {
>>  	int i, status;
>> @@ -357,7 +377,7 @@ static const struct attribute_group adt7410_group = {
>>  	.attrs = adt7410_attributes,
>>  };
>>  
>> -int adt7410_probe(struct device *dev, const char *name,
>> +int adt7410_probe(struct device *dev, const char *name, int irq,
>>  	const struct adt7410_ops *ops)
>>  {
>>  	struct adt7410_data *data;
>> @@ -383,11 +403,13 @@ int adt7410_probe(struct device *dev, const char *name,
>>  	data->oldconfig = ret;
>>  
>>  	/*
>> -	 * Set to 16 bit resolution, continous conversion and comparator mode.
>> +	 * Set to 16 bit resolution and continous conversion
>>  	 */
>>  	data->config = data->oldconfig;
>> -	data->config &= ~ADT7410_MODE_MASK;
>> +	data->config &= ~(ADT7410_MODE_MASK | ADT7410_CT_POLARITY |
>> +			ADT7410_INT_POLARITY);
>>  	data->config |= ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MODE;
>> +
>>  	if (data->config != data->oldconfig) {
>>  		ret = adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
>>  		if (ret)
>> @@ -421,8 +443,18 @@ int adt7410_probe(struct device *dev, const char *name,
>>  		goto exit_remove_name;
>>  	}
>>  
>> +	if (irq > 0) {
>> +		ret = request_threaded_irq(irq, NULL, adt7410_irq_handler,
>> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				dev_name(dev), dev);
> 
> If you use devm_request_threaded_irq, you don't have to release it on remove.

devm_request_threaded_irq is tricky, since the IRQ will only be freed after
the drivers remove callback has been run. This can cause race conditions,
since the IRQ handler often access resources already freed in the remove
callback. In this case it will work fine since sysfs_notify handles the case
where the files are already gone gracefully and just does nothing in that
case. I'd still prefer to keep the explicit free, so things are cleaned up
in the reverse order to the way they were set up.

> 
>> +		if (ret)
>> +			goto exit_hwmon_device_unregister;
>> +	}
>> +
> 
> This code should be before hwmon registration.

Why? It doesn't make sense to signal an event before userspace can actually
discover the device.

> 
>>  	return 0;
>>  
>> +exit_hwmon_device_unregister:
>> +	hwmon_device_unregister(data->hwmon_dev);
>>  exit_remove_name:
>>  	if (name)
>>  		device_remove_file(dev, &dev_attr_name);
>> @@ -434,10 +466,13 @@ exit_restore:
>>  }
>>  EXPORT_SYMBOL_GPL(adt7410_probe);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
