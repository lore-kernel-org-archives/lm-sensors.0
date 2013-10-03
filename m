From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Oct 2013 10:59:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] spi: Add a spi_w8r16be() helper
Message-Id: <20131003105943.GJ27287@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5477044793970100199=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
 <20130927183456.GM19304@sirena.org.uk>
 <5245D2A0.4090909@metafoo.de>
 <20130927192233.GN19304@sirena.org.uk>
 <5245E420.2030207@metafoo.de>
 <20130929123019.GT19304@sirena.org.uk>
 <524D4967.4030300@metafoo.de>
In-Reply-To: <524D4967.4030300@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>


--===============5477044793970100199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2013 at 12:39:35PM +0200, Lars-Peter Clausen wrote:
> On 09/29/2013 02:30 PM, Mark Brown wrote:

> > I think that's probably the way to go, the API seems to error prone as
> > it is.

> It looks as if for the ads7871 the wire order is actually little endian.

Why do hardware engineers get all the best drugs?

> endian word. Maybe we can merge this series as it is, then add a LE version
> for the ads7871 and STMPE driver and afterward remove the wire-order
> spi_w8r16().

Yeah, that's probably about as good as it gets.

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTU4cAAoJELSic+t+oim9mN0P/iBFTv8hp1fyqVL45aFnfntO
KH3MuqlJURq8FMjcgeQL4YEQxm28zt5ay7je6fApyZF2NqS5bU+C76isJM75kElq
u2vXKbALTQna0OhGwlzxp7wdkDzbHrN25i1xYlmE6JaglwQ8rNMCjAhVQXwwH06i
Tk16a+pOAXJCrX8K9WbYadz4pWTYcU04Ea1YZPheFPMaLweO7NzLdI7cY30jmZdH
AfFMLhF7aHd2Lpa/z1l6hFuqlHnL1xH0BDAsxruhginbpGDebRjHiVdumBcOjBT8
F62mLrDDlFlWm1wGaC9Thm7kkbD+42q2/ntTsk5H1iCe931LizqnS/iSnE7iGJMx
kaCw0nBosmQ7zDF+2YIIzKlhgU+crR5nuA27b9z4dn6ropxPSd8YMvSUPJ3fEzFQ
7dSBiBuwIXJugRv/LY01Vdg/648f8NEmBF1Pqzrv5a0pEwAOttNEVl2mJGlzWJsO
9sL0tbnunM3D3iCOv72f9PGQb1cCN/Kz8ZlZ3fGsXeCRtoXCg/VenbkMpkEd8Z0t
DeeiFQefPZ1XWnr6CqXCkmFlvByxfLdaHu1mDGFtNTR39ma2+3JWll/QDsE4SUWO
5Cc8N6LfGl1jRFw3oMojMxnYIapDnBSblUuP9Iyly3mDk69f37MJycqV/XzxgEyp
5CvxULPf5VObA/ve/tZo
=sOEF
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--


--===============5477044793970100199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5477044793970100199==--
