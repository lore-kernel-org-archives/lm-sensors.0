From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 13:08:48 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (gl518sm) Refactor fan functions
Message-Id: <20071125140848.4b2eb924@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022174642.3c3ce8f0@hyperion.delvare>
In-Reply-To: <20071022174642.3c3ce8f0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Herbert,

Thanks for your review.

On Sat, 24 Nov 2007 22:26:21 +0100, Herbert Valerio Riedel wrote:
> On Mon, 2007-10-22 at 17:46 +0200, Jean Delvare wrote:
> > This makes the code more readable and the binary smaller (by 5% or so).
> 
> :-)
> 
> > +static ssize_t show_fan_input(struct device *dev,
> > +			      struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct gl518_data *data = gl518_update_device(dev);
> > +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_in[nr],
> > +					DIV_FROM_REG(data->fan_div[nr])));
> > +}
> > +
> > +static ssize_t show_fan_min(struct device *dev,
> > +			    struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct gl518_data *data = gl518_update_device(dev);
> > +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
> > +					DIV_FROM_REG(data->fan_div[nr])));
> > +}
> > +
> > +static ssize_t show_fan_div(struct device *dev,
> > +			    struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct gl518_data *data = gl518_update_device(dev);
> > +	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
> > +}
> 
> imho, it would have been ok to reduce those 3 instantiations to a macro
> template and 3 expansions... but I guess it's a matter of preference :-)

Using a macro to define these functions would result in the same binary
code. The only thing it would save is a few lines in the code source,
at the price of a decreased readability (don't know about you, but my
text editor can't do syntax coloring on macro code). Macro-generated
functions are also grep-unfriendly, as they make the code look like the
functions are used but never defined, and in some cases, that some
macros are defined but never used.

So, as a general rule, I stay away from macro-generated functions.

> > -	data->fan_min[0] = FAN_TO_REG(val,
> > -		DIV_FROM_REG(data->fan_div[0]));
> > -	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
> > +	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> 
> > +	regvalue = (regvalue & (0xff << (8 * nr)))
> > +		 | (data->fan_min[nr] << (8 * (1 - nr)));
> 
> this shifting/masking looks a bit confusing to me; as 'nr' is supposed
> to take only 2 values, wouldn't it be more readable to use an if/else
> construct or an ?: operator? 
> 
> > +	regvalue = (regvalue & ~(0xc0 >> (2 * nr)))
> > +		 | (data->fan_div[nr] << (6 - 2 * nr));
> 
> same thing

I'll remember for my future patches. For this one, it was tested
successfully so I don't feel like changing the code again. I don't
have a GL518SM chip so I can't test myself.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
