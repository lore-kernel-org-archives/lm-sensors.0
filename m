From: Sergey Vlasov <vsu@altlinux.ru>
Date: Mon, 14 Jul 2008 13:28:03 +0000
Subject: [lm-sensors] [lm_sensors legacy PATCH] Rename free_expr() to
Message-Id: <1216042083-11676-1-git-send-email-vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The free_expr() function is no longer static in lib/init.c (it is also
used in lib/conf-parse.y), and therefore must be renamed according to
the libsensors naming conventions.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 lib/conf-parse.y |    6 +++---
 lib/init.c       |   12 ++++++------
 lib/init.h       |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/conf-parse.y b/lib/conf-parse.y
index 9e75606..84eaee2 100644
--- a/lib/conf-parse.y
+++ b/lib/conf-parse.y
@@ -170,7 +170,7 @@ set_statement:	  SET function_name expression
 		    if (!current_chip) {
 		      sensors_yyerror("Set statement before first chip statement");
 		      free($2);
-		      free_expr($3);
+		      sensors_free_expr($3);
 		      YYERROR;
 		    }
 		    new_el.lineno = $1;
@@ -185,8 +185,8 @@ compute_statement:	  COMPUTE function_name expression ',' expression
 			    if (!current_chip) {
 			      sensors_yyerror("Compute statement before first chip statement");
 			      free($2);
-			      free_expr($3);
-			      free_expr($5);
+			      sensors_free_expr($3);
+			      sensors_free_expr($5);
 			      YYERROR;
 			    }
 			    new_el.lineno = $1;
diff --git a/lib/init.c b/lib/init.c
index 2e7f696..158f0b1 100644
--- a/lib/init.c
+++ b/lib/init.c
@@ -171,14 +171,14 @@ void free_label(sensors_label label)
 void free_set(sensors_set set)
 {
   free(set.name);
-  free_expr(set.value);
+  sensors_free_expr(set.value);
 }
 
 void free_compute(sensors_compute compute)
 {
   free(compute.name);
-  free_expr(compute.from_proc);
-  free_expr(compute.to_proc);
+  sensors_free_expr(compute.from_proc);
+  sensors_free_expr(compute.to_proc);
 }
 
 void free_ignore(sensors_ignore ignore)
@@ -186,15 +186,15 @@ void free_ignore(sensors_ignore ignore)
   free(ignore.name);
 }
 
-void free_expr(sensors_expr *expr)
+void sensors_free_expr(sensors_expr *expr)
 {
   if ((expr->kind) = sensors_kind_var)
     free(expr->data.var);
   else if ((expr->kind) = sensors_kind_sub) {
     if (expr->data.subexpr.sub1)
-      free_expr(expr->data.subexpr.sub1);
+      sensors_free_expr(expr->data.subexpr.sub1);
     if (expr->data.subexpr.sub2)
-      free_expr(expr->data.subexpr.sub2);
+      sensors_free_expr(expr->data.subexpr.sub2);
   }
   free(expr);
 }
diff --git a/lib/init.h b/lib/init.h
index c413e39..ae0476a 100644
--- a/lib/init.h
+++ b/lib/init.h
@@ -22,6 +22,6 @@
 
 #include "data.h"
 
-void free_expr(sensors_expr *expr);
+void sensors_free_expr(sensors_expr *expr);
 
 #endif /* def LIB_SENSORS_INIT_H */
-- 
1.5.6.2.305.g2938b


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
