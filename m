From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Nov 2009 08:51:34 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <20091122095134.33d98192@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Allen,

Please do not top-post.

On Sat, 21 Nov 2009 20:34:35 -0800, Allen Edwards wrote:
> On Sat, Nov 21, 2009 at 7:49 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sat, 21 Nov 2009 07:19:01 -0800, Allen Edwards wrote:
> > > I searched back several months of your archives and can't find anything
> > > relevant to my problem.  When I run pwmconfig it finds my fans and
> > > controls the speeds. I can run a characterization of fan speeds vs
> > > settings and find that 180 is a good speed noise wise.  It is definitely
> > > controlling the fan speed.  But when it gets to the part about finding
> > > the min and max stall speeds, it will not control the fan speed, the fan
> > > just stays at full speed.
> > >  And, of course, fancontrol will not work.  This seems very strange to
> > > me. The fan is 3 wire and I have tried it in both a 3 and 4 wire
> > > controllable header.
> >
> > And you are using lm-sensors version...? Kernel version...? Hwmon
> > drivers...?

> lm-sensors 3.0.0, kernel 2.6.24.23-generic  Pardon my stupidity but I do not
> know hot to find a version of hwmon.

I never asked for a version of hwmon; I asked which hwmon drivers you
were using on your system.

It probably doesn't matter anyway. Looking at lm-sensors' changelog
[1], I see the following:

3.0.3 (2008-09-28)
  (...)
  pwmconfig: (...)
             Fix MINSTOP and MINSTART test functions (#2340)
             Test MINSTOP before MINSTART
             Use better step values for MINSTOP test
             (...)
             Determine MINSTOP automatically
             Skip MINSTOP and MINSTART tests if fan can't stop

This makes it clear to me that the problem you reported is known and
already fixed in lm-sensors 3.0.3 and later. So all you have to do is
upgrade to lm-sensors 3.0.3 or later. If you don't want to for any
reason, note that pwmconfig is a standalone script, so you can just
copy the one from lm-sensors 3.0.3 [2] and run it from wherever you
like.

[1] http://www.lm-sensors.org/browser/lm-sensors/tags/V3-1-1/CHANGES
[2] http://www.lm-sensors.org/export/5798/lm-sensors/tags/V3-0-3/prog/pwm/pwmconfig

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
