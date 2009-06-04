From: Yuriy Kaminskiy <yumkam@mail.ru>
Date: Thu, 04 Jun 2009 23:25:06 +0000
Subject: [lm-sensors] [PATCH] bug in sensors.d reading: not all filesystems
Message-Id: <h09l4i$sdc$1@ger.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090603030006080704010309"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090603030006080704010309
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello!
  Most filesystems (in particular - reiserfs, jfs, xfs, nfs); maybe,
some legacy installation of ext2/3 too) always return dirent->dt_type =
DT_UNKNOWN, so libsensors fails to parse /etc/sensors.d.
  Also, symlink (DT_LNK) can point to directory, or FIFO/socket/device
(very bad!) - current check insufficient anyways.
  I've attached [somewhat hackerish] patch to solve both problem.
=== cut !man 3 readdir ===
Currently,  only  some  file systems (among them: ext2, etx3, and ext4)
have full support returning the file type in d_type.  All  applications
must properly handle a return of DT_UNKNOWN.
=== cut ===
  Maybe, it would be better to remove dt_type check and use stat() always.

--------------090603030006080704010309
Content-Type: text/x-diff;
 name="lm_sensors-3.1.0-dt_unknown-fix-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lm_sensors-3.1.0-dt_unknown-fix-3.patch"

Index: lm_sensors-3.1.0/lib/init.c
===================================================================
--- lm_sensors-3.1.0/lib/init.c.orig	2009-06-01 05:10:42.000000000 +0400
+++ lm_sensors-3.1.0/lib/init.c	2009-06-05 03:17:49.000000000 +0400
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <errno.h>
 #include <dirent.h>
+#include <sys/stat.h>
 #include "sensors.h"
 #include "data.h"
 #include "error.h"
@@ -118,9 +119,10 @@ exit_cleanup:
 	return err;
 }
 
+static int need_check_stat;
 static int config_file_filter(const struct dirent *entry)
 {
-	return (entry->d_type == DT_REG || entry->d_type == DT_LNK)
+	return (entry->d_type == DT_REG || (need_check_stat |= entry->d_type == DT_LNK || entry->d_type == DT_UNKNOWN))
 	    && entry->d_name[0] != '.';		/* Skip hidden files */
 }
 
@@ -129,6 +131,7 @@ static int add_config_from_dir(const cha
 	int count, res, i;
 	struct dirent **namelist;
 
+	need_check_stat = 0;
 	count = scandir(dir, &namelist, config_file_filter, alphasort);
 	if (count < 0) {
 		/* Do not return an error if directory does not exist */
@@ -143,6 +146,7 @@ static int add_config_from_dir(const cha
 		int len;
 		char path[PATH_MAX];
 		FILE *input;
+		struct stat st;
 
 		len = snprintf(path, sizeof(path), "%s/%s", dir,
 			       namelist[i]->d_name);
@@ -151,6 +155,9 @@ static int add_config_from_dir(const cha
 			continue;
 		}
 
+		if (need_check_stat && (stat(path, &st) < 0 || !S_ISREG(st.st_mode)))
+			continue;
+
 		input = fopen(path, "r");
 		if (input) {
 			res = parse_config(input, path);

--------------090603030006080704010309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090603030006080704010309--

