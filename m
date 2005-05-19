From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040921005021.GD758@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

(liberal snips)

* Jean Delvare <khali@linux-fr.org> [2004-09-20 11:10:56 +0100]:
> On Mon, 20 Sep 2004 01:00:22 -0400, Mark M. Hoffman wrote
> > Well, here are a couple more, from adm1031.c:
> > 
> > 	auto_fan?_min_pwm => pwm?_auto_min
> > 
> > 	auto_fan?_channel => pwm?_auto_channels
> > 
> > The new names come from your most recent proposal [1], s/fan/pwm/ where
> > necessary.
> > 
> > 	[1] http://archives.andrew.net.au/lm-sensors/msg08477.html
> 
> I don't think this belong to the same changeset. The pwm and vid changes are
> reverts from my own changes back in the early 2.6 times. They are documented
> and were considered stable, and part of libsensors already, which is why we
> have to provide compatibility.
> 
> (...)
> 
> So to me there are only the two changes you mentioned first, which should be
> quite simple from libsensors' point of view.

Fair enough.

> > (One) In adm1031.c lines 594-595:
> > 
> > (...)
> > 
> > That's a bug, right?
> 
> I don't think so. As Alexandre suggests in its reply, the ADM1030 and ADM1031
> have registers those meaning change depending of a selected mode. We could not
> think of a better way than this implementation, which may look a bit confusing
> first (changing one value will of course change the other as well from the
> (...)

Right, no problem.

> > (Two) As for fscher.c, I can't honestly tell whether or not it actually
> > supports PWM control.  If it does, then the choice of variable and
> > structure names was very poor.
> 
> The FSC Hermes doesn't have PWM capabilities as far as I know. I wonder what
> made you think it could have.

Are you sure?  Try 'grep pwm kernel/chips/fscher.c' in 2.4/CVS and same
in 2.6.9.  Actually, the 2.4/CVS and 2.6.9 drivers don't look similar
at all.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
