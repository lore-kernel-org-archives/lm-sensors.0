From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:04:51 +0000
Subject: [lm-sensors] [PATCH 1/7] libsensors4: Drop sensors_strip_of_spaces
Message-Id: <20070902220451.5266a262@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop sensors_strip_of_spaces. There's no rationale for stripping
trailing spaces of bus names and nothing else.

---
 lib/conf-parse.y |    3 +--
 lib/general.c    |    8 --------
 lib/general.h    |    3 ---
 3 files changed, 1 insertion(+), 13 deletions(-)

--- lm-sensors-3.orig/lib/conf-parse.y	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/conf-parse.y	2007-09-02 16:16:25.000000000 +0200
@@ -298,8 +298,7 @@ bus_id:		  NAME
 ;
 
 adapter_name:	  NAME
-		  { sensors_strip_of_spaces($1);
-		    $$ = $1; }
+		  { $$ = $1; }
 ;
 
 function_name:	  NAME
--- lm-sensors-3.orig/lib/general.h	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/general.h	2007-09-02 16:16:25.000000000 +0200
@@ -33,9 +33,6 @@ void sensors_add_array_el(const void *el
 void sensors_add_array_els(const void *els, int nr_els, void *list,
 			   int *num_el, int *max_el, int el_size);
 
-/* Strip a string of all terminating spaces */
-void sensors_strip_of_spaces(char *name);
-
 #define ARRAY_SIZE(arr)	(int)(sizeof(arr) / sizeof((arr)[0]))
 
 #endif /* LIB_SENSORS_GENERAL */
--- lm-sensors-3.orig/lib/general.c	2007-09-02 16:16:15.000000000 +0200
+++ lm-sensors-3/lib/general.c	2007-09-02 16:16:25.000000000 +0200
@@ -83,11 +83,3 @@ void sensors_add_array_els(const void *e
 	memcpy(((char *)*my_list) + *num_el * el_size, els, el_size * nr_els);
 	*num_el += nr_els;
 }
-
-/* Strip a string of all terminating spaces */
-void sensors_strip_of_spaces(char *name)
-{
-	int i;
-	for (i = strlen(name) - 1; i >= 0 && name[i] = ' '; i--);
-	name[i + 1] = '\0';
-}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
