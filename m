From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:21:10 +0000
Subject: [lm-sensors] [PATCH 6/7] libsensors4: Optimize the memory
Message-Id: <20070902222110.0653c5f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Optimize the memory consumption in sensors_read_dynamic_chip(). The
idea is to have separate indexing for subfeatures with a compute
mapping and for subfeatures without it. They still follow each
other in the big table but this avoids wasting memory due to the
numbering gap between them.

This cuts the amount of memory (temporarily) allocated by
sensors_read_dynamic_chip() almost by half, and also speeds it up
a little as it now takes less iterations to walk the sparse array.

---
 lib/sysfs.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 16:18:38.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 16:19:42.000000000 +0200
@@ -37,9 +37,9 @@
 char sensors_sysfs_mount[NAME_MAX];
 
 #define MAX_SENSORS_PER_TYPE	16
-#define MAX_SUB_FEATURES	22
+#define MAX_SUB_FEATURES	6
 /* Room for all 3 types (in, fan, temp) with all their subfeatures + VID */
-#define ALL_POSSIBLE_FEATURES	(MAX_SENSORS_PER_TYPE * MAX_SUB_FEATURES * 3 \
+#define ALL_POSSIBLE_FEATURES	(MAX_SENSORS_PER_TYPE * MAX_SUB_FEATURES * 6 \
 				 + MAX_SENSORS_PER_TYPE)
 
 static
@@ -120,11 +120,12 @@ static int sensors_read_dynamic_chip(sen
 		/* "calculate" a place to store the feature in our sparse,
 		   sorted table */
 		if (type = SENSORS_FEATURE_VID) {
-			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUB_FEATURES * 3;
+			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUB_FEATURES * 6;
 		} else {
 			i = (type >> 8) * MAX_SENSORS_PER_TYPE *
-				MAX_SUB_FEATURES + nr * MAX_SUB_FEATURES +
-				(type & 0xFF);
+			    MAX_SUB_FEATURES * 2 + nr * MAX_SUB_FEATURES * 2 +
+			    ((type & 0x10) >> 4) * MAX_SUB_FEATURES +
+			    (type & 0x0F);
 		}
 
 		if (features[i].data.name) {
@@ -144,7 +145,7 @@ static int sensors_read_dynamic_chip(sen
 			feature.data.mapping = SENSORS_NO_MAPPING;
 		} else {
 			/* sub feature */
-			feature.data.mapping = i - i % MAX_SUB_FEATURES;
+			feature.data.mapping = i - i % (MAX_SUB_FEATURES * 2);
 			if (!(type & 0x10))
 				feature.data.flags |= SENSORS_COMPUTE_MAPPING;
 		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
