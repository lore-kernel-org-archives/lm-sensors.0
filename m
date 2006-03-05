From: linux@rick.claranet.de (Hartmut Rick)
Date: Sun, 05 Mar 2006 00:33:15 +0000
Subject: [lm-sensors]  sensors program patch for SMSC47M192
Message-Id: <Pine.LNX.4.63.0603050021410.4437@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi everybody,

Attached is a patch which makes the sensors program print the readings 
from the preliminary smsc47m192 driver for 2.6 kernels.
The patch is relative to the lm_sensors-2.10.0 release.

This is definitely not a candidate for release, since I did not really 
know what I'm doing. I just kept changing the source until printing the 
readings from the smsc47m192 driver worked for me.
I copied the code from some other chips. Since they all use a set of 
definitions containing _SYSCTL_, I did the same. For other drivers, those 
definitions are scanned from the kernel drivers for 2.4. Since I don't 
have a driver for 2.4 kernels, I just included a dummy file which contains 
only the #defines. I still have the suspicion that I don't need all that 
at all, but I couldn't yet figure out what the code should look like.
I haven't even tested whether this breaks the support for 2.4 kernels.

I'm posting the patch here anyway, since it works for me and I guess it 
might be helpful for anybody who wants to test the smsc47m192 driver.

Best regards,
  Hartmut
-------------- next part --------------
diff -uprN1 lm_sensors-2.10.0/etc/sensors.conf.eg lm_sensors-2.10.0-new/etc/sensors.conf.eg
--- lm_sensors-2.10.0/etc/sensors.conf.eg	2006-02-15 02:46:47.000000000 +0100
+++ lm_sensors-2.10.0-new/etc/sensors.conf.eg	2006-03-05 00:16:22.000000000 +0100
@@ -2143,2 +2143,16 @@ chip "smsc47m1-*"
 
+chip "smsc47m192-*"
+
+    label in0 "+2.5V"
+    label in1 "VCore"
+    label in2 "+3.3V"
+    label in3 "+5V"
+    label in4 "+12V"
+    label in5 "VCC"
+    label in6 "+1.5V"
+    label in7 "+1.8V"
+    
+    label temp1 "Chip Temp"
+    label temp2 "CPU Temp"
+    label temp3 "Sys Temp"
 
diff -uprN1 lm_sensors-2.10.0/kernel/chips/smsc47m192.c lm_sensors-2.10.0-new/kernel/chips/smsc47m192.c
--- lm_sensors-2.10.0/kernel/chips/smsc47m192.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors-2.10.0-new/kernel/chips/smsc47m192.c	2006-03-05 00:09:00.000000000 +0100
@@ -0,0 +1,22 @@
+/* The SMSC47M192 driver for 2.4 kernels has not been written yet,
+  this is just a dummy which contains defines to be used by
+  sensors program
+*/
+
+/* -- SENSORS SYSCTL START -- */
+#define SMSC47M192_SYSCTL_IN0        1000
+#define SMSC47M192_SYSCTL_IN1        1001
+#define SMSC47M192_SYSCTL_IN2        1002
+#define SMSC47M192_SYSCTL_IN3        1003
+#define SMSC47M192_SYSCTL_IN4        1004
+#define SMSC47M192_SYSCTL_IN5        1005
+#define SMSC47M192_SYSCTL_IN6        1006
+#define SMSC47M192_SYSCTL_IN7        1007
+#define SMSC47M192_SYSCTL_TEMP1      1250
+#define SMSC47M192_SYSCTL_TEMP2      1251
+#define SMSC47M192_SYSCTL_TEMP3      1252
+#define SMSC47M192_SYSCTL_VID        2003
+#define SMSC47M192_SYSCTL_VRM        2004
+
+/* -- SENSORS SYSCTL END -- */
+
diff -uprN1 lm_sensors-2.10.0/lib/chips.c lm_sensors-2.10.0-new/lib/chips.c
--- lm_sensors-2.10.0/lib/chips.c	2006-02-15 02:46:48.000000000 +0100
+++ lm_sensors-2.10.0-new/lib/chips.c	2006-03-04 23:58:57.000000000 +0100
@@ -4638,2 +4638,118 @@ static sensors_chip_feature smsc47m1_fea
 
+static sensors_chip_feature smsc47m192_features[] +  { 
+    { SENSORS_SMSC47M192_IN0, "in0", NOMAP, NOMAP, 
+                        R, SMSC47M192_SYSCTL_IN0, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN1, "in1", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN1, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN2, "in2", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN2, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN3, "in3", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN3, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN4, "in4", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN4, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN5, "in5", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN5, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN6, "in6", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN6, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN7, "in7", NOMAP, NOMAP,
+                        R, SMSC47M192_SYSCTL_IN7, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_IN0_MIN, "in0_min", SENSORS_SMSC47M192_IN0, SENSORS_SMSC47M192_IN0,
+                            RW, SMSC47M192_SYSCTL_IN0, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN1_MIN, "in1_min", SENSORS_SMSC47M192_IN1, SENSORS_SMSC47M192_IN1,
+                            RW, SMSC47M192_SYSCTL_IN1, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN2_MIN, "in2_min", SENSORS_SMSC47M192_IN2, SENSORS_SMSC47M192_IN2,
+                            RW, SMSC47M192_SYSCTL_IN2, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN3_MIN, "in3_min", SENSORS_SMSC47M192_IN3, SENSORS_SMSC47M192_IN3,
+                            RW, SMSC47M192_SYSCTL_IN3, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN4_MIN, "in4_min", SENSORS_SMSC47M192_IN4, SENSORS_SMSC47M192_IN4,
+                            RW, SMSC47M192_SYSCTL_IN4, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN5_MIN, "in5_min", SENSORS_SMSC47M192_IN5, SENSORS_SMSC47M192_IN5,
+                            RW, SMSC47M192_SYSCTL_IN5, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN6_MIN, "in6_min", SENSORS_SMSC47M192_IN6, SENSORS_SMSC47M192_IN6,
+                            RW, SMSC47M192_SYSCTL_IN6, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN7_MIN, "in7_min", SENSORS_SMSC47M192_IN7, SENSORS_SMSC47M192_IN7,
+                            RW, SMSC47M192_SYSCTL_IN7, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_IN0_MAX, "in0_max", SENSORS_SMSC47M192_IN0, SENSORS_SMSC47M192_IN0,
+                            RW, SMSC47M192_SYSCTL_IN0, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN1_MAX, "in1_max", SENSORS_SMSC47M192_IN1, SENSORS_SMSC47M192_IN1,
+                            RW, SMSC47M192_SYSCTL_IN1, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN2_MAX, "in2_max", SENSORS_SMSC47M192_IN2, SENSORS_SMSC47M192_IN2,
+                            RW, SMSC47M192_SYSCTL_IN2, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN3_MAX, "in3_max", SENSORS_SMSC47M192_IN3, SENSORS_SMSC47M192_IN3,
+                            RW, SMSC47M192_SYSCTL_IN3, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN4_MAX, "in4_max", SENSORS_SMSC47M192_IN4, SENSORS_SMSC47M192_IN4,
+                            RW, SMSC47M192_SYSCTL_IN4, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN5_MAX, "in5_max", SENSORS_SMSC47M192_IN5, SENSORS_SMSC47M192_IN5,
+                            RW, SMSC47M192_SYSCTL_IN5, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN6_MAX, "in6_max", SENSORS_SMSC47M192_IN6, SENSORS_SMSC47M192_IN6,
+                            RW, SMSC47M192_SYSCTL_IN6, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN7_MAX, "in7_max", SENSORS_SMSC47M192_IN7, SENSORS_SMSC47M192_IN7,
+                            RW, SMSC47M192_SYSCTL_IN7, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_IN0_ALARM, "in0_alarm", SENSORS_SMSC47M192_IN0, NOMAP,
+                            R, SMSC47M192_SYSCTL_IN0, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN1_ALARM, "in1_alarm", SENSORS_SMSC47M192_IN1,
+			NOMAP, R, SMSC47M192_SYSCTL_IN1, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN2_ALARM, "in2_alarm", SENSORS_SMSC47M192_IN2,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN2, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN3_ALARM, "in3_alarm", SENSORS_SMSC47M192_IN3,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN3, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN4_ALARM, "in4_alarm", SENSORS_SMSC47M192_IN4,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN4, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN5_ALARM, "in5_alarm", SENSORS_SMSC47M192_IN5,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN5, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN6_ALARM, "in6_alarm", SENSORS_SMSC47M192_IN6,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN6, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_IN7_ALARM, "in7_alarm", SENSORS_SMSC47M192_IN7,
+                        NOMAP, R, SMSC47M192_SYSCTL_IN7, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP1, "temp1", NOMAP, NOMAP,
+                         R, SMSC47M192_SYSCTL_TEMP1, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_TEMP2, "temp2", NOMAP, NOMAP,
+                         R, SMSC47M192_SYSCTL_TEMP2, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_TEMP3, "temp3", NOMAP, NOMAP,
+                         R, SMSC47M192_SYSCTL_TEMP3, VALUE(3), 3 },
+    { SENSORS_SMSC47M192_TEMP1_MIN, "temp1_min", SENSORS_SMSC47M192_TEMP1,
+                              SENSORS_SMSC47M192_TEMP1, RW, 
+                              SMSC47M192_SYSCTL_TEMP1, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_TEMP2_MIN, "temp2_min", SENSORS_SMSC47M192_TEMP2,
+                              SENSORS_SMSC47M192_TEMP2, RW, 
+                              SMSC47M192_SYSCTL_TEMP2, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_TEMP3_MIN, "temp3_min", SENSORS_SMSC47M192_TEMP3,
+                              SENSORS_SMSC47M192_TEMP3, RW, 
+                              SMSC47M192_SYSCTL_TEMP3, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_TEMP1_MAX, "temp1_max", SENSORS_SMSC47M192_TEMP1,
+                              SENSORS_SMSC47M192_TEMP1, RW, 
+                              SMSC47M192_SYSCTL_TEMP1, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_TEMP2_MAX, "temp2_max", SENSORS_SMSC47M192_TEMP2,
+                              SENSORS_SMSC47M192_TEMP2, RW, 
+                              SMSC47M192_SYSCTL_TEMP2, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_TEMP3_MAX, "temp3_max", SENSORS_SMSC47M192_TEMP3,
+                              SENSORS_SMSC47M192_TEMP3, RW, 
+                              SMSC47M192_SYSCTL_TEMP3, VALUE(2), 3 },
+    { SENSORS_SMSC47M192_TEMP1_ALARM, "temp1_alarm", SENSORS_SMSC47M192_TEMP1,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP1, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP2_ALARM, "temp2_alarm", SENSORS_SMSC47M192_TEMP2,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP2, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP3_ALARM, "temp3_alarm", SENSORS_SMSC47M192_TEMP3,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP3, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP1_FAULT, "temp1_fault", SENSORS_SMSC47M192_TEMP1,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP1, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP2_FAULT, "temp2_fault", SENSORS_SMSC47M192_TEMP2,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP2, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_TEMP3_FAULT, "temp3_fault", SENSORS_SMSC47M192_TEMP3,
+                              NOMAP, R, 
+                              SMSC47M192_SYSCTL_TEMP3, VALUE(2), 0 },
+    { SENSORS_SMSC47M192_VID, "vid", NOMAP, NOMAP,
+                         R, SMSC47M192_SYSCTL_VID, VALUE(1), 3 },
+    { SENSORS_SMSC47M192_VRM, "vrm", NOMAP, NOMAP,
+                         RW, SMSC47M192_SYSCTL_VRM, VALUE(1), 1 },
+    { 0 }
+  };
+
+
 static sensors_chip_feature pc87360_features[] @@ -5626,2 +5742,3 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_VT1211_PREFIX, vt1211_features }, 
+ { SENSORS_SMSC47M192_PREFIX, smsc47m192_features }, 
  { SENSORS_SMSC47M1_PREFIX, smsc47m1_features }, 
diff -uprN1 lm_sensors-2.10.0/lib/chips.h lm_sensors-2.10.0-new/lib/chips.h
--- lm_sensors-2.10.0/lib/chips.h	2006-02-15 02:46:48.000000000 +0100
+++ lm_sensors-2.10.0-new/lib/chips.h	2006-03-05 00:02:29.000000000 +0100
@@ -1749,2 +1749,54 @@
 
+#define SENSORS_SMSC47M192_PREFIX "smsc47m192"
+
+#define SENSORS_SMSC47M192_IN0		1	/* R */
+#define SENSORS_SMSC47M192_IN1		2	/* R */
+#define SENSORS_SMSC47M192_IN2		3	/* R */
+#define SENSORS_SMSC47M192_IN3		4	/* R */
+#define SENSORS_SMSC47M192_IN4		5	/* R */
+#define SENSORS_SMSC47M192_IN5		6	/* R */
+#define SENSORS_SMSC47M192_IN6		7	/* R */
+#define SENSORS_SMSC47M192_IN7		8	/* R */
+#define SENSORS_SMSC47M192_IN0_MIN	11	/* RW */
+#define SENSORS_SMSC47M192_IN1_MIN	12	/* RW */
+#define SENSORS_SMSC47M192_IN2_MIN	13	/* RW */
+#define SENSORS_SMSC47M192_IN3_MIN	14	/* RW */
+#define SENSORS_SMSC47M192_IN4_MIN	15	/* RW */
+#define SENSORS_SMSC47M192_IN5_MIN	16	/* RW */
+#define SENSORS_SMSC47M192_IN6_MIN	17	/* RW */
+#define SENSORS_SMSC47M192_IN7_MIN	18	/* RW */
+#define SENSORS_SMSC47M192_IN0_MAX	21	/* RW */
+#define SENSORS_SMSC47M192_IN1_MAX	22	/* RW */
+#define SENSORS_SMSC47M192_IN2_MAX	23	/* RW */
+#define SENSORS_SMSC47M192_IN3_MAX	24	/* RW */
+#define SENSORS_SMSC47M192_IN4_MAX	25	/* RW */
+#define SENSORS_SMSC47M192_IN5_MAX	26	/* RW */
+#define SENSORS_SMSC47M192_IN6_MAX	27	/* RW */
+#define SENSORS_SMSC47M192_IN7_MAX	28	/* RW */
+#define SENSORS_SMSC47M192_IN0_ALARM	29	/* R */
+#define SENSORS_SMSC47M192_IN1_ALARM	30	/* R */
+#define SENSORS_SMSC47M192_IN2_ALARM	31	/* R */
+#define SENSORS_SMSC47M192_IN3_ALARM	32	/* R */
+#define SENSORS_SMSC47M192_IN4_ALARM	33	/* R */
+#define SENSORS_SMSC47M192_IN5_ALARM	34	/* R */
+#define SENSORS_SMSC47M192_IN6_ALARM	35	/* R */
+#define SENSORS_SMSC47M192_IN7_ALARM	36	/* R */
+#define SENSORS_SMSC47M192_TEMP1	51	/* R */
+#define SENSORS_SMSC47M192_TEMP2	52	/* R */
+#define SENSORS_SMSC47M192_TEMP3	53	/* R */
+#define SENSORS_SMSC47M192_TEMP1_MAX	54	/* RW */
+#define SENSORS_SMSC47M192_TEMP2_MAX	55	/* RW */
+#define SENSORS_SMSC47M192_TEMP3_MAX	56	/* RW */
+#define SENSORS_SMSC47M192_TEMP1_MIN	57	/* RW */
+#define SENSORS_SMSC47M192_TEMP2_MIN	58	/* RW */
+#define SENSORS_SMSC47M192_TEMP3_MIN	59	/* RW */
+#define SENSORS_SMSC47M192_TEMP1_ALARM	61	/* R */
+#define SENSORS_SMSC47M192_TEMP2_ALARM	62	/* R */
+#define SENSORS_SMSC47M192_TEMP3_ALARM	63	/* R */
+#define SENSORS_SMSC47M192_TEMP1_FAULT	64	/* R */
+#define SENSORS_SMSC47M192_TEMP2_FAULT	65	/* R */
+#define SENSORS_SMSC47M192_TEMP3_FAULT	66	/* R */
+#define SENSORS_SMSC47M192_VID		82	/* R */
+#define SENSORS_SMSC47M192_VRM		83	/* RW */
+
 #define SENSORS_PC87360_PREFIX "pc87360"
diff -uprN1 lm_sensors-2.10.0/prog/sensors/chips.c lm_sensors-2.10.0-new/prog/sensors/chips.c
--- lm_sensors-2.10.0/prog/sensors/chips.c	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0-new/prog/sensors/chips.c	2006-03-05 00:20:44.000000000 +0100
@@ -4440,2 +4440,49 @@ void print_smsc47m1(const sensors_chip_n
 
+void print_smsc47m192(const sensors_chip_name *name)
+{
+  char *label;
+  double cur,min,max;
+  int valid, i;
+
+  for (i=0; i<8; i++) {
+    if (!sensors_get_label_and_valid(*name,SENSORS_SMSC47M192_IN0+i,&label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_IN0+i,&cur) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_IN0_MIN+i,&min) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_IN0_MAX+i,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   ", cur,min,max);
+	if (!sensors_get_feature(*name,SENSORS_SMSC47M192_IN0_ALARM+i,&cur))
+	  if (cur>0.5)
+	    printf("ALARM");
+	printf("\n");
+      }
+    } else
+      if (i!=4) /* Chip may have +12V input used for VID instead */
+        printf("ERROR: Can't get IN%d data!\n", i);
+    free(label);
+  }
+  for (i=0; i<3; i++) {
+    if (!sensors_get_label_and_valid(*name,SENSORS_SMSC47M192_TEMP1+i,&label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1+i,&cur) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_MIN+i,&min) &&
+        !sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_MAX+i,&max)) {
+      if (valid) {
+        print_label(label,10);
+        print_temp_info( cur, max, min, MINMAX, 1, 0);
+	if (!sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_FAULT+i,&cur))
+	  if (cur>0.5)
+	    printf("FAULT");
+	if (!sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_ALARM+i,&cur))
+	  if (cur>0.5)
+	    printf(" ALARM");
+        printf("\n");
+      }
+    } else
+      printf("ERROR: Can't get TEMP%d data!\n", i+1);
+    free(label);
+  }
+  print_vid_info(name, SENSORS_SMSC47M192_VID, SENSORS_SMSC47M192_VRM);
+}
+
 void print_pc87360(const sensors_chip_name *name)
diff -uprN1 lm_sensors-2.10.0/prog/sensors/chips.h lm_sensors-2.10.0-new/prog/sensors/chips.h
--- lm_sensors-2.10.0/prog/sensors/chips.h	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0-new/prog/sensors/chips.h	2006-03-04 23:55:38.000000000 +0100
@@ -57,2 +57,3 @@ extern void print_vt1211(const sensors_c
 extern void print_smsc47m1(const sensors_chip_name *name);
+extern void print_smsc47m192(const sensors_chip_name *name);
 extern void print_pc87360(const sensors_chip_name *name);
diff -uprN1 lm_sensors-2.10.0/prog/sensors/main.c lm_sensors-2.10.0-new/prog/sensors/main.c
--- lm_sensors-2.10.0/prog/sensors/main.c	2006-02-15 02:46:49.000000000 +0100
+++ lm_sensors-2.10.0-new/prog/sensors/main.c	2006-03-04 23:55:59.000000000 +0100
@@ -390,2 +390,3 @@ struct match matches[] = {
 	{ "vt1211", print_vt1211 },
+	{ "smsc47m192", print_smsc47m192 },
 	{ "smsc47m1", print_smsc47m1 },
