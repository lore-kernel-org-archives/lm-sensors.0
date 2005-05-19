From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: two patches
Message-Id: <20020715003408.7c5513a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

Here are two patches for lm_sensors2 I wrote in the train two hours ago.

The first one fixes a (maybe dangerous) bug in libsensors where
read-only features could be written and write-only features could be
read.

The second one simply (re)indents the eeprom section of prog/sensors. I
plan to make modifications on this part soon, and it was hardly readable
the way it was before.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -ruN lm_sensors2/lib/access.c lm_sensors2-and/lib/access.c
--- lm_sensors2/lib/access.c	Fri Dec 24 23:44:40 1999
+++ lm_sensors2-and/lib/access.c	Sun Jul 14 22:06:34 2002
@@ -222,7 +222,7 @@
                    sensors_lookup_feature_nr(name.prefix,
                                              main_feature->compute_mapping)))
     return -SENSORS_ERR_NO_ENTRY;
-  if (! (main_feature->mode && SENSORS_MODE_R))
+  if (! (main_feature->mode & SENSORS_MODE_R))
     return -SENSORS_ERR_ACCESS;
   for (chip = NULL; !expr && (chip = sensors_for_all_config_chips(name,chip));)
     for (i = 0; !final_expr && (i < chip->computes_count); i++) {
@@ -265,7 +265,7 @@
                    sensors_lookup_feature_nr(name.prefix,
                                              main_feature->compute_mapping)))
     return -SENSORS_ERR_NO_ENTRY;
-  if (! (main_feature->mode && SENSORS_MODE_W))
+  if (! (main_feature->mode & SENSORS_MODE_W))
     return -SENSORS_ERR_ACCESS;
   for (chip = NULL; !expr && (chip = sensors_for_all_config_chips(name,chip));)
     for (i = 0; !final_expr && (i < chip->computes_count); i++)
-------------- next part --------------
diff -ruN lm_sensors2/prog/sensors/chips.c lm_sensors2-indent-eeprom/prog/sensors/chips.c
--- lm_sensors2/prog/sensors/chips.c	Fri Jul 12 13:08:06 2002
+++ lm_sensors2-indent-eeprom/prog/sensors/chips.c	Sun Jul 14 22:14:30 2002
@@ -2423,46 +2423,45 @@
 
 void print_eeprom(const sensors_chip_name *name)
 {
-	char  *label = NULL;
-	double a, b, c, d;
-	int    valid, i;
+  char *label = NULL;
+  double a, b, c, d;
+  int valid, i;
 
-   if (!sensors_get_label_and_valid(*name, SENSORS_EEPROM_TYPE, &label,&valid) &&
-       !sensors_get_feature(*name, SENSORS_EEPROM_TYPE, &a)) {
-      if (valid) {
-	if(((int) a) = 4) {
-           print_label(label, 24);
-	   printf("SDRAM DIMM SPD\n");
-	} else if(((int) a) = 7) {
-           print_label(label, 24);
-	   printf("DDR SDRAM DIMM SPD\n");
-	} else
-	      return;
-      }
-   } else
-      printf("ERROR: data 1\n");
-   free_the_label(&label);
+  if (!sensors_get_label_and_valid(*name, SENSORS_EEPROM_TYPE, &label,&valid) &&
+      !sensors_get_feature(*name, SENSORS_EEPROM_TYPE, &a)) {
+    if (valid) {
+      if(((int) a) = 4) {
+        print_label(label, 24);
+        printf("SDRAM DIMM SPD\n");
+      } else if(((int) a) = 7) {
+        print_label(label, 24);
+        printf("DDR SDRAM DIMM SPD\n");
+      } else
+        return;
+    }
+  } else
+    printf("ERROR: data 1\n");
+  free_the_label(&label);
 
-   if (!sensors_get_label_and_valid(*name, SENSORS_EEPROM_ROWADDR, &label,&valid) &&
-       !sensors_get_feature(*name, SENSORS_EEPROM_ROWADDR, &a) &&
-       !sensors_get_feature(*name, SENSORS_EEPROM_COLADDR, &b) &&
-       !sensors_get_feature(*name, SENSORS_EEPROM_NUMROWS, &c) &&
-       !sensors_get_feature(*name, SENSORS_EEPROM_BANKS, &d)) {
-      if (valid) {
-         print_label(label, 24);
-	 i = (((int) a) & 0x0f) + (((int) b) & 0x0f) - 17;
-	 if(i > 0 && i <= 12 && c <= 8 && d <= 8)
-	         printf("%d\n", (1 << i) * ((int) c) * ((int) d));
-	 else
-{
-	         printf("invalid\n");
-printf("%d %d %d %d\n", (int) a, (int) b, (int) c, (int) d);
-}
+  if (!sensors_get_label_and_valid(*name, SENSORS_EEPROM_ROWADDR, &label,&valid) &&
+      !sensors_get_feature(*name, SENSORS_EEPROM_ROWADDR, &a) &&
+      !sensors_get_feature(*name, SENSORS_EEPROM_COLADDR, &b) &&
+      !sensors_get_feature(*name, SENSORS_EEPROM_NUMROWS, &c) &&
+      !sensors_get_feature(*name, SENSORS_EEPROM_BANKS, &d)) {
+    if (valid) {
+      print_label(label, 24);
+      i = (((int) a) & 0x0f) + (((int) b) & 0x0f) - 17;
+      if(i > 0 && i <= 12 && c <= 8 && d <= 8)
+        printf("%d\n", (1 << i) * ((int) c) * ((int) d));
+      else
+      {
+        printf("invalid\n");
+        printf("%d %d %d %d\n", (int) a, (int) b, (int) c, (int) d);
       }
-   } else
-      printf("ERROR: data 2\n");
-   free_the_label(&label);
-
+    }
+  } else
+    printf("ERROR: data 2\n");
+  free_the_label(&label);
 }
 
 
