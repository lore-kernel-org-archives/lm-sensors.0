From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:08:15 +0000
Subject: [lm-sensors] [PATCH 1/6] Add a default configuration file name to
Message-Id: <20071024170815.76deb8ec@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let libsensors know the default path to its configuration file.
That way, applications no longer have to care.

---
 Makefile   |    4 ++--
 lib/init.c |   24 ++++++++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

--- lm-sensors-3.orig/lib/init.c	2007-10-20 16:02:44.000000000 +0200
+++ lm-sensors-3/lib/init.c	2007-10-20 16:08:42.000000000 +0200
@@ -29,6 +29,8 @@
 #include "scanner.h"
 #include "init.h"
 
+#define DEFAULT_CONFIG_FILE	ETCDIR "/sensors.conf"
+
 int sensors_init(FILE *input)
 {
 	int res;
@@ -38,10 +40,24 @@ int sensors_init(FILE *input)
 	if ((res = sensors_read_sysfs_bus()) ||
 	    (res = sensors_read_sysfs_chips()))
 		return res;
-	if ((res = sensors_scanner_init(input)))
-		return -SENSORS_ERR_PARSE;
-	if ((res = sensors_yyparse()))
-		return -SENSORS_ERR_PARSE;
+
+	if (input) {
+		if (sensors_scanner_init(input) ||
+		    sensors_yyparse())
+			return -SENSORS_ERR_PARSE;
+	} else {
+		/* No configuration provided, use default */
+		input = fopen(DEFAULT_CONFIG_FILE, "r");
+		if (!input)
+			return -SENSORS_ERR_PARSE;
+		if (sensors_scanner_init(input) ||
+		    sensors_yyparse()) {
+			fclose(input);
+			return -SENSORS_ERR_PARSE;
+		}
+		fclose(input);
+	}
+
 	if ((res = sensors_substitute_busses()))
 		return res;
 	return 0;
--- lm-sensors-3.orig/Makefile	2007-10-20 16:02:44.000000000 +0200
+++ lm-sensors-3/Makefile	2007-10-20 16:06:18.000000000 +0200
@@ -144,9 +144,9 @@ ALL_CFLAGS += $(CFLAGS)
 
 PROGCPPFLAGS := -DETCDIR="\"$(ETCDIR)\"" $(ALL_CPPFLAGS)
 PROGCFLAGS := $(ALL_CFLAGS)
-ARCPPFLAGS := $(ALL_CPPFLAGS)
+ARCPPFLAGS := -DETCDIR="\"$(ETCDIR)\"" $(ALL_CPPFLAGS)
 ARCFLAGS := $(ALL_CFLAGS)
-LIBCPPFLAGS := $(ALL_CPPFLAGS)
+LIBCPPFLAGS := -DETCDIR="\"$(ETCDIR)\"" $(ALL_CPPFLAGS)
 LIBCFLAGS := -fpic -D_REENTRANT $(ALL_CFLAGS)
 
 .PHONY: all user clean install user_install uninstall user_uninstall


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
