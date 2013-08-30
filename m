From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Aug 2013 06:50:14 +0000
Subject: Re: [lm-sensors] Configuration file for ASUS P8H77-I motherboard
Message-Id: <20130830085014.164a8b61@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
In-Reply-To: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Victor,

On Thu, 29 Aug 2013 20:02:34 +0300, Victor Severov wrote:
> Hi Jean
> 
> > I have added it to the wiki:
> > http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I
> 
> Thank you!
> 
> >> ignore in7
> > in7 is always VSB (+3.3V Stand-By) for this chip according to the
> > driver's source code, so it should be labelled as such, not ignored.
> > There's probably a note about this in the kernel logs when you load the
> > it87 driver.
> Unfortunately I can't find any scaling factor for VSB3 voltage. Sometimes
> in7 = 5.98, sometimes in7 = 4.44 or even 3.91, and I can't see any
> regularity for this values.
> Still no ideas about this in7 parameter. :(

OK. Well again we don't have a datasheet for the chip so it could be
that in7 behaves differently than we guessed. If the value changes all
the time then it suggests that the input is not connected (or the
signal is not routed properly due to wrong configuration.)
Unfortunately there's nothing we can do about it until we can get a
datasheet.

> >> compute in0 @+0.06, @-0.06
> > I've seen this a few times in the past but electrically it makes no
> > sense.
> 
> My motherboard uses intel g2020 processor with nominal core voltage 0.92V.
> Core voltage displays as 0,86V in lm-sensors by default.
> In BIOS power management menu core voltage displays as 0.92V, In my guess
> we needs a "+0.06" correction for this.
> Maybe I'm wrong.

I think you are wrong, yes ;-) The G2020 supports Intel SpeedStep,
which means it operates at different frequency and voltage when idle
and when busy. In the BIOS, the CPU is always busy, so running at the
maximum voltage. In Linux it will be idle by default, this running at a
the minimum voltage. This explains your observation.

If you put some load on the CPU (or switch to the "performance" CPUFreq
governor) and run "sensors" again, it should report the same Vcore as
the BIOS was (without the compute line you added.) With your compute
line, it will (wrongly) indicate a higher voltage value.

So you want to drop the compute line for in0, and instead adjust the
min and max limits to take this voltage change into account:

   set in0_min 0.86 * 0.95
   set in0_max 0.92 * 1.05

> >> compute in2 @*(72/12), @/(72/12)
> >> compute in3 @*(30/12), @/(30/12)
> >> compute in4 @*(1978/1200), @/(1978/1200)
> > I'm curious how you came up with this unusual scaling factor?
> 
> I used several reverse engineering tricks from this wonderful article:
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling

Glad you liked it :)

> >> set in4_min 3.3 * 0.90
> >> set in4_max 3.3 * 1.05
> 
> > The ATX specifications sets the limit to +/-5 % so all these * 0.90
> > should really be * 0.95 (or 0.94 if you want to take the resistor's
> > imperfection into account.)
> Yes, this is my mistake.
> 
> Thank you for your comments and recommendations.

You're welcome. I have updated the wiki page accordingly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
