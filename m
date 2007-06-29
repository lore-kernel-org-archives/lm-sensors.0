From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 17:00:35 +0000
Subject: [lm-sensors] Do we need regex in libsensors?
Message-Id: <20070629190035.36806ea8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all, hi Hans,

I've made a performance regression test on the new libsensors. It shows
a significant performance drop. Valgrind showed that almost half of the
total CPU cycles were spent in sensors_feature_get_type(), and in
particular in regexec(). Looking at what the code does, I don't think
that we need the power of the regex engine; sscanf() should be enough.
I've reimplemented the function using sscanf(), it seems to work just
fine, and is much faster (although not yet as fast as the original, but
I guess this is expected due to the dynamic feature gathering.)

Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(r=E9vision 4520)
+++ lib/access.c	(copie de travail)
@@ -20,7 +20,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <math.h>
-#include <regex.h>
 #include "access.h"
 #include "sensors.h"
 #include "data.h"
@@ -28,8 +27,6 @@
 #include "proc.h"
 #include "general.h"
=20
-#define GET_TYPE_REGEX "\\([[:alpha:]]\\{1,\\}\\)[[:digit:]]\\{0,\\}\\(_\\=
([[:alpha:]]\\{1,\\}\\)\\)\\{0,1\\}"
-
 static int sensors_do_this_chip_sets(sensors_chip_name name);
=20
 /* Compare two chips name descriptions, to see whether they could match.
@@ -541,11 +538,10 @@
 };
=20
 static struct feature_type_match matches[] =3D {=20
-	{ "temp", SENSORS_FEATURE_TEMP, temp_matches },
-	{ "in", SENSORS_FEATURE_IN, in_matches },
-	{ "fan", SENSORS_FEATURE_FAN, fan_matches },
-	{ "cpu", SENSORS_FEATURE_UNKNOWN, cpu_matches },
-	{ "vrm", SENSORS_FEATURE_VRM, 0 },
+	{ "temp%d%c", SENSORS_FEATURE_TEMP, temp_matches },
+	{ "in%d%c", SENSORS_FEATURE_IN, in_matches },
+	{ "fan%d%c", SENSORS_FEATURE_FAN, fan_matches },
+	{ "cpu%d%c", SENSORS_FEATURE_UNKNOWN, cpu_matches },
 	{ 0 }
 };
=20
@@ -553,39 +549,30 @@
 sensors_feature_type sensors_feature_get_type(
 	const sensors_feature_data *feature)
 {
-	regmatch_t pmatch[4];
-	int size_first, size_second, retval, i;
+	char c;
+	int i, nr, count;
 	struct feature_type_match *submatches;
-	static regex_t reg;
-	static regex_t *preg =3D NULL;
 =09
-	if (!preg) {
-		regcomp(&reg, GET_TYPE_REGEX, 0);
-		preg =3D &reg;
-	}
+	/* vrm is special */
+	if (!strcmp(feature->name, "vrm"))
+		return SENSORS_FEATURE_VRM;
 =09
-	retval =3D regexec(preg, feature->name, 4, pmatch, 0);
-=09
-	if (retval =3D -1)
-		return SENSORS_FEATURE_UNKNOWN;
-=09
-	size_first =3D pmatch[1].rm_eo - pmatch[1].rm_so;
-	size_second =3D pmatch[3].rm_eo - pmatch[3].rm_so;
-=09
 	for(i =3D 0; matches[i].name !=3D 0; i++)
-		if (!strncmp(feature->name, matches[i].name, size_first))
+		if ((count =3D sscanf(feature->name, matches[i].name, &nr, &c)))
 			break;
 =09
 	if (matches[i].name =3D NULL) /* no match */
 		return SENSORS_FEATURE_UNKNOWN;
-	else if (size_second =3D 0) /* single type */
+	else if (count =3D 1) /* single type */
 		return matches[i].type;
-	else if (matches[i].submatches =3D NULL) /* not single type, but no subma=
tches */
+
+	/* assert: count =3D 2 */
+	if (c !=3D '_')
 		return SENSORS_FEATURE_UNKNOWN;
=20
 	submatches =3D matches[i].submatches;
 	for(i =3D 0; submatches[i].name !=3D 0; i++)
-		if (!strcmp(feature->name + pmatch[3].rm_so, submatches[i].name))
+		if (!strcmp(strchr(feature->name, '_') + 1, submatches[i].name))
 			return submatches[i].type;
 =09
 	return SENSORS_FEATURE_UNKNOWN;

Is it OK to apply this, or does anyone have a good reason to believe
that sscanf() won't be sufficient in some (present or future) case?

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
