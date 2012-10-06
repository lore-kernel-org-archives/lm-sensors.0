From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Oct 2012 11:12:53 +0000
Subject: Re: [lm-sensors] Intel 5500 temperature
Message-Id: <20121006131253.59beb17a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Karl,

Jumping in 3 years later...

On Sun, 20 Sep 2009 21:36:24 -0500, Karl Schmidt wrote:
> I'm working on a Tyan S7002. It has an Intel 5500 (AKA tylersburg) chip o=
n it with heatsink that=20
> runs hot. Digging into the details reveals that it throttles back if it g=
ets too hot -
>=20
> http://www.intel.com/assets/pdf/designguide/321330.pdf  -- see pg 18.
>=20
> Is it possible to read the temperature of this chip?
>=20
> I've attached some readouts..
>=20
>=20
> More information at pg 159 of http://www.intel.com/Assets/PDF/datasheet/3=
21328.pdf

I have the same chipset on my Asus Z8NA-D6 board and decided to look
into this. There seems to be a thermal sensor in this chipset and
following Intel's documentation I wrote a driver for it. You can
download it at:
  http://khali.linux-fr.org/devel/misc/i5500_temp/
Generic installation instructions are available at:
  http://khali.linux-fr.org/devel/misc/INSTALL

Unfortunately it turns out the driver doesn't work for me. It returns a
constant temperature of 36.5=B0C. I've tested on a few other systems at
work, with the same disappointing result. I have read the datasheet
again but can't find what I got wrong, if anything.

I'm still sharing my work, in case it works on other systems, or
someone looking at my code can figure out what I missed.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
