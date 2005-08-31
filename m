From: jim.cromie@gmail.com (jim.cromie@gmail.com)
Date: Wed, 31 Aug 2005 22:21:57 +0000
Subject: [lm-sensors] [patch 0/2] pc87360 SDA-Array - refactor hwmon-sysfs
Message-Id: <200508312020.j7VKKtTM008092@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


05.	i2c-pc87360-05-hwmon-sysfs-array-init.patch

This patch refactors SENSOR_DEVICE_ATTR macro.  1st it creates a new
macro __SENSOR_DEVICE_ATTR() which expands to an initialization
expression, then it uses that in SENSOR_DEVICE_ATTR, which declares
and initializes a struct sensor_device_attribute.

IOW, __SENSOR_DEVICE_ATTR() imitates __ATTR in include/linux/device.h

 hwmon-sysfs.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>




diff -ruNp -X exclude-diffs C-5/include/linux/hwmon-sysfs.h D-1/include/linux/hwmon-sysfs.h
--- C-5/include/linux/hwmon-sysfs.h	2005-08-31 06:54:51.000000000 -0600
+++ D-1/include/linux/hwmon-sysfs.h	2005-08-31 13:04:25.000000000 -0600
@@ -27,12 +27,16 @@ struct sensor_device_attribute{
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
@@ -41,11 +45,15 @@ struct sensor_device_attribute_2 {
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
