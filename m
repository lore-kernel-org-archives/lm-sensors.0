From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Mon, 01 Dec 2014 19:45:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] i8k: Rework error retries
Message-Id: <201412012045.59404@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8095105472379413092=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1417381240-7641-1-git-send-email-linux@roeck-us.net> <1417381240-7641-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417381240-7641-2-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============8095105472379413092==
Content-Type: multipart/signed;
  boundary="nextPart1455025.ZsU8UBEka1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1455025.ZsU8UBEka1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 30 November 2014 22:00:39 Guenter Roeck wrote:
> Instead of returning a previous value if the SMM code returns
> an error when trying to read a temperature, retry once.
> If that fails again, return -ENODATA. Also return -ENODATA if
> an attempt is made to read the GPU temperature but the GPU is
> currently turned off.
>=20
> Drop the I8K_TEMPERATURE_BUG definition and handle the related
> bug unconditionally.
>=20
> Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Applies on top of Pali's patch series.
>=20
>  drivers/char/i8k.c | 47
> ++++++++++++++++++++++++----------------------- 1 file
> changed, 24 insertions(+), 23 deletions(-)
>=20

Working fine GPU temp (turned on or off).

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1455025.ZsU8UBEka1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR8xXcACgkQi/DJPQPkQ1Jo+ACgw4LyEqUIZaC3TLjYvVNcVP9P
XNQAoIkmi5pyhK0kqZwkxzqIvmDUk600
=NGEm
-----END PGP SIGNATURE-----

--nextPart1455025.ZsU8UBEka1--


--===============8095105472379413092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8095105472379413092==--
