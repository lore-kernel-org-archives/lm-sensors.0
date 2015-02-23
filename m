From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 23 Feb 2015 16:13:36 +0000
Subject: Re: [lm-sensors] [PATCH v4 7/8] hwmon: pwm-fan: Read PWM FAN configuration from device tree
Message-Id: <20150223171336.2e09ce50@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-8-git-send-email-l.majewski@samsung.com>
 <54E7D0B3.7040800@roeck-us.net>
In-Reply-To: <54E7D0B3.7040800@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi Guenter,

> On 02/18/2015 02:07 AM, Lukasz Majewski wrote:
> > This patch provides code for reading PWM FAN configuration data via
> > device tree. The pwm-fan can work with full speed when configuration
> > is not provided. However, errors are propagated when wrong DT
> > bindings are found.
> > Additionally the struct pwm_fan_ctx has been extended.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - Rename pwm_fan_max_states to pwm_fan_cooling_levels
> > - Moving pwm_fan_of_get_cooling_data() call after setting end
> > enabling PWM FAN
> > - pwm_fan_of_get_cooling_data() now can fail - preserving old
> > behaviour
> > - Remove unnecessary dev_err() call
> > Changes for v3:
> > - Patch's headline has been reedited
> > - pwm_fan_of_get_cooling_data() return code is now being checked.
> > - of_property_count_elems_of_size() is now used instead
> > of_find_property()
> > - More verbose patch description added
> > Changes for v4:
> > - dev_err() has been removed from pwm_fan_of_get_cooling_data()
> > - Returning -EINVAL when "cooling-levels" are defined in DT, but
> > doesn't have the value
> > ---
> >   drivers/hwmon/pwm-fan.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> > 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index bd42d39..82cd06a 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -30,7 +30,10 @@
> >   struct pwm_fan_ctx {
> >   	struct mutex lock;
> >   	struct pwm_device *pwm;
> > -	unsigned char pwm_value;
> > +	unsigned int pwm_value;
> > +	unsigned int pwm_fan_state;
> > +	unsigned int pwm_fan_max_state;
> > +	unsigned int *pwm_fan_cooling_levels;
> >   };
> >
> >   static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> > @@ -100,6 +103,48 @@ static struct attribute *pwm_fan_attrs[] = {
> >
> >   ATTRIBUTE_GROUPS(pwm_fan);
> >
> > +int pwm_fan_of_get_cooling_data(struct device *dev, struct
> > pwm_fan_ctx *ctx) +{
> > +	struct device_node *np = dev->of_node;
> > +	int num, i, ret;
> > +
> > +	ret = of_property_count_elems_of_size(np, "cooling-levels",
> > +					      sizeof(u32));
> > +
> > +	if (ret = -EINVAL)
> > +		return 0;
> 
> The function returns -EINVAL if there is no such property,
> but also if prop->length % elem_size != 0. The latter _would_
> be an error.
> 
> Overall I don't entirely understand why you do not call
> of_find_property first. If that returns NULL, you would know for sure
> that the property does not exist, and you would not have to second
> guess the returned error from of_property_count_elems_of_size.

For sake of readability I will at v5 first check of_find_property() and
if it is correct, then I will call of_property_count_u32_elems().

> 
> On a side note, there is of_property_count_u32_elems() to count
> properties of size u32.
> 
> > +
> > +	if (ret <= 0) {
> > +		dev_err(dev, "Wrong data!\n");
> > +		return ret ? ret : -EINVAL;
> > +	}
> 
> If devicetree is not configured, of_property_count_elems_of_size
> returns -ENOSYS, which is returned, causing the driver to fail
> loading.

Has of_property_count_elems_of_size() returns -ENOSYS?

Maybe something has changed, but in my linux-vanila (3.19-rc4)
at ./drivers/of/base.c it returns -EINVAL, -ENODATA or number of
elements.

Have I missed something?

> 
> > +
> > +	num = ret;
> > +	ctx->pwm_fan_cooling_levels = devm_kzalloc(dev, num *
> > sizeof(u32),
> > +						   GFP_KERNEL);
> > +	if (!ctx->pwm_fan_cooling_levels)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32_array(np, "cooling-levels",
> > +
> > ctx->pwm_fan_cooling_levels, num);
> > +	if (ret) {
> > +		dev_err(dev, "Property 'cooling-levels' cannot be
> > read!\n");
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < num; i++) {
> > +		if (ctx->pwm_fan_cooling_levels[i] > MAX_PWM) {
> > +			dev_err(dev, "PWM fan state[%d]:%d >
> > %d\n", i,
> > +				ctx->pwm_fan_cooling_levels[i],
> > MAX_PWM);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	ctx->pwm_fan_max_state = num - 1;
> > +
> > +	return 0;
> > +}
> > +
> >   static int pwm_fan_probe(struct platform_device *pdev)
> >   {
> >   	struct device *hwmon;
> > @@ -145,6 +190,11 @@ static int pwm_fan_probe(struct
> > platform_device *pdev) pwm_disable(ctx->pwm);
> >   		return PTR_ERR(hwmon);
> >   	}
> > +
> > +	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
> > +	if (ret)
> > +		return ret;

I think that here is the confusing part. Please compare this patch with
the following one.

Here we configure ctx struct via DT. If of_property_count_u32_elems()
returns -EINVAL, then we consider that "cooling-levels" wasn't defined
in DT and return with 0. Other error codes are considered as errors
and probe return error code.

> > +
> >   	return 0;
> >   }
> >
> >
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
