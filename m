From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 09 Jul 2011 19:42:12 +0000
Subject: [lm-sensors] [PATCH RFC] Add new sysfs attributes to libsensors and
Message-Id: <20110709194212.GA7068@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add proposed new sysfs attributes to libsensors and to the sensors command.

Only voltage and current attributes are really new; the temperature attributes
are already defined in the ABI but were not supported.

---

Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5982)
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
=================================--- lib/sysfs.c	(revision 5982)
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
=================================--- prog/sensors/chips.c	(revision 5982)
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
 
@@ -365,6 +368,9 @@
 	{ SENSORS_SUBFEATURE_IN_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_IN_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_IN_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_IN_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_IN_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -653,6 +659,9 @@
 	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_CURR_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_CURR_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_CURR_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
