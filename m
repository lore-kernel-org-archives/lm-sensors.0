From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040920085154.M35137@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Sep 2004 01:00:22 -0400, Mark M. Hoffman wrote
> > Agreed, I would like to get the library changes in to 2.8.8.  However,
> > I'm not sure yet what is the scope of the changes.  Right now, I see
> > these:
> >
> > fan?_pwm	=> pwm?
> > fan?_pwm_enable	=> pwm?_enable
> >
> > Are there more?  I think there could be.  So, that forces me to do the
> > driver work up front anyway.
> 
> (all comments here are w.r.t. 2.6.9-rc2)
> 
> Well, here are a couple more, from adm1031.c:
> 
> 	auto_fan?_min_pwm => pwm?_auto_min
> 
> 	auto_fan?_channel => pwm?_auto_channels
> 
> The new names come from your most recent proposal [1], s/fan/pwm/ where
> necessary.
> 
> 	[1] http://archives.andrew.net.au/lm-sensors/msg08477.html

I don't think this belong to the same changeset. The pwm and vid changes are
reverts from my own changes back in the early 2.6 times. They are documented
and were considered stable, and part of libsensors already, which is why we
have to provide compatibility.

The auto-fan stuff is new, not official yet (I know it should have been done
months ago but I just don't have the time to work on that many things at once
- plus the fact that my previous interface proposals have been everything but
successfull, which makes me somewhat reluctant to endorsing this new one) and
not part of libsensors. So people using it are (or should be) aware that the
interface is subject to change without notice. Since the adm1031 may not
comply with the final interface, I don't think it makes sense to change the
auto_pwm entries now. Better finalize the interface proposal and publish it,
and only then fix all drivers which needs be.

So to me there are only the two changes you mentioned first, which should be
quite simple from libsensors' point of view.

> Two other things...
> 
> (One) In adm1031.c lines 594-595:
> 
> > static DEVICE_ATTR(auto_fan##offset##_min_pwm, S_IRUGO | S_IWUSR,       \
> >                    show_pwm_##offset, set_pwm_##offset)
> 
> But those are also used for the sysfs files fan?_pwm in lines 439-440:
> 
> > static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,                \
> >                    show_pwm_##offset, set_pwm_##offset)
> 
> That's a bug, right?

I don't think so. As Alexandre suggests in its reply, the ADM1030 and ADM1031
have registers those meaning change depending of a selected mode. We could not
think of a better way than this implementation, which may look a bit confusing
first (changing one value will of course change the other as well from the
user's point of view, although only one makes sense at any given time). The
other possibility would have been to hide the fact that both values were
stored in the same register by remembering values in the driver and writing
them to the register each time the mode changes. We didn't see any benefit in
doing this. I think it is admitted that users should never assume anything
about possible links between sysfs values. One example of this is the LM90 and
ADM1032 which have a single hysteresis register which applies to two
temperature channels, so the two sysfs files map to the same register. In this
particular case, I made one of them read-only so as to make it (hopefully)
clearer, but using such a trick isn't always possible. For example, it
wouldn't work for the ADM1030/ADM1031. And the point is the same, in that
writing to one file changes the value of another. Users and user-space
applications must expect this to happen depending on the various hardware
implementations.

An alternative approach would be to switch sysfs files read-only on mode
change, or even to create and destroy them on the fly. I don't know how well
it would fit in the current architecture though. And not sure it would look
less confusing either.

> (Two) As for fscher.c, I can't honestly tell whether or not it actually
> supports PWM control.  If it does, then the choice of variable and
> structure names was very poor.

The FSC Hermes doesn't have PWM capabilities as far as I know. I wonder what
made you think it could have.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
