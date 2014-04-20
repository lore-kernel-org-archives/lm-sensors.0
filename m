From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Apr 2014 12:57:23 +0000
Subject: [lm-sensors] [PATCH 2/2] sensors: Add support for temp[1-*]_min_hyst and temp[1-*]_lcrit_hyst
Message-Id: <20140420145723.09af01de@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for sysfs attributes temp[1-*]_min_hyst and
temp[1-*]_lcrit_hyst.
---
 prog/sensors/chips.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/sensors/chips.c	2014-04-20 14:41:58.363341231 +0200
+++ lm-sensors/prog/sensors/chips.c	2014-04-20 14:49:52.201665552 +0200
@@ -237,6 +237,16 @@ static void get_sensor_limit_data(const
 	}
 }
 
+static const struct sensor_subfeature_list temp_min_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_MIN_HYST, NULL, 0, hyst_str },
+	{ -1, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list temp_lcrit_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT_HYST, NULL, 0, hyst_str },
+	{ -1, NULL, 0, NULL }
+};
+
 static const struct sensor_subfeature_list temp_max_sensors[] = {
 	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, 0, hyst_str },
 	{ -1, NULL, 0, NULL }
@@ -260,9 +270,9 @@ static const struct sensor_subfeature_li
 	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, 1, "HIGH" },
 	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, 1, "CRIT" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, 1, "EMERGENCY" },
-	{ SENSORS_SUBFEATURE_TEMP_MIN, NULL, 0, "low" },
+	{ SENSORS_SUBFEATURE_TEMP_MIN, temp_min_sensors, 0, "low" },
 	{ SENSORS_SUBFEATURE_TEMP_MAX, temp_max_sensors, 0, "high" },
-	{ SENSORS_SUBFEATURE_TEMP_LCRIT, NULL, 0, "crit low" },
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT, temp_lcrit_sensors, 0, "crit low" },
 	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, 0, "crit" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, 0,
 	    "emerg" },

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
