From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Sep 2008 15:30:52 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Add script for manual control
Message-Id: <20080921173052.17335d47@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0807231020pe333553t4e94e4c77530b10d@mail.gmail.com>
In-Reply-To: <191fb4ca0807231020pe333553t4e94e4c77530b10d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

That was posted while I was on vacation and I overlooked it, sorry.
This is checked in now, with a small change: vt1211_pwm will not be
installed by default, on the assumption that this chip isn't very
popular, and most users will either not try to control their fans, or
will be happy with the automatic mode. So you have to use "make install
VT1211_PWM=1" to get the script installed. I hope that's OK with you.

BTW, are you certain you don't want write access to the SVN repository?
This would avoid such delays. I will not always be available to commit
other people's patches...

On Tue, 16 Sep 2008 15:30:15 -0700, Juerg Haefliger wrote:
> I was wondering what happened to this patch? I don't think it made it
> in. Is there a problem with it?
> 
> Thanks
> ...juerg
> 
> 
> On Wed, Jul 23, 2008 at 10:20 AM, Juerg Haefliger <juergh@gmail.com> wrote:
> > Add a script that provides manual control of the vt1211 PWM outputs.
> > This script puts the vt1211 in automatic PWM mode and fools the chip
> > into believing that there is a temp change to force the PWM outputs to
> > specified values. This is necessary since the standard manual mode of
> > the vt1211 doesn't seem to work.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
