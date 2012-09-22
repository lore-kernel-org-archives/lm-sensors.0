From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 Sep 2012 12:44:52 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20120922144452.339bbb0d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi G=F6ran,

On Wed, 19 Sep 2012 23:56:57 +0200, G=F6ran Uddeborg wrote:
> Jean Delvare:
> > One of these could be +5V,
> > it's usually monitored (even though the lack of mention in your BIOS
> > suggests that might not be the case here.) One could be 5VSB. Both
> > would need scaling so are more likely to appear in the 2.5 - 3.3 V
> > range unscaled.
>=20
> in3 is labeled +5V by the driver, and reports 2.93V, so that seems to
> match what you say.  How would I go about figuring out the scaling
> factor?

I can't find it in the datasheet but I'm almost certain the chip uses
6.8 kOhm and 10 kOhm resistors internally to scale the voltage down to
the measurable range. This leads to:

   compure in3  @ * (1 + 6.8 / 10), @ / (1 + 6.8 / 10)

This should give you a valid +5V reading. It is odd that the BIOS won't
show it.

> in6 at 1.12V and in7 at 4.08 are both outside that range.

in7 is saturated, definitely not used. If in6 could be used, for
example for -12V, but we can't label it. If it stays stable, you can
leave it visible.

> > in8 is normally Vbat on the IT8716F, it shouldn't need scaling. Didn't
> > it report a correct value for you?
>=20
> It reports 3.20V, which I guess makes sense.  These batteries are
> nominally rated 3V unless I'm mistaken.  And this board is fairly new,
> so a little bit above that sounds reasonable to me.

Correct. Plus many recent boards backup the battery with 3VSB while the
system is powered, to extend the battery life, so values above 3.0 V
aren't unusual.

> > > (...)
> > >      # Min and max for Athlon II X2 245e
> > >      set in0_min  0.875
> > >      set in0_max  1.4
> >=20
> > Did you check if the BIOS had set proper limits on its own?
>=20
> No.  Would that be the limits given before I did "sensors -s"?

Yes, after a cold boot.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
