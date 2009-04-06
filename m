From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 07:57:45 +0000
Subject: [lm-sensors] [PATCH 6/8] sensord: Refactoring of loadConfig()
Message-Id: <20090406075745.GG4734@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch does some refactoring of the loadConfig()
function.
---

* Simplifying the conditions makes code flow clearer and eliminates
long lines (> 80 chars).
* Removed useless stat() call.
* Return -1 in error case, instead of several positiv values (never defined).

 lib.c |   76 +++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

--- quilt-sensors.orig/prog/sensord/lib.c	2009-04-03 09:31:57.000000000 +0200
+++ quilt-sensors/prog/sensord/lib.c	2009-04-04 18:30:46.000000000 +0200
@@ -20,7 +20,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  * MA 02110-1301 USA.
  */
-
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -34,46 +34,59 @@
 
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
-			sensorLog(LOG_INFO, "configuration reloading");
-			sensors_cleanup();
-		}
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
-	}
+	int ret;
+ 	FILE *fp;
 
-	return ret;
+ 	/* Load default configuratinon. */
+ 	if (!cfgPath) {
+ 		if (reload)
+  			sensors_cleanup();
+
+ 		ret = sensors_init(NULL);
+ 		if (ret) {
+ 			sensorLog(LOG_ERR, "Error while loading default"
+ 				  " configuration file: %s",
+ 				  sensors_strerror(ret));
+ 			return -1;
+  		}
+ 		return 0;
+ 	}
+
+ 	/* Read config from stdin. */
+ 	if (!strcmp(cfgPath, "-")) {
+ 		if (reload)
+ 			return 0;
+
+ 		ret = sensors_init(stdin);
+ 		if (ret) {
+ 			sensorLog(LOG_ERR, "Error loading sensors"
+ 				  " configuration file <stdin>: %s",
+  				  sensors_strerror(ret));
+ 			return -1;
+  		}
+ 		return 0;
+  	}
+
+ 	fp = fopen(cfgPath, "r");
+ 	if (!fp) {
+ 		sensorLog(LOG_ERR, "Error opening config file %s: %s",
+ 			  sensors_strerror(ret));
+ 		return -1;
+ 	}
+
+ 	ret = sensors_init(fp);
+ 	if (ret) {
+ 		if (reload)
+ 			sensors_cleanup();
+
+ 		sensorLog(LOG_ERR, "Error loading sensors config file %s: %s",
+ 			  cfgPath, sensors_strerror(ret));
+ 		fclose(fp);
+ 		return -1;
+ 	}
+ 	fclose(fp);
+
+ 	return 0;
 }
 
 int loadLib(const char *cfgPath)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
