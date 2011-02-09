From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Feb 2011 17:52:15 +0000
Subject: [lm-sensors] [PATCH resend] libsensors: Add support for additional
Message-Id: <20110209175215.GA19821@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Update libsensors to support recently added sysfs attributes.

The patch does not include support for the new humidity attribute;
this will be a separate patch since it requires a new sensor feature type.

--
Resending earlier patch, trying to get it out of my queue.
Only change is to mark is as patch in the headline.

CHANGES already includes a line for added attributes, so no change should be needed there.

Index: doc/libsensors-API.txt
=================================--- doc/libsensors-API.txt	(revision 5914)
+++ doc/libsensors-API.txt	(working copy)
@@ -14,13 +14,25 @@
 * Added support for various new sysfs attributes
   enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_LCRIT
   enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_CRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_LCRIT_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_CRIT_ALARM
   enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LCRIT
   enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY
   enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM
   enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM
   enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CAP
   enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CAP_HYST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_MAX
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CRIT
   enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CAP_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_MAX_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_CRIT_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LCRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_CRIT
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LCRIT_ALARM
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_CRIT_ALARM
 
 0x430	lm-sensors 3.2.0
 * License changed from GPL to LGPL
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5914)
+++ lib/sensors.h	(working copy)
@@ -160,6 +160,8 @@
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
 	SENSORS_SUBFEATURE_IN_BEEP,
+	SENSORS_SUBFEATURE_IN_LCRIT_ALARM,
+	SENSORS_SUBFEATURE_IN_CRIT_ALARM,
 
 	SENSORS_SUBFEATURE_FAN_INPUT = SENSORS_FEATURE_FAN << 8,
 	SENSORS_SUBFEATURE_FAN_MIN,
@@ -186,6 +188,7 @@
 	SENSORS_SUBFEATURE_TEMP_OFFSET,
 	SENSORS_SUBFEATURE_TEMP_BEEP,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM,
+	SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM,
 
 	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
@@ -195,18 +198,27 @@
 	SENSORS_SUBFEATURE_POWER_INPUT_LOWEST,
 	SENSORS_SUBFEATURE_POWER_CAP,
 	SENSORS_SUBFEATURE_POWER_CAP_HYST,
+	SENSORS_SUBFEATURE_POWER_MAX,
+	SENSORS_SUBFEATURE_POWER_CRIT,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
 	SENSORS_SUBFEATURE_POWER_ALARM,
+	SENSORS_SUBFEATURE_POWER_CAP_ALARM,
+	SENSORS_SUBFEATURE_POWER_MAX_ALARM,
+	SENSORS_SUBFEATURE_POWER_CRIT_ALARM,
 
 	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
 
 	SENSORS_SUBFEATURE_CURR_INPUT = SENSORS_FEATURE_CURR << 8,
 	SENSORS_SUBFEATURE_CURR_MIN,
 	SENSORS_SUBFEATURE_CURR_MAX,
+	SENSORS_SUBFEATURE_CURR_LCRIT,
+	SENSORS_SUBFEATURE_CURR_CRIT,
 	SENSORS_SUBFEATURE_CURR_ALARM = (SENSORS_FEATURE_CURR << 8) | 0x80,
 	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
 	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
 	SENSORS_SUBFEATURE_CURR_BEEP,
+	SENSORS_SUBFEATURE_CURR_LCRIT_ALARM,
+	SENSORS_SUBFEATURE_CURR_CRIT_ALARM,
 
 	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
 
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5914)
+++ lib/sysfs.c	(working copy)
@@ -234,6 +234,7 @@
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
 	{ "crit_alarm", SENSORS_SUBFEATURE_TEMP_CRIT_ALARM },
 	{ "emergency_alarm", SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM },
+	{ "lcrit_alarm", SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM },
 	{ "fault", SENSORS_SUBFEATURE_TEMP_FAULT },
 	{ "type", SENSORS_SUBFEATURE_TEMP_TYPE },
 	{ "offset", SENSORS_SUBFEATURE_TEMP_OFFSET },
@@ -250,6 +251,8 @@
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
+	{ "lcrit_alarm", SENSORS_SUBFEATURE_IN_LCRIT_ALARM },
+	{ "crit_alarm", SENSORS_SUBFEATURE_IN_CRIT_ALARM },
 	{ "beep", SENSORS_SUBFEATURE_IN_BEEP },
 	{ NULL, 0 }
 };
@@ -273,7 +276,12 @@
 	{ "input_lowest", SENSORS_SUBFEATURE_POWER_INPUT_LOWEST },
 	{ "cap", SENSORS_SUBFEATURE_POWER_CAP },
 	{ "cap_hyst", SENSORS_SUBFEATURE_POWER_CAP_HYST },
+	{ "cap_alarm", SENSORS_SUBFEATURE_POWER_CAP_ALARM },
 	{ "alarm", SENSORS_SUBFEATURE_POWER_ALARM },
+	{ "max", SENSORS_SUBFEATURE_POWER_MAX },
+	{ "max_alarm", SENSORS_SUBFEATURE_POWER_MAX_ALARM },
+	{ "crit", SENSORS_SUBFEATURE_POWER_CRIT },
+	{ "crit_alarm", SENSORS_SUBFEATURE_POWER_CRIT_ALARM },
 	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
 	{ NULL, 0 }
 };
@@ -287,9 +295,13 @@
 	{ "input", SENSORS_SUBFEATURE_CURR_INPUT },
 	{ "min", SENSORS_SUBFEATURE_CURR_MIN },
 	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
+	{ "lcrit", SENSORS_SUBFEATURE_CURR_LCRIT },
+	{ "crit", SENSORS_SUBFEATURE_CURR_CRIT },
 	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
+	{ "lcrit_alarm", SENSORS_SUBFEATURE_CURR_LCRIT_ALARM },
+	{ "crit_alarm", SENSORS_SUBFEATURE_CURR_CRIT_ALARM },
 	{ "beep", SENSORS_SUBFEATURE_CURR_BEEP },
 	{ NULL, 0 }
 };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
