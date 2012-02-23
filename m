From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 20:00:52 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
Message-Id: <1330027252.23014.113.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329949129-4265-6-git-send-email-mail@microschulz.de>
In-Reply-To: <1329949129-4265-6-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-02-23 at 14:50 -0500, Nikolaus Schulz wrote:
> On Wed, Feb 22, 2012 at 06:26:00PM -0800, Guenter Roeck wrote:
> > On Wed, Feb 22, 2012 at 05:18:48PM -0500, Nikolaus Schulz wrote:
> > > +static bool duty_mode_enabled(u8 pwm_enable)
> > > +{
> > > +	switch (pwm_enable) {
> > > +	case 0: /* Manual, duty mode (full speed) */
> > > +	case 1: /* Manual, duty mode */
> > > +	case 4: /* Auto, duty mode */
> > > +		return true;
> > > +	case 2: /* Auto, speed mode */
> > > +	case 3: /* Manual, speed mode */
> > > +		return false;
> > > +	default:
> > > +		BUG();
> > > +	}
> > > +}
> > 
> > This keeps bugging me ... I think it would make sense to simplify it to
> > 
> > 	return pwm_enable != 2 && pwm_enable != 3;
> 
> Well, I used that verbose switch statement because
> 
> a) I feel uncomfortable using these magic numbers instead of a
>    well-defined enum - by the way, is there a reason for not using an enum for
>    that? - and
> 
I don't think there is a reason other than being lazy.

> b) a simple logical expression like you suggested may lead to hidden
>    bugs once the range of valid values changes.
> 
Good point. Maybe start using an enum ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
