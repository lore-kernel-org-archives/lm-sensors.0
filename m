From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Aug 2007 13:14:33 +0000
Subject: [lm-sensors] [PATCH 3/3] sensors3: Optimize command line handling
Message-Id: <20070825151433.0fab41fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks to the new prototype of sensors_get_detected_chips, we no
longer need to build an array from the chip names passed on the
command line. Instead, we can process them one after the other
directly. This saves some memory and allows for minor code cleanups.

---
 prog/sensors/main.c |   86 +++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

--- lm-sensors-3.orig/prog/sensors/main.c	2007-08-25 13:53:15.000000000 +0200
+++ lm-sensors-3/prog/sensors/main.c	2007-08-25 14:19:45.000000000 +0200
@@ -48,12 +48,9 @@ static void print_long_help(void);
 static void print_version(void);
 static void do_a_print(const sensors_chip_name *name);
 static int do_a_set(const sensors_chip_name *name);
-static int do_the_real_work(int *error);
+static int do_the_real_work(const sensors_chip_name *chip, int *error);
 static const char *sprintf_chip_name(const sensors_chip_name *name);
 
-#define CHIPS_MAX 20
-sensors_chip_name chips[CHIPS_MAX];
-int chips_count=0;
 int do_sets, do_raw, fahrenheit, hide_adapter;
 
 char degstr[5]; /* store the correct string to print degrees */
@@ -200,23 +197,6 @@ int main (int argc, char *argv[])
     }
   }
 
-  if (optind = argc) {
-    chips[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
-    chips[0].bus.type = SENSORS_BUS_TYPE_ANY;
-    chips[0].bus.nr = SENSORS_BUS_NR_ANY;
-    chips[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
-    chips_count = 1;
-  } else 
-    for(i = optind; i < argc; i++) 
-      if ((res = sensors_parse_chip_name(argv[i],chips+chips_count))) {
-        fprintf(stderr,"Parse error in chip name `%s'\n",argv[i]);
-        print_short_help();
-        exit(1);
-      } else if (++chips_count = CHIPS_MAX) {
-        fprintf(stderr,"Too many chips on command line!\n");
-        exit(1);
-      }
-
   open_config_file(config_file_name);
   if ((res = sensors_init(config_file))) {
     fprintf(stderr, "sensors_init: %s\n", sensors_strerror(res));
@@ -227,40 +207,54 @@ int main (int argc, char *argv[])
   /* build the degrees string */
   set_degstr();
 
-  if(do_the_real_work(&error)) {
-    sensors_cleanup();
-    exit(error);
+  if (optind = argc) { /* No chip name on command line */
+    if (!do_the_real_work(NULL, &error)) {
+      fprintf(stderr,
+              "No sensors found!\n"
+              "Make sure you loaded all the kernel drivers you need.\n"
+              "Try sensors-detect to find out which these are.\n");
+      error = 1;
+    }
   } else {
-    if (optind = argc) /* No chip name on command line */
-	    fprintf(stderr,
-	            "No sensors found!\n"
-	            "Make sure you loaded all the kernel drivers you need.\n"
-	            "Try sensors-detect to find out which these are.\n");
-    else
-	    fprintf(stderr,"Specified sensor(s) not found!\n");
-    sensors_cleanup();
-    exit(1);
+    int cnt = 0;
+    sensors_chip_name chip;
+
+    for (i = optind; i < argc; i++) {
+      if (sensors_parse_chip_name(argv[i], &chip)) {
+        fprintf(stderr, "Parse error in chip name `%s'\n", argv[i]);
+        print_short_help();
+        error = 1;
+        goto exit;
+      }
+      cnt += do_the_real_work(&chip, &error);
+    }
+
+    if (!cnt) {
+      fprintf(stderr, "Specified sensor(s) not found!\n");
+      error = 1;
+    }
   }
+
+exit:
+  sensors_cleanup();
+  exit(res);
 }
 
 /* returns number of chips found */
-int do_the_real_work(int *error)
+int do_the_real_work(const sensors_chip_name *match, int *error)
 {
   const sensors_chip_name *chip;
-  int chip_nr,i;
+  int chip_nr;
   int cnt = 0;
 
-  *error = 0;
-  for (i = 0; i < chips_count; i++) {
-    chip_nr = 0;
-    while ((chip = sensors_get_detected_chips(&chips[i], &chip_nr))) {
-      if (do_sets) {
-        if (do_a_set(chip))
-          *error = 1;
-      } else
-        do_a_print(chip);
-      cnt++;
-    }
+  chip_nr = 0;
+  while ((chip = sensors_get_detected_chips(match, &chip_nr))) {
+    if (do_sets) {
+      if (do_a_set(chip))
+        *error = 1;
+    } else
+      do_a_print(chip);
+    cnt++;
   }
   return cnt;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
