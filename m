From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 May 2013 16:44:57 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.10-rc2
Message-Id: <20130520164457.GA3918@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7126951208811867841=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130515133311.GA14411@roeck-us.net>
In-Reply-To: <20130515133311.GA14411@roeck-us.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============7126951208811867841==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.10-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

This pull request adds two more patches to the request I sent out last week.
If there is a reason for not accepting it, I would appreciate if you would
let me know to give me a chance to correct it.

Thanks,
Guenter
------

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 917cc4e6b25c655264e8ea903eb77db25994ac24:

  MAINTAINERS: Add myself as maintainer for LM95234 and TMP401 drivers (2013-05-20 06:29:25 -0700)

----------------------------------------------------------------
Error path fixes for abituguru and iio_hwmon drivers.
Drop erroneously created attributes from nct6775 driver.
Drop redundant safety on cache lifetime for tmp401 driver.
Add explicit maintainer for LM95234 and TMP401 drivers.

----------------------------------------------------------------
Axel Lin (2):
      hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm_kzalloc fail
      hwmon: (iio_hwmon) Fix null pointer dereference

Guenter Roeck (2):
      hwmon: (nct6775) Do not create non-existing attributes
      MAINTAINERS: Add myself as maintainer for LM95234 and TMP401 drivers

Jean Delvare (1):
      hwmon: (tmp401) Drop redundant safety on cache lifetime

Wei Yongjun (1):
      hwmon: fix error return code in abituguru_probe()

 MAINTAINERS               |   14 ++++++++++++++
 drivers/hwmon/abituguru.c |   16 ++++++++++------
 drivers/hwmon/iio_hwmon.c |    8 +++++---
 drivers/hwmon/nct6775.c   |    6 ++++--
 drivers/hwmon/tmp401.c    |    2 +-
 5 files changed, 34 insertions(+), 12 deletions(-)

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRmlMJAAoJEMsfJm/On5mBDcoP/Aig+RAOOOmFKHIu1hNFXYzZ
d+smq8k66xMyapZiBkoZXP4NSgS4ohwAt4u1R11KkM2SuTf+Gr50pkozEo+uvh3N
2PwK2TKRsVfGWnoTjay72SWi3BGokHSHY2CZypW4R0mRIBNjzg5DX6kPo+eHFXE7
XdcYL1JZIcyjqJ8Sih5LKWF9U4fSq3UGYwApQOS0Yqx8wD9R3IhpAQ8/E1An95VZ
57o4YZrYYxG9dF0mo60KIMLS/plnFuREhDM2tEYweXphU/NVXcft3CsQzlMlh2kK
u2XvHUfEi11xM5+aHVhi4oskAT7+0I6aQ/lWPQ+g3QqmRHV9CLQcvjkiCrSwBvvq
mmUPF91XoqZd2AtwpsDEqjmgKtYl+tLit4LsSejhUxwT1jZHg7LfJ3KnpDU/xvBO
kPO0NuD1/rxVLqiVyYN2bgC0Ro52tiUcNbL2CIXiiHsYYfEVmvmPPPjLlVJOg6O5
tUa9eKKs9lDdhAa1wFDGMc3fD80gY4h+lB958r94vGpHVl3q5ikY4dVYcu2wiKSG
+LpFbGvXQ/CMi6wKpogoO8tEIA/MXqF535PC2ak7kDvhq31Yt4P9ziDgexcrA6qD
X/rgHNftWRNxtviHEawAlv3jUww+/hwL1tB5zTcCkFy1/dCDMcG9hcWkO0VkxkIf
ihuJkK3+kOHzKpGmGmMY
=sRIC
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


--===============7126951208811867841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7126951208811867841==--
