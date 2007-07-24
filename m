From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 11:17:23 +0000
Subject: [lm-sensors] [PATCH 1/2] libsensors4: Make
Message-Id: <20070724131723.133f54e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't export sensors_chip_name_has_wildcards(). I don't know of any
application using it, and I can't think of any use case for it outside
of libsensors. I'm not even sure if the inside calls are all legitimate.

Hans, can you please check if gnome sensors-applet or gkrellm use this
function?

---
 lib/access.c     |    2 +-
 lib/libsensors.3 |    6 ------
 lib/sensors.h    |    5 -----
 3 files changed, 1 insertion(+), 12 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-07-24 10:21:36.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-07-24 10:32:00.000000000 +0200
@@ -132,7 +132,7 @@ sensors_lookup_feature_name(const sensor
 /* Check whether the chip name is an 'absolute' name, which can only match
    one chip, or whether it has wildcards. Returns 0 if it is absolute, 1
    if there are wildcards. */
-int sensors_chip_name_has_wildcards(sensors_chip_name chip)
+static int sensors_chip_name_has_wildcards(sensors_chip_name chip)
 {
 	if ((chip.prefix = SENSORS_CHIP_NAME_PREFIX_ANY) ||
 	    (chip.bus = SENSORS_CHIP_NAME_BUS_ANY) ||
--- lm-sensors-3.orig/lib/libsensors.3	2007-07-24 10:18:57.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-07-24 10:32:15.000000000 +0200
@@ -37,7 +37,6 @@ libsensors \- publicly accessible functi
                             \fBsensors_chip_name *res);\fP
 .B int sensors_match_chip(sensors_chip_name chip1, 
                        \fBsensors_chip_name chip2);\fP
-.B int sensors_chip_name_has_wildcards(sensors_chip_name chip);
 .B const char *sensors_get_adapter_name(int bus_nr);
 .B int sensors_get_label(sensors_chip_name name, int feature, 
                       \fBchar **result);\fP
@@ -72,11 +71,6 @@ Parse a chip name to the internal repres
 .br
 Compare two chips name descriptions, to see whether they could match. Return 0 if it does not match, return 1 if it does match.
 
-\fBint sensors_chip_name_has_wildcards
-    (sensors_chip_name chip);\fP
-.br
-Check whether the chip name is an 'absolute' name, which can only match one chip, or whether it has wildcards. Returns 0 if it is absolute, 1 if there are wildcards.
-
 .B const char *sensors_get_adapter_name(int bus_nr);
 .br
 This function returns the adapter name of a bus number, as used within the
--- lm-sensors-3.orig/lib/sensors.h	2007-07-24 10:20:10.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-07-24 10:32:03.000000000 +0200
@@ -66,11 +66,6 @@ extern int sensors_parse_chip_name(const
 extern int sensors_match_chip(sensors_chip_name chip1, 
                               sensors_chip_name chip2);
 
-/* Check whether the chip name is an 'absolute' name, which can only match
-   one chip, or whether it has wildcards. Returns 0 if it is absolute, 1
-   if there are wildcards. */
-extern int sensors_chip_name_has_wildcards(sensors_chip_name chip);
-
 /* This function returns the adapter name of a bus number,
    as used within the sensors_chip_name structure. If it could not be found, 
    it returns NULL */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
