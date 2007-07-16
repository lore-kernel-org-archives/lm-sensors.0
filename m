From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jul 2007 13:25:34 +0000
Subject: [lm-sensors] [PATCH 3/3] libsensors4: Optimize
Message-Id: <20070716152534.1755ba05@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Minor optimizations to sensors_feature_get_type():
* We no longer support any single type, so no need to handle this case.
* We can start looking for "_" at offset 3 rather than the beginning
  of the string (the shortest valid prefix is "in0", 3 characters.)

---
 lib/access.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-16 14:48:55.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-16 14:51:19.000000000 +0200
@@ -522,8 +522,6 @@ struct feature_subtype_match
 struct feature_type_match
 {
 	const char *name;
-	sensors_feature_type type;
-	
 	const struct feature_subtype_match *submatches;
 };
 
@@ -568,10 +566,10 @@ static const struct feature_subtype_matc
 };
 
 static struct feature_type_match matches[] = { 
-	{ "temp%d%c", SENSORS_FEATURE_UNKNOWN, temp_matches },
-	{ "in%d%c", SENSORS_FEATURE_UNKNOWN, in_matches },
-	{ "fan%d%c", SENSORS_FEATURE_UNKNOWN, fan_matches },
-	{ "cpu%d%c", SENSORS_FEATURE_UNKNOWN, cpu_matches },
+	{ "temp%d%c", temp_matches },
+	{ "in%d%c", in_matches },
+	{ "fan%d%c", fan_matches },
+	{ "cpu%d%c", cpu_matches },
 };
 
 /* Return the feature type and channel number based on the feature name */
@@ -585,18 +583,13 @@ sensors_feature_type sensors_feature_get
 		if ((count = sscanf(name, matches[i].name, nr, &c)))
 			break;
 	
-	if (i = ARRAY_SIZE(matches)) /* no match */
-		return SENSORS_FEATURE_UNKNOWN;
-	else if (count = 1) /* single type */
-		return matches[i].type;
-
-	/* assert: count = 2 */
-	if (c != '_')
-		return SENSORS_FEATURE_UNKNOWN;
+	if (i = ARRAY_SIZE(matches) || count != 2 || c != '_')
+		return SENSORS_FEATURE_UNKNOWN;  /* no match */
 
 	submatches = matches[i].submatches;
+	name = strchr(name + 3, '_') + 1;
 	for (i = 0; submatches[i].name != NULL; i++)
-		if (!strcmp(strchr(name, '_') + 1, submatches[i].name))
+		if (!strcmp(name, submatches[i].name))
 			return submatches[i].type;
 	
 	return SENSORS_FEATURE_UNKNOWN;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
