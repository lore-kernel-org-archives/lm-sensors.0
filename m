From: Nikolaus Schulz <mail@microschulz.de>
Date: Thu, 23 Feb 2012 19:12:39 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
Message-Id: <20120223191239.GC13767@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-6-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-6-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 05:32:34PM -0800, Guenter Roeck wrote:
> On Wed, Feb 22, 2012 at 05:18:48PM -0500, Nikolaus Schulz wrote:
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
> > ---
> [ ... ]
> 
> > @@ -363,12 +382,14 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
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
> > +			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
> 
> Might be time to get rid of those extra spaces.

I see no extra spaces.  You mean the extra parentheses?  I can update
the patch to drop them.

> > +			break;
> >  		}
> >  	} else {
> >  		/* clear each fanX_mode bit before setting them properly */
> > @@ -386,6 +407,8 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> >  			break;
> >  		case 3: /* fan speed */
> >  			break;
> > +		case 4: /* Automatic pwm */
> > +			return -EOPNOTSUPP;
> 
> 	Should be -EINVAL.

The value 4 is valid as it encodes an existing mode, it's just that this
code path handles hardware that does not support that mode.  Why should
the code return EINVAL?

Thanks for your review,
Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
