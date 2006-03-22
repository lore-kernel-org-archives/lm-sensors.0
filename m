From: linux@rick.claranet.de (Hartmut Rick)
Date: Wed, 22 Mar 2006 22:44:36 +0000
Subject: [lm-sensors]  [PATCH] New sensors program patch for SMSC47M192
Message-Id: <Pine.LNX.4.63.0603222323420.2984@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jean, and everybody else,

Thanks for the review of my user-space patch, and for all the comments
and suggestions.
Here is a new patch that should work together with the latest smsc47m192 
driver. The patch applies to lm_sensors-2.10.0.

On Sat, 11 Mar 2006, Jean Delvare wrote:

> For temperatures, the Linux 2.4 standard is VALUE(1) for the high limit
> and VALUE(2) for the low limit. This still doesn't affect your Linux 2.6

Ok, I've changed that for the temperatures. Does the same comment apply 
also to voltages?

Otherwise I hope I've included all your comments.

Best regards,
  Hartmut
-------------- next part --------------
diff -uprN lm_sensors-2.10.0/etc/sensors.conf.eg lm_sensors-2.10.0n/etc/sensors.conf.eg
--- lm_sensors-2.10.0/etc/sensors.conf.eg	2006-02-15 02:46:47.000000000 +0100
+++ lm_sensors-2.10.0n/etc/sensors.conf.eg	2006-03-22 23:08:44.000000000 +0100
@@ -2141,6 +2141,59 @@ chip "smsc47m1-*"
 #    set fan1_min 3000
 #    set fan2_min 3000
 
+chip "smsc47m192-*"
+
+# Temperature and voltage input from SMSC LPC47M192 and LPC47M997 chips
+# This example works on a Gigabyte K8U motherboard
+# Voltages are scaled internally, no computations needed
+
+    label in0 "+2.5V"
+    set in0_min  2.5 * 0.95
+    set in0_max  2.5 * 1.05
+
+    label in1 "VCore"
+    set in1_min  vid * 0.95
+    set in1_max  vid * 1.05
+
+    label in2 "+3.3V"
+    set in2_min  3.3 * 0.95
+    set in2_max  3.3 * 1.05
+
+    label in3 "+5V"
+    set in3_min  5.0 * 0.95
+    set in3_max  5.0 * 1.05
+
+    label in4 "+12V"
+    set in4_min  12.0 * 0.95
+    set in4_max  12.0 * 1.05
+
+    label in5 "VCC"
+    set in5_min  3.3 * 0.95
+    set in5_max  3.3 * 1.05
+
+    label in6 "+1.5V"
+    set in6_min  1.5 * 0.95
+    set in6_max  1.5 * 1.05
+#   ignore in6
+
+    label in7 "+1.8V"
+    set in7_min  1.8 * 0.95
+    set in7_max  1.8 * 1.05
+#   Haven't yet heard from any board that has 1.8V connected, so
+#   this might be more appropriate:
+#   ignore in7
+    
+    label temp1 "Chip Temp"
+#    set temp1_min   0
+#    set temp1_max   60
+
+    label temp2 "CPU Temp"
+#    set temp2_min   0
+#    set temp2_max   60
+
+    label temp3 "Sys Temp"
+#    set temp3_min   0
+#    set temp3_max   60
 
 #
 # This example was tested vs. Asus P4S333
diff -uprN lm_sensors-2.10.0/lib/chips.c lm_sensors-2.10.0n/lib/chips.c
--- lm_sensors-2.10.0/lib/chips.c	2006-02-15 02:46:48.000000000 +0100
+++ lm_sensors-2.10.0n/lib/chips.c	2006-03-22 23:00:52.000000000 +0100
@@ -4636,6 +4636,106 @@ static sensors_chip_feature smsc47m1_fea
     { 0 }
   };
 
+static sensors_chip_feature smsc47m192_features[] +  { 
+    { SENSORS_SMSC47M192_IN(0), "in0", NOMAP, NOMAP, 
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(1), "in1", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(2), "in2", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(3), "in3", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(4), "in4", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(5), "in5", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(6), "in6", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN(7), "in7", NOMAP, NOMAP,
+                        R, NOSYSCTL, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(0), "in0_min", SENSORS_SMSC47M192_IN(0),
+		SENSORS_SMSC47M192_IN(0), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(1), "in1_min", SENSORS_SMSC47M192_IN(1),
+		SENSORS_SMSC47M192_IN(1), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(2), "in2_min", SENSORS_SMSC47M192_IN(2),
+		SENSORS_SMSC47M192_IN(2), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(3), "in3_min", SENSORS_SMSC47M192_IN(3),
+		SENSORS_SMSC47M192_IN(3), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(4), "in4_min", SENSORS_SMSC47M192_IN(4),
+		SENSORS_SMSC47M192_IN(4), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(5), "in5_min", SENSORS_SMSC47M192_IN(5),
+		SENSORS_SMSC47M192_IN(5), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(6), "in6_min", SENSORS_SMSC47M192_IN(6),
+		SENSORS_SMSC47M192_IN(6), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MIN(7), "in7_min", SENSORS_SMSC47M192_IN(7),
+		SENSORS_SMSC47M192_IN(7), RW, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(0), "in0_max", SENSORS_SMSC47M192_IN(0),
+		SENSORS_SMSC47M192_IN(0), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(1), "in1_max", SENSORS_SMSC47M192_IN(1),
+		SENSORS_SMSC47M192_IN(1), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(2), "in2_max", SENSORS_SMSC47M192_IN(2),
+		SENSORS_SMSC47M192_IN(2), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(3), "in3_max", SENSORS_SMSC47M192_IN(3),
+		SENSORS_SMSC47M192_IN(3), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(4), "in4_max", SENSORS_SMSC47M192_IN(4),
+		SENSORS_SMSC47M192_IN(4), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(5), "in5_max", SENSORS_SMSC47M192_IN(5),
+		SENSORS_SMSC47M192_IN(5), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(6), "in6_max", SENSORS_SMSC47M192_IN(6),
+		SENSORS_SMSC47M192_IN(6), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_MAX(7), "in7_max", SENSORS_SMSC47M192_IN(7),
+		SENSORS_SMSC47M192_IN(7), RW, NOSYSCTL, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN_ALARM(0), "in0_alarm", SENSORS_SMSC47M192_IN(0),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(1), "in1_alarm", SENSORS_SMSC47M192_IN(1),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(2), "in2_alarm", SENSORS_SMSC47M192_IN(2),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(3), "in3_alarm", SENSORS_SMSC47M192_IN(3),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(4), "in4_alarm", SENSORS_SMSC47M192_IN(4),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(5), "in5_alarm", SENSORS_SMSC47M192_IN(5),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(6), "in6_alarm", SENSORS_SMSC47M192_IN(6),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_IN_ALARM(7), "in7_alarm", SENSORS_SMSC47M192_IN(7),
+			NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP(1), "temp1", NOMAP, NOMAP,
+			R, NOSYSCTL, VALUE(3), 0 },
+    { SENSORS_SMSC47M192_TEMP(2), "temp2", NOMAP, NOMAP,
+			R, NOSYSCTL, VALUE(3), 0 },
+    { SENSORS_SMSC47M192_TEMP(3), "temp3", NOMAP, NOMAP,
+			R, NOSYSCTL, VALUE(3), 0 },
+    { SENSORS_SMSC47M192_TEMP_MIN(1), "temp1_min", SENSORS_SMSC47M192_TEMP(1),
+		SENSORS_SMSC47M192_TEMP(1), RW, NOSYSCTL, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP_MIN(2), "temp2_min", SENSORS_SMSC47M192_TEMP(2),
+		SENSORS_SMSC47M192_TEMP(2), RW, NOSYSCTL, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP_MIN(3), "temp3_min", SENSORS_SMSC47M192_TEMP(3),
+		SENSORS_SMSC47M192_TEMP(3), RW, NOSYSCTL, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP_MAX(1), "temp1_max", SENSORS_SMSC47M192_TEMP(1),
+		SENSORS_SMSC47M192_TEMP(1), RW, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_MAX(2), "temp2_max", SENSORS_SMSC47M192_TEMP(2),
+		SENSORS_SMSC47M192_TEMP(2), RW, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_MAX(3), "temp3_max", SENSORS_SMSC47M192_TEMP(3),
+		SENSORS_SMSC47M192_TEMP(3), RW, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_ALARM(1), "temp1_alarm",
+		SENSORS_SMSC47M192_TEMP(1), NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_ALARM(2), "temp2_alarm",
+		SENSORS_SMSC47M192_TEMP(2), NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_ALARM(3), "temp3_alarm",
+		SENSORS_SMSC47M192_TEMP(3), NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_FAULT(2), "temp2_input_fault",
+		SENSORS_SMSC47M192_TEMP(2), NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_TEMP_FAULT(3), "temp3_input_fault",
+		SENSORS_SMSC47M192_TEMP(3), NOMAP, R, NOSYSCTL, VALUE(1), 0 },
+    { SENSORS_SMSC47M192_VID, "vid", NOMAP, NOMAP, R, NOSYSCTL, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_VRM, "vrm", NOMAP, NOMAP, RW, NOSYSCTL, VALUE(1), 1 },
+    { 0 }
+  };
+
+
 static sensors_chip_feature pc87360_features[]    { 
     { SENSORS_PC87360_FAN1, "fan1", NOMAP, NOMAP, R,
@@ -5624,6 +5724,7 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_FSCHER_PREFIX, fscher_features },
  { SENSORS_PCF8591_PREFIX, pcf8591_features }, 
  { SENSORS_VT1211_PREFIX, vt1211_features }, 
+ { SENSORS_SMSC47M192_PREFIX, smsc47m192_features }, 
  { SENSORS_SMSC47M1_PREFIX, smsc47m1_features }, 
  { SENSORS_PC87360_PREFIX, pc87360_features }, 
  { SENSORS_PC87363_PREFIX, pc87360_features }, 
diff -uprN lm_sensors-2.10.0/lib/chips.h lm_sensors-2.10.0n/lib/chips.h
--- lm_sensors-2.10.0/lib/chips.h	2006-02-15 02:46:48.000000000 +0100
+++ lm_sensors-2.10.0n/lib/chips.h	2006-03-22 22:04:46.000000000 +0100
@@ -1747,6 +1747,21 @@
 #define SENSORS_SMSC47M1_FAN2_DIV 76 /* RW */
 #define SENSORS_SMSC47M1_ALARMS 81 /* R */
 
+#define SENSORS_SMSC47M192_PREFIX "smsc47m192"
+
+#define SENSORS_SMSC47M192_IN(n)		(1 + (n))	/* R */
+#define SENSORS_SMSC47M192_IN_MIN(n)		(21 + (n))	/* RW */
+#define SENSORS_SMSC47M192_IN_MAX(n)		(41 + (n))	/* RW */
+#define SENSORS_SMSC47M192_IN_ALARM(n)		(61 + (n))	/* R */
+#define SENSORS_SMSC47M192_TEMP(n)		(100 + (n))	/* R */
+#define SENSORS_SMSC47M192_TEMP_MAX(n)		(120 + (n))	/* RW */
+#define SENSORS_SMSC47M192_TEMP_MIN(n)		(140 + (n))	/* RW */
+#define SENSORS_SMSC47M192_TEMP_OFFSET(n)	(160 + (n))	/* RW */
+#define SENSORS_SMSC47M192_TEMP_ALARM(n)	(180 + (n))	/* R */
+#define SENSORS_SMSC47M192_TEMP_FAULT(n)	(200 + (n))	/* R */
+#define SENSORS_SMSC47M192_VID			301		/* R */
+#define SENSORS_SMSC47M192_VRM			302		/* RW */
+
 #define SENSORS_PC87360_PREFIX "pc87360"
 #define SENSORS_PC87363_PREFIX "pc87363"
 #define SENSORS_PC87364_PREFIX "pc87364"
diff -uprN lm_sensors-2.10.0/prog/detect/sensors-detect lm_sensors-2.10.0n/prog/detect/sensors-detect
--- lm_sensors-2.10.0/prog/detect/sensors-detect	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0n/prog/detect/sensors-detect	2006-03-22 22:29:54.000000000 +0100
@@ -1478,7 +1478,7 @@ use subs qw(mtp008_detect lm78_detect lm
      },
      {
        name => "SMSC LPC47M15x, LPC47M192 or LPC47M997",
-       driver => "to-be-written",
+       driver => "smsc47m192",
        i2c_addrs => [0x2c..0x2d],
        i2c_detect => sub { smsc47m192_detect @_ },
      },
diff -uprN lm_sensors-2.10.0/prog/sensors/chips.c lm_sensors-2.10.0n/prog/sensors/chips.c
--- lm_sensors-2.10.0/prog/sensors/chips.c	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0n/prog/sensors/chips.c	2006-03-22 22:55:49.000000000 +0100
@@ -4438,6 +4438,58 @@ void print_smsc47m1(const sensors_chip_n
   }
 }
 
+void print_smsc47m192(const sensors_chip_name *name)
+{
+  char *label;
+  double cur,min,max;
+  int valid, i;
+
+  for (i=0; i<8; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_SMSC47M192_IN(i), &label,
+								&valid) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_IN(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_IN_MIN(i), &min) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_IN_MAX(i), &max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   ", cur, min, max);
+	if (!sensors_get_feature(*name, SENSORS_SMSC47M192_IN_ALARM(i), &cur))
+	  if (cur > 0.5)
+	    printf("ALARM");
+	printf("\n");
+      }
+    } else
+      if (i!=4) /* Chip may have +12V input used for VID instead */
+        printf("ERROR: Can't get IN%d data!\n", i);
+    free(label);
+  }
+  for (i=1; i<=3; i++) {
+    if (!sensors_get_label_and_valid(*name, SENSORS_SMSC47M192_TEMP(i),
+							&label, &valid) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP_MIN(i), &min) &&
+        !sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP_MAX(i), &max)) {
+      if (valid) {
+        print_label(label,10);
+        print_temp_info( cur, max, min, MINMAX, 1, 0);
+        if (i > 1 && !sensors_get_feature(*name,
+				SENSORS_SMSC47M192_TEMP_FAULT(i), &cur)) {
+	   if (cur > 0.5)
+	     printf("FAULT");
+	}
+        else
+        if (!sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP_ALARM(i), &cur))
+          if (cur > 0.5)
+	    printf("ALARM");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get TEMP%d data!\n", i);
+    free(label);
+  }
+  print_vid_info(name, SENSORS_SMSC47M192_VID, SENSORS_SMSC47M192_VRM);
+}
+
 void print_pc87360(const sensors_chip_name *name)
 {
   char *label;
diff -uprN lm_sensors-2.10.0/prog/sensors/chips.h lm_sensors-2.10.0n/prog/sensors/chips.h
--- lm_sensors-2.10.0/prog/sensors/chips.h	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0n/prog/sensors/chips.h	2006-03-22 21:09:03.000000000 +0100
@@ -55,6 +55,7 @@ extern void print_fscher(const sensors_c
 extern void print_pcf8591(const sensors_chip_name *name);
 extern void print_vt1211(const sensors_chip_name *name);
 extern void print_smsc47m1(const sensors_chip_name *name);
+extern void print_smsc47m192(const sensors_chip_name *name);
 extern void print_pc87360(const sensors_chip_name *name);
 extern void print_pc87364(const sensors_chip_name *name);
 extern void print_pc87366(const sensors_chip_name *name);
diff -uprN lm_sensors-2.10.0/prog/sensors/main.c lm_sensors-2.10.0n/prog/sensors/main.c
--- lm_sensors-2.10.0/prog/sensors/main.c	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0n/prog/sensors/main.c	2006-03-22 21:08:22.000000000 +0100
@@ -388,6 +388,7 @@ struct match matches[] = {
 	{ "fscher", print_fscher },
 	{ "pcf8591", print_pcf8591 },
 	{ "vt1211", print_vt1211 },
+	{ "smsc47m192", print_smsc47m192 },
 	{ "smsc47m1", print_smsc47m1 },
 	{ "pc87360", print_pc87360 },
 	{ "pc87363", print_pc87360 },
