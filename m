From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:24:06 +0000
Subject: [lm-sensors] [PATCH 4/6] Clean up on libsensors init error
Message-Id: <20071024172406.1417ec5b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up if something goes wrong during initialization. Otherwise
we're leaking memory.

---
 lib/init.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- lm-sensors-3.orig/lib/init.c	2007-10-20 16:08:42.000000000 +0200
+++ lm-sensors-3/lib/init.c	2007-10-20 16:25:19.000000000 +0200
@@ -39,28 +39,33 @@ int sensors_init(FILE *input)
 		return -SENSORS_ERR_KERNEL;
 	if ((res = sensors_read_sysfs_bus()) ||
 	    (res = sensors_read_sysfs_chips()))
-		return res;
+		goto exit_cleanup;
 
+	res = -SENSORS_ERR_PARSE;
 	if (input) {
 		if (sensors_scanner_init(input) ||
 		    sensors_yyparse())
-			return -SENSORS_ERR_PARSE;
+			goto exit_cleanup;
 	} else {
 		/* No configuration provided, use default */
 		input = fopen(DEFAULT_CONFIG_FILE, "r");
 		if (!input)
-			return -SENSORS_ERR_PARSE;
+			goto exit_cleanup;
 		if (sensors_scanner_init(input) ||
 		    sensors_yyparse()) {
 			fclose(input);
-			return -SENSORS_ERR_PARSE;
+			goto exit_cleanup;
 		}
 		fclose(input);
 	}
 
 	if ((res = sensors_substitute_busses()))
-		return res;
+		goto exit_cleanup;
 	return 0;
+
+exit_cleanup:
+	sensors_cleanup();
+	return res;
 }
 
 static void free_chip_name(sensors_chip_name *name)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
