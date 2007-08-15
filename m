From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 15:40:20 +0000
Subject: [lm-sensors] [PATCH 3/6] libsensors4: Don't substitute the isa bus
Message-Id: <20070815174020.055f6ea3@hyperion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't handle the isa bus in sensors_parse_i2cbus_name(). We really
don't need to, as there is a single ISA bus, there's no need for
substituting anything.

---
 lib/data.c  |    4 ----
 lib/sysfs.c |   10 ++++------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- lm-sensors-3.orig/lib/data.c	2007-08-15 12:14:51.000000000 +0200
+++ lm-sensors-3/lib/data.c	2007-08-15 12:14:55.000000000 +0200
@@ -190,10 +190,6 @@ int sensors_parse_i2cbus_name(const char
 {
   int i;
 
-  if (! strcmp(name,"isa")) {
-    *res = SENSORS_CHIP_NAME_BUS_ISA;
-    return 0;
-  }
   if (strncmp(name,"i2c-",4)) {
     return -SENSORS_ERR_BUS_NAME;
   }
--- lm-sensors-3.orig/lib/sysfs.c	2007-08-15 12:14:51.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-08-15 12:14:55.000000000 +0200
@@ -374,17 +374,15 @@ int sensors_read_sysfs_bus(void)
 		      (attr = sysfs_get_device_attr(dev, "name"))))
 			continue;
 
+		if (sscanf(clsdev->name, "i2c-%d", &entry.number) != 1 ||
+		    entry.number = 9191) /* legacy ISA */
+			continue;
+
 		/* NB: attr->value[attr->len-1] = '\n'; chop that off */
 		entry.adapter = strndup(attr->value, attr->len - 1);
 		if (!entry.adapter)
 			sensors_fatal_error(__FUNCTION__, "out of memory");
 
-		if (!strncmp(entry.adapter, "ISA ", 4)) {
-			entry.number = SENSORS_CHIP_NAME_BUS_ISA;
-		} else if (sscanf(clsdev->name, "i2c-%d", &entry.number) != 1) {
-			continue;
-		}
-
 		sensors_add_proc_bus(&entry);
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
