From: Mark Brown <broonie@kernel.org>
Date: Sat, 23 Aug 2014 14:54:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] pmbus: add regulator support
Message-Id: <20140823145404.GI24407@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1386258834752727040=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1408741894-24879-1-git-send-email-atull@opensource.altera.com>
 <1408741894-24879-2-git-send-email-atull@opensource.altera.com>
 <20140822214417.GC24407@sirena.org.uk>
 <alpine.DEB.2.10.1408221927370.2334@shineypoop>
 <53F89E8C.3070200@roeck-us.net>
In-Reply-To: <53F89E8C.3070200@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: atull <atull@opensource.altera.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============1386258834752727040==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vl4kNlnRfHfswxag"
Content-Disposition: inline


--Vl4kNlnRfHfswxag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2014 at 07:00:44AM -0700, Guenter Roeck wrote:
> On 08/22/2014 05:31 PM, atull wrote:

> >of_get_regulator_init_data() will only have an error if it cannot alloc
> >the regulator_init_data struct.  That's why I did -ENOMEM.  If there
> >is no platform data and nothing about the regulator in the device tree, we
> >should end up with a zeroed out regulator_init_data.

> Yes, but if OF is not defined it will return NULL as well. Unless I am
> missing something, that means that the code will now fail if there is
> no platform init data and OF is not configured.

Indeed, and that's the more interesting case than running out of memory.

--Vl4kNlnRfHfswxag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+KsIAAoJELSic+t+oim9UfEP/AyHQIanF6o+ovN7+Iv1Jeaf
zo3e968+924k+YlGk5/zHc/tzngmqeqR5PXi1me6/T4n6Hnk8ABrNLoY+KBOzGY1
GYibzPyipy0e/xTe/J59dD+7choWDCovs8vl66g97fPzAAYWkNUnl2/fKLOBo/4a
kkkdnYT3hTADmtxBddJMxr4l75Un0abpUHEuLboLlk1M9mGlp3rRQjEf1r3IXmEQ
dFEwKe8wHYEsyGe7FQXzNG/OTdTrSWPkHih2yLkgd3p+e6h5XFkqXTfxEFF2UwhJ
iQe97YyzaiKJSKzA9FdnXVvba0Y+w/Awp7ortoFhd5wX9wHBCUSV5XuA74tFbiR9
A5u40FFbktakjASKRKjJxqhf4dqy+gqr2rDbioXXKla9CuM4jfQ3QdF/D0//6O/K
QxSN9+4klb23lTgf6T5YK+IIkp5Y5ODdIPkjSVFj+vOrHUxh1OcH64tdtJn43qG1
Ibb5EvP2WxXiFBbKmgdSV6CyroExzNpvZFEMeCGnwdOh4I+hnsG4vKzCeqQpnRuw
P7VSRJlTEyBTonctVgBauDHcIpBdO1w18PA2pUm+T67qnvEPLyIMGbUOEcA3W+U5
c9nLxul1oQiFsUlEXp+CTaMIyqWwOOb7Wz9Y+RgevHQO/rl+QaUMNen7obGT40+q
JAJ1sJmiYELyr3pq+FWd
=m80y
-----END PGP SIGNATURE-----

--Vl4kNlnRfHfswxag--


--===============1386258834752727040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1386258834752727040==--
