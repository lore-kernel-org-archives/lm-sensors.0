From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2014 21:44:17 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] pmbus: add regulator support
Message-Id: <20140822214417.GC24407@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4510723180573062426=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1408741894-24879-1-git-send-email-atull@opensource.altera.com>
 <1408741894-24879-2-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1408741894-24879-2-git-send-email-atull@opensource.altera.com>
To: atull@opensource.altera.com
Cc: linux@roeck-us.net, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============4510723180573062426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/OCBIV6O7sl/38gM"
Content-Disposition: inline


--/OCBIV6O7sl/38gM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2014 at 04:11:33PM -0500, atull@opensource.altera.com wrote:

> +	if (pdata && pdata->reg_init_data) {
> +		config.init_data = pdata->reg_init_data;
> +	} else {
> +		config.init_data = of_get_regulator_init_data(dev, np);
> +		if (!config.init_data)
> +			return -ENOMEM;
> +	}

It should be fine to start with no init data - just let the regulator
core worry about it.  This will allow users to read back the state even
if they can't change anything which is useful for system bringup or
general debugging.

--/OCBIV6O7sl/38gM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT97muAAoJELSic+t+oim9RE0P/3ctAmxcQw+eYMxcs0XVvZQ6
ZwqnDoovINlsRXoi9kAGgp/gdeng1zsPgqVhdSgOdTL1p2gvoMshAnGSRGDKLopY
abZb87Nhf65UEvNob+opqeeQvRAs7pvjLNo+3BFUQ0CfhIji1LP2EwLqJt5UwJG5
sGK/MA2zchzWy9JZzRGA1meOS74wV7EzhZM047Ic1fu2+IkxXW8NpamiID4R5zey
tdxdf3jnQi3Q2M2RD7ZamEwDHSlCxSiNZCtPrj8o3KdmGoM+U0/AfWHXaDuaT961
cJNCxde7r1DSqoGMk7+4874lDjHzmdackgRyKEXFWPyDY/eAFvELbq3j7HCNKFKA
a4bRnknMubMZq3J8pY8pIpgU8BfzV+smwRN9FIbdECnNCVX7OuWA5fQBFUFXXAZn
UTslMrS8HihGspgctLkiZBjypThhaSJPvIvOpLpnvYACuCkekK2VY2bPCVW05sic
Q4FP431tG5V2tLfcgxUaJAktBrE56KvTQTU8TLtFdHOe1WZ3mZJqEwsBO33p8Q/v
fcbsWALG80OU2ljEOBdhxFfQ2Sw7aNvJyEeYToEQcYW3s8P5msPE2KkgIOcC9J9B
h14KVTjVJmNjPRn1EDtojH/3gZOgsoIaHTwL+qNocmpsV3iYLSQcEc1DqXCyDwZ7
/IPQv7z+iSoHn/fcGSmj
=chNo
-----END PGP SIGNATURE-----

--/OCBIV6O7sl/38gM--


--===============4510723180573062426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4510723180573062426==--
