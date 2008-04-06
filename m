From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 06 Apr 2008 20:58:39 +0000
Subject: [lm-sensors] [PATCH] Parse the configuration file in C locale
Message-Id: <20080406205839.GA31929@volta.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The configuration file is currently parsed in the locale set by the main
program using the library. This means that if the decimal separator
(defined in LC_NUMERIC) is not '.' the values in the compute lines are
truncated. This happens for example with sensors-applet and a French
locale.

The patch below is an attempt to fix that. There may be more clever ways
to do that, but currently I fail to find them.


Index: lib/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/init.c	(r=E9vision 5168)
+++ lib/init.c	(copie de travail)
@@ -19,6 +19,7 @@
     MA 02110-1301 USA.
 */
=20
+#include <locale.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
@@ -37,6 +38,7 @@
 int sensors_init(FILE *input)
 {
 	int res;
+	char *locale =3D NULL;
=20
 	if (!sensors_init_sysfs())
 		return -SENSORS_ERR_KERNEL;
@@ -44,6 +46,13 @@
 	    (res =3D sensors_read_sysfs_chips()))
 		goto exit_cleanup;
=20
+	/* Read the current locale */
+	locale =3D setlocale(LC_NUMERIC, NULL);
+	if (locale)
+		locale =3D strdup(locale);
+	/* Set the locale to C */
+	setlocale(LC_NUMERIC, "C");
+
 	res =3D -SENSORS_ERR_PARSE;
 	if (input) {
 		if (sensors_scanner_init(input) ||
@@ -64,11 +73,21 @@
 		}
 	}
=20
+	/* Restore the old locale */
+	if (locale) {
+		setlocale(LC_NUMERIC, locale);
+		free(locale);
+	}
 	if ((res =3D sensors_substitute_busses()))
 		goto exit_cleanup;
 	return 0;
=20
 exit_cleanup:
+	/* Restore the old locale */
+	if (locale) {
+		setlocale(LC_NUMERIC, locale);
+		free(locale);
+	}
 	sensors_cleanup();
 	return res;
 }

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
