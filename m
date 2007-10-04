From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Thu, 04 Oct 2007 18:38:39 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: List more Winbond chips
Message-Id: <20071004183839.GH32267@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8352833952035077079=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============8352833952035077079==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline


--TKDEsImF70pdVIl+
Content-Type: multipart/mixed; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here's a first patch to add some more recognized chips to the
sensors-detect output. No new IDs, just alternate names of existing
chips (which all have the same IDs).

More patches will follow.

Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--oyqLL/JqMvClXZi1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sensors-detect-winbond.patch"

List some more Winbond chips which can be detected with the same IDs.

Signed-off-by: Uwe Hermann <uwe@hermann-uwe.de>

Index: sensors-detect
===================================================================
--- sensors-detect	(Revision 4915)
+++ sensors-detect	(Arbeitskopie)
@@ -1921,20 +1921,20 @@
 	alias_detect => sub { vt1211_alias_detect(0, @_); },
       },
       {
-	name => "Winbond W83627HF Super IO Sensors",
+	name => "Winbond W83627HF/F/HG/G Super IO Sensors",
 	driver => "w83627hf",
 	devid => 0x52,
 	logdev => 0x0b,
 	alias_detect => sub { w83781d_alias_detect(3, @_); },
       },
       {
-	name => "Winbond W83627THF Super IO Sensors",
+	name => "Winbond W83627THF/THG Super IO Sensors",
 	driver => "w83627hf",
 	devid => 0x82,
 	logdev => 0x0b,
       },
       {
-	name => "Winbond W83637HF Super IO Sensors",
+	name => "Winbond W83637HF/HG Super IO Sensors",
 	driver => "w83627hf",
 	devid => 0x70,
 	logdev => 0x0b,
@@ -1946,19 +1946,19 @@
 	logdev => 0x0b,
       },
       {
-	name => "Winbond W83697HF Super IO Sensors",
+	name => "Winbond W83697HF/F/HG Super IO Sensors",
 	driver => "w83627hf",
 	devid => 0x60,
 	logdev => 0x0b,
       },
       {
-	name => "Winbond W83697SF/UF Super IO PWM",
+	name => "Winbond W83697SF/UF/UG Super IO PWM",
 	driver => "to-be-written",
 	devid => 0x68,
 	logdev => 0x0b,
       },
       {
-	name => "Winbond W83627EHF/EHG Super IO Sensors",
+	name => "Winbond W83627EHF/EF/EHG/EG Super IO Sensors",
 	driver => "w83627ehf",
 	# W83627EHF datasheet says 0x886x but 0x8853 was seen, thus the
 	# broader mask. W83627EHG was seen with ID 0x8863.
@@ -1976,7 +1976,7 @@
 	alias_detect => sub { w83781d_alias_detect(10, @_); },
       },
       {
-	name => "Winbond W83L517D Super IO",
+	name => "Winbond W83L517D/D-F Super IO",
 	driver => "not-a-sensor",
 	devid => 0x61,
       },

--oyqLL/JqMvClXZi1--

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBTMvXdVoV3jWIbQRAi/MAJ9TPPOgB1BXWTffw2uHSwU5fPVeQACfSxDs
r+pNJiAfVL4EWv3opH08jxI=
=GUt2
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--


--===============8352833952035077079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8352833952035077079==--
