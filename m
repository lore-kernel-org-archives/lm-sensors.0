From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Mar 2012 16:31:13 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.3-rc7
Message-Id: <20120308163113.GA30950@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4754772764152055734=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============4754772764152055734==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.3-rc7 from tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Guenter Roeck (3):
      hwmon: (pmbus_core) Fix maximum number of POUT alarm attributes
      hwmon: (zl6100) Maintain delay parameter in driver instance data
      hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804

Jean Delvare (1):
      hwmon: (jc42) Add support for ST Microelectronics STTS2002 and STTS3000

 Documentation/hwmon/jc42         |   26 ++++++++++++++++++++------
 drivers/hwmon/Kconfig            |    5 +++--
 drivers/hwmon/jc42.c             |   30 ++++++++++++++++++++++++++++--
 drivers/hwmon/pmbus/pmbus_core.c |    3 ++-
 drivers/hwmon/pmbus/zl6100.c     |   10 ++++++----
 5 files changed, 59 insertions(+), 15 deletions(-)

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWN7RAAoJEMsfJm/On5mBpZAP/j/XYI2Yw0v2ofwuf1s0/FQy
Rs7DRxjzyVi+8RTlW5VCGkXkCRIWDqQzrdJXqtwaSm/d19QUruEiUXvtM8QzdNMW
mGpitWxbNEyGHDvZP965B0rGHGNr9aZCvSSXdIfACBcF+MsyZvitrpF8psUEMFgH
fCzcyfUD3j/EfwZMICzQb/U400va02ZqRvLD7I/ggawnabBZvrg9jRSNmrN8wka1
uDk56Iw0oHZm5m+HhV6fn8JNaepyYYeanBZF7p+qBfZL1AFGhDkvpQ73/XAxtk1V
ED4zlXzIzKy47DkU0dKde+aVcmgy22CRRDnpfaxFBE8rvsg7/vglPNbR7r0sxQzg
wPyBFnkeBShRl4ZFMT45FMN7pvA7DRoVpMKiryBsAMqS50dOofprd24XsX/EBDMv
WRhMPsBf5YvB4kihJJvftb/1Z0ZeV85klcApRk41vhjaFsd99b3TVdlCJ8L6pf2z
tzxYV3Ik8IHyEoFSrXYU8PvOtK4kGNad9Oid3IBSMCUY9NRkwIzmMVmpkYzqm9MO
i7tlyWD5Uc2rxI5FtqlTDBVTNZn0YH6r22Zk4y1Q//TkHYtbDDrnk3aifH7nmm72
A8NPSF4gUgCZ5xjbFwMMmmYS/qY3TzPQaxgeW9X3cpLc/unQy+Pk7RKkuI7idNRR
aUfjOppjhrQFBqVXBMn1
=w0x8
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--


--===============4754772764152055734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4754772764152055734==--
