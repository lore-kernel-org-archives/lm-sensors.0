From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 19 Oct 2012 18:40:35 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.7-rc2
Message-Id: <20121019184035.GA7287@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1793428215730416239=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============1793428215730416239==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.7-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 1102dcab849313bd5a340b299b5cf61b518fbc0f:

  hwmon: (coretemp) Add support for Atom CE4110/4150/4170 (2012-10-14 15:21:33 -0700)

----------------------------------------------------------------
Drop some leftover dependencies on CONFIG_EXPERIMENTAL,
and add support for Intel Atom CE4110/4150/4170.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (coretemp) Add support for Atom CE4110/4150/4170

Kees Cook (2):
      hwmon: (pmbus) remove CONFIG_EXPERIMENTAL
      Documentation/hwmon: remove CONFIG_EXPERIMENTAL

 Documentation/hwmon/coretemp           |    1 +
 Documentation/hwmon/submitting-patches |    3 +--
 drivers/hwmon/coretemp.c               |    7 +++++--
 drivers/hwmon/pmbus/Kconfig            |    2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQgZ6iAAoJEMsfJm/On5mBtVYP/RJPyk5d/3ApIM8iCun2ZHBY
rKe0CefH7Uj/tJa3t9mwISzGmD1nPs/WrO0pqpku1FBSWF/8RScpUtd9UwJRZJ52
+hGpo6F29/uc/iLyup79UzCWTPi0CgrE+gFo010nQmZvJ67W7KgFWS/7Kehq612W
tJJkNQDqJ8da7xW9lhv1N45KTlhZw/rRKGlqWJ98BvTLe1ORSlPQn1Tr8NEglp9M
HDlW4RRyDAnduhIG/O3hzuQILm18zk+fdWvyJp63AuWfChS77yVT/Cp4bOoJHXhC
mB2yV/HThp6wRvibKoZTtprmW9KHVd3Fr5m3N2maHI8K241/W0bQdtOXv3oboCPw
wpHXuWMGfQN33gQ/RyTzn1MDuBjmdk7ZgyDIBTsgrvJHROfSS7NwvYSLnZKT7e6U
I4Pfl+5KFQeR81UE4mNrvclEy2jdny4zrpwPFG9xjzo0i7mLoUu4bKGp6MIhV5V6
60/RBz32xGRfYzeLRMHFNQBQtAoMI0Vl1GTiWPNC4dAAipB9SYHahaXEVoHrUJ8M
um9xiy7D2q3jUCHNzo7NekQ6/n4vsJn2EEI+FE8P55JTvYYL5IcFXk51TvCQPboJ
woHUbmRT08GYZ29f4c8QFoNj6SUi3juTO3ZrIPrSZo6ceMyVn6hy7Ap3MCmyc57m
rVZFtLBR+g1dc3vIQ3H3
=J6xN
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


--===============1793428215730416239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1793428215730416239==--
