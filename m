From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 14:53:37 +0000
Subject: [lm-sensors] [PATCh 4/4] Speed up sensors_get_ignored()
Message-Id: <20070722165337.20c91514@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now that sensors_get_ignored() is an internal function, we can change
its prototype to suit our needs better.

* Pass the chip name by address.
* Pass the feature directly rather than its number.
* Switch to a sane convention for the returned value.
* Don't check for errors that can't happen.

---
 lib/access.c |   41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-22 14:53:41.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-22 15:08:41.000000000 +0200
@@ -193,34 +193,29 @@ sensors_get_label_exit:
 	return 0;
 }
 
-/* Looks up whether a feature should be ignored. Returns <0 on failure,
-   0 if it should be ignored, 1 if it is valid. This function takes
+/* Looks up whether a feature should be ignored. Returns
+   1 if it should be ignored, 0 if not. This function takes
    logical mappings into account. */
-static int sensors_get_ignored(sensors_chip_name name, int feature)
+static int sensors_get_ignored(const sensors_chip_name *name,
+			       const sensors_chip_feature *feature)
 {
 	const sensors_chip *chip;
-	const sensors_chip_feature *featureptr;
-	const sensors_chip_feature *alt_featureptr;
+	const char *main_feature_name;
 	int i;
 
-	if (sensors_chip_name_has_wildcards(name))
-		return -SENSORS_ERR_WILDCARDS;
-	if (!(featureptr = sensors_lookup_feature_nr(&name, feature)))
-		return -SENSORS_ERR_NO_ENTRY;
-	if (featureptr->data.mapping = SENSORS_NO_MAPPING)
-		alt_featureptr = NULL;
-	else if (!(alt_featureptr -		   sensors_lookup_feature_nr(&name,
-					     featureptr->data.mapping)))
-		return -SENSORS_ERR_NO_ENTRY;
-	for (chip = NULL; (chip = sensors_for_all_config_chips(name, chip));)
+	if (feature->data.mapping = SENSORS_NO_MAPPING)
+		main_feature_name = NULL;
+	else
+		main_feature_name = sensors_lookup_feature_nr(name,
+					feature->data.mapping)->data.name;
+
+	for (chip = NULL; (chip = sensors_for_all_config_chips(*name, chip));)
 		for (i = 0; i < chip->ignores_count; i++)
-			if (!strcasecmp(featureptr->data.name, chip->ignores[i].name) ||
-			    (alt_featureptr &&
-			     !strcasecmp(alt_featureptr->data.name, chip->ignores[i].name)))
-				return 0;
-	/* valid */
-	return 1;
+			if (!strcasecmp(feature->data.name, chip->ignores[i].name) ||
+			    (main_feature_name &&
+			     !strcasecmp(main_feature_name, chip->ignores[i].name)))
+				return 1;
+	return 0;
 }
 
 /* Read the value of a feature of a certain chip. Note that chip should not
@@ -347,7 +342,7 @@ const sensors_feature_data *sensors_get_
 		if (sensors_match_chip(sensors_proc_chips[i].chip, name)) {
 			feature_list = sensors_proc_chips[i].feature;
 			while (feature_list[*nr].data.name
-			    && sensors_get_ignored(name, feature_list[*nr].data.number) != 1)
+			    && sensors_get_ignored(&name, &feature_list[*nr]))
 				(*nr)++;
 			if (!feature_list[*nr].data.name)
 				return NULL;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
