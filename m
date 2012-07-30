From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jul 2012 01:17:46 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.6-rc1
Message-Id: <20120730011746.GA20149@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5894535419632610753=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============5894535419632610753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.6-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

The branch is based on an arbitrary commit in your tree. This was necessary
because one of the patches fixes a newly introduced build warning.

Thanks,
Guenter
------

The following changes since commit 25918f9811eae1d657db2bccdfcb077038d9454c:

  Merge tag 'fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-07-26 20:29:52 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 829917cd7246204d6c5f066c40b66d2b62d0930d:

  hwmon: (applesmc) Decode and act on read/write status codes (2012-07-27 14:00:12 -0700)

----------------------------------------------------------------
Fix timing problems in applesmc driver
Improve device removal in jc42 driver
Fix build warning in acpi_power_meter driver

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (acpi_power_meter) Fix build warning

Henrik Rydberg (1):
      hwmon: (applesmc) Decode and act on read/write status codes

Jean Delvare (2):
      hwmon: (jc42) Simplify hysteresis mask
      hwmon: (jc42) Don't reset hysteresis on device removal

 drivers/hwmon/acpi_power_meter.c |    4 +++
 drivers/hwmon/applesmc.c         |   70 +++++++++++++++++++++++++-------------
 drivers/hwmon/jc42.c             |   26 ++++++++------
 3 files changed, 66 insertions(+), 34 deletions(-)

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQFeC6AAoJEMsfJm/On5mBY4gQAKHxfS67P18K4zq50la15bqt
QUyqPA+FBWK8+GX8q+cDzTNdAroejpbW65qqjp5qK0rmbNVJJ2+UscgIUhBqpoXp
zBvCQeK+JHNjU3CgLgl9IEj9Gxsa+KRGKwZ7QhfHu5pHVp3VBchvDIdrFIsE33dX
L19Gdt/k2zxtHhHK8SWuuJk0KY9tTBf+6sLEQYHb55zAgTFoQ6nLaTQX0bN0KApz
EUdSbrJZPqffXWfG18yNmBaVKoxZ9n5yYtiGE7rIG+fNasHl3N7215cYbwPK88xP
lpj/51YHmtm2pYW1NiTPPCQu31iwjkPbFWKb9ai88x7iNuL6ki4yPqVeEV1LmwMd
fJX5TNTdlN3sVq6QMisyyFizRHRvQvg7MtPfqXO71eo/5vN/1QLgnXT7Gc7NSUHO
Jh5hYZ22nWpPXnk/1wZks3hzKc8a8nUcoDirEdtHTLCur1nSJqitJTDB9BlyQemn
6xR5qJLq1vAh5H7WvlxJBZpqmwqOFu0ZmmQMDK/Gzue0Zt576h5U1R217xERlrUZ
4w0yPi3LPE+AoEHty49VJxQp2BUaYOSDffu1Sr8KafKr8rdYy3b8FBQrWvytpe+N
fXQfTwJMKt00T1wheHqDuRQPzSBa9QpkIdbkZtddxBhgFixDSS/EC4h/iEH7cThZ
G4aU0NBUyNUgs9ktkr3c
=jJzw
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============5894535419632610753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5894535419632610753==--
