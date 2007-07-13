From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 13 Jul 2007 12:08:53 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <46976B55.8010803@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

While actually updating the driver I realized I didn't respond to all points 
raised (I think), so here is my reply to the other points.

>> +static struct f71882fg_data *f71882fg_update_device(struct device * dev)
>> +{
>> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>> +	int nr, reg, reg2;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	
>> +	/* Update once every 60 seconds */
>> +	if ( time_after(jiffies, data->last_updated + 60 * HZ ) ||
>> +			!data->valid) {
> 
> You test last_updated here but update last_limits below.  Is that
> really what you intended?  last_limits isn't used anywhere in
> the driver.
> 

Good catch, will fix.

>> +static ssize_t store_in_max(struct device *dev, struct device_attribute
>> +	*devattr, const char *buf, size_t count)
>> +{
>> +	struct f71882fg_data *data = dev_get_drvdata(dev);
>> +	int val = simple_strtoul(buf, NULL, 10) / 8;
>> +	
>> +	if (val > 255)
>> +		val = 255;
> 
> This check won't catch the case where I feed your sysfs file "-4096"
> and the value inside f71882fg_data won't match what gets written to the
> port.  Granted, the maxim "If you write garbage to the control systems
> you deserve what you get" might apply here too.
> 

Notice that I use simple_strtoul, so val will never be < 0, if you write -4096 
strtoul will not recognize the - and return 0.

I know it looks strange to store the return value in an int then, but in some 
of the other store methods I need val to be signed, and for consistency I've 
thus stored it into an int everywhere.


Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
