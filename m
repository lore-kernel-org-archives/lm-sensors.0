From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 15 Jun 2012 15:28:34 +0000
Subject: Re: [lm-sensors] [PATCH 88/95] hwmon: (wm831x-hwmon) Convert to use devm_ functions
Message-Id: <20120615152833.GM4482@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8833012542491484394=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-89-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-89-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============8833012542491484394==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2012 at 08:24:09AM -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
>=20
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP21RgAAoJEBus8iNuMP3dAfkP/0GSsMr8XuJ2QCA+ZWX82PpG
wIIumFYKMWm3jyPrnCEdrni7m9I4jVOo8ci1JjeTNo93GYlxCoGCHqWzVUG8bjma
eXXA++f3aONaytUoSzwIylWA4jBZ3n2jTq79CHvIeVMZcXWHAKszyBqEa03U+PZP
MswWPvMkGstqGyrf30qX4oTdL7omVO0OuMwn6Rio5HDzBdLLTWv6/3k06CUbk6UR
xPWYjqNPsNBTm2s9Cya3rl0XqnyxfANglyIALLDpRUmBxn3zY1VSTXBND25rRff4
fm+3p+Xh9msP+zslqFpTb8duiAEhtP4LMvy7S5J8xFwHYcgD9IeMU5n4AknRPsNV
FhQaXMAq2SkVd5amvtz0VY+AmHwEVA3xzEihxIuZSo5/yZqLNsb+RphLu/kHlc/a
1fb2VskPftBuk83IogQ31W0hP4G+QctoErICK/CHAZ50qDoJfxwMI7Zm0hWNrekI
17z3D45wkced8bNsq8j86zS7WFJ/GpVNSkgld8cMWim+tEp1bTzkNd1kys1Qrn2p
cvziN42Bo8huI3R/VOCib/+goRm3LKPCL37ex5OPeiTbzkE1aXpCu7BQ0Wf9SvyX
yZ/tM3gCTkDLZh5yeSSeQ9F2Tr33EWBveppED0sjX0v/k/rwXCZNAiMaLgHt/CAf
2GJklecFrcKfWAzXvt8d
=hcvU
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--


--===============8833012542491484394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8833012542491484394==--
