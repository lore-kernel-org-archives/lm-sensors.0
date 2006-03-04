From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Mar 2006 15:04:31 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <20060304160431.a10afb4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I just finished adding the support for voltage channels on EHF chip. Feel free to test it.
> (This implies to the mailing list members rather to you Yuan, I know you are busy ;)
> 
> Jean, If you like it, please apply (after someone did the testing in reasonable time)

Can I have a -p1 patch please?

Comments on the code:

> +    This is a preliminary version of the driver. The chip does much more than
> +    that.

The "much" is probably too much now that the voltage inputs, and parts
of the alarms, are supported.

> +/* The W83627EHF registers for nr=7,8,9 are in bank 5 */
> +#define W83627EHF_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \
> +					   (0x554 + (((nr) - 7) * 2)))
> +#define W83627EHF_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \
> +					   (0x555 + (((nr) - 7) * 2)))
> +#define W83627EHF_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
> +					   (0x550 + (nr) - 7))

Don't use spaces for primary alignment please.

> +/* Some of registers have internal scaling,
> +   8mV is ADC LSB and some are scaled twice */

They are "scaled by a factor of 2", rather than "scaled twice". You may
also mention the word "internally", as this is the reason why we care
in the driver rather than user-space.

> +static u8 scale_in[10] = { 3, 3, 4, 4, 3, 3, 3, 4, 4, 3 };
> +
> +static inline u32 in_from_reg(u8 reg, u8 nr)
> +{
> +	return reg << scale_in[nr];
> +}
> +
> +static inline u8 in_to_reg(u32 val, u8 nr)
> +{
> +	return SENSORS_LIMIT(((val + (1 << (scale_in[nr] - 1))) / 
> +					(1 << scale_in[nr])), 0, 255);
> +}

That bit-shifting makes things quite hard to read. Why don't you just
go with explicit multiplications/divisions by 8 and 2 (or 8 and 16 if
you prefer)? This would be much easier to check, and I'm almost certain
that the compiler will generate the same code anyway.

> +		for (i = 0; i < 10; i++) {
> +			data->in[i] > +			    w83627ehf_read_value(client, W83627EHF_REG_IN(i));
> +			data->in_min[i] > +			    w83627ehf_read_value(client,
> +					       W83627EHF_REG_IN_MIN(i));
> +			data->in_max[i] > +			    w83627ehf_read_value(client,
> +					       W83627EHF_REG_IN_MAX(i));
> +
> +		}

Coding style, please.

> +static ssize_t show_##reg (struct device *dev, struct device_attribute *attr, char *buf) \

Line too long.

> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);\
> +	int nr = sensor_attr->index;\
> +	return sprintf(buf,"%ld\n", (long)in_from_reg(data->reg[nr], nr)); \

Missing space before backslash (twice), missing space after comma, and
there are many more in your patch. Please pay attention, you've been
around for long enough now to know how picky I am about this! ;)

I also fail to see the point of the cast; just make sure that
in_from_reg() will return what you need (i.e. long instead of u32) in
the first place.

> +static ssize_t show_in_alarm(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev);
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +	int nr = sensor_attr->index;
> +	return sprintf(buf,"%d\n", 
> +			(1 << W83627EHF_ALARM_IN_SHIFT[nr]) & data->alarms ? 1 : 0);
> +}

Looks inefficient. Why don't you instead store
W83627EHF_ALARM_IN_SHIFT[N] in sensor_attr->index when creating the
sysfs file? You would spare the lookup on each file read, and you
wouldn't even need to define an array with the shift values.

Also, an added benefit would be that the same callback could be used
for temperatures and fans as well, not just voltages.

Rest looks OK. Now with this patch, we end up with alarms for the
voltages and not the other input types, so I'd appreciate an incremental
patch adding these, for consistency. It should be quite straightforward.

Also I see that this driver has no documentation file. Shame on me, but
if anyone wants to contribute a patch, this would be welcome.

Thanks,
-- 
Jean Delvare

