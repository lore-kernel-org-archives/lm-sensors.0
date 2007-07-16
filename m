From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 23:07:24 +0000
Subject: [lm-sensors] [PATCH] adt7470: Temperatures should be signed
Message-Id: <20070716230724.GG2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7910284016699511121=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============7910284016699511121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2007 at 03:19:04PM -0700, Philip Pokorny wrote:
> The values 0x81 and 0x7f are *signed* 8 bit quantities.  0x81 whould be c=
onsidered -127

Ah yes, excellent point.  Here's a patch to correct that.

---
adt7470: Temperature sensors are signed quantities

Philip Pokorny points out that the temperature sensors are signed
quantities, hence the anomalous looking readings reported by Vadim
Zeitlin.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 33a66ac..75aee3b 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -125,9 +125,9 @@ struct adt7470_data {
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
=20
-	u8			temp[ADT7470_TEMP_COUNT];
-	u8			temp_min[ADT7470_TEMP_COUNT];
-	u8			temp_max[ADT7470_TEMP_COUNT];
+	s8			temp[ADT7470_TEMP_COUNT];
+	s8			temp_min[ADT7470_TEMP_COUNT];
+	s8			temp_max[ADT7470_TEMP_COUNT];
 	u16			fan[ADT7470_FAN_COUNT];
 	u16			fan_min[ADT7470_FAN_COUNT];
 	u16			fan_max[ADT7470_FAN_COUNT];
@@ -137,7 +137,7 @@ struct adt7470_data {
 	u8			pwm_max[ADT7470_PWM_COUNT];
 	u8			pwm_automatic[ADT7470_PWM_COUNT];
 	u8			pwm_min[ADT7470_PWM_COUNT];
-	u8			pwm_tmin[ADT7470_PWM_COUNT];
+	s8			pwm_tmin[ADT7470_PWM_COUNT];
 	u8			pwm_auto_temp[ADT7470_PWM_COUNT];
 };
=20

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm/osa6vRYYgWQuURAhIAAJ4gPp4pLV7IwGmGq4F4lyBJBr1bcQCfUjir
YNbrV25rN9XIbgf+4lgv4Ko=
=+N+o
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--


--===============7910284016699511121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7910284016699511121==--
