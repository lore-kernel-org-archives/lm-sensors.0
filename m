From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040811200301.GB12506@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Jean Delvare <khali@linux-fr.org> [2004-07-05 16:49:45 +0200]:

<snip>

> It looks like the possibility to select more than one temp channel for a
> given fan controler is needed (Philip Pokorny), so we wouldn't simplify
> this. As in the first proposal, the values would be bitfields, 1<<N =
> temp channel N matters to compute the considered fan's speed.
> 
> Files :
> 
> fan1_auto_channels
> fan2_auto_channels

<snip>

I think these should be named e.g. pwm1_auto_channels to make clear
the distinction between a tacho input (fanX) and a pwm output (pwmX).

(/me goes off to look at 2.6 sysfs_interface doc again)

Oh dear.  I'm sorry I wasn't paying attention to this sooner, but I
think our interface needs revision again.  All of the fan[nr]_pwm*
files should really just be pwm[nr]*.

The association between tacho input and pwm output is arbitrary and
depends on mainboard maker.  E.g. our script prog/pwm/pwmconfig is
made to discover the relationships.

Would anyone object to such a patch for 2.6 kernel drivers?

* * * * *

This also seems like a good time to introduce an idea that Khali
and I discussed on IRC some days ago, actually, a rule-of-thumb:

Any patch to the 2.6 kernel which changes/breaks some part of the
documented sysfs interface must be accompanied by a patch to
libsensors.  The libsensors patch must preserve backwards compat.
to the sysfs interface as it existed in every kernel.org kernel
from 2.6.5-rc1 to present.

I'm not suggesting we support forward-compat... nobody should
complain if, after upgrading to a newer kernel, they are asked
to upgrade to a newer libsensors. 

We've had sort of a honeymoon period where we could change the 2.6
kernel interface at will, and not support older ones with our current
libsensors.  That pissed some people off, and now that distros are
releasing not-quite-current 2.6 kernels, it's a real PIA all around.
So, let's declare the honeymoon over.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
