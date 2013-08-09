From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Aug 2013 10:27:57 +0000
Subject: Re: [lm-sensors] Proposal: I2C device power (Was: hwmon: (lm90) Add power control)
Message-Id: <20130809102757.GT6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1414882545557224937=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <20130808211825.GN6427@sirena.org.uk>
 <52040DE2.50201@roeck-us.net>
 <1376027820.695103970@f416.i.mail.ru>
In-Reply-To: <1376027820.695103970@f416.i.mail.ru>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Guenter Roeck <linux@roeck-us.net>, Wei Ni <wni@nvidia.com>, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, MLongnecker@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--===============1414882545557224937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yE3esYaFu3yg/VEv"
Content-Disposition: inline


--yE3esYaFu3yg/VEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 09:57:00AM +0400, Alexander Shiyan wrote:

> Instead of adding the support of regulators in each device, let's think about
> whether it is possible to create a global regulator for any device on the I2C bus.

> I see it like this:
> We add an extra field in the i2c_board_info structure "power_name" and handle
> it in the i2c_device_{probe/remove} functions.

This would need to be an array of supplies, relatively few devices need
only a single power supply.  This is also not something that should be
handled in I2C, power is not something that's uniquely needed by devices
on an I2C bus.

> The question remains how to maintain such regulator in the PM functions,
> but we can discuss it.

Well, there's some basic stuff for this for clocks already - a similar
pattern should work.  You need to use runtime PM to hook in the power
management and it's not going to work for everything (especially things
that can be wake sources) but there's some value in trying to factor out
the basic use case.

--yE3esYaFu3yg/VEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBMQpAAoJELSic+t+oim9cQoP/RcdidXGGHhCkcvMOrc+QtgR
tneK0C9EATYUhNFc0xGQufplPt8r5TobiyRK/Fxkq5Yl4XTH0y9gca8j5TSldY1v
oHM0d88qFY0ZaR9k5YKaY3iSYT+Iq1O+ItCcIOXlqYjgOs37sAfMmbUovAXFsEvD
A7douB517YoaJm2JPsEz7FRrwsNUjgJ4XT+DT9OYcEr2LJp8aU6dZ02bZ82a0l8W
DdSJgnFrna7G89yKNNQjcxzb+qDSf7SEsg4qXmIa7/E4KsiRB+4BHCb7ujmbLs2A
dUdRCBdGn4sJaoj0czMMyG9KY2hUih0BX3laa1LrMLSmzTEyFgxU7v/wcb5Si57Y
hFVdyWx4fgFuueORP0eqwpcSB16g5RQaM6toBRMzW4o8Thm+yhZyE+LVvpZSpOa1
R9ciYkmiBWvRKHrTz2n8L3BgXRUArTLTm8cG58n4HJwQkrHO+GRz1rQwMTLa9s9e
WpItvPoSKvJ8ooZapYWygrS7paytX/RQVYH+03URtVYKMA632lnXvljFsi3qlBcY
ry3/FAD472dFFr/6TC3yH4+ZcPYjz5RYJWs0SReadmXxIfDNihzvDHDuomDZbZhj
kdb+H13E+K8ivvMQtq6hn5EbTSHidRj/7sIkJzXTuYMAYb1Mp2/hv6j5MmEwPy6/
BRsIAVyEQjJ3AgIkL94M
=FlkJ
-----END PGP SIGNATURE-----

--yE3esYaFu3yg/VEv--


--===============1414882545557224937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1414882545557224937==--
