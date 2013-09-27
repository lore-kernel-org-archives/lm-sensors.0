From: Mark Brown <broonie@kernel.org>
Date: Fri, 27 Sep 2013 18:34:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] spi: Add a spi_w8r16be() helper
Message-Id: <20130927183456.GM19304@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7894393089446833503=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380292469-17347-1-git-send-email-lars@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org


--===============7894393089446833503==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7trrzIZ+323l9a6P"
Content-Disposition: inline


--7trrzIZ+323l9a6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 04:34:27PM +0200, Lars-Peter Clausen wrote:
> This patch adds a new spi_w8r16be() helper, which is similar to spi_w8r16()
> except that it converts the read data word from big endian to native endianness
> before returning it. The reason for introducing this new helper is that for SPI

This actually feels like a bug in spi_w8r16() - I'd expect it to be
returning native endian in the first place since in SPI a word is by
default big endian so I'd expect this to have more of a register I/O
model.  It certainly seems to match what almost all of the users are
doing.

That said I'm not sure this is worth fixing in which case the new API
makes sense.  Or converting the users to regmap I guess.

--7trrzIZ+323l9a6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRc/NAAoJELSic+t+oim93NQP/RHbzfrfaSV7HU3/tidrmOtB
Aowo5KNj7szZ3GO8WUQlAhQnsavAvlkjSUIAaiCuqxecFYCKWX+b87dkB+1B9kT3
u5G6lpW14OzIhLlq6nYvL8TymhgYpkcjQ3eGQvweUuQpEv62Bi/9Ji5+hyxRJ5UR
Vto1QZmvN7HOKNm5DWSsAw7j/rZYtxn9V325OZEshCEhpoUwhKyAidEN8ggYxNTq
AnYK1fDB4GLeTS8v5syeNpYgpxyz2ZNQzwOiUebvMVLsR+mFf52Xb8dsWx9dDAGG
sYjrpSuldnlCcyFuIPJyJNuCNDYXDR8S0UV1XHhyA4Eq6gB96HSU3wZxtAhfLq9S
mMkj9wusXR2SzLgok3KYGjAHbqrRUhXmaWt4NuPRri8ShBhN7FlYAnpvDjAmXE0s
ugKN0zn1whWb+5DwO3aFIeOcXWN/6WCLSPpFsQHe7Vn4qnttcLCUaKpnbnBB6ITI
sOA6wzFG2BaUI5A8XVwVWSyfi16nHhLQbdoyLqJiVimS9j37qhJ6lxEnKhB/+smS
y7ZXedqm47Gebh+y24+y9Ml6rhf6zn0xghz3agN7oERXvPMdDBd4jtUy0586X2EG
AeuaZsHXozm+aytVk5KMh61VX6Kn9CAv5M/eZJbpKZRJSe5zxIYI2H89hz7c7Cct
ecejrKWQgqCik84K+4pv
=bQi1
-----END PGP SIGNATURE-----

--7trrzIZ+323l9a6P--


--===============7894393089446833503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7894393089446833503==--
