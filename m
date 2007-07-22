From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 14:48:16 +0000
Subject: [lm-sensors] [PATCH 3/4] Delete sensors_get_label_and_valid()
Message-Id: <20070722164816.6b8bdd65@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We no longer need sensors_get_label_and_valid(), as it does hardly
more than sensors_get_label(). This allows for some cleanups.

---
 prog/sensors/chips.c         |   24 +++++-------------------
 prog/sensors/chips.h         |    2 --
 prog/sensors/chips_generic.c |   31 ++++++++++---------------------
 3 files changed, 15 insertions(+), 42 deletions(-)

--- lm-sensors-3.orig/prog/sensors/chips.c	2007-07-22 15:42:06.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.c	2007-07-22 16:14:05.000000000 +0200
@@ -86,46 +86,32 @@ void print_label(const char *label, int 
     printf("%s:%*s", label, space - len, "");
 }
 
-int sensors_get_label_and_valid(sensors_chip_name name, int feature, char **label,
-                        int *valid)
-{
-  int err;
-  err = sensors_get_label(name,feature,label);
-  *valid = !err;
-  return err;
-}
-
 void print_vid_info(const sensors_chip_name *name, int f_vid, int label_size)
 {
   char *label;
-  int valid;
   double vid;
 
-  if (!sensors_get_label_and_valid(*name,f_vid,&label,&valid)
+  if (!sensors_get_label(*name, f_vid, &label)
       && !sensors_get_feature(*name,f_vid,&vid) ) {
-    if (valid) {
-      print_label(label, label_size);
-      printf("%+6.3f V\n", vid);
-    }
+    print_label(label, label_size);
+    printf("%+6.3f V\n", vid);
   }
   free(label);
 }
 
 void print_unknown_chip(const sensors_chip_name *name)
 {
-  int a, valid;
+  int a;
   const sensors_feature_data *data;
   char *label;
   double val;
  
   a = 0;
   while((data=sensors_get_all_features(*name, &a))) {
-    if (sensors_get_label_and_valid(*name,data->number,&label,&valid)) {
+    if (sensors_get_label(*name, data->number, &label)) {
       printf("ERROR: Can't get feature `%s' data!\n",data->name);
       continue;
     }
-    if (! valid)
-      continue;
     if (data->mode & SENSORS_MODE_R) {
       if(sensors_get_feature(*name,data->number,&val)) {
         printf("ERROR: Can't get feature `%s' data!\n",data->name);
--- lm-sensors-3.orig/prog/sensors/chips.h	2007-07-22 15:28:33.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.h	2007-07-22 16:14:05.000000000 +0200
@@ -38,6 +38,4 @@ void print_vid_info(const sensors_chip_n
 
 void print_label(const char *label, int space);
 
-int sensors_get_label_and_valid(sensors_chip_name name, int feature, char **label,
-                        int *valid);
 #endif /* def PROG_SENSORS_CHIPS_H */
--- lm-sensors-3.orig/prog/sensors/chips_generic.c	2007-07-22 15:28:33.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips_generic.c	2007-07-22 16:14:05.000000000 +0200
@@ -62,15 +62,15 @@ static void sensors_get_available_featur
 
 static int sensors_get_label_size(const sensors_chip_name *name)
 {
-  int i, valid;
+  int i;
   const sensors_feature_data *iter;
   char *label;
   unsigned int max_size = 11; /* Initialised to 11 as minumum label-width */
 
   i = 0;
   while((iter = sensors_get_all_features(*name, &i))) {
-    if (!sensors_get_label_and_valid(*name, iter->number, &label, &valid) &&
-        valid && strlen(label) > max_size)
+    if (!sensors_get_label(*name, iter->number, &label) &&
+        strlen(label) > max_size)
       max_size = strlen(label);
     free(label);
   }
@@ -93,18 +93,15 @@ static void print_generic_chip_temp(cons
 {
   double val, max, min;
   char *label;
-  int valid, type;
+  int type;
   const int size = SENSORS_FEATURE_TEMP_SENS - SENSORS_FEATURE_TEMP;
   short has_features[SENSORS_FEATURE_TEMP_SENS - SENSORS_FEATURE_TEMP] = {0, };
   double feature_vals[SENSORS_FEATURE_TEMP_SENS - SENSORS_FEATURE_TEMP] = {0.0, };
   
-  if (sensors_get_label_and_valid(*name, feature->number, &label, &valid)) {
+  if (sensors_get_label(*name, feature->number, &label)) {
     free(label);
-    printf("ERROR: Can't get temperature data!\n");
+    printf("ERROR: Can't get temperature label!\n");
     return;
-  } else if (!valid) {
-    free(label);
-    return; /* ignored */
   }
   
   if (get_feature_value(name, feature, &val)) {
@@ -210,19 +207,15 @@ static void print_generic_chip_in(const 
                                   int i, int label_size)
 {
   const int size = SENSORS_FEATURE_IN_MAX_ALARM - SENSORS_FEATURE_IN;
-  int valid;
   short has_features[SENSORS_FEATURE_IN_MAX_ALARM - SENSORS_FEATURE_IN] = {0, };
   double feature_vals[SENSORS_FEATURE_IN_MAX_ALARM - SENSORS_FEATURE_IN] = {0.0, };
   double val, alarm_max, alarm_min;
   char *label;
   
-  if (sensors_get_label_and_valid(*name, feature->number, &label, &valid)) {
+  if (sensors_get_label(*name, feature->number, &label)) {
     free(label);
-    printf("ERROR: Can't get in data!\n");
+    printf("ERROR: Can't get in label!\n");
     return;
-  } else if (!valid) {
-    free(label);
-    return; /* ignored */
   }
   
   if (get_feature_value(name, feature, &val)) {
@@ -277,19 +270,15 @@ static void print_generic_chip_fan(const
                                    int i, int label_size)
 {
   char *label;
-  int valid;
   const int size = SENSORS_FEATURE_FAN_DIV - SENSORS_FEATURE_FAN;
   short has_features[SENSORS_FEATURE_FAN_DIV - SENSORS_FEATURE_FAN] = {0, };
   double feature_vals[SENSORS_FEATURE_FAN_DIV - SENSORS_FEATURE_FAN] = {0.0, };
   double val;
   
-  if (sensors_get_label_and_valid(*name, feature->number, &label, &valid)) {
-    printf("ERROR: Can't get fan data!\n");
+  if (sensors_get_label(*name, feature->number, &label)) {
+    printf("ERROR: Can't get fan label!\n");
     free(label);
     return;
-  } else if (!valid) {
-    free(label);
-    return; /* ignored */
   }
   
   if (get_feature_value(name, feature, &val))


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
