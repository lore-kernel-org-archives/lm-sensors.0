From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 14:58:24 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070525165824.77ea91bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 25 May 2007 15:47:50 +0200, Jean Delvare wrote:
> Here is the patch I have come up with, which fixes both problems and
> makes the generic code work for my ADM1032. Can you please review it and
> confirm that it doesn't break anything on your side? Thanks.

I spoke a bit too fast. There was actually a third problem, alarms
weren't reported. This is because the ADM1032 has per-limit alarm flags
and the generic code only supported per-channel alarms for temperatures.

So here is a more complete patch which fixes all three problems.

Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(r=E9vision 4405)
+++ lib/sensors.h	(copie de travail)
@@ -166,15 +166,20 @@
   SENSORS_FEATURE_FAN_DIV,
  =20
   SENSORS_FEATURE_TEMP =3D 0x200,
-  SENSORS_FEATURE_TEMP_HYST,
   SENSORS_FEATURE_TEMP_OVER,
   SENSORS_FEATURE_TEMP_MAX,
+  SENSORS_FEATURE_TEMP_MAX_HYST,
   SENSORS_FEATURE_TEMP_MIN,
+  SENSORS_FEATURE_TEMP_MIN_HYST,
   SENSORS_FEATURE_TEMP_HIGH,
   SENSORS_FEATURE_TEMP_LOW,
   SENSORS_FEATURE_TEMP_LIM,
   SENSORS_FEATURE_TEMP_CRIT,
+  SENSORS_FEATURE_TEMP_CRIT_HYST,
   SENSORS_FEATURE_TEMP_ALARM =3D 0x210,
+  SENSORS_FEATURE_TEMP_MAX_ALARM,
+  SENSORS_FEATURE_TEMP_MIN_ALARM,
+  SENSORS_FEATURE_TEMP_CRIT_ALARM,
   SENSORS_FEATURE_TEMP_FAULT,
   SENSORS_FEATURE_TEMP_SENS,
  =20
@@ -185,7 +190,7 @@
  =20
   /* special the largest number of subfeatures used, iow the=20
      highest ## from all the 0x?## above + 1*/
-  SENSORS_FEATURE_MAX_SUB_FEATURES =3D 19
+  SENSORS_FEATURE_MAX_SUB_FEATURES =3D 22
 } sensors_feature_type;
=20
 sensors_feature_type sensors_feature_get_type
Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(r=E9vision 4405)
+++ lib/access.c	(copie de travail)
@@ -515,13 +515,18 @@
 };
=20
 static struct feature_type_match temp_matches[] =3D {
-	{ "hyst", SENSORS_FEATURE_TEMP_HYST },
 	{ "over", SENSORS_FEATURE_TEMP_OVER },
 	{ "max", SENSORS_FEATURE_TEMP_MAX },
+	{ "max_hyst", SENSORS_FEATURE_TEMP_MAX_HYST },
 	{ "min", SENSORS_FEATURE_TEMP_MIN },
+	{ "min_hyst", SENSORS_FEATURE_TEMP_MIN_HYST },
 	{ "low", SENSORS_FEATURE_TEMP_LOW },
 	{ "crit", SENSORS_FEATURE_TEMP_CRIT },
+	{ "crit_hyst", SENSORS_FEATURE_TEMP_CRIT_HYST },
 	{ "alarm", SENSORS_FEATURE_TEMP_ALARM },
+	{ "min_alarm", SENSORS_FEATURE_TEMP_MIN_ALARM },
+	{ "max_alarm", SENSORS_FEATURE_TEMP_MAX_ALARM },
+	{ "crit_alarm", SENSORS_FEATURE_TEMP_CRIT_ALARM },
 	{ "fault", SENSORS_FEATURE_TEMP_FAULT },
 	{ "type", SENSORS_FEATURE_TEMP_SENS },
 	{ 0 }
Index: lib/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.c	(r=E9vision 4405)
+++ lib/sysfs.c	(copie de travail)
@@ -37,6 +37,29 @@
=20
 #define MAX_SENSORS_PER_TYPE 16
=20
+static
+int get_type_scaling(int type)
+{
+	switch (type & 0xFF10) {
+	case SENSORS_FEATURE_IN:
+	case SENSORS_FEATURE_TEMP:
+		return 3;
+	case SENSORS_FEATURE_FAN:
+		return 0;
+	}
+
+	switch (type) {
+	case SENSORS_FEATURE_VID:
+		return 3;
+	case SENSORS_FEATURE_VRM:
+		return 1;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static=20
 sensors_chip_features sensors_read_dynamic_chip(struct sysfs_device *sysdi=
r)
 {
@@ -149,6 +172,8 @@
 			SENSORS_MODE_R : (attr->method & SYSFS_METHOD_STORE) ?
 			SENSORS_MODE_W : SENSORS_MODE_NO_RW;
=20
+		feature.scaling =3D get_type_scaling(type);
+
 		features[i] =3D feature;
 		fnum++;
 	}
Index: prog/sensors/chips_generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/chips_generic.c	(r=E9vision 4405)
+++ prog/sensors/chips_generic.c	(copie de travail)
@@ -144,27 +144,16 @@
       } else {
         type =3D MINMAX;
       }
+    } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX_HYST)) {
+      min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX_HYST);
+      type =3D HYST;
     } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_CRIT)) {
       min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_CRIT);
       type =3D CRIT;
-    } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_HYST)) {
-      min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_HYST);
-      type =3D HYST;
     } else {
       min =3D 0;
       type =3D MAXONLY;
     }
-  } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_HYST)) {
-    min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_HYST);
-   =20
-    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_OVER)) {
-      max =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_OVER);
-      type =3D HYST;
-    } else {
-      max =3D min;
-      max =3D 0;
-      type =3D HYSTONLY;
-    }
   } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_LOW)) {
     min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_LOW);
    =20
@@ -208,24 +197,27 @@
   if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_FAULT) &&
       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_FAULT) > 0.5) {
     printf(" FAULT");
-  } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
-      TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5) {
+  } else
+  if ((TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
+       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5)
+   || (type =3D MINMAX &&
+       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MIN_ALARM) &&=20
+       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MIN_ALARM) > 0.5)
+   || (type =3D MINMAX &&
+       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX_ALARM) &&=20
+       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX_ALARM) > 0.5)) {
     printf(" ALARM");
   }
   printf("\n");
  =20
-  if (type =3D MINMAX && TEMP_FEATURE(SENSORS_FEATURE_TEMP_CRIT))
+  if (type !=3D CRIT && TEMP_FEATURE(SENSORS_FEATURE_TEMP_CRIT))
   {
     const sensors_feature_data *subfeature;
     max =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_CRIT);
    =20
-    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_HYST)) {
-      min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_HYST);
+    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_CRIT_HYST)) {
+      min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_CRIT_HYST);
       type =3D HYSTONLY;
-    } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX) &&=20
-        !TEMP_FEATURE(SENSORS_FEATURE_TEMP_MIN)) {
-      min =3D TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX);
-      type =3D HYSTONLY;
     } else {
       type =3D SINGLE;
       min =3D 0.0;
@@ -239,7 +231,11 @@
       if (valid) {
         print_label(label, label_size);
         free(label);
-        print_temp_info_real(max, min, 0, 0.0, type, 1, 0);
+        print_temp_info_real(max, min, 0, 0.0, type, 1, 1);
+        if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_CRIT_ALARM) &&
+            TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_CRIT_ALARM) > 0.5) {
+          printf(" ALARM");
+        }
         printf("\n");
       }
     }

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
