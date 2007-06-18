From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Mon, 18 Jun 2007 16:58:24 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <651567.12953.qm@web25110.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-173508737-1182185904=:12953"
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
To: lm-sensors@vger.kernel.org

--0-173508737-1182185904=:12953
Content-Type: multipart/alternative; boundary="0-505686146-1182185904=:12953"

--0-505686146-1182185904=:12953
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I've attached a patch for Fintek F75373S support,=20
kernel module f75375s is required.

At the moment it is possible to read out 4 different voltage=20
values, 2 temperatures and 2 fans/pwm (i've only one fan=20
connected, so i could only verify that one of two is working
correct).
I was not able to adjust fan speed using fancontrol,=20
i have to do it by hand.

sensors output looks like:
mythtv@pc:~$ sensors F75373-*
F75373-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5100
VCC:       +1.72 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
V1:        +1.34 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
V2:        +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
V3:        +0.77 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
CPU Temp:    +50=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C) =20
Sys Temp:    +47=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C) =20
CPU Fan:  1866 RPM  (min =3D    0 RPM)
CPU PWM:    31      (enable =3D 1)

christian.
=20
 	=09
---------------------------------
Yahoo! Messenger -  kostenlos* mit Familie und Freunden von PC zu PC telefo=
nieren.=20
--0-505686146-1182185904=:12953
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi<br><pre>I've attached a patch for Fintek F75373S support, <br>kernel mod=
ule f75375s is required.<br><br>At the moment it is possible to read out 4 =
different voltage <br>values, 2 temperatures and 2 fans/pwm (i've only one =
fan <br>connected, so i could only verify that one of two is working<br>cor=
rect).<br>I was not able to adjust fan speed using fancontrol, <br>i have t=
o do it by hand.<br><br>sensors output looks like:<br>mythtv@pc:~$ sensors =
F75373-*<br>F75373-i2c-1-2d<br>Adapter: SMBus nForce2 adapter at 5100<br>VC=
C:       +1.72 V  (min =3D  +0.00 V, max =3D  +0.00 V)  <br>V1:        +1.3=
4 V  (min =3D  +0.00 V, max =3D  +0.00 V)  <br>V2:        +1.01 V  (min =3D=
  +0.00 V, max =3D  +0.00 V)  <br>V3:        +0.77 V  (min =3D  +0.00 V, ma=
x =3D  +0.00 V)  <br>CPU Temp:    +50=B0C  (high =3D    +0=B0C, hyst =3D   =
 +0=B0C)  <br>Sys Temp:    +47=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C=
)  <br>CPU Fan:  1866 RPM  (min =3D    0 RPM)<br>CPU PWM:    31      (enabl=
e =3D 1)<br><br>christian.</pre> <p>&#32;
		<hr size=3D1>Yahoo! Messenger -=20
 <a href=3Dhttp://de.rd.yahoo.com/evt=3D39058/*http://de.messenger.yahoo.com
>kostenlos* mit Familie und Freunden von PC zu PC telefonieren
</a>.=20

--0-505686146-1182185904=:12953--

--0-173508737-1182185904=:12953
Content-Type: text/x-patch; name="fintek_75373s_support.patch"
Content-Description: 4088216775-fintek_75373s_support.patch
Content-Disposition: inline; filename="fintek_75373s_support.patch"

diff -urN lm-sensors_org/etc/sensors.conf.eg lm-sensors/etc/sensors.conf.eg
--- lm-sensors_org/etc/sensors.conf.eg	2007-06-17 15:34:35.000000000 +0200
+++ lm-sensors/etc/sensors.conf.eg	2007-06-17 16:54:34.000000000 +0200
@@ -2880,3 +2880,36 @@
 #   set fan4_min 1000
 #   set fan5_min 1000
 #   set fan6_min 1000
+
+
+#
+# Sample configuration for the Fintek F75373
+#
+chip "f75373-*"
+
+# Voltages
+   label in0_input "VCC"
+   label in1_input "V1"
+   label in2_input "V2"
+   label in3_input "V3"
+
+   compute in0_input  @/1000,@/1000
+   compute in1_input  @/1000,@/1000
+   compute in2_input  @/1000,@/1000
+   compute in3_input  @/1000,@/1000
+
+# Fans
+   label fan1 "CPU Fan"
+   label fan2 "Sys Fan"
+
+   compute fan1  ( 1.5 * 1000000 )/@,  ( 1.5 * 1000000 )/@
+   compute fan2  ( 1.5 * 1000000 )/@,  ( 1.5 * 1000000 )/@
+
+# Temperatures
+   label temp1 "CPU Temp"
+   label temp2 "Sys Temp"
+   
+# PWM
+   label pwm1   "CPU PWM"
+   label pwm2   "Sys PWM"
+
diff -urN lm-sensors_org/lib/chips.c lm-sensors/lib/chips.c
--- lm-sensors_org/lib/chips.c	2007-06-17 15:34:32.000000000 +0200
+++ lm-sensors/lib/chips.c	2007-06-17 15:57:49.000000000 +0200
@@ -6108,6 +6108,64 @@
     { { 0 }, 0 }
   };
 
+
+
+#define SENSORS_F75373_IN_FEATURES(nr) \
+        { { SENSORS_F75373_IN(nr), "in" #nr "_input", \
+                NOMAP, NOMAP, R }, \
+                NOSYSCTL, VALUE(3), 3 }, \
+        { { SENSORS_F75373_IN_MIN(nr), "in" #nr "_min", \
+                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW }, \
+                NOSYSCTL, VALUE(2), 3 }, \
+        { { SENSORS_F75373_IN_MAX(nr), "in" #nr "_max", \
+                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW }, \
+                NOSYSCTL, VALUE(2), 3 }
+
+#define SENSORS_F75373_TEMP_FEATURES(nr) \
+        { { SENSORS_F75373_TEMP(nr), "temp" #nr "", \
+                NOMAP, NOMAP, R }, \
+                NOSYSCTL, VALUE(3), 3 }, \
+        { { SENSORS_F75373_TEMP_MAX(nr), "temp" #nr "_max", \
+                SENSORS_F75373_TEMP(nr), SENSORS_F75373_TEMP(nr), RW }, \
+                NOSYSCTL, VALUE(1), 3 }, \
+        { { SENSORS_F75373_TEMP_HYST(nr), "temp" #nr "_hyst", \
+                SENSORS_F75373_TEMP(nr), NOMAP, R }, \
+                NOSYSCTL, VALUE(1), 0 }
+
+#define SENSORS_F75373_FAN_FEATURES(nr) \
+        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
+                NOMAP, NOMAP, R }, \
+                NOSYSCTL, VALUE(2), 0 }, \
+        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
+                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW }, \
+                NOSYSCTL, VALUE(1), 0 }, \
+        { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \
+                SENSORS_F75373_FAN(nr), NOMAP, R }, \
+                NOSYSCTL, VALUE(1), 0 }
+
+#define SENSORS_F75373_PWM_FEATURES(nr) \
+        { { SENSORS_F75373_PWM(nr), "pwm" #nr, \
+                NOMAP, NOMAP, RW }, \
+                NOSYSCTL, VALUE(1), 0 }, \
+        { { SENSORS_F75373_PWM_ENABLE(nr), "pwm" #nr "_enable", \
+                SENSORS_F75373_PWM(nr), SENSORS_F75373_PWM(nr), RW }, \
+                NOSYSCTL, VALUE(3), 0 }
+
+static sensors_chip_feature f75373_features[] =
+{
+        SENSORS_F75373_IN_FEATURES(0),
+        SENSORS_F75373_IN_FEATURES(1),
+        SENSORS_F75373_IN_FEATURES(2),
+        SENSORS_F75373_IN_FEATURES(3),
+        SENSORS_F75373_TEMP_FEATURES(1),
+        SENSORS_F75373_TEMP_FEATURES(2),
+        SENSORS_F75373_FAN_FEATURES(1),
+        SENSORS_F75373_FAN_FEATURES(2),
+        SENSORS_F75373_PWM_FEATURES(1),
+        SENSORS_F75373_PWM_FEATURES(2),
+        { { 0 }, 0 }
+};
+
 sensors_chip_features sensors_chip_features_list[] =
 {
  { SENSORS_LM78_PREFIX, lm78_features },
@@ -6223,5 +6281,6 @@
  { SENSORS_CORETEMP_PREFIX, coretemp_features },
  { SENSORS_DME1737_PREFIX, dme1737_features },
  { SENSORS_APPLESMC_PREFIX, applesmc_features },
+ { SENSORS_F75373_PREFIX, f75373_features },
  { 0 }
 };
diff -urN lm-sensors_org/lib/chips.h lm-sensors/lib/chips.h
--- lm-sensors_org/lib/chips.h	2007-06-17 15:34:32.000000000 +0200
+++ lm-sensors/lib/chips.h	2007-06-17 16:53:25.000000000 +0200
@@ -2312,4 +2312,28 @@
 #define SENSORS_APPLESMC_FAN_MAX(n)		(0x61 + (n)) /* R */
 #define SENSORS_APPLESMC_FAN_SAFE(n)		(0x81 + (n)) /* R */
 
+/* Fintek F75373 registers  */
+
+#define SENSORS_F75373_PREFIX "f75373"
+
+// voltage n from 0 to 3
+#define SENSORS_F75373_IN(nr)           (0x10 + (nr))
+#define SENSORS_F75373_IN_MAX(nr)       (0x20 + (nr) * 2 )
+#define SENSORS_F75373_IN_MIN(nr)       (0x21 + (nr) * 2 )
+
+// temp n from 0 to 1
+#define SENSORS_F75373_TEMP(nr)         (0x14 + (nr))
+#define SENSORS_F75373_TEMP_MAX(nr)     (0x28 + (nr) * 2 )
+#define SENSORS_F75373_TEMP_HYST(nr)    (0x29 + (nr) * 2 )
+
+// fan n from 0 to 1
+#define SENSORS_F75373_FAN(nr)          (0x16 + (nr) * 2 )
+#define SENSORS_F75373_FAN_MIN(nr)      (0x26 + (nr) * 2 )
+// FAN Full Speed Count Register Index 70h
+#define SENSORS_F75373_FAN_MAX(nr)      (0x70 + (nr) * 0x10 )
+
+// pwm n from 0 to 1
+#define SENSORS_F75373_PWM(nr)          (0x76 + (nr) * 0x10 )
+#define SENSORS_F75373_PWM_ENABLE(nr)   (0x7D + (nr) * 0x10 )
+
 #endif /* def LIB_SENSORS_CHIPS_H */
diff -urN lm-sensors_org/prog/sensors/chips.c lm-sensors/prog/sensors/chips.c
--- lm-sensors_org/prog/sensors/chips.c	2007-06-17 15:34:33.000000000 +0200
+++ lm-sensors/prog/sensors/chips.c	2007-06-17 16:29:50.000000000 +0200
@@ -6131,6 +6131,114 @@
 	}
 }
 
+static void print_f75373_in(const sensors_chip_name *name, int i)
+{
+  char *label;
+  double cur, min, max;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_IN(i), &label,
+                                  &valid) &&
+      !sensors_get_feature(*name, SENSORS_F75373_IN(i), &cur) &&
+      !sensors_get_feature(*name, SENSORS_F75373_IN_MAX(i), &max) &&
+      !sensors_get_feature(*name, SENSORS_F75373_IN_MIN(i), &min)) {
+    if (valid) {
+      print_label(label, 10);
+      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)  \n",
+             cur, min, max);
+    }
+  } else {
+    printf("ERROR: Can't get in%d data!\n", i);
+  }
+  free(label);
+}
+
+static void print_f75373_temp(const sensors_chip_name *name, int i)
+{
+  char *label;
+  double cur, max, alarm;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_TEMP(i), &label,
+                                   &valid) &&
+      !sensors_get_feature(*name, SENSORS_F75373_TEMP(i), &cur) &&
+      !sensors_get_feature(*name, SENSORS_F75373_TEMP_MAX(i), &max) &&
+      !sensors_get_feature(*name, SENSORS_F75373_TEMP_HYST(i), &alarm)
+      ) {
+    if (valid) {
+      print_label(label, 10);
+      print_temp_info(cur, max, 0, HYST , 0, 0);
+      printf("%s\n", alarm ? "ALARM" : "");
+    }
+  } else {
+    printf("ERROR: Can't get temp%d data!\n", i);
+  }
+  free(label);
+}
+
+static void print_f75373_fan(const sensors_chip_name *name, int i)
+{
+  char *label;
+  double cur, min;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_FAN(i), &label,
+                                   &valid) &&
+      !sensors_get_feature(*name, SENSORS_F75373_FAN(i), &cur) &&
+      !sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)
+     ){
+    if (valid) {
+      print_label(label, 10);
+      printf("%4.0f RPM  (min = %4.0f RPM)\n", 
+             cur, min);
+    }
+  } else {
+    printf("ERROR: Can't get fan%d data!\n", i);
+  }
+  free(label);
+}
+
+static void print_f75373_pwm(const sensors_chip_name *name, int i)
+{
+  char *label;
+  double cur, enable;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_PWM(i), &label,
+                                   &valid) &&
+      !sensors_get_feature(*name, SENSORS_F75373_PWM(i), &cur) &&
+      !sensors_get_feature(*name, SENSORS_F75373_PWM_ENABLE(i), &enable)) {
+    if (valid) {
+      print_label(label, 10);
+      printf("%4.0f      (enable = %1.0f)\n", cur, enable);
+    }
+  } else {
+    printf("ERROR: Can't get pwm%d data!\n", i);
+  }
+  free(label);
+}
+
+void print_f75373(const sensors_chip_name *name)
+{
+  int i;
+
+  for (i = 0; i < 4; i++) {
+    print_f75373_in(name, i);
+  }
+
+  for (i = 1; i < 3; i++) {
+    print_f75373_temp(name, i);
+  }
+
+  for (i = 1; i < 3; i++) {
+    print_f75373_fan(name, i);
+  }
+
+  for (i = 1; i < 3; i++) {
+    print_f75373_pwm(name, i);
+  }
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
diff -urN lm-sensors_org/prog/sensors/chips.h lm-sensors/prog/sensors/chips.h
--- lm-sensors_org/prog/sensors/chips.h	2007-06-17 15:34:33.000000000 +0200
+++ lm-sensors/prog/sensors/chips.h	2007-06-16 20:59:34.000000000 +0200
@@ -78,5 +78,6 @@
 extern void print_coretemp(const sensors_chip_name *name);
 extern void print_dme1737(const sensors_chip_name *name);
 extern void print_applesmc(const sensors_chip_name *name);
+extern void print_f75373(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -urN lm-sensors_org/prog/sensors/main.c lm-sensors/prog/sensors/main.c
--- lm-sensors_org/prog/sensors/main.c	2007-06-17 15:34:33.000000000 +0200
+++ lm-sensors/prog/sensors/main.c	2007-06-17 08:12:48.000000000 +0200
@@ -424,6 +424,7 @@
  	{ "coretemp", print_coretemp },
  	{ "dme1737", print_dme1737 },
 	{ "applesmc", print_applesmc },
+	{ "F75373", print_f75373 },
 	{ NULL, NULL }
 };
 

--0-173508737-1182185904=:12953
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0-173508737-1182185904=:12953--
