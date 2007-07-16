From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 22:11:11 +0000
Subject: [lm-sensors] [PATCH] adt7470: Increase refresh interval to 5s
Message-Id: <20070716221111.GE2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4181097555786845512=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============4181097555786845512==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Increase interval between sensor refreshes to 5s.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index d31e023..33a66ac 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -105,7 +105,7 @@ I2C_CLIENT_INSMOD_1(adt7470);
 /* "all temps" according to hwmon sysfs interface spec */
 #define ADT7470_PWM_ALL_TEMPS	0x3FF
=20
-#define REFRESH_INTERVAL	(2 * HZ)
+#define REFRESH_INTERVAL	(5 * HZ)
=20
 /* sleep 1s while gathering temperature data */
 #define TEMP_COLLECTION_TIME	1000

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm+z/a6vRYYgWQuURAg3qAKCKHyOMxjDBmo4yzZaIWygUE5GShwCeNZoN
jJER/0s+2QQjZzt6zeBLIQA=
=IV0s
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--


--===============4181097555786845512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4181097555786845512==--
