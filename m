From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Apr 2014 12:53:15 +0000
Subject: [lm-sensors] [PATCH 1/2] libsensors: Add support for temp[1-*]_min_hyst and temp[1-*]_lcrit_hyst
Message-Id: <20140420145315.545af82f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022134628.5224289d@hyperion.delvare>
In-Reply-To: <20081022134628.5224289d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for sysfs attributes temp[1-*]_min_hyst (already
implemented by drivers adt7x10, lm77 and lm92) and
temp[1-*]_lcrit_hyst (no known users yet.)
---
 doc/libsensors-API.txt |    3 +++
 lib/sensors.h          |    2 ++
 lib/sysfs.c            |    2 ++
 3 files changed, 7 insertions(+)

--- lm-sensors.orig/lib/sensors.h	2014-04-20 14:41:58.363341231 +0200
+++ lm-sensors/lib/sensors.h	2014-04-20 14:45:56.714537072 +0200
@@ -190,6 +190,8 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
 	SENSORS_SUBFEATURE_TEMP_LOWEST,
 	SENSORS_SUBFEATURE_TEMP_HIGHEST,
+	SENSORS_SUBFEATURE_TEMP_MIN_HYST,
+	SENSORS_SUBFEATURE_TEMP_LCRIT_HYST,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
--- lm-sensors.orig/lib/sysfs.c	2014-04-20 14:41:58.363341231 +0200
+++ lm-sensors/lib/sysfs.c	2014-04-20 14:42:35.795164162 +0200
@@ -214,9 +214,11 @@ static const struct subfeature_type_matc
 	{ "max", SENSORS_SUBFEATURE_TEMP_MAX },
 	{ "max_hyst", SENSORS_SUBFEATURE_TEMP_MAX_HYST },
 	{ "min", SENSORS_SUBFEATURE_TEMP_MIN },
+	{ "min_hyst", SENSORS_SUBFEATURE_TEMP_MIN_HYST },
 	{ "crit", SENSORS_SUBFEATURE_TEMP_CRIT },
 	{ "crit_hyst", SENSORS_SUBFEATURE_TEMP_CRIT_HYST },
 	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
+	{ "lcrit_hyst", SENSORS_SUBFEATURE_TEMP_LCRIT_HYST },
 	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
 	{ "emergency_hyst", SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST },
 	{ "lowest", SENSORS_SUBFEATURE_TEMP_LOWEST },
--- lm-sensors.orig/doc/libsensors-API.txt	2014-01-29 10:23:58.749091894 +0100
+++ lm-sensors/doc/libsensors-API.txt	2014-04-20 14:49:18.605933238 +0200
@@ -9,6 +9,9 @@ given new feature.
 0x440	lm-sensors 3.4.0
 * Defined SENSORS_FEATURE_MAX
   enum sensors_feature_type SENSORS_FEATURE_MAX
+* Added support for temp min and temp critical min hysteresis
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_MIN_HYST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LCRIT_HYST
 
 0x432	lm-sensors 3.3.2 to 3.3.5
 * Added support for new sysfs attributes


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
