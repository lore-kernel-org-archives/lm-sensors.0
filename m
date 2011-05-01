From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 01 May 2011 11:35:25 +0000
Subject: Re: [lm-sensors] HELP with  and [msi p67a-gd65]
Message-Id: <20110501133525.5244a160@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
In-Reply-To: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 1 May 2011 11:03:59 +0000, Jose =C1lvarez wrote:
> > Chip ID 0x1005appears to be a F71889 a standalone drive is available he=
re
> > http://people.fedoraproject.org/~jwrdegoede/f71882fg/
> >
> > Just manually download the driver to some directory than do a make && s=
udo
> > make install && modprobe f71882fg

FWIW, the "official" (i.e. somewhat maintained and reasonably
up-to-date) standalone version of the f71882fg driver is the one at:
  http://khali.linux-fr.org/devel/misc/f71882fg/

Hans, maybe you should remove yours altogether, to avoid confusion?

Generic instructions are available at:
  http://khali.linux-fr.org/devel/misc/INSTALL

> thanks for=A0responding=A0so quickly,=A0amazing
>=20
> I'll try=A0with=A0that=A0driver
>=20
> one=A0question=A0...
>=20
> >=A0Do=A0you=A0want=A0to=A0probe=A0the=A0I2C/SMBus=A0adapters=A0now?=A0(Y=
ES=A0/ no):
> >=A0Using=A0driver=A0`i2c-i801=A0'for=A0device=A00000:00:1=A0f.3:=A0Intel=
=A0Cougar=A0Point=A0(PCH)
> >=A0Module=A0i2c-i801=A0loaded=A0successfully.
> >=A0i2c-dev=A0Module=A0loaded=A0successfully.
>=20
> why=A0 i2c-i801=A0not come out=A0in=A0the=A0summary of=A0sensors-detect=
=A0to add it=A0to=A0/etc=A0/=A0modules?=A0is=A0not necessary?

Because 1* i2c-i801 is not a hwmon driver, it's only an accessor driver
in case there are hwmon devices in the SMBus, which isn't your case and
2* the i2c-i801 driver is typically loaded automatically thanks to
module aliases and udev anyway.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
