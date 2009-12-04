From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Dec 2009 08:44:05 +0000
Subject: Re: [lm-sensors] [PATCH] therm_adt746x: Record pwm invert bit at
Message-Id: <20091204094405.4bad9d69@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091130234727.GA10295@tux1.beaverton.ibm.com>
	<1259893211.2076.1243.camel@pasglop>
In-Reply-To: <1259893211.2076.1243.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: djwong@us.ibm.com, Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Fri, 04 Dec 2009 13:20:11 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 15:47 -0800, Darrick J. Wong wrote:
> > In commit 0512a9a8e277a9de2820211eef964473b714ae65, we unilaterally zero the
> > "pwm invert" bit in the fan behavior configuration register.  On my PowerBook
> > G4, this results in the fans going to full speed at low temperature and
> > shutting off at high temperature because the pwm invert bit is supposed to be
> > set.
> > 
> > Therefore, record the pwm invert bit at driver load time, and write the bit
> > into the fan behavior control register.  This restores correct behavior on my
> > PBG4 and should work around the bit being set to the wrong value after
> > suspend/resume (which is what the original patch was trying to fix).  It also
> > fixes a minor omission where the pwm invert bit correction is NOT performed
> > when switching into automatic mode.
> 
> Thanks, I'll apply.

This is a pretty serious bug, please make sure to send the fix to the
stable team for kernels 2.6.31 and 2.6.32.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
