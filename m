From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 11:20:28 +0000
Subject: [lm-sensors] [PATCH 2/2] libsensors4: Delete sensors_do_all_sets()
Message-Id: <20070724132028.09132bbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Delete sensors_do_all_sets(). I couldn't find any application using it,
and sensors_do_chip_sets() can be used instead if really needed.

Hans, can you please check if gnome sensors-applet or gkrellm use this
function?

---
 lib/access.c     |   12 ------------
 lib/libsensors.3 |    5 -----
 lib/sensors.h    |    4 ----
 3 files changed, 21 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-24 10:32:00.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-24 11:57:37.000000000 +0200
@@ -483,18 +483,6 @@ int sensors_do_chip_sets(sensors_chip_na
 	return res;
 }
 
-/* Execute all set statements for all detected chips. This is the same as
-   calling sensors_do_chip_sets with an all wildcards chip name */
-int sensors_do_all_sets(void)
-{
-	static const sensors_chip_name name = {
-		.prefix	= SENSORS_CHIP_NAME_PREFIX_ANY,
-		.bus	= SENSORS_CHIP_NAME_BUS_ANY,
-		.addr	= SENSORS_CHIP_NAME_ADDR_ANY,
-	};
-	return sensors_do_chip_sets(name);
-}
-
 /* Static mappings for use by sensors_feature_get_type() */
 struct feature_subtype_match
 {
--- lm-sensors-3.orig/lib/libsensors.3	2007-07-24 10:32:15.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-07-24 11:58:01.000000000 +0200
@@ -45,7 +45,6 @@ libsensors \- publicly accessible functi
 .B int sensors_set_feature(sensors_chip_name name, int feature,
                         \fBdouble value);\fP
 .B int sensors_do_chip_sets(sensors_chip_name name);
-.B extern int sensors_do_all_sets(void);
 .B const sensors_chip_name *sensors_get_detected_chips(int *nr);
 .B const sensors_feature_data *sensors_get_all_features 
              \fB(sensors_chip_name name, int *nr);\fP
@@ -95,10 +94,6 @@ Set the value of a feature of a certain 
 .br
 Execute all set statements for this particular chip. The chip may contain wildcards!  This function will return 0 on success, and <0 on failure.
 
-.B int sensors_do_all_sets(void);
-.br
-Execute all set statements for all detected chips. This is the same as calling sensors_do_chip_sets with an all wildcards chip name
-
 \fBconst sensors_chip_name *sensors_get_detected_chips
                         (int *nr);\fP
 .br
--- lm-sensors-3.orig/lib/sensors.h	2007-07-24 10:32:03.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-07-24 11:58:10.000000000 +0200
@@ -94,10 +94,6 @@ extern int sensors_set_feature(sensors_c
    wildcards!  This function will return 0 on success, and <0 on failure. */
 extern int sensors_do_chip_sets(sensors_chip_name name);
 
-/* Execute all set statements for all detected chips. This is the same as
-   calling sensors_do_chip_sets with an all wildcards chip name */
-extern int sensors_do_all_sets(void);
-
 /* This function returns all detected chips, one by one. To start at the
    beginning of the list, use 0 for nr; NULL is returned if we are
    at the end of the list. Do not try to change these chip names, as 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
