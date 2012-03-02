From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 21:45:00 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.3-rc6
Message-Id: <20120302214459.GA25716@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7554935112067699949=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============7554935112067699949==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.3-rc6 from tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

These patches are necessary for correct operation and management of F75387.

Thanks,
Guenter

------

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Nikolaus Schulz (4):
      hwmon: (f75375s) Fix writes to the pwm* attribute for the F75387
      hwmon: (f75375s) Make pwm*_mode writable for the F75387
      hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
      hwmon: (f75375s) Catch some attempts to write to r/o registers

 drivers/hwmon/f75375s.c |   89 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 75 insertions(+), 14 deletions(-)

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUT9bAAoJEMsfJm/On5mBVN0P/Rw7msLmnTYOkrAQaLdy1FX4
rDhTNF008T9+2FrnKpANy+PfTb6rIQ+I7WSRYqTUewxnavHmqFEaB18dDe1yxdgq
3kytmK+GNIWMdhlSLaKJ1rILbDNfZYvI1Lu1wKq7qRhx8bwTC12hevvUpNp0zdC8
hv8uEmgj41dRHYRaIxd59MQ94AdXwpmRMvDa2c4NvsxpBXf2n8V7MYKtet31+T1s
VzcqmMQuJzFaa7BmABvE1mkmpTegWXdC90J1LkcVsI0LibsiN5mQIJ591XANgpI6
12GyFEnaYKGww0PoOgLlSBmlCYhtsPGwMOuV3wZp2VCCfSFaGwi/8rIFFY1bEl7l
Clx3IIKzp84GaIkUh+8rXxBasw4VSPyriRnjKdUMYe+/pL26HtNArr9AChSnl8tm
gM4I4IEMYRsPKVxbsVIPTXTzlsLKeNSVJRiDtzVFps47b4opSiS6pXFrNLyLCpWy
yBrdI1TwjSsGgCvB6McrJnBj3XEDiT2e3f37pLCFfm/8iDuTaoY434NiwYDwK0ME
eA9Uf0qk8q7Q3bqMPlKFsw34B0dPlvsaVtpJnumYU3uHohM8m1Byk/LCKxsJBMpk
xD3VOtKo5ADU7GSnYVEeQm/YwjTYCjvpN7RbkW7oinA/YpDJT9vvZLo/XTdBZ7vu
UTagy8rI5KgqkaYjjppq
=Ttqq
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


--===============7554935112067699949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7554935112067699949==--
