From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Aug 2007 13:07:46 +0000
Subject: [lm-sensors] [PATCH 2/3] libsensors4: Make sensors_match_chip()
Message-Id: <20070825150746.5ca3f95e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make sensors_match_chip internal to libsensors. It is no longer used by
applications in practice.

---
 lib/access.c     |    2 +-
 lib/libsensors.3 |    7 -------
 lib/sensors.h    |    5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-08-19 20:34:35.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-08-19 20:47:49.000000000 +0200
@@ -34,7 +34,7 @@ static int sensors_eval_expr(const senso
 
 /* Compare two chips name descriptions, to see whether they could match.
    Return 0 if it does not match, return 1 if it does match. */
-int sensors_match_chip(const sensors_chip_name *chip1,
+static int sensors_match_chip(const sensors_chip_name *chip1,
 		       const sensors_chip_name *chip2)
 {
 	if ((chip1->prefix != SENSORS_CHIP_NAME_PREFIX_ANY) &&
--- lm-sensors-3.orig/lib/libsensors.3	2007-08-19 20:37:13.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-08-19 20:48:06.000000000 +0200
@@ -35,8 +35,6 @@ libsensors \- publicly accessible functi
 .B void sensors_cleanup(void);
 .B int sensors_parse_chip_name(const char *orig_name,
                             \fBsensors_chip_name *res);\fP
-.B int sensors_match_chip(const sensors_chip_name *chip1,
-                       \fBconst sensors_chip_name *chip2);\fP
 .B const char *sensors_get_adapter_name(int bus_nr);
 .B char *sensors_get_label(const sensors_chip_name *name, int feature);\fP
 .B int sensors_get_value(const sensors_chip_name *name, int feature,
@@ -68,11 +66,6 @@ Clean-up function: You can't access anyt
 .br
 Parse a chip name to the internal representation. Return 0 on succes, <0 on error.
 
-\fBint sensors_match_chip(const sensors_chip_name *chip1,
-                       const sensors_chip_name *chip2);\fP
-.br
-Compare two chips name descriptions, to see whether they could match. Return 0 if it does not match, return 1 if it does match.
-
 .B const char *sensors_get_adapter_name(int bus_nr);
 .br
 This function returns the adapter name of a bus number, as used within the
--- lm-sensors-3.orig/lib/sensors.h	2007-08-19 20:37:29.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-19 20:48:14.000000000 +0200
@@ -77,11 +77,6 @@ int sensors_parse_chip_name(const char *
 int sensors_snprintf_chip_name(char *str, size_t size,
 			       const sensors_chip_name *chip);
 
-/* Compare two chips name descriptions, to see whether they could match.
-   Return 0 if it does not match, return 1 if it does match. */
-int sensors_match_chip(const sensors_chip_name *chip1,
-		       const sensors_chip_name *chip2);
-
 /* This function returns the adapter name of a bus,
    as used within the sensors_chip_name structure. If it could not be found,
    it returns NULL */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
