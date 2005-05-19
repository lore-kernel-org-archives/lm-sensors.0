From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fscpos driver
Message-Id: <tn5FkB8Q.1104942343.6506780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > It allows you to clear the alert state. I noticed this doesn't
> > > comply with the sysfs guidelines which say alarms are read-only but
> > > it's quite handy after doing stupid things such as stopping a fan
> > > altogether (which causes an alert state for said fan and "sensors"
> > > won't show any more fan data until the state has been cleared).
> >
> > The driver, not the user, should take care of this. When one is
> > reading from the status file, the driver should automatically rearm
> > any flag that needs be. Don't the 2.4 fscpos and the 2.6 fscher
> > drivers do it that way?
>
> No, they don't. So what you're saying is that once an alarm has been
> read it should disappear if the problem is no longer there?

That's it. The policy is that alarm conditions should show at least
once, and be cleared when the condition is gone. This is what most chips
implement in hardware. For the chips which do not automatically clear
the alarms bits when the condition is gone, the driver has to do it. See
for example:
http://sosdg.org/~coywolf/lxr/source/drivers/i2c/chips/smsc47m1.c#L554

> > It's odd that the min value would affect the speed, since it
> > supposedly is only a limit to the alarm condition, not a speed target.
>
> According to the PDF you sent me, this really is meant to actually control
> the fan speed.

Wow. I'll take a look at it this evening. If this is true, then this
would correspond to either an analog output or PWM output, and
correspond to a file names pwm1, not fan1_min.

> > Does "sensors" complain as well? Does "sensors" display anything for
> > these two files? If it doesn't, I guess it shows that these files are
> > not really important and could possibly be removed.
>
> No, sensors doesn't show anything, so should I just remove them?

I would - but you are porting the driver and will be one of the few users
in the end (I don't think that the Poseidon is widely used) so you
decide. Know that I will update libsensors depending on your decision so
that "sensors -u" doesn't cause any error.

> Yes, it appears so. I guess the only changes required will be to remove
> references to the features i removed (like rev and control).

Fine with me.
--
Jean Delvare
