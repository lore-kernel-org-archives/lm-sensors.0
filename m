From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Jan 2014 13:28:26 +0000
Subject: [lm-sensors] [PATCH RFC] libsensors: Get rid of arbitrary limit on per-type sensor count
Message-Id: <20140116142826.36b3cc9c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When gathering the attributes of each hwmon chip, libsensors uses a
temporary structure in memory to order and group all the attributes
into features. This temporary structure used to be a single array with
room for every possible attribute/subfeature. While simple, this
approach required to predefine a maximum number of per-type sensor
that could be handled.

In order to get rid of this arbitrary limit, which we hit and had to
raise three times already, I changed the temporary structure to an
array of dynamically allocated per-type subattribute arrays. This lets
us not allocate any memory for types which aren't implemented by a
given chip, and more importantly, this lets us reallocate room for
more attributes of a given type as needed.

I decided to allocate chunks of 8 attributes at a time, as this seemed
a good compromise between two frequent reallocations and
over-provisioning. It could be tweaked if needed.

Icing on the cake, I benchmarked this change on two different systems
and it results in performance gains. The total heap usage as reported
by valgrind is down by 50% on average, with peak memory consumption
(as reported by valgrind's massif) also down by 43% on average. The
total instructions count (as reported by valgrind's callgrind) is down
by 11% on average, with measured execution time also down by a few
percents. Valgrind rocks, BTW.

I have some ideas to optimize the memory allocations further, but I do
not expect such a huge gain from them. They may not even improve peak
memory consumption as massif shows the peak is somewhere else now at
least in some cases.
---
Note: this is NOT lm-sensors 3.3.5 material. I'd rather release 3.3.5
quickly and merge this later. That would make the following lm-sensors
version 3.4.0 as this is a significant change.

Testing and comments would still be appreciated.

 lib/sensors.h |    1 
 lib/sysfs.c   |  153 ++++++++++++++++++++++++++++------------------------------
 2 files changed, 77 insertions(+), 77 deletions(-)

--- lm-sensors.orig/lib/sysfs.c	2014-01-15 10:02:43.148325970 +0100
+++ lm-sensors/lib/sysfs.c	2014-01-16 08:59:21.441256754 +0100
@@ -138,21 +138,8 @@ static int sysfs_foreach_busdev(const ch
 
 char sensors_sysfs_mount[NAME_MAX];
 
-#define MAX_MAIN_SENSOR_TYPES	(SENSORS_FEATURE_MAX_MAIN - SENSORS_FEATURE_IN)
-#define MAX_OTHER_SENSOR_TYPES	(SENSORS_FEATURE_MAX_OTHER - SENSORS_FEATURE_VID)
-#define MAX_SENSORS_PER_TYPE	33
 /* max_subfeatures is now computed dynamically */
 #define FEATURE_SIZE		(max_subfeatures * 2)
-#define FEATURE_TYPE_SIZE	(MAX_SENSORS_PER_TYPE * FEATURE_SIZE)
-
-/*
- * Room for all 7 main types (in, fan, temp, power, energy, current, humidity)
- * and 2 other types (VID, intrusion) with all their subfeatures + misc features
- */
-#define SUB_OFFSET_OTHER	(MAX_MAIN_SENSOR_TYPES * FEATURE_TYPE_SIZE)
-#define SUB_OFFSET_MISC		(SUB_OFFSET_OTHER + \
-				 MAX_OTHER_SENSOR_TYPES * FEATURE_TYPE_SIZE)
-#define ALL_POSSIBLE_SUBFEATURES	(SUB_OFFSET_MISC + 1)
 
 static
 int get_type_scaling(sensors_subfeature_type type)
@@ -432,7 +419,10 @@ static int sensors_read_dynamic_chip(sen
 	static int max_subfeatures;
 	DIR *dir;
 	struct dirent *ent;
-	sensors_subfeature *all_subfeatures;
+	struct {
+		int count;
+		sensors_subfeature *sf;
+	} all_types[SENSORS_FEATURE_MAX];
 	sensors_subfeature *dyn_subfeatures;
 	sensors_feature *dyn_features;
 	sensors_feature_type ftype;
@@ -445,13 +435,10 @@ static int sensors_read_dynamic_chip(sen
 	if (!max_subfeatures)
 		max_subfeatures = sensors_compute_max();
 
-	/* We use a large sparse table at first to store all found
-	   subfeatures, so that we can store them sorted at type and index
-	   and then later create a dense sorted table. */
-	all_subfeatures = calloc(ALL_POSSIBLE_SUBFEATURES,
-				 sizeof(sensors_subfeature));
-	if (!all_subfeatures)
-		sensors_fatal_error(__func__, "Out of memory");
+	/* We use a set of large sparse tables at first (one per main
+	   feature type present) to store all found subfeatures, so that we
+	   can store them sorted and then later create a dense sorted table. */
+	memset(&all_types, 0, sizeof(all_types));
 
 	while ((ent = readdir(dir))) {
 		char *name;
@@ -482,37 +469,43 @@ static int sensors_read_dynamic_chip(sen
 			break;
 		}
 
-		if (nr < 0 || nr >= MAX_SENSORS_PER_TYPE) {
-			/* More sensors of one type than MAX_SENSORS_PER_TYPE,
-			   we have to ignore it */
+		/* Skip invalid entries */
+		if (nr < 0) {
 #ifdef DEBUG
 			sensors_fatal_error(__func__,
-					    "Increase MAX_SENSORS_PER_TYPE!");
+					    "Invalid channel number!");
 #endif
 			continue;
 		}
 
+		/* (Re-)allocate memory if needed */
+		if (all_types[ftype].count < nr + 1) {
+			int old_count = all_types[ftype].count;
+
+			while (all_types[ftype].count < nr + 1)
+				all_types[ftype].count += 8;
+
+			all_types[ftype].sf = realloc(all_types[ftype].sf,
+						all_types[ftype].count *
+						FEATURE_SIZE *
+						sizeof(sensors_subfeature));
+			if (!all_types[ftype].sf)
+				sensors_fatal_error(__func__, "Out of memory");
+			memset(all_types[ftype].sf + old_count * FEATURE_SIZE,
+			       0, (all_types[ftype].count - old_count) *
+				  FEATURE_SIZE * sizeof(sensors_subfeature));
+		}
+
 		/* "calculate" a place to store the subfeature in our sparse,
 		   sorted table */
-		switch (ftype) {
-		case SENSORS_FEATURE_VID:
-		case SENSORS_FEATURE_INTRUSION:
-			i = SUB_OFFSET_OTHER +
-			    (ftype - SENSORS_FEATURE_VID) * FEATURE_TYPE_SIZE +
-			    nr * FEATURE_SIZE + (sftype & 0xFF);
-			break;
-		case SENSORS_FEATURE_BEEP_ENABLE:
-			i = SUB_OFFSET_MISC +
-			    (ftype - SENSORS_FEATURE_BEEP_ENABLE);
-			break;
-		default:
-			i = ftype * FEATURE_TYPE_SIZE +
-			    nr * FEATURE_SIZE +
+		if (ftype < SENSORS_FEATURE_VID)
+			i = nr * FEATURE_SIZE +
 			    ((sftype & 0x80) >> 7) * max_subfeatures +
 			    (sftype & 0x7F);
-		}
+		else
+			i = nr * FEATURE_SIZE + (sftype & 0xFF);
 
-		if (all_subfeatures[i].name) {
+		if (all_types[ftype].sf[i].name) {
 #ifdef DEBUG
 			sensors_fatal_error(__func__, "Duplicate subfeature");
 #endif
@@ -520,15 +513,16 @@ static int sensors_read_dynamic_chip(sen
 		}
 
 		/* fill in the subfeature members */
-		all_subfeatures[i].type = sftype;
-		all_subfeatures[i].name = strdup(name);
-		if (!all_subfeatures[i].name)
+		all_types[ftype].sf[i].type = sftype;
+		all_types[ftype].sf[i].name = strdup(name);
+		if (!all_types[ftype].sf[i].name)
 			sensors_fatal_error(__func__, "Out of memory");
 
 		/* Other and misc subfeatures are never scaled */
 		if (sftype < SENSORS_SUBFEATURE_VID && !(sftype & 0x80))
-			all_subfeatures[i].flags |= SENSORS_COMPUTE_MAPPING;
-		all_subfeatures[i].flags |= sensors_get_attr_mode(dev_path, name);
+			all_types[ftype].sf[i].flags |= SENSORS_COMPUTE_MAPPING;
+		all_types[ftype].sf[i].flags |+					sensors_get_attr_mode(dev_path, name);
 
 		sfnum++;
 	}
@@ -540,14 +534,16 @@ static int sensors_read_dynamic_chip(sen
 	}
 
 	/* How many main features? */
-	prev_slot = -1;
-	for (i = 0; i < ALL_POSSIBLE_SUBFEATURES; i++) {
-		if (!all_subfeatures[i].name)
-			continue;
-
-		if (i >= SUB_OFFSET_MISC || i / FEATURE_SIZE != prev_slot) {
-			fnum++;
-			prev_slot = i / FEATURE_SIZE;
+	for (ftype = 0; ftype < SENSORS_FEATURE_MAX; ftype++) {
+		prev_slot = -1;
+		for (i = 0; i < all_types[ftype].count * FEATURE_SIZE; i++) {
+			if (!all_types[ftype].sf[i].name)
+				continue;
+
+			if (i / FEATURE_SIZE != prev_slot) {
+				fnum++;
+				prev_slot = i / FEATURE_SIZE;
+			}
 		}
 	}
 
@@ -559,30 +555,32 @@ static int sensors_read_dynamic_chip(sen
 	/* Copy from the sparse array to the compact array */
 	sfnum = 0;
 	fnum = -1;
-	prev_slot = -1;
-	for (i = 0; i < ALL_POSSIBLE_SUBFEATURES; i++) {
-		if (!all_subfeatures[i].name)
-			continue;
-
-		/* New main feature? */
-		if (i >= SUB_OFFSET_MISC || i / FEATURE_SIZE != prev_slot) {
-			ftype = all_subfeatures[i].type >> 8;
-			fnum++;
-			prev_slot = i / FEATURE_SIZE;
-
-			dyn_features[fnum].name = get_feature_name(ftype,
-						all_subfeatures[i].name);
-			dyn_features[fnum].number = fnum;
-			dyn_features[fnum].first_subfeature = sfnum;
-			dyn_features[fnum].type = ftype;
-		}
+	for (ftype = 0; ftype < SENSORS_FEATURE_MAX; ftype++) {
+		prev_slot = -1;
+		for (i = 0; i < all_types[ftype].count * FEATURE_SIZE; i++) {
+			if (!all_types[ftype].sf[i].name)
+				continue;
+
+			/* New main feature? */
+			if (i / FEATURE_SIZE != prev_slot) {
+				fnum++;
+				prev_slot = i / FEATURE_SIZE;
+
+				dyn_features[fnum].name +					get_feature_name(ftype,
+						all_types[ftype].sf[i].name);
+				dyn_features[fnum].number = fnum;
+				dyn_features[fnum].first_subfeature = sfnum;
+				dyn_features[fnum].type = ftype;
+			}
 
-		dyn_subfeatures[sfnum] = all_subfeatures[i];
-		dyn_subfeatures[sfnum].number = sfnum;
-		/* Back to the feature */
-		dyn_subfeatures[sfnum].mapping = fnum;
+			dyn_subfeatures[sfnum] = all_types[ftype].sf[i];
+			dyn_subfeatures[sfnum].number = sfnum;
+			/* Back to the feature */
+			dyn_subfeatures[sfnum].mapping = fnum;
 
-		sfnum++;
+			sfnum++;
+		}
 	}
 
 	chip->subfeature = dyn_subfeatures;
@@ -591,7 +589,8 @@ static int sensors_read_dynamic_chip(sen
 	chip->feature_count = ++fnum;
 
 exit_free:
-	free(all_subfeatures);
+	for (ftype = 0; ftype < SENSORS_FEATURE_MAX; ftype++)
+		free(all_types[ftype].sf);
 	return 0;
 }
 
--- lm-sensors.orig/lib/sensors.h	2012-03-14 08:41:26.191719258 +0100
+++ lm-sensors/lib/sensors.h	2014-01-16 08:38:58.288268508 +0100
@@ -146,6 +146,7 @@ typedef enum sensors_feature_type {
 	SENSORS_FEATURE_INTRUSION	= 0x11,
 	SENSORS_FEATURE_MAX_OTHER,
 	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
+	SENSORS_FEATURE_MAX,
 	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
 } sensors_feature_type;
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
