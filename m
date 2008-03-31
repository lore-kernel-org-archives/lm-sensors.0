From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 31 Mar 2008 23:54:41 +0000
Subject: [lm-sensors] [PATCH 4/4]: sensors: Automatically scale energy/power
Message-Id: <20080331235441.GH7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Automatically scale energy and power values when printing them in cooked
mode.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Index: lm-sensors-3.0.0/lib/sysfs.c
=================================--- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-03-31 16:35:30.000000000 -0700
+++ lm-sensors-3.0.0/lib/sysfs.c	2008-03-31 16:35:46.000000000 -0700
@@ -155,10 +155,6 @@
 		return 1000;
 	case SENSORS_SUBFEATURE_FAN_INPUT:
 		return 1;
-	case SENSORS_SUBFEATURE_POWER_AVERAGE:
-		return 1000000;
-	case SENSORS_SUBFEATURE_ENERGY_INPUT:
-		return 1000000;
 	case SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL:
 		return 1000;
 	}
Index: lm-sensors-3.0.0/prog/sensors/chips.c
=================================--- lm-sensors-3.0.0.orig/prog/sensors/chips.c	2008-03-31 16:35:38.000000000 -0700
+++ lm-sensors-3.0.0/prog/sensors/chips.c	2008-03-31 16:35:46.000000000 -0700
@@ -401,10 +401,40 @@
 	printf("\n");
 }
 
+struct scale_table {
+	float upper_bound;
+	const char *units;
+};
+
+static void scale_value(struct scale_table *scales, float *value,
+			const char **unitstr)
+{
+	float divisor = 1;
+
+	while (scales->upper_bound != 0 && *value > scales->upper_bound) {
+		divisor = scales->upper_bound;
+		scales++;
+	}
+
+	*value /= divisor;
+
+	*unitstr = scales->units;
+}
+
+struct scale_table power_scales[] = {
+	{1e3,  "uW"},
+	{1e6,  "mW"},
+	{1e9,   "W"},
+	{1e12, "KW"},
+	{1e15, "MW"},
+	{0,    "GW"},
+};
+
 static void print_chip_power(const sensors_chip_name *name,
 			     const sensors_feature *feature,
 			     int label_size)
 {
+	float val;
 	int need_space = 0;
 	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
 	char *label;
@@ -419,9 +449,11 @@
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_POWER_AVERAGE);
-	if (sf)
-		printf("%6.2f W", get_value(name, sf));
-	else
+	if (sf) {
+		val = get_value(name, sf);
+		scale_value(power_scales, &val, &label);
+		printf("%6.2f %s", val, label);
+	} else
 		printf("     N/A");
 
 	sfmin = sensors_get_subfeature(name, feature,
@@ -434,13 +466,17 @@
 		printf("  (");
 
 		if (sfmin) {
-			printf("min = %6.2f W", get_value(name, sfmin));
+			val = get_value(name, sfmin);
+			scale_value(power_scales, &val, &label);
+			printf("min = %6.2f %s", val, label);
 			need_space = 1;
 		}
 
 		if (sfmax) {
-			printf("%smax = %6.2f W", (need_space ? ", " : ""),
-			       get_value(name, sfmax));
+			val = get_value(name, sfmax);
+			scale_value(power_scales, &val, &label);
+			printf("%smax = %6.2f %s", (need_space ? ", " : ""),
+			       val, label);
 			need_space = 1;
 		}
 
@@ -455,10 +491,20 @@
 	printf("\n");
 }
 
+struct scale_table energy_scales[] = {
+	{1e3,  "uJ"},
+	{1e6,  "mJ"},
+	{1e9,   "J"},
+	{1e12, "KJ"},
+	{1e15, "MJ"},
+	{0,    "GJ"},
+};
+
 static void print_chip_energy(const sensors_chip_name *name,
 			      const sensors_feature *feature,
 			      int label_size)
 {
+	float val;
 	const sensors_subfeature *sf;
 	char *label;
 
@@ -472,9 +518,11 @@
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_ENERGY_INPUT);
-	if (sf)
-		printf("%6.2f J", get_value(name, sf));
-	else
+	if (sf) {
+		val = get_value(name, sf);
+		scale_value(energy_scales, &val, &label);
+		printf("%6.2f %s", val, label);
+	} else
 		printf("     N/A");
 
 	printf("\n");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
