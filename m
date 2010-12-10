From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Dec 2010 19:50:05 +0000
Subject: [lm-sensors] [PATCH] libsensors: Add missing attributes
Message-Id: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The attributes added in this patch are listed in the current version
of the hwmon sysfs ABI, but not yet supported by libsensors.

This patch only adds the new attributes to libsensors. The sensors command
will be updated in a separate patch.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Index: doc/libsensors-API.txt
=================================--- doc/libsensors-API.txt	(revision 5889)
+++ doc/libsensors-API.txt	(working copy)
@@ -11,6 +11,16 @@
   enum sensors_feature_type SENSORS_FEATURE_INTRUSION
   enum sensors_subfeature_type SENSORS_SUBFEATURE_INTRUSION_ALARM
   enum sensors_subfeature_type SENSORS_SUBFEATURE_INTRUSION_BEEP
+* Added support for various new sysfs attributes
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_LCRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_CRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LCRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CAP
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CAP_HYST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_ALARM
 
 0x430	lm-sensors 3.2.0
 * License changed from GPL to LGPL
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5889)
+++ lib/sensors.h	(working copy)
@@ -152,6 +152,8 @@
 	SENSORS_SUBFEATURE_IN_INPUT = SENSORS_FEATURE_IN << 8,
 	SENSORS_SUBFEATURE_IN_MIN,
 	SENSORS_SUBFEATURE_IN_MAX,
+	SENSORS_SUBFEATURE_IN_LCRIT,
+	SENSORS_SUBFEATURE_IN_CRIT,
 	SENSORS_SUBFEATURE_IN_ALARM = (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
@@ -170,6 +172,9 @@
 	SENSORS_SUBFEATURE_TEMP_MIN,
 	SENSORS_SUBFEATURE_TEMP_CRIT,
 	SENSORS_SUBFEATURE_TEMP_CRIT_HYST,
+	SENSORS_SUBFEATURE_TEMP_LCRIT,
+	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
+	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -178,6 +183,7 @@
 	SENSORS_SUBFEATURE_TEMP_TYPE,
 	SENSORS_SUBFEATURE_TEMP_OFFSET,
 	SENSORS_SUBFEATURE_TEMP_BEEP,
+	SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM,
 
 	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
@@ -185,7 +191,10 @@
 	SENSORS_SUBFEATURE_POWER_INPUT,
 	SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST,
 	SENSORS_SUBFEATURE_POWER_INPUT_LOWEST,
+	SENSORS_SUBFEATURE_POWER_CAP,
+	SENSORS_SUBFEATURE_POWER_CAP_HYST,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
+	SENSORS_SUBFEATURE_POWER_ALARM,
 
 	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
 
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5889)
+++ lib/sysfs.c	(working copy)
@@ -226,10 +226,14 @@
 	{ "min", SENSORS_SUBFEATURE_TEMP_MIN },
 	{ "crit", SENSORS_SUBFEATURE_TEMP_CRIT },
 	{ "crit_hyst", SENSORS_SUBFEATURE_TEMP_CRIT_HYST },
+	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
+	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
+	{ "emergency_hyst", SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_TEMP_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
 	{ "crit_alarm", SENSORS_SUBFEATURE_TEMP_CRIT_ALARM },
+	{ "emergency_alarm", SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM },
 	{ "fault", SENSORS_SUBFEATURE_TEMP_FAULT },
 	{ "type", SENSORS_SUBFEATURE_TEMP_TYPE },
 	{ "offset", SENSORS_SUBFEATURE_TEMP_OFFSET },
@@ -241,6 +245,8 @@
 	{ "input", SENSORS_SUBFEATURE_IN_INPUT },
 	{ "min", SENSORS_SUBFEATURE_IN_MIN },
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
+	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
+	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
@@ -265,6 +271,9 @@
 	{ "input", SENSORS_SUBFEATURE_POWER_INPUT },
 	{ "input_highest", SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST },
 	{ "input_lowest", SENSORS_SUBFEATURE_POWER_INPUT_LOWEST },
+	{ "cap", SENSORS_SUBFEATURE_POWER_CAP },
+	{ "cap_hyst", SENSORS_SUBFEATURE_POWER_CAP_HYST },
+	{ "alarm", SENSORS_SUBFEATURE_POWER_ALARM },
 	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
 	{ NULL, 0 }
 };
Index: CHANGES
=================================--- CHANGES	(revision 5889)
+++ CHANGES	(working copy)
@@ -4,7 +4,8 @@
 SVN HEAD
   Makefile: Check for bison and flex
   libsensors: Add support for intrusion detection (#2370)
-  sensors.conf.defauit: Add a section for the W83627THF
+	      Add support for new sysfs attributes
+  sensors.conf.default: Add a section for the W83627THF
                         Add a section for the SCH5127
   sensors: Display 3 decimal places in raw output
            Add support for intrusion detection (#2370)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
