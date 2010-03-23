From: Giel van Schijndel <me@mortis.eu>
Date: Tue, 23 Mar 2010 23:01:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: properly acquire I/O
Message-Id: <20100323230140.GA30938@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8028542421885373485=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1269353535-23134-1-git-send-email-me@mortis.eu>
In-Reply-To: <1269353535-23134-1-git-send-email-me@mortis.eu>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============8028542421885373485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
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
> ---
>  drivers/hwmon/f71882fg.c |   38 +++++++++++++++++++++++---------------
>  1 files changed, 23 insertions(+), 15 deletions(-)

Sorry, forgot to sign off the commit message itself. So just to be sure
it's understood to be signed off on by myself:

Signed-off-by: Giel van Schijndel <me@mortis.eu>

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkupSFAACgkQZBYm/87l50L3AQCfVSzzCgDKbTFU76O+/+wXNpSf
QYEAn2yULeOW1/elDbRPiy4gnS61jcyk
=bKUE
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============8028542421885373485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8028542421885373485==--
