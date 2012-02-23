From: Nikolaus Schulz <mail@microschulz.de>
Date: Thu, 23 Feb 2012 19:58:20 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
Message-Id: <20120223195820.GF13767@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-6-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-6-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 23, 2012 at 11:21:09AM -0800, Guenter Roeck wrote:
> On Thu, 2012-02-23 at 14:12 -0500, Nikolaus Schulz wrote:
> > On Wed, Feb 22, 2012 at 05:32:34PM -0800, Guenter Roeck wrote:
> > > On Wed, Feb 22, 2012 at 05:18:48PM -0500, Nikolaus Schulz wrote:
> > > > From: Nikolaus Schulz <schulz@macnetix.de>
[...]
> > > > @@ -363,12 +382,14 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> > > >  			fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
> > > >  			fanmode  |= (1 << F75387_FAN_DUTY_MODE(nr));
> > > >  			break;
> > > > -		case 2: /* AUTOMATIC*/
> > > > -			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
> > > > +		case 2: /* Automatic, speed mode */
> > > >  			break;
> > > >  		case 3: /* fan speed */
> > > >  			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
> > > >  			break;
> > > > +		case 4: /* Automatic, pwm */
> > > > +			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
> > > 
> > > Might be time to get rid of those extra spaces.
> > 
> > I see no extra spaces.  You mean the extra parentheses?  I can update
> > the patch to drop them.
> > 
> There seem to be two spaces before and after |=.

Ah, got it :)

> > > > +			break;
> > > >  		}
> > > >  	} else {
> > > >  		/* clear each fanX_mode bit before setting them properly */
> > > > @@ -386,6 +407,8 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> > > >  			break;
> > > >  		case 3: /* fan speed */
> > > >  			break;
> > > > +		case 4: /* Automatic pwm */
> > > > +			return -EOPNOTSUPP;
> > > 
> > > 	Should be -EINVAL.
> > 
> > The value 4 is valid as it encodes an existing mode, it's just that this
> > code path handles hardware that does not support that mode.  Why should
> > the code return EINVAL?
> > 
> val is invalid for this hardware.

Ok, I consider that a valid argument :)

> Also it returned -EINVAL before you
> made your changes.

That one less so, since before, the value 4 was never valid for any
hardware, but it is now for the F75387.

But I'm okay making it return EINVAL.

Thanks for your review,
Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
