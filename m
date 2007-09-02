From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:20:00 +0000
Subject: [lm-sensors] [PATCH 5/7] libsensors4: Store the feature list length
Message-Id: <20070902222000.7e83afba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Store the feature list length separately instead of null-terminating
the list. This make it possible to check for out-of-bound indexes
without walking the entire list, so that direct look-ups are safer.

---
 lib/access.c |    9 ++++++---
 lib/data.h   |    1 +
 lib/init.c   |   10 +++++-----
 lib/sysfs.c  |    5 +++--
 4 files changed, 15 insertions(+), 10 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-09-02 16:17:52.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-09-02 16:18:38.000000000 +0200
@@ -96,6 +96,9 @@ const sensors_chip_feature *sensors_look
 
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(&sensors_proc_chips[i].chip, chip)) {
+			if (feature < 0 ||
+			    feature >= sensors_proc_chips[i].feature_count)
+				return NULL;
 			return sensors_proc_chips[i].feature + feature;
 		}
 	return NULL;
@@ -113,7 +116,7 @@ sensors_lookup_feature_name(const sensor
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(&sensors_proc_chips[i].chip, chip)) {
 			features = sensors_proc_chips[i].feature;
-			for (j = 0; features[j].data.name; j++)
+			for (j = 0; j < sensors_proc_chips[i].feature_count; j++)
 				if (!strcasecmp(features[j].data.name, feature))
 					return features + j;
 		}
@@ -350,10 +353,10 @@ const sensors_feature_data *sensors_get_
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(&sensors_proc_chips[i].chip, name)) {
 			feature_list = sensors_proc_chips[i].feature;
-			while (feature_list[*nr].data.name
+			while (*nr < sensors_proc_chips[i].feature_count
 			    && sensors_get_ignored(name, &feature_list[*nr]))
 				(*nr)++;
-			if (!feature_list[*nr].data.name)
+			if (*nr = sensors_proc_chips[i].feature_count)
 				return NULL;
 			return &feature_list[(*nr)++].data;
 		}
--- lm-sensors-3.orig/lib/data.h	2007-09-02 16:17:16.000000000 +0200
+++ lm-sensors-3/lib/data.h	2007-09-02 16:18:38.000000000 +0200
@@ -143,6 +143,7 @@ typedef struct sensors_chip_feature {
 typedef struct sensors_chip_features {
 	struct sensors_chip_name chip;
 	struct sensors_chip_feature *feature;
+	int feature_count;
 } sensors_chip_features;
 
 extern sensors_chip *sensors_config_chips;
--- lm-sensors-3.orig/lib/init.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/init.c	2007-09-02 16:18:38.000000000 +0200
@@ -51,13 +51,13 @@ static void free_chip_name(sensors_chip_
 	free(name->path);
 }
 
-static void free_chip_features(sensors_chip_feature *features)
+static void free_chip_features(sensors_chip_features *features)
 {
 	int i;
 
-	for (i = 0; features[i].data.name; i++)
-		free(features[i].data.name);
-	free(features);
+	for (i = 0; i < features->feature_count; i++)
+		free(features->feature[i].data.name);
+	free(features->feature);
 }
 
 static void free_bus(sensors_bus *bus)
@@ -140,7 +140,7 @@ void sensors_cleanup(void)
 
 	for (i = 0; i < sensors_proc_chips_count; i++) {
 		free_chip_name(&sensors_proc_chips[i].chip);
-		free_chip_features(sensors_proc_chips[i].feature);
+		free_chip_features(&sensors_proc_chips[i]);
 	}
 	free(sensors_proc_chips);
 	sensors_proc_chips = NULL;
--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 16:17:52.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 16:18:38.000000000 +0200
@@ -64,7 +64,7 @@ int get_type_scaling(int type)
 static int sensors_read_dynamic_chip(sensors_chip_features *chip,
 				     struct sysfs_device *sysdir)
 {
-	int i, type, fnum = 1;
+	int i, type, fnum = 0;
 	struct sysfs_attribute *attr;
 	struct dlist *attrs;
 	sensors_chip_feature *features;
@@ -160,7 +160,7 @@ static int sensors_read_dynamic_chip(sen
 		fnum++;
 	}
 
-	if (fnum = 1) { /* No feature */
+	if (!fnum) { /* No feature */
 		chip->feature = NULL;
 		goto exit_free;
 	}
@@ -194,6 +194,7 @@ static int sensors_read_dynamic_chip(sen
 	}
 
 	chip->feature = dyn_features;
+	chip->feature_count = fnum;
 
 exit_free:
 	free(features);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
