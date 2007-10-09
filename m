From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 09 Oct 2007 15:00:44 +0000
Subject: Re: [lm-sensors] Unknown chip on Dell Latitude D630
Message-Id: <20071009150044.GG13822@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7703506126274331448=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200710071631.00273.arnestaecker@web.de>
In-Reply-To: <200710071631.00273.arnestaecker@web.de>
To: lm-sensors@vger.kernel.org


--===============7703506126274331448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2007 at 07:21:46PM +0200, Hans de Goede wrote:
> > On 10/7/07, Arne St=E4cker <arnestaecker@web.de> wrote:
> >> Hi,
> >> when I run sensors-detect, I get:
> >>
> >> ...
> >> Some Super I/O chips may also contain sensors. We have to write to
> >> standard I/O ports to probe them. This is usually safe.
> >> Do you want to scan for Super I/O sensors? (YES/no):
> >> Probing for Super-I/O at 0x2e/0x2f
> >> Trying family `National Semiconductor'...                   No
> >> Trying family `SMSC'...                                     Yes
> >> Found unknown chip with ID 0x3201
> >> Probing for Super-I/O at 0x4e/0x4f
> >> Trying family `National Semiconductor'...                   No
> >> Trying family `SMSC'...                                     Yes
> >> Found unknown non-standard chip with ID 0x13
> >> ...
> >=20
> > This is an unknown chip. You could try the superiotool
> > (http://linuxbios.org/Superiotool) to check if it can find something.
> > Other than that, you would have to open your machine and look for a
> > chip with the SMSC logo an tell us the chip name. Maybe we can do
> > something with that information...

The output of 'superiotool -V' would be useful.

If the 0x13 above is correct, then superiotool won't recognize the chip
either, though. I can't seem to find a public datasheet for it.


Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC5ecXdVoV3jWIbQRAnqaAJ4weZiQaWVv7ssA+0bchgxlCLscogCfeYyJ
AQ6lgPy/TXrLLQf7y9a2jcc=
=vrLu
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--


--===============7703506126274331448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7703506126274331448==--
