From: Mark Brown <broonie@kernel.org>
Date: Fri, 27 Sep 2013 19:22:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] spi: Add a spi_w8r16be() helper
Message-Id: <20130927192233.GN19304@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6832406105572327889=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
 <20130927183456.GM19304@sirena.org.uk>
 <5245D2A0.4090909@metafoo.de>
In-Reply-To: <5245D2A0.4090909@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org


--===============6832406105572327889==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OE5XN2KVoD5QaTkR"
Content-Disposition: inline


--OE5XN2KVoD5QaTkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 08:46:56PM +0200, Lars-Peter Clausen wrote:

> According to the documentation of spi_w8r16() it is a feature.

> 	* The number is returned in wire-order, which is at least sometimes
>  	* big-endian.

Indeed.  I don't think that's terribly well thought through though,
especially not now we have annotations for endianness (as you noticed!).

> There seem to be at least two users though which assume that the result is
> in native endianness drivers/hwmon/ads7871.c and drivers/mfd/stmpe-spi.c

Yeah, I saw.  The ads7871 is just going to break when run on the
opposite endianness to the one it was (hopefully) tested on since it
doesn't make any effort I saw to cope with endianness.  Looking at the
history it's not terribly obvious which that was but it'd be surprising
to see a little endian register...

STMPE is doing a byte swap so it's another user for your function -
it's for ARM systems so it'll be assuming that little endian is the
native format.

--OE5XN2KVoD5QaTkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRdr1AAoJELSic+t+oim9PG8P/0UKnEJ+rkGxtGoV5ZnwJF2p
peYcJ8hOsEcuo+ZY4U7anWZ4vN3igH5XCCapKK5D5Aw4hf6PwZEqdeYo43ZYlwkD
Q+65VDp1A8QyAJgQPnyBINZDwYZV4YEMkOSX5mbqrcOU1slIM3l5L2BJ0rF9jKvT
NXUX7dzv1i+CVK6LkpVwTgboE+li8vtIqb7HdU5aQUDgJWKHGv/oNLW5ooNi+1I3
t99iH/zUCjqLoM9P0T6RBisL6VOqMDM/OK6cqkcIsm83eeC0YGqcDlYc/RIi4GAT
eaTVc5IRdPOLarL7YOFNId5p4+4q5Qoommyb51UKXsOmJIhM2dKUdo2OIwmRF7B5
LeqzeuXktCtRUJQ5Qtx6u/FRBMI/Hs2Zt2G+97dPa5RLvBWqnc/sQ7+kowUWjiQt
1aCQ+y9pUbQQlmlLtpflidR9yvK9UacxCaqpEJl8gErl3FrcdInvx5waX9gBYdvC
isBVVQjJKOYLNzyO1DvxLEQDgZXDtfgGQvgwvoCnykqrtw/xkgEt4eMqtolhyerB
fkdpVcK60dqHW3D/VKeXhyr+AhY/1KeSHHtMMnqqsUp0I0oDDyqCKy5RnjYf4qpN
al2eToBPtXe8iJtRiod7nVhLBJTa44BhGk5UZWy6QIJT0imthvd+SLAScUVR3lDf
Gg3Wc6jxbVlGAr+ygdUM
=cA06
-----END PGP SIGNATURE-----

--OE5XN2KVoD5QaTkR--


--===============6832406105572327889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6832406105572327889==--
