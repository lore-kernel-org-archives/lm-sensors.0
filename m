From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 14:37:35 +0000
Subject: [lm-sensors] [PATCH 1/4] Simplify sensors_get_all_features()
Message-Id: <20070722163735.3c0df2bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The way we build the feature lists guarantees that subfeatures always
immediately follow their main feature. This makes it possible to simplify
sensors_get_all_features() quite a bit. We no longer need to maintain
separate pointers for the last main feature and the last subfeature,
we can simply walk the list linearly.

Note that I am still not entirely happy with this API. It was obviously
designed for debugging purposes (sensors -u) and without performance
concernes nor interface cleanliness in mind. I believe that we want to
tag main features and subfeatures as such, and let the application ask
specifically for the list of main features, and for each feature, for
its list of subfeatures (i.e. two functions instead of one.)

---
 lib/access.c                 |   21 ++++-----------------
 lib/libsensors.3             |   12 +++++++++---
 lib/sensors.h                |    6 +++---
 prog/sensors/chips.c         |    6 +++---
 prog/sensors/chips_generic.c |   34 +++++++++++++++++-----------------
 5 files changed, 36 insertions(+), 43 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-22 14:52:57.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-22 15:28:33.000000000 +0200
@@ -333,9 +333,9 @@ const char *sensors_get_adapter_name(int
 	return NULL;
 }
 
-/* nr1-1 is the last main feature found; nr2-1 is the last subfeature found */
+/* nr-1 is the last feature returned */
 const sensors_feature_data *sensors_get_all_features(sensors_chip_name name,
-						     int *nr1, int *nr2)
+						     int *nr)
 {
 	sensors_chip_feature *feature_list;
 	int i;
@@ -343,22 +343,9 @@ const sensors_feature_data *sensors_get_
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(sensors_proc_chips[i].chip, name)) {
 			feature_list = sensors_proc_chips[i].feature;
-			if (!*nr1 && !*nr2) {	/* Return the first entry */
-				*nr1 = *nr2 = 1;
-				return &feature_list->data;
-			}
-			for ((*nr2)++; feature_list[*nr2 - 1].data.name; (*nr2)++)
-				if (feature_list[*nr2 - 1].data.mapping =
-				    feature_list[*nr1 - 1].data.number)
-					return &((feature_list + *nr2 - 1)->data);
-			for ((*nr1)++;
-			     feature_list[*nr1 - 1].data.name
-			     && (feature_list[*nr1 - 1].data.mapping !-				 SENSORS_NO_MAPPING); (*nr1)++) ;
-			*nr2 = *nr1;
-			if (!feature_list[*nr1 - 1].data.name)
+			if (!feature_list[*nr].data.name)
 				return NULL;
-			return &((feature_list + *nr1 - 1)->data);
+			return &feature_list[(*nr)++].data;
 		}
 	return NULL;
 }
--- lm-sensors-3.orig/lib/sensors.h	2007-07-22 14:52:57.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-07-22 15:28:33.000000000 +0200
@@ -179,13 +179,13 @@ typedef struct sensors_feature_data {
 /* This returns all features of a specific chip. They are returned in
    bunches: everything with the same mapping is returned just after each
    other, with the master feature in front (that feature does not map to
-   itself, but has SENSORS_NO_MAPPING as mapping field). nr1 and nr2 are
-   two internally used variables. Set both to zero to start again at the
+   itself, but has SENSORS_NO_MAPPING as mapping field). nr is
+   an internally used variable. Set it to zero to start again at the
    begin of the list. If no more features are found NULL is returned.
    Do not try to change the returned structure; you will corrupt internal
    data structures. */
 extern const sensors_feature_data *sensors_get_all_features
-             (sensors_chip_name name, int *nr1,int *nr2);
+             (sensors_chip_name name, int *nr);
 
 #ifdef __cplusplus
 }
--- lm-sensors-3.orig/prog/sensors/chips.c	2007-07-22 14:52:57.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.c	2007-07-22 15:28:33.000000000 +0200
@@ -118,13 +118,13 @@ void print_vid_info(const sensors_chip_n
 
 void print_unknown_chip(const sensors_chip_name *name)
 {
-  int a,b,valid;
+  int a, valid;
   const sensors_feature_data *data;
   char *label;
   double val;
  
-  a=b=0;
-  while((data=sensors_get_all_features(*name,&a,&b))) {
+  a = 0;
+  while((data=sensors_get_all_features(*name, &a))) {
     if (sensors_get_label_and_valid(*name,data->number,&label,&valid)) {
       printf("ERROR: Can't get feature `%s' data!\n",data->name);
       continue;
--- lm-sensors-3.orig/prog/sensors/chips_generic.c	2007-07-22 14:52:57.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips_generic.c	2007-07-22 15:28:33.000000000 +0200
@@ -35,7 +35,7 @@ static int get_feature_value(const senso
 
 static void sensors_get_available_features(const sensors_chip_name *name, 
                                            const sensors_feature_data *feature, 
-                                           int i, int j, 
+                                           int i,
                                            short *has_features, 
                                            double *feature_vals, 
                                            int size, 
@@ -43,7 +43,7 @@ static void sensors_get_available_featur
 {
   const sensors_feature_data *iter;
   
-  while((iter = sensors_get_all_features(*name, &i, &j)) && 
+  while((iter = sensors_get_all_features(*name, &i)) &&
       iter->mapping = feature->number) {
     int indx;
     
@@ -62,13 +62,13 @@ static void sensors_get_available_featur
 
 static int sensors_get_label_size(const sensors_chip_name *name)
 {
-  int i, j, valid;
+  int i, valid;
   const sensors_feature_data *iter;
   char *label;
   unsigned int max_size = 11; /* Initialised to 11 as minumum label-width */
 
-  i = j = 0;
-  while((iter = sensors_get_all_features(*name, &i, &j))) {
+  i = 0;
+  while((iter = sensors_get_all_features(*name, &i))) {
     if (!sensors_get_label_and_valid(*name, iter->number, &label, &valid) &&
         valid && strlen(label) > max_size)
       max_size = strlen(label);
@@ -89,7 +89,7 @@ static inline float deg_ctof(float cel)
 #define TEMP_FEATURE_VAL(x) feature_vals[x - SENSORS_FEATURE_TEMP - 1]
 static void print_generic_chip_temp(const sensors_chip_name *name, 
                                     const sensors_feature_data *feature,
-                                    int i, int j, int label_size)
+                                    int i, int label_size)
 {
   double val, max, min;
   char *label;
@@ -113,7 +113,7 @@ static void print_generic_chip_temp(cons
     return;
   }
   
-  sensors_get_available_features(name, feature, i, j, has_features, 
+  sensors_get_available_features(name, feature, i, has_features,
       feature_vals, size, SENSORS_FEATURE_TEMP);
   
   if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX)) {
@@ -207,7 +207,7 @@ static void print_generic_chip_temp(cons
 #define IN_FEATURE_VAL(x) feature_vals[x - SENSORS_FEATURE_IN - 1]
 static void print_generic_chip_in(const sensors_chip_name *name, 
                                   const sensors_feature_data *feature,
-                                  int i, int j, int label_size)
+                                  int i, int label_size)
 {
   const int size = SENSORS_FEATURE_IN_MAX_ALARM - SENSORS_FEATURE_IN;
   int valid;
@@ -231,7 +231,7 @@ static void print_generic_chip_in(const 
     return;
   }
   
-  sensors_get_available_features(name, feature, i, j, has_features, feature_vals,
+  sensors_get_available_features(name, feature, i, has_features, feature_vals,
       size, SENSORS_FEATURE_IN);
   
   print_label(label, label_size);
@@ -274,7 +274,7 @@ static void print_generic_chip_in(const 
 #define FAN_FEATURE_VAL(x) feature_vals[x - SENSORS_FEATURE_FAN - 1]
 static void print_generic_chip_fan(const sensors_chip_name *name, 
                                    const sensors_feature_data *feature,
-                                   int i, int j, int label_size)
+                                   int i, int label_size)
 {
   char *label;
   int valid;
@@ -308,7 +308,7 @@ static void print_generic_chip_fan(const
   else
     printf("%4.0f RPM", val);
   
-  sensors_get_available_features(name, feature, i, j, has_features, feature_vals,
+  sensors_get_available_features(name, feature, i, has_features, feature_vals,
       size, SENSORS_FEATURE_FAN);
   
   if (FAN_FEATURE(SENSORS_FEATURE_FAN_MIN) &&
@@ -332,22 +332,22 @@ static void print_generic_chip_fan(const
 void print_generic_chip(const sensors_chip_name *name)
 {
   const sensors_feature_data *feature;
-  int i,j, label_size;
+  int i, label_size;
   
   label_size = sensors_get_label_size(name);
   
-  i = j = 0;
-  while((feature = sensors_get_all_features(*name, &i, &j))) {
+  i = 0;
+  while((feature = sensors_get_all_features(*name, &i))) {
     if (feature->mapping != SENSORS_NO_MAPPING)
       continue;
     
     switch (feature->type) {
       case SENSORS_FEATURE_TEMP:
-        print_generic_chip_temp(name, feature, i, j, label_size); break;
+        print_generic_chip_temp(name, feature, i, label_size); break;
       case SENSORS_FEATURE_IN:
-        print_generic_chip_in(name, feature, i, j, label_size); break;
+        print_generic_chip_in(name, feature, i, label_size); break;
       case SENSORS_FEATURE_FAN:
-        print_generic_chip_fan(name, feature, i, j, label_size); break;
+        print_generic_chip_fan(name, feature, i, label_size); break;
       case SENSORS_FEATURE_VID:
         print_vid_info(name, feature->number, label_size); break;
       default: continue;
--- lm-sensors-3.orig/lib/libsensors.3	2007-07-22 14:52:57.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-07-22 14:53:40.000000000 +0200
@@ -49,7 +49,7 @@ libsensors \- publicly accessible functi
 .B extern int sensors_do_all_sets(void);
 .B const sensors_chip_name *sensors_get_detected_chips(int *nr);
 .B const sensors_feature_data *sensors_get_all_features 
-             \fB(sensors_chip_name name, int *nr1,int *nr2);\fP
+             \fB(sensors_chip_name name, int *nr);\fP
 .B const char *libsensors_version;
 .fi
 .SH DESCRIPTION
@@ -133,9 +133,15 @@ The mode field can be one of:
 SENSORS_MODE_NO_RW, SENSORS_MODE_R, SENSORS_MODE_W or SENSORS_MODE_RW.
 
 \fBconst sensors_feature_data *sensors_get_all_features
-      (sensors_chip_name name, int *nr1,int *nr2);\fP
+      (sensors_chip_name name, int *nr);\fP
 .br
-This returns all features of a specific chip. They are returned in bunches: everything with the same mapping is returned just after each other, with the master feature in front (that feature does not map to itself, but has SENSORS_NO_MAPPING as mapping field). nr1 and nr2 are two internally used variables. Set both to zero to start again at the begin of the list. If no more features are found NULL is returned. Do not try to change the returned structure; you will corrupt internal data structures.
+This returns all features of a specific chip. They are returned in bunches:
+everything with the same mapping is returned just after each other, with
+the master feature in front (that feature does not map to itself, but
+has SENSORS_NO_MAPPING as mapping field). nr is an internally used variable.
+Set it to zero to start again at the begin of the list. If no more features
+are found NULL is returned. Do not try to change the returned structure; you
+will corrupt internal data structures.
 
 \fBconst char *libsensors_version;\fP
 .br


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
