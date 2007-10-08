From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Oct 2007 08:49:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/w83781d: Add individual alarm and
Message-Id: <20071008104904.63c28574@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007205740.0c52f8cf@hyperion.delvare>
In-Reply-To: <20071007205740.0c52f8cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Thanks for the fast review :)

On Sun, 07 Oct 2007 21:11:20 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > The upcoming libsensors 3 needs these individual alarm and beep files.
> > For the W83781D, this is quirky because this chip has a single alarm
> > bit for both temp2 and temp3.
> 
> Here is a quick review:
> 
> <snip>
> 
> > +static ssize_t
> > +store_beep(struct device *dev, struct device_attribute *attr,
> > +		const char *buf, size_t count)
> > +{
> > +	struct w83781d_data *data = w83781d_update_device(dev);
> > +	int bitnr = to_sensor_dev_attr(attr)->index;
> > +	unsigned long bit;
> > +	u8 reg;
> > +
> 
> You've just thought me not to call foo_update_device() in store functions, 
> since I agree with your assessment that calling foo_update_device() in store 
> functions is bad, please fix this.

You're totally right. Probably the result of a careless copy-and-paste.
I'll fix and resubmit.

> > +	bit = simple_strtoul(buf, NULL, 10);
> > +	if (bit & ~1)
> > +		return -EINVAL;
>  > +	bit <<= bitnr;
>  > +
>  > +	mutex_lock(&data->update_lock);
>  > +	data->beep_mask &= ~(1 << bitnr);
>  > +	data->beep_mask |= bit;
> 
> Hmm, we need a clearer convention for writes to sysfs attr which are a boolean. 
> In both of my abituguru drivers and in the fschmd driver I use:
> 	unsigned long bool = bit = simple_strtoul(buf, NULL, 10);
> 
> And then
> 	if (bool)
> 		...
> 	else
> 		...
> 
> Your code above does things different. So I think we need a convention for this 
> (and add the conention to the sysfs-interface doc). I prefer my way, if only 
> for not having to change it everywhere.

We already have a convention. From sysfs-interface: "If it is not
continuous like for example a tempX_type, then when an invalid value is
written, -EINVAL should be returned." Boolean values fall under this
"not continuous" category, which means that unsupported values should
trigger an error.

> I would like to suggest the following 
> for your code:
>
>  > +	bit = simple_strtoul(buf, NULL, 10);
>  > +
>  > +	mutex_lock(&data->update_lock);
>  > +	if (bit)
>  > +		data->beep_mask |= 1 << bitnr;
>  > +	else
>  > +		data->beep_mask &= ~(1 << bitnr);
> 
> I must say I also find this more readable / cleaner.

I was a bit reluctant at first because it makes the code larger, but
well, if you think it's more readable that way, this section isn't
time-critical so why not.

I'll retest and resubmit my patch later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
