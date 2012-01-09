From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 00:21:24 +0000
Subject: [lm-sensors] [PATCH v3 3/3] Add support for additional sysfs
Message-Id: <1326068484-1898-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

inX_average
inX_lowest
inX_highest
tempX_lowest
tempX_highest
currX_average
currX_lowest
currX_highest

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Separated into two patches, one to automatically handle array sizes and one
  to add new sensors.
- Fixed array size calculations (in separate patch)
- Removed code to display average power in addition to instantaneous power if
  both are available.
- In doc/libsensors-API.txt, moved new attributes to new version entry.
  Not sure what is correct here, and if the API version number needs to change.

 CHANGES                |    2 ++
 doc/libsensors-API.txt |   10 ++++++++++
 lib/sensors.h          |    8 ++++++++
 lib/sysfs.c            |    8 ++++++++
 prog/sensors/chips.c   |    8 ++++++++
 5 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/CHANGES b/CHANGES
index ce04e54..1159aee 100644
--- a/CHANGES
+++ b/CHANGES
@@ -2,6 +2,8 @@ lm-sensors CHANGES file
 -----------------------
 
 SVN HEAD
+  libsensors: Added support for new sysfs attributes
+  sensors: Added support for new sysfs attributes
   fancontrol: Support setup where one PWM output controls several fans
               Output error messages to stderr
   sensors-detect: Stop calling for PIIX5 SMBus testers
diff --git a/doc/libsensors-API.txt b/doc/libsensors-API.txt
index 284f58e..41794c4 100644
--- a/doc/libsensors-API.txt
+++ b/doc/libsensors-API.txt
@@ -6,6 +6,16 @@ over time. This document summarizes these evolutions so that application
 authors can quickly figure out how to test for the availability of a
 given new feature.
 
+SVN HEAD
+* Added support for new sysfs attributes
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_AVERAGE
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_IN_HIGHEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_TEMP_HIGHEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_AVERAGE
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LOWEST
+  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_HIGHEST
 0x431	lm-sensors 3.3.0 to 3.3.1
 * Added support for intrusion detection
   enum sensors_feature_type SENSORS_FEATURE_INTRUSION
diff --git a/lib/sensors.h b/lib/sensors.h
index 99e6e44..6d94784 100644
--- a/lib/sensors.h
+++ b/lib/sensors.h
@@ -157,6 +157,9 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_IN_MAX,
 	SENSORS_SUBFEATURE_IN_LCRIT,
 	SENSORS_SUBFEATURE_IN_CRIT,
+	SENSORS_SUBFEATURE_IN_AVERAGE,
+	SENSORS_SUBFEATURE_IN_LOWEST,
+	SENSORS_SUBFEATURE_IN_HIGHEST,
 	SENSORS_SUBFEATURE_IN_ALARM = (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
@@ -181,6 +184,8 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_TEMP_LCRIT,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
+	SENSORS_SUBFEATURE_TEMP_LOWEST,
+	SENSORS_SUBFEATURE_TEMP_HIGHEST,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -215,6 +220,9 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_CURR_MAX,
 	SENSORS_SUBFEATURE_CURR_LCRIT,
 	SENSORS_SUBFEATURE_CURR_CRIT,
+	SENSORS_SUBFEATURE_CURR_AVERAGE,
+	SENSORS_SUBFEATURE_CURR_LOWEST,
+	SENSORS_SUBFEATURE_CURR_HIGHEST,
 	SENSORS_SUBFEATURE_CURR_ALARM = (SENSORS_FEATURE_CURR << 8) | 0x80,
 	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
 	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 02f6c51..94cea35 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -233,6 +233,8 @@ static const struct subfeature_type_match temp_matches[] = {
 	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
 	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
 	{ "emergency_hyst", SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST },
+	{ "lowest", SENSORS_SUBFEATURE_TEMP_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_TEMP_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_TEMP_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
@@ -252,6 +254,9 @@ static const struct subfeature_type_match in_matches[] = {
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
+	{ "average", SENSORS_SUBFEATURE_IN_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_IN_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_IN_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
@@ -302,6 +307,9 @@ static const struct subfeature_type_match curr_matches[] = {
 	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_CURR_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_CURR_CRIT },
+	{ "average", SENSORS_SUBFEATURE_CURR_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_CURR_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_CURR_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
index 36264a8..78b62cc 100644
--- a/prog/sensors/chips.c
+++ b/prog/sensors/chips.c
@@ -266,6 +266,8 @@ static const struct sensor_subfeature_list temp_sensors[] = {
 	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, 0, "crit" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, 0,
 	    "emerg" },
+	{ SENSORS_SUBFEATURE_TEMP_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_TEMP_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -357,6 +359,9 @@ static const struct sensor_subfeature_list voltage_sensors[] = {
 	{ SENSORS_SUBFEATURE_IN_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_IN_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_IN_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_IN_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_IN_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
@@ -651,6 +656,9 @@ static const struct sensor_subfeature_list current_sensors[] = {
 	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_CURR_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_CURR_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_CURR_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
