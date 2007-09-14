From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 14 Sep 2007 19:29:24 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Update
Message-Id: <20070914192924.GL30825@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5146418599325003695=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164905.GM32667@tree.beaverton.ibm.com> <20070828232504.GP32667@tree.beaverton.ibm.com> <20070911132335.GJ31992@jupiter.solarsys.private>
In-Reply-To: <20070911132335.GJ31992@jupiter.solarsys.private>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com


--===============5146418599325003695==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update the hwmon sysfs interface documentation to include a specification
for power meters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/sysfs-interface |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysf=
s-interface
index db7bb4a..5c98bee 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -324,6 +324,36 @@ curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
=20
+*********
+* Power *
+*********
+
+power[1-*]_average		Average power use
+				Unit: microWatt
+				RO
+
+power[1-*]_average_highest	Historical average maximum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_average_lowest	Historical average minimum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input		Instantaneous power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input_highest	Historical maximum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input_lowest		Historical minimum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_high_low_reset	Reset input_highest/input_lowest.
+				WO
=20
 **********
 * Alarms *

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6uEUa6vRYYgWQuURAu7hAKCgo38PuKtHR8aMr41isnLrPYCNpwCePeZ0
NgcIiQisomwA2To2YHdn/nk=
=W2WX
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--


--===============5146418599325003695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5146418599325003695==--
