From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Aug 2015 05:25:13 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <20150825052513.GI1654@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0175039851168914932=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
In-Reply-To: <1440413522-7855-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org


--===============0175039851168914932==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
> Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
> /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
> code in lm-sensors does not find them anymore:

Acked-by: Mark Brown <broonie@kernel.org>

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV2/wxAAoJECTWi3JdVIfQqAEH/RzBrneVJ4mml8ks/Gr9hA+B
Gy/2BLyESl/2wYICVZwduC6p07x1UH3mHPPLbt/F9YAOupj6KXDgBXPViiSQQsiv
oTYuJLAiCnCxT8XrF1TDO3e4T16e6/mjk26mjgDBeHHpidwN16yofs070kAnK++Z
7/KPVhjhOVwbo7BXXlFXrrmUJ0f7DGE6dUxkpVgabqgO8peCBOWgcPgAXlJ/Dlod
p34VsGwiRO8oCNGKT12Mb+rhS/7jKdkoSH2khWDPOJSQQB4KHKHJ/FFlGcaolpKF
EUhpxIm5nvafU9CuLEfLE/3GoMZxfZLmf+XOyF2zBPVVISdhtLv+fkCKpa7KmgM=
=kKSL
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--


--===============0175039851168914932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0175039851168914932==--
