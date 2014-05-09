From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 09 May 2014 08:27:30 +0000
Subject: [lm-sensors] [PATCH 1/3] libsensors: Store the kernel class device name of each hwmon device
Message-Id: <20140509102730.03fe1658@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We will need this soon.
---
 lib/data.h  |    3 +++
 lib/init.c  |    1 +
 lib/sysfs.c |   20 ++++++++++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

--- lm-sensors.orig/lib/data.h	2014-05-09 07:50:24.515126418 +0200
+++ lm-sensors/lib/data.h	2014-05-09 09:09:20.391454565 +0200
@@ -131,8 +131,11 @@ typedef struct sensors_bus {
 } sensors_bus;
 
 /* Internal data about all features and subfeatures of a chip */
+/* Note: kernel_name would rather go into struct sensors_chip_name but doing
+   so would change the ABI */
 typedef struct sensors_chip_features {
 	struct sensors_chip_name chip;
+	char *kernel_name;
 	struct sensors_feature *feature;
 	struct sensors_subfeature *subfeature;
 	int feature_count;
--- lm-sensors.orig/lib/init.c	2014-05-09 07:50:24.515126418 +0200
+++ lm-sensors/lib/init.c	2014-05-09 07:54:00.035197170 +0200
@@ -239,6 +239,7 @@ static void free_chip_features(sensors_c
 	for (i = 0; i < features->feature_count; i++)
 		free(features->feature[i].name);
 	free(features->feature);
+	free(features->kernel_name);
 }
 
 static void free_label(sensors_label *label)
--- lm-sensors.orig/lib/sysfs.c	2014-05-09 07:50:24.515126418 +0200
+++ lm-sensors/lib/sysfs.c	2014-05-09 07:54:00.035197170 +0200
@@ -614,7 +614,8 @@ int sensors_init_sysfs(void)
 /* returns: number of devices added (0 or 1) if successful, <0 otherwise */
 static int sensors_read_one_sysfs_chip(const char *dev_path,
 				       const char *dev_name,
-				       const char *hwmon_path)
+				       const char *hwmon_path,
+				       const char *classdev)
 {
 	int domain, bus, slot, fn, vendor, product, id;
 	int err = -SENSORS_ERR_KERNEL;
@@ -633,6 +634,12 @@ static int sensors_read_one_sysfs_chip(c
 	if (!entry.chip.path)
 		sensors_fatal_error(__func__, "Out of memory");
 
+	if (classdev) {
+		entry.kernel_name = strdup(classdev);
+		if (!entry.kernel_name)
+			sensors_fatal_error(__func__, "Out of memory");
+	}
+
 	if (dev_path = NULL) {
 		/* Virtual device */
 		entry.chip.bus.type = SENSORS_BUS_TYPE_VIRTUAL;
@@ -735,6 +742,7 @@ done:
 	return 1;
 
 exit_free:
+	free(entry.kernel_name);
 	free(entry.chip.prefix);
 	free(entry.chip.path);
 	return err;
@@ -745,7 +753,7 @@ static int sensors_add_hwmon_device_comp
 {
 	int err;
 
-	err = sensors_read_one_sysfs_chip(path, dev_name, path);
+	err = sensors_read_one_sysfs_chip(path, dev_name, path, NULL);
 	if (err < 0)
 		return err;
 	return 0;
@@ -768,23 +776,23 @@ static int sensors_add_hwmon_device(cons
 	char linkpath[NAME_MAX];
 	char device[NAME_MAX], *device_p;
 	int dev_len, err;
-	(void)classdev; /* hide warning */
 
 	snprintf(linkpath, NAME_MAX, "%s/device", path);
 	dev_len = readlink(linkpath, device, NAME_MAX - 1);
 	if (dev_len < 0) {
 		/* No device link? Treat as virtual */
-		err = sensors_read_one_sysfs_chip(NULL, NULL, path);
+		err = sensors_read_one_sysfs_chip(NULL, NULL, path, classdev);
 	} else {
 		device[dev_len] = '\0';
 		device_p = strrchr(device, '/') + 1;
 
 		/* The attributes we want might be those of the hwmon class
 		   device, or those of the device itself. */
-		err = sensors_read_one_sysfs_chip(linkpath, device_p, path);
+		err = sensors_read_one_sysfs_chip(linkpath, device_p, path,
+						  classdev);
 		if (err = 0)
 			err = sensors_read_one_sysfs_chip(linkpath, device_p,
-							  linkpath);
+							  linkpath, classdev);
 	}
 	if (err < 0)
 		return err;

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
