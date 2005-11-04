From: nowozin@gmail.com (Sebastian Nowozin)
Date: Fri, 04 Nov 2005 21:10:15 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <b12ed2970511041208k42d3804bm2624be28bee4aa7f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean and the others who have helped me,


On 11/3/05, Jean Delvare <khali@linux-fr.org> wrote:

> >   1. The w83627hf chip on the board can only provide readings but no
> > control of the fanspeed.

> Yes, this is the most probable. It is always a bit frustrating to know
> that the chip could do it, but the motherboard manufacturer did not wire
> it properly to do so. Unfortunately, this is a rather common situation.

> Note however that the run of pwmconfig above only shows that the speed of
> the case can cannot be controlled. When you get valid readings for your
> CPU fan, try again. It is possible, though unlikely, that the CPU fan
> can be controlled.

Today I opened the case and examined both the CPU and power supply
fan.  The power supply fan has a simple two-wire connection, without
any speed reading line physically present.  It must be a mistake the
BIOS displays a reading for it.

The loud fan was actually the CPU fan (I only discovered that _after_
I exchanged the power supply fan).  Luckily I could reuse the
potiometer for the power supply fan for the CPU fan then.  With the
potiometer on the lowest voltage setting it is much more quieter now
and testing with the "cpuburn" program for a long time still only had
a max peak temperature at 68? degrees.  So its sort of a workaround
solution now, but I'm closer to the original goal.


> Likewise, if your motherboard has a third fan header, you may try to use
> it for the case fan instead of fan1, and run pwmconfig again. Who knows?

It only has two fan connectors, for two CPU fans, both connected. 
(The EPOX board is a bit strange in that way, it has a combined
Northbridge and CPU cooler with two fans, one is loud and the other is
hidden inside).

I really don't know where from the BIOS could come up with a chassis
fan speed.  Maybe just a wrong text label.


> >   3. Something else is wrong, eg. /etc/sensors.conf (attached), ...

> Attaching a 70 kB file wasn't exactly wise ;) please only include the
> relevant part next time.

Ooops, next time I will remember :)


> You may try to load the w83627hf driver with reset=1. Please report if it
> helps. I don't expect it to actually help, but you may still want to
> try.

I tried it, no difference.  I tried with init=0, but for 2.6.14 it
should be reset=1, as reset=0/init=0 is the default behaviour, right?
:)


> Remember that there are always hardware solutions to reduce the fan
> noise. You can use a potentiometer. You can use a thermoregulated fan.
> Or you can simply use a fan with a lower nominal speed.

Yes, but its a more expensive solution.  In my case it turns out to be
the only solution, but if it would have been possible by changing a
configuration setting I would really dislike the thought of buying
extra hardware to fix it. :-)

Thanks for the great support you all are doing on lm-sensors, its a real help.

Regards,
Sebastian
