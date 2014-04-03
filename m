From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Apr 2014 15:48:49 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for v3.15 (part 2)
Message-Id: <20140403154848.GA5588@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6485373336230261515=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============6485373336230261515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the second part of hwmon updates for Linux v3.15 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

This adds one more patch which had secondary dependencies. The branch point
is arbitrary, but I did run a full set of build and qemu tests on it. While
there are some new build failures (6 out of 122 in my builds), none are due
to this commit.

Build results are available at http://server.roeck-us.net:8010/builders.

Thanks,
Guenter
------

The following changes since commit 0f1b1e6d73cb989ce2c071edc57deade3b084dfe:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid (2014-04-02 16:24:28 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to ec0159503ae74aeb834e78366bdf4b9663ca1129:

  hwmon: (k10temp) Add support for AMD F16 M30h processor (2014-04-02 22:09:14 -0700)

----------------------------------------------------------------
Add support for AMD F16 M30h processor to k10temp driver

----------------------------------------------------------------
Aravind Gopalakrishnan (1):
      hwmon: (k10temp) Add support for AMD F16 M30h processor

 Documentation/hwmon/k10temp |    6 +++---
 drivers/hwmon/Kconfig       |    4 ++--
 drivers/hwmon/k10temp.c     |    1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTPYLgAAoJEMsfJm/On5mBpO8P/0ukoGhmnf14h0rjl8ES3B5R
l+c42fIboLUqFlK4kv0dOKtz3iKfGWR5CeF0ZYuZySrz4YizfPyTEr1n5kirU84y
uJc62zn6Cjlt1bt69BMsP59aXcjAn3LQqejZNrYulO95iXD2Tt8pJhzQCaJbMmve
ZQ7G+dICx4PtaNpktmdfCdAFF0T41kMFEItnIn7o+ttdw3PJ19Fva4tliRTWTRBv
tgqcJ2kmO16h2gzvFCFNXJ1dVN9mGnT4ktZLroiT+PH2PmrmZDAnskOvQcePEtwB
pSc77PfE0VADNjyVBrdtwMidAqiEI8m9m0ndrQFpmIY1eizAYpwA6BHA13Nz+eyX
7Rsr34L65nXSgdH6EFUDikVG1McTAEvOSSIuKDvsZmWXkuCIB3MXOgWzXw9gSvEf
WSzUz1tQgnVgU0ewySNvl2ro72pZQ6xijoaTRvFE8Zggwr2zqe6yS2DTuHvLRprg
rO5nSjjmBW+GMyRoehCLe9cv0AQ5nQtiRGbFMY9uisCF4lFLCUB3tkbGigoSy42F
9YWTeU/n9mleILdYIiRHkv15YO02Qrzxyx2amWbHTR3n0QofxnjiggYu0gPZNynE
zmYiDpiCRxEd2pBCUE3dsf1Pl/Y0yqzk6D+5VwxEvSkey/VQuHPIpQszPFlmhCQv
KUsx1iuOoo8b4wNVIAKh
=KteO
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============6485373336230261515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6485373336230261515==--
