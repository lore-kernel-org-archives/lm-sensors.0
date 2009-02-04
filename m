From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Feb 2009 22:04:26 +0000
Subject: [lm-sensors] [PATCH 3/4] libsensors: Make
Message-Id: <20090204230426.41ee7bd9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make it possible to only substitute the bus number of a subset of the
chip entries. This is a prerequisite to add support for multiple
configuration files. Each configuration file can come with its own bus
statements and the bus number substitution should only affect chip
entries from the same configuration file.

---
 lib/data.c |    5 +++--
 lib/data.h |    4 ++--
 lib/init.c |    3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

--- lm-sensors.orig/lib/data.c	2009-01-14 17:49:58.000000000 +0100
+++ lm-sensors/lib/data.c	2009-02-04 14:31:29.000000000 +0100
@@ -226,13 +226,13 @@ static int sensors_substitute_chip(senso
 	return 0;
 }
 
-int sensors_substitute_busses(void)
+int sensors_substitute_busses(int *from)
 {
 	int err, i, j, lineno;
 	sensors_chip_name_list *chips;
 	int res = 0;
 
-	for (i = 0; i < sensors_config_chips_count; i++) {
+	for (i = *from; i < sensors_config_chips_count; i++) {
 		lineno = sensors_config_chips[i].lineno;
 		chips = &sensors_config_chips[i].chips;
 		for (j = 0; j < chips->fits_count; j++) {
@@ -246,5 +246,6 @@ int sensors_substitute_busses(void)
 				res = err;
 		}
 	}
+	*from = sensors_config_chips_count;
 	return res;
 }
--- lm-sensors.orig/lib/data.h	2009-01-29 09:39:18.000000000 +0100
+++ lm-sensors/lib/data.h	2009-02-04 14:32:18.000000000 +0100
@@ -157,8 +157,8 @@ extern int sensors_proc_bus_max;
 	&sensors_proc_bus_max, sizeof(struct sensors_bus))
 
 /* Substitute configuration bus numbers with real-world bus numbers
-   in the chips lists */
-int sensors_substitute_busses(void);
+   in the chips lists, starting from the given chip entry number */
+int sensors_substitute_busses(int *from);
 
 
 /* Parse a bus id into its components. Returns 0 on succes, a value from
--- lm-sensors.orig/lib/init.c	2009-02-04 14:29:57.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-04 14:40:39.000000000 +0100
@@ -80,6 +80,7 @@ static void free_config_busses(void)
 static int parse_config(FILE *input)
 {
 	int err;
+	static int from = 0;
 
 	if (sensors_scanner_init(input)) {
 		err = -SENSORS_ERR_PARSE;
@@ -92,7 +93,7 @@ static int parse_config(FILE *input)
 		goto exit_cleanup;
 	}
 
-	err = sensors_substitute_busses();
+	err = sensors_substitute_busses(&from);
 
 exit_cleanup:
 	free_config_busses();

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
