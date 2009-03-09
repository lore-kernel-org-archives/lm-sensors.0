From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 08:45:38 +0000
Subject: [lm-sensors] [PATCH 3/7] sensord: Coding style conversion (gnu ->
Message-Id: <20090309084538.GD4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix coding style in lib.c

---
 prog/sensord/lib.c |  119 +++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

--- quilt-sensors.orig/prog/sensord/lib.c	2009-03-06 16:24:55.000000000 +0100
+++ quilt-sensors/prog/sensord/lib.c	2009-03-08 18:19:28.000000000 +0100
@@ -32,69 +32,72 @@
 #include "sensord.h"
 #include "lib/error.h"
 
-static int
-loadConfig
-(const char *cfgPath, int reload) {
-  struct stat stats;
-  FILE *cfg = NULL;
-  int ret = 0;
-
-  if (cfgPath && !strcmp (cfgPath, "-")) {
-    if (!reload) {
-      if ((ret = sensors_init (stdin))) {
-        sensorLog (LOG_ERR, "Error loading sensors configuration file <stdin>: %s",
-                   sensors_strerror (ret));
-        ret = 12;
-      }
-    }
-  } else if (cfgPath && stat (cfgPath, &stats) < 0) {
-    sensorLog (LOG_ERR, "Error stating sensors configuration file: %s", cfgPath);
-    ret = 10;
-  } else {
-    if (reload) {
-      sensorLog (LOG_INFO, "configuration reloading");
-      sensors_cleanup ();
-    }
-    if (cfgPath && !(cfg = fopen (cfgPath, "r"))) {
-      sensorLog (LOG_ERR, "Error opening sensors configuration file: %s", cfgPath);
-      ret = 11;
-    } else if ((ret = sensors_init (cfg))) {
-      sensorLog (LOG_ERR, "Error loading sensors configuration file %s: %s",
-                 cfgPath ? cfgPath : "(default)", sensors_strerror (ret));
-      ret = 11;
-    }
-    if (cfg)
-      fclose (cfg);
-  }
+static int loadConfig(const char *cfgPath, int reload)
+{
+	struct stat stats;
+	FILE *cfg = NULL;
+	int ret = 0;
+
+	if (cfgPath && !strcmp(cfgPath, "-")) {
+		if (!reload) {
+			if ((ret = sensors_init(stdin))) {
+				sensorLog(LOG_ERR,
+					  "Error loading sensors configuration file <stdin>: %s",
+					  sensors_strerror(ret));
+				ret = 12;
+			}
+		}
+	} else if (cfgPath && stat(cfgPath, &stats) < 0) {
+		sensorLog(LOG_ERR,
+			  "Error stating sensors configuration file: %s",
+			  cfgPath);
+		ret = 10;
+	} else {
+		if (reload) {
+			sensorLog(LOG_INFO, "configuration reloading");
+			sensors_cleanup();
+		}
+		if (cfgPath && !(cfg = fopen(cfgPath, "r"))) {
+			sensorLog(LOG_ERR,
+				  "Error opening sensors configuration file: %s",
+				  cfgPath);
+			ret = 11;
+		} else if ((ret = sensors_init(cfg))) {
+			sensorLog(LOG_ERR,
+				  "Error loading sensors configuration file %s: %s",
+				  cfgPath ? cfgPath : "(default)",
+				  sensors_strerror(ret));
+			ret = 11;
+		}
+		if (cfg)
+			fclose(cfg);
+	}
 
-  return ret;
+	return ret;
 }
 
-int
-loadLib
-(const char *cfgPath) {
-  int ret;
-  ret = loadConfig (cfgPath, 0);
-  if (!ret)
-    ret = initKnownChips ();
-  return ret;
+int loadLib(const char *cfgPath)
+{
+	int ret;
+	ret = loadConfig(cfgPath, 0);
+	if (!ret)
+		ret = initKnownChips();
+	return ret;
 }
 
-int
-reloadLib
-(const char *cfgPath) {
-  int ret;
-  freeKnownChips ();
-  ret = loadConfig (cfgPath, 1);
-  if (!ret)
-    ret = initKnownChips ();
-  return ret;
+int reloadLib(const char *cfgPath)
+{
+	int ret;
+	freeKnownChips();
+	ret = loadConfig(cfgPath, 1);
+	if (!ret)
+		ret = initKnownChips();
+	return ret;
 }
 
-int
-unloadLib
-(void) {
-  freeKnownChips ();
-  sensors_cleanup ();
-  return 0;  
+int unloadLib(void)
+{
+	freeKnownChips();
+	sensors_cleanup();
+	return 0;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
