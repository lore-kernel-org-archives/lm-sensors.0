From: Wolfram Sang <w.sang@pengutronix.de>
Date: Mon, 18 Jun 2012 15:49:45 +0000
Subject: Re: [lm-sensors] [PATCH 17/95] hwmon: (adt7411) Convert to use devm_ functions
Message-Id: <20120618154945.GE10768@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7115384838819044545=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============7115384838819044545==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> code size reduction on x86_64 is about 15 kBytes for all drivers. With

Ah, this is useful information. Being home in the embedded world, I only
activate the drivers I need, and for that the gain is marginal if any. I
can accept that saving 15kB for an all-module distro build is nice.

> In addition to that, it does help preventing memory leaks, and it does
> make the code a bit simpler.

I definately agree for new drivers, but changing working code without a
proper need is a risk. Especially, because converting to devm_* can
cause subtle bugs when done without thought. I've been bitten by that in
[1] (last paragraph) where input_free_device is not covered by devm, so
one still has to free the IRQ manually, otherwise OOPS.

[1] http://permalink.gmane.org/gmane.linux.kernel.input/24180

> So, overall I do think it is worth it. Maybe not if I only look at one
> driver, but very much so if I look at the overall impact.

As said, I am not NACKing :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/fThkACgkQD27XaX1/VRudrQCfdoejv4wgjKzw8PGtqaG2804U
Ox4AoK1Dnxmwr5yu66g7KEXDeA/KATjx
=774g
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--


--===============7115384838819044545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7115384838819044545==--
