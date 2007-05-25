From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 13:47:50 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070525154750.21a78d2a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

Better late than never...

On Mon, 09 Apr 2007 17:20:52 +0200, Hans de Goede wrote:
> I've committed everything my students had written + some fixes done by me=
 after=20
> some initial testing to the 3.0.0 sensors branch.
>=20
> I claim in no way that this code is perfect, I did things this way to pro=
perly=20
> document / atrribute who wrote what, and to give us a starting point as I=
 think=20
> the code in general is ok. It needs testing and cleanups, but its not a b=
ad=20
> starting point perse.
>=20
> So please test this:
> 1) checkout the 3.0.0 branch:
>     svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors=
-3.0.0
> 2) comment the entries for your chips int he table at the end of lib/chip=
s.c
>     and in the table near the end of progs/sensors/main.c
> 3) compile and install as usual
> 4) run sensors and let me/us know how it works

I've tried that with my ADM1032 today, and this uncovered two problems.

First problem is the way the new library (and sensors) code handles
temperature hysteresis. It handles it as a "standard" temperature
limit, which it isn't. An hysteresis value is more like a property
of other temperature limit. So having a type named
SENSORS_FEATURE_TEMP_HYST doesn't make sense. We need, instead,
SENSORS_FEATURE_TEMP_MAX_HYST, and SENSORS_FEATURE_TEMP_CRIT_HYST.

Second problem is that the new code doesn't fill the magnitude when
creating the dynamic feature tables. It just happens to work in most
cases thanks to the general symbol name translation code, which
enforces standard magnitudes as a side effect. This doesn't work when
we had a dedicated symbol name translation rule for a given chip though
(which was the case for the hysteresis value of the lm90/adm1032)
because this rule is part of the chip-specific features table which we
drop when switching to the generic code. And the general symbol name
translation is bound to be deleted at some point too, so we shouldn't
rely on it.

Here is the patch I have come up with, which fixes both problems and
makes the generic code work for my ADM1032. Can you please review it and
confirm that it doesn't break anything on your side? Thanks.

Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(r=E9vision 4405)
+++ lib/sensors.h	(copie de travail)
@@ -166,14 +166,16 @@
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
   SENSORS_FEATURE_TEMP_FAULT,
   SENSORS_FEATURE_TEMP_SENS,
Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(r=E9vision 4405)
+++ lib/access.c	(copie de travail)
@@ -515,12 +515,14 @@
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
 	{ "fault", SENSORS_FEATURE_TEMP_FAULT },
 	{ "type", SENSORS_FEATURE_TEMP_SENS },
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
@@ -214,18 +203,14 @@
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
@@ -239,7 +224,7 @@
       if (valid) {
         print_label(label, label_size);
         free(label);
-        print_temp_info_real(max, min, 0, 0.0, type, 1, 0);
+        print_temp_info_real(max, min, 0, 0.0, type, 1, 1);
         printf("\n");
       }
     }


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
