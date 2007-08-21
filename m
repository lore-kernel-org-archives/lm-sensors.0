From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 19:27:17 +0000
Subject: [lm-sensors] [PATCH 3/4] libsensors4: Rename
Message-Id: <20070821212717.1d853aed@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rename sensors_get_feature() and sensors_set_feature() to
sensors_get_value() and sensors_set_value(), respectively.
The new names better reflect what the functions do.

---
 lib/access.c                 |   12 ++++++------
 lib/libsensors.3             |   16 ++++++++--------
 lib/sensors.h                |    8 ++++----
 prog/sensord/sense.c         |    8 ++++----
 prog/sensors/chips.c         |    4 ++--
 prog/sensors/chips_generic.c |    2 +-
 6 files changed, 25 insertions(+), 25 deletions(-)

--- lm-sensors-3.orig/lib/libsensors.3	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-08-21 20:46:37.000000000 +0200
@@ -39,10 +39,10 @@ libsensors \- publicly accessible functi
                        \fBconst sensors_chip_name *chip2);\fP
 .B const char *sensors_get_adapter_name(int bus_nr);
 .B char *sensors_get_label(const sensors_chip_name *name, int feature);\fP
-.B int sensors_get_feature(const sensors_chip_name *name, int feature,
-                        \fBdouble *result);\fP
-.B int sensors_set_feature(const sensors_chip_name *name, int feature,
-                        \fBdouble value);\fP
+.B int sensors_get_value(const sensors_chip_name *name, int feature,
+                      \fBdouble *value);\fP
+.B int sensors_set_value(const sensors_chip_name *name, int feature,
+                      \fBdouble value);\fP
 .B int sensors_do_chip_sets(const sensors_chip_name *name);
 .B const sensors_chip_name *sensors_get_detected_chips(int *nr);
 .B const sensors_feature_data *sensors_get_all_features 
@@ -84,13 +84,13 @@ contain wildcard values! The returned st
 yourself). On failure, NULL is returned.
 If no label exists for this feature, its name is returned itself.
 
-\fBint sensors_get_feature(const sensors_chip_name *name,
-                        int feature, double *result);\fP
+\fBint sensors_get_value(const sensors_chip_name *name,
+                      int feature, double *value);\fP
 .br
 Read the value of a feature of a certain chip. Note that chip should not contain wildcard values! This function will return 0 on success, and <0 on failure.
 
-\fBint sensors_set_feature(const sensors_chip_name *name,
-                        int feature, double value);\fP
+\fBint sensors_set_value(const sensors_chip_name *name,
+                      int feature, double value);\fP
 .br
 Set the value of a feature of a certain chip. Note that chip should not contain wildcard values! This function will return 0 on success, and <0 on failure.
 
--- lm-sensors-3.orig/lib/sensors.h	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-21 20:46:50.000000000 +0200
@@ -96,14 +96,14 @@ char *sensors_get_label(const sensors_ch
 /* Read the value of a feature of a certain chip. Note that chip should not
    contain wildcard values! This function will return 0 on success, and <0
    on failure.  */
-int sensors_get_feature(const sensors_chip_name *name, int feature,
-			double *result);
+int sensors_get_value(const sensors_chip_name *name, int feature,
+		      double *value);
 
 /* Set the value of a feature of a certain chip. Note that chip should not
    contain wildcard values! This function will return 0 on success, and <0
    on failure. */
-int sensors_set_feature(const sensors_chip_name *name, int feature,
-			double value);
+int sensors_set_value(const sensors_chip_name *name, int feature,
+		      double value);
 
 /* Execute all set statements for this particular chip. The chip may contain
    wildcards!  This function will return 0 on success, and <0 on failure. */
--- lm-sensors-3.orig/prog/sensord/sense.c	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/prog/sensord/sense.c	2007-08-21 20:39:20.000000000 +0200
@@ -108,7 +108,7 @@ readUnknownChip
       /* skip invalid */
     } else if (!(sensor->mode & SENSORS_MODE_R)) {
       sensorLog (LOG_INFO, "%s: %s", sensor->name, label);
-    } else if ((ret = sensors_get_feature (chip, sensor->number, &value))) {
+    } else if ((ret = sensors_get_value (chip, sensor->number, &value))) {
       sensorLog (LOG_ERR, "Error getting sensor data: %s/%s: %s", chip->prefix, sensor->name, sensors_strerror (ret));
       ret = 22;
     } else {
@@ -133,7 +133,7 @@ doKnownChip
   if (action = DO_READ)
     ret = idChip (chip);
   if (!ret && descriptor->alarmNumber) {
-    if ((ret = sensors_get_feature (chip, descriptor->alarmNumber, &tmp))) {
+    if ((ret = sensors_get_value (chip, descriptor->alarmNumber, &tmp))) {
       sensorLog (LOG_ERR, "Error getting sensor data: %s/#%d: %s", chip->prefix, descriptor->alarmNumber, sensors_strerror (ret));
       ret = 20;
     } else {
@@ -141,7 +141,7 @@ doKnownChip
     }
   }
   if (!ret && descriptor->beepNumber) {
-    if ((ret = sensors_get_feature (chip, descriptor->beepNumber, &tmp))) {
+    if ((ret = sensors_get_value (chip, descriptor->beepNumber, &tmp))) {
       sensorLog (LOG_ERR, "Error getting sensor data: %s/#%d: %s", chip->prefix, descriptor->beepNumber, sensors_strerror (ret));
       ret = 21;
     } else {
@@ -168,7 +168,7 @@ doKnownChip
       double values[MAX_DATA];
 
       for (subindex = 0; !ret && (feature->dataNumbers[subindex] >= 0); ++ subindex) {
-        if ((ret = sensors_get_feature (chip, feature->dataNumbers[subindex], values + subindex))) {
+        if ((ret = sensors_get_value (chip, feature->dataNumbers[subindex], values + subindex))) {
           sensorLog (LOG_ERR, "Error getting sensor data: %s/#%d: %s", chip->prefix, feature->dataNumbers[subindex], sensors_strerror (ret));
           ret = 23;
         }
--- lm-sensors-3.orig/prog/sensors/chips.c	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.c	2007-08-21 20:39:20.000000000 +0200
@@ -92,7 +92,7 @@ void print_vid_info(const sensors_chip_n
   double vid;
 
   if ((label = sensors_get_label(name, f_vid))
-      && !sensors_get_feature(name, f_vid, &vid)) {
+      && !sensors_get_value(name, f_vid, &vid)) {
     print_label(label, label_size);
     printf("%+6.3f V\n", vid);
   }
@@ -113,7 +113,7 @@ void print_unknown_chip(const sensors_ch
       continue;
     }
     if (data->mode & SENSORS_MODE_R) {
-      if(sensors_get_feature(name, data->number, &val)) {
+      if (sensors_get_value(name, data->number, &val)) {
         printf("ERROR: Can't get feature `%s' data!\n",data->name);
         continue;
       }
--- lm-sensors-3.orig/prog/sensors/chips_generic.c	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips_generic.c	2007-08-21 20:39:20.000000000 +0200
@@ -30,7 +30,7 @@ static int get_feature_value(const senso
                              const sensors_feature_data *feature, 
                              double *val)
 {
-  return sensors_get_feature(name, feature->number, val);
+  return sensors_get_value(name, feature->number, val);
 }
 
 static void sensors_get_available_features(const sensors_chip_name *name, 
--- lm-sensors-3.orig/lib/access.c	2007-08-21 20:38:49.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-08-21 20:50:24.000000000 +0200
@@ -216,8 +216,8 @@ static int sensors_get_ignored(const sen
 /* Read the value of a feature of a certain chip. Note that chip should not
    contain wildcard values! This function will return 0 on success, and <0
    on failure. */
-int sensors_get_feature(const sensors_chip_name *name, int feature,
-			double *result)
+int sensors_get_value(const sensors_chip_name *name, int feature,
+		      double *result)
 {
 	const sensors_chip_feature *main_feature;
 	const sensors_chip_feature *alt_feature;
@@ -261,8 +261,8 @@ int sensors_get_feature(const sensors_ch
 /* Set the value of a feature of a certain chip. Note that chip should not
    contain wildcard values! This function will return 0 on success, and <0
    on failure. */
-int sensors_set_feature(const sensors_chip_name *name, int feature,
-			double value)
+int sensors_set_value(const sensors_chip_name *name, int feature,
+		      double value)
 {
 	const sensors_chip_feature *main_feature;
 	const sensors_chip_feature *alt_feature;
@@ -377,7 +377,7 @@ int sensors_eval_expr(const sensors_chip
 		if (!(feature = sensors_lookup_feature_name(name,
 							    expr->data.var)))
 			return SENSORS_ERR_NO_ENTRY;
-		if (!(res = sensors_get_feature(name, feature->data.number, result)))
+		if (!(res = sensors_get_value(name, feature->data.number, result)))
 			return res;
 		return 0;
 	}
@@ -461,7 +461,7 @@ static int sensors_do_this_chip_sets(con
 				err = res;
 				continue;
 			}
-			if ((res = sensors_set_feature(name, feature_nr, value))) {
+			if ((res = sensors_set_value(name, feature_nr, value))) {
 				sensors_parse_error("Failed to set feature",
 						chip->sets[i].lineno);
 				err = res;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
