From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:57:03 +0000
Subject: [lm-sensors] [PATCH 5/6] libsensors: Keep track of configuration
Message-Id: <20090211175703.1a5c9dbd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Keep track of configuration file names so that we can later generate
better error reports.

---
 lib/access.c            |    6 +++---
 lib/conf-lex.l          |   22 +++++++++++++++-------
 lib/conf-parse.y        |   14 +++++++-------
 lib/data.c              |    6 +++++-
 lib/data.h              |   26 ++++++++++++++++++++------
 lib/init.c              |   29 ++++++++++++++++++++++-------
 lib/scanner.h           |    2 +-
 lib/test/test-scanner.c |    2 +-
 8 files changed, 74 insertions(+), 33 deletions(-)

--- lm-sensors.orig/lib/init.c	2009-02-11 11:13:56.000000000 +0100
+++ lm-sensors/lib/init.c	2009-02-11 11:21:15.000000000 +0100
@@ -83,11 +83,18 @@ static void free_config_busses(void)
 	sensors_config_busses_count = sensors_config_busses_max = 0;
 }
 
-static int parse_config(FILE *input)
+static int parse_config(FILE *input, const char *name)
 {
 	int err;
+	char *name_copy;
 
-	if (sensors_scanner_init(input)) {
+	/* Record configuration file name for error reporting */
+	name_copy = strdup(name);
+	if (!name_copy)
+		sensors_fatal_error(__func__, "Out of memory");
+	sensors_add_config_files(&name_copy);
+
+	if (sensors_scanner_init(input, name_copy)) {
 		err = -SENSORS_ERR_PARSE;
 		goto exit_cleanup;
 	}
@@ -136,7 +143,7 @@ static int add_config_from_dir(const cha
 
 		input = fopen(path, "r");
 		if (input) {
-			res = parse_config(input);
+			res = parse_config(input, path);
 			fclose(input);
 		} else {
 			res = -SENSORS_ERR_PARSE;
@@ -163,16 +170,18 @@ int sensors_init(FILE *input)
 		goto exit_cleanup;
 
 	if (input) {
-		res = parse_config(input);
+		res = parse_config(input, NULL);
 		if (res)
 			goto exit_cleanup;
 	} else {
+		const char* name;
+
 		/* No configuration provided, use default */
-		input = fopen(DEFAULT_CONFIG_FILE, "r");
+		input = fopen(name = DEFAULT_CONFIG_FILE, "r");
 		if (!input && errno = ENOENT)
-			input = fopen(ALT_CONFIG_FILE, "r");
+			input = fopen(name = ALT_CONFIG_FILE, "r");
 		if (input) {
-			res = parse_config(input);
+			res = parse_config(input, name);
 			fclose(input);
 			if (res)
 				goto exit_cleanup;
@@ -305,4 +314,10 @@ void sensors_cleanup(void)
 	free(sensors_proc_bus);
 	sensors_proc_bus = NULL;
 	sensors_proc_bus_count = sensors_proc_bus_max = 0;
+
+	for (i = 0; i < sensors_config_files_count; i++)
+		free(sensors_config_files[i]);
+	free(sensors_config_files);
+	sensors_config_files = NULL;
+	sensors_config_files_count = sensors_config_files_max = 0;
 }
--- lm-sensors.orig/lib/conf-lex.l	2009-02-11 11:11:11.000000000 +0100
+++ lm-sensors/lib/conf-lex.l	2009-02-11 11:35:50.000000000 +0100
@@ -34,6 +34,7 @@ static char *buffer;
 
 char sensors_lex_error[100];
 
+const char *sensors_yyfilename;
 int sensors_yylineno;
 
 #define buffer_malloc() sensors_malloc_array(&buffer,&buffer_count,\
@@ -110,37 +111,43 @@ NUM	0|([1-9][[:digit:]]*)
   */
 
 label{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return LABEL;
 		}
 
 set{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return SET;
 		}
 
 compute{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return COMPUTE;
 		}
 
 bus{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return BUS;
 		}
 
 chip{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return CHIP;
 		}
 
 ignore{BLANK}*	{
-		  sensors_yylval.line = sensors_yylineno;
+		  sensors_yylval.line.filename = sensors_yyfilename;
+		  sensors_yylval.line.lineno = sensors_yylineno;
 		  BEGIN(MIDDLE);
 		  return IGNORE;
 		}
@@ -335,13 +342,14 @@ ignore{BLANK}*	{
 
 static YY_BUFFER_STATE scan_buf = (YY_BUFFER_STATE)0;
 
-int sensors_scanner_init(FILE *input)
+int sensors_scanner_init(FILE *input, const char *filename)
 {
 	BEGIN(0);
 	if (!(scan_buf = sensors_yy_create_buffer(input, YY_BUF_SIZE)))
 		return -1;
 
 	sensors_yy_switch_to_buffer(scan_buf);
+	sensors_yyfilename = filename;
 	sensors_yylineno = 1;
 	return 0;
 }
--- lm-sensors.orig/lib/scanner.h	2009-02-11 11:11:11.000000000 +0100
+++ lm-sensors/lib/scanner.h	2009-02-11 11:24:00.000000000 +0100
@@ -21,7 +21,7 @@
 #ifndef LIB_SENSORS_SCANNER_H
 #define LIB_SENSORS_SCANNER_H
 
-int sensors_scanner_init(FILE *input);
+int sensors_scanner_init(FILE *input, const char *filename);
 void sensors_scanner_exit(void);
 
 #endif
--- lm-sensors.orig/lib/test/test-scanner.c	2009-02-11 11:11:11.000000000 +0100
+++ lm-sensors/lib/test/test-scanner.c	2009-02-11 11:13:57.000000000 +0100
@@ -32,7 +32,7 @@ int main(void)
 	int result;
 
 	/* init the scanner */
-	if ((result = sensors_scanner_init(stdin)))
+	if ((result = sensors_scanner_init(stdin, NULL)))
 		return result;
 
 	do {
--- lm-sensors.orig/lib/data.c	2009-02-11 11:13:52.000000000 +0100
+++ lm-sensors/lib/data.c	2009-02-11 11:38:58.000000000 +0100
@@ -33,6 +33,10 @@
 
 const char *libsensors_version = LM_VERSION;
 
+char **sensors_config_files = NULL;
+int sensors_config_files_count = 0;
+int sensors_config_files_max = 0;
+
 sensors_chip *sensors_config_chips = NULL;
 int sensors_config_chips_count = 0;
 int sensors_config_chips_subst = 0;
@@ -238,7 +242,7 @@ int sensors_substitute_busses(void)
 
 	for (i = sensors_config_chips_subst;
 	     i < sensors_config_chips_count; i++) {
-		lineno = sensors_config_chips[i].lineno;
+		lineno = sensors_config_chips[i].line.lineno;
 		chips = &sensors_config_chips[i].chips;
 		for (j = 0; j < chips->fits_count; j++) {
 			/* We can only substitute if a specific bus number
--- lm-sensors.orig/lib/data.h	2009-02-11 11:13:52.000000000 +0100
+++ lm-sensors/lib/data.h	2009-02-11 11:38:48.000000000 +0100
@@ -60,12 +60,18 @@ typedef struct sensors_expr {
 	} data;
 } sensors_expr;
 
+/* Config file line reference */
+typedef struct sensors_config_line {
+	const char *filename;
+	int lineno;
+} sensors_config_line;
+
 /* Config file label declaration: a feature name, combined with the label
    value */
 typedef struct sensors_label {
 	char *name;
 	char *value;
-	int lineno;
+	sensors_config_line line;
 } sensors_label;
 
 /* Config file set declaration: a subfeature name, combined with an
@@ -73,7 +79,7 @@ typedef struct sensors_label {
 typedef struct sensors_set {
 	char *name;
 	sensors_expr *value;
-	int lineno;
+	sensors_config_line line;
 } sensors_set;
 
 /* Config file compute declaration: a feature name, combined with two
@@ -82,13 +88,13 @@ typedef struct sensors_compute {
 	char *name;
 	sensors_expr *from_proc;
 	sensors_expr *to_proc;
-	int lineno;
+	sensors_config_line line;
 } sensors_compute;
 
 /* Config file ignore declaration: a feature name */
 typedef struct sensors_ignore {
 	char *name;
-	int lineno;
+	sensors_config_line line;
 } sensors_ignore;
 
 /* A list of chip names, used to represent a config file chips declaration */
@@ -113,7 +119,7 @@ typedef struct sensors_chip {
 	sensors_ignore *ignores;
 	int ignores_count;
 	int ignores_max;
-	int lineno;
+	sensors_config_line line;
 } sensors_chip;
 
 /* Config file bus declaration: the bus type and number, combined with adapter
@@ -121,7 +127,7 @@ typedef struct sensors_chip {
 typedef struct sensors_bus {
 	char *adapter;
 	sensors_bus_id bus;
-	int lineno;
+	sensors_config_line line;
 } sensors_bus;
 
 /* Internal data about all features and subfeatures of a chip */
@@ -133,6 +139,14 @@ typedef struct sensors_chip_features {
 	int subfeature_count;
 } sensors_chip_features;
 
+extern char **sensors_config_files;
+extern int sensors_config_files_count;
+extern int sensors_config_files_max;
+
+#define sensors_add_config_files(el) sensors_add_array_el( \
+	(el), &sensors_config_files, &sensors_config_files_count, \
+	&sensors_config_files_max, sizeof(char *))
+
 extern sensors_chip *sensors_config_chips;
 extern int sensors_config_chips_count;
 extern int sensors_config_chips_subst;
--- lm-sensors.orig/lib/access.c	2009-02-11 11:11:50.000000000 +0100
+++ lm-sensors/lib/access.c	2009-02-11 11:40:33.000000000 +0100
@@ -512,7 +512,7 @@ static int sensors_do_this_chip_sets(con
 							chip->sets[i].name);
 			if (!subfeature) {
 				sensors_parse_error("Unknown feature name",
-						    chip->sets[i].lineno);
+						    chip->sets[i].line.lineno);
 				err = -SENSORS_ERR_NO_ENTRY;
 				continue;
 			}
@@ -522,14 +522,14 @@ static int sensors_do_this_chip_sets(con
 						0, &value);
 			if (res) {
 				sensors_parse_error("Error parsing expression",
-						    chip->sets[i].lineno);
+						    chip->sets[i].line.lineno);
 				err = res;
 				continue;
 			}
 			if ((res = sensors_set_value(name, subfeature->number,
 						     value))) {
 				sensors_parse_error("Failed to set value",
-						chip->sets[i].lineno);
+						chip->sets[i].line.lineno);
 				err = res;
 				continue;
 			}
--- lm-sensors.orig/lib/conf-parse.y	2009-02-11 11:31:15.000000000 +0100
+++ lm-sensors/lib/conf-parse.y	2009-02-11 11:41:08.000000000 +0100
@@ -84,7 +84,7 @@ static sensors_chip *current_chip = NULL
   sensors_expr *expr;
   sensors_bus_id bus;
   sensors_chip_name chip;
-  int line;
+  sensors_config_line line;
 }  
 
 %left <nothing> '-' '+'
@@ -131,7 +131,7 @@ line:	  bus_statement EOL
 
 bus_statement:	  BUS bus_id adapter_name
 		  { sensors_bus new_el;
-		    new_el.lineno = $1;
+		    new_el.line = $1;
 		    new_el.bus = $2;
                     new_el.adapter = $3;
 		    bus_add_el(&new_el);
@@ -146,7 +146,7 @@ label_statement:	  LABEL function_name s
 			      free($3);
 			      YYERROR;
 			    }
-			    new_el.lineno = $1;
+			    new_el.line = $1;
 			    new_el.name = $2;
 			    new_el.value = $3;
 			    label_add_el(&new_el);
@@ -161,7 +161,7 @@ set_statement:	  SET function_name expre
 		      sensors_free_expr($3);
 		      YYERROR;
 		    }
-		    new_el.lineno = $1;
+		    new_el.line = $1;
 		    new_el.name = $2;
 		    new_el.value = $3;
 		    set_add_el(&new_el);
@@ -177,7 +177,7 @@ compute_statement:	  COMPUTE function_na
 			      sensors_free_expr($5);
 			      YYERROR;
 			    }
-			    new_el.lineno = $1;
+			    new_el.line = $1;
 			    new_el.name = $2;
 			    new_el.from_proc = $3;
 			    new_el.to_proc = $5;
@@ -192,7 +192,7 @@ ignore_statement:	IGNORE function_name
 			    free($2);
 			    YYERROR;
 			  }
-			  new_el.lineno = $1;
+			  new_el.line = $1;
 			  new_el.name = $2;
 			  ignore_add_el(&new_el);
 			}
@@ -200,7 +200,7 @@ ignore_statement:	IGNORE function_name
 
 chip_statement:	  CHIP chip_name_list
 		  { sensors_chip new_el;
-		    new_el.lineno = $1;
+		    new_el.line = $1;
 		    new_el.labels = NULL;
 		    new_el.sets = NULL;
 		    new_el.computes = NULL;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
