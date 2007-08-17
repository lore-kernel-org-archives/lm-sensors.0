From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Aug 2007 15:21:23 +0000
Subject: [lm-sensors] [PATCH 3/4] libsensors4: Fix corner case bug in
Message-Id: <20070817172123.3823d3d8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Contrary to what the comment says, sensors_proc_bus_count may be a
perfectly valid bus number. We need to use a different value for
chip configuration entries we want to ignore.

---
 lib/data.c    |    8 ++++----
 lib/sensors.h |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

--- lm-sensors-3.orig/lib/data.c	2007-08-17 10:53:33.000000000 +0200
+++ lm-sensors-3/lib/data.c	2007-08-17 10:57:46.000000000 +0200
@@ -192,7 +192,7 @@ int sensors_substitute_chip(sensors_chip
 
 	if (i = sensors_config_busses_count) {
 		sensors_parse_error("Undeclared bus id referenced", lineno);
-		name->bus.nr = sensors_proc_bus_count;
+		name->bus.nr = SENSORS_BUS_NR_IGNORE;
 		return -SENSORS_ERR_BUS_NAME;
 	}
 
@@ -205,9 +205,9 @@ int sensors_substitute_chip(sensors_chip
 		}
 	}
 
-	/* We did not find anything. sensors_proc_bus_count is not
-	   a valid bus number, so it will never be matched. Good. */
-	name->bus.nr = sensors_proc_bus_count;
+	/* We did not find a matching bus name, simply ignore this chip
+	   config entry. */
+	name->bus.nr = SENSORS_BUS_NR_IGNORE;
 	return 0;
 }
 
--- lm-sensors-3.orig/lib/sensors.h	2007-08-17 09:24:35.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-17 10:57:46.000000000 +0200
@@ -34,6 +34,7 @@
 #define SENSORS_BUS_TYPE_ISA	1
 #define SENSORS_BUS_TYPE_PCI	2
 #define SENSORS_BUS_NR_ANY	(-1)
+#define SENSORS_BUS_NR_IGNORE	(-2)
 
 #ifdef __cplusplus
 extern "C" {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
