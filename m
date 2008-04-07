From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Apr 2008 20:03:55 +0000
Subject: Re: [lm-sensors] [PATCH] Parse the configuration file in C locale
Message-Id: <20080407220355.581580d8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406205839.GA31929@volta.aurel32.net>
In-Reply-To: <20080406205839.GA31929@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Aur=E9lien,

On Sun, 6 Apr 2008 22:58:39 +0200, Aurelien Jarno wrote:
> The configuration file is currently parsed in the locale set by the main
> program using the library. This means that if the decimal separator
> (defined in LC_NUMERIC) is not '.' the values in the compute lines are
> truncated. This happens for example with sensors-applet and a French
> locale.

Good catch.

>=20
> The patch below is an attempt to fix that. There may be more clever ways
> to do that, but currently I fail to find them.
>=20
>=20
> Index: lib/init.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- lib/init.c	(r=E9vision 5168)
> +++ lib/init.c	(copie de travail)
> @@ -19,6 +19,7 @@
>      MA 02110-1301 USA.
>  */
> =20
> +#include <locale.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -37,6 +38,7 @@
>  int sensors_init(FILE *input)
>  {
>  	int res;
> +	char *locale =3D NULL;
> =20
>  	if (!sensors_init_sysfs())
>  		return -SENSORS_ERR_KERNEL;
> @@ -44,6 +46,13 @@
>  	    (res =3D sensors_read_sysfs_chips()))
>  		goto exit_cleanup;
> =20
> +	/* Read the current locale */
> +	locale =3D setlocale(LC_NUMERIC, NULL);
> +	if (locale)
> +		locale =3D strdup(locale);
> +	/* Set the locale to C */
> +	setlocale(LC_NUMERIC, "C");
> +
>  	res =3D -SENSORS_ERR_PARSE;
>  	if (input) {
>  		if (sensors_scanner_init(input) ||
> @@ -64,11 +73,21 @@
>  		}
>  	}
> =20
> +	/* Restore the old locale */
> +	if (locale) {
> +		setlocale(LC_NUMERIC, locale);
> +		free(locale);
> +	}
>  	if ((res =3D sensors_substitute_busses()))
>  		goto exit_cleanup;
>  	return 0;
> =20
>  exit_cleanup:
> +	/* Restore the old locale */
> +	if (locale) {
> +		setlocale(LC_NUMERIC, locale);
> +		free(locale);
> +	}
>  	sensors_cleanup();
>  	return res;
>  }
>=20

I've come up with a variant where we don't need to duplicate the
clear-up step in the error path:

---
 lib/init.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

--- lib/init.c.orig	2008-04-07 21:32:53.000000000 +0200
+++ lib/init.c	2008-04-07 21:48:18.000000000 +0200
@@ -19,8 +19,10 @@
     MA 02110-1301 USA.
 */
=20
+#include <locale.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <errno.h>
 #include "sensors.h"
 #include "data.h"
@@ -34,6 +36,31 @@
 #define DEFAULT_CONFIG_FILE	ETCDIR "/sensors3.conf"
 #define ALT_CONFIG_FILE		ETCDIR "/sensors.conf"
=20
+/* Wrapper around sensors_yyparse(), which clears the locale so that
+   the decimal numbers are always parsed properly. */
+static int sensors_parse(void)
+{
+	int res;
+	char *locale;
+
+	/* Remember the current locale and clear it */
+	locale =3D setlocale(LC_ALL, NULL);
+	if (locale) {
+		locale =3D strdup(locale);
+		setlocale(LC_ALL, "C");
+	}
+
+	res =3D sensors_yyparse();
+
+	/* Restore the old locale */
+	if (locale) {
+		setlocale(LC_ALL, locale);
+		free(locale);
+	}
+
+	return res;
+}
+
 int sensors_init(FILE *input)
 {
 	int res;
@@ -47,7 +74,7 @@ int sensors_init(FILE *input)
 	res =3D -SENSORS_ERR_PARSE;
 	if (input) {
 		if (sensors_scanner_init(input) ||
-		    sensors_yyparse())
+		    sensors_parse())
 			goto exit_cleanup;
 	} else {
 		/* No configuration provided, use default */
@@ -56,7 +83,7 @@ int sensors_init(FILE *input)
 			input =3D fopen(ALT_CONFIG_FILE, "r");
 		if (input) {
 			if (sensors_scanner_init(input) ||
-			    sensors_yyparse()) {
+			    sensors_parse()) {
 				fclose(input);
 				goto exit_cleanup;
 			}

I've also changed LC_NUMERIC for LC_ALL, as discussed on IRC. Otherwise
it's the same as your original patch.

I'll apply this patch tomorrow if nobody objects.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
