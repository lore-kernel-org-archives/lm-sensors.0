From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 03 Dec 2010 23:27:26 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101204002726.7af809e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Fri, 3 Dec 2010 15:16:26 -0600 (CST), Jeff Rickman wrote:
> > Which I admit isn't very appealing. Make me wonder if the internal
> > scaling factors in the driver are correct. Again, Juerg, I have to
> > defer to you.
> 
> I looked at the BIOS report for a sensor it calls "V+1.5". It is the very
> first value reported (Top of the list) in the Hardware Monitoring BIOS
> screen. The value shown is right on "1.5 volts" at system startup.

Strange. This suggests that in0's nominal value is +2.0V and not +2.5V
as the driver assumes. But without the datasheet I can't confirm this. I
don't even remember if we ever had a successful report for SCH5127
support in general and voltages in particular. Juerg?

Note that I wouldn't necessarily trust the order of the voltage labels
in your BIOS to match the DME1737 inputs. There are so many strange
things about your voltages...

> > (...)
> > I use "md5sum /dev/zero" for this.
> 
> Thank you for the info. I ran this test for about 15 minutes. The system
> voltages changed slightly...no more than 5 hundredths up or down: that
> looks like a very stable power supply.

I didn't expect all voltages to change more than this, but I would have
expected one to do and that would have been Vcore. I thought that all
recent CPUs doing frequency scaling were also doing voltage scaling,
but maybe I was wrong on this. But maybe the Intel Atom are different
in this respect, I don't know. Which Atom model is this exactly?

One thing I just noticed about the voltages is that in4 is almost
saturated. It reaches 1.48V while the max is 1.49V (as a matter of
fact, you tried to set the max limit to 1.65V in your configuration
file but it got clamped to 1.49V.) This could mean that you have
voltage seriously off... but assuming your system is running OK, it
doesn't make sense to wire a voltage sensor that way, unless you only
want to detect low voltage on that line, and not high voltage.

The only voltage input for which this makes sense IMHO is Vbat. But if
in4 is Vbat then what is in2? I always thought that it was a little
high for Vbat at +3.32V, but OTOH you already have 2 +3.3V lines as in5
and in6, and it doesn't really make sense to monitor +3.3V three times.
OTOH, one of them could be +5V with ad-hoc scaling, so in1 or in3 would
be Vcore. Which would make some sense as they have values around +1.1V
before scaling, which seems OK for an Atom CPU.

You may be able to find out which voltage is Vbat by booting the system
without a battery inserted - assuming the battery is removable AND this
particular system accepts booting without it.

If you want to sort things out, another option is to stay in the BIOS
setup screen for a longer time and write down _all_ values which are
displayed for _all_ voltages lines over time. The more different values
you collect, the better. It can only work if the BIOS displays 3
decimal places. By analyzing the difference between values, we can
deduce the candidate scaling factors and thus the candidate pin
mappings. This is a little more complex with this chip because of the
internal scaling factors, but this should still be doable. If you write
down all the values and post them on this list, I'll take a look.

Of course there is also still the possibility that Acer messed it all
up so some my assumption are wrong.

> System temperatures did go up: it
> pushed CPU temp up about 5 degrees Celsius, from ~42 to ~47, but never
> reached 50 degrees Celsius.

At least this confirms that you got the temp labels right.

> Systemgraph shows CPU MHz ramped up to full speed: this system can use the
> "userspace" governor with ~200 MHz steps starting at ~200 MHz and topping
> out at ~1600 MHz.

What drives the user-space governor on your system? And what is the
minimum value at which it sets the CPU frequency? Maybe you need to use
the lowest frequency to see a voltage drop. Finding which input is
Vcore would really help a lot.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
