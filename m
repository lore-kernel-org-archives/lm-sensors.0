From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 10 Nov 2005 16:03:09 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <lZFjH3NK.1131634172.3798950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stephen, Eric,

> > I have been submitting a patch to enable Fan speed control on my
> > P4P800, and if you disable Q-Fan in the BIOS it work perfectly, you
> > just set the temperature you want, the tolerance and the step and it
> > works perfectly, don't need to rely on any tool like Speedfan on
> > Windows to set the speed of my fan. The patch is being tested and
> > modified to comply with lm-sensors standard. But if you are
> > interested I can send you the patch that works great.

I'm a bit worried by the "if you disable Q-Fan in the BIOS" condition.
It should work even with it enabled.

Anyway, Eric, I am still waiting for you to post the latest version of
your patch so that we can improve it.

> I realise now that my first mail was somewhat hasty, and in fact my setup
> is (was) so unusual that it probably doesn't justify keeping reset=1. I
> imagine most people who set Q-Fan up in their BIOS would want its fan
> control to remain after booting, and those people who want to use
> software-based fan control would simply disable Q-Fan altogether!

Except that some boards do not let you disable the automatic fan speed
control.

> Furthermore if the controller can be switched from one mode to another
> at run-time, resetting it would become unnecessary (or rather, subsumed
> by the mode switching), wouldn't it?

My point exactly. I still want to remove the reset parameter in the long
run, but I think we need to merge Eric's patch (after rework) before we
do.

Thanks,
--
Jean Delvare
