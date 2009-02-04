From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Feb 2009 22:02:44 +0000
Subject: [lm-sensors] [PATCH 1/4] libsensors: Exit the configuration file
Message-Id: <20090204230244.03ebb335@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Exit the configuration file parser as soon as we are done with it.

---
 lib/init.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

--- lm-sensors.orig/lib/init.c	2009-02-04 14:05:11.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-04 14:05:22.000000000 +0100
@@ -61,6 +61,20 @@ static int sensors_parse(void)
 	return res;
 }
 
+static int parse_config(FILE *input)
+{
+	int err;
+
+	if (sensors_scanner_init(input))
+		return -SENSORS_ERR_PARSE;
+	err = sensors_parse();
+	sensors_scanner_exit();
+	if (err)
+		return -SENSORS_ERR_PARSE;
+
+	return 0;
+}
+
 int sensors_init(FILE *input)
 {
 	int res;
@@ -71,10 +85,9 @@ int sensors_init(FILE *input)
 	    (res = sensors_read_sysfs_chips()))
 		goto exit_cleanup;
 
-	res = -SENSORS_ERR_PARSE;
 	if (input) {
-		if (sensors_scanner_init(input) ||
-		    sensors_parse())
+		res = parse_config(input);
+		if (res)
 			goto exit_cleanup;
 	} else {
 		/* No configuration provided, use default */
@@ -82,12 +95,10 @@ int sensors_init(FILE *input)
 		if (!input && errno = ENOENT)
 			input = fopen(ALT_CONFIG_FILE, "r");
 		if (input) {
-			if (sensors_scanner_init(input) ||
-			    sensors_parse()) {
-				fclose(input);
-				goto exit_cleanup;
-			}
+			res = parse_config(input);
 			fclose(input);
+			if (res)
+				goto exit_cleanup;
 		}
 	}
 
@@ -194,8 +205,6 @@ void sensors_cleanup(void)
 {
 	int i;
 
-	sensors_scanner_exit();
-
 	for (i = 0; i < sensors_proc_chips_count; i++) {
 		free_chip_name(&sensors_proc_chips[i].chip);
 		free_chip_features(&sensors_proc_chips[i]);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
