From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:23:33 +0000
Subject: [lm-sensors] [PATCH 7/7] libsensors4: Don't store scaling factors
Message-Id: <20070902222333.6a46e91b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now that we can deduce the scaling factor required for each feature
from its type, there's no need to store this scaling factor. We can
instead compute it at runtime. This saves some memory (about 10 kB
in my real-world test), and the runtime overhead is totally
negligible.

Note that the structures sensors_chip_feature and sensors_feature_data
are now exactly the same, so we could use one structure everywhere.
The only advantage to have two structures is that sensors_feature_data
is part of the API, while sensors_chip_feature is not, so if we
ever need to add internal attributes, for example to improve performance,
having an internal structure can be helpful. Question is, will we
actually ever need this? Opinion anyone?

---
 lib/data.h  |    5 +----
 lib/sysfs.c |   18 ++++++------------
 2 files changed, 7 insertions(+), 16 deletions(-)

--- lm-sensors-3.orig/lib/data.h	2007-09-02 16:18:38.000000000 +0200
+++ lm-sensors-3/lib/data.h	2007-09-02 16:22:06.000000000 +0200
@@ -131,12 +131,9 @@ typedef struct sensors_bus {
      fan_div)
    flags is a bitfield, its value is a combination of SENSORS_MODE_R (readable),
      SENSORS_MODE_W (writable) and SENSORS_COMPUTE_MAPPING (affected by the
-     computation rules of the main feature).
-   scaling is the number of decimal points to scale by.
-     Divide the read value by 10**scaling to get the real value. */
+     computation rules of the main feature). */
 typedef struct sensors_chip_feature {
 	sensors_feature_data data;
-	int scaling;
 } sensors_chip_feature;
 
 /* Internal data about all features of a type of chip */
--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 16:19:42.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 16:22:06.000000000 +0200
@@ -48,16 +48,16 @@ int get_type_scaling(int type)
 	switch (type & 0xFF10) {
 	case SENSORS_FEATURE_IN:
 	case SENSORS_FEATURE_TEMP:
-		return 3;
+		return 1000;
 	case SENSORS_FEATURE_FAN:
-		return 0;
+		return 1;
 	}
 
 	switch (type) {
 	case SENSORS_FEATURE_VID:
-		return 3;
+		return 1000;
 	default:
-		return 0;
+		return 1;
 	}
 }
 
@@ -155,8 +155,6 @@ static int sensors_read_dynamic_chip(sen
 		if (attr->method & SYSFS_METHOD_STORE)
 			feature.data.flags |= SENSORS_MODE_W;
 
-		feature.scaling = get_type_scaling(type);
-
 		features[i] = feature;
 		fnum++;
 	}
@@ -422,7 +420,6 @@ int sensors_read_sysfs_attr(const sensor
 			    double *value)
 {
 	const sensors_chip_feature *the_feature;
-	int mag;
 	char n[NAME_MAX];
 	FILE *f;
 	const char *suffix = "";
@@ -443,8 +440,7 @@ int sensors_read_sysfs_attr(const sensor
 		fclose(f);
 		if (res != 1)
 			return -SENSORS_ERR_PROC;
-		for (mag = the_feature->scaling; mag > 0; mag --)
-			*value /= 10.0;
+		*value /= get_type_scaling(the_feature->data.type);
 	} else
 		return -SENSORS_ERR_PROC;
 
@@ -455,7 +451,6 @@ int sensors_write_sysfs_attr(const senso
 			     double value)
 {
 	const sensors_chip_feature *the_feature;
-	int mag;
 	char n[NAME_MAX];
 	FILE *f;
 	const char *suffix = "";
@@ -472,8 +467,7 @@ int sensors_write_sysfs_attr(const senso
 	snprintf(n, NAME_MAX, "%s/%s%s", name->path, the_feature->data.name,
 		 suffix);
 	if ((f = fopen(n, "w"))) {
-		for (mag = the_feature->scaling; mag > 0; mag --)
-			value *= 10.0;
+		value *= get_type_scaling(the_feature->data.type);
 		fprintf(f, "%d", (int) value);
 		fclose(f);
 	} else


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
