From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 09 Sep 2007 14:30:51 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070909163051.2f42709a.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The patch below adds support for the 2.6 thmc50 and adm1022 to the lmsensors.

Feel free to fix any shortcomings of the patch.

Regards,
Krzysztof

diff -urp lm-sensors/lib/chips.c lm-sensors.new/lib/chips.c
--- lm-sensors/lib/chips.c	2007-09-09 16:10:40.206761317 +0200
+++ lm-sensors.new/lib/chips.c	2007-09-09 16:25:37.105872685 +0200
@@ -2756,6 +2756,19 @@ static sensors_chip_feature thmc50_featu
                                          SENSORS_THMC50_REMOTE_TEMP, RW }, 
                                          THMC50_SYSCTL_REMOTE_TEMP, VALUE(1), 
                                          0 },
+    { { SENSORS_ADM1022_REMOTE_TEMP2, "remote_temp2", NOMAP, NOMAP, R }, 
+                                      ADM1022_SYSCTL_REMOTE_TEMP2, VALUE(3),
+                                      0, "temp3_input", 3 },
+    { { SENSORS_ADM1022_REMOTE_TEMP2_HYST, "remote_temp2_hyst", 
+                                         SENSORS_ADM1022_REMOTE_TEMP2, 
+                                         SENSORS_ADM1022_REMOTE_TEMP2, RW }, 
+                                         ADM1022_SYSCTL_REMOTE_TEMP2, VALUE(2), 
+                                         0, "temp3_min", 3 },
+    { { SENSORS_ADM1022_REMOTE_TEMP2_OVER, "remote2_temp_over", 
+                                         SENSORS_ADM1022_REMOTE_TEMP2, 
+                                         SENSORS_ADM1022_REMOTE_TEMP2, RW }, 
+                                         ADM1022_SYSCTL_REMOTE_TEMP2, VALUE(1), 
+                                         0, "temp3_max", 3 },
     { { SENSORS_THMC50_ANALOG_OUT, "analog output", NOMAP, NOMAP, RW }, 
                                    THMC50_SYSCTL_ANALOG_OUT, VALUE(1), 0,
                                    "pwm1", 0 },
diff -urp lm-sensors/lib/chips.h lm-sensors.new/lib/chips.h
--- lm-sensors/lib/chips.h	2007-09-09 16:10:40.258764281 +0200
+++ lm-sensors.new/lib/chips.h	2007-09-09 15:44:43.238034726 +0200
@@ -1191,6 +1191,9 @@
 #define SENSORS_THMC50_REMOTE_TEMP 54 /* R */
 #define SENSORS_THMC50_REMOTE_TEMP_HYST 55 /* RW */
 #define SENSORS_THMC50_REMOTE_TEMP_OVER 56 /* RW */
+#define SENSORS_ADM1022_REMOTE_TEMP2 57 /* R */
+#define SENSORS_ADM1022_REMOTE_TEMP2_HYST 58 /* RW */
+#define SENSORS_ADM1022_REMOTE_TEMP2_OVER 59 /* RW */
 #define SENSORS_THMC50_ANALOG_OUT 71 /* RW */
 #define SENSORS_THMC50_INTER 81 /* R */
 #define SENSORS_THMC50_INTER_MASK 82 /* RW */
diff -urp lm-sensors/prog/sensors/chips.c lm-sensors.new/prog/sensors/chips.c
--- lm-sensors/prog/sensors/chips.c	2007-09-09 16:10:49.851310930 +0200
+++ lm-sensors.new/prog/sensors/chips.c	2007-09-09 16:27:01.798699053 +0200
@@ -6255,6 +6255,100 @@ void print_f71882fg(const sensors_chip_n
     print_f71882fg_temp(name, i);
 }
 
+void print_thmc50(const sensors_chip_name *name)
+{
+  char *label;
+  double cur,hyst,over;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_TEMP,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_TEMP,&cur) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_TEMP_HYST,&hyst) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_TEMP_OVER,&over))  {
+    if (valid) {
+      print_label(label,14);
+      print_temp_info( cur, over, hyst, MINMAX, 0, 0);
+      printf("\n");
+    }
+  } else
+    printf("ERROR: Can't get temperature1 data!\n");
+  free(label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_REMOTE_TEMP,
+                                   &label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_REMOTE_TEMP,&cur) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_REMOTE_TEMP_HYST,&hyst) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_REMOTE_TEMP_OVER,&over))  {
+    if (valid) {
+      print_label(label,14);
+      print_temp_info( cur, over, hyst, MINMAX, 0, 0);
+      printf("\n");
+    }
+  } else
+    printf("ERROR: Can't get temperature2 data!\n");
+  free(label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_ADM1022_REMOTE_TEMP2,
+                                   &label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_ADM1022_REMOTE_TEMP2,&cur) &&
+      !sensors_get_feature(*name,SENSORS_ADM1022_REMOTE_TEMP2_HYST,&hyst) &&
+      !sensors_get_feature(*name,SENSORS_ADM1022_REMOTE_TEMP2_OVER,&over))  {
+    if (valid) {
+      print_label(label,14);
+      print_temp_info( cur, over, hyst, MINMAX, 0, 0);
+      printf("\n");
+    }
+  }
+  /* No error if files are missing as it will happen for original thmc50 */
+  free(label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_ANALOG_OUT,
+                                   &label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_ANALOG_OUT,&cur)) {
+    if (valid) {
+      print_label(label,14);
+      printf("%4.0f\n", cur);
+    }
+  } else
+    printf("ERROR: Can't get analog output data!\n");
+  free(label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_INTER,
+                                   &label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_INTER,&cur)) {
+    if (valid) {
+      print_label(label,14);
+      printf("%4.0f\n", cur);
+    }
+  }
+  /* No error if files are missing as it will happen with 2.6 kernels */
+  free(label);
+
+  if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_INTER_MASK,
+                                   &label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_THMC50_INTER_MASK,&cur)) {
+    if (valid) {
+      print_label(label,14);
+      printf("%4.0f\n", cur);
+    }
+  }
+  /* No error if files are missing as it will happen with 2.6 kernels */
+  free(label);
+
+  if (!strcmp(name->prefix,"thmc50")) {
+    if (!sensors_get_label_and_valid(*name,SENSORS_THMC50_DIE_CODE,
+                                     &label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_THMC50_DIE_CODE,&cur)) {
+      if (valid) {
+        print_label(label,14);
+        printf("%4.0f\n",cur);
+      }
+    }
+  /* No error if files are missing as it will happen with 2.6 kernels */
+    free(label);
+  }
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
diff -urp lm-sensors/prog/sensors/chips.h lm-sensors.new/prog/sensors/chips.h
--- lm-sensors/prog/sensors/chips.h	2007-09-09 16:10:49.871312069 +0200
+++ lm-sensors.new/prog/sensors/chips.h	2007-09-09 15:19:46.556743721 +0200
@@ -80,5 +80,6 @@ extern void print_coretemp(const sensors
 extern void print_dme1737(const sensors_chip_name *name);
 extern void print_applesmc(const sensors_chip_name *name);
 extern void print_f71882fg(const sensors_chip_name *name);
+extern void print_thmc50(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -urp lm-sensors/prog/sensors/main.c lm-sensors.new/prog/sensors/main.c
--- lm-sensors/prog/sensors/main.c	2007-09-09 16:10:49.819309105 +0200
+++ lm-sensors.new/prog/sensors/main.c	2007-09-09 15:34:52.712382587 +0200
@@ -427,6 +427,8 @@ static struct match matches[] = {
  	{ "sch311x", print_dme1737 },
 	{ "applesmc", print_applesmc },
 	{ "f71882fg", print_f71882fg },
+	{ "thmc50", print_thmc50 },
+	{ "adm1022", print_thmc50 },
 	{ NULL, NULL }
 };
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
