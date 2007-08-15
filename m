From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 15:38:02 +0000
Subject: [lm-sensors] [PATCH 2/6] libsensors4: Rename busname to path
Message-Id: <20070815173802.2576fbda@hyperion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rename sensors_chip_name.busname to path, as this is what we are using
it for by now.

---
 lib/access.c  |    2 +-
 lib/data.c    |    3 ---
 lib/init.c    |    2 +-
 lib/sensors.h |    2 +-
 lib/sysfs.c   |   10 +++++-----
 5 files changed, 8 insertions(+), 11 deletions(-)

Index: lm-sensors-3.0.0/lib/access.c
=================================--- lm-sensors-3.0.0.orig/lib/access.c	2007-07-31 11:31:37.000000000 +0200
+++ lm-sensors-3.0.0/lib/access.c	2007-07-31 11:41:31.000000000 +0200
@@ -170,7 +170,7 @@ int sensors_get_label(const sensors_chip
 			}
 
 	/* No user specified label, check for a _label sysfs file */
-	snprintf(path, PATH_MAX, "%s/%s_label", name->busname,
+	snprintf(path, PATH_MAX, "%s/%s_label", name->path,
 		featureptr->data.name);
 	
 	if ((f = fopen(path, "r"))) {
Index: lm-sensors-3.0.0/lib/data.c
=================================--- lm-sensors-3.0.0.orig/lib/data.c	2007-07-31 11:25:21.000000000 +0200
+++ lm-sensors-3.0.0/lib/data.c	2007-07-31 11:41:10.000000000 +0200
@@ -78,9 +78,6 @@ int sensors_parse_chip_name(const char *
   char *name = strdup(orig_name);
   int i;
 
-  /* Play it safe */
-  res->busname = NULL;
-  
   if (! name)
     sensors_fatal_error("sensors_parse_chip_name","Allocating new name");
   /* First split name in upto four pieces. */
Index: lm-sensors-3.0.0/lib/init.c
=================================--- lm-sensors-3.0.0.orig/lib/init.c	2007-07-30 14:53:50.000000000 +0200
+++ lm-sensors-3.0.0/lib/init.c	2007-07-31 11:40:25.000000000 +0200
@@ -90,7 +90,7 @@ void sensors_cleanup(void)
 void free_chip_name(sensors_chip_name *name)
 {
   free(name->prefix);
-  free(name->busname);
+  free(name->path);
 }
 
 void free_chip_features(sensors_chip_feature *features)
Index: lm-sensors-3.0.0/lib/sensors.h
=================================--- lm-sensors-3.0.0.orig/lib/sensors.h	2007-07-31 11:31:37.000000000 +0200
+++ lm-sensors-3.0.0/lib/sensors.h	2007-07-31 11:45:49.000000000 +0200
@@ -43,7 +43,7 @@ typedef struct sensors_chip_name {
   char *prefix;
   int bus;
   int addr;
-  char *busname;
+  char *path;
 } sensors_chip_name;
 
 /* (Re)load the configuration file and the detected chips list. If this 
Index: lm-sensors-3.0.0/lib/sysfs.c
=================================--- lm-sensors-3.0.0.orig/lib/sysfs.c	2007-07-31 11:23:29.000000000 +0200
+++ lm-sensors-3.0.0/lib/sysfs.c	2007-07-31 11:36:17.000000000 +0200
@@ -222,8 +222,8 @@ static int sensors_read_one_sysfs_chip(s
 	if (!entry.chip.prefix)
 		sensors_fatal_error(__FUNCTION__, "out of memory");
 
-	entry.chip.busname = strdup(dev->path);
-	if (!entry.chip.busname)
+	entry.chip.path = strdup(dev->path);
+	if (!entry.chip.path)
 		sensors_fatal_error(__FUNCTION__, "out of memory");
 
 	if (sscanf(dev->name, "%d-%x", &entry.chip.bus, &entry.chip.addr) = 2) {
@@ -270,7 +270,7 @@ static int sensors_read_one_sysfs_chip(s
 
 exit_free:
 	free(entry.chip.prefix);
-	free(entry.chip.busname);
+	free(entry.chip.path);
 	return err;
 }
 
@@ -416,7 +416,7 @@ int sensors_read_sysfs_attr(const sensor
 	 || sscanf(the_feature->data.name, "temp%d%c", &dummy, &check) = 1)
 		suffix = "_input";
 
-	snprintf(n, NAME_MAX, "%s/%s%s", name->busname, the_feature->data.name,
+	snprintf(n, NAME_MAX, "%s/%s%s", name->path, the_feature->data.name,
 		 suffix);
 	if ((f = fopen(n, "r"))) {
 		int res = fscanf(f, "%lf", value);
@@ -451,7 +451,7 @@ int sensors_write_sysfs_attr(const senso
 	 || sscanf(the_feature->data.name, "temp%d%c", &dummy, &check) = 1)
 		suffix = "_input";
 
-	snprintf(n, NAME_MAX, "%s/%s%s", name->busname, the_feature->data.name,
+	snprintf(n, NAME_MAX, "%s/%s%s", name->path, the_feature->data.name,
 		 suffix);
 	if ((f = fopen(n, "w"))) {
 		for (mag = the_feature->scaling; mag > 0; mag --)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
