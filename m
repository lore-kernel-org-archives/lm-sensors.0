From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 15:53:25 +0000
Subject: [lm-sensors] [PATCH v3] sensors/linsensors: Add support for new
Message-Id: <20110728155325.GA24750@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add proposed new sysfs attributes to libsensors and to the sensors command.

Only voltage and current attributes are really new; the temperature attributes
were already defined in the ABI but not supported.

---
v3: Updated CHANGES and doc/libsensors-API.txt
v2: Updated sensors attribute array sizes.
    Added average power output to list of instantaneous power attributes.
    This way both current and average power can be displayed.

Index: doc/libsensors-API.txt
=================================--- doc/libsensors-API.txt	(revision 5992)
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
=================================--- lib/sensors.h	(revision 5992)
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
=================================--- lib/sysfs.c	(revision 5992)
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
=================================--- prog/sensors/chips.c	(revision 5992)
+++ prog/sensors/chips.c	(working copy)
@@ -280,6 +280,9 @@
 	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, 0, "crit" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, 0,
 	    "emerg" },
+	{ SENSORS_SUBFEATURE_TEMP_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_TEMP_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_TEMP_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -287,7 +290,7 @@
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	struct sensor_subfeature_data sensors[8];
+	struct sensor_subfeature_data sensors[11];
 	struct sensor_subfeature_data alarms[5];
 	int sensor_count, alarm_count;
 	const sensors_subfeature *sf;
@@ -365,6 +368,9 @@
 	{ SENSORS_SUBFEATURE_IN_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_IN_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_IN_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_IN_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_IN_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -374,7 +380,7 @@
 {
 	const sensors_subfeature *sf;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[4];
 	int sensor_count, alarm_count;
 	double val;
@@ -504,6 +510,7 @@
 };
 
 static const struct sensor_subfeature_list power_inst_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
@@ -523,7 +530,7 @@
 {
 	double val;
 	const sensors_subfeature *sf;
-	struct sensor_subfeature_data sensors[6];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[3];
 	int sensor_count, alarm_count;
 	char *label;
@@ -653,6 +660,9 @@
 	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_CURR_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_CURR_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_CURR_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -663,7 +673,7 @@
 	const sensors_subfeature *sf;
 	double val;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[4];
 	int sensor_count, alarm_count;
 
Index: CHANGES
=================================--- CHANGES	(revision 5992)
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
