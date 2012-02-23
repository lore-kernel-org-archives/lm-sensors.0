From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 19:59:08 +0000
Subject: Re: [lm-sensors] [PATCH 6/6] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <1330027148.23014.111.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-7-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-7-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-02-23 at 14:40 -0500, Nikolaus Schulz wrote:
> On Wed, Feb 22, 2012 at 05:35:12PM -0800, Guenter Roeck wrote:
> > On Wed, Feb 22, 2012 at 05:18:49PM -0500, Nikolaus Schulz wrote:
> > > It makes no sense to attempt to manually configure the fan in auto mode,
> > > or set the duty cycle directly in closed loop mode.  The corresponding
> > > registers are then read-only.  If the user tries it nonetheless, error out
> > > with EBUSY instead of silently doing nothing.
> > > 
> > > Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> > > ---
> > >  drivers/hwmon/f75375s.c |   32 ++++++++++++++++++++++++++++++++
> > >  1 files changed, 32 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> > > index 29b11c6..0e7fe3a 100644
> > > --- a/drivers/hwmon/f75375s.c
> > > +++ b/drivers/hwmon/f75375s.c
> > > @@ -281,6 +281,21 @@ static bool duty_mode_enabled(u8 pwm_enable)
> > >  	}
> > >  }
> > >  
> > > +static bool auto_mode_enabled(u8 pwm_enable)
> > > +{
> > > +	switch (pwm_enable) {
> > > +	case 0: /* Manual, duty mode (full speed) */
> > > +	case 1: /* Manual, duty mode */
> > > +	case 3: /* Manual, speed mode */
> > > +		return false;
> > > +	case 2: /* Auto, speed mode */
> > > +	case 4: /* Auto, duty mode */
> > > +		return true;
> > > +	default:
> > > +		BUG();
> > > +	}
> > > +}
> > > +
> > >  static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
> > >  		const char *buf, size_t count)
> > >  {
> > > @@ -314,6 +329,11 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > +	if (auto_mode_enabled(data->pwm_enable[nr]))
> > > +		return -EBUSY;
> > > +	if (data->kind = f75387 && duty_mode_enabled(data->pwm_enable[nr]))
> > > +		return -EBUSY;
> > > +
> > -EBUSY is really not appropriate here. -EINVAL would be better, though I am open to suggestions.
> 
> I am not very happy about using EINVAL here, but if EBUSY is
> inappropriate, I don't have a better idea.
> 
EBUSY - device or resource busy
EINVAL - Invalid argument

So EBUSY is definitely wrong, and EINVAL is a better match. It would be
nice if there was an "Invalid in this context", or "Invalid with the
current configuration", but I am not aware of such an error code. One
could think of EOPNOTSUPP, but that means "Operation not supported on
transport endpoint", which doesn't seem to be appropriate either.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
