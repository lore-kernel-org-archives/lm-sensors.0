From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 11:01:53 +0000
Subject: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <20071129120153.26879145@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is a proposed patch to make libsensors no longer depend on
libsysfs. Instead, it accesses sysfs directly, using 3 embedded helper
functions. My motivations for doing this are:
* As far as I know, libsysfs is no longer maintained.
* libsysfs does much more than we need. For example, when asking for a
  device attribute list, libsysfs will read the contents and permissions
  of all attributes. Not only does this waste CPU cycles per se, but in
  the case of hwmon driver it also triggers register reads, which can be
  slow for SMBus chips.
* libsysfs enforces the difference between devices and class devices,
  while future changes will be easier if we can handle both types alike.

The diffstat goes like this:
 INSTALL       |    2
 lib/Module.mk |    2
 lib/sysfs.c   |  323 ++++++++++++++++++++++++++++++++++------------------------
 3 files changed, 191 insertions(+), 136 deletions(-)

So basically ~60 lines of code are added, not really significant
compared to the total number of lines of code of libsensors (6500), and
also very small compared to the size of libsysfs (4500 lines of code.)

As for performance benefits, numbers speak for themselves: "sensors" is
more than twice as fast as before! Just counting the sysfs part of
sensors_init, the new code is 4.7x as fast as the original
libsysfs-based code. I've also checked memory consumption and the
improvement is very visible: the overall memory used is divided by 4
(from 1,025,281 bytes to 259,110 bytes in my example, measured using
valgrind.)

Testers and comments welcome.

--- lm-sensors-3.orig/INSTALL	2007-11-29 11:32:32.000000000 +0100
+++ lm-sensors-3/INSTALL	2007-11-29 11:39:45.000000000 +0100
@@ -14,11 +14,9 @@ Build-time dependencies:
 * gcc
 * bison
 * flex
-* libsysfs header files (from sysfsutils-devel)
 * rrd header files (optional, for sensord)
 
 Run-time dependencies:
-* libsysfs (from sysfsutils)
 * perl (for sensors-detect)
 * rrd (optional, for sensord)
 * proper kernel configuration (see below)
--- lm-sensors-3.orig/lib/Module.mk	2007-11-29 11:32:32.000000000 +0100
+++ lm-sensors-3/lib/Module.mk	2007-11-29 11:39:45.000000000 +0100
@@ -59,7 +59,7 @@ LIBHEADERFILES := $(MODULE_DIR)/error.h 
 
 # How to create the shared library
 $(MODULE_DIR)/$(LIBSHLIBNAME): $(LIBSHOBJECTS)
-	$(CC) -shared -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm -lsysfs
+	$(CC) -shared -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
 
 $(MODULE_DIR)/$(LIBSHSONAME): $(MODULE_DIR)/$(LIBSHLIBNAME)
 	$(RM) $@
--- lm-sensors-3.orig/lib/sysfs.c	2007-11-29 11:32:33.000000000 +0100
+++ lm-sensors-3/lib/sysfs.c	2007-11-29 11:39:45.000000000 +0100
@@ -28,13 +28,111 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <errno.h>
-#include <sysfs/libsysfs.h>
+#include <dirent.h>
 #include "data.h"
 #include "error.h"
 #include "access.h"
 #include "general.h"
 #include "sysfs.h"
 
+
+/****************************************************************************/
+
+#define ATTR_MAX	128
+
+/*
+ * Read an attribute from sysfs
+ * Returns a pointer to a freshly allocated string; free it yourself.
+ * If the file doesn't exist or can't be read, NULL is returned.
+ */
+static char *sysfs_read_attr(const char *device, const char *attr)
+{
+	char path[NAME_MAX];
+	char buf[ATTR_MAX], *p;
+	FILE *f;
+
+	snprintf(path, NAME_MAX, "%s/%s", device, attr);
+
+	if (!(f = fopen(path, "r")))
+		return NULL;
+	p = fgets(buf, ATTR_MAX, f);
+	fclose(f);
+	if (!p)
+		return NULL;
+
+	/* Last byte is a '\n'; chop that off */
+	p = strndup(buf, strlen(buf) - 1);
+	if (!p)
+		sensors_fatal_error(__FUNCTION__, "out of memory");
+	return p;
+}
+
+/*
+ * Call an arbitrary function for each class device of the given class
+ * Returns 0 on success (all calls returned 0), a positive errno for
+ * local errors, or a negative error value if any call fails.
+ */
+static int sysfs_foreach_classdev(const char *class_name,
+				   int (*func)(char *, const char*))
+{
+	char path[NAME_MAX];
+	int path_off, ret;
+	DIR *dir;
+	struct dirent *ent;
+
+	path_off = snprintf(path, NAME_MAX, "%s/class/%s",
+			    sensors_sysfs_mount, class_name);
+	if (!(dir = opendir(path)))
+		return errno;
+
+	ret = 0;
+	while (!ret && (ent = readdir(dir))) {
+		if (ent->d_name[0] = '.')	/* skip hidden entries */
+			continue;
+
+		snprintf(path + path_off, NAME_MAX - path_off, "/%s",
+			 ent->d_name);
+		ret = func(path, ent->d_name);
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+/*
+ * Call an arbitrary function for each device of the given bus type
+ * Returns 0 on success (all calls returned 0), a positive errno for
+ * local errors, or a negative error value if any call fails.
+ */
+static int sysfs_foreach_busdev(const char *bus_type,
+				 int (*func)(char *, const char*))
+{
+	char path[NAME_MAX];
+	int path_off, ret;
+	DIR *dir;
+	struct dirent *ent;
+
+	path_off = snprintf(path, NAME_MAX, "%s/bus/%s/devices",
+			    sensors_sysfs_mount, bus_type);
+	if (!(dir = opendir(path)))
+		return errno;
+
+	ret = 0;
+	while (!ret && (ent = readdir(dir))) {
+		if (ent->d_name[0] = '.')	/* skip hidden entries */
+			continue;
+
+		snprintf(path + path_off, NAME_MAX - path_off, "/%s",
+			 ent->d_name);
+		ret = func(path, ent->d_name);
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+/****************************************************************************/
+
 char sensors_sysfs_mount[NAME_MAX];
 
 #define MAX_SENSORS_PER_TYPE	20
@@ -176,22 +274,36 @@ sensors_subfeature_type sensors_subfeatu
 	return SENSORS_SUBFEATURE_UNKNOWN;
 }
 
+static int sensors_get_attr_mode(const char *device, const char *attr)
+{
+	char path[NAME_MAX];
+	struct stat st;
+	int mode = 0;
+
+	snprintf(path, NAME_MAX, "%s/%s", device, attr);
+	if (!stat(path, &st)) {
+		if (st.st_mode & S_IRUSR)
+			mode |= SENSORS_MODE_R;
+		if (st.st_mode & S_IWUSR)
+			mode |= SENSORS_MODE_W;
+	}
+	return mode;
+}
+
 static int sensors_read_dynamic_chip(sensors_chip_features *chip,
-				     struct sysfs_device *sysdir)
+				     const char *dev_path)
 {
 	int i, fnum = 0, sfnum = 0, prev_slot;
-	struct sysfs_attribute *attr;
-	struct dlist *attrs;
+	DIR *dir;
+	struct dirent *ent;
 	sensors_subfeature *all_subfeatures;
 	sensors_subfeature *dyn_subfeatures;
 	sensors_feature *dyn_features;
 	sensors_feature_type ftype;
 	sensors_subfeature_type sftype;
 
-	attrs = sysfs_get_device_attributes(sysdir);
-
-	if (attrs = NULL)
-		return -ENOENT;
+	if (!(dir = opendir(dev_path)))
+		return -errno;
 
 	/* We use a large sparse table at first to store all found
 	   subfeatures, so that we can store them sorted at type and index
@@ -201,10 +313,13 @@ static int sensors_read_dynamic_chip(sen
 	if (!all_subfeatures)
 		sensors_fatal_error(__FUNCTION__, "Out of memory");
 
-	dlist_for_each_data(attrs, attr, struct sysfs_attribute) {
-		char *name = attr->name;
+	while ((ent = readdir(dir))) {
+		char *name = ent->d_name;
 		int nr;
 
+		if (ent->d_name[0] = '.')
+			continue;
+
 		sftype = sensors_subfeature_get_type(name, &nr);
 		if (sftype = SENSORS_SUBFEATURE_UNKNOWN)
 			continue;
@@ -257,13 +372,11 @@ static int sensors_read_dynamic_chip(sen
 		all_subfeatures[i].name = strdup(name);
 		if (!(sftype & 0x80))
 			all_subfeatures[i].flags |= SENSORS_COMPUTE_MAPPING;
-		if (attr->method & SYSFS_METHOD_SHOW)
-			all_subfeatures[i].flags |= SENSORS_MODE_R;
-		if (attr->method & SYSFS_METHOD_STORE)
-			all_subfeatures[i].flags |= SENSORS_MODE_W;
+		all_subfeatures[i].flags |= sensors_get_attr_mode(dev_path, name);
 
 		sfnum++;
 	}
+	closedir(dir);
 
 	if (!sfnum) { /* No subfeature */
 		chip->subfeature = NULL;
@@ -333,10 +446,8 @@ int sensors_init_sysfs(void)
 {
 	struct stat statbuf;
 
-	/* libsysfs will return success even if sysfs is not mounted,
-	   so we have to double-check */
-	if (sysfs_get_mnt_path(sensors_sysfs_mount, NAME_MAX)
-	 || stat(sensors_sysfs_mount, &statbuf) < 0
+	snprintf(sensors_sysfs_mount, NAME_MAX, "%s", "/sys");
+	if (stat(sensors_sysfs_mount, &statbuf) < 0
 	 || statbuf.st_nlink <= 2)	/* Empty directory */
 		return 0;
 
@@ -344,28 +455,23 @@ int sensors_init_sysfs(void)
 }
 
 /* returns: 0 if successful, !0 otherwise */
-static int sensors_read_one_sysfs_chip(struct sysfs_device *dev)
+static int sensors_read_one_sysfs_chip(char *dev_path, const char *dev_name)
 {
 	int domain, bus, slot, fn;
 	int err = -SENSORS_ERR_KERNEL;
-	struct sysfs_attribute *attr, *bus_attr;
-	char bus_path[SYSFS_PATH_MAX];
+	char *bus_attr;
+	char bus_path[NAME_MAX];
 	sensors_chip_features entry;
 
 	/* ignore any device without name attribute */
-	if (!(attr = sysfs_get_device_attr(dev, "name")))
+	if (!(entry.chip.prefix = sysfs_read_attr(dev_path, "name")))
 		return 0;
 
-	/* NB: attr->value[attr->len-1] = '\n'; chop that off */
-	entry.chip.prefix = strndup(attr->value, attr->len - 1);
-	if (!entry.chip.prefix)
-		sensors_fatal_error(__FUNCTION__, "out of memory");
-
-	entry.chip.path = strdup(dev->path);
+	entry.chip.path = strdup(dev_path);
 	if (!entry.chip.path)
 		sensors_fatal_error(__FUNCTION__, "out of memory");
 
-	if (sscanf(dev->name, "%hd-%x", &entry.chip.bus.nr, &entry.chip.addr) = 2) {
+	if (sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr, &entry.chip.addr) = 2) {
 		/* find out if legacy ISA or not */
 		if (entry.chip.bus.nr = 9191) {
 			entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
@@ -373,33 +479,27 @@ static int sensors_read_one_sysfs_chip(s
 		} else {
 			entry.chip.bus.type = SENSORS_BUS_TYPE_I2C;
 			snprintf(bus_path, sizeof(bus_path),
-				"%s/class/i2c-adapter/i2c-%d/device/name",
+				"%s/class/i2c-adapter/i2c-%d/device",
 				sensors_sysfs_mount, entry.chip.bus.nr);
 
-			if ((bus_attr = sysfs_open_attribute(bus_path))) {
-				if (sysfs_read_attribute(bus_attr)) {
-					sysfs_close_attribute(bus_attr);
-					goto exit_free;
-				}
-
-				if (bus_attr->value
-				 && !strncmp(bus_attr->value, "ISA ", 4)) {
+			if ((bus_attr = sysfs_read_attr(bus_path, "name"))) {
+				if (!strncmp(bus_attr, "ISA ", 4)) {
 					entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
 					entry.chip.bus.nr = 0;
 				}
 
-				sysfs_close_attribute(bus_attr);
+				free(bus_attr);
 			}
 		}
-	} else if (sscanf(dev->name, "spi%hd.%d", &entry.chip.bus.nr,
+	} else if (sscanf(dev_name, "spi%hd.%d", &entry.chip.bus.nr,
 			  &entry.chip.addr) = 2) {
 		/* SPI */
 		entry.chip.bus.type = SENSORS_BUS_TYPE_SPI;
-	} else if (sscanf(dev->name, "%*[a-z0-9_].%d", &entry.chip.addr) = 1) {
+	} else if (sscanf(dev_name, "%*[a-z0-9_].%d", &entry.chip.addr) = 1) {
 		/* must be new ISA (platform driver) */
 		entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
 		entry.chip.bus.nr = 0;
-	} else if (sscanf(dev->name, "%x:%x:%x.%x", &domain, &bus, &slot, &fn) = 4) {
+	} else if (sscanf(dev_name, "%x:%x:%x.%x", &domain, &bus, &slot, &fn) = 4) {
 		/* PCI */
 		entry.chip.addr = (domain << 16) + (bus << 8) + (slot << 3) + fn;
 		entry.chip.bus.type = SENSORS_BUS_TYPE_PCI;
@@ -411,7 +511,7 @@ static int sensors_read_one_sysfs_chip(s
 		entry.chip.addr = 0;
 	}
 
-	if (sensors_read_dynamic_chip(&entry, dev) < 0)
+	if (sensors_read_dynamic_chip(&entry, dev_path) < 0)
 		goto exit_free;
 	if (!entry.subfeature) { /* No subfeature, discard chip */
 		err = 0;
@@ -430,122 +530,79 @@ exit_free:
 /* returns 0 if successful, !0 otherwise */
 static int sensors_read_sysfs_chips_compat(void)
 {
-	struct sysfs_bus *bus;
-	struct dlist *devs;
-	struct sysfs_device *dev;
-	int ret = 0;
-
-	if (!(bus = sysfs_open_bus("i2c"))) {
-		if (errno && errno != ENOENT)
-			ret = -SENSORS_ERR_KERNEL;
-		goto exit0;
-	}
+	int ret;
 
-	if (!(devs = sysfs_get_bus_devices(bus))) {
-		if (errno && errno != ENOENT)
-			ret = -SENSORS_ERR_KERNEL;
-		goto exit1;
-	}
+	ret = sysfs_foreach_busdev("i2c", sensors_read_one_sysfs_chip);
+	if (ret && ret != ENOENT)
+		return -SENSORS_ERR_KERNEL;
 
-	dlist_for_each_data(devs, dev, struct sysfs_device)
-		if ((ret = sensors_read_one_sysfs_chip(dev)))
-			goto exit1;
+	return 0;
+}
 
-exit1:
-	/* this frees bus and devs */
-	sysfs_close_bus(bus);
+static int sensors_add_hwmon_device(char *path, const char *classdev)
+{
+	char device[NAME_MAX];
+	int path_off = strlen(path);
+	int dev_len;
+	(void)classdev; /* hide warning */
+
+	snprintf(path + path_off, NAME_MAX - path_off, "/device");
+	dev_len = readlink(path, device, NAME_MAX - 1);
+	if (dev_len < 0)
+		return -SENSORS_ERR_KERNEL;
+	device[dev_len] = '\0';
 
-exit0:
-	return ret;
+	return sensors_read_one_sysfs_chip(path, strrchr(device, '/') + 1);
 }
 
 /* returns 0 if successful, !0 otherwise */
 int sensors_read_sysfs_chips(void)
 {
-	struct sysfs_class *cls;
-	struct dlist *clsdevs;
-	struct sysfs_class_device *clsdev;
-	int ret = 0;
+	int ret;
 
-	if (!(cls = sysfs_open_class("hwmon"))) {
+	ret = sysfs_foreach_classdev("hwmon", sensors_add_hwmon_device);
+	if (ret = ENOENT) {
 		/* compatibility function for kernel 2.6.n where n <= 13 */
 		return sensors_read_sysfs_chips_compat();
 	}
 
-	if (!(clsdevs = sysfs_get_class_devices(cls))) {
-		if (errno && errno != ENOENT)
-			ret = -SENSORS_ERR_KERNEL;
-		goto exit;
-	}
-
-	dlist_for_each_data(clsdevs, clsdev, struct sysfs_class_device) {
-		struct sysfs_device *dev;
-		if (!(dev = sysfs_get_classdev_device(clsdev))) {
-			ret = -SENSORS_ERR_KERNEL;
-			goto exit;
-		}
-		if ((ret = sensors_read_one_sysfs_chip(dev)))
-			goto exit;
-	}
-
-exit:
-	/* this frees cls and clsdevs */
-	sysfs_close_class(cls);
+	if (ret > 0)
+		ret = -SENSORS_ERR_KERNEL;
 	return ret;
 }
 
 /* returns 0 if successful, !0 otherwise */
-int sensors_read_sysfs_bus(void)
+static int sensors_add_i2c_bus(char *path, const char *classdev)
 {
-	struct sysfs_class *cls;
-	struct dlist *clsdevs;
-	struct sysfs_class_device *clsdev;
 	sensors_bus entry;
-	int ret = 0;
 
-	if (!(cls = sysfs_open_class("i2c-adapter"))) {
-		if (errno && errno != ENOENT)
-			ret = -SENSORS_ERR_KERNEL;
-		goto exit0;
-	}
-
-	if (!(clsdevs = sysfs_get_class_devices(cls))) {
-		if (errno && errno != ENOENT)
-			ret = -SENSORS_ERR_KERNEL;
-		goto exit1;
-	}
-
-	dlist_for_each_data(clsdevs, clsdev, struct sysfs_class_device) {
-		struct sysfs_device *dev;
-		struct sysfs_attribute *attr;
-
-		/* Get the adapter name from the classdev "name" attribute
-		 * (Linux 2.6.20 and later). If it fails, fall back to
-		 * the device "name" attribute (for older kernels). */
-		if (!(attr = sysfs_get_classdev_attr(clsdev, "name"))
-		 && !((dev = sysfs_get_classdev_device(clsdev)) &&
-		      (attr = sysfs_get_device_attr(dev, "name"))))
-			continue;
+	if (sscanf(classdev, "i2c-%hd", &entry.bus.nr) != 1 ||
+	    entry.bus.nr = 9191) /* legacy ISA */
+		return 0;
+	entry.bus.type = SENSORS_BUS_TYPE_I2C;
 
-		if (sscanf(clsdev->name, "i2c-%hd", &entry.bus.nr) != 1 ||
-		    entry.bus.nr = 9191) /* legacy ISA */
-			continue;
-		entry.bus.type = SENSORS_BUS_TYPE_I2C;
+	/* Get the adapter name from the classdev "name" attribute
+	 * (Linux 2.6.20 and later). If it fails, fall back to
+	 * the device "name" attribute (for older kernels). */
+	entry.adapter = sysfs_read_attr(path, "name");
+	if (!entry.adapter)
+		entry.adapter = sysfs_read_attr(path, "device/name");
+	if (entry.adapter)
+		sensors_add_proc_bus(&entry);
 
-		/* NB: attr->value[attr->len-1] = '\n'; chop that off */
-		entry.adapter = strndup(attr->value, attr->len - 1);
-		if (!entry.adapter)
-			sensors_fatal_error(__FUNCTION__, "out of memory");
+	return 0;
+}
 
-		sensors_add_proc_bus(&entry);
-	}
+/* returns 0 if successful, !0 otherwise */
+int sensors_read_sysfs_bus(void)
+{
+	int ret;
 
-exit1:
-	/* this frees *cls _and_ *clsdevs */
-	sysfs_close_class(cls);
+	ret = sysfs_foreach_classdev("i2c-adapter", sensors_add_i2c_bus);
+	if (ret && ret != ENOENT)
+		return -SENSORS_ERR_KERNEL;
 
-exit0:
-	return ret;
+	return 0;
 }
 
 int sensors_read_sysfs_attr(const sensors_chip_name *name,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
