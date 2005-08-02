From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 04:42:29 +0000
Subject: [lm-sensors] [ pc87360 patch 18/23 ] rework hwmon-sysfs refactoring
Message-Id: <42EEDD6B.2090807@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


refactor SENSOR_DEVICE_ATTR* macros into separate macros,
for declaration-initialization and for initialization-expression.
2 part construct is better for array-initialization.

With this change, the 23 part patchset works for 13-rc4-mm1

$ diffstat ../hwmon-sysfs-patch
 hwmon-sysfs.h |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>

-------------- next part --------------
--- include/linux/hwmon-sysfs.h.orig	2005-08-01 19:31:23.000000000 -0600
+++ include/linux/hwmon-sysfs.h	2005-08-01 20:22:48.000000000 -0600
@@ -27,12 +27,16 @@
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
+#define __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+{	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
 	.index =	_index,					\
 }
 
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name  	\
+	= __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)
+
+
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
 	u8 index;
@@ -41,11 +45,15 @@
 #define to_sensor_dev_attr_2(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute_2, dev_attr)
 
-#define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
-struct sensor_device_attribute_2 sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
+#define __SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
+{	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
 	.index =	_index,					\
 	.nr =		_nr,					\
 }
 
+#define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
+struct sensor_device_attribute_2 sensor_dev_attr_##_name 		\
+	= __SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)
+
+
 #endif /* _LINUX_HWMON_SYSFS_H */
