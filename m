From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 02 Mar 2012 18:16:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enab
Message-Id: <20120302181632.GA6964@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-4-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-4-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 28, 2012 at 02:22:47PM -0800, Guenter Roeck wrote:
> On Tue, Feb 28, 2012 at 04:15:53PM -0500, Nikolaus Schulz wrote:
> > From: Nikolaus Schulz <schulz@macnetix.de>
> > 
> > The F75387 supports automatic fan control using either PWM duty cycle or
> > RPM speed values.  Make the driver detect the latter mode, and expose the
> > different modes in sysfs as per pwm_enable, so that the user can switch
> > between them.
> > 
> > The interpretation of the pwm_enable attribute for the F75387 is adjusted
> > to be a superset of those values used for similar Fintek chips which do
> > not support automatic duty mode, with 2 mapping to automatic speed mode,
> > and moving automatic duty mode to the new value 4.
> > 
> > Toggling the duty mode via pwm_enable is currently denied for the F75387,
> > as the chip then simply reinterprets the fan configuration register values
> > according to the new mode, switching between RPM and PWM units, which
> > makes this a dangerous operation.
> > 
> > Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> 
> Nikolaus,
> 
> I don't feel comfortable adding this patch to 3.3 at this point; it is not a pure
> bug fix but a functionality enhancement.

The patch is indeed quite invasive for v3.3, but I think it is necessary
in this form in order to fix the current code.  Let me explain.  (Be
warned, this is going to be verbose.)

The F75373 & F75375 chips support three modes:

a) Closed loop, user specifies RPM.
   Let's call that "manual speed mode".
b) Open loop, user specifies PWM aka duty cycle.
   ("manual duty mode")
c) Automatic temperature mode, user may configure RPM depending on
   temperature, this is again a closed loop mode.
   ("automatic speed mode")

One can distinguish these modes by two boolean switches: duty mode vs
speed mode (aka open loop vs closed loop), and auto vs. manual
(temperature-drive or not).

Automatic duty mode is not supported by the F75373 & F75375, and in the
driver, the three supported modes map to the values 1, 2 and 3 for
pwm*_enable.

But the F75387 is different as it supports all four possible modes.
Thus, to express these in sysfs, we need to extend the range of valid
values for pwm*_enable.  Note that any mode might have been enabled by
the BIOS at system startup, so the driver really should detect and
report all four modes correctly.

Currently, for the F75387, f75375_init does not initialize pwm*_enable
correctly: it identifies manual duty mode as manual speed mode, and
identifies both manual speed mode and auto speed mode as manual mode.
I think this should be fixed in v3.3 to identify all four modes
correctly. -  This is the first change in my patch.

Now, for the F75387 the matter is slightly complicated by the fact that
the same registers are used to configure the open and closed loop modes.
So, at any point in time, these registers can only hold the
configuration for one of these modes - and they make sense only for that
mode.

Thus, switching from an open loop mode to a closed loop mode and vice
versa is generally dangerous for this chip, because the PWM values in
the configuration register(s) are then simply reinterpreted as RPM and
vice versa.  Which is of course bogus.  Moreover, changing the
configuration registers for auto mode is not (yet) supported by the
driver, so we're stuck here with the values provided by the BIOS.
And the BIOS might have configured any auto mode, either duty or speed
mode.

The current code lets the user switch to automatic duty mode only, and
does not provide a way to activate auto speed mode.  This might enable a
bogus configuration, with uncertain consequences.

For these reasons, until a safe way to support switching between open
loop mode and closed loop mode is implemented in the driver, my patch
inhibits such a mode switch. -  This is the second change in my patch.

Moreover, when setting modes via writes to pwm*_enable, the current
mapping of values to modes is inconsistent: for the F75387, 2 maps
to automatic duty mode, while for the F75373 & F75375, it maps to
automatic speed mode.  IMO this should be fixed in v3.3 to avoid
breaking the API later. -  This is the third change in my patch
(touching the same area as the first).

> We can either wait for 3.4, or split it into
> two patches (if possible), one to fix <automatic, speed mode> for 3.3 and one to add 
> <automatic, pwm> for 3.4.
> 
> Any preference ?

Given my reasoning above, I consider this more a fix of seriously broken
functionality, rather than an addition of new functionality.  We simply
cannot ignore the automatic pwm mode, because it might already be
enabled by the BIOS.  The board I use for testing does so, for example.

So I really think this should go into v3.3.

However, it might make sense to split out the inhibiting of switches
between open and closed loop modes.

-- Nikolaus

> > ---
> >  drivers/hwmon/f75375s.c |   42 ++++++++++++++++++++++++++++++++++--------
> >  1 files changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> > index 29c0d06..3fee82dc 100644
> > --- a/drivers/hwmon/f75375s.c
> > +++ b/drivers/hwmon/f75375s.c
> > @@ -263,6 +263,21 @@ static inline u16 rpm_to_reg(int rpm)
> >  	return 1500000 / rpm;
> >  }
> >  
> > +static bool duty_mode_enabled(u8 pwm_enable)
> > +{
> > +	switch (pwm_enable) {
> > +	case 0: /* Manual, duty mode (full speed) */
> > +	case 1: /* Manual, duty mode */
> > +	case 4: /* Auto, duty mode */
> > +		return true;
> > +	case 2: /* Auto, speed mode */
> > +	case 3: /* Manual, speed mode */
> > +		return false;
> > +	default:
> > +		BUG();
> > +	}
> > +}
> > +
> >  static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
> >  		const char *buf, size_t count)
> >  {
> > @@ -336,11 +351,15 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> >  	struct f75375_data *data = i2c_get_clientdata(client);
> >  	u8 fanmode;
> >  
> > -	if (val < 0 || val > 3)
> > +	if (val < 0 || val > 4)
> >  		return -EINVAL;
> >  
> >  	fanmode = f75375_read8(client, F75375_REG_FAN_TIMER);
> >  	if (data->kind = f75387) {
> > +		/* For now, deny dangerous toggling of duty mode */
> > +		if (duty_mode_enabled(data->pwm_enable[nr]) !> > +				duty_mode_enabled(val))
> > +			return -EOPNOTSUPP;
> >  		/* clear each fanX_mode bit before setting them properly */
> >  		fanmode &= ~(1 << F75387_FAN_DUTY_MODE(nr));
> >  		fanmode &= ~(1 << F75387_FAN_MANU_MODE(nr));
> > @@ -354,12 +373,14 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> >  			fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
> >  			fanmode  |= (1 << F75387_FAN_DUTY_MODE(nr));
> >  			break;
> > -		case 2: /* AUTOMATIC*/
> > -			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
> > +		case 2: /* Automatic, speed mode */
> >  			break;
> >  		case 3: /* fan speed */
> >  			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
> >  			break;
> > +		case 4: /* Automatic, pwm */
> > +			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
> > +			break;
> >  		}
> >  	} else {
> >  		/* clear each fanX_mode bit before setting them properly */
> > @@ -377,6 +398,8 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> >  			break;
> >  		case 3: /* fan speed */
> >  			break;
> > +		case 4: /* Automatic pwm */
> > +			return -EINVAL;
> >  		}
> >  	}
> >  
> > @@ -734,14 +757,17 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
> >  
> >  				manu = ((mode >> F75387_FAN_MANU_MODE(nr)) & 1);
> >  				duty = ((mode >> F75387_FAN_DUTY_MODE(nr)) & 1);
> > -				if (manu && duty)
> > -					/* speed */
> > +				if (!manu && duty)
> > +					/* auto, pwm */
> > +					data->pwm_enable[nr] = 4;
> > +				else if (manu && !duty)
> > +					/* manual, speed */
> >  					data->pwm_enable[nr] = 3;
> > -				else if (!manu && duty)
> > -					/* automatic */
> > +				else if (!manu && !duty)
> > +					/* automatic, speed */
> >  					data->pwm_enable[nr] = 2;
> >  				else
> > -					/* manual */
> > +					/* manual, pwm */
> >  					data->pwm_enable[nr] = 1;
> >  			} else {
> >  				if (!(conf & (1 << F75375_FAN_CTRL_LINEAR(nr))))
> > -- 
> > 1.7.9.1
> > 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
