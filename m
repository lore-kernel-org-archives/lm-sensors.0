From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Feb 2012 03:43:49 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.3-rc4
Message-Id: <20120210034349.GA31275@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0478855482279875543=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============0478855482279875543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.3-rc4 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

hwmon-for-linus is a signed tag.

Couple of regressions, couple of zero-day bugs, a minor enhancement.
Nothing really major.

Thanks,
Guenter

------

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Guenter Roeck (1):
      hwmon: (w83627ehf) Remove duplicate code

Nikolaus Schulz (4):
      hwmon: (f75375s) Fix automatic pwm mode setting for F75373 & F75375
      hwmon: (f75375s) Fix reading of wrong register when initializing the F75387
      hwmon: (f75375s) Fix bit shifting in f75375_write16
      hwmon: (f75375s) Let f75375_update_device treat pwmX as a measured value

 drivers/hwmon/f75375s.c   |   11 +++++------
 drivers/hwmon/w83627ehf.c |    5 -----
 2 files changed, 5 insertions(+), 11 deletions(-)

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNJJ1AAoJEMsfJm/On5mBk+AP/3U+FkcBWXQC+vEM60w/B+ae
/MQgzY88xnQU0PXQoLKjqMbT4GFNAM4oaqkP+NPT1EGjBsSswXzH/F0g+ybiO/7j
zj5G9Yn527B18RrXujCudgpvXdJ5PJvhOA4D0OgHJ7yYUfAwyxLd/nKaTEJwhbFv
4xNyOsc0hnxeQ+VcOBhgg7xojaBCZSzodWMDE8DxXxgF29Z2I9/c5r7EhaJ/gJIk
GVlaClj4f/6q7t5ECziioxg4eFgc7Uja2ybfeoK8OZ904/TyvZpDlZfAuTff/Zjf
fEh+c/lhg+5iuLaiH0oPFc0v+0NsAH9atb1bW3JI9sUUdjTygiWGkibL32CfSG5o
sIkQ5L7pvzY8ffO79sf1TVXUt2jH2zUlMvG+zUR+w7vK509ybUUVtbSUvSYbWIgV
fJPjDDV5rPED1V7KYHjjUpFmYS3tfSOyUiQIbUpWRZpQbpDWOt8D2wSLgeiiuPSm
/T7MaHhhxkTZqVk46ZQspzqNeesHzbBGPWh652NoS82w5xiaR/6FFuhUFu6tP1Xj
qWZs6Y8xIS6ozXw+P2Z7bMr+HkMccPTrTTNpqh2VLsxIOVjL5oqixxAjFScK9I6Q
tLq3MKjRH2jRivncCq27BPnMz+rQldxF7eST6f3ddb8KyjLe/Mx6I617fu08DzgT
Ox/BegX0acEmHc0QvCG6
=wU+g
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--


--===============0478855482279875543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0478855482279875543==--
