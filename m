From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 28 Mar 2015 22:00:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201503282300.48749@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5683307601867905310=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com> <1427540660.2334.14.camel@x220> <CABz95_BkAvPoBAm_tRLH6OhCk_pDfJQ8UuwfhuEYuPNt3P-PGw@mail.gmail.com>
In-Reply-To: <CABz95_BkAvPoBAm_tRLH6OhCk_pDfJQ8UuwfhuEYuPNt3P-PGw@mail.gmail.com>
To: Steven Honeyman <stevenhoneyman@gmail.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============5683307601867905310==
Content-Type: multipart/signed;
  boundary="nextPart18554150.3UFgmxOnW2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart18554150.3UFgmxOnW2
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 March 2015 13:54:51 Steven Honeyman wrote:
> On 28 March 2015 at 11:04, Paul Bolle <pebolle@tiscali.nl>=20
wrote:
> > On Sat, 2015-03-28 at 11:24 +0100, Pali Roh=C3=A1r wrote:
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -1703,6 +1703,17 @@ config SENSORS_ULTRA45
> >>=20
> >>         This driver provides support for the Ultra45
> >>         workstation environmental sensors.
> >>=20
> >> +config SENSORS_DELL_SMM
> >> +     tristate "Dell laptop SMM BIOS hwmon driver"
> >> +     depends ON X86
> >=20
> > How did this past your testing?
> >=20
> >> +     ---help---
> >> +       This hwmon driver adds support for reporting
> >> temperature of different +       sensors and controls the
> >> fans on Dell laptops via System Management +       Mode
> >> provided by Dell BIOS.
> >> +
> >> +       When option I8K is also enabled this driver
> >> provides legacy /proc/i8k +       userspace interface for
> >> i8kutils package.
> >> +
>=20
> It's working OK for me (after fixing the mistake pointed out
> above).
>=20
> [Latitude e6540]
> -----
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +53.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 0:         +51.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 1:         +53.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>=20
> i8k-virtual-0
> Adapter: Virtual device
> Processor Fan: 3171 RPM
> CPU:            +52.0=C2=B0C
> Ambient:        +46.0=C2=B0C
> SODIMM:         +40.0=C2=B0C
> -----
>=20
> Ambient and SODIMM look swapped - but it's probably just
> another Dell error. I really need to look at getting coreboot
> on this thing.
>=20

Both patches do not change any code. So there should not be any=20
type swapped with or without my patch.

Cpu type is requested via SMM in same way as it is doing old DOS=20
executable. So there can be maybe problem in DELL SMM handler too=20
or maybe just I did not understand correctly assembler dump of=20
DOS executable...

> On 28 March 2015 at 10:24, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote: ...
>=20
> >  config I8K
> >=20
> > -       tristate "Dell laptop support"
> > -       select HWMON
> > +       bool "Dell i8k legacy laptop support"
> > +       select SENSORS_DELL_SMM
>=20
> ...
>=20
> > +config SENSORS_DELL_SMM
> > +       tristate "Dell laptop SMM BIOS hwmon driver"
>=20
> The only change I'd suggest is not to change the tristate to
> bool for I8K. Forcing that to bool means that
> SENSORS_DELL_SMM can't be compiled as a module if the user
> wishes to keep i8k hanging around "just in case". It'll
> probably annoy distro kernel packagers too.
>=20
>=20
> Thanks,
> Steven

My idea was:

SENSORS_DELL_SMM enable/disable compilation of kernel driver=20
(ether statically link into kernel image or as external module)

CONFIG_I8K just enable /proc/i8k code in SENSORS_DELL_SMM -- no=20
additional driver, just boolean switch which has effect only iff=20
SENSORS_DELL_SMM is Y or M

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart18554150.3UFgmxOnW2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUXJJAACgkQi/DJPQPkQ1JcLQCgoanOm08BpqD2cSSbDzk/EVoH
1bcAoIicstuwHGvI41ZDD0dfsaJY4hGy
=jeim
-----END PGP SIGNATURE-----

--nextPart18554150.3UFgmxOnW2--


--===============5683307601867905310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5683307601867905310==--
