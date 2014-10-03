From: Mark Brown <broonie@kernel.org>
Date: Fri, 03 Oct 2014 14:27:46 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/4] pmbus: add regulator support
Message-Id: <20141003142746.GA24441@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7950504667713603805=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com>
 <1412275071-6417-4-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1412275071-6417-4-git-send-email-atull@opensource.altera.com>
To: atull@opensource.altera.com
Cc: linux@roeck-us.net, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============7950504667713603805==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 01:37:50PM -0500, atull@opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
>=20
> Add support for simple on/off control of each channel.
>=20
> To add regulator support, the pmbus part driver needs to add
> regulator_desc information and number of regulators to its
> pmbus_driver_info struct.

Reviewed-by: Mark Brown <broonie@kernel.org>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULrJeAAoJECTWi3JdVIfQx5YH/2Or3CYT25D8ArNXkmGEnXvN
PPXAbRTmKOGRdX3gH5p7Vbijw0n2YonPF4s4lFNr3OPwPBXic8AHlB6nBOFQkho/
4MD196tDboRfOFbAuEtZxHU2BREBEPo1JK10Q5EO/knRnTow7ub5GrOSDs0ToKdw
ieI8fG4GYxcUAoIeUnelt9TQmjqtxlOTaAmPEQ00RzL0zLQxt4AlLxFgQywQrrps
9AjY3mLzF/isYGVfGFOYzmu0Ny9iCKLBuffu8i/pdBZaU6BtUsPBkeqZszjR+PeJ
fbsARKC/o8Tryp9ttaWsA4jnoSAeNKKyc0IoJPkXjqbcmt1Sn3Px4hB3hgUFCMc=
=J0bv
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============7950504667713603805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7950504667713603805==--
