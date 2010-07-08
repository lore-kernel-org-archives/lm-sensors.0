From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Jul 2010 05:43:33 +0000
Subject: [lm-sensors] [PATCH v2] lm-sensors: Add support for new hwmon
Message-Id: <1278567813-9608-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the following new attributes to libsensors and
to the sensors command.

inX_lcrit
inX_crit
inX_lcrit_alarm
inX_crit_alarm
temp_lcrit
temp_emergency
temp_lcrit_alarm
powerX_cap
powerX_max
powerX_crit
powerX_alarm
powerX_crit_alarm
currX_lcrit
currX_crit
currX_lcrit_alarm
currX_crit_alarm

I reworked print_temp_limits() significantly, which asks for a detailed review.
Idea is to make the function better scalable for a large number of attributes
while retaining at least some compatibility with legacy output.

sensord does not yet support the new attributes. The sensord code is a bit more
complex than sensors, and I don't have a clean solution for it yet.

---
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5851)
+++ lib/sensors.h	(working copy)
@@ -151,10 +151,14 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_IN_INPUT = SENSORS_FEATURE_IN << 8,
 	SENSORS_SUBFEATURE_IN_MIN,
 	SENSORS_SUBFEATURE_IN_MAX,
+	SENSORS_SUBFEATURE_IN_LCRIT,
+	SENSORS_SUBFEATURE_IN_CRIT,
 	SENSORS_SUBFEATURE_IN_ALARM = (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
 	SENSORS_SUBFEATURE_IN_BEEP,
+	SENSORS_SUBFEATURE_IN_LCRIT_ALARM,
+	SENSORS_SUBFEATURE_IN_CRIT_ALARM,
 
 	SENSORS_SUBFEATURE_FAN_INPUT = SENSORS_FEATURE_FAN << 8,
 	SENSORS_SUBFEATURE_FAN_MIN,
@@ -169,6 +173,8 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_TEMP_MIN,
 	SENSORS_SUBFEATURE_TEMP_CRIT,
 	SENSORS_SUBFEATURE_TEMP_CRIT_HYST,
+	SENSORS_SUBFEATURE_TEMP_LCRIT,
+	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -177,6 +183,7 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_TEMP_TYPE,
 	SENSORS_SUBFEATURE_TEMP_OFFSET,
 	SENSORS_SUBFEATURE_TEMP_BEEP,
+	SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM,
 
 	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
@@ -184,6 +191,11 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_POWER_INPUT,
 	SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST,
 	SENSORS_SUBFEATURE_POWER_INPUT_LOWEST,
+	SENSORS_SUBFEATURE_POWER_CAP,
+	SENSORS_SUBFEATURE_POWER_MAX,
+	SENSORS_SUBFEATURE_POWER_CRIT,
+	SENSORS_SUBFEATURE_POWER_ALARM,
+	SENSORS_SUBFEATURE_POWER_CRIT_ALARM,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
 
 	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
@@ -191,10 +203,14 @@ typedef enum sensors_subfeature_type {
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
 
Index: lib/sensors.conf.5
=================================--- lib/sensors.conf.5	(revision 5851)
+++ lib/sensors.conf.5	(working copy)
@@ -402,7 +402,7 @@ really cool before the fan stops, so that it will
 again immediately.
 
 So, in addition to tempX_max, many chips have a tempX_max_hyst
-sub-feature. Likewise, tempX_crit often comes with tempX_max_crit.
+sub-feature. Likewise, tempX_crit often comes with tempX_crit_hyst.
 Example:
 
 .RS
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5851)
+++ lib/sysfs.c	(working copy)
@@ -219,11 +219,14 @@ static const struct subfeature_type_match temp_mat
 	{ "max", SENSORS_SUBFEATURE_TEMP_MAX },
 	{ "max_hyst", SENSORS_SUBFEATURE_TEMP_MAX_HYST },
 	{ "min", SENSORS_SUBFEATURE_TEMP_MIN },
+	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_TEMP_CRIT },
 	{ "crit_hyst", SENSORS_SUBFEATURE_TEMP_CRIT_HYST },
+	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_TEMP_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
+	{ "lcrit_alarm", SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM },
 	{ "crit_alarm", SENSORS_SUBFEATURE_TEMP_CRIT_ALARM },
 	{ "fault", SENSORS_SUBFEATURE_TEMP_FAULT },
 	{ "type", SENSORS_SUBFEATURE_TEMP_TYPE },
@@ -236,9 +239,13 @@ static const struct subfeature_type_match in_match
 	{ "input", SENSORS_SUBFEATURE_IN_INPUT },
 	{ "min", SENSORS_SUBFEATURE_IN_MIN },
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
+	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
+	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
+	{ "lcrit_alarm", SENSORS_SUBFEATURE_IN_LCRIT_ALARM },
+	{ "crit_alarm", SENSORS_SUBFEATURE_IN_CRIT_ALARM },
 	{ "beep", SENSORS_SUBFEATURE_IN_BEEP },
 	{ NULL, 0 }
 };
@@ -260,6 +267,11 @@ static const struct subfeature_type_match power_ma
 	{ "input", SENSORS_SUBFEATURE_POWER_INPUT },
 	{ "input_highest", SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST },
 	{ "input_lowest", SENSORS_SUBFEATURE_POWER_INPUT_LOWEST },
+	{ "cap", SENSORS_SUBFEATURE_POWER_CAP },
+	{ "max", SENSORS_SUBFEATURE_POWER_MAX },
+	{ "crit", SENSORS_SUBFEATURE_POWER_CRIT },
+	{ "alarm", SENSORS_SUBFEATURE_POWER_ALARM },
+	{ "crit_alarm", SENSORS_SUBFEATURE_POWER_CRIT_ALARM },
 	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
 	{ NULL, 0 }
 };
@@ -273,9 +285,13 @@ static const struct subfeature_type_match curr_mat
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
Index: prog/sensors/chips.c
=================================--- prog/sensors/chips.c	(revision 5851)
+++ prog/sensors/chips.c	(working copy)
@@ -123,37 +123,44 @@ static int get_label_size(const sensors_chip_name
 	return max_size + 1;
 }
 
-static void print_temp_limits(double limit1, double limit2,
-			      const char *name1, const char *name2, int alarm)
+static void print_temp_limits(double limit[], const char *name[],
+			      int count, int alarm, int label_size)
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
+	if (fahrenheit)
+		for (i=0; i<count; i++)
+			limit[i] = deg_ctof(limit[i]);
+
+	for (i=0; i<count; i++) {
+		if (!(i&1)) {
+			if (i)
+				printf("\n%*s", label_size + 10, "");
+			printf("(");
+		} else if (i)
+			printf(", ");
+		printf("%-4s = %+5.1f%s", name[i], limit[i], degstr);
+		if ((i&1) || i = count-1)
+			printf(")  ");
 	}
 
-	if (alarm)
-		printf("ALARM  ");
+	if (alarm & (2|8))      /* min/max (crit) alarm    */
+		printf("  %sALARM(MIN%s)", (alarm & 8) ? "CRIT " : "",
+                       (alarm &(1|4)) ? ", MAX" : "");
+	else if (alarm & (1|4)) /* max (crit) alarm */
+		printf("  %sALARM  ", (alarm & 4) ? "CRIT " : "");
 }
 
 static void print_chip_temp(const sensors_chip_name *name,
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sfhyst;
-	double val, limit1, limit2;
-	const char *s1, *s2;
-	int alarm, crit_displayed = 0;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sflcrit, *sfcrit,
+				 *sfhyst, *sfemerg;
+	double val, limit[7];
+	const char *s[7];
+	int alarm;
+	int count = 0;
 	char *label;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -172,8 +179,12 @@ static void print_chip_temp(const sensors_chip_nam
 				       SENSORS_SUBFEATURE_TEMP_MIN);
 	sfmax = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_TEMP_MAX);
+	sflcrit = sensors_get_subfeature(name, feature,
+					 SENSORS_SUBFEATURE_TEMP_LCRIT);
 	sfcrit = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_CRIT);
+	sfemerg = sensors_get_subfeature(name, feature,
+					 SENSORS_SUBFEATURE_TEMP_EMERGENCY);
 	if (sfmax) {
 		sf = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_MAX_ALARM);
@@ -181,63 +192,56 @@ static void print_chip_temp(const sensors_chip_nam
 			alarm |= 1;
 
      		if (sfmin) {
-			limit1 = get_value(name, sfmin);
-			s1 = "low";
-			limit2 = get_value(name, sfmax);
-			s2 = "high";
+			limit[count] = get_value(name, sfmin);
+			s[count++] = "low";
 
 			sf = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_MIN_ALARM);
 			if (sf && get_value(name, sf))
-				alarm |= 1;
-		} else {
-			limit1 = get_value(name, sfmax);
-			s1 = "high";
+				alarm |= 2;
+		}
+		limit[count] = get_value(name, sfmax);
+		s[count++] = "high";
 
-			sfhyst = sensors_get_subfeature(name, feature,
+		sfhyst = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_MAX_HYST);
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
+		if (sfhyst) {
+			limit[count] = get_value(name, sfhyst);
+			s[count++] = "hyst";
 		}
-	} else if (sfcrit) {
-		limit1 = get_value(name, sfcrit);
-		s1 = "crit";
+	}
+	if (sflcrit) {
+		limit[count] = get_value(name, sflcrit);
+		s[count++] = "crit low";
+	}
+	if (sfcrit) {
+		limit[count] = get_value(name, sfcrit);
+		s[count++] = sflcrit ? "crit high" : "crit";
 
 		sfhyst = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
 		if (sfhyst) {
-			limit2 = get_value(name, sfhyst);
-			s2 = "hyst";
-		} else {
-			limit2 = 0;
-			s2 = NULL;
+			limit[count] = get_value(name, sfhyst);
+			s[count++] = "crit hyst";
 		}
-
+	}
+	if (sfcrit) {
 		sf = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
 		if (sf && get_value(name, sf))
-			alarm |= 1;
-		crit_displayed = 1;
-	} else {
-		limit1 = limit2 = 0;
-		s1 = s2 = NULL;
+			alarm |= 4;
 	}
+	if (sflcrit) {
+		sf = sensors_get_subfeature(name, feature,
+					SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM);
+		if (sf && get_value(name, sf))
+			alarm |= 8;
+	}
+	if (sfemerg) {
+		limit[count] = get_value(name, sfemerg);
+		s[count++] = "emergency";
+	}
 
-
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_FAULT);
 	if (sf && get_value(name, sf)) {
@@ -253,30 +257,9 @@ static void print_chip_temp(const sensors_chip_nam
 		} else
 			printf("     N/A  ");
 	}
-	print_temp_limits(limit1, limit2, s1, s2, alarm);
 
-	if (!crit_displayed && sfcrit) {
-		limit1 = get_value(name, sfcrit);
-		s1 = "crit";
+	print_temp_limits(limit, s, count, alarm, label_size);
 
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
-		alarm = sf && get_value(name, sf);
-
-		printf("\n%*s", label_size + 10, "");
-		print_temp_limits(limit1, limit2, s1, s2, alarm);
-	}
-
 	/* print out temperature sensor info */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_TYPE);
@@ -303,9 +286,10 @@ static void print_chip_in(const sensors_chip_name
 			  const sensors_feature *feature,
 			  int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sflcrit, *sfcrit;
 	double val, alarm_max, alarm_min;
 	char *label;
+        int crit;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -337,13 +321,61 @@ static void print_chip_in(const sensors_chip_name
 		printf("  (max = %+6.2f V)",
 		       get_value(name, sfmax));
 
+	sflcrit = sensors_get_subfeature(name, feature,
+					 SENSORS_SUBFEATURE_IN_LCRIT);
+	sfcrit = sensors_get_subfeature(name, feature,
+					SENSORS_SUBFEATURE_IN_CRIT);
+	if (sflcrit && sfcrit)
+		printf("\n%*s(crit min = %+6.2f V, crit max = %+6.2f V)",
+		       label_size+10, "",
+		       get_value(name, sflcrit),
+		       get_value(name, sfcrit));
+	else if (sflcrit)
+		printf("\n%*s(crit min = %+6.2f V)",
+		       label_size + 10, "",
+		       get_value(name, sflcrit));
+	else if (sfcrit)
+		printf("\n%*s(crit max = %+6.2f V)",
+		       label_size + 10, "",
+		       get_value(name, sfcrit));
+
+        crit = 0;
+	sfmin = sensors_get_subfeature(name, feature,
+				       SENSORS_SUBFEATURE_IN_LCRIT_ALARM);
+	sfmax = sensors_get_subfeature(name, feature,
+				       SENSORS_SUBFEATURE_IN_CRIT_ALARM);
+	if (sfmin && sfmax) {
+		alarm_max = sfmax ? get_value(name, sfmax) : 0;
+		alarm_min = sfmin ? get_value(name, sfmin) : 0;
+
+		if (alarm_min || alarm_max) {
+			printf(" CRIT ALARM (");
+
+			if (alarm_min)
+				printf("MIN");
+			if (alarm_max)
+				printf("%sMAX", alarm_min ? ", " : "");
+
+			printf(")");
+                        crit = 1;
+		}
+	} else if (sfmax) {
+                alarm_max = get_value(name, sf);
+                if (alarm_max) {
+		        printf("  CRIT ALARM");
+                        crit = 1;
+                }
+	}
+
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_IN_ALARM);
 	sfmin = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_IN_MIN_ALARM);
 	sfmax = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_IN_MAX_ALARM);
-	if (sfmin || sfmax) {
+
+	/* Only display non-critical alarms if there were no critical alarms */
+	if (!crit && (sfmin || sfmax)) {
 		alarm_max = sfmax ? get_value(name, sfmax) : 0;
 		alarm_min = sfmin ? get_value(name, sfmin) : 0;
 
@@ -357,7 +389,7 @@ static void print_chip_in(const sensors_chip_name
 
 			printf(")");
 		}
-	} else if (sf) {
+	} else if (!crit && sf) {
 		printf("   %s",
 		       get_value(name, sf) ? "ALARM" : "");
 	}
@@ -453,9 +485,10 @@ static void print_chip_power(const sensors_chip_na
 {
 	double val;
 	int need_space = 0;
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint, *sfcrit, *sfcap;
 	char *label;
 	const char *unit;
+	double crit = 0;
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -475,7 +508,20 @@ static void print_chip_power(const sensors_chip_na
 					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
 		sfmax = sensors_get_subfeature(name, feature,
 					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
+		sfcap = sensors_get_subfeature(name, feature,
+					       SENSORS_SUBFEATURE_POWER_CAP);
 		sfint = NULL;
+		sfcrit = NULL;
+		/*
+		 * Maybe we have power_max and power_crit instead of highest/lowest
+		 */
+		if (!sfmax) {
+			sfmin = NULL;
+			sfmax = sensors_get_subfeature(name, feature,
+						       SENSORS_SUBFEATURE_POWER_MAX);
+			sfcrit = sensors_get_subfeature(name, feature,
+							SENSORS_SUBFEATURE_POWER_CRIT);
+		}
 	} else {
 		sf = sensors_get_subfeature(name, feature,
 					    SENSORS_SUBFEATURE_POWER_AVERAGE);
@@ -485,6 +531,8 @@ static void print_chip_power(const sensors_chip_na
 					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
 		sfint = sensors_get_subfeature(name, feature,
 					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
+		sfcrit = NULL;
+		sfcap = NULL;
 	}
 
 	if (sf && get_input_value(name, sf, &val) = 0) {
@@ -493,7 +541,7 @@ static void print_chip_power(const sensors_chip_na
 	} else
 		printf("     N/A");
 
-	if (sfmin || sfmax || sfint) {
+	if (sfmin || sfmax || sfcap || sfint || sfcrit) {
 		printf("  (");
 
 		if (sfmin) {
@@ -511,6 +559,22 @@ static void print_chip_power(const sensors_chip_na
 			need_space = 1;
 		}
 
+		if (sfcap) {
+			val = get_value(name, sfcap);
+			scale_value(&val, &unit);
+			printf("%scap = %6.2f %sW", (need_space ? ", " : ""),
+			       val, unit);
+			need_space = 1;
+		}
+
+		if (sfcrit) {
+			val = get_value(name, sfcrit);
+			scale_value(&val, &unit);
+			printf("%scrit = %6.2f %sW", (need_space ? ", " : ""),
+			       val, unit);
+			need_space = 1;
+		}
+
 		if (sfint) {
 			printf("%sinterval = %6.2f s", (need_space ? ", " : ""),
 			       get_value(name, sfint));
@@ -519,6 +583,20 @@ static void print_chip_power(const sensors_chip_na
 		printf(")");
 	}
 
+	sf = sensors_get_subfeature(name, feature,
+				    SENSORS_SUBFEATURE_POWER_CRIT_ALARM);
+	if (sf) {
+		crit = get_value(name, sf);
+		if (crit)
+			printf("   %s", "CRIT ALARM");
+	}
+	if (!crit) {
+		sf = sensors_get_subfeature(name, feature,
+					    SENSORS_SUBFEATURE_POWER_ALARM);
+		if (sf)
+			printf("   %s", get_value(name, sf) ? "ALARM" : "");
+	}
+
 	printf("\n");
 }
 
@@ -596,7 +674,7 @@ static void print_chip_curr(const sensors_chip_nam
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sflcrit;
 	double alarm_max, alarm_min, val;
 	char *label;
 
@@ -630,18 +708,35 @@ static void print_chip_curr(const sensors_chip_nam
 		printf("  (max = %+6.2f A)",
 		       get_value(name, sfmax));
 
-	sf = sensors_get_subfeature(name, feature,
-				    SENSORS_SUBFEATURE_CURR_ALARM);
+	sflcrit = sensors_get_subfeature(name, feature,
+					 SENSORS_SUBFEATURE_CURR_LCRIT);
+	sfcrit = sensors_get_subfeature(name, feature,
+					SENSORS_SUBFEATURE_CURR_CRIT);
+	if (sflcrit && sfcrit)
+		printf("\n%*s(crit min = %+6.2f A, crit max = %+6.2f A)",
+		       label_size+10, "",
+		       get_value(name, sflcrit),
+		       get_value(name, sfcrit));
+	else if (sflcrit)
+		printf("\n%*s(crit min = %+6.2f A)",
+		       label_size + 10, "",
+		       get_value(name, sflcrit));
+	else if (sfcrit)
+		printf("\n%*s(crit max = %+6.2f A)",
+		       label_size + 10, "",
+		       get_value(name, sfcrit));
+
+	alarm_min = alarm_max = 0;
 	sfmin = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MIN_ALARM);
+				       SENSORS_SUBFEATURE_CURR_LCRIT_ALARM);
 	sfmax = sensors_get_subfeature(name, feature,
-				       SENSORS_SUBFEATURE_CURR_MAX_ALARM);
-	if (sfmin || sfmax) {
-		alarm_max = sfmax ? get_value(name, sfmax) : 0;
-		alarm_min = sfmin ? get_value(name, sfmin) : 0;
+				       SENSORS_SUBFEATURE_CURR_CRIT_ALARM);
+	if (sfmin && sfmax) {
+		alarm_max = get_value(name, sfmax);
+		alarm_min = get_value(name, sfmin);
 
 		if (alarm_min || alarm_max) {
-			printf(" ALARM (");
+			printf(" CRIT ALARM (");
 
 			if (alarm_min)
 				printf("MIN");
@@ -650,11 +745,40 @@ static void print_chip_curr(const sensors_chip_nam
 
 			printf(")");
 		}
-	} else if (sf) {
-		printf("   %s",
-		       get_value(name, sf) ? "ALARM" : "");
+	} else if (sfmax) {
+		alarm_max = get_value(name, sfmax);
+		if (alarm_max)
+			printf("   CRIT ALARM");
 	}
 
+	/* Only display non-critical alarms if there were no critical alarms */
+	if (!alarm_min && !alarm_max) {
+		sf = sensors_get_subfeature(name, feature,
+					    SENSORS_SUBFEATURE_CURR_ALARM);
+		sfmin = sensors_get_subfeature(name, feature,
+					    SENSORS_SUBFEATURE_CURR_MIN_ALARM);
+		sfmax = sensors_get_subfeature(name, feature,
+					    SENSORS_SUBFEATURE_CURR_MAX_ALARM);
+		if (sfmin || sfmax) {
+			alarm_max = sfmax ? get_value(name, sfmax) : 0;
+			alarm_min = sfmin ? get_value(name, sfmin) : 0;
+
+			if (alarm_min || alarm_max) {
+				printf(" ALARM (");
+
+				if (alarm_min)
+					printf("MIN");
+				if (alarm_max)
+					printf("%sMAX", (alarm_min) ? ", " : "");
+
+				printf(")");
+			}
+		} else if (sf) {
+			printf("   %s",
+			    get_value(name, sf) ? "ALARM" : "");
+		}
+	}
+
 	printf("\n");
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
