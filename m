From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Dec 2010 12:58:42 +0000
Subject: [lm-sensors] [PATCH] libsensors: Compute MAX_SUBFEATURES dynamically
Message-Id: <20101213135842.73b08221@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reference: http://www.lm-sensors.org/ticket/2378

This is a candidate patch to let libsensors compute MAX_SUBFEATURES
dynamically. This should avoid accidental overflows when we add new
subfeatures.

An alternative is to keep it a constant and add code to check for
overflows. I had a patch ready, but if we are going to add code, I'd
rather add code that get things right than code which only spots when
things are wrong.

Then we can discuss what do to with the other constants.

MAX_MAIN_SENSOR_TYPES and MAX_OTHER_SENSOR_TYPES could be easily
computed in the same loops which now compute MAX_SUBFEATURES. It's only
a few code lines to add. OTOH it can be discussed whether they are
worth the runtime cost, given that adding a new feature is a rare
event, so we should be able to deal with it. I would like to hear
opinions about this.

Lastly, making MAX_SENSORS_PER_TYPE dynamic would be very nice, as it
would avoid allocating more memory than we need (and supporting
virtually unlimited channel numbers, if people have really big sensor
chips.) But this means reworking the discovery loop significantly, as
we would need a first pass to find out the maximum channel number. This
will come at a runtime cost which we want to minimize. And I do not
have the time to work on this at the moment.

---
 lib/sysfs.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

--- lm-sensors.orig/lib/sysfs.c	2010-12-13 10:50:42.000000000 +0100
+++ lm-sensors/lib/sysfs.c	2010-12-13 11:40:05.000000000 +0100
@@ -139,8 +139,8 @@ char sensors_sysfs_mount[NAME_MAX];
 #define MAX_MAIN_SENSOR_TYPES	6
 #define MAX_OTHER_SENSOR_TYPES	2
 #define MAX_SENSORS_PER_TYPE	24
-#define MAX_SUBFEATURES		8
-#define FEATURE_SIZE		(MAX_SUBFEATURES * 2)
+/* max_subfeatures is now computed dynamically */
+#define FEATURE_SIZE		(max_subfeatures * 2)
 #define FEATURE_TYPE_SIZE	(MAX_SENSORS_PER_TYPE * FEATURE_SIZE)
 
 /* Room for all 6 main types (in, fan, temp, power, energy, current) and 2
@@ -337,6 +337,31 @@ sensors_subfeature_type sensors_subfeatu
 	return SENSORS_SUBFEATURE_UNKNOWN;
 }
 
+static void sensors_compute_max(int *max_subfeatures)
+{
+	int i, j, offset;
+	const struct subfeature_type_match *submatches;
+	sensors_feature_type ftype;
+
+	for (i = 0; i < ARRAY_SIZE(matches); i++) {
+		submatches = matches[i].submatches;
+		for (j = 0; submatches[j].name != NULL; j++) {
+			ftype = submatches[j].type >> 8;
+
+			if (ftype < SENSORS_FEATURE_VID) {
+				offset = submatches[j].type & 0x7F;
+				if (offset >= *max_subfeatures)
+					*max_subfeatures = offset + 1;
+			} else {
+				offset = submatches[j].type & 0xFF;
+				if (offset >= *max_subfeatures * 2)
+					*max_subfeatures = ((offset + 1) + 1)
+							   / 2;
+			}
+		}
+	}
+}
+
 static int sensors_get_attr_mode(const char *device, const char *attr)
 {
 	char path[NAME_MAX];
@@ -357,6 +382,7 @@ static int sensors_read_dynamic_chip(sen
 				     const char *dev_path)
 {
 	int i, fnum = 0, sfnum = 0, prev_slot;
+	static int max_subfeatures;
 	DIR *dir;
 	struct dirent *ent;
 	sensors_subfeature *all_subfeatures;
@@ -368,6 +394,10 @@ static int sensors_read_dynamic_chip(sen
 	if (!(dir = opendir(dev_path)))
 		return -errno;
 
+	/* Dynamically figure out the max number of subfeatures */
+	if (!max_subfeatures)
+		sensors_compute_max(&max_subfeatures);
+
 	/* We use a large sparse table at first to store all found
 	   subfeatures, so that we can store them sorted at type and index
 	   and then later create a dense sorted table. */
@@ -430,7 +460,7 @@ static int sensors_read_dynamic_chip(sen
 		default:
 			i = ftype * FEATURE_TYPE_SIZE +
 			    nr * FEATURE_SIZE +
-			    ((sftype & 0x80) >> 7) * MAX_SUBFEATURES +
+			    ((sftype & 0x80) >> 7) * max_subfeatures +
 			    (sftype & 0x7F);
 		}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
