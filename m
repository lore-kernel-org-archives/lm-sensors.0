From: Christian Krafft <krafft@de.ibm.com>
Date: Thu, 10 Apr 2008 15:11:11 +0000
Subject: [lm-sensors] [Patch] lm-sensors crash on non x86 hardware
Message-Id: <20080410171111.3f275bcb@de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4809081431670293955=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4809081431670293955==
Content-Type: multipart/signed; boundary="Sig_/wuY+6ZoL.=ofHBSQwm9rJJG";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/wuY+6ZoL.=ofHBSQwm9rJJG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Please consider this tiny patch for inclusion.
It provides the user with more precise info.

Index: lm_sensors-2.10.0/prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lm_sensors-2.10.0.orig/prog/detect/sensors-detect
+++ lm_sensors-2.10.0/prog/detect/sensors-detect
@@ -5153,7 +5153,7 @@ sub main
=20
   print "\nSome chips are also accessible through the ISA bus. ISA probes =
are\n".
         "typically a bit more dangerous, as we have to write to I/O ports =
to do\n".
-        "this. This is usually safe though.\n\n";
+        "this. This is usually safe on x86 acrhitecture.\n\n";
   if ($> !=3D 0) {
     print "As you are not root, we shall skip this step.\n";
   } else {
@@ -5167,7 +5167,7 @@ sub main
=20
   print "\nSome Super I/O chips may also contain sensors. Super I/O probes=
 are\n".
         "typically a bit more dangerous, as we have to write to I/O ports =
to do\n".
-        "this. This is usually safe though.\n\n";
+        "this. This is usually safe on x86 acrhitecture.\n\n";
   if ($> !=3D 0) {
     print "As you are not root, we shall skip this step.\n";
   } else {


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/wuY+6ZoL.=ofHBSQwm9rJJG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFH/i4t6rqK4qDx+dcRAu0TAJ90DroTcy870+xooBSWFjPlsUVqZgCggZie
LQubAJYbDED3McoqqCGacuQ=
=PdbZ
-----END PGP SIGNATURE-----

--Sig_/wuY+6ZoL.=ofHBSQwm9rJJG--


--===============4809081431670293955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4809081431670293955==--
