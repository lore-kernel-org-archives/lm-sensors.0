From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:43:45 +0000
Subject: [lm-sensors] [PATCH 2/6] libsensors: Free bus statements sooner
Message-Id: <20090211174345.191010d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Free bus statements from the configuration file as soon as we are done
with them.

---
 lib/init.c |   47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

--- lm-sensors.orig/lib/init.c	2009-02-10 22:00:25.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-10 22:01:46.000000000 +0100
@@ -61,18 +61,42 @@ static int sensors_parse(void)
 	return res;
 }
 
+static void free_bus(sensors_bus *bus)
+{
+	free(bus->adapter);
+}
+
+static void free_config_busses(void)
+{
+	int i;
+
+	for (i = 0; i < sensors_config_busses_count; i++)
+		free_bus(&sensors_config_busses[i]);
+	free(sensors_config_busses);
+	sensors_config_busses = NULL;
+	sensors_config_busses_count = sensors_config_busses_max = 0;
+}
+
 static int parse_config(FILE *input)
 {
 	int err;
 
-	if (sensors_scanner_init(input))
-		return -SENSORS_ERR_PARSE;
+	if (sensors_scanner_init(input)) {
+		err = -SENSORS_ERR_PARSE;
+		goto exit_cleanup;
+	}
 	err = sensors_parse();
 	sensors_scanner_exit();
-	if (err)
-		return -SENSORS_ERR_PARSE;
+	if (err) {
+		err = -SENSORS_ERR_PARSE;
+		goto exit_cleanup;
+	}
 
-	return 0;
+	err = sensors_substitute_busses();
+
+exit_cleanup:
+	free_config_busses();
+	return err;
 }
 
 int sensors_init(FILE *input)
@@ -107,8 +131,6 @@ int sensors_init(FILE *input)
 		}
 	}
 
-	if ((res = sensors_substitute_busses()))
-		goto exit_cleanup;
 	return 0;
 
 exit_cleanup:
@@ -134,11 +156,6 @@ static void free_chip_features(sensors_c
 	free(features->feature);
 }
 
-static void free_bus(sensors_bus *bus)
-{
-	free(bus->adapter);
-}
-
 static void free_label(sensors_label *label)
 {
 	free(label->name);
@@ -218,12 +235,6 @@ void sensors_cleanup(void)
 	sensors_proc_chips = NULL;
 	sensors_proc_chips_count = sensors_proc_chips_max = 0;
 
-	for (i = 0; i < sensors_config_busses_count; i++)
-		free_bus(&sensors_config_busses[i]);
-	free(sensors_config_busses);
-	sensors_config_busses = NULL;
-	sensors_config_busses_count = sensors_config_busses_max = 0;
-
 	for (i = 0; i < sensors_config_chips_count; i++)
 		free_chip(&sensors_config_chips[i]);
 	free(sensors_config_chips);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
