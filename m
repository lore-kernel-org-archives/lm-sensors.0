From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 15:42:40 +0000
Subject: [lm-sensors] [PATCH 4/6] libsensors4: Use strtoul
Message-Id: <20070815174240.34ddf040@hyperion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use strtoul() instead of parsing integers on our own.

---
 lib/data.c |   61 +++++++++----------------------------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

Index: lm-sensors-3.0.0/lib/data.c
=================================--- lm-sensors-3.0.0.orig/lib/data.c	2007-07-31 16:39:22.000000000 +0200
+++ lm-sensors-3.0.0/lib/data.c	2007-07-31 17:10:18.000000000 +0200
@@ -76,7 +76,7 @@ int sensors_parse_chip_name(const char *
 {
   char *part2, *part3, *part4;
   char *name = strdup(orig_name);
-  int i;
+  char *endptr;
 
   if (! name)
     sensors_fatal_error("sensors_parse_chip_name","Allocating new name");
@@ -103,28 +103,9 @@ int sensors_parse_chip_name(const char *
   if (!strcmp(part4,"*"))
     res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
   else {
-    if ((strlen(part4) > 4) || (strlen(part4) = 0))
+    res->addr = strtoul(part4, &endptr, 16);
+    if (*part4 = '\0' || *endptr != '\0' || res->addr < 0)
       goto ERROR;
-    res->addr = 0;
-    for (i = 0; ; i++) { 
-      switch (part4[i]) {
-      case '0': case '1': case '2': case '3': case '4':
-      case '5': case '6': case '7': case '8': case '9':
-        res->addr = res->addr * 16 + part4[i] - '0';
-        break;
-      case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
-        res->addr = res->addr * 16 + part4[i] - 'a' + 10;
-        break;
-      case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
-        res->addr = res->addr * 16 + part4[i] - 'A' + 10;
-        break;
-      case 0:
-        goto DONE;
-      default:
-        goto ERROR;
-      }
-    }
-DONE:;
   }
 
   /* OK. So let's look at part3. It must either be the number of the
@@ -147,22 +128,9 @@ DONE:;
   } else if (part2 && !strcmp(part2,"i2c") && !strcmp(part3,"*"))
     res->bus = SENSORS_CHIP_NAME_BUS_ANY_I2C;
   else if (part2 && !strcmp(part2,"i2c")) {
-    if ((strlen(part3) > 3) || (strlen(part3) = 0))
+    res->bus = strtoul(part3, &endptr, 10);
+    if (*part3 = '\0' || *endptr != '\0' || res->bus < 0)
       goto ERROR;
-    res->bus = 0;
-    for (i = 0; ; i++) { 
-      switch (part3[i]) {
-      case '0': case '1': case '2': case '3': case '4':
-      case '5': case '6': case '7': case '8': case '9':
-        res->bus = res->bus * 10 + part3[i] - '0';
-        break;
-      case 0:
-        goto DONE2;
-      default:
-        goto ERROR;
-      }
-    }
-DONE2:;
   } else if (res->addr = SENSORS_CHIP_NAME_ADDR_ANY) {
     res->bus = SENSORS_CHIP_NAME_BUS_ANY;
     if (part2)
@@ -188,27 +156,16 @@ ERROR:
 
 int sensors_parse_i2cbus_name(const char *name, int *res)
 {
-  int i;
+  char *endptr;
 
   if (strncmp(name,"i2c-",4)) {
     return -SENSORS_ERR_BUS_NAME;
   }
   name += 4;
-  if ((strlen(name) > 3) || (strlen(name) = 0))
+  *res = strtoul(name, &endptr, 10);
+  if (*name = '\0' || *endptr != '\0' || *res < 0)
     return -SENSORS_ERR_BUS_NAME;
-  *res = 0;
-  for (i = 0; ; i++) { 
-    switch (name[i]) {
-    case '0': case '1': case '2': case '3': case '4':
-    case '5': case '6': case '7': case '8': case '9':
-      *res = *res * 10 + name[i] - '0';
-      break;
-    case 0:
-      return 0;
-    default:
-      return -SENSORS_ERR_BUS_NAME;
-    }
-  }
+  return 0;
 }
 
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
