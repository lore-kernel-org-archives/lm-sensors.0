From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 14 Apr 2008 21:48:44 +0000
Subject: [lm-sensors] [PATCH 1/3 v3] libsensors: Support energy and power
Message-Id: <20080414214844.GD7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add power and sensor meters to libsensors, with minor tweaks and
documentation updates as suggested by Jean Delvare.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Index: lm-sensors-3.0.0/lib/sensors.h
=================================--- lm-sensors-3.0.0.orig/lib/sensors.h	2008-04-14 09:25:05.000000000 -0700
+++ lm-sensors-3.0.0/lib/sensors.h	2008-04-14 09:25:51.000000000 -0700
@@ -132,6 +132,8 @@
 	SENSORS_FEATURE_IN		= 0x00,
 	SENSORS_FEATURE_FAN		= 0x01,
 	SENSORS_FEATURE_TEMP		= 0x02,
+	SENSORS_FEATURE_POWER		= 0x03,
+	SENSORS_FEATURE_ENERGY		= 0x04,
 	SENSORS_FEATURE_VID		= 0x10,
 	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
 	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
@@ -170,6 +172,14 @@
 	SENSORS_SUBFEATURE_TEMP_OFFSET,
 	SENSORS_SUBFEATURE_TEMP_BEEP,
 
+	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
+	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
+	SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST,
+
+	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
+
+	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
+
 	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
 
 	SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_BEEP_ENABLE << 8,
Index: lm-sensors-3.0.0/lib/sysfs.c
=================================--- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-04-14 09:25:05.000000000 -0700
+++ lm-sensors-3.0.0/lib/sysfs.c	2008-04-14 14:42:02.000000000 -0700
@@ -138,24 +138,33 @@
 
 #define MAX_SENSORS_PER_TYPE	20
 #define MAX_SUBFEATURES		8
-/* Room for all 3 types (in, fan, temp) with all their subfeatures + VID
-   + misc features */
+#define MAX_SENSOR_TYPES	5
+/* Room for all 5 types (in, fan, temp, power, energy) with all their
+   subfeatures + VID + misc features */
 #define ALL_POSSIBLE_SUBFEATURES \
-				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 \
-				 + MAX_SENSORS_PER_TYPE + 1)
+				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * \
+				 MAX_SENSOR_TYPES * 2 + \
+				 MAX_SENSORS_PER_TYPE + 1)
 
 static
 int get_type_scaling(sensors_subfeature_type type)
 {
+	/* Multipliers for subfeatures */
 	switch (type & 0xFF80) {
 	case SENSORS_SUBFEATURE_IN_INPUT:
 	case SENSORS_SUBFEATURE_TEMP_INPUT:
 		return 1000;
 	case SENSORS_SUBFEATURE_FAN_INPUT:
 		return 1;
+	case SENSORS_SUBFEATURE_POWER_AVERAGE:
+	case SENSORS_SUBFEATURE_ENERGY_INPUT:
+		return 1000000;
 	}
 
+	/* Multipliers for second class subfeatures
+	   that need their own multiplier */
 	switch (type) {
+	case SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL:
 	case SENSORS_SUBFEATURE_VID:
 	case SENSORS_SUBFEATURE_TEMP_OFFSET:
 		return 1000;
@@ -173,6 +182,8 @@
 	case SENSORS_FEATURE_IN:
 	case SENSORS_FEATURE_FAN:
 	case SENSORS_FEATURE_TEMP:
+	case SENSORS_FEATURE_POWER:
+	case SENSORS_FEATURE_ENERGY:
 		underscore = strchr(sfname, '_');
 		name = strndup(sfname, underscore - sfname);
 		break;
@@ -232,6 +243,19 @@
 	{ NULL, 0 }
 };
 
+static const struct subfeature_type_match power_matches[] = {
+	{ "average", SENSORS_SUBFEATURE_POWER_AVERAGE },
+	{ "average_highest", SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST },
+	{ "average_lowest", SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST },
+	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
+	{ NULL, 0 }
+};
+
+static const struct subfeature_type_match energy_matches[] = {
+	{ "input", SENSORS_SUBFEATURE_ENERGY_INPUT },
+	{ NULL, 0 }
+};
+
 static const struct subfeature_type_match cpu_matches[] = {
 	{ "vid", SENSORS_SUBFEATURE_VID },
 	{ NULL, 0 }
@@ -242,6 +266,8 @@
 	{ "in%d%c", in_matches },
 	{ "fan%d%c", fan_matches },
 	{ "cpu%d%c", cpu_matches },
+	{ "power%d%c", power_matches },
+	{ "energy%d%c", energy_matches },
 };
 
 /* Return the subfeature type and channel number based on the subfeature
@@ -327,10 +353,12 @@
 
 		/* Adjust the channel number */
 		switch (sftype & 0xFF00) {
-			case SENSORS_SUBFEATURE_FAN_INPUT:
-			case SENSORS_SUBFEATURE_TEMP_INPUT:
-				nr--;
-				break;
+		case SENSORS_SUBFEATURE_FAN_INPUT:
+		case SENSORS_SUBFEATURE_TEMP_INPUT:
+		case SENSORS_SUBFEATURE_POWER_AVERAGE:
+		case SENSORS_SUBFEATURE_ENERGY_INPUT:
+			nr--;
+			break;
 		}
 
 		if (nr < 0 || nr >= MAX_SENSORS_PER_TYPE) {
@@ -347,11 +375,12 @@
 		   sorted table */
 		switch (sftype) {
 		case SENSORS_SUBFEATURE_VID:
-			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6;
+			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
+			    MAX_SENSOR_TYPES * 2;
 			break;
 		case SENSORS_SUBFEATURE_BEEP_ENABLE:
-			i = MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 +
-			    MAX_SENSORS_PER_TYPE;
+			i = MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
+			    MAX_SENSOR_TYPES * 2 + MAX_SENSORS_PER_TYPE;
 			break;
 		default:
 			i = (sftype >> 8) * MAX_SENSORS_PER_TYPE *
@@ -389,7 +418,8 @@
 		if (!all_subfeatures[i].name)
 			continue;
 
-		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
+		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
+		    MAX_SENSOR_TYPES * 2 ||
 		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
 			fnum++;
 			prev_slot = i / (MAX_SUBFEATURES * 2);
@@ -410,7 +440,8 @@
 			continue;
 
 		/* New main feature? */
-		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
+		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
+		    MAX_SENSOR_TYPES * 2 ||
 		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
 			ftype = all_subfeatures[i].type >> 8;
 			fnum++;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
