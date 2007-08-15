From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 15:36:23 +0000
Subject: [lm-sensors] [PATCH 1/6] libsensors4: Drop dummy adapter type
Message-Id: <20070815173623.2626979b@hyperion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop support for "dummy" bus types. The kernel no longer supports
such fake i2c buses, so neither should we. Instead, non-i2c buses are
handled explicitly.

---
 lib/access.c        |    2 --
 lib/data.c          |    8 +-------
 lib/sensors.h       |    3 +--
 lib/sysfs.c         |    2 +-
 prog/sensors/main.c |    3 ---
 5 files changed, 3 insertions(+), 15 deletions(-)

--- lm-sensors-3.orig/lib/access.c	2007-08-15 12:00:23.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-08-15 12:02:41.000000000 +0200
@@ -326,8 +326,6 @@ const char *sensors_get_adapter_name(int
 		return "ISA adapter";
 	if (bus_nr = SENSORS_CHIP_NAME_BUS_PCI)
 		return "PCI adapter";
-	if (bus_nr = SENSORS_CHIP_NAME_BUS_DUMMY)
-		return "Dummy adapter";
 	for (i = 0; i < sensors_proc_bus_count; i++)
 		if (sensors_proc_bus[i].number = bus_nr)
 			return sensors_proc_bus[i].adapter;
--- lm-sensors-3.orig/lib/data.c	2007-08-11 17:28:56.000000000 +0200
+++ lm-sensors-3/lib/data.c	2007-08-15 12:02:18.000000000 +0200
@@ -171,10 +171,6 @@ DONE2:;
     if (part2)
       *(part2-1) = '-';
     *(part3-1) = '-';
-  } else if(part3 && part4) {
-    res->bus = SENSORS_CHIP_NAME_BUS_DUMMY;
-    if (! (res->busname = strdup(part3)))
-      sensors_fatal_error("sensors_parse_chip_name","Allocating new busname");
   } else
     goto ERROR;
     
@@ -202,8 +198,7 @@ int sensors_parse_i2cbus_name(const char
     return 0;
   }
   if (strncmp(name,"i2c-",4)) {
-    *res = SENSORS_CHIP_NAME_BUS_DUMMY;
-    return 0;
+    return -SENSORS_ERR_BUS_NAME;
   }
   name += 4;
   if ((strlen(name) > 3) || (strlen(name) = 0))
@@ -265,7 +260,6 @@ int sensors_substitute_busses(void)
     for(j = 0; j < chips->fits_count; j++)
       if ((chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ISA) &&
           (chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_PCI) &&
-          (chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_DUMMY) &&
           (chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ANY) &&
           (chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ANY_I2C))
         if ((err = sensors_substitute_chip(chips->fits+j, lineno)))
--- lm-sensors-3.orig/lib/sensors.h	2007-08-15 12:00:23.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2007-08-15 12:02:18.000000000 +0200
@@ -29,7 +29,6 @@
 #define SENSORS_CHIP_NAME_BUS_ISA -1
 #define SENSORS_CHIP_NAME_BUS_ANY -2
 #define SENSORS_CHIP_NAME_BUS_ANY_I2C -3
-#define SENSORS_CHIP_NAME_BUS_DUMMY -4
 #define SENSORS_CHIP_NAME_BUS_PCI -5
 #define SENSORS_CHIP_NAME_ADDR_ANY -1
 
@@ -44,7 +43,7 @@ typedef struct sensors_chip_name {
   char *prefix;
   int bus;
   int addr;
-  char *busname;	/* if dummy */
+  char *busname;
 } sensors_chip_name;
 
 /* (Re)load the configuration file and the detected chips list. If this 
--- lm-sensors-3.orig/lib/sysfs.c	2007-08-13 22:16:38.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-08-15 12:02:18.000000000 +0200
@@ -382,7 +382,7 @@ int sensors_read_sysfs_bus(void)
 		if (!strncmp(entry.adapter, "ISA ", 4)) {
 			entry.number = SENSORS_CHIP_NAME_BUS_ISA;
 		} else if (sscanf(clsdev->name, "i2c-%d", &entry.number) != 1) {
-			entry.number = SENSORS_CHIP_NAME_BUS_DUMMY;
+			continue;
 		}
 
 		sensors_add_proc_bus(&entry);
--- lm-sensors-3.orig/prog/sensors/main.c	2007-08-15 12:00:23.000000000 +0200
+++ lm-sensors-3/prog/sensors/main.c	2007-08-15 12:02:18.000000000 +0200
@@ -302,9 +302,6 @@ const char *sprintf_chip_name(const sens
     snprintf(buf, BUF_SIZE, "%s-isa-%04x", name->prefix, name->addr);
   else if (name->bus = SENSORS_CHIP_NAME_BUS_PCI)
     snprintf(buf, BUF_SIZE, "%s-pci-%04x", name->prefix, name->addr);
-  else if (name->bus = SENSORS_CHIP_NAME_BUS_DUMMY)
-    snprintf(buf, BUF_SIZE, "%s-%s-%04x", name->prefix, name->busname,
-             name->addr);
   else
     snprintf(buf, BUF_SIZE, "%s-i2c-%d-%02x", name->prefix, name->bus,
              name->addr);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
