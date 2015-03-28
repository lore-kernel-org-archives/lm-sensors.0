From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 28 Mar 2015 22:33:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <201503282333.46803@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5836667387771929115=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com> <1427580377.2408.2.camel@x220> <CABz95_AZnyCH_0VYdx4bHV7KV=goNxz1YdvrUCFJQSOAqwwMug@mail.gmail.com>
In-Reply-To: <CABz95_AZnyCH_0VYdx4bHV7KV=goNxz1YdvrUCFJQSOAqwwMug@mail.gmail.com>
To: Steven Honeyman <stevenhoneyman@gmail.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============5836667387771929115==
Content-Type: multipart/signed;
  boundary="nextPart9468335.Bq8StZm9v6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9468335.Bq8StZm9v6
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 March 2015 23:19:04 Steven Honeyman wrote:
> On 28 March 2015 at 22:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Saturday 28 March 2015 13:54:51 Steven Honeyman wrote:
> >> i8k-virtual-0
> >> Adapter: Virtual device
> >> Processor Fan: 3171 RPM
> >> CPU:            +52.0=C2=B0C
> >> Ambient:        +46.0=C2=B0C
> >> SODIMM:         +40.0=C2=B0C
> >> -----
> >>=20
> >> Ambient and SODIMM look swapped - but it's probably just
> >> another Dell error. I really need to look at getting
> >> coreboot on this thing.
> >=20
> > Both patches do not change any code. So there should not be
> > any type swapped with or without my patch.
> >=20
> > Cpu type is requested via SMM in same way as it is doing old
> > DOS executable. So there can be maybe problem in DELL SMM
> > handler too or maybe just I did not understand correctly
> > assembler dump of DOS executable...
>=20
> Is there some way that I can find out for you? I've got a
> Windows partition somewhere, or DOS boot disk should be easy
> enough if this program works on new hardware.
> If I knew where the sensors were placed I could cool one of
> them.
>=20

Maybe DOS executable is just too old... and need to use new one.=20
I extracted diagnostic application from BIOS package (EFI binary=20
which show temperature in BIOS) for my laptop, but decoding=20
instructions of this big graphic binary is beyond my power. But=20
it looks like it calls same SMM inb/outb calls, so SMM code in=20
BIOS handler was not changed.

So if you want to fix this problem, next step is to disassemble=20
or understand new modern EFI diag binary...

I think it would be better to locate on which bus are sensors=20
connected (smbus? isa? pci?), find out HW chips and wrote native=20
kernel drivers for them...

I scanned smbus (intel controller connected on pci) on my E6440=20
but there is no additional/unknown device. I have no idea where=20
else could be sensor device connected and accessible (from SMM or=20
kernel mode).

> On 28 March 2015 at 22:04, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > I think that setting CONFIG_I8K to tristate (Y/M/N) does not
> > make sense... CONFIG_I8K just control if /proc/i8k will be
> > compiled into dell-smm-hwmon or not.
>=20
> Try and select dell-smm-hwmon as a module, with i8k enabled as
> well...
>=20

Got it.

> On 28 March 2015 at 22:06, Paul Bolle <pebolle@tiscali.nl>
> wrote:
> > On Sat, 2015-03-28 at 22:55 +0100, Pali Roh=C3=A1r wrote:
> >> I have tested compilation only with out of tree make
> >> command with manual CONFIG_SENSORS_DELL_SMM and CONFIG_I8K
> >> options.
> >=20
> > Not sure what you mean here. I can't get things past this
> > error:
> >     drivers/hwmon/Kconfig:1721: syntax error
> >     drivers/hwmon/Kconfig:1720: invalid option
>=20
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1705,8 +1705,8 @@
>=20
>  config SENSORS_DELL_SMM
>      tristate "Dell laptop SMM BIOS hwmon driver"
> -    depends ON X86
> -    ---help---
> +    depends on X86
> +    help
>        This hwmon driver adds support for reporting
> temperature of different sensors and controls the fans on
> Dell laptops via System Management Mode provided by Dell
> BIOS.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9468335.Bq8StZm9v6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUXLEoACgkQi/DJPQPkQ1LafACfaPoaTXVdanbkrbbOTfFcb/Md
X6IAnj6lIyZ/LmLDj0ZbuKG4wtPGBecu
=qP1a
-----END PGP SIGNATURE-----

--nextPart9468335.Bq8StZm9v6--


--===============5836667387771929115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5836667387771929115==--
