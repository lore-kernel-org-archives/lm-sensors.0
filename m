From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 28 Apr 2015 12:33:02 +0000
Subject: [lm-sensors] [PATCH] libsensors: Fix sparse warnings
Message-Id: <20150428143302.3cdacd3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sparse wants forward declarations of static functions to be static as
well. For sensors_eval_expr, do that. For the error callbacks,
rearrange the code so that the forward declarations are no longer
needed.
---
 lib/access.c |    6 +++---
 lib/error.c  |   27 +++++++++++----------------
 2 files changed, 14 insertions(+), 19 deletions(-)

--- lm-sensors.orig/lib/access.c	2014-11-17 09:16:14.570052822 +0100
+++ lm-sensors/lib/access.c	2015-04-28 14:25:16.766433604 +0200
@@ -435,9 +435,9 @@ sensors_get_subfeature(const sensors_chi
 }
 
 /* Evaluate an expression */
-int sensors_eval_expr(const sensors_chip_features *chip_features,
-		      const sensors_expr *expr,
-		      double val, int depth, double *result)
+static int sensors_eval_expr(const sensors_chip_features *chip_features,
+			     const sensors_expr *expr,
+			     double val, int depth, double *result)
 {
 	double res1, res2;
 	int res;
--- lm-sensors.orig/lib/error.c	2014-03-20 11:06:57.490155748 +0100
+++ lm-sensors/lib/error.c	2015-04-28 14:22:59.151550121 +0200
@@ -24,18 +24,6 @@
 #include "error.h"
 #include "general.h"
 
-static void sensors_default_parse_error(const char *err, int lineno);
-static void sensors_default_parse_error_wfn(const char *err,
-					    const char *filename, int lineno);
-static void sensors_default_fatal_error(const char *proc, const char *err);
-
-void (*sensors_parse_error) (const char *err, int lineno) -						sensors_default_parse_error;
-void (*sensors_parse_error_wfn) (const char *err, const char *filename,
-				 int lineno) = sensors_default_parse_error_wfn;
-void (*sensors_fatal_error) (const char *proc, const char *err) -						sensors_default_fatal_error;
-
 static const char *errorlist[] = {
 	/* Invalid error code    */ "Unknown error",
 	/* SENSORS_ERR_WILDCARDS */ "Wildcard found in chip name",
@@ -60,7 +48,7 @@ const char *sensors_strerror(int errnum)
 	return errorlist[errnum];
 }
 
-void sensors_default_parse_error(const char *err, int lineno)
+static void sensors_default_parse_error(const char *err, int lineno)
 {
 	if (lineno)
 		fprintf(stderr, "Error: Line %d: %s\n", lineno, err);
@@ -68,8 +56,8 @@ void sensors_default_parse_error(const c
 		fprintf(stderr, "Error: %s\n", err);
 }
 
-void sensors_default_parse_error_wfn(const char *err,
-				     const char *filename, int lineno)
+static void sensors_default_parse_error_wfn(const char *err,
+					    const char *filename, int lineno)
 {
 	/* If application provided a custom parse error reporting function
 	   but not the variant with the filename, fall back to the original
@@ -85,8 +73,15 @@ void sensors_default_parse_error_wfn(con
 		fprintf(stderr, "Error: File %s: %s\n", filename, err);
 }
 
-void sensors_default_fatal_error(const char *proc, const char *err)
+static void sensors_default_fatal_error(const char *proc, const char *err)
 {
 	fprintf(stderr, "Fatal error in `%s': %s\n", proc, err);
 	exit(1);
 }
+
+void (*sensors_parse_error) (const char *err, int lineno) +						sensors_default_parse_error;
+void (*sensors_parse_error_wfn) (const char *err, const char *filename,
+				 int lineno) = sensors_default_parse_error_wfn;
+void (*sensors_fatal_error) (const char *proc, const char *err) +						sensors_default_fatal_error;


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
