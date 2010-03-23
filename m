From: Giel van Schijndel <me@mortis.eu>
Date: Tue, 23 Mar 2010 14:17:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: properly acquire I/O
Message-Id: <20100323141718.GA23172@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1942557188110948254=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1269353535-23134-1-git-send-email-me@mortis.eu>
In-Reply-To: <1269353535-23134-1-git-send-email-me@mortis.eu>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============1942557188110948254==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2010 at 03:12:15PM +0100, Giel van Schijndel wrote:
> Acquire the I/O region for the Super I/O chip while we're working on it.
>=20
> Further alter the way multiple Super I/O addresses are probed for chips
> such that errors in the probing process are passed on from the module
> initialisation function.
>=20
> Some code cleanup: properly using, previously defined, functions rather
> than duplicating their code.

Oh yes, this in preparation for adding watchdog support for the Fintek
F71808E (very similar to the F71889) to this driver.

I'll be sending in a patch for adding sensor hardware monitor support
for the F71808E first (i.e. before the addition of watchdog support).

PS I'm using the watchdog API as described in
   Documentation/watchdog/watchdog-api.txt.

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuozWsACgkQZBYm/87l50IbawCdGH82ok/A5nXgIIIXhtLdbRV/
7GQAn1CTom8BEvM9Is9XQFqktUXu25sl
=ymYv
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


--===============1942557188110948254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1942557188110948254==--
