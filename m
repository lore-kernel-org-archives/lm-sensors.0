From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 19:56:30 +0000
Subject: [lm-sensors] bogus data from W83627HF on an ASRock K7S41
Message-Id: <20050616195541.2ffca10a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Sorry for the delay.

> I've just started to play with lm-sensors, and have almost got it
> working... however, I'm getting some bogus values, and some others are
> missing:
> - -12V is bogus

FAQ 4.6.1

"-5V and -12V readings are way out of range!

It's very frequent that negative voltage lines are not wired because
motherboard manufacturers don't think they're worth monitoring (they are
mostly unused these days). You can just add ignore inN lines to
/etc/sensors.conf to hide them."

Another possibility is that these lines are used to monitor different
voltages. If this is the case, only the motherboard manufacturer can
tell, or maybe you can have a look at what voltage values your BIOS
displays, if any.

> - Vbat looks bogus

Maybe it's simply not wired. Same rules apply as for negative voltages.

> - fan1 and fan2 both zero (even though 1 fan is installed and turning)

FAQ 4.1.1

"Fans sometimes/always read 0!!

You may not have a three-wire fan, which is required.

You may need to increase the 'fan divisor'. See doc/fan-divisors in our
package for further information."

> My motherboard is an ASRock K7S41, and the sensor appears to be a
> S83627HF

In fact it appears to be a W83697HF. All these chips have very similar
names but slightly different feature sets, so you should be careful when
announcing the name of your chip.

> ????? Why is the algorithm unavailable

Because the Linux 2.6 i2c layer doesn't provide an access to it. I tend
to think we should stop displaying it, as more people are now using 2.6
kernels and it is confusing. Nobody really cares about the algorithm,
it's an internal implementation detail.

-- 
Jean Delvare
