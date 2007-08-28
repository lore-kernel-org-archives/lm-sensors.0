From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 28 Aug 2007 16:44:40 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070828164440.GL32667@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3050139335805739673=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare>
In-Reply-To: <20070828131942.18449886@hyperion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============3050139335805739673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update the hwmon sysfs interface documentation to include a specification
for power meters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/sysfs-interface |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysf=
s-interface
index b3a9e1b..da546ce 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -304,6 +304,21 @@ curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
=20
+*********
+* Power *
+*********
+
+power[1-*]_input	Current power use
+			Unit: milliWatt
+			RO
+
+power[1-*]_max_input	Historical maximum power use
+			Unit: milliWatt
+			RO
+
+power[1-*]_min_input	Historical minimum power use
+			Unit: milliWatt
+			RO
=20
 **********
 * Alarms *

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1FD4a6vRYYgWQuURAmRjAKCOEumX1dcUVMpbMBm7PANfM5KKfQCgjH2w
inT5ba/UK4ihIWJ/LUKYC0U=
=1aoj
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--


--===============3050139335805739673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3050139335805739673==--
