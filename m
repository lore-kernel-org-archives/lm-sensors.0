From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:47:38 +0000
Subject: [lm-sensors] [PATCH 3/6] libsensors: Make
Message-Id: <20090211174738.3320ff2d@hyperion.delvare>
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
 lib/data.c |   10 ++++++++--
 lib/data.h |    3 ++-
 lib/init.c |    1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

--- lm-sensors.orig/lib/data.c	2009-02-11 11:11:12.000000000 +0100
+++ lm-sensors/lib/data.c	2009-02-11 11:13:52.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     data.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007, 2009  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -35,6 +35,7 @@ const char *libsensors_version = LM_VERS
 
 sensors_chip *sensors_config_chips = NULL;
 int sensors_config_chips_count = 0;
+int sensors_config_chips_subst = 0;
 int sensors_config_chips_max = 0;
 
 sensors_bus *sensors_config_busses = NULL;
@@ -226,13 +227,17 @@ static int sensors_substitute_chip(senso
 	return 0;
 }
 
+/* Bus substitution is on a per-configuration file basis, so we keep
+   memory (in sensors_config_chips_subst) of which chip entries have been
+   already substituted. */
 int sensors_substitute_busses(void)
 {
 	int err, i, j, lineno;
 	sensors_chip_name_list *chips;
 	int res = 0;
 
-	for (i = 0; i < sensors_config_chips_count; i++) {
+	for (i = sensors_config_chips_subst;
+	     i < sensors_config_chips_count; i++) {
 		lineno = sensors_config_chips[i].lineno;
 		chips = &sensors_config_chips[i].chips;
 		for (j = 0; j < chips->fits_count; j++) {
@@ -246,5 +251,6 @@ int sensors_substitute_busses(void)
 				res = err;
 		}
 	}
+	sensors_config_chips_subst = sensors_config_chips_count;
 	return res;
 }
--- lm-sensors.orig/lib/data.h	2009-02-11 11:12:04.000000000 +0100
+++ lm-sensors/lib/data.h	2009-02-11 11:13:52.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     data.h - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007, 2009  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -135,6 +135,7 @@ typedef struct sensors_chip_features {
 
 extern sensors_chip *sensors_config_chips;
 extern int sensors_config_chips_count;
+extern int sensors_config_chips_subst;
 extern int sensors_config_chips_max;
 
 extern sensors_bus *sensors_config_busses;
--- lm-sensors.orig/lib/init.c	2009-02-11 11:13:51.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-11 11:13:52.000000000 +0100
@@ -240,6 +240,7 @@ void sensors_cleanup(void)
 	free(sensors_config_chips);
 	sensors_config_chips = NULL;
 	sensors_config_chips_count = sensors_config_chips_max = 0;
+	sensors_config_chips_subst = 0;
 
 	for (i = 0; i < sensors_proc_bus_count; i++)
 		free_bus(&sensors_proc_bus[i]);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
