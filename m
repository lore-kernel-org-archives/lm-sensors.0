From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Apr 2008 13:23:30 +0000
Subject: [lm-sensors] [PATCH] Add virtual hwmon device support to libsensors
Message-Id: <20080409152330.2900add8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As Zhang Rui is adding hwmon support to the generic thermal zone driver
[1], we need to add support for virtual hwmon devices to libsensors.
The hwmon devices created by Rui's code do not have any parent device,
they are purely virtual, and libsensors doesn't expect this. There's a
bug reported in Red Hat's bugzilla already [2].

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022791.html
[2] https://bugzilla.redhat.com/show_bug.cgi?idC7637

Here's a proposed implementation for virtual devices support:

---
 doc/libsensors-API.txt |   14 ++++++++++++++
 lib/access.c           |    2 ++
 lib/data.c             |    5 +++++
 lib/sensors.h          |    3 ++-
 lib/sysfs.c            |   32 +++++++++++++++++++++++---------
 5 files changed, 46 insertions(+), 10 deletions(-)

--- lm-sensors-3.orig/lib/sensors.h	2008-04-09 13:50:23.000000000 +0200
+++ lm-sensors-3/lib/sensors.h	2008-04-09 13:51:47.000000000 +0200
@@ -31,7 +31,7 @@
    when the API + ABI breaks), the third digit is incremented to track small
    API additions like new flags / enum values. The second digit is for tracking
    larger additions like new methods. */
-#define SENSORS_API_VERSION 0x400
+#define SENSORS_API_VERSION 0x401
 
 #define SENSORS_CHIP_NAME_PREFIX_ANY NULL
 #define SENSORS_CHIP_NAME_ADDR_ANY -1
@@ -41,6 +41,7 @@
 #define SENSORS_BUS_TYPE_ISA	1
 #define SENSORS_BUS_TYPE_PCI	2
 #define SENSORS_BUS_TYPE_SPI	3
+#define SENSORS_BUS_TYPE_VIRTUAL	4
 #define SENSORS_BUS_NR_ANY	(-1)
 #define SENSORS_BUS_NR_IGNORE	(-2)
 
--- lm-sensors-3.orig/lib/access.c	2008-04-09 13:50:23.000000000 +0200
+++ lm-sensors-3/lib/access.c	2008-04-09 13:52:16.000000000 +0200
@@ -345,6 +345,8 @@ const char *sensors_get_adapter_name(con
 	   so we don't have any custom string to return. */
 	case SENSORS_BUS_TYPE_SPI:
 		return "SPI adapter";
+	case SENSORS_BUS_TYPE_VIRTUAL:
+		return "Virtual device";
 	}
 
 	/* bus types with several instances */
--- lm-sensors-3.orig/lib/sysfs.c	2008-04-09 13:50:23.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2008-04-09 13:53:31.000000000 +0200
@@ -476,6 +476,15 @@ static int sensors_read_one_sysfs_chip(c
 	if (!entry.chip.path)
 		sensors_fatal_error(__func__, "Out of memory");
 
+	if (dev_path = NULL) {
+		/* Virtual device */
+		entry.chip.bus.type = SENSORS_BUS_TYPE_VIRTUAL;
+		entry.chip.bus.nr = 0;
+		/* For now we assume that virtual devices are unique */
+		entry.chip.addr = 0;
+		goto done;
+	}
+
 	/* Find bus type */
 	snprintf(linkpath, NAME_MAX, "%s/subsystem", dev_path);
 	sub_len = readlink(linkpath, subsys_path, NAME_MAX - 1);
@@ -544,6 +553,7 @@ static int sensors_read_one_sysfs_chip(c
 		goto exit_free;
 	}
 
+done:
 	if (sensors_read_dynamic_chip(&entry, hwmon_path) < 0)
 		goto exit_free;
 	if (!entry.subfeature) { /* No subfeature, discard chip */
@@ -592,16 +602,20 @@ static int sensors_add_hwmon_device(cons
 
 	snprintf(linkpath, NAME_MAX, "%s/device", path);
 	dev_len = readlink(linkpath, device, NAME_MAX - 1);
-	if (dev_len < 0)
-		return -SENSORS_ERR_KERNEL;
-	device[dev_len] = '\0';
-	device_p = strrchr(device, '/') + 1;
+	if (dev_len < 0) {
+		/* No device link? Treat as virtual */
+		err = sensors_read_one_sysfs_chip(NULL, NULL, path);
+	} else {
+		device[dev_len] = '\0';
+		device_p = strrchr(device, '/') + 1;
 
-	/* The attributes we want might be those of the hwmon class device,
-	   or those of the device itself. */
-	err = sensors_read_one_sysfs_chip(linkpath, device_p, path);
-	if (err = 0)
-		err = sensors_read_one_sysfs_chip(linkpath, device_p, linkpath);
+		/* The attributes we want might be those of the hwmon class
+		   device, or those of the device itself. */
+		err = sensors_read_one_sysfs_chip(linkpath, device_p, path);
+		if (err = 0)
+			err = sensors_read_one_sysfs_chip(linkpath, device_p,
+							  linkpath);
+	}
 	if (err < 0)
 		return err;
 	return 0;
--- lm-sensors-3.orig/lib/data.c	2008-04-09 13:50:23.000000000 +0200
+++ lm-sensors-3/lib/data.c	2008-04-09 13:52:22.000000000 +0200
@@ -109,6 +109,8 @@ int sensors_parse_chip_name(const char *
 		res->bus.type = SENSORS_BUS_TYPE_PCI;
 	else if (!strncmp(name, "spi", dash - name))
 		res->bus.type = SENSORS_BUS_TYPE_SPI;
+	else if (!strncmp(name, "virtual", dash - name))
+		res->bus.type = SENSORS_BUS_TYPE_VIRTUAL;
 	else
 		goto ERROR;
 	name = dash + 1;
@@ -169,6 +171,9 @@ int sensors_snprintf_chip_name(char *str
 	case SENSORS_BUS_TYPE_SPI:
 		return snprintf(str, size, "%s-spi-%hd-%x", chip->prefix,
 				chip->bus.nr, chip->addr);
+	case SENSORS_BUS_TYPE_VIRTUAL:
+		return snprintf(str, size, "%s-virtual-%x", chip->prefix,
+				chip->addr);
 	}
 
 	return -SENSORS_ERR_CHIP_NAME;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lm-sensors-3/doc/libsensors-API.txt	2008-04-09 14:48:42.000000000 +0200
@@ -0,0 +1,14 @@
+libsensors API history
+===========
+
+SENSORS_API_VERSION tracks the evolutions made to the libsensors API
+over time. This document summarizes these evolutions so that application
+authors can quickly figure out how to test for the availability of a
+given new feature.
+
+0x401	lm-sensors SVN
+* Added bus type "virtual":
+  #define SENSORS_BUS_TYPE_VIRTUAL	4
+
+0x400	lm-sensors 3.0.0 to 3.0.1
+* Initial API.

Admittedly there are a couple of things which could be discussed:

* The code assumes that virtual devices are unique, i.e. foo-virtual-*
can only match one device, which we arbitrarily name foo-virtual-0.
Right now, the only implementer of virtual devices guarantees device
uniqueness by construction. I'm not completely sure if this is a
reasonable assumption. If not, I'm not sure how we want to address the
problem.

* Still, the virtual devices are named foo-virtual-0 rather than just
foo-virtual. I made it that way for consistency with the other device
types and because doing otherwise would require additional code.

I welcome comments on this patch. If nobody objects, I will apply it to
the lm-sensors SVN tree in the next few days (without it, lm-sensors is
broken for everyone testing Rui's patches). The exact implementation can
always be adjusted later if needed.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
