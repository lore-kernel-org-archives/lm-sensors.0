From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:11:36 +0000
Subject: [lm-sensors] [PATCH 3/7] libsensors4: Compute mapping as a flag
Message-Id: <20070902221136.6b060a26@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The compute mapping value is either SENSORS_NO_MAPPING or the same
feature number as the logical mapping. This means that the compute
mapping can be turned into a simple boolean flag. Doing so makes
struct sensors_feature_data smaller, which saves some memory (about
17 kB in my tests.)

---
 lib/access.c     |   18 +++++++++---------
 lib/data.h       |   10 ++++------
 lib/libsensors.3 |    5 ++---
 lib/sensors.h    |    8 ++++----
 lib/sysfs.c      |    9 +++------
 5 files changed, 22 insertions(+), 28 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-09-02 14:04:17.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-09-02 14:04:21.000000000 +0200
@@ -190,7 +190,7 @@ sensors_get_label_exit:
 
 /* Looks up whether a feature should be ignored. Returns
    1 if it should be ignored, 0 if not. This function takes
-   logical mappings into account. */
+   mappings into account. */
 static int sensors_get_ignored(const sensors_chip_name *name,
 			       const sensors_chip_feature *feature)
 {
@@ -232,11 +232,11 @@ int sensors_get_value(const sensors_chip
 	if (!(main_feature = sensors_lookup_feature_nr(name, feature)))
 		return -SENSORS_ERR_NO_ENTRY;
 
-	if (main_feature->data.compute_mapping = SENSORS_NO_MAPPING)
-		alt_feature = NULL;
-	else
+	if (main_feature->data.flags & SENSORS_COMPUTE_MAPPING)
 		alt_feature = sensors_lookup_feature_nr(name,
-					main_feature->data.compute_mapping);
+					main_feature->data.mapping);
+	else
+		alt_feature = NULL;
 
 	if (!(main_feature->data.flags & SENSORS_MODE_R))
 		return -SENSORS_ERR_ACCESS_R;
@@ -279,11 +279,11 @@ int sensors_set_value(const sensors_chip
 	if (!(main_feature = sensors_lookup_feature_nr(name, feature)))
 		return -SENSORS_ERR_NO_ENTRY;
 
-	if (main_feature->data.compute_mapping = SENSORS_NO_MAPPING)
-		alt_feature = NULL;
-	else
+	if (main_feature->data.flags & SENSORS_COMPUTE_MAPPING)
 		alt_feature = sensors_lookup_feature_nr(name,
-					main_feature->data.compute_mapping);
+					main_feature->data.mapping);
+	else
+		alt_feature = NULL;
 
 	if (!(main_feature->data.flags & SENSORS_MODE_W))
 		return -SENSORS_ERR_ACCESS_W;
--- lm-sensors-3.orig/lib/data.h	2007-09-02 14:04:17.000000000 +0200
+++ lm-sensors-3/lib/data.h	2007-09-02 14:04:21.000000000 +0200
@@ -125,15 +125,13 @@ typedef struct sensors_bus {
      files and through user functions);
    number is the internal feature number, used in many functions to refer
      to this feature
-   logical_mapping is either SENSORS_NO_MAPPING if this is feature is the
+   mapping is either SENSORS_NO_MAPPING if this is feature is the
      main element of category; or it is the number of a feature with which
      this feature is logically grouped (a group could be fan, fan_max and
      fan_div)
-   compute_mapping is like logical_mapping, only it refers to another
-     feature whose compute line will be inherited (a group could be fan and
-     fan_max, but not fan_div)
-   flags is a bitfield, its value is a combination of SENSORS_MODE_R (readable)
-     and SENSORS_MODE_W (writable).
+   flags is a bitfield, its value is a combination of SENSORS_MODE_R (readable),
+     SENSORS_MODE_W (writable) and SENSORS_COMPUTE_MAPPING (affected by the
+     computation rules of the main feature).
    scaling is the number of decimal points to scale by.
      Divide the read value by 10**scaling to get the real value. */
 typedef struct sensors_chip_feature {
--- lm-sensors-3.orig/lib/libsensors.3	2007-09-02 14:04:17.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-09-02 14:04:21.000000000 +0200
@@ -113,14 +113,13 @@ This structure is used when you want to 
 .br
   int mapping;
 .br
-  int compute_mapping;
-.br
   unsigned int flags;
 .br
 } sensors_feature_data;\fP
 .br
 The flags field is a bitfield, its value is a combination of
-SENSORS_MODE_R (readable) and SENSORS_MODE_W (writable).
+SENSORS_MODE_R (readable), SENSORS_MODE_W (writable) and SENSORS_COMPUTE_MAPPING
+(affected by the computation rules of the main feature).
 
 \fBconst sensors_feature_data *sensors_get_all_features
       (const sensors_chip_name *name, int *nr);\fP
--- lm-sensors-3.orig/lib/sensors.h	2007-09-02 14:04:17.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-09-02 14:04:21.000000000 +0200
@@ -113,8 +113,9 @@ const sensors_chip_name *sensors_get_det
 						    *match, int *nr);
 
 /* These defines are used in the flags field of sensors_feature_data */
-#define SENSORS_MODE_R 1
-#define SENSORS_MODE_W 2
+#define SENSORS_MODE_R			1
+#define SENSORS_MODE_W			2
+#define SENSORS_COMPUTE_MAPPING		4
 
 /* This define is used in the mapping field of sensors_feature_data if no
    mapping is available */
@@ -122,7 +123,7 @@ const sensors_chip_name *sensors_get_det
 
 /* This enum contains some "magic" used by sensors_read_dynamic_chip() from
    lib/sysfs.c. All the sensor types (in, fan, temp, vid) are a multiple of
-   0x100 apart, and sensor features which should not have a compute_mapping to
+   0x100 apart, and sensor features which should not have a compute mapping to
    the _input feature start at 0x?10. */
 typedef enum sensors_feature_type {
 	SENSORS_FEATURE_IN = 0x000,
@@ -163,7 +164,6 @@ typedef struct sensors_feature_data {
 	int number;
 	sensors_feature_type type;
 	int mapping;
-	int compute_mapping;
 	unsigned int flags;
 } sensors_feature_data;
 
--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 14:04:17.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 14:04:21.000000000 +0200
@@ -142,14 +142,11 @@ static int sensors_read_dynamic_chip(sen
 		if ((type & 0x00FF) = 0) {
 			/* main feature */
 			feature.data.mapping = SENSORS_NO_MAPPING;
-			feature.data.compute_mapping = SENSORS_NO_MAPPING;
-		} else if (type & 0x10) {
-			/* sub feature without compute mapping */
-			feature.data.mapping = i - i % MAX_SUB_FEATURES;
-			feature.data.compute_mapping = SENSORS_NO_MAPPING;
 		} else {
+			/* sub feature */
 			feature.data.mapping = i - i % MAX_SUB_FEATURES;
-			feature.data.compute_mapping = feature.data.mapping;
+			if (!(type & 0x10))
+				feature.data.flags |= SENSORS_COMPUTE_MAPPING;
 		}
 
 		if (attr->method & SYSFS_METHOD_SHOW)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
