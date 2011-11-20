From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Nov 2011 09:17:40 +0000
Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <20111120101740.014f0bcd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
In-Reply-To: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Sat, 19 Nov 2011 13:21:06 -0800, Paul Norman wrote:
> I tried adding/removing a load from the 12V line composed of a cold cathode
> tube and all the fans I could control in the case, totaling about 10-15W of
> draw on the +12V line and none on the +5V. Removing everything brought up
> the in0 value to 2.964V. Attempts to change the BIOS value were unsuccessful
> as I have no control over the CPU power draw while in BIOS. I hooked up a
> multimeter and I was unable to get voltage changes that caused the needle to
> move.

I recommend using digital voltmeters for this work. It doesn't matter
too much how accurate they are. What matters is that it is easier to
distinguish between two close values.

> Because adjusting the load on the 12V line changed in0 but not in1 I think
> in0 is 12V and in1 is 5V.

Yes, this makes sense. Given the values you gave previously, this would
lead to a scaling factor of about 4.1666 for +12V (25/6) and 1.7397 for
+5V (I couldn't find a rational number for it.)

> I think the reason I can't influence the voltages much is that the power
> supply is rather excessive for what it powers. It draws ~125W at the wall
> and it's a 600W power supply. It's +12V rail is speced to power multiple
> graphics cards, not a low power Athlon II CPU and some fans.

FWIW, I wouldn't recommend this. PSU are typically most efficient
around 50% of their rated load, so using a big PSU on a small system
increases power losses.

> When I get my SATA card back from RMA I can try adding drives - right now
> I'm maxed out.
> 
> > I am a little surprised by the raw values BTW... 2.952 V is really close
> > to the ADC max of 3.060 V.
> 
> This surprises me too. Based on the values and an ADC max of 3.060 the
> sensors would max out at a voltage of 5.8-6.1% over the nominal voltage.
> Iirc, the power supply spec allows +/- 5%, so that seems to be cutting it a
> bit fine. I suppose it works if your power supply is within spec, but I bet
> there's lots out there more than 5% off.

Correct. Maybe they consider that anything beyond +5% is bad enough
anyway and can be reported as a single "too much". At least, aiming at
the end of the ADC range gives good measurement resolution, so it makes
some sense. Still, I prefer the traditional "nominal value is 3/4 of
ADC scale" rule.

When you have come up with a final configuration file for your board,
please send it and I'll add it to the wiki.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
