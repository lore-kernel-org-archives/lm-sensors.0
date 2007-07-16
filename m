From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jul 2007 13:21:29 +0000
Subject: [lm-sensors] [PATCH 1/3] libsensors4: Add type to struct
Message-Id: <20070716152129.6aab923f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The way we use sensors_feature_get_type() is rather suboptimal. It is
first called during the library initialization to generate the feature
tables. Then it is called again by sensors itself. This is because we
do not store the result the first time. I propose that we add a type
field to struct sensors_feature_data, where libsensors would store
the result of sensors_feature_get_type(). That way, the application
can get the information without calling sensors_feature_get_type()
again.

This change has the following benefits:
* Obviously, a small speed-up.
* sensors_feature_get_type() can be removed from the public interface.
  This means that we can turn it into something that fits the
  libsensors needs better, allowing for more optimizations (see next
  patches.)

Note: the patch looks bigger that it really is, because I had to move
definitions around in sensors.h.

---
 lib/access.h                 |    2 +
 lib/sensors.h                |   44 ++++++++++++++++++++----------------------
 lib/sysfs.c                  |    1 
 prog/sensors/chips_generic.c |    8 +------
 4 files changed, 26 insertions(+), 29 deletions(-)

--- lm-sensors-3.orig/lib/sensors.h	2007-07-16 14:03:40.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-07-16 14:09:00.000000000 +0200
@@ -125,27 +125,6 @@ extern const sensors_chip_name *sensors_
    mapping is available */
 #define SENSORS_NO_MAPPING -1
 
-/* This structure is used when you want to get all features of a specific
-   chip. */
-typedef struct sensors_feature_data {
-  int number;
-  char *name;
-  int mapping;
-  int compute_mapping;
-  int mode;
-} sensors_feature_data;
-
-/* This returns all features of a specific chip. They are returned in 
-   bunches: everything with the same mapping is returned just after each
-   other, with the master feature in front (that feature does not map to
-   itself, but has SENSORS_NO_MAPPING as mapping field). nr1 and nr2 are
-   two internally used variables. Set both to zero to start again at the
-   begin of the list. If no more features are found NULL is returned.
-   Do not try to change the returned structure; you will corrupt internal
-   data structures. */
-extern const sensors_feature_data *sensors_get_all_features 
-             (sensors_chip_name name, int *nr1,int *nr2);
-
 /* This enum contains some "magic" used by sensors_read_dynamic_chip() from
    lib/sysfs.c. All the sensor types (in, fan, temp, vid) are a multiple of
    0x100 apart, and sensor features which should not have a compute_mapping to
@@ -186,8 +165,27 @@ typedef enum sensors_feature_type {
   SENSORS_FEATURE_MAX_SUB_FEATURES = 22
 } sensors_feature_type;
 
-sensors_feature_type sensors_feature_get_type
-  	     (const sensors_feature_data *feature);
+/* This structure is used when you want to get all features of a specific
+   chip. */
+typedef struct sensors_feature_data {
+  int number;
+  char *name;
+  sensors_feature_type type;
+  int mapping;
+  int compute_mapping;
+  int mode;
+} sensors_feature_data;
+
+/* This returns all features of a specific chip. They are returned in
+   bunches: everything with the same mapping is returned just after each
+   other, with the master feature in front (that feature does not map to
+   itself, but has SENSORS_NO_MAPPING as mapping field). nr1 and nr2 are
+   two internally used variables. Set both to zero to start again at the
+   begin of the list. If no more features are found NULL is returned.
+   Do not try to change the returned structure; you will corrupt internal
+   data structures. */
+extern const sensors_feature_data *sensors_get_all_features
+             (sensors_chip_name name, int *nr1,int *nr2);
 
 #ifdef __cplusplus
 }
--- lm-sensors-3.orig/lib/sysfs.c	2007-07-16 14:07:31.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-07-16 14:09:00.000000000 +0200
@@ -148,6 +148,7 @@ static int sensors_read_dynamic_chip(sen
 		
 		/* fill in the other feature members */
 		feature.data.number = i + 1;
+		feature.data.type = type;
 			
 		if ((type & 0x00FF) = 0) {
 			/* main feature */
--- lm-sensors-3.orig/prog/sensors/chips_generic.c	2007-07-16 14:03:40.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips_generic.c	2007-07-16 14:09:00.000000000 +0200
@@ -46,13 +46,9 @@ static void sensors_get_available_featur
   while((iter = sensors_get_all_features(*name, &i, &j)) && 
       iter->mapping != SENSORS_NO_MAPPING &&
       iter->mapping = feature->number) {
-    sensors_feature_type type = sensors_feature_get_type(iter);
     int indx;
     
-    if (type = SENSORS_FEATURE_UNKNOWN)
-      continue;
-    
-    indx = type - first_val - 1;
+    indx = iter->type - first_val - 1;
     if (indx < 0 || indx >= size) {
       printf("ERROR: Bug in sensors: index out of bound");
       return;
@@ -345,7 +341,7 @@ void print_generic_chip(const sensors_ch
     if (feature->mapping != SENSORS_NO_MAPPING)
       continue;
     
-    switch(sensors_feature_get_type(feature)) {
+    switch (feature->type) {
       case SENSORS_FEATURE_TEMP:
         print_generic_chip_temp(name, feature, i, j, label_size); break;
       case SENSORS_FEATURE_IN:
--- lm-sensors-3.orig/lib/access.h	2007-07-16 14:03:40.000000000 +0200
+++ lm-sensors-3/lib/access.h	2007-07-16 14:09:00.000000000 +0200
@@ -29,4 +29,6 @@
 extern const sensors_chip_feature *sensors_lookup_feature_nr(const sensors_chip_name *chip,
                                                              int feature);
 
+sensors_feature_type sensors_feature_get_type(const sensors_feature_data *feature);
+
 #endif /* def LIB_SENSORS_ACCESS_H */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
