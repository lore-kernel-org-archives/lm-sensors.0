From: Mark Brown <broonie@kernel.org>
Date: Sun, 26 Jan 2014 20:42:04 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140126204204.GI11727@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2746776745946417670=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net>
 <20140126211357.6fa68909@endymion.delvare>
In-Reply-To: <20140126211357.6fa68909@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>, LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>


--===============2746776745946417670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mlxBsilMljZ1v4XL"
Content-Disposition: inline


--mlxBsilMljZ1v4XL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 26, 2014 at 09:13:57PM +0100, Jean Delvare wrote:

> Me, I really don't know. I seem to remember I tested Wei's patch set on
> an emulated ADM1032 chip and it was working fine. So maybe it depends
> on the kernel configuration, or something changed on the regulator side
> meanwhile.

The regulator API hasn't changed here, probably the regulator API was
enabled when previously it was disabled.  If the platform doesn't have
regulator support either natively or via use of a firmware interface
like OF then enabling it is going to cause problems since no supplies
will be mapped in.

--mlxBsilMljZ1v4XL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5XMZAAoJELSic+t+oim9Zf8P/0LV4QrIbu0RRIpoiYiAMHNt
dsmEsvMo+zuwpjTJlgaNFyo7ZWz4DZNcWR8azCBJEj1RNItZcTsDUnaQgJuGWbf9
3+wDMaZzEzB9lBQ0tKLu7uciVw6RFfdTS0FYs0mMbOTatmd0QMgKNWHu+Vguu56G
6cuyIqwUDIaG5C7YwxZTihP9wM06Nvtz1MRASkxLls3Ae5/QOaV1tpJD+jtLdcE4
Kix62qOTEY/1q8tFPk0iSL7wLXUDVXWoMZcZQLe27OxXPd19nwgCk87laK55cvQQ
8pNZCJObsJr/l+QOSO1+d1exVlib2YleI7jHE0G++osXQpiOy/wbpIPkFI1hmSyA
ZE/CLKEkCj+6BpXUKHPBnj64t5AQGNG6sPuGJLSY0Ol51l05yjyaX8NTuR8VxyV/
tACbE75Bfww/bB1BGD0YqCPWE0EYWLcC82cPhNynt/NEELopQIASJ1XSLSjZN7wV
lbucAedErHhcZA2ANwYdu+22Y7lhMexT6fvNopWaxRwaYQ86xAGJ4kM/7d3facDY
k5eTwq/VXOdmdTjl3iKfXFPQgXJetSVxtGJ/I5h9/0lx1o429yQu7Fspypp1CbA3
d6d1jYEVxntF4ERQ/qhQXntvjNugwRboUptS/lPQC8qgSK/WdJ+bChjcAA2XuWwI
bVVjqUdiyVf1Uix3IKVi
=9/Ae
-----END PGP SIGNATURE-----

--mlxBsilMljZ1v4XL--


--===============2746776745946417670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2746776745946417670==--
