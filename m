From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 06 Apr 2008 21:02:32 +0000
Subject: [lm-sensors] [PATCH] Use the current locale in sensors program
Message-Id: <20080406210232.GB31929@volta.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The previous patch fixed libsensors behaviour wrt locales, so I guess it
is now safe to use the current locale for all categories in the sensors=20
program. This includes LC_NUMERIC, so the values are printed using the
correct decimal separator wrt to the locale settings.


Index: prog/sensors/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/main.c	(r=E9vision 5168)
+++ prog/sensors/main.c	(copie de travail)
@@ -257,7 +257,7 @@
 		{ 0, 0, 0, 0 }
 	};
=20
-	setlocale(LC_CTYPE, "");
+	setlocale(LC_ALL, "");
=20
 	do_raw =3D 0;
 	do_sets =3D 0;

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
