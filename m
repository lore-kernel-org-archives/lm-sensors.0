From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:04:11 +0000
Subject: [lm-sensors] [PATCH v2 5/7] sensord: Refactoring of loadConfig()
Message-Id: <20090511160411.GF17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch does some refactoring of the loadConfig()
function.

* Simplifying the conditions makes code flow clearer and eliminates
long lines (> 80 chars).
* Removed useless stat() call.
* Return -1 in error case, instead of several positive values (never defined).

Changes in v2:

Blank line before the first #include.
Fix typo.
Bring back logging (reload configuration).
Consistent error messages.
Drop reading configuration from stdin.
Fix logging (if fopen() fails).
Cleanup sensors before reloading configuration.
Fix compile warning.
Don't print error value if reloadLib() fails.
---

 lib.c     |   74 +++++++++++++++++++++++++++++++-------------------------------
 sensord.c |    4 +--
 2 files changed, 40 insertions(+), 38 deletions(-)

Index: quilt-sensors/prog/sensord/lib.c
=================================--- quilt-sensors.orig/prog/sensord/lib.c	2009-04-26 22:11:03.000000000 +0200
+++ quilt-sensors/prog/sensord/lib.c	2009-04-26 22:13:09.000000000 +0200
@@ -21,6 +21,7 @@
  * MA 02110-1301 USA.
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -34,46 +35,47 @@
 
 static int loadConfig(const char *cfgPath, int reload)
 {
-	struct stat stats;
-	FILE *cfg = NULL;
-	int ret = 0;
-
-	if (cfgPath && !strcmp(cfgPath, "-")) {
-		if (!reload) {
-			if ((ret = sensors_init(stdin))) {
-				sensorLog(LOG_ERR,
-					  "Error loading sensors configuration file <stdin>: %s",
-					  sensors_strerror(ret));
-				ret = 12;
-			}
-		}
-	} else if (cfgPath && stat(cfgPath, &stats) < 0) {
-		sensorLog(LOG_ERR,
-			  "Error stating sensors configuration file: %s",
-			  cfgPath);
-		ret = 10;
-	} else {
-		if (reload) {
+	int ret;
+ 	FILE *fp;
+
+ 	/* Load default configuration. */
+ 	if (!cfgPath) {
+ 		if (reload) {
 			sensorLog(LOG_INFO, "configuration reloading");
-			sensors_cleanup();
+  			sensors_cleanup();
 		}
-		if (cfgPath && !(cfg = fopen(cfgPath, "r"))) {
-			sensorLog(LOG_ERR,
-				  "Error opening sensors configuration file: %s",
-				  cfgPath);
-			ret = 11;
-		} else if ((ret = sensors_init(cfg))) {
-			sensorLog(LOG_ERR,
-				  "Error loading sensors configuration file %s: %s",
-				  cfgPath ? cfgPath : "(default)",
-				  sensors_strerror(ret));
-			ret = 11;
-		}
-		if (cfg)
-			fclose(cfg);
+
+ 		ret = sensors_init(NULL);
+ 		if (ret) {
+ 			sensorLog(LOG_ERR, "Error loading default"
+ 				  " configuration file: %s",
+ 				  sensors_strerror(ret));
+ 			return -1;
+  		}
+ 		return 0;
+ 	}
+
+ 	fp = fopen(cfgPath, "r");
+ 	if (!fp) {
+ 		sensorLog(LOG_ERR, "Error opening config file %s: %s",
+ 			  strerror(errno));
+ 		return -1;
+ 	}
+
+	if (reload) {
+		sensorLog(LOG_INFO, "configuration reloading");
+		sensors_cleanup();
 	}
+ 	ret = sensors_init(fp);
+ 	if (ret) {
+ 		sensorLog(LOG_ERR, "Error loading sensors configuration file"
+			  " %s: %s", cfgPath, sensors_strerror(ret));
+ 		fclose(fp);
+ 		return -1;
+ 	}
+ 	fclose(fp);
 
-	return ret;
+ 	return 0;
 }
 
 int loadLib(const char *cfgPath)
Index: quilt-sensors/prog/sensord/sensord.c
=================================--- quilt-sensors.orig/prog/sensord/sensord.c	2009-04-26 22:13:33.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.c	2009-04-26 22:13:49.000000000 +0200
@@ -93,8 +93,8 @@
 		if (reload) {
 			ret = reloadLib(sensord_args.cfgFile);
 			if (ret)
-				sensorLog(LOG_NOTICE,
-					  "config reload error (%d)", ret);
+				sensorLog(LOG_NOTICE, "configuration reload"
+					  " error");
 			reload = 0;
 		}
 		if (sensord_args.scanTime && (scanValue <= 0)) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
