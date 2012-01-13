From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 14:51:00 +0000
Subject: [lm-sensors] [PATCH] libsensors: Add support for extra fan attributes
Message-Id: <20120113155100.1e081f29@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for fan[1-*]_max, fan[1-*]_min_alarm and fan[1-*]_max_alarm
attributes. These are defined in the standard sysfs interface for quite
some time, and at least three drivers (max6650, lm63 and applesmc)
implement them so we should support them.
---
 doc/libsensors-API.txt |    3 +++
 lib/sensors.h          |    3 +++
 lib/sysfs.c            |    3 +++
 prog/sensors/chips.c   |   38 +++++++++++++++++++++++++-------------
 4 files changed, 34 insertions(+), 13 deletions(-)

--- lm-sensors.orig/lib/sensors.h	2012-01-09 18:33:55.000000000 +0100
+++ lm-sensors/lib/sensors.h	2012-01-13 13:48:42.000000000 +0100
@@ -169,11 +169,14 @@ typedef enum sensors_subfeature_type {
 
 	SENSORS_SUBFEATURE_FAN_INPUT = SENSORS_FEATURE_FAN << 8,
 	SENSORS_SUBFEATURE_FAN_MIN,
+	SENSORS_SUBFEATURE_FAN_MAX,
 	SENSORS_SUBFEATURE_FAN_ALARM = (SENSORS_FEATURE_FAN << 8) | 0x80,
 	SENSORS_SUBFEATURE_FAN_FAULT,
 	SENSORS_SUBFEATURE_FAN_DIV,
 	SENSORS_SUBFEATURE_FAN_BEEP,
 	SENSORS_SUBFEATURE_FAN_PULSES,
+	SENSORS_SUBFEATURE_FAN_MIN_ALARM,
+	SENSORS_SUBFEATURE_FAN_MAX_ALARM,
 
 	SENSORS_SUBFEATURE_TEMP_INPUT = SENSORS_FEATURE_TEMP << 8,
 	SENSORS_SUBFEATURE_TEMP_MAX,
--- lm-sensors.orig/lib/sysfs.c	2012-01-09 18:33:55.000000000 +0100
+++ lm-sensors/lib/sysfs.c	2012-01-13 13:49:18.000000000 +0100
@@ -269,9 +269,12 @@ static const struct subfeature_type_matc
 static const struct subfeature_type_match fan_matches[] = {
 	{ "input", SENSORS_SUBFEATURE_FAN_INPUT },
 	{ "min", SENSORS_SUBFEATURE_FAN_MIN },
+	{ "max", SENSORS_SUBFEATURE_FAN_MAX },
 	{ "div", SENSORS_SUBFEATURE_FAN_DIV },
 	{ "pulses", SENSORS_SUBFEATURE_FAN_PULSES },
 	{ "alarm", SENSORS_SUBFEATURE_FAN_ALARM },
+	{ "min_alarm", SENSORS_SUBFEATURE_FAN_MIN_ALARM },
+	{ "max_alarm", SENSORS_SUBFEATURE_FAN_MAX_ALARM },
 	{ "fault", SENSORS_SUBFEATURE_FAN_FAULT },
 	{ "beep", SENSORS_SUBFEATURE_FAN_BEEP },
 	{ NULL, 0 }
--- lm-sensors.orig/prog/sensors/chips.c	2012-01-13 10:40:50.000000000 +0100
+++ lm-sensors/prog/sensors/chips.c	2012-01-13 15:41:58.000000000 +0100
@@ -408,7 +408,7 @@ static void print_chip_fan(const sensors
 			   const sensors_feature *feature,
 			   int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfdiv;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sfdiv;
 	double val;
 	char *label;
 
@@ -435,24 +435,36 @@ static void print_chip_fan(const sensors
 
 	sfmin = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_FAN_MIN);
+	sfmax = sensors_get_subfeature(name, feature,
+				       SENSORS_SUBFEATURE_FAN_MAX);
 	sfdiv = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_FAN_DIV);
-	if (sfmin && sfdiv)
-		printf("  (min = %4.0f RPM, div = %1.0f)",
-		       get_value(name, sfmin),
-		       get_value(name, sfdiv));
-	else if (sfmin)
-		printf("  (min = %4.0f RPM)",
-		       get_value(name, sfmin));
-	else if (sfdiv)
-		printf("  (div = %1.0f)",
-		       get_value(name, sfdiv));
+	if (sfmin || sfmax || sfdiv) {
+		printf("  (");
+		if (sfmin)
+			printf("min = %4.0f RPM",
+			       get_value(name, sfmin));
+		if (sfmax)
+			printf("%smax = %4.0f RPM",
+			       sfmin ? ", " : "",
+			       get_value(name, sfmax));
+		if (sfdiv)
+			printf("%sdiv = %1.0f",
+			       (sfmin || sfmax) ? ", " : "",
+			       get_value(name, sfdiv));
+		printf(")");
+	}
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_FAN_ALARM);
-	if (sf && get_value(name, sf)) {
+	sfmin = sensors_get_subfeature(name, feature,
+				       SENSORS_SUBFEATURE_FAN_MIN_ALARM);
+	sfmax = sensors_get_subfeature(name, feature,
+				       SENSORS_SUBFEATURE_FAN_MAX_ALARM);
+	if ((sf && get_value(name, sf)) ||
+	    (sfmin && get_value(name, sfmin)) ||
+	    (sfmax && get_value(name, sfmax)))
 		printf("  ALARM");
-	}
 
 	printf("\n");
 }
--- lm-sensors.orig/doc/libsensors-API.txt	2012-01-09 18:33:55.000000000 +0100
+++ lm-sensors/doc/libsensors-API.txt	2012-01-13 15:47:52.000000000 +0100
@@ -16,6 +16,9 @@ SVN HEAD
   enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_AVERAGE
   enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LOWEST
   enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_HIGHEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_FAN_MAX
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_FAN_MIN_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_FAN_MAX_ALARM
 0x431	lm-sensors 3.3.0 to 3.3.1
 * Added support for intrusion detection
   enum sensors_feature_type SENSORS_FEATURE_INTRUSION


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
