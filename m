From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Mar 2011 04:20:06 +0000
Subject: [lm-sensors] [PATCH v2] sensors: Add support for additional
Message-Id: <20110316042006.GA25075@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

This patch adds support for additional sensor attributes to the sensors command.

v2: Incorporated feedback from code review as follows.

- Changed several variable and function names to better match functionality.
- Removed unnecessary conditionals.
- Modified output to better match original alignment.
- Always print alarms if set, even if there are no limit registers
- Added range check to get_sensor_limit_data() to avoid buffer overruns.
  If an overrun occurs, display an error message and try to write a core dump.
- Added comment explaining when alarms are queued, and why alarm values are
  not queued.
- Avoid use of strcpy() and strcat(). Instead, use patch from Jean's
  review to attach temperature units to limit values.
- Print highest/lowest as well as max/crit power attributes if provided.
- Replace MIN/MAX temperature alarms with LOW/HIGH.
- If an attribute value is 0, display the value with its base unit,
  not with the minumum supported unit.
- Replace "emergency" with "emerg" for emergency high temperature attributes.

An example sensors output from a system with lots of sensors is attached
for reference.

--

Index: prog/sensors/chips.c
===================================================================
--- prog/sensors/chips.c	(revision 5939)
+++ prog/sensors/chips.c	(working copy)
@@ -24,6 +24,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <math.h>
+#include <sys/types.h>
+#include <signal.h>
 
 #include "main.h"
 #include "chips.h"
@@ -126,38 +128,159 @@
 	return max_size + 2;
 }
 
-static void print_temp_limits(double limit1, double limit2,
-			      const char *name1, const char *name2, int alarm)
+static void print_alarms(struct sensor_subfeature_data *alarms, int alarm_count,
+			 int leading_spaces)
 {
-	if (fahrenheit) {
-		limit1 = deg_ctof(limit1);
-		limit2 = deg_ctof(limit2);
-        }
+	int i;
 
-	if (name2) {
-		printf("(%-4s = %+5.1f%s, %-4s = %+5.1f%s)  ",
-		       name1, limit1, degstr,
-		       name2, limit2, degstr);
-	} else if (name1) {
-		printf("(%-4s = %+5.1f%s)                  ",
-		       name1, limit1, degstr);
-	} else {
-		printf("                                  ");
+	printf("%*s", leading_spaces + 7, "ALARM");
+	if (alarms[0].name) {
+		printf(" (");
+		for (i = 0; i < alarm_count; i++) {
+			printf("%s", alarms[i].name);
+			if (i < alarm_count - 1)
+				printf(", ");
+		}
+		printf(")");
 	}
+}
 
-	if (alarm)
-		printf("ALARM  ");
+static void print_limits(struct sensor_subfeature_data *limits,
+			 int limit_count,
+			 struct sensor_subfeature_data *alarms,
+			 int alarm_count, int label_size,
+			 const char *fmt)
+{
+	int i;
+	int alarms_printed = 0;
+
+	for (i = 0; i < limit_count; i++) {
+		if (!(i & 1)) {
+			if (i)
+				printf("\n%*s", label_size + 10, "");
+			printf("(");
+		} else {
+			printf(", ");
+		}
+		printf(fmt, limits[i].name, limits[i].value,
+			     limits[i].unit);
+		if ((i & 1) || i == limit_count - 1) {
+			printf(")");
+			if (i < 2 && alarm_count) {
+				print_alarms(alarms, alarm_count,
+					     (i & 1) ?  0 : 16);
+				alarms_printed = 1;
+			}
+		}
+	}
+	if (alarm_count && !alarms_printed)
+		print_alarms(alarms, alarm_count, 32);
 }
 
+static void get_sensor_limit_data(const sensors_chip_name *name,
+				  const sensors_feature *feature,
+				  const struct sensor_subfeature_list *sfl,
+				  struct sensor_subfeature_data *limits,
+				  int max_limits,
+				  int *num_limits,
+				  struct sensor_subfeature_data *alarms,
+				  int max_alarms,
+				  int *num_alarms)
+{
+	const sensors_subfeature *sf;
+
+	for (; sfl->subfeature >= 0; sfl++) {
+		sf = sensors_get_subfeature(name, feature, sfl->subfeature);
+		if (sf) {
+			if (sfl->alarm) {
+				/*
+				 * Only queue alarm subfeatures if the alarm
+				 * is active, and don't store the alarm value
+				 * (it is implied to be active if queued).
+				 */
+				if (get_value(name, sf)) {
+					if (*num_alarms >= max_alarms) {
+						fprintf(stderr,
+							"Not enough alarm buffers (%d)\n",
+							max_alarms);
+						kill(0, SIGABRT);
+					}
+					alarms[*num_alarms].name = sfl->name;
+					(*num_alarms)++;
+				}
+			} else {
+				/*
+				 * Always queue limit subfeatures with their value.
+				 */
+				if (*num_limits >= max_limits) {
+					fprintf(stderr,
+						"Not enough limit buffers (%d)\n",
+						max_limits);
+					kill(0, SIGABRT);
+				}
+				limits[*num_limits].value = get_value(name, sf);
+				limits[*num_limits].name = sfl->name;
+				(*num_limits)++;
+			}
+			if (sfl->exists) {
+				get_sensor_limit_data(name, feature, sfl->exists,
+						      limits, max_limits, num_limits,
+						      alarms, max_alarms, num_alarms);
+			}
+		} else if (sfl->nexists)
+			get_sensor_limit_data(name, feature, sfl->nexists,
+					      limits, max_limits, num_limits,
+					      alarms, max_alarms, num_alarms);
+	}
+}
+
+static const struct sensor_subfeature_list temp_alarms[] = {
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_TEMP_MIN_ALARM, NULL, NULL, 1, "LOW" },
+	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, NULL, 1, "HIGH" },
+	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, NULL, 1, "EMERGENCY" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list temp_max_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, NULL, 0, "hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list temp_crit_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, NULL, 0, "crit hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list temp_emergency_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, NULL, 0,
+	    "emerg hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list temp_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_ALARM, NULL, temp_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_TEMP_MIN, NULL, NULL, 0, "low" },
+	{ SENSORS_SUBFEATURE_TEMP_MAX, temp_max_sensors, NULL, 0, "high" },
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT, NULL, NULL, 0, "crit low" },
+	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, NULL, 0, "crit" },
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, NULL, 0,
+	    "emerg" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
 static void print_chip_temp(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sfhyst;
-	double val, limit1, limit2;
-	const char *s1, *s2;
-	int alarm, crit_displayed = 0;
+	struct sensor_subfeature_data sensors[8];
+	struct sensor_subfeature_data alarms[5];
+	int sensor_count, alarm_count;
+	const sensors_subfeature *sf;
+	double val;
 	char *label;
+	int i;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -168,80 +291,6 @@
 	free(label);
 
 	sf = sensors_get_subfeature(name, feature,
-				    SENSORS_SUBFEATURE_TEMP_ALARM);
-	alarm = sf && get_value(name, sf);
-
-	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_TEMP_MIN);
-	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_TEMP_MAX);
-	sfcrit = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT);
-	if (sfmax) {
-		sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_MAX_ALARM);
-		if (sf && get_value(name, sf))
-			alarm |= 1;
-
-     		if (sfmin) {
-			limit1 = get_value(name, sfmin);
-			s1 = "low";
-			limit2 = get_value(name, sfmax);
-			s2 = "high";
-
-			sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_MIN_ALARM);
-			if (sf && get_value(name, sf))
-				alarm |= 1;
-		} else {
-			limit1 = get_value(name, sfmax);
-			s1 = "high";
-
-			sfhyst = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_MAX_HYST);
-			if (sfhyst) {
-				limit2 = get_value(name, sfhyst);
-				s2 = "hyst";
-			} else if (sfcrit) {
-				limit2 = get_value(name, sfcrit);
-				s2 = "crit";
-
-				sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
-				if (sf && get_value(name, sf))
-					alarm |= 1;
-				crit_displayed = 1;
-			} else {
-				limit2 = 0;
-				s2 = NULL;
-			}
-		}
-	} else if (sfcrit) {
-		limit1 = get_value(name, sfcrit);
-		s1 = "crit";
-
-		sfhyst = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
-		if (sfhyst) {
-			limit2 = get_value(name, sfhyst);
-			s2 = "hyst";
-		} else {
-			limit2 = 0;
-			s2 = NULL;
-		}
-
-		sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
-		if (sf && get_value(name, sf))
-			alarm |= 1;
-		crit_displayed = 1;
-	} else {
-		limit1 = limit2 = 0;
-		s1 = s2 = NULL;
-	}
-
-
-	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_FAULT);
 	if (sf && get_value(name, sf)) {
 		printf("   FAULT  ");
@@ -256,30 +305,21 @@
 		} else
 			printf("     N/A  ");
 	}
-	print_temp_limits(limit1, limit2, s1, s2, alarm);
 
-	if (!crit_displayed && sfcrit) {
-		limit1 = get_value(name, sfcrit);
-		s1 = "crit";
+	sensor_count = alarm_count = 0;
+	get_sensor_limit_data(name, feature, temp_sensors,
+			      sensors, 8, &sensor_count,
+			      alarms, 5, &alarm_count);
 
-		sfhyst = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
-		if (sfhyst) {
-			limit2 = get_value(name, sfhyst);
-			s2 = "hyst";
-		} else {
-			limit2 = 0;
-			s2 = NULL;
-		}
+	for (i = 0; i < sensor_count; i++) {
+		if (fahrenheit)
+			sensors[i].value = deg_ctof(sensors[i].value);
+		sensors[i].unit = degstr;
+	}
 
-		sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
-		alarm = sf && get_value(name, sf);
+	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
+		     "%-4s = %+5.1f%s");
 
-		printf("\n%*s", label_size + 10, "");
-		print_temp_limits(limit1, limit2, s1, s2, alarm);
-	}
-
 	/* print out temperature sensor info */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_TYPE);
@@ -302,13 +342,33 @@
 	printf("\n");
 }
 
+static const struct sensor_subfeature_list voltage_alarms[] = {
+	{ SENSORS_SUBFEATURE_IN_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_IN_MIN_ALARM, NULL, NULL, 1, "MIN" },
+	{ SENSORS_SUBFEATURE_IN_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_IN_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list voltage_sensors[] = {
+	{ SENSORS_SUBFEATURE_IN_ALARM, NULL, voltage_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_IN_LCRIT, NULL, NULL, 0, "crit min" },
+	{ SENSORS_SUBFEATURE_IN_MIN, NULL, NULL, 0, "min" },
+	{ SENSORS_SUBFEATURE_IN_MAX, NULL, NULL, 0, "max" },
+	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, NULL, 0, "crit max" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
 static void print_chip_in(const sensors_chip_name *name,
 			  const sensors_feature *feature,
 			  int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
-	double val, alarm_max, alarm_min;
+	const sensors_subfeature *sf;
 	char *label;
+	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data alarms[4];
+	int sensor_count, alarm_count;
+	double val;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -321,50 +381,18 @@
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_IN_INPUT);
 	if (sf && get_input_value(name, sf, &val) == 0)
-		printf("%+6.2f V", val);
+		printf("%+6.2f V  ", val);
 	else
-		printf("     N/A");
+		printf("     N/A  ");
 
-	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_IN_MIN);
-	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_IN_MAX);
-	if (sfmin && sfmax)
-		printf("  (min = %+6.2f V, max = %+6.2f V)",
-		       get_value(name, sfmin),
-		       get_value(name, sfmax));
-	else if (sfmin)
-		printf("  (min = %+6.2f V)",
-		       get_value(name, sfmin));
-	else if (sfmax)
-		printf("  (max = %+6.2f V)",
-		       get_value(name, sfmax));
+	sensor_count = alarm_count = 0;
+	get_sensor_limit_data(name, feature, voltage_sensors,
+			      sensors, 4, &sensor_count,
+			      alarms, 4, &alarm_count);
 
-	sf = sensors_get_subfeature(name, feature,
-				    SENSORS_SUBFEATURE_IN_ALARM);
-	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_IN_MIN_ALARM);
-	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_IN_MAX_ALARM);
-	if (sfmin || sfmax) {
-		alarm_max = sfmax ? get_value(name, sfmax) : 0;
-		alarm_min = sfmin ? get_value(name, sfmin) : 0;
+	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
+		     "%s = %+6.2f V");
 
-		if (alarm_min || alarm_max) {
-			printf(" ALARM (");
-
-			if (alarm_min)
-				printf("MIN");
-			if (alarm_max)
-				printf("%sMAX", (alarm_min) ? ", " : "");
-
-			printf(")");
-		}
-	} else if (sf) {
-		printf("   %s",
-		       get_value(name, sf) ? "ALARM" : "");
-	}
-
 	printf("\n");
 }
 
@@ -441,6 +469,11 @@
 	};
 	struct scale_table *scale = prefix_scales;
 
+	if (abs_value == 0) {
+		*prefixstr = "";
+		return;
+	}
+
 	while (scale->upper_bound && abs_value > scale->upper_bound) {
 		divisor = scale->upper_bound;
 		scale++;
@@ -450,15 +483,49 @@
 	*prefixstr = scale->unit;
 }
 
+static const struct sensor_subfeature_list power_alarms[] = {
+	{ SENSORS_SUBFEATURE_POWER_CAP_ALARM, NULL, NULL, 1, "CAP" },
+	{ SENSORS_SUBFEATURE_POWER_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_POWER_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list power_max[] = {
+	{ SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
+	{ SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
+	{ SENSORS_SUBFEATURE_POWER_CAP, NULL, NULL, 0, "cap" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list power_inst_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, power_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, power_max, power_max, 0,
+		"highest" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list power_avg_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, NULL, 1, NULL },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, NULL, 0, "highest" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, power_max, power_max, 0,
+		"interval" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
 static void print_chip_power(const sensors_chip_name *name,
 			     const sensors_feature *feature,
 			     int label_size)
 {
 	double val;
-	int need_space = 0;
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
+	const sensors_subfeature *sf;
+	struct sensor_subfeature_data sensors[6];
+	struct sensor_subfeature_data alarms[3];
+	int sensor_count, alarm_count;
 	char *label;
 	const char *unit;
+	int i;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -468,60 +535,30 @@
 	print_label(label, label_size);
 	free(label);
 
+	sensor_count = alarm_count = 0;
+
 	/* Power sensors come in 2 flavors: instantaneous and averaged.
 	   To keep things simple, we assume that each sensor only implements
 	   one flavor. */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_POWER_INPUT);
-	if (sf) {
-		sfmin = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
-		sfmax = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
-		sfint = NULL;
-	} else {
-		sf = sensors_get_subfeature(name, feature,
-					    SENSORS_SUBFEATURE_POWER_AVERAGE);
-		sfmin = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
-		sfmax = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
-		sfint = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
-	}
+	get_sensor_limit_data(name, feature, 
+			      sf ? power_inst_sensors : power_avg_sensors,
+			      sensors, 6, &sensor_count,
+			      alarms, 3, &alarm_count);
 
 	if (sf && get_input_value(name, sf, &val) == 0) {
 		scale_value(&val, &unit);
-		printf("%6.2f %sW", val, unit);
+		printf("%6.2f %sW  ", val, unit);
 	} else
-		printf("     N/A");
+		printf("     N/A  ");
 
-	if (sfmin || sfmax || sfint) {
-		printf("  (");
+	for (i = 0; i < sensor_count; i++)
+		scale_value(&sensors[i].value, &sensors[i].unit);
 
-		if (sfmin) {
-			val = get_value(name, sfmin);
-			scale_value(&val, &unit);
-			printf("min = %6.2f %sW", val, unit);
-			need_space = 1;
-		}
+	print_limits(sensors, sensor_count, alarms, alarm_count,
+		     label_size, "%s = %6.2f %sW");
 
-		if (sfmax) {
-			val = get_value(name, sfmax);
-			scale_value(&val, &unit);
-			printf("%smax = %6.2f %sW", (need_space ? ", " : ""),
-			       val, unit);
-			need_space = 1;
-		}
-
-		if (sfint) {
-			printf("%sinterval = %6.2f s", (need_space ? ", " : ""),
-			       get_value(name, sfint));
-			need_space = 1;
-		}
-		printf(")");
-	}
-
 	printf("\n");
 }
 
@@ -595,13 +632,33 @@
 	free(label);
 }
 
+static const struct sensor_subfeature_list current_alarms[] = {
+	{ SENSORS_SUBFEATURE_CURR_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_CURR_MIN_ALARM, NULL, NULL, 1, "MIN" },
+	{ SENSORS_SUBFEATURE_CURR_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_CURR_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_subfeature_list current_sensors[] = {
+	{ SENSORS_SUBFEATURE_CURR_ALARM, NULL, current_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_CURR_LCRIT, NULL, NULL, 0, "crit min" },
+	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, NULL, 0, "min" },
+	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, NULL, 0, "max" },
+	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, NULL, 0, "crit max" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
 static void print_chip_curr(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
-	double alarm_max, alarm_min, val;
+	const sensors_subfeature *sf;
+	double val;
 	char *label;
+	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data alarms[4];
+	int sensor_count, alarm_count;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -614,50 +671,18 @@
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_CURR_INPUT);
 	if (sf && get_input_value(name, sf, &val) == 0)
-		printf("%+6.2f A", val);
+		printf("%+6.2f A  ", val);
 	else
-		printf("     N/A");
+		printf("     N/A  ");
 
-	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MIN);
-	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MAX);
-	if (sfmin && sfmax)
-		printf("  (min = %+6.2f A, max = %+6.2f A)",
-		       get_value(name, sfmin),
-		       get_value(name, sfmax));
-	else if (sfmin)
-		printf("  (min = %+6.2f A)",
-		       get_value(name, sfmin));
-	else if (sfmax)
-		printf("  (max = %+6.2f A)",
-		       get_value(name, sfmax));
+	sensor_count = alarm_count = 0;
+	get_sensor_limit_data(name, feature, current_sensors,
+			      sensors, 4, &sensor_count,
+			      alarms, 4, &alarm_count);
 
-	sf = sensors_get_subfeature(name, feature,
-				    SENSORS_SUBFEATURE_CURR_ALARM);
-	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MIN_ALARM);
-	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MAX_ALARM);
-	if (sfmin || sfmax) {
-		alarm_max = sfmax ? get_value(name, sfmax) : 0;
-		alarm_min = sfmin ? get_value(name, sfmin) : 0;
+	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
+		     "%s = %+6.2f A");
 
-		if (alarm_min || alarm_max) {
-			printf(" ALARM (");
-
-			if (alarm_min)
-				printf("MIN");
-			if (alarm_max)
-				printf("%sMAX", (alarm_min) ? ", " : "");
-
-			printf(")");
-		}
-	} else if (sf) {
-		printf("   %s",
-		       get_value(name, sf) ? "ALARM" : "");
-	}
-
 	printf("\n");
 }
 
Index: prog/sensors/chips.h
===================================================================
--- prog/sensors/chips.h	(revision 5939)
+++ prog/sensors/chips.h	(working copy)
@@ -24,6 +24,32 @@
 
 #include "lib/sensors.h"
 
+/*
+ * Retrieved limits
+ */
+struct sensor_subfeature_data {
+	double value;		/* Subfeature value. Not used for alarms. */
+	const char *name;	/* Subfeature name */
+	const char *unit;	/* Unit to be displayed for this subfeature.
+				   This field is optional. */
+};
+
+/*
+ * Subfeature data structure. Used to create a table of supported subfeatures
+ * for a given feature.
+ */
+struct sensor_subfeature_list {
+	int subfeature;		/* Limit we are looking for */
+	const struct sensor_subfeature_list *exists;
+				/* Complementary subfeatures to be displayed
+				   if subfeature exists */
+	const struct sensor_subfeature_list *nexists;
+				/* Alternative subfeatures to be displayed
+				   if subfeature does not exist */
+	int alarm;		/* true if this is an alarm */
+	const char *name;	/* subfeature name to be printed */
+};
+
 void print_chip_raw(const sensors_chip_name *name);
 void print_chip(const sensors_chip_name *name);
 

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="sensors.log"

max6696-i2c-1-19
Adapter: Phalanx i2c channel 1
temp1:        +22.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

max6696-i2c-100-18
Adapter: SMBus I801 adapter at 5080
temp1:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +81.9 C  (low  = -55.0 C, high = +70.0 C)  ALARM (HIGH)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:        +23.5 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

bmr453-i2c-0-12
Adapter: Phalanx i2c channel 0
vin:         +53.75 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +12.00 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +28.0 C  (low  = -40.0 C, high = +125.0 C)
                       (crit low = -50.0 C, crit = +135.0 C)
iout1:        +5.25 A  (max = +39.00 A, crit max = +39.00 A)

max6696-i2c-100-19
Adapter: SMBus I801 adapter at 5080
temp1:        +21.5 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:        +21.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-0-5c
Adapter: Phalanx i2c channel 0
vin:         +12.06 V  (crit min =  +8.00 V, min = +10.50 V)
                       (max = +13.20 V, crit max = +14.00 V)
vout1:        +1.09 V  (crit min =  +0.97 V, min =  +1.00 V)
                       (max =  +1.10 V, crit max =  +1.13 V)
vout2:        +1.50 V  (crit min =  +1.39 V, min =  +1.41 V)
                       (max =  +1.59 V, crit max =  +1.61 V)
vout3:        +1.01 V  (crit min =  +0.93 V, min =  +0.95 V)
                       (max =  +1.05 V, crit max =  +1.07 V)
vout4:        +1.84 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.94 V, crit max =  +1.98 V)
vout5:        +1.23 V  (crit min =  +1.11 V, min =  +1.14 V)
                       (max =  +1.26 V, crit max =  +1.29 V)
vout6:        +1.02 V  (crit min =  +0.93 V, min =  +0.95 V)
                       (max =  +1.05 V, crit max =  +1.07 V)
vout7:        +1.02 V  (crit min =  +0.93 V, min =  +0.95 V)
                       (max =  +1.05 V, crit max =  +1.07 V)
vout8:        +0.90 V  (crit min =  +0.83 V, min =  +0.85 V)
                       (max =  +0.94 V, crit max =  +0.97 V)
temp1:        +28.8 C  (low  =  -5.0 C, high = +95.0 C)
                       (crit low =  -5.0 C, crit = +100.0 C)

ltc4261-i2c-0-10
Adapter: Phalanx i2c channel 0
in1:          +0.00 V  
Vin:         +49.16 V  
Cin:          +4.44 A  

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +25.0 C  (high = +74.0 C, crit = +94.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:       +25.0 C  (high = +74.0 C, crit = +94.0 C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:       +26.0 C  (high = +74.0 C, crit = +94.0 C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:       +25.0 C  (high = +74.0 C, crit = +94.0 C)

lm75-i2c-70-48
Adapter: i2c-2-mux (chan_id 0)
temp1:        +19.5 C  (high = +80.0 C, hyst = +75.0 C)

lm75-i2c-71-49
Adapter: i2c-2-mux (chan_id 0)
temp1:        +19.5 C  (high = +80.0 C, hyst = +75.0 C)

jc42-i2c-100-1a
Adapter: SMBus I801 adapter at 5080
temp1:        +27.2 C  (low  =  +0.0 C, high =  +0.0 C)  ALARM (HIGH, CRIT)
                       (hyst =  +0.0 C, crit =  +0.0 C)
                       (crit hyst =  +0.0 C)

jc42-i2c-100-1b
Adapter: SMBus I801 adapter at 5080
temp1:        +26.5 C  (low  =  +0.0 C, high =  +0.0 C)  ALARM (HIGH, CRIT)
                       (hyst =  +0.0 C, crit =  +0.0 C)
                       (crit hyst =  +0.0 C)

lineage_pem-i2c-60-44
Adapter: i2c-55-mux (chan_id 0)
in1:         +54.16 V  
in2:         +51.00 V  
fan1:             N/A
temp1:        +64.0 C  (high = +97.0 C, crit = +107.0 C)
power1:      887.00 W  
curr1:       +15.00 A  

ssrft-i2c-68-74
Adapter: i2c-57-mux (chan_id 0)
in0:         +54.00 V  
fan1:        4026 RPM  (min =  700 RPM)
fan2:        4092 RPM  (min =  700 RPM)
fan3:        4092 RPM  (min =  700 RPM)
fan4:        4092 RPM  (min =  700 RPM)
fan5:        4092 RPM  (min =  700 RPM)
fan6:        4092 RPM  (min =  700 RPM)
temp1:        +24.0 C  (high = +35.0 C, crit = +40.0 C)
curr1:        +5.50 A  

lineage_pem-i2c-61-45
Adapter: i2c-55-mux (chan_id 0)
in1:          +0.00 V                                    ALARM
in2:          +0.00 V                                    ALARM
fan1:             N/A
temp1:        +35.0 C  (high = +97.0 C, crit = +107.0 C)
power1:        0.00 W  
curr1:        +0.00 A  

ssrft-i2c-69-74
Adapter: i2c-58-mux (chan_id 0)
in0:         +54.25 V  
fan1:        4290 RPM  (min =  700 RPM)
fan2:        4290 RPM  (min =  700 RPM)
fan3:        4356 RPM  (min =  700 RPM)
fan4:        4224 RPM  (min =  700 RPM)
fan5:        4224 RPM  (min =  700 RPM)
fan6:        4290 RPM  (min =  700 RPM)
temp1:        +24.0 C  (high = +35.0 C, crit = +40.0 C)
curr1:        +4.00 A  

ltc4261-i2c-12-10
Adapter: Spanky i2c channel 12
in1:          +0.00 V  
Vin:         +54.11 V  
Cin:          +1.19 A  

max6696-i2c-12-18
Adapter: Spanky i2c channel 12
temp1:        +22.6 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-12-5c
Adapter: Spanky i2c channel 12
vin:         +12.05 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.02 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +2.52 V  (crit min =  +2.25 V, min =  +2.32 V)
                       (max =  +2.67 V, crit max =  +2.75 V)
vout4:        +1.80 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +1.50 V  (crit min =  +1.35 V, min =  +1.40 V)
                       (max =  +1.60 V, crit max =  +1.65 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +22.9 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-13-12
Adapter: Spanky i2c channel 13
vin:         +53.75 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +12.01 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +17.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +1.12 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-13-18
Adapter: Spanky i2c channel 13
temp1:        +25.5 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +24.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc4261-i2c-18-10
Adapter: Spanky i2c channel 18
in1:          +0.00 V  
Vin:         +53.94 V  
Cin:          +1.25 A  

max6696-i2c-18-18
Adapter: Spanky i2c channel 18
temp1:        +23.2 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-18-5c
Adapter: Spanky i2c channel 18
vin:         +12.03 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.00 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +2.52 V  (crit min =  +2.25 V, min =  +2.32 V)
                       (max =  +2.67 V, crit max =  +2.75 V)
vout4:        +1.80 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +1.50 V  (crit min =  +1.35 V, min =  +1.40 V)
                       (max =  +1.60 V, crit max =  +1.65 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +23.5 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-19-12
Adapter: Spanky i2c channel 19
vin:         +54.25 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +11.99 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +27.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +1.12 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-19-18
Adapter: Spanky i2c channel 19
temp1:        +25.0 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +22.6 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc4261-i2c-24-10
Adapter: Spanky i2c channel 24
in1:          +0.00 V  
Vin:         +54.17 V  
Cin:          +0.31 A  

max6696-i2c-24-18
Adapter: Spanky i2c channel 24
temp1:        +22.9 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-24-5c
Adapter: Spanky i2c channel 24
vin:         +12.03 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.01 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout4:        +1.80 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +27.8 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-25-12
Adapter: Spanky i2c channel 25
vin:         +53.75 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +11.94 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +29.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +0.75 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-25-18
Adapter: Spanky i2c channel 25
temp1:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +23.8 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc4261-i2c-30-10
Adapter: Spanky i2c channel 30
in1:          +0.00 V  
Vin:         +54.11 V  
Cin:          +1.25 A  

max6696-i2c-30-18
Adapter: Spanky i2c channel 30
temp1:        +22.0 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-30-5c
Adapter: Spanky i2c channel 30
vin:         +12.05 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.02 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout4:        +1.79 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +27.5 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-31-12
Adapter: Spanky i2c channel 31
vin:         +53.50 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +11.96 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +27.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +0.94 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-31-18
Adapter: Spanky i2c channel 31
temp1:        +23.4 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +25.4 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc4261-i2c-36-10
Adapter: Spanky i2c channel 36
in1:          +0.00 V  
Vin:         +54.00 V  
Cin:          +0.00 A  

max6696-i2c-36-18
Adapter: Spanky i2c channel 36
temp1:        +22.6 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-36-5c
Adapter: Spanky i2c channel 36
vin:         +12.05 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.01 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout4:        +1.80 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +27.7 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-37-12
Adapter: Spanky i2c channel 37
vin:         +53.62 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +11.96 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +25.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +0.38 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-37-18
Adapter: Spanky i2c channel 37
temp1:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc4261-i2c-42-10
Adapter: Spanky i2c channel 42
in1:          +0.00 V  
Vin:         +54.11 V  
Cin:          +0.00 A  

max6696-i2c-42-18
Adapter: Spanky i2c channel 42
temp1:        +21.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)

ltc2978-i2c-42-5c
Adapter: Spanky i2c channel 42
vin:         +12.05 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +14.00 V, crit max = +15.00 V)
vout1:        +3.30 V  (crit min =  +2.97 V, min =  +3.07 V)
                       (max =  +3.53 V, crit max =  +3.63 V)
vout2:        +3.01 V  (crit min =  +2.70 V, min =  +2.79 V)
                       (max =  +3.21 V, crit max =  +3.30 V)
vout3:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout4:        +1.80 V  (crit min =  +1.62 V, min =  +1.67 V)
                       (max =  +1.93 V, crit max =  +1.98 V)
vout5:        +0.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout6:        +1.20 V  (crit min =  +1.08 V, min =  +1.11 V)
                       (max =  +1.28 V, crit max =  +1.32 V)
vout7:        +1.00 V  (crit min =  +0.90 V, min =  +0.93 V)
                       (max =  +1.07 V, crit max =  +1.10 V)
vout8:        +0.90 V  (crit min =  +0.81 V, min =  +0.84 V)
                       (max =  +0.96 V, crit max =  +0.99 V)
temp1:        +27.6 C  (low  =  +0.0 C, high = +75.0 C)
                       (crit low = -10.0 C, crit = +100.0 C)

bmr454-i2c-43-12
Adapter: Spanky i2c channel 43
vin:         +53.75 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +80.00 V, crit max = +85.00 V)
vout1:       +12.00 V  (crit min =  +0.00 V, min =  +0.00 V)
                       (max = +15.00 V, crit max = +15.60 V)
temp1:        +26.0 C  (low  = -40.0 C, high = +115.0 C)
                       (crit low = -50.0 C, crit = +125.0 C)
iout1:        +0.38 A  (max = +25.00 A, crit max = +25.00 A)

max6696-i2c-43-18
Adapter: Spanky i2c channel 43
temp1:        +23.1 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emerg = +90.0 C, emerg hyst = +80.0 C)
temp2:        +23.2 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (LOW)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emerg = +120.0 C, emerg hyst = +110.0 C)


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--WIyZ46R2i8wDzkSu--
