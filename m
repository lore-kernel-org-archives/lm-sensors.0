From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Aug 2007 13:02:59 +0000
Subject: [lm-sensors] [PATCH 1/3] libsensors4: New prototype for
Message-Id: <20070825150259.0a936215@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add a parameter to sensors_get_detected_chips(), to optionally let the
caller select which subset of chips it wants. This is slightly better
size-wise than letting all applications do the filtering by themselves.

This will change the way the command line parameters of "sensors" are
interpreted. Beforehand, the chips were always returned in the order
in which they were listed by the library. Also, each chip could be listed
only once. From now on, the chips will be listed in the order in which
they are passed on the command line, which I think makes more sense. A
side effect is that chips can be listed more than once, if that's what
the user asks for. Not very useful though.

This change makes it possible to make sensors_match_chip() internal
to the library. Filtering the list of chips returned by
sensors_get_detected_chips() was the last known external use for this
function.

This patch looks much bigger than it really is, but the largest part is
really only code reindentation.

---
 lib/access.c         |   25 ++++++++++--------
 lib/libsensors.3     |   13 ++++++---
 lib/sensors.h        |   12 +++++----
 prog/sensord/rrd.c   |   66 ++++++++++++++++++++++++--------------------------
 prog/sensord/sense.c |    8 ++----
 prog/sensors/main.c  |   24 +++++++++---------
 6 files changed, 77 insertions(+), 71 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-08-25 13:53:15.000000000 +0200
@@ -303,13 +303,17 @@ int sensors_set_value(const sensors_chip
 	return 0;
 }
 
-const sensors_chip_name *sensors_get_detected_chips(int *nr)
+const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+						    *match, int *nr)
 {
 	const sensors_chip_name *res;
-	res = (*nr >= sensors_proc_chips_count ?
-			NULL : &sensors_proc_chips[*nr].chip);
-	(*nr)++;
-	return res;
+
+	while (*nr < sensors_proc_chips_count) {
+		res = &sensors_proc_chips[(*nr)++].chip;
+		if (!match || sensors_match_chip(res, match))
+			return res;
+	}
+	return NULL;
 }
 
 const char *sensors_get_adapter_name(const sensors_bus_id *bus)
@@ -480,12 +484,11 @@ int sensors_do_chip_sets(const sensors_c
 	const sensors_chip_name *found_name;
 	int res = 0;
 
-	for (nr = 0; (found_name = sensors_get_detected_chips(&nr));)
-		if (sensors_match_chip(name, found_name)) {
-			this_res = sensors_do_this_chip_sets(found_name);
-			if (!res)
-				res = this_res;
-		}
+	for (nr = 0; (found_name = sensors_get_detected_chips(name, &nr));) {
+		this_res = sensors_do_this_chip_sets(found_name);
+		if (this_res)
+			res = this_res;
+	}
 	return res;
 }
 
--- lm-sensors-3.orig/lib/libsensors.3	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-08-25 13:53:15.000000000 +0200
@@ -44,7 +44,8 @@ libsensors \- publicly accessible functi
 .B int sensors_set_value(const sensors_chip_name *name, int feature,
                       \fBdouble value);\fP
 .B int sensors_do_chip_sets(const sensors_chip_name *name);
-.B const sensors_chip_name *sensors_get_detected_chips(int *nr);
+.B const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+                                                    \fB*match, int *nr);\fP
 .B const sensors_feature_data *sensors_get_all_features 
              \fB(const sensors_chip_name *name, int *nr);\fP
 .B const char *libsensors_version;
@@ -98,10 +99,14 @@ Set the value of a feature of a certain 
 .br
 Execute all set statements for this particular chip. The chip may contain wildcards!  This function will return 0 on success, and <0 on failure.
 
-\fBconst sensors_chip_name *sensors_get_detected_chips
-                        (int *nr);\fP
+\fBconst sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+                                                    *match, int *nr);\fP
 .br
-This function returns all detected chips, one by one. To start at the beginning of the list, use 0 for nr; NULL is returned if we are at the end of the list. Do not try to change these chip names, as they point to internal structures! Do not use nr for anything else.
+This function returns all detected chips that match a given chip name,
+one by one. If no chip name is provided, all detected chips are returned.
+To start at the beginning of the list, use 0 for nr; NULL is returned if
+we are at the end of the list. Do not try to change these chip names, as
+they point to internal structures!
 
 This structure is used when you want to get all features of a specific chip.
 .br
--- lm-sensors-3.orig/lib/sensors.h	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-25 13:53:15.000000000 +0200
@@ -109,11 +109,13 @@ int sensors_set_value(const sensors_chip
    wildcards!  This function will return 0 on success, and <0 on failure. */
 int sensors_do_chip_sets(const sensors_chip_name *name);
 
-/* This function returns all detected chips, one by one. To start at the
-   beginning of the list, use 0 for nr; NULL is returned if we are
-   at the end of the list. Do not try to change these chip names, as
-   they point to internal structures! Do not use nr for anything else. */
-const sensors_chip_name *sensors_get_detected_chips(int *nr);
+/* This function returns all detected chips that match a given chip name,
+   one by one. If no chip name is provided, all detected chips are returned.
+   To start at the beginning of the list, use 0 for nr; NULL is returned if
+   we are at the end of the list. Do not try to change these chip names, as
+   they point to internal structures! */
+const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+						    *match, int *nr);
 
 /* These defines are used in the mode field of sensors_feature_data */
 #define SENSORS_MODE_R 1
--- lm-sensors-3.orig/prog/sensors/main.c	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/prog/sensors/main.c	2007-08-25 13:53:15.000000000 +0200
@@ -251,18 +251,18 @@ int do_the_real_work(int *error)
   int cnt = 0;
 
   *error = 0;
-  for (chip_nr = 0; (chip = sensors_get_detected_chips(&chip_nr));)
-    for(i = 0; i < chips_count; i++)
-      if (sensors_match_chip(chip, &chips[i])) {
-        if(do_sets) {
-          if (do_a_set(chip))
-            *error = 1;
-        } else
-          do_a_print(chip);
-        i = chips_count;
-	cnt++;
-      }
-   return(cnt);
+  for (i = 0; i < chips_count; i++) {
+    chip_nr = 0;
+    while ((chip = sensors_get_detected_chips(&chips[i], &chip_nr))) {
+      if (do_sets) {
+        if (do_a_set(chip))
+          *error = 1;
+      } else
+        do_a_print(chip);
+      cnt++;
+    }
+  }
+  return cnt;
 }
 
 /* returns 1 on error */
--- lm-sensors-3.orig/prog/sensord/rrd.c	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/prog/sensord/rrd.c	2007-08-25 13:53:15.000000000 +0200
@@ -139,41 +139,39 @@ applyToFeatures
   const sensors_chip_name *chip;
   int i = 0, j, ret = 0, num = 0;
 
-  while ((ret = 0) && ((chip = sensors_get_detected_chips (&i)) != NULL)) {
-    for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
-      if (sensors_match_chip (chip, &chipNames[j])) {
-        int index0, subindex, chipindex = -1;
-        for (index0 = 0; knownChips[index0]; ++ index0)
-          for (subindex = 0; knownChips[index0]->names[subindex]; ++ subindex)
-            if (!strcmp (chip->prefix, knownChips[index0]->names[subindex]))
-              chipindex = index0;
-        if (chipindex >= 0) {
-          const ChipDescriptor *descriptor = knownChips[chipindex];
-          const FeatureDescriptor *features = descriptor->features;
-
-          for (index0 = 0; (ret = 0) && (num < MAX_RRD_SENSORS) && features[index0].format; ++ index0) {
-            const FeatureDescriptor *feature = features + index0;
-            int labelNumber = feature->dataNumbers[0];
-            const char *rawLabel = NULL;
-            char *label = NULL;
-            int valid = 0;
-            if (getValid (chip, labelNumber, &valid)) {
-              sensorLog (LOG_ERR, "Error getting sensor validity: %s/#%d", chip->prefix, labelNumber);
-              ret = -1;
-            } else if (getRawLabel (chip, labelNumber, &rawLabel)) {
-              sensorLog (LOG_ERR, "Error getting raw sensor label: %s/#%d", chip->prefix, labelNumber);
-              ret = -1;
-            } else if (!(label = sensors_get_label (chip, labelNumber))) {
-              sensorLog (LOG_ERR, "Error getting sensor label: %s/#%d", chip->prefix, labelNumber);
-              ret = -1;
-            } else if (valid) {
-              rrdCheckLabel (rawLabel, num);
-              ret = fn (data, rrdLabels[num], label, feature);
-              ++ num;
-            }
-            if (label)
-              free (label);
+  for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
+    while ((ret = 0) && ((chip = sensors_get_detected_chips (&chipNames[j], &i)) != NULL)) {
+      int index0, subindex, chipindex = -1;
+      for (index0 = 0; knownChips[index0]; ++ index0)
+        for (subindex = 0; knownChips[index0]->names[subindex]; ++ subindex)
+          if (!strcmp (chip->prefix, knownChips[index0]->names[subindex]))
+            chipindex = index0;
+      if (chipindex >= 0) {
+        const ChipDescriptor *descriptor = knownChips[chipindex];
+        const FeatureDescriptor *features = descriptor->features;
+
+        for (index0 = 0; (ret = 0) && (num < MAX_RRD_SENSORS) && features[index0].format; ++ index0) {
+          const FeatureDescriptor *feature = features + index0;
+          int labelNumber = feature->dataNumbers[0];
+          const char *rawLabel = NULL;
+          char *label = NULL;
+          int valid = 0;
+          if (getValid (chip, labelNumber, &valid)) {
+            sensorLog (LOG_ERR, "Error getting sensor validity: %s/#%d", chip->prefix, labelNumber);
+            ret = -1;
+          } else if (getRawLabel (chip, labelNumber, &rawLabel)) {
+            sensorLog (LOG_ERR, "Error getting raw sensor label: %s/#%d", chip->prefix, labelNumber);
+            ret = -1;
+          } else if (!(label = sensors_get_label (chip, labelNumber))) {
+            sensorLog (LOG_ERR, "Error getting sensor label: %s/#%d", chip->prefix, labelNumber);
+            ret = -1;
+          } else if (valid) {
+            rrdCheckLabel (rawLabel, num);
+            ret = fn (data, rrdLabels[num], label, feature);
+            ++ num;
           }
+          if (label)
+            free (label);
         }
       }
     }
--- lm-sensors-3.orig/prog/sensord/sense.c	2007-08-25 13:44:04.000000000 +0200
+++ lm-sensors-3/prog/sensord/sense.c	2007-08-25 13:53:15.000000000 +0200
@@ -238,11 +238,9 @@ doChips
   const sensors_chip_name *chip;
   int i = 0, j, ret = 0;
 
-  while ((ret = 0) && ((chip = sensors_get_detected_chips (&i)) != NULL)) {
-    for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
-      if (sensors_match_chip (chip, &chipNames[j])) {
-        ret = doChip (chip, action);
-      }
+  for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
+    while ((ret = 0) && ((chip = sensors_get_detected_chips (&chipNames[j], &i)) != NULL)) {
+      ret = doChip (chip, action);
     }
   }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
