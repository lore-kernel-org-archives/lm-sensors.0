From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 20:47:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] hwmon: (w83795) Fix fan control mode
Message-Id: <20101107214722.25f3b020@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107163636.2ca42efe@endymion.delvare>
In-Reply-To: <20101107163636.2ca42efe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Thanks for the quick reviews!

On Sun, 7 Nov 2010 08:23:06 -0800, Guenter Roeck wrote:
> On Sun, Nov 07, 2010 at 10:36:36AM -0500, Jean Delvare wrote:
> > There were two bugs:
> > * Speed cruise mode was improperly reported for all fans but fan1.
> > * Fan control method (PWM vs. DC) was mixed with the control mode.
> >   It will be added back as a separate attribute, as per the standard
> >   sysfs interface.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Couple of questions below. If as intended,
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> > ---
> >  w83795.c |   18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > --- a/drivers/hwmon/w83795.c	2010-10-29 14:00:04.000000000 +0200
> > +++ b/drivers/hwmon/w83795.c	2010-10-29 14:00:07.000000000 +0200
> > @@ -857,20 +857,20 @@ show_pwm_enable(struct device *dev, stru
> >  	int index = sensor_attr->index;
> >  	u8 tmp;
> >  
> > -	if (1 = (data->pwm_fcms[0] & (1 << index))) {
> > +	/* Speed cruise mode */
> > +	if (data->pwm_fcms[0] & (1 << index)) {
> >  		tmp = 2;
> >  		goto out;
> >  	}
> > +	/* Thermal cruise or SmartFan IV mode */
> >  	for (tmp = 0; tmp < 6; tmp++) {
> >  		if (data->pwm_tfmr[tmp] & (1 << index)) {
> >  			tmp = 3;
> 
> That means return values are 1, 2, or 3, but never 0 (= full speed per ABI).

Yes. The device doesn't support mode 0, so the driver can't return it,
ever.

> On the setting side, you only support 1 and 2, but not 3 or 0.
> 
> Is that as intended ?

Not supporting 0 is completely intended, the device doesn't support
that mode so the driver can't implement it.

Not supporting 3 isn't a limitation introduced by my patch, the code
already didn't support setting mode to 3. And I'm not sure if we can
ever support setting it directly. It is not trivial at all. The device
doesn't allow setting a given PWM output to mode 3
(temperature-controlled) directly. Instead, it lets you configure
temperature channels for automatic fan speed control, and a given PWM
output is considered to be in mode 3 if any temperature channel has
this PWM output listed as a target. In fact, the device treats manual
control as a degraded variant of temperature-based automatic control
(when temperature source count is zero.)

I need to look more into the details, but I suspect the code is OK as
is, and setting mode 3 has to be done indirectly, by writing to the
pwm/temp mapping files.

We could allow setting mode 3 directly if we remembered which
temperature channels were used as sources last time mode was 3. However
I'm not sure if this is desirable, for 2 reasons. First reason, this
won't work if mode isn't set to 3 when the driver gets loaded. Second
reason, the source temperatures are indirect as well, there is a
look-up table involved, and a change to this table while a given PWM
output isn't in mode 3 would mean that we will restore settings which
have a different meaning when PWM mode is set back to 3.

The temperature-based fan speed control part of this device is really
complex and very hard to make fit into our sysfs interface, which is
why it currently doesn't. I really don't know how I'll solve this
problem.

> >  			goto out;
> >  		}
> >  	}
> > -	if (data->pwm_fomc & (1 << index))
> > -		tmp = 0;
> > -	else
> > -		tmp = 1;
> > +	/* Manual mode */
> > +	tmp = 1;
> >  
> What if (pwm_fomc & (1<<index)) is set from the bios ?
> Doesn't that state get lost now ?

Patch 2/7 hopefully answered this question ;)

> >  out:
> >  	return sprintf(buf, "%u\n", tmp);
> > @@ -890,23 +890,21 @@ store_pwm_enable(struct device *dev, str
> >  
> >  	if (strict_strtoul(buf, 10, &val) < 0)
> >  		return -EINVAL;
> > -	if (val > 2)
> > +	if (val < 1 || val > 2)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&data->update_lock);
> >  	switch (val) {
> > -	case 0:
> >  	case 1:
> > +		/* Clear speed cruise mode bits */
> >  		data->pwm_fcms[0] &= ~(1 << index);
> >  		w83795_write(client, W83795_REG_FCMS1, data->pwm_fcms[0]);
> > +		/* Clear thermal cruise mode bits */
> >  		for (i = 0; i < 6; i++) {
> >  			data->pwm_tfmr[i] &= ~(1 << index);
> >  			w83795_write(client, W83795_REG_TFMR(i),
> >  				data->pwm_tfmr[i]);
> >  		}
> > -		data->pwm_fomc |= 1 << index;
> > -		data->pwm_fomc ^= val << index;
> > -		w83795_write(client, W83795_REG_FOMC, data->pwm_fomc);
> >  		break;
> >  	case 2:
> >  		data->pwm_fcms[0] |= (1 << index);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
