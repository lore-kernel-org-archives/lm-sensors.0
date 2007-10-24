From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:11:19 +0000
Subject: [lm-sensors] [PATCH 3/6] No default configuration file name in
Message-Id: <20071024171119.33e90128@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"sensord" no longer needs a default configuration file name. If no
file name is provided on the command line, use the libsensors default.

---
 prog/sensord/args.c    |    8 +++-----
 prog/sensord/lib.c     |    8 ++++----
 prog/sensord/sensord.8 |    4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

--- lm-sensors-3.orig/prog/sensord/args.c	2007-10-24 16:21:23.000000000 +0200
+++ lm-sensors-3/prog/sensord/args.c	2007-10-24 16:22:57.000000000 +0200
@@ -30,12 +30,10 @@
 #include "lib/error.h"
 #include "version.h"
 
-#define DEFAULT_CONFIG_FILE	ETCDIR "/sensors.conf"
-
 #define MAX_CHIP_NAMES 32
 
 int isDaemon = 0;
-const char *sensorsCfgFile = DEFAULT_CONFIG_FILE;
+const char *sensorsCfgFile = NULL;
 const char *pidFile = "/var/run/sensord.pid";
 const char *rrdFile = NULL;
 const char *cgiDir = NULL;
@@ -104,7 +102,7 @@ static const char *daemonSyntax    "  -t, --rrd-interval <time> -- interval between updating RRD file (default 5m)\n"
   "  -T, --rrd-no-average      -- switch RRD in non-average mode\n"
   "  -r, --rrd-file <file>     -- RRD file (default <none>)\n"
-  "  -c, --config-file <file>  -- configuration file (default " DEFAULT_CONFIG_FILE ")\n"
+  "  -c, --config-file <file>  -- configuration file\n"
   "  -p, --pid-file <file>     -- PID file (default /var/run/sensord.pid)\n"
   "  -f, --syslog-facility <f> -- syslog facility to use (default local4)\n"
   "  -g, --rrd-cgi <img-dir>   -- output an RRD CGI script and exit\n"
@@ -129,7 +127,7 @@ static const char *appSyntax    "  -a, --alarm-scan          -- only scan for alarms\n"
   "  -s, --set                 -- execute set statements (root only)\n"
   "  -r, --rrd-file <file>     -- only update RRD file\n"
-  "  -c, --config-file <file>  -- configuration file (default " DEFAULT_CONFIG_FILE ")\n"
+  "  -c, --config-file <file>  -- configuration file\n"
   "  -d, --debug               -- display some debug information\n"
   "  -v, --version             -- display version and exit\n"
   "  -h, --help                -- display help and exit\n"
--- lm-sensors-3.orig/prog/sensord/lib.c	2007-10-24 16:21:23.000000000 +0200
+++ lm-sensors-3/prog/sensord/lib.c	2007-10-24 16:22:57.000000000 +0200
@@ -38,7 +38,7 @@ loadConfig
   FILE *cfg = NULL;
   int ret = 0;
 
-  if (!strcmp (cfgPath, "-")) {
+  if (cfgPath && !strcmp (cfgPath, "-")) {
     if (!reload) {
       if ((ret = sensors_init (stdin))) {
         sensorLog (LOG_ERR, "Error loading sensors configuration file <stdin>: %s",
@@ -46,7 +46,7 @@ loadConfig
         ret = 12;
       }
     }
-  } else if (stat (cfgPath, &stats) < 0) {
+  } else if (cfgPath && stat (cfgPath, &stats) < 0) {
     sensorLog (LOG_ERR, "Error stating sensors configuration file: %s", cfgPath);
     ret = 10;
   } else {
@@ -54,12 +54,12 @@ loadConfig
       sensorLog (LOG_INFO, "configuration reloading");
       sensors_cleanup ();
     }
-    if (!(cfg = fopen (cfgPath, "r"))) {
+    if (cfgPath && !(cfg = fopen (cfgPath, "r"))) {
       sensorLog (LOG_ERR, "Error opening sensors configuration file: %s", cfgPath);
       ret = 11;
     } else if ((ret = sensors_init (cfg))) {
       sensorLog (LOG_ERR, "Error loading sensors configuration file %s: %s",
-                 cfgPath, sensors_strerror (ret));
+                 cfgPath ? cfgPath : "(default)", sensors_strerror (ret));
       ret = 11;
     }
     if (cfg)
--- lm-sensors-3.orig/prog/sensord/sensord.8	2007-10-21 16:20:25.000000000 +0200
+++ lm-sensors-3/prog/sensord/sensord.8	2007-10-24 16:26:08.000000000 +0200
@@ -79,8 +79,8 @@ below for more details.
 .IP "-c, --config-file file"
 Specify a
 .BR libsensors (3)
-configuration file. If no file is specified, the default configuration file
-is used.
+configuration file. If no file is specified, the libsensors default
+configuration file is used.
 
 .IP "-p, --pid-file file"
 Specify what PID file to write; the default is to write the file


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
