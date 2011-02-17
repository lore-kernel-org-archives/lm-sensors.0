From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Feb 2011 10:49:31 +0000
Subject: [lm-sensors] [PATCH] Fix libsensors symbol visibility
Message-Id: <20110217114931.36b39e02@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Cristian Rodriguez <crrodriguez@opensuse.org>

Only export from libsensors symbols which are actually public (i.e.
listed in the public header files and documented in the manual page.)
---
It worked fine on the 3 distributions I tested it on (openSUSE 11.3,
Slackware 12.0 and 9.1, Debian) but I would welcome tests on more
distributions (including old ones) just to make sure it doesn't break
anything.

 lib/Module.mk      |    2 +-
 lib/libsensors.map |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lm-sensors/lib/libsensors.map	2011-02-17 10:08:27.000000000 +0100
@@ -0,0 +1,23 @@
+{
+global:
+  libsensors_version;
+  sensors_cleanup;
+  sensors_do_chip_sets;
+  sensors_free_chip_name;
+  sensors_get_adapter_name;
+  sensors_get_all_subfeatures;
+  sensors_get_detected_chips;
+  sensors_get_features;
+  sensors_get_label;
+  sensors_get_subfeature;
+  sensors_get_value;
+  sensors_init;
+  sensors_parse_chip_name;
+  sensors_set_value;
+  sensors_snprintf_chip_name;
+  sensors_strerror;
+  sensors_parse_error;
+  sensors_parse_error_wfn;
+  sensors_fatal_error;
+local: *;
+ };
--- lm-sensors.orig/lib/Module.mk	2011-02-17 10:07:59.000000000 +0100
+++ lm-sensors/lib/Module.mk	2011-02-17 10:08:04.000000000 +0100
@@ -63,7 +63,7 @@ LIBHEADERFILES := $(MODULE_DIR)/error.h
 
 # How to create the shared library
 $(MODULE_DIR)/$(LIBSHLIBNAME): $(LIBSHOBJECTS)
-	$(CC) -shared $(LDFLAGS) -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
+	$(CC) -shared $(LDFLAGS) -Wl,--version-script=$(LIB_DIR)/libsensors.map -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
 
 $(MODULE_DIR)/$(LIBSHSONAME): $(MODULE_DIR)/$(LIBSHLIBNAME)
 	$(RM) $@


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
