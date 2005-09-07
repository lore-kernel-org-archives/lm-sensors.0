From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 07 Sep 2005 07:25:36 +0000
Subject: [lm-sensors] [patch 1/2] pc87360 dynamic sysfs attr arrays -
Message-Id: <200509070524.j875OOJ2013025@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


split SENSOR_DEVICE_ATTR* into 2 parts: SENSOR_DEVICE_ATTR*, which
declares the struct sensor_device_attribute variable and initializes
it to the value of __SENSOR_DEVICE_ATTR*, which expands to an
initialization expression.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
diff -ruNp -X exclude-diffs jd1-3/include/linux/hwmon-sysfs.h sda-array-1/include/linux/hwmon-sysfs.h
--- jd1-3/include/linux/hwmon-sysfs.h	2005-08-31 06:54:51.000000000 -0600
+++ sda-array-1/include/linux/hwmon-sysfs.h	2005-09-04 20:02:31.000000000 -0600
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
