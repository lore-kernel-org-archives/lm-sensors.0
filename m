From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jul 2007 13:24:24 +0000
Subject: [lm-sensors] [PATCH 2/3] libsensors4: Adjust
Message-Id: <20070716152424.6e48a07f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now that sensors_feature_get_type() is an internal function, we can
adjust it to fit our needs better:

* Call sensors_feature_get_type() before allocating memory for the
feature name. The allocation will be reverted for all sysfs files
which are not valid libsensors attributes, and there can be a lot
of these. So this saves a few memory allocations. But this means
that we want to pass a simple string to sensors_feature_get_type()
rather than a struct sensors_feature_data. This also means that
sensors_feature_get_type() gets the raw attribute name ("_input"
not stripped.)

* Get the channel number from sensors_feature_get_type() too. We
get it for free from sscanf(), so it's more efficient to return it
than to parse it again in sensors_read_dynamic_chip().

---
 lib/access.c |   20 +++++++++++---------
 lib/access.h |    2 +-
 lib/sysfs.c  |   32 +++++++++++---------------------
 3 files changed, 23 insertions(+), 31 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-16 14:26:16.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-16 14:48:55.000000000 +0200
@@ -528,6 +528,7 @@ struct feature_type_match
 };
 
 static const struct feature_subtype_match temp_matches[] = {
+	{ "input", SENSORS_FEATURE_TEMP },
 	{ "max", SENSORS_FEATURE_TEMP_MAX },
 	{ "max_hyst", SENSORS_FEATURE_TEMP_MAX_HYST },
 	{ "min", SENSORS_FEATURE_TEMP_MIN },
@@ -543,6 +544,7 @@ static const struct feature_subtype_matc
 };
 
 static const struct feature_subtype_match in_matches[] = {
+	{ "input", SENSORS_FEATURE_IN },
 	{ "min", SENSORS_FEATURE_IN_MIN },
 	{ "max", SENSORS_FEATURE_IN_MAX },
 	{ "alarm", SENSORS_FEATURE_IN_ALARM },
@@ -552,6 +554,7 @@ static const struct feature_subtype_matc
 };
 
 static const struct feature_subtype_match fan_matches[] = {
+	{ "input", SENSORS_FEATURE_FAN },
 	{ "min", SENSORS_FEATURE_FAN_MIN },
 	{ "div", SENSORS_FEATURE_FAN_DIV },
 	{ "alarm", SENSORS_FEATURE_FAN_ALARM },
@@ -565,22 +568,21 @@ static const struct feature_subtype_matc
 };
 
 static struct feature_type_match matches[] = { 
-	{ "temp%d%c", SENSORS_FEATURE_TEMP, temp_matches },
-	{ "in%d%c", SENSORS_FEATURE_IN, in_matches },
-	{ "fan%d%c", SENSORS_FEATURE_FAN, fan_matches },
+	{ "temp%d%c", SENSORS_FEATURE_UNKNOWN, temp_matches },
+	{ "in%d%c", SENSORS_FEATURE_UNKNOWN, in_matches },
+	{ "fan%d%c", SENSORS_FEATURE_UNKNOWN, fan_matches },
 	{ "cpu%d%c", SENSORS_FEATURE_UNKNOWN, cpu_matches },
 };
 
-/* Return the feature type based on the feature name */
-sensors_feature_type sensors_feature_get_type(
-	const sensors_feature_data *feature)
+/* Return the feature type and channel number based on the feature name */
+sensors_feature_type sensors_feature_get_type(const char *name, int *nr)
 {
 	char c;
-	int i, nr, count;
+	int i, count;
 	const struct feature_subtype_match *submatches;
 	
 	for (i = 0; i < ARRAY_SIZE(matches); i++)
-		if ((count = sscanf(feature->name, matches[i].name, &nr, &c)))
+		if ((count = sscanf(name, matches[i].name, nr, &c)))
 			break;
 	
 	if (i = ARRAY_SIZE(matches)) /* no match */
@@ -594,7 +596,7 @@ sensors_feature_type sensors_feature_get
 
 	submatches = matches[i].submatches;
 	for (i = 0; submatches[i].name != NULL; i++)
-		if (!strcmp(strchr(feature->name, '_') + 1, submatches[i].name))
+		if (!strcmp(strchr(name, '_') + 1, submatches[i].name))
 			return submatches[i].type;
 	
 	return SENSORS_FEATURE_UNKNOWN;
--- lm-sensors-3.orig/lib/access.h	2007-07-16 14:26:40.000000000 +0200
+++ lm-sensors-3/lib/access.h	2007-07-16 14:48:17.000000000 +0200
@@ -29,6 +29,6 @@
 extern const sensors_chip_feature *sensors_lookup_feature_nr(const sensors_chip_name *chip,
                                                              int feature);
 
-sensors_feature_type sensors_feature_get_type(const sensors_feature_data *feature);
+sensors_feature_type sensors_feature_get_type(const char *name, int *nr);
 
 #endif /* def LIB_SENSORS_ACCESS_H */
--- lm-sensors-3.orig/lib/sysfs.c	2007-07-16 14:26:40.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-07-16 14:48:17.000000000 +0200
@@ -85,7 +85,12 @@ static int sensors_read_dynamic_chip(sen
 	dlist_for_each_data(attrs, attr, struct sysfs_attribute) {
 		sensors_chip_feature feature;
 		name = attr->name;
+		int nr;
 		
+		type = sensors_feature_get_type(name, &nr);
+		if (type = SENSORS_FEATURE_UNKNOWN)
+			continue;
+
 		memset(&feature, 0, sizeof(sensors_chip_feature));
 		/* check for _input extension and remove */
 		i = strlen(name);
@@ -94,31 +99,16 @@ static int sensors_read_dynamic_chip(sen
 		else
 			feature.data.name = strdup(name);
 
-		type = sensors_feature_get_type(&feature.data);
-		if (type = SENSORS_FEATURE_UNKNOWN) {
-			free(feature.data.name);
-			continue;
-		}
-			
-		/* Get N as in this is the N-th in / fan / temp / vid */
+		/* Adjust the channel number */
 		switch (type & 0xFF00) {
-			case SENSORS_FEATURE_IN:
-				i = strtol(name + 2, NULL, 10);
-				break;
 			case SENSORS_FEATURE_FAN:
-				i = strtol(name + 3, NULL, 10);
-				if (i) i--;
-				break;
 			case SENSORS_FEATURE_TEMP:
-				i = strtol(name + 4, NULL, 10);
-				if (i) i--;
-				break;
-			case SENSORS_FEATURE_VID:
-				i = strtol(name + 3, NULL, 10);
+				if (nr)
+					nr--;
 				break;
 		}
 		
-		if (i >= MAX_SENSORS_PER_TYPE) {
+		if (nr >= MAX_SENSORS_PER_TYPE) {
 			fprintf(stderr, "libsensors error, more sensors of one"
 				" type then MAX_SENSORS_PER_TYPE, ignoring "
 				"feature: %s\n", name);
@@ -129,12 +119,12 @@ static int sensors_read_dynamic_chip(sen
 		/* "calculate" a place to store the feature in our sparse,
 		   sorted table */
 		if (type = SENSORS_FEATURE_VID) {
-			i += MAX_SENSORS_PER_TYPE *
+			i = nr + MAX_SENSORS_PER_TYPE *
 			     SENSORS_FEATURE_MAX_SUB_FEATURES * 3;
 		} else {
 			i = (type >> 8) * MAX_SENSORS_PER_TYPE *
 				SENSORS_FEATURE_MAX_SUB_FEATURES +
-				i * SENSORS_FEATURE_MAX_SUB_FEATURES +
+				nr * SENSORS_FEATURE_MAX_SUB_FEATURES +
 				(type & 0xFF);
 		}
 		


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
