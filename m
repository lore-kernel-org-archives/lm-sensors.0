From: Mark Brown <broonie@sirena.org.uk>
Date: Thu, 12 Apr 2007 12:15:27 +0000
Subject: [lm-sensors] w83627hf hardware sharing
Message-Id: <20070412121527.GA3132@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7963644661918341064=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============7963644661918341064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While looking at the w83627hf driver I noticed that there are currently
two drivers in the kernel controlling these devices: w83627hf providing
lm_sensors support and the w83627hf_wdt driver providing watchdog
support.  Due to the hardware interface provided by the chip with many
functions multiplexed via two registers this can't be done safely:
concurrent access.  This is unlikely to happen at present but it is
possible and I'm currently looking at an application which uses some
additional functionality on the chip and would run into trouble much
more readily.

The most straightforward fix appears to be to provide a multiplexing
driver for the chip.  Does this sound like a reasonable approach to
take?  I'm particularly worried about the possible effects of changing
the lm_sensors driver, causing the device to move in sysfs, though as
far as I can tell current versions of lm-sensors should not be affected
due to the sysfs class.

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iQCVAwUBRh4i2w2erOLNe+68AQLoawQAhbQtZeXyUWC/3T2GwcKykWrBH8bmlKcx
4V3gzwjD84M9GZ/7/E6q5HUa+fh5lxLWiIgmAM5/u9cO165m95t6SExjEWv36aai
TBpXyWuEAS+f7n+UIU4HI93KobcpXxoVs0svHtF6qkDEugotXTzVqMUIBckpkrCg
67f/wMvjEsg=
=jGNa
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


--===============7963644661918341064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7963644661918341064==--
