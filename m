From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:38:48 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604203848.0f3a3350.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Sun, 04 Jun 2006, Jean Delvare wrote:
> > Definitely not the LM75, as it is a temperature-only sensor chip. But I
> 
> My bad, I should have typed lm85 (which would not be strictly correct,
> either: the ADM1027 does it.  It is a LM85 compatible chip, but I don't
> think the lm85b/c can do it).
> 
> > indeed. Strangely enough, some vendors are doing the opposite and
> > propose 4-wire fans, the idea being that tick counts tend to be lost
> > when fan speed control is in use on 3-wire fans.
> 
> As soon as you drive fans using PWM you screw up any sort of simple tick
> counters completely, as you have a spike on every PWM cycle start, plus no
> spikes generated during the second phase of the PWM cycle.

Some chips try to compensate with additional circuitery. This requires
that you know which fan input is connected to which PWM output though,
and that the motherboard manufacturer did take care of wiring things
properly. And even then I guess you lose most of the accuracy when PWM
gets too low.

-- 
Jean Delvare

