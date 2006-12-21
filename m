From: corentin.labbe@geomatys.fr (corentin.labbe)
Date: Thu, 21 Dec 2006 22:06:14 +0000
Subject: [lm-sensors] lm-sensors patch for adding adm1029 support
Message-Id: <458B0556.9030807@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

This is my patch for adding adm1029 chip support in user-space.

Labbe Corentin

lib/chips.h
--- ./original/lm-sensors-r4254-20061207/lib/chips.h    2006-11-12
14:17:32.000000000 +0100
+++ ./lm-sensors-r4254-20061207/lib/chips.h     2006-12-21
20:51:35.000000000 +0100
@@ -184,6 +184,29 @@
 #define SENSORS_ADM1021_ALARMS 81 /* R */
 #define SENSORS_ADM1021_DIE_CODE 90 /* R */

+/* ADM1029 chips */
+
+#define SENSORS_ADM1029_PREFIX "adm1029"
+#define SENSORS_ADM1029_TEMP1      51
+#define SENSORS_ADM1029_TEMP1_MAX      52
+#define SENSORS_ADM1029_TEMP1_MIN      53
+
+#define SENSORS_ADM1029_TEMP2      61
+#define SENSORS_ADM1029_TEMP2_MAX      62
+#define SENSORS_ADM1029_TEMP2_MIN      63
+
+#define SENSORS_ADM1029_TEMP3      71
+#define SENSORS_ADM1029_TEMP3_MAX      72
+#define SENSORS_ADM1029_TEMP3_MIN      73
+
+#define SENSORS_ADM1029_FAN1      81
+#define SENSORS_ADM1029_FAN1_MIN      82
+#define SENSORS_ADM1029_FAN1_DIV      83
+
+#define SENSORS_ADM1029_FAN2      91
+#define SENSORS_ADM1029_FAN2_MIN      92
+#define SENSORS_ADM1029_FAN2_DIV      93
+

 /* ADM1030 and ADM1031 chips */

lib/chips.C
--- ./original/lm-sensors-r4254-20061207/lib/chips.c    2006-11-12
14:17:32.000000000 +0100
+++ ./lm-sensors-r4254-20061207/lib/chips.c     2006-12-21
21:04:38.000000000 +0100
@@ -362,6 +362,75 @@
   };


+static sensors_chip_feature adm1029_features[] +  {
+       { SENSORS_ADM1029_TEMP1, "temp1",
+                               NOMAP, NOMAP,
+                               R, NOSYSCTL, VALUE(3), 3 },
+       { SENSORS_ADM1029_TEMP1_MAX, "temp1_max",
+                               SENSORS_ADM1029_TEMP1,
+                               SENSORS_ADM1029_TEMP1,
+                               RW, NOSYSCTL, VALUE(1), 3 },
+       { SENSORS_ADM1029_TEMP1_MIN, "temp1_min",
+                               SENSORS_ADM1029_TEMP1,
+                               SENSORS_ADM1029_TEMP1,
+                               RW, NOSYSCTL, VALUE(2), 3 },
+
+       { SENSORS_ADM1029_TEMP2, "temp2",
+                               NOMAP, NOMAP,
+                               R, NOSYSCTL, VALUE(3), 3 },
+       { SENSORS_ADM1029_TEMP2_MAX, "temp2_max",
+                               SENSORS_ADM1029_TEMP2,
+                               SENSORS_ADM1029_TEMP2,
+                               RW, NOSYSCTL, VALUE(1), 3 },
+       { SENSORS_ADM1029_TEMP2_MIN, "temp2_min",
+                               SENSORS_ADM1029_TEMP2,
+                               SENSORS_ADM1029_TEMP2,
+                               RW, NOSYSCTL, VALUE(2), 3 },
+
+       { SENSORS_ADM1029_TEMP3, "temp3",
+                               NOMAP, NOMAP,
+                               R, NOSYSCTL, VALUE(3), 3 },
+       { SENSORS_ADM1029_TEMP3_MAX, "temp3_max",
+                               SENSORS_ADM1029_TEMP3,
+                               SENSORS_ADM1029_TEMP3,
+                               RW, NOSYSCTL, VALUE(1), 3 },
+       { SENSORS_ADM1029_TEMP3_MIN, "temp3_min",
+                               SENSORS_ADM1029_TEMP3,
+                               SENSORS_ADM1029_TEMP3,
+                               RW, NOSYSCTL, VALUE(2), 3 },
+
+
+       { SENSORS_ADM1029_FAN1, "fan1",
+                               NOMAP, NOMAP,
+                               R, NOSYSCTL, VALUE(2), 0 },
+       { SENSORS_ADM1029_FAN1_MIN, "fan1_min",
+                               SENSORS_ADM1029_FAN1,
+                               SENSORS_ADM1029_FAN1,
+                               RW, NOSYSCTL, VALUE(1), 0 },
+       { SENSORS_ADM1029_FAN1_DIV, "fan1_div",
+                               SENSORS_ADM1029_FAN1,
+                               NOMAP,
+                               RW, NOSYSCTL, VALUE(1), 0 },
+
+       { SENSORS_ADM1029_FAN2, "fan2",
+                               NOMAP, NOMAP,
+                               R, NOSYSCTL, VALUE(2), 0 },
+       { SENSORS_ADM1029_FAN2_MIN, "fan2_min",
+                               SENSORS_ADM1029_FAN2,
+                               SENSORS_ADM1029_FAN2,
+                               RW, NOSYSCTL, VALUE(1), 0 },
+
+       { SENSORS_ADM1029_FAN2_DIV, "fan2_div",
+                               SENSORS_ADM1029_FAN2,
+                               NOMAP,
+                               RW, NOSYSCTL, VALUE(2), 0 },
+
+       { 0 }
+  };
+
+
+
 static sensors_chip_feature adm1030_features[]    {
     { SENSORS_ADM1031_TEMP1, "temp1",
@@ -6155,6 +6224,7 @@
  { SENSORS_MAX1619_PREFIX, max1619_features },
  { SENSORS_XEONTEMP_PREFIX, xeontemp_features },
  { SENSORS_MAX6650_PREFIX, max6650_features },
+ { SENSORS_ADM1029_PREFIX, adm1029_features },
  { SENSORS_ADM1030_PREFIX, adm1030_features },
  { SENSORS_ADM1031_PREFIX, adm1031_features },
  { SENSORS_LM93_PREFIX, lm93_features },
prog/sensors/chips.c
--- ./original/lm-sensors-r4254-20061207/prog/sensors/chips.c
2006-11-12 14:17:32.000000000 +0100
+++ ./lm-sensors-r4254-20061207/prog/sensors/chips.c    2006-12-21
21:14:21.000000000 +0100
@@ -5386,6 +5386,86 @@
   free(label);
 }

+
+void print_adm1029(const sensors_chip_name *name)
+{
+       char *label;
+       double cur, high, low,fan_div;
+       int valid;
+
+       if (!sensors_get_label_and_valid(*name, SENSORS_ADM1029_TEMP1,
+               &label, &valid)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP1, &cur)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP1_MAX, &high)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP1_MIN, &low)) {
+               if (valid) {
+                       print_label(label, 10);
+                       print_temp_info(cur, high, low, MINMAX, 0, 0);
+                       printf("\n");
+               }
+       } else
+               printf("ERROR: Can't get local temperature data!\n");
+       free(label);
+
+       if (!sensors_get_label_and_valid(*name, SENSORS_ADM1029_TEMP2,
+               &label, &valid)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP2, &cur)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP2_MAX, &high)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP2_MIN, &low)) {
+               if (valid) {
+                       print_label(label, 10);
+                       print_temp_info(cur, high, low, MINMAX, 0, 0);
+                       printf("\n");
+                       }
+       } else
+               printf("ERROR: Can't get remote1 temperature data!\n");
+       free(label);
+
+       if (!sensors_get_label_and_valid(*name, SENSORS_ADM1029_TEMP3,
+               &label, &valid)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP3, &cur)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP3_MAX, &high)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_TEMP3_MIN, &low)) {
+               if (valid) {
+                       print_label(label, 10);
+                       print_temp_info(cur, high, low, MINMAX, 0, 0);
+                       printf("\n");
+               }
+       } else
+               printf("ERROR: Can't get remote2 temperature data!\n");
+       free(label);
+
+       if (!sensors_get_label_and_valid(*name, SENSORS_ADM1029_FAN1,
+               &label, &valid)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN1, &cur)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN1_MIN, &low)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN1_DIV,
&fan_div)) {
+               if (valid) {
+                       print_label(label, 10);
+                       printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)\n"
+                       ,cur, low, fan_div);
+               }
+       } else
+               printf("ERROR: Can't get fan1 data!\n");
+       free(label);
+
+       if (!sensors_get_label_and_valid(*name, SENSORS_ADM1029_FAN2,
+               &label, &valid)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN2, &cur)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN2_MIN, &low)
+       && !sensors_get_feature(*name, SENSORS_ADM1029_FAN2_DIV,
&fan_div)) {
+               if (valid) {
+                       print_label(label, 10);
+                       printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)\n"
+                       ,cur, low , fan_div );
+               }
+       } else
+               printf("ERROR: Can't get fan2 data!\n");
+       free(label);
+
+}
+
+
 void print_lm63(const sensors_chip_name *name)
 {
   char *label;
prog/sensors/chips.h
--- ./original/lm-sensors-r4254-20061207/prog/sensors/chips.h
2006-10-15 21:26:10.000000000 +0200
+++ ./lm-sensors-r4254-20061207/prog/sensors/chips.h    2006-12-09
23:47:10.000000000 +0100
@@ -72,6 +72,7 @@
 extern void print_xeontemp(const sensors_chip_name *name);
 extern void print_max6650(const sensors_chip_name *name);
 extern void print_adm1031(const sensors_chip_name *name);
+extern void print_adm1029(const sensors_chip_name *name);
 extern void print_smsc47b397(const sensors_chip_name *name);
 extern void print_f71805f(const sensors_chip_name *name);
 extern void print_abituguru(const sensors_chip_name *name);
prog/sensors/main.c
--- ./original/lm-sensors-r4254-20061207/prog/sensors/main.c
2006-11-12 14:17:32.000000000 +0100
+++ ./lm-sensors-r4254-20061207/prog/sensors/main.c     2006-12-10
14:57:47.000000000 +0100
@@ -411,6 +411,7 @@
        { "xeontemp", print_xeontemp },
        { "max6650", print_max6650 },
        { "asb100", print_asb100 },
+       { "adm1029", print_adm1029 },
        { "adm1030", print_adm1031 },
        { "adm1031", print_adm1031 },
        { "lm93", print_lm93 },


