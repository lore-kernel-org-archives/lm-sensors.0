From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 02 Mar 2012 21:59:52 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <20120302215952.GA9264@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-5-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-5-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 28, 2012 at 02:23:55PM -0800, Guenter Roeck wrote:
> On Tue, Feb 28, 2012 at 04:15:54PM -0500, Nikolaus Schulz wrote:
> > It makes no sense to attempt to manually configure the fan in auto mode,
> > or set the duty cycle directly in closed loop mode.  The corresponding
> > registers are then read-only.  If the user tries it nonetheless, error out
> > with EINVAL instead of silently doing nothing.
> > 
> > Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> 
> Same as before - we can either hold the patch for 3.4, or split it into two parts.
> Let me know which way you prefer.

I see that this patch can indeed be split.

> > ---
> >  drivers/hwmon/f75375s.c |   27 +++++++++++++++++++++++++++
> >  1 files changed, 27 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> > index 3fee82dc..5374501 100644
> > --- a/drivers/hwmon/f75375s.c
> > +++ b/drivers/hwmon/f75375s.c
> > @@ -278,6 +278,21 @@ static bool duty_mode_enabled(u8 pwm_enable)
> >  	}
> >  }
> >  
> > +static bool auto_mode_enabled(u8 pwm_enable)
> > +{
> > +	switch (pwm_enable) {
> > +	case 0: /* Manual, duty mode (full speed) */
> > +	case 1: /* Manual, duty mode */
> > +	case 3: /* Manual, speed mode */
> > +		return false;
> > +	case 2: /* Auto, speed mode */
> > +	case 4: /* Auto, duty mode */
> > +		return true;
> > +	default:
> > +		BUG();
> > +	}
> > +}
> > +
> >  static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
> >  		const char *buf, size_t count)
> >  {
> > @@ -311,6 +326,11 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	if (auto_mode_enabled(data->pwm_enable[nr]))
> > +		return -EINVAL;

This is harmless as the register is r/o in this case, so the change need
not go into v3.3.

> > +	if (data->kind = f75387 && duty_mode_enabled(data->pwm_enable[nr]))
> > +		return -EINVAL;
> > +

This is blocking a dangerous operation, so it is a good candidate for
v3.3.

> >  	mutex_lock(&data->update_lock);
> >  	data->fan_target[nr] = rpm_to_reg(val);
> >  	f75375_write16(client, F75375_REG_FAN_EXP(nr), data->fan_target[nr]);
> > @@ -331,6 +351,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	if (auto_mode_enabled(data->pwm_enable[nr]) ||
> > +			!duty_mode_enabled(data->pwm_enable[nr]))
> > +		return -EINVAL;
> > +

This is combination of the two cases above.  The check for auto mode is
again only cosmetic, but the check for duty mode is blocking a dangerous
operation for the F75387.

> >  	mutex_lock(&data->update_lock);
> >  	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
> >  	f75375_write_pwm(client, nr, data->pwm[nr]);
> > @@ -792,6 +816,9 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
> >  	set_pwm_enable_direct(client, 0, f75375s_pdata->pwm_enable[0]);
> >  	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
> >  	for (nr = 0; nr < 2; nr++) {
> > +		if (auto_mode_enabled(f75375s_pdata->pwm_enable[nr]) ||
> > +		   !duty_mode_enabled(f75375s_pdata->pwm_enable[nr]))
> > +			continue;

This is again combining a cosmetic and a safety check.

> >  		data->pwm[nr] = SENSORS_LIMIT(f75375s_pdata->pwm[nr], 0, 255);
> >  		f75375_write_pwm(client, nr, data->pwm[nr]);
> >  	}
> > -- 
> > 1.7.9.1

How shall we proceed here?  I can split this, but then I see that you
have already applied the current patch to -next.

-- Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
