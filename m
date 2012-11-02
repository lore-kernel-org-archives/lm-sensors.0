From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Nov 2012 20:09:54 +0000
Subject: [lm-sensors] [GIT PULL] hwmon patches for 3.7-rc4
Message-Id: <20121102200954.GA32041@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8122257495367832296=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============8122257495367832296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon patches for Linux 3.7-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to eaa7cc60f7dff5e74ef387ace8228235fab8241b:

  hwmon: Only include of_match_table with CONFIG_OF_GPIO (2012-11-01 17:31:20 -0700)

----------------------------------------------------------------
An e-mail address update, and fix a compile error on SPARC

----------------------------------------------------------------
Andreas Herrmann (1):
      hwmon, fam15h_power: Change email address, MAINTAINERS entry

Jamie Lentin (1):
      hwmon: Only include of_match_table with CONFIG_OF_GPIO

 Documentation/hwmon/fam15h_power |    2 +-
 MAINTAINERS                      |    2 +-
 drivers/hwmon/fam15h_power.c     |    4 ++--
 drivers/hwmon/gpio-fan.c         |    2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQlCiSAAoJEMsfJm/On5mB/cwP/1h0v+YcE/U6M3Jr0plsd9jE
5kMDvYmcrm0MuHTnl0wIOQ+d1SfYPAxMtyWz/lG8s+GZ1JzLRIbD9w1S3nd1twOT
jcck808ZOSH1wMaPRkFdbqpc7qD1c9sRVtAH5/qTYBmXxZ8hiO0lCiv7qlmp6uYU
HUpeqx86OG9KQb/vC96J7a8bImjic09h38P0fR5kp0s7G9wfel2J9ZGmbrg1sTJA
XbgPV0ODyq95gCwKKnO6Z7pBMRIwrXnJRWzWUe6Fw0j4trI1VLnC7rp+L6yWPtlY
xp0YQ+3aVZsXykBbzmdGSVmhdWbJBQxd1czs+U3nPxxa2H0vDMEgzfmkEvVfbfVc
6iR3zJBCbSyI8pGDfL2krow5MZwZrY+VIt7uhBOaiEEui4HyFmggeQDin2hfRmPI
tOHIPRfDVEUeeFAuLA/mON43RBKmRRfBQIf6DLBVpg5ZdNbPczEmpbwhd0hLEXhf
vFvdboI1NHpvrzn714tp6VMx+CnB1ZAqg/XReMW2poMqTUK7FYREvGFj2RvYYxUf
LMqFgrQmlEEXRlBEleFoQfJOTUgIm+8EXuXeZ67pXZgl5rlIV43kx2Hw7GYL8Bhx
x616qsCNYazGWN2Nf9IDqDVDLYGwGhRcOcTlAlLn6pbOUaVGiTWIWw3yWUeXe1Nn
vvEJFgdWCRXOaN2djJm7
=96mN
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--


--===============8122257495367832296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8122257495367832296==--
