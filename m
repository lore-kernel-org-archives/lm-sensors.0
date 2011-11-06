From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Nov 2011 22:46:22 +0000
Subject: [lm-sensors] [PATCH v2] Add support for new attributes to
Message-Id: <20111106224622.GA28914@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for new sysfs attributes to libsensors and to the sensors command.

v2: Use defines for array sizes. Some of the resulting arrays are larger than necessary,
    but that is better than missing an array size update if the number of attributes
    changes.
--
Index: doc/libsensors-API.txt
=================================--- doc/libsensors-API.txt	(revision 5996)
+++ doc/libsensors-API.txt	(working copy)
@@ -7,6 +7,16 @@
 given new feature.
 
 0x431	lm-sensors 3.3.0 to 3.3.1
+* Added support for new sysfs attributes
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_AVERAGE
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_HIGHEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_AVERAGE
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_HIGHEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_AVERAGE
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_HIGHEST
 * Added support for intrusion detection
   enum sensors_feature_type SENSORS_FEATURE_INTRUSION
   enum sensors_subfeature_type SENSORS_SUBFEATURE_INTRUSION_ALARM
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5996)
+++ lib/sensors.h	(working copy)
@@ -157,6 +157,9 @@
 	SENSORS_SUBFEATURE_IN_MAX,
 	SENSORS_SUBFEATURE_IN_LCRIT,
 	SENSORS_SUBFEATURE_IN_CRIT,
+	SENSORS_SUBFEATURE_IN_AVERAGE,
+	SENSORS_SUBFEATURE_IN_LOWEST,
+	SENSORS_SUBFEATURE_IN_HIGHEST,
 	SENSORS_SUBFEATURE_IN_ALARM = (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
@@ -181,6 +184,9 @@
 	SENSORS_SUBFEATURE_TEMP_LCRIT,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
+	SENSORS_SUBFEATURE_TEMP_AVERAGE,
+	SENSORS_SUBFEATURE_TEMP_LOWEST,
+	SENSORS_SUBFEATURE_TEMP_HIGHEST,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -215,6 +221,9 @@
 	SENSORS_SUBFEATURE_CURR_MAX,
 	SENSORS_SUBFEATURE_CURR_LCRIT,
 	SENSORS_SUBFEATURE_CURR_CRIT,
+	SENSORS_SUBFEATURE_CURR_AVERAGE,
+	SENSORS_SUBFEATURE_CURR_LOWEST,
+	SENSORS_SUBFEATURE_CURR_HIGHEST,
 	SENSORS_SUBFEATURE_CURR_ALARM = (SENSORS_FEATURE_CURR << 8) | 0x80,
 	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
 	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5996)
+++ lib/sysfs.c	(working copy)
@@ -233,6 +233,9 @@
 	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
 	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
 	{ "emergency_hyst", SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST },
+	{ "average", SENSORS_SUBFEATURE_TEMP_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_TEMP_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_TEMP_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_TEMP_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
@@ -252,6 +255,9 @@
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
+	{ "average", SENSORS_SUBFEATURE_IN_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_IN_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_IN_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
@@ -302,6 +308,9 @@
 	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_CURR_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_CURR_CRIT },
+	{ "average", SENSORS_SUBFEATURE_CURR_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_CURR_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_CURR_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
Index: prog/sensors/chips.c
=================================--- prog/sensors/chips.c	(revision 5996)
+++ prog/sensors/chips.c	(working copy)
@@ -280,15 +280,26 @@
 	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, 0, "crit" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, 0,
 	    "emerg" },
+	{ SENSORS_SUBFEATURE_TEMP_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_TEMP_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_TEMP_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_TEMP_ALARMS		6
+#define NUM_TEMP_SENSORS	(ARRAY_SIZE(temp_sensors) \
+				 + ARRAY_SIZE(temp_max_sensors) \
+				 + ARRAY_SIZE(temp_crit_sensors) \
+				 + ARRAY_SIZE(temp_emergency_sensors) \
+				 - NUM_TEMP_ALARMS)
+				
+
 static void print_chip_temp(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	struct sensor_subfeature_data sensors[8];
-	struct sensor_subfeature_data alarms[5];
+	struct sensor_subfeature_data sensors[NUM_TEMP_SENSORS];
+	struct sensor_subfeature_data alarms[NUM_TEMP_ALARMS];
 	int sensor_count, alarm_count;
 	const sensors_subfeature *sf;
 	double val;
@@ -365,17 +376,23 @@
 	{ SENSORS_SUBFEATURE_IN_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_IN_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_IN_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_IN_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_IN_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_IN_ALARMS	5
+#define NUM_IN_SENSORS	(ARRAY_SIZE(voltage_sensors) - NUM_IN_ALARMS)
+
 static void print_chip_in(const sensors_chip_name *name,
 			  const sensors_feature *feature,
 			  int label_size)
 {
 	const sensors_subfeature *sf;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
-	struct sensor_subfeature_data alarms[4];
+	struct sensor_subfeature_data sensors[NUM_IN_SENSORS];
+	struct sensor_subfeature_data alarms[NUM_IN_ALARMS];
 	int sensor_count, alarm_count;
 	double val;
 
@@ -504,6 +521,7 @@
 };
 
 static const struct sensor_subfeature_list power_inst_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
@@ -517,14 +535,20 @@
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_POWER_ALARMS	4
+#define NUM_POWER_SENSORS	(ARRAY_SIZE(power_common_sensors) \
+				 + ARRAY_SIZE(power_inst_sensors) \
+				 + ARRAY_SIZE(power_avg_sensors) \
+				 - NUM_POWER_ALARMS)
+
 static void print_chip_power(const sensors_chip_name *name,
 			     const sensors_feature *feature,
 			     int label_size)
 {
 	double val;
 	const sensors_subfeature *sf;
-	struct sensor_subfeature_data sensors[6];
-	struct sensor_subfeature_data alarms[3];
+	struct sensor_subfeature_data sensors[NUM_POWER_SENSORS];
+	struct sensor_subfeature_data alarms[NUM_POWER_ALARMS];
 	int sensor_count, alarm_count;
 	char *label;
 	const char *unit;
@@ -653,9 +677,15 @@
 	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_CURR_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_CURR_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_CURR_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_CURR_ALARM		5
+#define NUM_CURR_SENSORS	(ARRAY_SIZE(current_sensors) - NUM_CURR_ALARM)
+
 static void print_chip_curr(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
@@ -663,8 +693,8 @@
 	const sensors_subfeature *sf;
 	double val;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
-	struct sensor_subfeature_data alarms[4];
+	struct sensor_subfeature_data sensors[NUM_CURR_SENSORS];
+	struct sensor_subfeature_data alarms[NUM_CURR_ALARM];
 	int sensor_count, alarm_count;
 
 	if (!(label = sensors_get_label(name, feature))) {
Index: CHANGES
=================================--- CHANGES	(revision 5996)
+++ CHANGES	(working copy)
@@ -2,6 +2,10 @@
 -----------------------
 
 SVN HEAD
+  libsensors: Added support for new sysfs attributes
+  sensors: Added support for new sysfs attributes
+           For power sensors, display both instantaneous and average data
+           if available
   sensors-detect: Stop calling for PIIX5 SMBus testers
                   Improve filtering of fake DMI data
                   Print DMI system/product version if available

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
