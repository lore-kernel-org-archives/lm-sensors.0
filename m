From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 22:10:49 +0000
Subject: [lm-sensors] [PATCH 09/17] hwmon: Refactor SENSOR_DEVICE_ATTR_2
Message-Id: <20060118231049.0e73d173.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>
Content-Disposition: inline; filename=hwmon-sensor-attr-array-2.patch

This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands 
to an initialization expression, then it uses that in SENSOR_DEVICE_ATTR_2, 
which declares and initializes a struct sensor_device_attribute_2.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 include/linux/hwmon-sysfs.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.15-rc7.orig/include/linux/hwmon-sysfs.h	2005-12-30 10:54:40.000000000 +0100
+++ linux-2.6.15-rc7/include/linux/hwmon-sysfs.h	2006-01-02 11:02:22.000000000 +0100
@@ -43,11 +43,13 @@
 #define to_sensor_dev_attr_2(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute_2, dev_attr)
 
+#define SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
+	  .index = _index,					\
+	  .nr = _nr }
+
 #define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
-struct sensor_device_attribute_2 sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
-	.index =	_index,					\
-	.nr =		_nr,					\
-}
+struct sensor_device_attribute_2 sensor_dev_attr_##_name		\
+	= SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)
 
 #endif /* _LINUX_HWMON_SYSFS_H */

-- 
Jean Delvare

