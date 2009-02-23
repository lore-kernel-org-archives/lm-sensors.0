From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 23 Feb 2009 08:44:03 +0000
Subject: [lm-sensors] [PATCH v2 2/2] libsensors: Use __func__ in
Message-Id: <20090223084402.GA4511@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

this is an updated version of the patch from 20.02. According to your
hint I have patched conf-parse.y and not conf-parse.c.

This patch unifies sensors_fatal_error() calls. Uses __func__ to get
the function name.

Andre

---
 access.c     |    3 +--
 conf-parse.y |    3 +--
 data.c       |    2 +-
 general.c    |    7 +++----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff -urp lm-sensors-dev/lib/access.c my-sensors/lib/access.c
--- lm-sensors-dev/lib/access.c	2009-02-19 23:17:15.000000000 +0100
+++ my-sensors/lib/access.c	2009-02-22 17:57:28.000000000 +0100
@@ -201,8 +201,7 @@ char *sensors_get_label(const sensors_ch
 	
 sensors_get_label_exit:
 	if (!label)
-		sensors_fatal_error("sensors_get_label",
-				    "Allocating label text");
+		sensors_fatal_error(__func__, "Allocating label text");
 	return label;
 }
 
diff -urp lm-sensors-dev/lib/conf-parse.y my-sensors/lib/conf-parse.y
--- lm-sensors-dev/lib/conf-parse.y	2009-02-16 14:12:50.000000000 +0100
+++ my-sensors/lib/conf-parse.y	2009-02-22 18:02:42.000000000 +0100
@@ -342,7 +342,6 @@ sensors_expr *malloc_expr(void)
 {
   sensors_expr *res = malloc(sizeof(sensors_expr));
   if (! res)
-    sensors_fatal_error("malloc_expr","Allocating a new expression");
+    sensors_fatal_error(__func__, "Allocating a new expression");
   return res;
 }
-  
diff -urp lm-sensors-dev/lib/data.c my-sensors/lib/data.c
--- lm-sensors-dev/lib/data.c	2009-02-19 23:17:15.000000000 +0100
+++ my-sensors/lib/data.c	2009-02-22 17:57:28.000000000 +0100
@@ -88,7 +88,7 @@ int sensors_parse_chip_name(const char *
 			return -SENSORS_ERR_CHIP_NAME;
 		res->prefix = strndup(name, dash - name);
 		if (!res->prefix)
-			sensors_fatal_error("sensors_parse_chip_name",
+			sensors_fatal_error(__func__,
 					    "Allocating name prefix");
 		name = dash + 1;
 	}
diff -urp lm-sensors-dev/lib/general.c my-sensors/lib/general.c
--- lm-sensors-dev/lib/general.c	2009-02-19 23:17:15.000000000 +0100
+++ my-sensors/lib/general.c	2009-02-22 17:57:28.000000000 +0100
@@ -34,8 +34,7 @@ void sensors_malloc_array(void *list, in
 
 	*my_list = malloc(el_size*A_BUNCH);
 	if (! *my_list)
-		sensors_fatal_error("sensors_malloc_array",
-				    "Allocating new elements");
+		sensors_fatal_error(__func__, "Allocating new elements");
 	*max_el = A_BUNCH;
 	*num_el = 0;
 }
@@ -59,7 +58,7 @@ void sensors_add_array_el(const void *el
 		new_max_el = *max_el + A_BUNCH;
 		*my_list = realloc(*my_list, new_max_el * el_size);
 		if (! *my_list)
-			sensors_fatal_error("sensors_add_array_el",
+			sensors_fatal_error(__func__,
 					    "Allocating new elements");
 		*max_el = new_max_el;
 	}
@@ -77,7 +76,7 @@ void sensors_add_array_els(const void *e
 		new_max_el -= new_max_el % A_BUNCH;
 		*my_list = realloc(*my_list, new_max_el * el_size);
 		if (! *my_list)
-			sensors_fatal_error("sensors_add_array_els",
+			sensors_fatal_error(__func__,
 					    "Allocating new elements");
 		*max_el = new_max_el;
 	}

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
