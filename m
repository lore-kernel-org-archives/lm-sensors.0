From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fscpos driver
Message-Id: <20050105203117.265d4139.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > It's odd that the min value would affect the speed, since it
> > > supposedly is only a limit to the alarm condition, not a speed
> > > target.
> >
> > According to the PDF you sent me, this really is meant to actually
> > control the fan speed.
> 
> Wow. I'll take a look at it this evening. If this is true, then this
> would correspond to either an analog output or PWM output, and
> correspond to a file names pwm1, not fan1_min.

I confirm this. The datasheet is rather clear about this, as you said -
although it doesn't mention whether analog output amplitude modulation
or PWM is used, nor does it states how temperature interacts with the
final speed. The fact that temperature somehow matters may explain the
strange behavior you noticed.

Note that I suspect that fscher isn't correct on some points. It seems
to create files named fanN_pwm (old standard) instead of pwmN (new
standard), and also maps fanN_div to fan ripple registers, while these
are two different things. I won't blame Reinhard Nissl too hard since I
might be responsible for some of the errors, as I gave him possibly
unenlightened advice while he did the work.

-- 
Jean Delvare
http://khali.linux-fr.org/
