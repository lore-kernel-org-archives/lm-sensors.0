From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 25 Jul 2006 04:13:58 +0000
Subject: [lm-sensors] [RFC PATCH] lib/access.c optimization
Message-Id: <20060725041358.GB12109@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi:

The following patch shaves about 8% off the execution time of 'sensors -u'
on my workstation (2645586 cycles before vs. 2430821 cycles after).

Can I please get an ACK on this patch before I commit it?  Thanks.

Measurement method:
	(build/install lm-sensors userspace with DEBUG=3D1 to get -g)
	valgrind --tool=CAllgrind sensors -u
	kcachegrind callgrind.out.NNNN


Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(revision 4073)
+++ lib/access.c	(working copy)
@@ -84,22 +84,44 @@
 	return NULL;
 }
=20
+static const sensors_chip_feature *sensors_lookup_features(const char *pre=
fix)
+{
+	static int cache =3D 0;
+	int ii =3D cache;
+
+	if (!strcasecmp(sensors_chip_features_list[ii].prefix, prefix))
+		return sensors_chip_features_list[ii].feature;
+
+	for (ii =3D 0; sensors_chip_features_list[ii].prefix; ii++)
+		if (!strcasecmp(sensors_chip_features_list[ii].prefix, prefix)){
+			cache =3D ii;
+			return sensors_chip_features_list[ii].feature;
+		}
+
+	return NULL;
+}
+
 /* Look up a resource in the intern chip list, and return a pointer to it.=
=20
    Do not modify the struct the return value points to! Returns NULL if=20
    not found.*/
 const sensors_chip_feature *sensors_lookup_feature_nr(const char *prefix,
 						      int feature)
 {
-	int i, j;
-	const sensors_chip_feature *features;
+	static int cache =3D 0;
+	int ii =3D cache;
+	const sensors_chip_feature *features =3D sensors_lookup_features(prefix);
=20
-	for (i =3D 0; sensors_chip_features_list[i].prefix; i++)
-		if (!strcasecmp(sensors_chip_features_list[i].prefix, prefix)) {
-			features =3D sensors_chip_features_list[i].feature;
-			for (j =3D 0; features[j].name; j++)
-				if (features[j].number =3D feature)
-					return features + j;
-		}
+	if (features) {
+		if (features[ii].number =3D feature)
+			return features + ii;
+
+		for (ii =3D 0; features[ii].name; ii++)
+			if (features[ii].number =3D feature) {
+				cache =3D ii;
+				return features + ii;
+			}
+
+	}
 	return NULL;
 }
=20
@@ -109,16 +131,20 @@
 const sensors_chip_feature *sensors_lookup_feature_name(const char *prefix,
 							const char *feature)
 {
-	int i, j;
-	const sensors_chip_feature *features;
+	static int cache =3D 0;
+	int ii =3D cache;
+	const sensors_chip_feature *features =3D sensors_lookup_features(prefix);
=20
-	for (i =3D 0; sensors_chip_features_list[i].prefix; i++)
-		if (!strcasecmp(sensors_chip_features_list[i].prefix, prefix)) {
-			features =3D sensors_chip_features_list[i].feature;
-			for (j =3D 0; features[j].name; j++)
-				if (!strcasecmp(features[j].name, feature))
-					return features + j;
-		}
+	if (features) {
+		if (!strcasecmp(features[ii].name, feature))
+			return features + ii;
+
+		for (ii =3D 0; features[ii].name; ii++)
+			if (!strcasecmp(features[ii].name, feature)) {
+				cache =3D ii;
+				return features + ii;
+			}
+	}
 	return NULL;
 }
=20
@@ -329,33 +355,36 @@
 const sensors_feature_data *sensors_get_all_features(sensors_chip_name nam=
e,
 						     int *nr1, int *nr2)
 {
-	sensors_chip_feature *feature_list;
-	int i;
+	const sensors_chip_feature *feature_list +				sensors_lookup_features(nam=
e.prefix);
=20
-	for (i =3D 0; sensors_chip_features_list[i].prefix; i++)
-		if (!strcasecmp(sensors_chip_features_list[i].prefix, name.prefix)) {
-			feature_list =3D sensors_chip_features_list[i].feature;
-			if (!*nr1 && !*nr2) {	/* Return the first entry */
-				if (!feature_list[0].name)	/* The list may be empty */
-					return NULL;
-				*nr1 =3D *nr2 =3D 1;
-				return (sensors_feature_data *)feature_list;
-			}
-			for ((*nr2)++; feature_list[*nr2 - 1].name; (*nr2)++)
-				if (feature_list[*nr2 - 1].logical_mapping =3D
-				    feature_list[*nr1 - 1].number)
-					return (sensors_feature_data *)
-						(feature_list + *nr2 - 1);
-			for ((*nr1)++;
-			     feature_list[*nr1 - 1].name
-			     && (feature_list[*nr1 - 1].logical_mapping !-				 SENSORS_NO_MAPPI=
NG); (*nr1)++) ;
-			*nr2 =3D *nr1;
-			if (!feature_list[*nr1 - 1].name)
-				return NULL;
-			return (sensors_feature_data *)(feature_list + *nr1 - 1);
-		}
-	return NULL;
+	if (!feature_list)
+		return NULL;
+
+	/* Return the first entry */
+	if (!*nr1 && !*nr2) {
+
+		/* The list may be empty */
+		if (!feature_list[0].name)
+			return NULL;
+
+		*nr1 =3D *nr2 =3D 1;
+		return (sensors_feature_data *)feature_list;
+	}
+
+	for ((*nr2)++; feature_list[*nr2 - 1].name; (*nr2)++)
+		if (feature_list[*nr2 - 1].logical_mapping =3D
+					feature_list[*nr1 - 1].number)
+			return (sensors_feature_data *)(feature_list + *nr2 - 1);
+
+	for ((*nr1)++; feature_list[*nr1 - 1].name &&
+		(feature_list[*nr1 - 1].logical_mapping !=3D SENSORS_NO_MAPPING);
+		(*nr1)++) ;
+
+	*nr2 =3D *nr1;
+	if (!feature_list[*nr1 - 1].name)
+		return NULL;
+	return (sensors_feature_data *)(feature_list + *nr1 - 1);
 }
=20
 int sensors_eval_expr(sensors_chip_name chipname, const sensors_expr * exp=
r,
--=20
Mark M. Hoffman
mhoffman at lightlink.com


