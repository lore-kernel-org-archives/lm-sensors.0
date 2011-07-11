From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jul 2011 04:16:00 +0000
Subject: [lm-sensors] [PATCH RFC v2] Add new sysfs attributes to libsensors
Message-Id: <20110711041600.GA16198@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Add proposed new sysfs attributes to libsensors and to the sensors command.

Only voltage and current attributes are really new; the temperature attribu=
tes
are already defined in the ABI but were not supported.

---
v2: Updated sensors attribute array sizes.
    Added average power output to list of instantaneous power attributes.
    This way both current and average power can be displayed.

Sample output:

lm5066-i2c-0-40
Adapter: i2c-devantech-iss at bus 001 device 007
vin:         +36.80 V  (min =3D  +0.00 V, max =3D +89.27 V)
                       (avg =3D +36.80 V)
vout1:       +36.47 V  (min =3D  +0.00 V, avg =3D +36.49 V)
vout2:        +0.02 V
temp1:        +26.1=B0C  (high =3D +125.0=B0C, crit =3D +150.0=B0C)
pin:          26.45 W  (avg =3D  28.10 W, highest =3D 573.55 W)
                       (max =3D   6.77 kW)
iin:          +0.78 A  (avg =3D  +0.72 A)

---

Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(revision 5984)
+++ lib/sensors.h	(working copy)
@@ -157,6 +157,9 @@
 	SENSORS_SUBFEATURE_IN_MAX,
 	SENSORS_SUBFEATURE_IN_LCRIT,
 	SENSORS_SUBFEATURE_IN_CRIT,
+	SENSORS_SUBFEATURE_IN_AVERAGE,
+	SENSORS_SUBFEATURE_IN_LOWEST,
+	SENSORS_SUBFEATURE_IN_HIGHEST,
 	SENSORS_SUBFEATURE_IN_ALARM =3D (SENSORS_FEATURE_IN << 8) | 0x80,
 	SENSORS_SUBFEATURE_IN_MIN_ALARM,
 	SENSORS_SUBFEATURE_IN_MAX_ALARM,
@@ -181,6 +184,9 @@
 	SENSORS_SUBFEATURE_TEMP_LCRIT,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
 	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
+	SENSORS_SUBFEATURE_TEMP_AVERAGE,
+	SENSORS_SUBFEATURE_TEMP_LOWEST,
+	SENSORS_SUBFEATURE_TEMP_HIGHEST,
 	SENSORS_SUBFEATURE_TEMP_ALARM =3D (SENSORS_FEATURE_TEMP << 8) | 0x80,
 	SENSORS_SUBFEATURE_TEMP_MAX_ALARM,
 	SENSORS_SUBFEATURE_TEMP_MIN_ALARM,
@@ -215,6 +221,9 @@
 	SENSORS_SUBFEATURE_CURR_MAX,
 	SENSORS_SUBFEATURE_CURR_LCRIT,
 	SENSORS_SUBFEATURE_CURR_CRIT,
+	SENSORS_SUBFEATURE_CURR_AVERAGE,
+	SENSORS_SUBFEATURE_CURR_LOWEST,
+	SENSORS_SUBFEATURE_CURR_HIGHEST,
 	SENSORS_SUBFEATURE_CURR_ALARM =3D (SENSORS_FEATURE_CURR << 8) | 0x80,
 	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
 	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
Index: lib/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.c	(revision 5984)
+++ lib/sysfs.c	(working copy)
@@ -233,6 +233,9 @@
 	{ "lcrit", SENSORS_SUBFEATURE_TEMP_LCRIT },
 	{ "emergency", SENSORS_SUBFEATURE_TEMP_EMERGENCY },
 	{ "emergency_hyst", SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST },
+	{ "average", SENSORS_SUBFEATURE_TEMP_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_TEMP_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_TEMP_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_TEMP_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_TEMP_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_TEMP_MAX_ALARM },
@@ -252,6 +255,9 @@
 	{ "max", SENSORS_SUBFEATURE_IN_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_IN_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_IN_CRIT },
+	{ "average", SENSORS_SUBFEATURE_IN_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_IN_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_IN_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_IN_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_IN_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_IN_MAX_ALARM },
@@ -302,6 +308,9 @@
 	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
 	{ "lcrit", SENSORS_SUBFEATURE_CURR_LCRIT },
 	{ "crit", SENSORS_SUBFEATURE_CURR_CRIT },
+	{ "average", SENSORS_SUBFEATURE_CURR_AVERAGE },
+	{ "lowest", SENSORS_SUBFEATURE_CURR_LOWEST },
+	{ "highest", SENSORS_SUBFEATURE_CURR_HIGHEST },
 	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
 	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
 	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
Index: prog/sensors/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/chips.c	(revision 5984)
+++ prog/sensors/chips.c	(working copy)
@@ -280,6 +280,9 @@
 	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, 0, "crit" },
 	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, 0,
 	    "emerg" },
+	{ SENSORS_SUBFEATURE_TEMP_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_TEMP_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_TEMP_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
=20
@@ -287,7 +290,7 @@
 			    const sensors_feature *feature,
 			    int label_size)
 {
-	struct sensor_subfeature_data sensors[8];
+	struct sensor_subfeature_data sensors[11];
 	struct sensor_subfeature_data alarms[5];
 	int sensor_count, alarm_count;
 	const sensors_subfeature *sf;
@@ -365,6 +368,9 @@
 	{ SENSORS_SUBFEATURE_IN_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_IN_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_IN_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_IN_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_IN_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
=20
@@ -374,7 +380,7 @@
 {
 	const sensors_subfeature *sf;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[4];
 	int sensor_count, alarm_count;
 	double val;
@@ -504,6 +510,7 @@
 };
=20
 static const struct sensor_subfeature_list power_inst_sensors[] =3D {
+	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
 	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
@@ -523,7 +530,7 @@
 {
 	double val;
 	const sensors_subfeature *sf;
-	struct sensor_subfeature_data sensors[6];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[3];
 	int sensor_count, alarm_count;
 	char *label;
@@ -653,6 +660,9 @@
 	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, 0, "min" },
 	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, 0, "max" },
 	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, 0, "crit max" },
+	{ SENSORS_SUBFEATURE_CURR_AVERAGE, NULL, 0, "avg" },
+	{ SENSORS_SUBFEATURE_CURR_LOWEST, NULL, 0, "lowest" },
+	{ SENSORS_SUBFEATURE_CURR_HIGHEST, NULL, 0, "highest" },
 	{ -1, NULL, 0, NULL }
 };
=20
@@ -663,7 +673,7 @@
 	const sensors_subfeature *sf;
 	double val;
 	char *label;
-	struct sensor_subfeature_data sensors[4];
+	struct sensor_subfeature_data sensors[7];
 	struct sensor_subfeature_data alarms[4];
 	int sensor_count, alarm_count;
=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
