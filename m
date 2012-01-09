From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 14:40:45 +0000
Subject: [lm-sensors] [PATCH v2] sensors: Use defines for array sizes
Message-Id: <1326120045-2370-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use defines for array sizes. For alarm attributes, take into account that both
the generic alarm flag as well as individual alarm attributes may be provided
by a driver (even though that should not be the case).

Remove overflow checks from get_sensor_limit_data(), as overflows should
no longer happen.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix MAX() macro

 prog/sensors/chips.c |   82 +++++++++++++++++++++++++-------------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
index d1d2a17..36264a8 100644
--- a/prog/sensors/chips.c
+++ b/prog/sensors/chips.c
@@ -201,10 +201,8 @@ static void get_sensor_limit_data(const sensors_chip_name *name,
 				  const sensors_feature *feature,
 				  const struct sensor_subfeature_list *sfl,
 				  struct sensor_subfeature_data *limits,
-				  int max_limits,
 				  int *num_limits,
 				  struct sensor_subfeature_data *alarms,
-				  int max_alarms,
 				  int *num_alarms)
 {
 	const sensors_subfeature *sf;
@@ -219,33 +217,21 @@ static void get_sensor_limit_data(const sensors_chip_name *name,
 				 * (it is implied to be active if queued).
 				 */
 				if (get_value(name, sf)) {
-					if (*num_alarms >= max_alarms) {
-						fprintf(stderr,
-							"Not enough %s buffers (%d)\n",
-							"alarm", max_alarms);
-					} else {
-						alarms[*num_alarms].name = sfl->name;
-						(*num_alarms)++;
-					}
+					alarms[*num_alarms].name = sfl->name;
+					(*num_alarms)++;
 				}
 			} else {
 				/*
 				 * Always queue limit subfeatures with their value.
 				 */
-				if (*num_limits >= max_limits) {
-					fprintf(stderr,
-						"Not enough %s buffers (%d)\n",
-						"limit", max_limits);
-				} else {
-					limits[*num_limits].value = get_value(name, sf);
-					limits[*num_limits].name = sfl->name;
-					(*num_limits)++;
-				}
+				limits[*num_limits].value = get_value(name, sf);
+				limits[*num_limits].name = sfl->name;
+				(*num_limits)++;
 			}
 			if (sfl->exists) {
 				get_sensor_limit_data(name, feature, sfl->exists,
-						      limits, max_limits, num_limits,
-						      alarms, max_alarms, num_alarms);
+						      limits, num_limits,
+						      alarms, num_alarms);
 			}
 		}
 	}
@@ -283,12 +269,19 @@ static const struct sensor_subfeature_list temp_sensors[] = {
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_TEMP_ALARMS		6
+#define NUM_TEMP_SENSORS	(ARRAY_SIZE(temp_sensors) \
+				 + ARRAY_SIZE(temp_max_sensors) \
+				 + ARRAY_SIZE(temp_crit_sensors) \
+				 + ARRAY_SIZE(temp_emergency_sensors) \
+				 - NUM_TEMP_ALARMS - 4)
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
@@ -321,8 +314,7 @@ static void print_chip_temp(const sensors_chip_name *name,
 
 	sensor_count = alarm_count = 0;
 	get_sensor_limit_data(name, feature, temp_sensors,
-			      sensors, ARRAY_SIZE(sensors), &sensor_count,
-			      alarms, ARRAY_SIZE(alarms), &alarm_count);
+			      sensors, &sensor_count, alarms, &alarm_count);
 
 	for (i = 0; i < sensor_count; i++) {
 		if (fahrenheit)
@@ -368,14 +360,17 @@ static const struct sensor_subfeature_list voltage_sensors[] = {
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_IN_ALARMS	5
+#define NUM_IN_SENSORS	(ARRAY_SIZE(voltage_sensors) - NUM_IN_ALARMS - 1)
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
 
@@ -396,8 +391,7 @@ static void print_chip_in(const sensors_chip_name *name,
 
 	sensor_count = alarm_count = 0;
 	get_sensor_limit_data(name, feature, voltage_sensors,
-			      sensors, ARRAY_SIZE(sensors), &sensor_count,
-			      alarms, ARRAY_SIZE(alarms), &alarm_count);
+			      sensors, &sensor_count, alarms, &alarm_count);
 
 	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
 		     "%s = %+6.2f V");
@@ -517,14 +511,21 @@ static const struct sensor_subfeature_list power_avg_sensors[] = {
 	{ -1, NULL, 0, NULL }
 };
 
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#define NUM_POWER_ALARMS	4
+#define NUM_POWER_SENSORS	(ARRAY_SIZE(power_common_sensors) \
+				 + MAX(ARRAY_SIZE(power_inst_sensors), \
+				       ARRAY_SIZE(power_avg_sensors)) \
+				 - NUM_POWER_ALARMS - 2)
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
@@ -547,13 +548,10 @@ static void print_chip_power(const sensors_chip_name *name,
 				    SENSORS_SUBFEATURE_POWER_INPUT);
 	get_sensor_limit_data(name, feature,
 			      sf ? power_inst_sensors : power_avg_sensors,
-			      sensors, ARRAY_SIZE(sensors), &sensor_count,
-			      alarms, ARRAY_SIZE(alarms), &alarm_count);
+			      sensors, &sensor_count, alarms, &alarm_count);
 	/* Add sensors common to both flavors. */
-	get_sensor_limit_data(name, feature,
-			      power_common_sensors,
-			      sensors, ARRAY_SIZE(sensors), &sensor_count,
-			      alarms, ARRAY_SIZE(alarms), &alarm_count);
+	get_sensor_limit_data(name, feature, power_common_sensors,
+			      sensors, &sensor_count, alarms, &alarm_count);
 	if (!sf)
 		sf = sensors_get_subfeature(name, feature,
 					    SENSORS_SUBFEATURE_POWER_AVERAGE);
@@ -656,6 +654,9 @@ static const struct sensor_subfeature_list current_sensors[] = {
 	{ -1, NULL, 0, NULL }
 };
 
+#define NUM_CURR_ALARMS		5
+#define NUM_CURR_SENSORS	(ARRAY_SIZE(current_sensors) - NUM_CURR_ALARMS - 1)
+
 static void print_chip_curr(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
@@ -663,8 +664,8 @@ static void print_chip_curr(const sensors_chip_name *name,
 	const sensors_subfeature *sf;
 	double val;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
-	struct sensor_subfeature_data alarms[4];
+	struct sensor_subfeature_data sensors[NUM_CURR_SENSORS];
+	struct sensor_subfeature_data alarms[NUM_CURR_ALARMS];
 	int sensor_count, alarm_count;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -684,8 +685,7 @@ static void print_chip_curr(const sensors_chip_name *name,
 
 	sensor_count = alarm_count = 0;
 	get_sensor_limit_data(name, feature, current_sensors,
-			      sensors, ARRAY_SIZE(sensors), &sensor_count,
-			      alarms, ARRAY_SIZE(alarms), &alarm_count);
+			      sensors, &sensor_count, alarms, &alarm_count);
 
 	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
 		     "%s = %+6.2f A");
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
