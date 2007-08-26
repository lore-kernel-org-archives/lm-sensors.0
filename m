From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 26 Aug 2007 07:20:17 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] libsensors4: New prototype for
Message-Id: <20070826092017.1f9235ec@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070825150259.0a936215@hyperion.delvare>
In-Reply-To: <20070825150259.0a936215@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 25 Aug 2007 19:18:19 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Add a parameter to sensors_get_detected_chips(), to optionally let the
> > caller select which subset of chips it wants. This is slightly better
> > size-wise than letting all applications do the filtering by themselves.
> > 
> > This will change the way the command line parameters of "sensors" are
> > interpreted. Beforehand, the chips were always returned in the order
> > in which they were listed by the library. Also, each chip could be listed
> > only once. From now on, the chips will be listed in the order in which
> > they are passed on the command line, which I think makes more sense. A
> > side effect is that chips can be listed more than once, if that's what
> > the user asks for. Not very useful though.
> > 
> > This change makes it possible to make sensors_match_chip() internal
> > to the library. Filtering the list of chips returned by
> > sensors_get_detected_chips() was the last known external use for this
> > function.
> > 
> > This patch looks much bigger than it really is, but the largest part is
> > really only code reindentation.
> >
> 
> Yes, making it harder to review, anyways reviewed and it looks good.
> 
> Maybe next time when there is lot of indentation changes include 2 patches, the 
> real one and one made with diff -uBb, the second one will then only show the 
> real changes.

Yes, good idea.

Here's the result for this one patch:

Index: lm-sensors-3/lib/access.c
=================================--- lm-sensors-3.orig/lib/access.c	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-08-26 09:13:45.000000000 +0200
@@ -303,13 +303,17 @@
 	return 0;
 }
 
-const sensors_chip_name *sensors_get_detected_chips(int *nr)
+const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+						    *match, int *nr)
 {
 	const sensors_chip_name *res;
-	res = (*nr >= sensors_proc_chips_count ?
-			NULL : &sensors_proc_chips[*nr].chip);
-	(*nr)++;
+
+	while (*nr < sensors_proc_chips_count) {
+		res = &sensors_proc_chips[(*nr)++].chip;
+		if (!match || sensors_match_chip(res, match))
 	return res;
+	}
+	return NULL;
 }
 
 const char *sensors_get_adapter_name(const sensors_bus_id *bus)
@@ -480,10 +484,9 @@
 	const sensors_chip_name *found_name;
 	int res = 0;
 
-	for (nr = 0; (found_name = sensors_get_detected_chips(&nr));)
-		if (sensors_match_chip(name, found_name)) {
+	for (nr = 0; (found_name = sensors_get_detected_chips(name, &nr));) {
 			this_res = sensors_do_this_chip_sets(found_name);
-			if (!res)
+		if (this_res)
 				res = this_res;
 		}
 	return res;
Index: lm-sensors-3/lib/libsensors.3
=================================--- lm-sensors-3.orig/lib/libsensors.3	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-08-26 09:13:45.000000000 +0200
@@ -44,7 +44,8 @@
 .B int sensors_set_value(const sensors_chip_name *name, int feature,
                       \fBdouble value);\fP
 .B int sensors_do_chip_sets(const sensors_chip_name *name);
-.B const sensors_chip_name *sensors_get_detected_chips(int *nr);
+.B const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+                                                    \fB*match, int *nr);\fP
 .B const sensors_feature_data *sensors_get_all_features 
              \fB(const sensors_chip_name *name, int *nr);\fP
 .B const char *libsensors_version;
@@ -98,10 +99,14 @@
 .br
 Execute all set statements for this particular chip. The chip may contain wildcards!  This function will return 0 on success, and <0 on failure.
 
-\fBconst sensors_chip_name *sensors_get_detected_chips
-                        (int *nr);\fP
+\fBconst sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+                                                    *match, int *nr);\fP
 .br
-This function returns all detected chips, one by one. To start at the beginning of the list, use 0 for nr; NULL is returned if we are at the end of the list. Do not try to change these chip names, as they point to internal structures! Do not use nr for anything else.
+This function returns all detected chips that match a given chip name,
+one by one. If no chip name is provided, all detected chips are returned.
+To start at the beginning of the list, use 0 for nr; NULL is returned if
+we are at the end of the list. Do not try to change these chip names, as
+they point to internal structures!
 
 This structure is used when you want to get all features of a specific chip.
 .br
Index: lm-sensors-3/lib/sensors.h
=================================--- lm-sensors-3.orig/lib/sensors.h	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-26 09:13:45.000000000 +0200
@@ -109,11 +109,13 @@
    wildcards!  This function will return 0 on success, and <0 on failure. */
 int sensors_do_chip_sets(const sensors_chip_name *name);
 
-/* This function returns all detected chips, one by one. To start at the
-   beginning of the list, use 0 for nr; NULL is returned if we are
-   at the end of the list. Do not try to change these chip names, as
-   they point to internal structures! Do not use nr for anything else. */
-const sensors_chip_name *sensors_get_detected_chips(int *nr);
+/* This function returns all detected chips that match a given chip name,
+   one by one. If no chip name is provided, all detected chips are returned.
+   To start at the beginning of the list, use 0 for nr; NULL is returned if
+   we are at the end of the list. Do not try to change these chip names, as
+   they point to internal structures! */
+const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name
+						    *match, int *nr);
 
 /* These defines are used in the mode field of sensors_feature_data */
 #define SENSORS_MODE_R 1
Index: lm-sensors-3/prog/sensors/main.c
=================================--- lm-sensors-3.orig/prog/sensors/main.c	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/prog/sensors/main.c	2007-08-26 09:13:45.000000000 +0200
@@ -251,18 +251,18 @@
   int cnt = 0;
 
   *error = 0;
-  for (chip_nr = 0; (chip = sensors_get_detected_chips(&chip_nr));)
-    for(i = 0; i < chips_count; i++)
-      if (sensors_match_chip(chip, &chips[i])) {
-        if(do_sets) {
+  for (i = 0; i < chips_count; i++) {
+    chip_nr = 0;
+    while ((chip = sensors_get_detected_chips(&chips[i], &chip_nr))) {
+      if (do_sets) {
           if (do_a_set(chip))
             *error = 1;
         } else
           do_a_print(chip);
-        i = chips_count;
 	cnt++;
       }
-   return(cnt);
+  }
+  return cnt;
 }
 
 /* returns 1 on error */
Index: lm-sensors-3/prog/sensord/rrd.c
=================================--- lm-sensors-3.orig/prog/sensord/rrd.c	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/prog/sensord/rrd.c	2007-08-25 15:19:49.000000000 +0200
@@ -139,9 +139,8 @@
   const sensors_chip_name *chip;
   int i = 0, j, ret = 0, num = 0;
 
-  while ((ret = 0) && ((chip = sensors_get_detected_chips (&i)) != NULL)) {
     for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
-      if (sensors_match_chip (chip, &chipNames[j])) {
+    while ((ret = 0) && ((chip = sensors_get_detected_chips (&chipNames[j], &i)) != NULL)) {
         int index0, subindex, chipindex = -1;
         for (index0 = 0; knownChips[index0]; ++ index0)
           for (subindex = 0; knownChips[index0]->names[subindex]; ++ subindex)
@@ -177,7 +176,6 @@
         }
       }
     }
-  }
 
   return ret;
 }
Index: lm-sensors-3/prog/sensord/sense.c
=================================--- lm-sensors-3.orig/prog/sensord/sense.c	2007-08-25 15:00:11.000000000 +0200
+++ lm-sensors-3/prog/sensord/sense.c	2007-08-25 15:19:49.000000000 +0200
@@ -238,13 +238,11 @@
   const sensors_chip_name *chip;
   int i = 0, j, ret = 0;
 
-  while ((ret = 0) && ((chip = sensors_get_detected_chips (&i)) != NULL)) {
     for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
-      if (sensors_match_chip (chip, &chipNames[j])) {
+    while ((ret = 0) && ((chip = sensors_get_detected_chips (&chipNames[j], &i)) != NULL)) {
         ret = doChip (chip, action);
       }
     }
-  }
 
   return ret;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
