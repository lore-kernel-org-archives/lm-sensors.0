From: Mark Brown <broonie@kernel.org>
Date: Sun, 29 Sep 2013 12:30:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] spi: Add a spi_w8r16be() helper
Message-Id: <20130929123019.GT19304@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0389203961523958388=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
 <20130927183456.GM19304@sirena.org.uk>
 <5245D2A0.4090909@metafoo.de>
 <20130927192233.GN19304@sirena.org.uk>
 <5245E420.2030207@metafoo.de>
In-Reply-To: <5245E420.2030207@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, viresh.linux@gmail.com


--===============0389203961523958388==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t5UUIFOgpLXgUtsP"
Content-Disposition: inline


--t5UUIFOgpLXgUtsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 10:01:36PM +0200, Lars-Peter Clausen wrote:
> On 09/27/2013 09:22 PM, Mark Brown wrote:

> > Indeed.  I don't think that's terribly well thought through though,
> > especially not now we have annotations for endianness (as you noticed!).

> I wouldn't mind updating spi_w8r16() to do the conversion to big-endian.
> Especially considering that a driver using the function will probably always
> need to do a endian conversion anyway to work correctly on both
> endiannesses. We can add a LE variant if we should ever need it.

I think that's probably the way to go, the API seems to error prone as
it is.

--t5UUIFOgpLXgUtsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSB1YAAoJELSic+t+oim9swIP/Ar+YLONmmhw4thOHhhhH6WK
nYkzvvge2z5KeBOYtuMi9/O0cW+uwONmqj05a9sCMaUn1cwTNlaRTEMvma1/v1s/
VNkZFyg4+TnebJZzHwcATJAuOIUbgKYKCo/BNZJga7/79T/gvJw6eecqv1wsCb2f
UUXpE4pRxAh7WsH+meJgLAXAp0dAy+ZXPPT4k543nSef9ttgiyil6mc/KtHI2rdO
wnZWUTG3JXGmkqLwATqygFCO1hnGnLg2z2JA8CceRXiQPTYehwMqEh9MNny8W8jn
qfiiUnDFiCkY4cvPyjg6/NIzTDUHiPPSEJ3q2P3YlEGdNd7HEIsucaeDyL8DV839
m3NeM1FhXkdWc0Vh54OFQ5CtbtHER5CprHZEJmzWLRyCk7lFLd0+QlpjRU8cLrMw
FPVZo2ZT4eVueI5s8Eu4CibDOYVtKnRyyx5kn19T7HTmURpVqHeDX8NoCwAr9dTo
l1+3/mcl6tdLxSN17q6udu/uKPMADEhoRed1wwCya1MJmDwicv+cjP0do1jhQ+Ok
OD6s2zDFuWXzWSgT7Fok+RMEMYyutk80MYe1CCZ0w07CyggUFJ6bvomEV2WkPunE
b5XvZVp27NpT1vzwtsFVHSDxaglg2q+BfJzxT1ckPtovuBE+AWFBAcV/1W/Qplvc
a9NIYr6Or2+ifrbpohps
=xABi
-----END PGP SIGNATURE-----

--t5UUIFOgpLXgUtsP--


--===============0389203961523958388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0389203961523958388==--
