From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:28:39 +0000
Subject: [lm-sensors] [patch pc87360 reroll 5/6] refactor SENSOR-DEVICE-ATTR
Message-Id: <42F16113.1020207@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

> refactor SENSOR_DEVICE_ATTR into declaration = initialization-expression
>    __SENSOR_DEVICE_ATTR() expands to init-expr
>
> this imitates  __ATTR in include/linux/device.h,
> but is needed cuz of new .index member ( otherwize __ATTR would suffice)
>

$ diffstat 05-pc87360-hwmon-sysfs-array-init.patch
 hwmon-sysfs.h |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs gc-4/include/linux/hwmon-sysfs.h gc-5/include/linux/hwmon-sysfs.h
--- gc-4/include/linux/hwmon-sysfs.h	2005-08-01 19:31:23.000000000 -0600
+++ gc-5/include/linux/hwmon-sysfs.h	2005-08-03 17:13:28.000000000 -0600
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
