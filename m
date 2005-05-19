From: aurelien@aurel32.net (=?iso-8859-15?Q?Aur=E9lien?= Jarno)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH] I2C: library update for sis5595
Message-Id: <20050126204138.GA21270@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a patch to support the sis5595 with the new 2.6
driver. It should also add support for displaying in4 with a 2.4 kernel.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

-------------- next part --------------
Index: lib/chips.h
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
retrieving revision 1.101
diff -u -1 -b -p -r1.101 chips.h
--- lib/chips.h	24 Nov 2004 04:31:40 -0000	1.101
+++ lib/chips.h	26 Jan 2005 18:48:08 -0000
@@ -848,3 +848,3 @@
 #define SENSORS_SIS5595_IN3 4 /* R */
-#define SENSORS_SIS5595_IN4 4 /* R */
+#define SENSORS_SIS5595_IN4 5 /* R */
 #define SENSORS_SIS5595_IN0_MIN 11 /* RW */
@@ -853,3 +853,3 @@
 #define SENSORS_SIS5595_IN3_MIN 14 /* RW */
-#define SENSORS_SIS5595_IN4_MIN 14 /* RW */
+#define SENSORS_SIS5595_IN4_MIN 15 /* RW */
 #define SENSORS_SIS5595_IN0_MAX 21 /* RW */
@@ -858,3 +858,3 @@
 #define SENSORS_SIS5595_IN3_MAX 24 /* RW */
-#define SENSORS_SIS5595_IN4_MAX 24 /* RW */
+#define SENSORS_SIS5595_IN4_MAX 25 /* RW */
 #define SENSORS_SIS5595_FAN1 31 /* R */
Index: prog/sensord/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/chips.c,v
retrieving revision 1.13
diff -u -1 -b -p -r1.13 chips.c
--- prog/sensord/chips.c	12 May 2004 20:05:14 -0000	1.13
+++ prog/sensord/chips.c	26 Jan 2005 18:48:08 -0000
@@ -328,2 +328,4 @@ static const FeatureDescriptor sis5595_f
     { SENSORS_SIS5595_IN3, SENSORS_SIS5595_IN3_MIN, SENSORS_SIS5595_IN3_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SIS5595_ALARM_IN4, 0,
+    { SENSORS_SIS5595_IN4, SENSORS_SIS5595_IN4_MIN, SENSORS_SIS5595_IN4_MAX, -1 } },
   { fmtFans_0, rrdF0, DataType_rpm, SIS5595_ALARM_FAN1, 0,
Index: prog/sensors/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
retrieving revision 1.150
diff -u -1 -b -p -r1.150 chips.c
--- prog/sensors/chips.c	4 Jan 2005 16:20:17 -0000	1.150
+++ prog/sensors/chips.c	26 Jan 2005 18:48:08 -0000
@@ -658,2 +658,15 @@ void print_sis5595(const sensors_chip_na
   free_the_label(&label);
+  if (!sensors_get_label_and_valid(*name,SENSORS_SIS5595_IN4,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_SIS5595_IN4,&cur) &&
+      !sensors_get_feature(*name,SENSORS_SIS5595_IN4_MIN,&min) &&
+      !sensors_get_feature(*name,SENSORS_SIS5595_IN4_MAX,&max)) {
+    if (valid) {
+      print_label(label,10);
+      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
+             cur,min,max,alarms&SIS5595_ALARM_IN4?"ALARM":"");
+    }
+  } else
+  /* No error if IN4 is missing as it will happen with 2.6 kernels when 
+     the chip is configured in 4 voltage + 1 temperature sensors. */
+  free_the_label(&label);
 
@@ -694,3 +707,4 @@ void print_sis5595(const sensors_chip_na
   } else
-    printf("ERROR: Can't get TEMP data!\n");
+  /* No error if TEMP is missing as it will happen with 2.6 kernels when 
+     the chip is configured in 5 voltage sensors mode. */
   free_the_label(&label);
