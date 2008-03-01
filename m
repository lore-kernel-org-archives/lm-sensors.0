From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Sat, 01 Mar 2008 19:04:25 +0000
Subject: [lm-sensors] lm_sensors v2 asc7621 support
Message-Id: <47C9A8B9.20501@kenm.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080106080601070408030102"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106080601070408030102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've had a go at implementing support for George Joseph's experimental 
Adigilog asc7621 driver in lm_sensors 2.10.5.  Find patch attached.

I've been running this for a while with the asc76xx driver on an Intel 
D975XBX2 board.  It works just fine for reading the sensors, although 
writing the alarm limits and such doesn't seem to work quite right.

Hopefully this might be a starting point for someone else to add 
official support for these chips to lm_sensors.

Kind regards,

Ken Milmore


--------------080106080601070408030102
Content-Type: text/plain;
 name="lm_sensors-asc7621.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors-asc7621.diff"

diff -Naur lm_sensors-2.10.5.orig/lib/chips.c lm_sensors-2.10.5/lib/chips.c
--- lm_sensors-2.10.5.orig/lib/chips.c	2007-10-25 03:31:30.000000000 +0100
+++ lm_sensors-2.10.5/lib/chips.c	2008-03-01 15:59:17.000000000 +0000
@@ -6384,6 +6384,78 @@
 	{ { 0 }, 0 }
 };
 
+#define SENSORS_ASC76XX_IN_FEATURES(nr) \
+	{ { SENSORS_ASC76XX_IN(nr), "in" #nr, \
+		NOMAP, NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 3, "in" #nr "_input" }, \
+	{ { SENSORS_ASC76XX_IN_MIN(nr), "in" #nr "_min", \
+		SENSORS_ASC76XX_IN(nr), SENSORS_ASC76XX_IN(nr), RW }, \
+		NOSYSCTL, VALUE(1), 3, "in" #nr "_min" }, \
+	{ { SENSORS_ASC76XX_IN_MAX(nr), "in" #nr "_max", \
+		SENSORS_ASC76XX_IN(nr), SENSORS_ASC76XX_IN(nr), RW }, \
+		NOSYSCTL, VALUE(1), 3, "in" #nr "_max" }, \
+	{ { SENSORS_ASC76XX_IN_ALARM(nr), "in" #nr "_alarm", \
+		SENSORS_ASC76XX_IN(nr), NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "in" #nr "_alarm" }
+
+#define SENSORS_ASC76XX_FAN_FEATURES(nr) \
+	{ { SENSORS_ASC76XX_FAN(nr), "fan" #nr, \
+		NOMAP, NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "fan" #nr "_input" }, \
+	{ { SENSORS_ASC76XX_FAN_MIN(nr), "fan" #nr "_min", \
+		SENSORS_ASC76XX_FAN(nr), SENSORS_ASC76XX_FAN(nr), RW }, \
+		NOSYSCTL, VALUE(1), 0, "fan" #nr "_min" }, \
+	{ { SENSORS_ASC76XX_FAN_ALARM(nr), "fan" #nr "_alarm", \
+		SENSORS_ASC76XX_FAN(nr), NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "fan" #nr "_alarm" }
+
+#define SENSORS_ASC76XX_TEMP_FEATURES(nr) \
+	{ { SENSORS_ASC76XX_TEMP(nr), "temp" #nr, \
+		NOMAP, NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 3, "temp" #nr "_input" }, \
+	{ { SENSORS_ASC76XX_TEMP_MAX(nr), "temp" #nr "_max", \
+		SENSORS_ASC76XX_TEMP(nr), SENSORS_ASC76XX_TEMP(nr), RW }, \
+		NOSYSCTL, VALUE(1), 3, "temp" #nr "_max" }, \
+	{ { SENSORS_ASC76XX_TEMP_MIN(nr), "temp" #nr "_min", \
+		SENSORS_ASC76XX_TEMP(nr), SENSORS_ASC76XX_TEMP(nr), RW }, \
+		NOSYSCTL, VALUE(1), 3, "temp" #nr "_min" }, \
+	{ { SENSORS_ASC76XX_TEMP_ALARM(nr), "temp" #nr "_alarm", \
+		SENSORS_ASC76XX_TEMP(nr), NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "temp" #nr "_alarm" }, \
+	{ { SENSORS_ASC76XX_TEMP_TYPE(nr), "temp" #nr "_type", \
+		SENSORS_ASC76XX_TEMP(nr), NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "temp" #nr "_type" }
+
+#define SENSORS_ASC76XX_CORETEMP_FEATURES(nr) \
+	{ { SENSORS_ASC76XX_TEMP(nr), "temp" #nr, \
+		NOMAP, NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 3, "temp" #nr "_input" }, \
+	{ { SENSORS_ASC76XX_TEMP_TYPE(nr), "temp" #nr "_type", \
+		SENSORS_ASC76XX_TEMP(nr), NOMAP, R }, \
+		NOSYSCTL, VALUE(1), 0, "temp" #nr "_type" }
+
+static sensors_chip_feature asc7621_features[] =
+{
+	SENSORS_ASC76XX_IN_FEATURES(0),
+	SENSORS_ASC76XX_IN_FEATURES(1),
+	SENSORS_ASC76XX_IN_FEATURES(2),
+	SENSORS_ASC76XX_IN_FEATURES(3),
+	SENSORS_ASC76XX_IN_FEATURES(4),
+	SENSORS_ASC76XX_FAN_FEATURES(1),
+	SENSORS_ASC76XX_FAN_FEATURES(2),
+	SENSORS_ASC76XX_FAN_FEATURES(3),
+	SENSORS_ASC76XX_FAN_FEATURES(4),
+	SENSORS_ASC76XX_TEMP_FEATURES(1),
+	SENSORS_ASC76XX_TEMP_FEATURES(2),
+	SENSORS_ASC76XX_TEMP_FEATURES(3),
+	SENSORS_ASC76XX_TEMP_FEATURES(4),
+	SENSORS_ASC76XX_CORETEMP_FEATURES(5),
+	SENSORS_ASC76XX_CORETEMP_FEATURES(6),
+	SENSORS_ASC76XX_CORETEMP_FEATURES(7),
+	SENSORS_ASC76XX_CORETEMP_FEATURES(8),
+	{ { 0 }, 0 }
+};
+
 sensors_chip_features sensors_chip_features_list[] =
 {
  { SENSORS_LM78_PREFIX, lm78_features },
@@ -6504,5 +6576,6 @@
  { SENSORS_F71882FG_PREFIX, f71882fg_features },
  { SENSORS_FSCHMD_PREFIX, fschmd_features },
  { SENSORS_FSCHRC_PREFIX, fschrc_features },
+ { SENSORS_ASC7621_PREFIX, asc7621_features },
  { 0 }
 };
diff -Naur lm_sensors-2.10.5.orig/lib/chips.h lm_sensors-2.10.5/lib/chips.h
--- lm_sensors-2.10.5.orig/lib/chips.h	2007-10-25 03:31:30.000000000 +0100
+++ lm_sensors-2.10.5/lib/chips.h	2008-03-01 16:16:56.000000000 +0000
@@ -2363,4 +2363,25 @@
 #define SENSORS_FSCHMD_TEMP_ALARM(n)		(130 + (n))
 #define SENSORS_FSCHMD_TEMP_FAULT(n)		(140 + (n))
 
+/* Andigilog aSC76xx family */
+#define SENSORS_ASC7621_PREFIX "asc7621"
+
+/* in n from 0 to 4 */
+#define SENSORS_ASC76XX_IN(n)			(0x01 + (n)) /* R */
+#define SENSORS_ASC76XX_IN_MIN(n)		(0x11 + (n)) /* RW */
+#define SENSORS_ASC76XX_IN_MAX(n)		(0x21 + (n)) /* RW */
+#define SENSORS_ASC76XX_IN_ALARM(n)		(0x31 + (n)) /* R */
+
+/* fan n from 1 to 4 */
+#define SENSORS_ASC76XX_FAN(n)			(0x40 + (n)) /* R */
+#define SENSORS_ASC76XX_FAN_MIN(n)		(0x50 + (n)) /* RW */
+#define SENSORS_ASC76XX_FAN_ALARM(n)		(0x60 + (n)) /* R */
+
+/* temp n from 1 to 8 */
+#define SENSORS_ASC76XX_TEMP(n)			(0x70 + (n)) /* R */
+#define SENSORS_ASC76XX_TEMP_MAX(n)		(0x80 + (n)) /* RW */
+#define SENSORS_ASC76XX_TEMP_MIN(n)		(0x90 + (n)) /* RW */
+#define SENSORS_ASC76XX_TEMP_ALARM(n)		(0xa0 + (n)) /* R */
+#define SENSORS_ASC76XX_TEMP_TYPE(n)		(0xb0 + (n)) /* R */
+
 #endif /* def LIB_SENSORS_CHIPS_H */
diff -Naur lm_sensors-2.10.5.orig/prog/sensors/chips.c lm_sensors-2.10.5/prog/sensors/chips.c
--- lm_sensors-2.10.5.orig/prog/sensors/chips.c	2007-10-25 03:31:39.000000000 +0100
+++ lm_sensors-2.10.5/prog/sensors/chips.c	2008-03-01 16:26:43.000000000 +0000
@@ -6461,6 +6461,99 @@
                       SENSORS_FSCHMD_TEMP_MAX(i + 1));
 }
 
+void print_asc7621(const sensors_chip_name *name)
+{
+  char *label;
+  double cur, min, max, alarm, sens;
+  int valid, i;
+
+  for (i = 0; i <= 4; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_ASC76XX_IN(i),
+        &label, &valid)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_IN(i), &cur)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_IN_MIN(i), &min)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_IN_MAX(i), &max)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_IN_ALARM(i), &alarm)) {
+      if (valid) {
+        print_label(label, 10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)", cur, min, max);
+        if(alarm)
+          printf("  ALARM");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get in%d data!\n", i);
+    free(label);
+  }
+
+  for (i = 1; i <= 4; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_ASC76XX_FAN(i),
+        &label, &valid)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_FAN(i), &cur)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_FAN_MIN(i), &min)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_FAN_ALARM(i), &alarm)) {
+      if (valid) {
+        print_label(label, 10);
+        printf("%4.0f RPM  (min = %4.0f RPM)", cur, min);
+        if(alarm)
+          printf("  ALARM");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get fan%d data!\n", i);
+    free(label);
+  }
+
+  for (i = 1; i <= 4; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_ASC76XX_TEMP(i),
+        &label, &valid)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP(i), &cur)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP_MAX(i), &max)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP_MIN(i), &min)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP_ALARM(i), &alarm)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP_TYPE(i), &sens)) {
+      if (valid) {
+        print_label(label, 10);
+        print_temp_info(cur, max, min, MINMAX, 1, 1);
+        if(alarm)
+          printf("ALARM  ");
+        printf("sensor = %s",
+               (int)sens == 1 ? "diode" :
+               (int)sens == 2 ? "transistor" :
+               (int)sens == 3 ? "thermal diode" :
+               (int)sens == 4 ? "thermistor" :
+               (int)sens == 5 ? "AMD AMDSI" :
+               (int)sens == 6 ? "Intel PECI" : "unknown");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get temp%d data!\n", i);
+    free(label);
+  }
+
+  for (i = 5; i <= 8; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_ASC76XX_TEMP(i),
+        &label, &valid)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP(i), &cur)
+        && !sensors_get_feature(*name, SENSORS_ASC76XX_TEMP_TYPE(i), &sens)) {
+      if (valid) {
+        print_label(label, 10);
+        print_temp_info(cur, 0, 0, SINGLE, 1, 0);
+        printf("  sensor = %s",
+               (int)sens == 1 ? "diode" :
+               (int)sens == 2 ? "transistor" :
+               (int)sens == 3 ? "thermal diode" :
+               (int)sens == 4 ? "thermistor" :
+               (int)sens == 5 ? "AMD AMDSI" :
+               (int)sens == 6 ? "Intel PECI" : "unknown");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get temp%d data!\n", i);
+    free(label);
+  }
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
diff -Naur lm_sensors-2.10.5.orig/prog/sensors/chips.h lm_sensors-2.10.5/prog/sensors/chips.h
--- lm_sensors-2.10.5.orig/prog/sensors/chips.h	2007-10-25 03:31:39.000000000 +0100
+++ lm_sensors-2.10.5/prog/sensors/chips.h	2008-03-01 15:59:17.000000000 +0000
@@ -85,5 +85,6 @@
 extern void print_fscpos_fschmd(const sensors_chip_name *name);
 extern void print_fscscy_fschmd(const sensors_chip_name *name);
 extern void print_fscher_fschmd(const sensors_chip_name *name);
+extern void print_asc7621(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -Naur lm_sensors-2.10.5.orig/prog/sensors/main.c lm_sensors-2.10.5/prog/sensors/main.c
--- lm_sensors-2.10.5.orig/prog/sensors/main.c	2007-10-25 03:31:39.000000000 +0100
+++ lm_sensors-2.10.5/prog/sensors/main.c	2008-03-01 16:25:06.000000000 +0000
@@ -433,6 +433,7 @@
 	{ "adm1022", print_thmc50 },
 	{ "fschmd", print_fschmd },
 	{ "fschrc", print_fschmd },
+	{ "asc7621", print_asc7621 },
 	{ NULL, NULL }
 };
 

--------------080106080601070408030102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080106080601070408030102--
