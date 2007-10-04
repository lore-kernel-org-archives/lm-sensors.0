From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 16:52:04 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
Message-Id: <20071004185204.2f1d8245@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925052306.24D6023942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 03 Oct 2007 20:34:42 -0700, David Brownell wrote:
> > > (...)
> > > But I updated it to just say that it's "round away from zero",
> > > which is "unusual".  The squirrely bit is that rounding should
> > > be done on the fixed point binary value, although I don't see
> > > any motivation for using "round away from zero" here.
> >
> > It's not rounding "away from zero" (whatever you mean with that
> > expression).
> 
> It is; see http://www.diycalculator.com/popup-m-round.shtml for
> a decent survey of rounding schemes.

Excellent article, thank you. Still, LM75_TEMP_TO_REG is not
implementing Round-Away-From-Zero. It is implementing Round-Half-Up
(symmetric).

Just try it. Feed the old lm75 driver (9-bit resolution) with a limit
value of 70100. Round-Away-From-Zero would round to 70.5 degrees C,
while the driver actually rounds to 70.0 degrees C, as expected.

> >	It's just rounding to the nearest representable value, I
> > see nothing unusual there. If you see anything else than regular
> > rounding, that would be a bug, please explain and we'll fix it.
> 
> No, it's not "Round-Toward-Nearest" since it considers the sign of
> the orignal value, and changes the rounding direction accordingly.
> That's what makes it "Round-Away-From-Zero" rather than one of the
> more typical rounding schemes.

Checking the sign or not doesn't have much to do with
Round-Away-From-Zero: Round-Away-From-Zero is different from
Round-Half-Up even for positive values.

And we're not really "changing the rounding direction". The (positive or
negative) offset we add is to compensate for the truncation effect of
the following division. The offset is negative for negative values
because the truncation is effectively a "round up" for negative values
while it is a "round down" for positive values. This is where the real
"direction change" is.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
