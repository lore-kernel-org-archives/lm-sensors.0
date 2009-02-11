From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:58:04 +0000
Subject: [lm-sensors] [PATCH 6/6] libsensors: Include the config file name
Message-Id: <20090211175804.64405008@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Include the configuration file name when reporting parse errors.

---
 doc/libsensors-API.txt |    4 ++++
 lib/access.c           |   11 +++++++----
 lib/conf-parse.y       |    4 ++--
 lib/conf.h             |    1 +
 lib/data.c             |   11 ++++++++---
 lib/error.c            |   23 ++++++++++++++++++++++-
 lib/error.h            |   21 ++++++++++++++++-----
 lib/init.c             |    6 +++---
 8 files changed, 63 insertions(+), 18 deletions(-)

--- lm-sensors.orig/lib/error.c	2009-02-11 14:19:50.000000000 +0100
+++ lm-sensors/lib/error.c	2009-02-11 15:02:17.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     error.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007, 2008  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007-2009   Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -25,10 +25,14 @@
 #include "general.h"
 
 static void sensors_default_parse_error(const char *err, int lineno);
+static void sensors_default_parse_error_wfn(const char *err,
+					    const char *filename, int lineno);
 static void sensors_default_fatal_error(const char *proc, const char *err);
 
 void (*sensors_parse_error) (const char *err, int lineno)  						sensors_default_parse_error;
+void (*sensors_parse_error_wfn) (const char *err, const char *filename,
+				 int lineno) = sensors_default_parse_error_wfn;
 void (*sensors_fatal_error) (const char *proc, const char *err)  						sensors_default_fatal_error;
 
@@ -64,6 +68,23 @@ void sensors_default_parse_error(const c
 		fprintf(stderr, "Error: %s\n", err);
 }
 
+void sensors_default_parse_error_wfn(const char *err,
+				     const char *filename, int lineno)
+{
+	/* If application provided a custom parse error reporting function
+	   but not the variant with the filename, fall back to the original
+	   variant without the filename, for backwards compatibility. */
+	if (sensors_parse_error != sensors_default_parse_error ||
+	    !filename)
+		return sensors_parse_error(err, lineno);
+
+	if (lineno)
+		fprintf(stderr, "Error: File %s, line %d: %s\n", filename,
+			lineno, err);
+	else
+		fprintf(stderr, "Error: File %s: %s\n", filename, err);
+}
+
 void sensors_default_fatal_error(const char *proc, const char *err)
 {
 	fprintf(stderr, "Fatal error in `%s': %s\n", proc, err);
--- lm-sensors.orig/lib/error.h	2009-02-11 14:19:50.000000000 +0100
+++ lm-sensors/lib/error.h	2009-02-11 16:23:04.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     error.h - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007, 2008  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007-2009   Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -44,11 +44,22 @@ extern "C" {
    You may not modify the result! */
 const char *sensors_strerror(int errnum);
 
-/* This function is called when a parse error is detected. Give it a new
-   value, and your own function is called instead of the default (which
-   prints to stderr). This function may terminate the program, but it
-   usually outputs an error and returns. */
+/* These functions are called when a parse error is detected. Give them new
+   values, and your own functions are called instead of the default (which
+   print to stderr). These functions may terminate the program, but they
+   usually output an error and return. The first function is the original
+   one, the second one was added later when support for multiple
+   configuration files was added.
+   The library code now only calls the second function. However, for
+   backwards compatibility, if an application provides a custom handling
+   function for the first function but not the second, then all parse
+   errors will be reported using the first function (that is, the filename
+   is never reported.)
+   Note that filename can be NULL (if filename isn't known) and lineno
+   can be 0 (if the error occurs before the actual parsing starts.) */
 extern void (*sensors_parse_error) (const char *err, int lineno);
+extern void (*sensors_parse_error_wfn) (const char *err,
+					const char *filename, int lineno);
 
 /* This function is called when an immediately fatal error (like no
    memory left) is detected. Give it a new value, and your own function
--- lm-sensors.orig/doc/libsensors-API.txt	2009-02-11 14:19:50.000000000 +0100
+++ lm-sensors/doc/libsensors-API.txt	2009-02-11 16:21:46.000000000 +0100
@@ -24,6 +24,10 @@ given new feature.
   enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_BEEP
 * Added error value for excessive recursion depth
   #define SENSORS_ERR_RECURSION 11
+* Added parse error reporting function including the configuration file
+  name
+  extern void (*sensors_parse_error_wfn) (const char *err,
+  					  const char *filename, int lineno);
 
 0x401	lm-sensors 3.0.2 to 3.0.3
 * Added bus type "virtual":
--- lm-sensors.orig/lib/init.c	2009-02-11 15:02:17.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-11 15:02:17.000000000 +0100
@@ -125,7 +125,7 @@ static int add_config_from_dir(const cha
 
 	count = scandir(dir, &namelist, config_file_filter, alphasort);
 	if (count < 0) {
-		sensors_parse_error(strerror(errno), 0);
+		sensors_parse_error_wfn(strerror(errno), NULL, 0);
 		return -SENSORS_ERR_PARSE;
 	}
 
@@ -147,7 +147,7 @@ static int add_config_from_dir(const cha
 			fclose(input);
 		} else {
 			res = -SENSORS_ERR_PARSE;
-			sensors_parse_error(strerror(errno), 0);
+			sensors_parse_error_wfn(strerror(errno), path, 0);
 		}
 	}
 
@@ -187,7 +187,7 @@ int sensors_init(FILE *input)
 				goto exit_cleanup;
 
 		} else if (errno != ENOENT) {
-			sensors_parse_error(strerror(errno), 0);
+			sensors_parse_error_wfn(strerror(errno), name, 0);
 			res = -SENSORS_ERR_PARSE;
 			goto exit_cleanup;
 		}
--- lm-sensors.orig/lib/data.c	2009-02-11 15:02:17.000000000 +0100
+++ lm-sensors/lib/data.c	2009-02-11 15:02:17.000000000 +0100
@@ -202,7 +202,8 @@ int sensors_parse_bus_id(const char *nam
 	return 0;
 }
 
-static int sensors_substitute_chip(sensors_chip_name *name, int lineno)
+static int sensors_substitute_chip(sensors_chip_name *name,
+				   const char *filename, int lineno)
 {
 	int i, j;
 	for (i = 0; i < sensors_config_busses_count; i++)
@@ -211,7 +212,8 @@ static int sensors_substitute_chip(senso
 			break;
 
 	if (i = sensors_config_busses_count) {
-		sensors_parse_error("Undeclared bus id referenced", lineno);
+		sensors_parse_error_wfn("Undeclared bus id referenced",
+					filename, lineno);
 		name->bus.nr = SENSORS_BUS_NR_IGNORE;
 		return -SENSORS_ERR_BUS_NAME;
 	}
@@ -238,10 +240,12 @@ int sensors_substitute_busses(void)
 {
 	int err, i, j, lineno;
 	sensors_chip_name_list *chips;
+	const char *filename;
 	int res = 0;
 
 	for (i = sensors_config_chips_subst;
 	     i < sensors_config_chips_count; i++) {
+		filename = sensors_config_chips[i].line.filename;
 		lineno = sensors_config_chips[i].line.lineno;
 		chips = &sensors_config_chips[i].chips;
 		for (j = 0; j < chips->fits_count; j++) {
@@ -250,7 +254,8 @@ int sensors_substitute_busses(void)
 			if (chips->fits[j].bus.nr = SENSORS_BUS_NR_ANY)
 				continue;
 
-			err = sensors_substitute_chip(&chips->fits[j], lineno);
+			err = sensors_substitute_chip(&chips->fits[j],
+						      filename, lineno);
 			if (err)
 				res = err;
 		}
--- lm-sensors.orig/lib/access.c	2009-02-11 15:02:17.000000000 +0100
+++ lm-sensors/lib/access.c	2009-02-11 16:23:52.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     access.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007, 2008  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007-2009   Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -511,7 +511,8 @@ static int sensors_do_this_chip_sets(con
 			subfeature = sensors_lookup_subfeature_name(chip_features,
 							chip->sets[i].name);
 			if (!subfeature) {
-				sensors_parse_error("Unknown feature name",
+				sensors_parse_error_wfn("Unknown feature name",
+						    chip->sets[i].line.filename,
 						    chip->sets[i].line.lineno);
 				err = -SENSORS_ERR_NO_ENTRY;
 				continue;
@@ -521,14 +522,16 @@ static int sensors_do_this_chip_sets(con
 						chip->sets[i].value, 0,
 						0, &value);
 			if (res) {
-				sensors_parse_error("Error parsing expression",
+				sensors_parse_error_wfn("Error parsing expression",
+						    chip->sets[i].line.filename,
 						    chip->sets[i].line.lineno);
 				err = res;
 				continue;
 			}
 			if ((res = sensors_set_value(name, subfeature->number,
 						     value))) {
-				sensors_parse_error("Failed to set value",
+				sensors_parse_error_wfn("Failed to set value",
+						chip->sets[i].line.filename,
 						chip->sets[i].line.lineno);
 				err = res;
 				continue;
--- lm-sensors.orig/lib/conf-parse.y	2009-02-11 15:02:17.000000000 +0100
+++ lm-sensors/lib/conf-parse.y	2009-02-11 15:02:17.000000000 +0100
@@ -332,10 +332,10 @@ chip_name:	  NAME
 void sensors_yyerror(const char *err)
 {
   if (sensors_lex_error[0]) {
-    sensors_parse_error(sensors_lex_error,sensors_yylineno);
+    sensors_parse_error_wfn(sensors_lex_error, sensors_yyfilename, sensors_yylineno);
     sensors_lex_error[0] = '\0';
   } else
-    sensors_parse_error(err,sensors_yylineno);
+    sensors_parse_error_wfn(err, sensors_yyfilename, sensors_yylineno);
 }
 
 sensors_expr *malloc_expr(void)
--- lm-sensors.orig/lib/conf.h	2009-02-11 14:19:50.000000000 +0100
+++ lm-sensors/lib/conf.h	2009-02-11 15:02:17.000000000 +0100
@@ -24,6 +24,7 @@
 /* This is defined in conf-lex.l */
 int sensors_yylex(void);
 extern char sensors_lex_error[];
+extern const char *sensors_yyfilename;
 extern int sensors_yylineno;
 extern FILE *sensors_yyin;
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
