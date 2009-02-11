From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:50:08 +0000
Subject: [lm-sensors] [PATCH 4/6] Read extra configuration files from
Message-Id: <20090211175008.0f843712@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Read extra configuration files from /etc/sensors.d.

---
 lib/init.c         |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/libsensors.3   |   16 +++++++++++--
 lib/sensors.conf.5 |   20 +++++++++++++++--
 3 files changed, 90 insertions(+), 6 deletions(-)

--- lm-sensors.orig/lib/init.c	2009-02-10 22:01:52.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-11 10:42:07.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     init.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007, 2009  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -19,11 +19,16 @@
     MA 02110-1301 USA.
 */
 
+/* Needed for scandir() and alphasort() */
+#define _BSD_SOURCE
+
+#include <sys/types.h>
 #include <locale.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
+#include <dirent.h>
 #include "sensors.h"
 #include "data.h"
 #include "error.h"
@@ -35,6 +40,7 @@
 
 #define DEFAULT_CONFIG_FILE	ETCDIR "/sensors3.conf"
 #define ALT_CONFIG_FILE		ETCDIR "/sensors.conf"
+#define DEFAULT_CONFIG_DIR	ETCDIR "/sensors.d"
 
 /* Wrapper around sensors_yyparse(), which clears the locale so that
    the decimal numbers are always parsed properly. */
@@ -99,6 +105,53 @@ exit_cleanup:
 	return err;
 }
 
+static int config_file_filter(const struct dirent *entry)
+{
+	return (entry->d_type = DT_REG || entry->d_type = DT_LNK)
+	    && entry->d_name[0] != '.';		/* Skip hidden files */
+}
+
+static int add_config_from_dir(const char *dir)
+{
+	int count, res, i;
+	struct dirent **namelist;
+
+	count = scandir(dir, &namelist, config_file_filter, alphasort);
+	if (count < 0) {
+		sensors_parse_error(strerror(errno), 0);
+		return -SENSORS_ERR_PARSE;
+	}
+
+	for (res = 0, i = 0; !res && i < count; i++) {
+		int len;
+		char path[16 + NAME_MAX];
+		FILE *input;
+
+		len = snprintf(path, sizeof(path), "%s/%s", dir,
+			       namelist[i]->d_name);
+		if (len < 0 || len >= (int)sizeof(path)) {
+			res = -SENSORS_ERR_PARSE;
+			continue;
+		}
+
+		input = fopen(path, "r");
+		if (input) {
+			res = parse_config(input);
+			fclose(input);
+		} else {
+			res = -SENSORS_ERR_PARSE;
+			sensors_parse_error(strerror(errno), 0);
+		}
+	}
+
+	/* Free memory allocated by scandir() */
+	for (i = 0; i < count; i++)
+		free(namelist[i]);
+	free(namelist);
+
+	return res;
+}
+
 int sensors_init(FILE *input)
 {
 	int res;
@@ -129,6 +182,11 @@ int sensors_init(FILE *input)
 			res = -SENSORS_ERR_PARSE;
 			goto exit_cleanup;
 		}
+
+		/* Also check for files in default directory */
+		res = add_config_from_dir(DEFAULT_CONFIG_DIR);
+		if (res)
+			goto exit_cleanup;
 	}
 
 	return 0;
--- lm-sensors.orig/lib/sensors.conf.5	2009-02-10 21:59:54.000000000 +0100
+++ lm-sensors/lib/sensors.conf.5	2009-02-11 10:30:22.000000000 +0100
@@ -1,6 +1,6 @@
 .\" Copyright (C) 1998, 1999 Adrian Baugh <adrian.baugh@keble.ox.ac.uk> and
 .\"                          Frodo Looijaard <frodol@dds.nl>
-.\" Copyright (C) 2008       Jean Delvare <khali@linux-fr.org>
+.\" Copyright (C) 2008, 2009 Jean Delvare <khali@linux-fr.org>
 .\"
 .\" Permission is granted to make and distribute verbatim copies of this
 .\" manual provided the copyright notice and this permission notice are
@@ -21,7 +21,7 @@
 .\"
 .\" References consulted:
 .\"     sensors.conf.eg by Frodo Looijaard
-.TH sensors.conf 5  "December 2008" "lm-sensors 3" "Linux User's Manual"
+.TH sensors.conf 5  "February 2009" "lm-sensors 3" "Linux User's Manual"
 .SH NAME
 sensors.conf \- libsensors configuration file
 
@@ -274,6 +274,13 @@ Running
 .B sensors --bus-list
 will generate these lines for you.
 
+In the case where multiple configuration files are used, the scope
+of each
+.I bus
+statement is the configuration file it was defined in. This makes it
+possible to have bus statements in all configuration files which will
+not unexpectedly interfere with each other.
+
 .SS STATEMENT ORDER
 
 Statements can go in any order, however it is recommended to put
@@ -533,6 +540,15 @@ The system-wide
 .BR libsensors (3)
 configuration file. /etc/sensors3.conf is tried first, and if it doesn't exist,
 /etc/sensors.conf is used instead.
+.RE
+
+.I /etc/sensors.d
+.RS
+A directory where you can put additional libsensors configuration files.
+Files found in this directory will be processed in alphabetical order after
+the default configuration file. Files those name starts with a dot are
+ignored.
+.RE
 
 .SH SEE ALSO
 libsensors(3)
--- lm-sensors.orig/lib/libsensors.3	2009-02-10 21:59:54.000000000 +0100
+++ lm-sensors/lib/libsensors.3	2009-02-11 10:29:09.000000000 +0100
@@ -1,4 +1,5 @@
-.\" Copyright 1998, 1999 Adrian Baugh <adrian.baugh@keble.ox.ac.uk>
+.\" Copyright (C) 1998, 1999  Adrian Baugh <adrian.baugh@keble.ox.ac.uk>
+.\" Copyright (C) 2007, 2009  Jean Delvare <khali@linux-fr.org>
 .\" based on sensors.h, part of libsensors by Frodo Looijaard
 .\" libsensors is distributed under the GPL
 .\"
@@ -24,7 +25,7 @@
 .\"
 .\" References consulted:
 .\"     libsensors source code
-.TH libsensors 3  "October 2007" "lm-sensors 3" "Linux Programmer's Manual"
+.TH libsensors 3  "February 2009" "lm-sensors 3" "Linux Programmer's Manual"
 .SH NAME
 libsensors \- publicly accessible functions provided by the sensors library
 .SH SYNOPSIS
@@ -57,7 +58,7 @@ value unequal to zero, you are in troubl
 be initialized properly. If you want to reload the configuration file, call
 sensors_cleanup() below before calling sensors_init() again.
 
-If FILE is NULL, the default configuration file is used (see the FILES
+If FILE is NULL, the default configuration files are used (see the FILES
 section below). Most applications will want to do that.
 
 .B void sensors_cleanup(void);
@@ -180,6 +181,15 @@ The system-wide
 .BR libsensors (3)
 configuration file. /etc/sensors3.conf is tried first, and if it doesn't exist,
 /etc/sensors.conf is used instead.
+.RE
+
+.I /etc/sensors.d
+.RS
+A directory where you can put additional libsensors configuration files.
+Files found in this directory will be processed in alphabetical order after
+the default configuration file. Files those name starts with a dot are
+ignored.
+.RE
 
 .SH SEE ALSO
 sensors.conf(5)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
