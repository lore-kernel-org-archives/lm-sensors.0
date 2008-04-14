From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 14 Apr 2008 21:53:16 +0000
Subject: [lm-sensors] [PATCH 3/3 v3]: sensors: Automatically scale
Message-Id: <20080414215316.GF7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Automatically scale energy and power values when printing them in cooked
mode.  Fixed all the warnings and warts that were brought up by Jean in
the previous thread.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Index: lm-sensors-3.0.0/prog/sensors/chips.c
=================================--- lm-sensors-3.0.0.orig/prog/sensors/chips.c	2008-04-14 14:43:07.000000000 -0700
+++ lm-sensors-3.0.0/prog/sensors/chips.c	2008-04-14 14:43:49.000000000 -0700
@@ -23,6 +23,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <math.h>
 
 #include "main.h"
 #include "chips.h"
@@ -401,13 +402,44 @@
 	printf("\n");
 }
 
+struct scale_table {
+	double upper_bound;
+	const char *unit;
+};
+
+static void scale_value(double *value, const char **prefixstr)
+{
+	double abs_value = fabs(*value);
+	double divisor = 1e-9;
+	static struct scale_table prefix_scales[] = {
+		{1e-6, "n"},
+		{1e-3, "u"},
+		{1,    "m"},
+		{1e3,   ""},
+		{1e6,  "k"},
+		{1e9,  "M"},
+		{0,    "G"}, /* no upper bound */
+	};
+	struct scale_table *scale = prefix_scales;
+
+	while (scale->upper_bound && abs_value > scale->upper_bound) {
+		divisor = scale->upper_bound;
+		scale++;
+	}
+
+	*value /= divisor;
+	*prefixstr = scale->unit;
+}
+
 static void print_chip_power(const sensors_chip_name *name,
 			     const sensors_feature *feature,
 			     int label_size)
 {
+	double val;
 	int need_space = 0;
 	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
 	char *label;
+	const char *unit;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -419,9 +451,11 @@
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_POWER_AVERAGE);
-	if (sf)
-		printf("%6.2f W", get_value(name, sf));
-	else
+	if (sf) {
+		val = get_value(name, sf);
+		scale_value(&val, &unit);
+		printf("%6.2f %sW", val, unit);
+	} else
 		printf("     N/A");
 
 	sfmin = sensors_get_subfeature(name, feature,
@@ -434,13 +468,17 @@
 		printf("  (");
 
 		if (sfmin) {
-			printf("min = %6.2f W", get_value(name, sfmin));
+			val = get_value(name, sfmin);
+			scale_value(&val, &unit);
+			printf("min = %6.2f %sW", val, unit);
 			need_space = 1;
 		}
 
 		if (sfmax) {
-			printf("%smax = %6.2f W", (need_space ? ", " : ""),
-			       get_value(name, sfmax));
+			val = get_value(name, sfmax);
+			scale_value(&val, &unit);
+			printf("%smax = %6.2f %sW", (need_space ? ", " : ""),
+			       val, unit);
 			need_space = 1;
 		}
 
@@ -459,8 +497,10 @@
 			      const sensors_feature *feature,
 			      int label_size)
 {
+	double val;
 	const sensors_subfeature *sf;
 	char *label;
+	const char *unit;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -472,9 +512,11 @@
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_ENERGY_INPUT);
-	if (sf)
-		printf("%6.2f J", get_value(name, sf));
-	else
+	if (sf) {
+		val = get_value(name, sf);
+		scale_value(&val, &unit);
+		printf("%6.2f %sJ", val, unit);
+	} else
 		printf("     N/A");
 
 	printf("\n");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
