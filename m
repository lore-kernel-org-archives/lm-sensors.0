From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Aug 2010 09:34:59 +0000
Subject: Re: [lm-sensors] small changes in configuration file for MSI
Message-Id: <20100830113459.6679b2ab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <37bbc84b5fac675db98cc0276a74e55e@mail.gmail.com>
In-Reply-To: <37bbc84b5fac675db98cc0276a74e55e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 30 Aug 2010 10:50:57 +0200, Leo Kr=C3=BCger wrote:
> Hi Jean,
> > I am a little curious about your experimental setup. How do you get
> > access to the ATX power connector while the system is running?
>=20
> For my atx power connector it was possible to get to conducting parts wit=
h a
> small test prod.
>=20
> >
> > I usually measure +5V and +12V from molex connectors, it's easy. But
> > 5VSB, I wouldn't know how to measure it.
> >
>=20
> http://en.wikipedia.org/wiki/ATX#Power_supply
> the purple wire is 5vsb

I know that, but I have no easy access to it when the system is up and
running, contrary to +5V.

> > (...)
> > A better way to figure out which scaling factors are intended by the
> > board manufacturer, is to compare with what the BIOS is printing. First
> > write down all values reported by the BIOS, and also note your
> > voltmeter measurement. Then do the same again with lm-sensors's
> > unscaled voltage values. If the voltmeter values didn't change, then
> > lm-sensors should report the same as the BIOS after scaling. If the
> > voltmeter values changed (which can happen as the system load is
> > slightly different) then you have to take it into account in your
> > computations.
>=20
> I've to admit that this sounds much more reliable than my simple
> measurements.
> To check your proposed factors I'm going to do it the way you suggested.
> Afterwards I will give you an acknowledgement.
> I've access to two of these motherboards, so I will check if the results
> differ.

OK, great.

> (...)
> I just found the datasheet
> http://www.fintek.com.tw/files/productfiles/F71882_ab.pdf
> To which one do you refer?

This is only a product brief, I was referring to the complete datasheet
for the device. Not sure if it can be downloaded publicly, I think I
got that one from our technical contacts at Fintek.

> Please let me know if I can do anything else.
> Especially if there is anything I can do to provide you with hardware
> specific data
> to support development of lm-sensors (I actually don't know if there is
> support missing for any of the hardware parts)

There is definitely support missing for many parts, but the hard part
is to get the datasheets and then write and review the driver code.

For board configurations, you can definitely help. If you can
contribute configuration files for all boards you have, this would be
welcome.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
