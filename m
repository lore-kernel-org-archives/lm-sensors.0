From: Paul Norman <penorman@mac.com>
Date: Sat, 19 Nov 2011 21:21:06 +0000
Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <001101cca701$273df700$75b9e500$@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
In-Reply-To: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Jean Delvare [mailto:khali@linux-fr.org]
> Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
> 
> > Both in0_input and in1_input vary between 2.940 and 2.952. They vary
> > independently, and I only observed in0_input=2.940 under heavy CPU
> load.
> >
> > I only observed in1_input=2.940 under heavy IO load.
> 
> Hu. If both have exactly the same raw value, it's obviously difficult to
> distinguish between them. And the only other Biostar configuration file
> we have has a completely different mapping, so it won't help.
> 
> Your only chance would be to temporarily change your hardware setup to
> slightly alter the load. For example adding or removing a hard disk
> drive, or using a different PSU.

I tried adding/removing a load from the 12V line composed of a cold cathode
tube and all the fans I could control in the case, totaling about 10-15W of
draw on the +12V line and none on the +5V. Removing everything brought up
the in0 value to 2.964V. Attempts to change the BIOS value were unsuccessful
as I have no control over the CPU power draw while in BIOS. I hooked up a
multimeter and I was unable to get voltage changes that caused the needle to
move.

Because adjusting the load on the 12V line changed in0 but not in1 I think
in0 is 12V and in1 is 5V.

I think the reason I can't influence the voltages much is that the power
supply is rather excessive for what it powers. It draws ~125W at the wall
and it's a 600W power supply. It's +12V rail is speced to power multiple
graphics cards, not a low power Athlon II CPU and some fans.

When I get my SATA card back from RMA I can try adding drives - right now
I'm maxed out.

> I am a little surprised by the raw values BTW... 2.952 V is really close
> to the ADC max of 3.060 V.

This surprises me too. Based on the values and an ADC max of 3.060 the
sensors would max out at a voltage of 5.8-6.1% over the nominal voltage.
Iirc, the power supply spec allows +/- 5%, so that seems to be cutting it a
bit fine. I suppose it works if your power supply is within spec, but I bet
there's lots out there more than 5% off.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
