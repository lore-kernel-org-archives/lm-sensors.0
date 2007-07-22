From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 14:41:24 +0000
Subject: [lm-sensors] [PATCH 2/4] Handle ignore statements in libsensors
Message-Id: <20070722164124.54817b5b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let libsensors handle ignore statements by itself, rather than
delegating the task to the user applications.

For now, I am calling sensors_get_ignored() in
sensors_get_all_features(), because this is the least intrusive way.
This is in no way optimal though, it would be better to not add
ignored features to the feature list in the first place. However,
doing so would require that the configuration file is read before
sysfs is scanned for features, which isn't currently the case. So
this improvement is left for later.

Note that this patch adds a small cost in terms of performance. This
is because we now honor ignore statements on all features (main ones
and subfeatures) while in practice "sensors" was only checking for
main features. It would be trivial to stop checking for subfeatures,
but it seems to me that supporting ignore on subfeatures is a good
move, as the user may actually want to ignore a specific subfeature.
Individual alarms come to mind. This will also be handy to debug the
generic print code in "sensors".

---
 lib/access.c         |    8 +++++++-
 lib/sensors.h        |    5 -----
 prog/sensors/chips.c |    7 +------
 3 files changed, 8 insertions(+), 12 deletions(-)

--- lm-sensors-3.orig/lib/sensors.h	2007-07-22 15:28:33.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-07-22 15:42:06.000000000 +0200
@@ -83,11 +83,6 @@ extern const char *sensors_get_adapter_n
 extern int sensors_get_label(sensors_chip_name name, int feature, 
                              char **result);
 
-/* Looks up whether a feature should be ignored. Returns <0 on failure,
-   0 if it should be ignored, 1 if it is valid. This function takes
-   logical mappings into account. */
-extern int sensors_get_ignored(sensors_chip_name name, int fature);
-
 /* Read the value of a feature of a certain chip. Note that chip should not
    contain wildcard values! This function will return 0 on success, and <0
    on failure.  */
--- lm-sensors-3.orig/prog/sensors/chips.c	2007-07-22 15:28:33.000000000 +0200
+++ lm-sensors-3/prog/sensors/chips.c	2007-07-22 15:42:06.000000000 +0200
@@ -91,12 +91,7 @@ int sensors_get_label_and_valid(sensors_
 {
   int err;
   err = sensors_get_label(name,feature,label);
-  if (!err)
-    err = sensors_get_ignored(name,feature);
-  if (err >= 0) {
-    *valid = err;
-    err = 0;
-  }
+  *valid = !err;
   return err;
 }
 
--- lm-sensors-3.orig/lib/access.c	2007-07-22 15:28:33.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-22 15:42:06.000000000 +0200
@@ -193,7 +193,10 @@ sensors_get_label_exit:
 	return 0;
 }
 
-int sensors_get_ignored(sensors_chip_name name, int feature)
+/* Looks up whether a feature should be ignored. Returns <0 on failure,
+   0 if it should be ignored, 1 if it is valid. This function takes
+   logical mappings into account. */
+static int sensors_get_ignored(sensors_chip_name name, int feature)
 {
 	const sensors_chip *chip;
 	const sensors_chip_feature *featureptr;
@@ -343,6 +346,9 @@ const sensors_feature_data *sensors_get_
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(sensors_proc_chips[i].chip, name)) {
 			feature_list = sensors_proc_chips[i].feature;
+			while (feature_list[*nr].data.name
+			    && sensors_get_ignored(name, feature_list[*nr].data.number) != 1)
+				(*nr)++;
 			if (!feature_list[*nr].data.name)
 				return NULL;
 			return &feature_list[(*nr)++].data;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
