From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 03:07:57 +0000
Subject: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110210030757.GA22858@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for additional sensor attributes to the sensors command.
It is essentially a re-submit of a patch submitted earlier, plus support
for additional sensor attributes which have been added to the sysfs ABI
since the original patch was submitted.

This patch rewrites significant paths of chips.c to make it easier to add
additional attributes. A thorough review would therefore be helpful.

--

Resubmitting this one as well. Question is how to proceed with it 
if no one has time for a thorough review. Maybe commit and clean up
with subsequent patches if needed ? 

Index: prog/sensors/chips.c
=================================--- prog/sensors/chips.c	(revision 5917)
+++ prog/sensors/chips.c	(working copy)
@@ -126,38 +126,124 @@
 	return max_size + 2;
 }
 
-static void print_temp_limits(double limit1, double limit2,
-			      const char *name1, const char *name2, int alarm)
+static void print_limits(struct sensor_limit_data *sensors,
+			 int sensor_count,
+			 struct sensor_limit_data *alarms,
+			 int alarm_count, int label_size,
+			 const char *fmt)
 {
-	if (fahrenheit) {
-		limit1 = deg_ctof(limit1);
-		limit2 = deg_ctof(limit2);
-        }
+	int i, j;
+	int first = 1;
 
-	if (name2) {
-		printf("(%-4s = %+5.1f%s, %-4s = %+5.1f%s)  ",
-		       name1, limit1, degstr,
-		       name2, limit2, degstr);
-	} else if (name1) {
-		printf("(%-4s = %+5.1f%s)                  ",
-		       name1, limit1, degstr);
-	} else {
-		printf("                                  ");
+	for (i = 0; i < sensor_count; i++) {
+		if (!(i & 1)) {
+			if (i)
+				printf("\n%*s", label_size + 10, "");
+			printf("(");
+		} else if (i)
+			printf(", ");
+		printf(fmt, sensors[i].name, sensors[i].value, sensors[i].unit);
+		if ((i & 1) || i = sensor_count - 1) {
+			printf(")  ");
+			if (first && alarm_count) {
+				printf("  ALARM");
+				if (alarm_count > 1 || alarms[0].name) {
+					printf("(");
+					for (j = 0; j < alarm_count; j++) {
+						printf("%s", alarms[j].name);
+						if (j < alarm_count - 1)
+							printf(", ");
+					}
+					printf(")");
+				}
+				first = 0;
+			}
+		}
 	}
+}
 
-	if (alarm)
-		printf("ALARM  ");
+static void get_sensor_limit_data(const sensors_chip_name *name,
+				  const sensors_feature *feature,
+				  const struct sensor_limits *ts,
+				  struct sensor_limit_data *ts_data,
+				  int *ts_sensors,
+				  struct sensor_limit_data *ts_alarm_data,
+				  int *ts_alarms)
+{
+	const sensors_subfeature *sf;
+
+	for (; ts->subfeature >= 0; ts++) {
+		sf = sensors_get_subfeature(name, feature, ts->subfeature);
+		if (sf) {
+			if (ts->alarm && get_value(name, sf)) {
+				ts_alarm_data[*ts_alarms].name = ts->name;
+				(*ts_alarms)++;
+			} else if (!ts->alarm) {
+				ts_data[*ts_sensors].value
+				  = get_value(name, sf);
+				ts_data[*ts_sensors].name = ts->name;
+				(*ts_sensors)++;
+			}
+			if (ts->exists) {
+				get_sensor_limit_data(name, feature, ts->exists,
+						      ts_data, ts_sensors,
+						      ts_alarm_data, ts_alarms);
+			}
+		} else if (!sf && ts->nexists)
+			get_sensor_limit_data(name, feature, ts->nexists,
+					      ts_data, ts_sensors,
+					      ts_alarm_data, ts_alarms);
+	}
 }
 
+static const struct sensor_limits temp_alarms[] = {
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_TEMP_MIN_ALARM, NULL, NULL, 1, "MIN" },
+	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, NULL, 1, "EMERGENCY" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits temp_max_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, NULL, 0, "hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits temp_crit_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, NULL, 0, "crit hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits temp_emergency_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, NULL, 0,
+	    "emergency hyst" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits temp_sensors[] = {
+	{ SENSORS_SUBFEATURE_TEMP_ALARM, NULL, temp_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_TEMP_MIN, NULL, NULL, 0, "low" },
+	{ SENSORS_SUBFEATURE_TEMP_MAX, temp_max_sensors, NULL, 0, "high" },
+	{ SENSORS_SUBFEATURE_TEMP_LCRIT, NULL, NULL, 0, "crit low" },
+	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, NULL, 0, "crit" },
+	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, NULL, 0,
+	    "emergency" },
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
+	struct sensor_limit_data sensors[8];
+	struct sensor_limit_data alarms[5];
+	int sensor_count, alarm_count;
+	const sensors_subfeature *sf;
+	double val;
 	char *label;
+	int i;
+	char fmt[32];
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -168,80 +254,6 @@
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
@@ -256,30 +268,21 @@
 		} else
 			printf("     N/A  ");
 	}
-	print_temp_limits(limit1, limit2, s1, s2, alarm);
 
-	if (!crit_displayed && sfcrit) {
-		limit1 = get_value(name, sfcrit);
-		s1 = "crit";
+	sensor_count = alarm_count = 0;
+	get_sensor_limit_data(name, feature, temp_sensors,
+			      sensors, &sensor_count,
+			      alarms, &alarm_count);
 
-		sfhyst = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
-		if (sfhyst) {
-			limit2 = get_value(name, sfhyst);
-			s2 = "hyst";
-		} else {
-			limit2 = 0;
-			s2 = NULL;
-		}
+	if (fahrenheit)
+		for (i = 0; i < sensor_count; i++)
+			sensors[i].value = deg_ctof(sensors[i].value);
 
-		sf = sensors_get_subfeature(name, feature,
-					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
-		alarm = sf && get_value(name, sf);
+	strcpy(fmt, "%-4s = %+5.1f");
+	strcat(fmt, degstr);
+	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
+		     fmt);
 
-		printf("\n%*s", label_size + 10, "");
-		print_temp_limits(limit1, limit2, s1, s2, alarm);
-	}
-
 	/* print out temperature sensor info */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_TYPE);
@@ -302,13 +305,33 @@
 	printf("\n");
 }
 
+static const struct sensor_limits voltage_alarms[] = {
+	{ SENSORS_SUBFEATURE_IN_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_IN_MIN_ALARM, NULL, NULL, 1, "MIN" },
+	{ SENSORS_SUBFEATURE_IN_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_IN_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits voltage_sensors[] = {
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
+	struct sensor_limit_data sensors[4];
+	struct sensor_limit_data alarms[4];
+	int sensor_count, alarm_count;
+	double val;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -321,50 +344,18 @@
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_IN_INPUT);
 	if (sf && get_input_value(name, sf, &val) = 0)
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
+			      sensors, &sensor_count,
+			      alarms, &alarm_count);
 
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
 
@@ -450,15 +441,53 @@
 	*prefixstr = scale->unit;
 }
 
+static const struct sensor_limits power_alarms[] = {
+	{ SENSORS_SUBFEATURE_POWER_CAP_ALARM, NULL, NULL, 1, "CAP" },
+	{ SENSORS_SUBFEATURE_POWER_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_POWER_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits power_inst_highest[] = {
+	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, NULL, 0, "max" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits power_inst_max[] = {
+	{ SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
+	{ SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits power_inst_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, power_alarms, 1, NULL },
+	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, power_inst_highest,
+	    power_inst_max, 0, "min" },
+	{ SENSORS_SUBFEATURE_POWER_CAP, NULL, NULL, 0, "cap" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits power_avg_sensors[] = {
+	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, NULL, 1, NULL },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, NULL, 0, "min" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, NULL, 0, "max" },
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, NULL, 0,
+	    "interval" },
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
+	struct sensor_limit_data sensors[4];
+	struct sensor_limit_data alarms[3];
+	int sensor_count, alarm_count;
 	char *label;
 	const char *unit;
+	int i;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -468,60 +497,36 @@
 	print_label(label, label_size);
 	free(label);
 
+	sensor_count = alarm_count = 0;
+
 	/* Power sensors come in 2 flavors: instantaneous and averaged.
 	   To keep things simple, we assume that each sensor only implements
 	   one flavor. */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_POWER_INPUT);
 	if (sf) {
-		sfmin = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
-		sfmax = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
-		sfint = NULL;
+		get_sensor_limit_data(name, feature, power_inst_sensors,
+				      sensors, &sensor_count, alarms,
+				      &alarm_count);
 	} else {
-		sf = sensors_get_subfeature(name, feature,
-					    SENSORS_SUBFEATURE_POWER_AVERAGE);
-		sfmin = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
-		sfmax = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
-		sfint = sensors_get_subfeature(name, feature,
-					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
+		get_sensor_limit_data(name, feature, power_avg_sensors,
+				      sensors, &sensor_count, alarms,
+				      &alarm_count);
 	}
 
 	if (sf && get_input_value(name, sf, &val) = 0) {
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
+	if (sensor_count)
+		print_limits(sensors, sensor_count, alarms, alarm_count,
+			     label_size, "%s = %6.2f %sW");
 
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
 
@@ -595,13 +600,33 @@
 	free(label);
 }
 
+static const struct sensor_limits current_alarms[] = {
+	{ SENSORS_SUBFEATURE_CURR_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
+	{ SENSORS_SUBFEATURE_CURR_MIN_ALARM, NULL, NULL, 1, "MIN" },
+	{ SENSORS_SUBFEATURE_CURR_MAX_ALARM, NULL, NULL, 1, "MAX" },
+	{ SENSORS_SUBFEATURE_CURR_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
+	{ -1, NULL, NULL, 0, NULL }
+};
+
+static const struct sensor_limits current_sensors[] = {
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
+	struct sensor_limit_data sensors[4];
+	struct sensor_limit_data alarms[4];
+	int sensor_count, alarm_count;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -614,50 +639,18 @@
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_CURR_INPUT);
 	if (sf && get_input_value(name, sf, &val) = 0)
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
+			      sensors, &sensor_count,
+			      alarms, &alarm_count);
 
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
=================================--- prog/sensors/chips.h	(revision 5917)
+++ prog/sensors/chips.h	(working copy)
@@ -24,6 +24,29 @@
 
 #include "lib/sensors.h"
 
+/*
+ * Retrieved limits
+ */
+struct sensor_limit_data {
+	double value;
+	const char *name;
+	const char *unit;
+};
+
+/*
+ * Limit data structure. Used to create a table of supported limits for a given
+ * feature.
+ */
+struct sensor_limits {
+	int subfeature;				/* Limit we are looking for */
+	const struct sensor_limits *exists;	/* Secondary limits if limit
+						   exists */
+	const struct sensor_limits *nexists;	/* Secondary limits if limit
+						   does not exist */
+	int alarm;				/* true if this is an alarm */
+	const char *name;			/* limit name to be printed */
+};
+
 void print_chip_raw(const sensors_chip_name *name);
 void print_chip(const sensors_chip_name *name);
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
