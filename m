From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 30 Jun 2010 06:06:18 +0000
Subject: [lm-sensors] [PATCH] lm-sensors: Add support for new hwmon
Message-Id: <1277877978-27726-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the following new attributes to libsensors and
to the sensors command.

inX_lcrit
inX_crit
inX_fault
temp_lcrit
powerX_cap
powerX_max
powerX_crit
powerX_alarm
powerX_fault
currX_lcrit
currX_crit
currX_fault

I reworked print_temp_limits() significantly, which asks for a detailed review.
Idea is to make the function better scalable for new attributes while retaining
legacy output.

sensord does not yet support the new attributes. The sensord code is a bit more
complex than sensors, and I don't have a clean solution for it yet.
Still working on it.

---
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5843)
+++ lib/sensors.h	(working copy)
@@ -151,10 +151,13 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_IN_INPUT = SENSORS_FEATURE_IN << 8,
 	SENSORS_SUBFEATURE_IN_MIN,
 	SENSORS_SUBFEATURE_IN_MAX,
+	SENSORS_SUBFEATURE_IN_LCRIT,
+	SENSORS_SUBFEATURE_IN_CRIT,
 	SENSORS_SUBFEATURE_IN_ALARM = (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
 	SENSORS_SUBFEATURE_IN_BEEP,
+	SENSORS_SUBFEATURE_IN_FAULT,
 
 	SENSORS_SUBFEATURE_FAN_INPUT = SENSORS_FEATURE_FAN << 8,
 	SENSORS_SUBFEATURE_FAN_MIN,
@@ -169,6 +172,7 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_TEMP_MIN,
 	SENSORS_SUBFEATURE_TEMP_CRIT,
 	SENSORS_SUBFEATURE_TEMP_CRIT_HYST,
+	SENSORS_SUBFEATURE_TEMP_LCRIT,
 	SENSORS_SUBFEATURE_TEMP_ALARM = (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -184,6 +188,11 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_POWER_INPUT,
 	SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST,
 	SENSORS_SUBFEATURE_POWER_INPUT_LOWEST,
+	SENSORS_SUBFEATURE_POWER_CAP,
+	SENSORS_SUBFEATURE_POWER_MAX,
+	SENSORS_SUBFEATURE_POWER_CRIT,
+	SENSORS_SUBFEATURE_POWER_ALARM,
+	SENSORS_SUBFEATURE_POWER_FAULT,
 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
 
 	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
@@ -191,10 +200,13 @@ typedef enum sensors_subfeature_type {
 	SENSORS_SUBFEATURE_CURR_INPUT = SENSORS_FEATURE_CURR << 8,
 	SENSORS_SUBFEATURE_CURR_MIN,
 	SENSORS_SUBFEATURE_CURR_MAX,
+	SENSORS_SUBFEATURE_CURR_LCRIT,
+	SENSORS_SUBFEATURE_CURR_CRIT,
 	SENSORS_SUBFEATURE_CURR_ALARM = (SENSORS_FEATURE_CURR << 8) | 0x80,
 	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
 	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
 	SENSORS_SUBFEATURE_CURR_BEEP,
+	SENSORS_SUBFEATURE_CURR_FAULT,
 
 	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
 
Index: lib/sensors.conf.5
=================================--- lib/sensors.conf.5	(revision 5843)
+++ lib/sensors.conf.5	(working copy)
@@ -402,7 +402,7 @@ really cool before the fan stops, so that it will
 again immediately.
 
 So, in addition to tempX_max, many chips have a tempX_max_hyst
-sub-feature. Likewise, tempX_crit often comes with tempX_max_crit.
+sub-feature. Likewise, tempX_crit often comes with tempX_crit_hyst.
 Example:
 
 .RS
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5843)
+++ lib/sysfs.c	(working copy)
@@ -219,6 +219,7 @@ static const struct subfeature_type_match temp_mat
 	{ "max", SENSORS_SUBFEATURE_TEMP_MAX },
 	{ "max_hyst", SENSORS_SUBFEATURE_TEMP_MAX_HYST },
 	{ "min", SENSORS_SUBFEATURE_TEMP_MIN },
+	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_TEMP_CRIT },
 	{ "crit_hyst", SENSORS_SUBFEATURE_TEMP_CRIT_HYST },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
@@ -236,9 +237,12 @@ static const struct subfeature_type_match in_match
 	{ "input", SENSORS_SUBFEATURE_IN_INPUT },
 	{ "min", SENSORS_SUBFEATURE_IN_MIN },
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
+	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
+	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
+	{ "fault", SENSORS_SUBFEATURE_IN_FAULT },
 	{ "beep", SENSORS_SUBFEATURE_IN_BEEP },
 	{ NULL, 0 }
 };
@@ -260,6 +264,11 @@ static const struct subfeature_type_match power_ma
 	{ "input", SENSORS_SUBFEATURE_POWER_INPUT },
 	{ "input_highest", SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST },
 	{ "input_lowest", SENSORS_SUBFEATURE_POWER_INPUT_LOWEST },
+	{ "cap", SENSORS_SUBFEATURE_POWER_CAP },
+	{ "max", SENSORS_SUBFEATURE_POWER_MAX },
+	{ "crit", SENSORS_SUBFEATURE_POWER_CRIT },
+	{ "alarm", SENSORS_SUBFEATURE_POWER_ALARM },
+	{ "fault", SENSORS_SUBFEATURE_POWER_FAULT },
 	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
 	{ NULL, 0 }
 };
@@ -273,9 +282,12 @@ static const struct subfeature_type_match curr_mat
 	{ "input", SENSORS_SUBFEATURE_CURR_INPUT },
 	{ "min", SENSORS_SUBFEATURE_CURR_MIN },
 	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
+	{ "lcrit", SENSORS_SUBFEATURE_CURR_LCRIT },
+	{ "crit", SENSORS_SUBFEATURE_CURR_CRIT },
 	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
+	{ "fault", SENSORS_SUBFEATURE_CURR_FAULT },
 	{ "beep", SENSORS_SUBFEATURE_CURR_BEEP },
 	{ NULL, 0 }
 };
Index: prog/sensors/chips.c
=================================--- prog/sensors/chips.c	(revision 5843)
+++ prog/sensors/chips.c	(working copy)
@@ -123,23 +123,25 @@ static int get_label_size(const sensors_chip_name
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
 
 	if (alarm)
@@ -150,10 +152,11 @@ static void print_chip_temp(const sensors_chip_nam
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sfhyst;
-	double val, limit1, limit2;
-	const char *s1, *s2;
-	int alarm, crit_displayed = 0;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sflcrit, *sfcrit, *sfhyst;
+	double val, limit[6];
+	const char *s[6];
+	int alarm;
+	int count = 0;
 	char *label;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -172,72 +175,57 @@ static void print_chip_temp(const sensors_chip_nam
 				       SENSORS_SUBFEATURE_TEMP_MIN);
 	sfmax = sensors_get_subfeature(name, feature,
 				       SENSORS_SUBFEATURE_TEMP_MAX);
+	sflcrit = sensors_get_subfeature(name, feature,
+					 SENSORS_SUBFEATURE_TEMP_LCRIT);
 	sfcrit = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_CRIT);
 	if (sfmax) {
 		sf = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_MAX_ALARM);
 		if (sf && get_value(name, sf))
-			alarm |= 1;
+			alarm = 1;
 
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
+				alarm = 1;
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
+			s[count++] = "hyst";
 		}
-
+	}
+	if (sfcrit || sflcrit) {
 		sf = sensors_get_subfeature(name, feature,
 					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
 		if (sf && get_value(name, sf))
-			alarm |= 1;
-		crit_displayed = 1;
-	} else {
-		limit1 = limit2 = 0;
-		s1 = s2 = NULL;
+			alarm = 1;
 	}
 
-
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_FAULT);
 	if (sf && get_value(name, sf)) {
@@ -253,30 +241,8 @@ static void print_chip_temp(const sensors_chip_nam
 		} else
 			printf("     N/A  ");
 	}
-	print_temp_limits(limit1, limit2, s1, s2, alarm);
+	print_temp_limits(limit, s, count, alarm, label_size);
 
-	if (!crit_displayed && sfcrit) {
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
-		alarm = sf && get_value(name, sf);
-
-		printf("\n%*s", label_size + 10, "");
-		print_temp_limits(limit1, limit2, s1, s2, alarm);
-	}
-
 	/* print out temperature sensor info */
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_TEMP_TYPE);
@@ -303,7 +269,7 @@ static void print_chip_in(const sensors_chip_name
 			  const sensors_feature *feature,
 			  int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sflcrit, *sfcrit;
 	double val, alarm_max, alarm_min;
 	char *label;
 
@@ -337,6 +303,24 @@ static void print_chip_in(const sensors_chip_name
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
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_IN_ALARM);
 	sfmin = sensors_get_subfeature(name, feature,
@@ -361,6 +345,12 @@ static void print_chip_in(const sensors_chip_name
 		printf("   %s",
 		       get_value(name, sf) ? "ALARM" : "");
 	}
+	sf = sensors_get_subfeature(name, feature,
+				    SENSORS_SUBFEATURE_IN_FAULT);
+	if (sf) {
+		printf("   %s",
+		       get_value(name, sf) ? "FAULT" : "");
+	}
 
 	printf("\n");
 }
@@ -453,7 +443,7 @@ static void print_chip_power(const sensors_chip_na
 {
 	double val;
 	int need_space = 0;
-	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint, *sfcrit, *sfcap;
 	char *label;
 	const char *unit;
 
@@ -475,7 +465,20 @@ static void print_chip_power(const sensors_chip_na
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
@@ -485,6 +488,8 @@ static void print_chip_power(const sensors_chip_na
 					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
 		sfint = sensors_get_subfeature(name, feature,
 					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
+		sfcrit = NULL;
+		sfcap = NULL;
 	}
 
 	if (sf && get_input_value(name, sf, &val) = 0) {
@@ -493,7 +498,7 @@ static void print_chip_power(const sensors_chip_na
 	} else
 		printf("     N/A");
 
-	if (sfmin || sfmax || sfint) {
+	if (sfmin || sfmax || sfint || sfcrit) {
 		printf("  (");
 
 		if (sfmin) {
@@ -511,6 +516,22 @@ static void print_chip_power(const sensors_chip_na
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
@@ -519,6 +540,16 @@ static void print_chip_power(const sensors_chip_na
 		printf(")");
 	}
 
+	sf = sensors_get_subfeature(name, feature,
+				    SENSORS_SUBFEATURE_POWER_ALARM);
+	if (sf)
+		printf("   %s", get_value(name, sf) ? "ALARM" : "");
+
+	sf = sensors_get_subfeature(name, feature,
+				    SENSORS_SUBFEATURE_POWER_FAULT);
+	if (sf)
+		printf("   %s", get_value(name, sf) ? "FAULT" : "");
+
 	printf("\n");
 }
 
@@ -596,7 +627,7 @@ static void print_chip_curr(const sensors_chip_nam
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	const sensors_subfeature *sf, *sfmin, *sfmax;
+	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sflcrit;
 	double alarm_max, alarm_min, val;
 	char *label;
 
@@ -630,6 +661,24 @@ static void print_chip_curr(const sensors_chip_nam
 		printf("  (max = %+6.2f A)",
 		       get_value(name, sfmax));
 
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
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_CURR_ALARM);
 	sfmin = sensors_get_subfeature(name, feature,
@@ -654,6 +703,12 @@ static void print_chip_curr(const sensors_chip_nam
 		printf("   %s",
 		       get_value(name, sf) ? "ALARM" : "");
 	}
+	sf = sensors_get_subfeature(name, feature,
+				    SENSORS_SUBFEATURE_CURR_FAULT);
+	if (sf) {
+		printf("   %s",
+		       get_value(name, sf) ? "FAULT" : "");
+	}
 
 	printf("\n");
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
