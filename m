From: jim.cromie@gmail.com (jim.cromie@gmail.com)
Date: Wed, 31 Aug 2005 00:43:57 +0000
Subject: [lm-sensors] [patch 5/6] pc87360 SDA callbacks - SDA array init
Message-Id: <200508302241.j7UMfTHN007953@harpo.jimc.earth>
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




diff -ruNp -X exclude-diffs A-4/include/linux/hwmon-sysfs.h A-5/include/linux/hwmon-sysfs.h
--- A-4/include/linux/hwmon-sysfs.h	2005-08-29 10:44:11.000000000 -0600
+++ A-5/include/linux/hwmon-sysfs.h	2005-08-29 11:37:17.000000000 -0600
@@ -27,10 +27,13 @@ struct sensor_device_attribute{
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
-	.index =	_index,					\
+#define __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index) \
+{	.dev_attr =     __ATTR(_name,_mode,_show,_store),       \
+	.index =        _index,                                 \
 }
 
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)   \
+struct sensor_device_attribute sensor_dev_attr_##_name        \
+	= __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)
+
 #endif /* _LINUX_HWMON_SYSFS_H */
