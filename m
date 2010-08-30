From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Aug 2010 08:23:54 +0000
Subject: Re: [lm-sensors] small changes in configuration file for MSI
Message-Id: <20100830102354.5895f9ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <37bbc84b5fac675db98cc0276a74e55e@mail.gmail.com>
In-Reply-To: <37bbc84b5fac675db98cc0276a74e55e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Leo,

On Sun, 29 Aug 2010 01:16:17 +0200, Leo Kr=C3=BCger wrote:
> I own a MSI IM-945GSE-A motherboard and used the sample configuration file
> from http://lm-sensors.org/wiki/Configurations/MSI/IM-945GSE-A,
> which showed me around 14V for the 12V output.

I'm adding the original author of the configuration file to Cc.

> Since this would be far above specification limits, I measured the actual
> values at the ATX power connector. In addition to the 12V output, the 5V
> and the 5Vsb line differed a little.

I am a little curious about your experimental setup. How do you get
access to the ATX power connector while the system is running?

I usually measure +5V and +12V from molex connectors, it's easy. But
5VSB, I wouldn't know how to measure it.

> Below is my updated configuration file. Note that I just changed 3 lines,
> the compute lines for in4, in5 and in6.
> It would be nice if you could update the sample file in your wiki.
> Let me know if any additional steps are necessary.

It is expected that measuring the values with a multimeter will lead to
slightly different results for voltages which need scaling. Scaling is
achieved using two resistors, the value of which is typically
guaranteed to 1%. Therefore, there can be up to 2% of error introduced
by the resistors themselves. By calibrating your configuration file
based on actual measurement, you correct this error for your specific
motherboard, but the same correction doesn't apply to other instances
of this motherboard model.

So your proposed changes may be perfect for your board, but aren't
suitable for the default configuration file for this board.

A better way to figure out which scaling factors are intended by the
board manufacturer, is to compare with what the BIOS is printing. First
write down all values reported by the BIOS, and also note your
voltmeter measurement. Then do the same again with lm-sensors's
unscaled voltage values. If the voltmeter values didn't change, then
lm-sensors should report the same as the BIOS after scaling. If the
voltmeter values changed (which can happen as the system load is
slightly different) then you have to take it into account in your
computations.

The 5.25 scaling factor comes straight from the datasheet (suggested
resistors of 200k and 47k), and your own measurement for +5V leads to
almost exactly this, so I wouldn't change it. It is also quite unlikely
that the vendor would use different resistor values for +5V and 5VSB,
which makes me reluctant to change 5VSB either, although your proposal
is quite different there.

For +12V, the 12.83 scaling factor was apparently copied from our old
default configuration file, which for this chip was written for an
Epox board. The datasheet instead suggests to use resistors of 200k and
20k, leading to a scaling factor of 11. Note that the difference
between this 11 and your 10.86 is less than 2%, so it is likely that
MSI followed to the datasheet. So I would go with 11.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
