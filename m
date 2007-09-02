From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:07:32 +0000
Subject: [lm-sensors] [PATCH 2/7] libsensors4: Rename
Message-Id: <20070902220732.072bd6b0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rename sensors_feature_data.mode to flags, as we plan to use it to
store non-mode flags soon.

---
 lib/access.c         |    4 ++--
 lib/data.h           |    2 +-
 lib/libsensors.3     |    4 ++--
 lib/sensors.h        |    4 ++--
 lib/sysfs.c          |    4 ++--
 prog/sensord/sense.c |    2 +-
 prog/sensors/chips.c |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

--- lm-sensors-3.orig/lib/sensors.h	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-09-02 16:16:53.000000000 +0200
@@ -112,7 +112,7 @@ int sensors_do_chip_sets(const sensors_c
 const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
 						    *match, int *nr);
 
-/* These defines are used in the mode field of sensors_feature_data */
+/* These defines are used in the flags field of sensors_feature_data */
 #define SENSORS_MODE_R 1
 #define SENSORS_MODE_W 2
 
@@ -164,7 +164,7 @@ typedef struct sensors_feature_data {
 	sensors_feature_type type;
 	int mapping;
 	int compute_mapping;
-	int mode;
+	unsigned int flags;
 } sensors_feature_data;
 
 /* This returns all features of a specific chip. They are returned in
--- lm-sensors-3.orig/lib/access.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-09-02 16:16:53.000000000 +0200
@@ -238,7 +238,7 @@ int sensors_get_value(const sensors_chip
 		alt_feature = sensors_lookup_feature_nr(name,
 					main_feature->data.compute_mapping);
 
-	if (!(main_feature->data.mode & SENSORS_MODE_R))
+	if (!(main_feature->data.flags & SENSORS_MODE_R))
 		return -SENSORS_ERR_ACCESS_R;
 	for (chip = NULL;
 	     !expr && (chip = sensors_for_all_config_chips(name, chip));)
@@ -285,7 +285,7 @@ int sensors_set_value(const sensors_chip
 		alt_feature = sensors_lookup_feature_nr(name,
 					main_feature->data.compute_mapping);
 
-	if (!(main_feature->data.mode & SENSORS_MODE_W))
+	if (!(main_feature->data.flags & SENSORS_MODE_W))
 		return -SENSORS_ERR_ACCESS_W;
 	for (chip = NULL;
 	     !expr && (chip = sensors_for_all_config_chips(name, chip));)
--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 16:16:53.000000000 +0200
@@ -153,9 +153,9 @@ static int sensors_read_dynamic_chip(sen
 		}
 
 		if (attr->method & SYSFS_METHOD_SHOW)
-			feature.data.mode |= SENSORS_MODE_R;
+			feature.data.flags |= SENSORS_MODE_R;
 		if (attr->method & SYSFS_METHOD_STORE)
-			feature.data.mode |= SENSORS_MODE_W;
+			feature.data.flags |= SENSORS_MODE_W;
 
 		feature.scaling = get_type_scaling(type);
 
--- lm-sensors-3.orig/prog/sensord/sense.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/prog/sensord/sense.c	2007-09-02 16:16:53.000000000 +0200
@@ -88,7 +88,7 @@ readUnknownChip
     if (!(label = sensors_get_label (chip, sensor->number))) {
       sensorLog (LOG_ERR, "Error getting sensor label: %s/%s", chip->prefix, sensor->name);
       ret = 21;
-    } else if (!(sensor->mode & SENSORS_MODE_R)) {
+    } else if (!(sensor->flags & SENSORS_MODE_R)) {
       sensorLog (LOG_INFO, "%s: %s", sensor->name, label);
     } else if ((ret = sensors_get_value (chip, sensor->number, &value))) {
       sensorLog (LOG_ERR, "Error getting sensor data: %s/%s: %s", chip->prefix, sensor->name, sensors_strerror (ret));
--- lm-sensors-3.orig/prog/sensors/chips.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.c	2007-09-02 16:16:53.000000000 +0200
@@ -41,7 +41,7 @@ void print_chip_raw(const sensors_chip_n
 			       data->name);
 			continue;
 		}
-		if (data->mode & SENSORS_MODE_R) {
+		if (data->flags & SENSORS_MODE_R) {
 			if (sensors_get_value(name, data->number, &val))
 				printf("ERROR: Can't get feature `%s' data!\n",
 				       data->name);
--- lm-sensors-3.orig/lib/data.h	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/data.h	2007-09-02 16:16:53.000000000 +0200
@@ -132,7 +132,7 @@ typedef struct sensors_bus {
    compute_mapping is like logical_mapping, only it refers to another
      feature whose compute line will be inherited (a group could be fan and
      fan_max, but not fan_div)
-   mode is a bitfield, its value is a combination of SENSORS_MODE_R (readable)
+   flags is a bitfield, its value is a combination of SENSORS_MODE_R (readable)
      and SENSORS_MODE_W (writable).
    scaling is the number of decimal points to scale by.
      Divide the read value by 10**scaling to get the real value. */
--- lm-sensors-3.orig/lib/libsensors.3	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-09-02 16:16:53.000000000 +0200
@@ -115,11 +115,11 @@ This structure is used when you want to 
 .br
   int compute_mapping;
 .br
-  int mode;
+  unsigned int flags;
 .br
 } sensors_feature_data;\fP
 .br
-The mode field is a bitfield, its value is a combination of
+The flags field is a bitfield, its value is a combination of
 SENSORS_MODE_R (readable) and SENSORS_MODE_W (writable).
 
 \fBconst sensors_feature_data *sensors_get_all_features


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
