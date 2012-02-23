From: Nikolaus Schulz <mail@microschulz.de>
Date: Thu, 23 Feb 2012 19:40:46 +0000
Subject: Re: [lm-sensors] [PATCH 6/6] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <20120223194046.GD13767@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-7-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-7-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 05:35:12PM -0800, Guenter Roeck wrote:
> On Wed, Feb 22, 2012 at 05:18:49PM -0500, Nikolaus Schulz wrote:
> > It makes no sense to attempt to manually configure the fan in auto mode,
> > or set the duty cycle directly in closed loop mode.  The corresponding
> > registers are then read-only.  If the user tries it nonetheless, error out
> > with EBUSY instead of silently doing nothing.
> > 
> > Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> > ---
> >  drivers/hwmon/f75375s.c |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> > index 29b11c6..0e7fe3a 100644
> > --- a/drivers/hwmon/f75375s.c
> > +++ b/drivers/hwmon/f75375s.c
> > @@ -281,6 +281,21 @@ static bool duty_mode_enabled(u8 pwm_enable)
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
> > @@ -314,6 +329,11 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	if (auto_mode_enabled(data->pwm_enable[nr]))
> > +		return -EBUSY;
> > +	if (data->kind = f75387 && duty_mode_enabled(data->pwm_enable[nr]))
> > +		return -EBUSY;
> > +
> -EBUSY is really not appropriate here. -EINVAL would be better, though I am open to suggestions.

I am not very happy about using EINVAL here, but if EBUSY is
inappropriate, I don't have a better idea.

> >  	mutex_lock(&data->update_lock);
> >  	data->fan_target[nr] = rpm_to_reg(val);
> >  	f75375_write16(client, F75375_REG_FAN_EXP(nr), data->fan_target[nr]);
> > @@ -334,6 +354,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	if (auto_mode_enabled(data->pwm_enable[nr]) ||
> > +			!duty_mode_enabled(data->pwm_enable[nr]))
> > +		return -EBUSY;
> > +
> Same here.

yes

> >  	mutex_lock(&data->update_lock);
> >  	/* TODO: Improve representation in the register cache for the F75387 */
> >  	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
> > @@ -819,6 +843,14 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
> >  	set_pwm_enable_direct(client, 0, f75375s_pdata->pwm_enable[0]);
> >  	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
> >  	for (nr = 0; nr < 2; nr++) {
> > +		if (auto_mode_enabled(f75375s_pdata->pwm_enable[nr]) ||
> > +		   !duty_mode_enabled(f75375s_pdata->pwm_enable[nr])) {
> > +			dev_err(data->hwmon_dev,
> > +				"fan %d: cannot set duty cycle in mode %d",
> > +				nr,
> > +				f75375s_pdata->pwm_enable[nr]);
> 
> Is this really an error ?

Ah, I see.  Indeed, setting automatic mode is certainly valid, the pwm
value in the platform data can just be ignored in that case.

Manual "speed mode" is less obvious, as there is currently no way to
configure this mode using platform data; but it might still be
reasonable to assume that the platform data is sane.

Ok, I'll drop the warning.

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
