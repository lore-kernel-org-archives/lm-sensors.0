From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040920050022.GD3652@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-09-19 20:12:58 -0400]:
> * Jean Delvare <khali@linux-fr.org> [2004-09-16 14:48:44 +0100]:
> > I think you have a plan to revert my bogus pwmN -> fanN_pwm interface change.
> > I believe that it would be great if you could add support for this in
> > libsensors before 2.8.8 is released. That way, people will need to upgrade
> > only once for both changes. Since libsensors now has room for one alternative
> > name for each feature, you don't need to update the drivers themselves now,
> > only the library.
> 
> Agreed, I would like to get the library changes in to 2.8.8.  However, I'm not
> sure yet what is the scope of the changes.  Right now, I see these:
> 
> fan?_pwm	=> pwm?
> fan?_pwm_enable	=> pwm?_enable
> 
> Are there more?  I think there could be.  So, that forces me to do the driver
> work up front anyway.

(all comments here are w.r.t. 2.6.9-rc2)

Well, here are a couple more, from adm1031.c:

	auto_fan?_min_pwm => pwm?_auto_min

	auto_fan?_channel => pwm?_auto_channels

The new names come from your most recent proposal [1], s/fan/pwm/ where
necessary.

	[1] http://archives.andrew.net.au/lm-sensors/msg08477.html

Two other things...

(One) In adm1031.c lines 594-595:

> static DEVICE_ATTR(auto_fan##offset##_min_pwm, S_IRUGO | S_IWUSR,       \
>                    show_pwm_##offset, set_pwm_##offset)

But those are also used for the sysfs files fan?_pwm in lines 439-440:

> static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,                \
>                    show_pwm_##offset, set_pwm_##offset)

That's a bug, right?

(Two) As for fscher.c, I can't honestly tell whether or not it actually
supports PWM control.  If it does, then the choice of variable and
structure names was very poor.

Anyway, the driver patch is almost done.  As soon as I understand these
last couple things I'll finish it off.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
