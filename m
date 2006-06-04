From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sun, 04 Jun 2006 18:52:50 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604185250.GB3682@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 04 Jun 2006, Jean Delvare wrote:
> > As soon as you drive fans using PWM you screw up any sort of simple tick
> > counters completely, as you have a spike on every PWM cycle start, plus no
> > spikes generated during the second phase of the PWM cycle.
> 
> Some chips try to compensate with additional circuitery. This requires
> that you know which fan input is connected to which PWM output though,
> and that the motherboard manufacturer did take care of wiring things
> properly. And even then I guess you lose most of the accuracy when PWM
> gets too low.

Yes. In fact, the LM85 chips are one of those and one of the current bugs in
the driver is that it is not directing the chips to do so properly.  Well,
when I get my butt off other Debian work, I will submit the patches I've been
using to fix that.

The PWM-compensation algo and circuits impose limits on the speeds one can
measure under PWM, and these limits are variable with the PWM duty cycle.
Slow speeds can never be measured well enough.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

