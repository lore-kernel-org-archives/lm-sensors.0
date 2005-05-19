From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <20030830041659.GA1298@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-08-29 19:23:53 +0200]:
> > In the new-drivers document, under the heading "Write the new driver",
> > it says:
> > 
> >   "Remember that you want to output the direct measurements done by
> >   the chip. If these sensor values need scaling, this should be done
> >   through the configuration file."
> > 
> > However, many of the existing drivers don't do this. For example,
> > lm85.c has this macro:
> > 
> > #define FAN_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:5400000/(val))
> > 
> > which the driver uses to convert from register values to rps. There
> > are lots of similar constructs in other drivers.
> > 
> > Which is the right way for new drivers - the code or the
> > documentation?
> 
> The documentation sure would need some clarifications. Yes, most drivers
> convert values to output useful information. Chips behave too
> differently and it would be a complete mess if we were really outputing
> raw values (what would the drivers be worth to then?). I think that what
> the documentation tries to prevent there is hardcoding resistor values
> for +5V, +12V, -12V and -5V. These values are likely to change from
> motherboard to motherboard, and that's why they are set in
> /etc/sensors.conf. For the rest, drivers tend to convert from registers
> to "real" values (that is, values that make direct sense for a human
> being).

There is a method to the madness:  those conversions which are specified
in the sensor chip datasheet and which *cannot* vary from one board to
the next are performed by the driver.  If other conversions are necessary,
they are performed in user-space.

For example: consider a +12V sensor via w83781d.  This is usually found
on in4.  According to the datasheet, in4 has a range of 0 to 4.08 volts.
The reading is stored in 8 bits fixed point, 16mV per bit.  So if the
hardware register reads 0xc5, the driver converts that to 3.152 volts.
Therefore, 3.152V is the "direct measurement done by the chip".  This
is what you read in /proc/.../in4 and /sysfs/.../in4 (1) 

From there, realize that the mainboard OEM puts some resistor between
+12V and the sensor chip (directly applying +12V would peg the sensor &
probably ruin it.)  The datasheet even *suggests* what resistor to use.
But not everyone does, <sigh>.  Back to the example, the suggested
resistor value implies a conversion f(x) = x * 3.8 to read +12V.  So,
we describe f(x) in /etc/sensors.conf so that users can modify it if
necessary for their board.  In my experience, Asus comes to mind...
Finally, `sensors` chews all that up and spits out (3.125 * 3.8) => 11.88.

(1) Actually that would be re-scaled to 1mV/bit in sysfs (kernel 2.6)
Read .../Documentation/i2c/sysfs-interface for more details.

> And don't hesitate to ask other questions that may come to your mind :)

Seems all of the regulars on this list are pretty busy just now, but
be patient and you'll get some answers.  ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
