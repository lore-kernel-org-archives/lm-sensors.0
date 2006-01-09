From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 22:22:24 +0000
Subject: [lm-sensors] [PATCH 07/11] hwmon: Allow sensor attributes arrays
Message-Id: <20060109232224.053ae9ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>
Content-Disposition: inline; filename=hwmon-allow-sensor-attr-arrays.patch

This patch refactors SENSOR_DEVICE_ATTR macro.  First it creates a new
macro SENSOR_ATTR() which expands to an initialization expression, then
it uses that in SENSOR_DEVICE_ATTR, which declares and initializes a
struct sensor_device_attribute.

IOW, SENSOR_ATTR() imitates __ATTR() in include/linux/device.h.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 include/linux/hwmon-sysfs.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.15-rc2.orig/include/linux/hwmon-sysfs.h	2005-10-28 17:20:54.000000000 +0200
+++ linux-2.6.15-rc2/include/linux/hwmon-sysfs.h	2005-11-21 21:44:14.000000000 +0100
@@ -27,11 +27,13 @@
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
-	.index =	_index,					\
-}
+#define SENSOR_ATTR(_name, _mode, _show, _store, _index)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
+	  .index = _index }
+
+#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name		\
+	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
 
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;

-- 
Jean Delvare

