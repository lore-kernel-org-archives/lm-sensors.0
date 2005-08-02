From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:56:14 +0000
Subject: [lm-sensors] [patchset 18/23] pc87360 refactor SENSOR_DEVICE_ATTR
Message-Id: <42EEA84B.4050702@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


refactor SENSOR_DEVICE_ATTR to separate the variable declaraion
and initialization from the initialization expression 'assigned' to it,
making it more friendly to array initialization.

[jimc@harpo pset]$ diffstat 15-sda-arry-initializer
 hwmon-sysfs.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

-------------- next part --------------
diff -ruNp -X exclude-diffs lxE-5/include/linux/hwmon-sysfs.h lxF-1/include/linux/hwmon-sysfs.h
--- lxE-5/include/linux/hwmon-sysfs.h	2005-07-18 12:36:48.000000000 -0600
+++ lxF-1/include/linux/hwmon-sysfs.h	2005-08-01 10:23:15.000000000 -0600
@@ -27,10 +27,13 @@ struct sensor_device_attribute{
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
-	.index =	_index,					\
+#define __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+	{ .dev_attr =	__ATTR(_name,_mode,_show,_store),	\
+	  .index =	_index,					\
 }
 
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name		\
+	= __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)
+
 #endif /* _LINUX_HWMON_SYSFS_H */
