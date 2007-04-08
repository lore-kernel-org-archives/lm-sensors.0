From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Sun, 08 Apr 2007 18:31:31 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <200704082031.31895.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am Sonntag 08 April 2007 19:36 schrieb Hans de Goede:
> Hans-J=FCrgen Koch wrote:
> > Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:
> >> The abituguru3 has a register which contains a motherboard ID. The
> >> current driver uses this ID, to look up info about the motherboard in a
> >> somewhat lenght table in the driver.
> >
> > Can you elaborate your design decision a bit? My first idea would be to
> > have a sysfs file that delivers that motherboard ID and then do the
> > lookup in user space.
>
> As I don't want the abituguru3 driver to create entries in sysfs for
> sensors which aren't there, and as without the table in the driver I cann=
ot
> be sure wether to create an in / temp / fan device for a given sensor
> address.=20

Good point. Anyway, most sensor drivers have no way of knowing which of the=
ir
inputs are actually used. The LM93 driver I'm currently working on is a=20
monster that creates about 160 (!) sysfs files. I don't find it easy to
judge what's worse, having a few unused sysfs files or a large table in
kernel space.

> Last but not least doing things this way allows me to always give=20
> a proper reading without userspace needing to "guess" any further
> nescesarry calculations to get from the reading to an actual measurement.

I agree that this is convenient, especially when reading sysfs values e.g.
from a script (without a library that could do table lookups). This is
probably a strong argument in favor of your table solution.

Thanks,
Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
