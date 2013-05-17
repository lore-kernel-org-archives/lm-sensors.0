From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 17 May 2013 11:56:40 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon fixes for 3.10-rc2
Message-Id: <20130517115640.GA15916@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8460594387430635646=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130515133311.GA14411@roeck-us.net>
In-Reply-To: <20130515133311.GA14411@roeck-us.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============8460594387430635646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I noticed that you did not pull this series of patches.

Did it get lost, is something wrong with it, or am I just impatient ?

Thanks,
Guenter

On Wed, May 15, 2013 at 06:33:11AM -0700, Guenter Roeck wrote:
> Hi Linus,
>=20
> Please pull hwmon fixes for Linux 3.10-rc2 from signed tag:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t hwmon-for-linus
>=20
> Thanks,
> Guenter
> ------
>=20
> The following changes since commit f722406faae2d073cc1d01063d1123c3542593=
9e:
>=20
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
tags/hwmon-for-linus
>=20
> for you to fetch changes up to ecacb0b17c08fae89f65468727f0e4b8e91da4e1:
>=20
>   hwmon: fix error return code in abituguru_probe() (2013-05-13 08:07:13 =
-0700)
>=20
> ----------------------------------------------------------------
> Error path fixes for abituguru and iio_hwmon drivers.
> Drop erroneously created attributes from nct6775 driver.
>=20
> ----------------------------------------------------------------
> Axel Lin (2):
>       hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm=
_kzalloc fail
>       hwmon: (iio_hwmon) Fix null pointer dereference
>=20
> Guenter Roeck (1):
>       hwmon: (nct6775) Do not create non-existing attributes
>=20
> Wei Yongjun (1):
>       hwmon: fix error return code in abituguru_probe()
>=20
>  drivers/hwmon/abituguru.c |   16 ++++++++++------
>  drivers/hwmon/iio_hwmon.c |    8 +++++---
>  drivers/hwmon/nct6775.c   |    6 ++++--
>  3 files changed, 19 insertions(+), 11 deletions(-)



> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRlhr3AAoJEMsfJm/On5mBNQsQAJxSvmxZNaB7Hx0Cseiuhyzb
Si3CdChTgx+btywxw/yGikwnMp8gmTBkMPvQBBGfMbt13YCU/isjZ1TQ8TcA3vkG
giVaD9IcNxMFErrcPba+Z35IUfIiIN5GZurXSrAzxSeAO9vR9SIkpoFeJJr227AA
05O31ZwsSLZrTUoVo64j8bqSwwXkGpXxrsau5hFEj2s4HvEaO+ivoRMP1CXDLloJ
7qrmzX+7nUXrwxw6DrY7WFM5ldiaKepj2Mo/huEwl4+IymrcKZ4z7n2BvSKmmphd
5eeli1V2JkbgkLgbOf54nzPbDJgH1thtgaAh8ZGg7cT1oVNrFsgMi+Hh8LxmXMt9
4PT3sDhNjHkSCRZI/E8LQCFg3FSpCEqBKMFndI5E60mpFkSIemyhmne9mzDHIcFD
TnxjccsLCSQtLMNbQEdlMaf/7YSehpy0y29tN6NeXSPCoNMaQSFh+QrITEtCgRtH
lGsMbnjTXSF4B6bAAMY+XAa/7QcIp/EgZz8ieNThPY/quID65O6L3QPsLLZZVguY
xjDgoefBCsuwj3aTY+ivL5p5nBjjgmepWYDYnMDwbCEbH05Ta3gnpHHLbehxJ6Ng
Lp9tlKVz0xPdh6QtbDxEJWdVuay/Ogzjhbyh6Oig4WxJTwh2+tKJH5p83hTaRO9V
9/2N9OoEJ0SAV1rspBno
=J6Cb
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


--===============8460594387430635646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8460594387430635646==--
