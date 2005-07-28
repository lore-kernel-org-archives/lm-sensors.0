From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 28 Jul 2005 14:52:42 +0000
Subject: [lm-sensors] [patch] refactor SENSORS_DEV_ATTR: was pc87360
Message-Id: <42E8D509.9020801@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>On 2005-07-28, Jim Cromie wrote:
>  
>
>>attached is a patch which:
>>
>>1. adds an __ATTR_N macro to device.h,
>>which takes an extra _index arg, and initializes device_attibute's new
>>.index member.
>>    
>>
>
>This seems to be duplicating the SENSOR_DEVICE_ATTR macro as defined in
>include/linux/hwmon-sysfs.h.
>
>  
>
its almost the same - and was heavily inspired by it.
The difference is that __ATTR_N is a smaller building block,
it has only the RHS of the initialization, it does not have the
variable declaration or the assignment/initialization itself.

So attached patch refactors SENSOR_DEV_ATTR
into a declaration and an initialization expression,
allowing latter to be used in array initializations.


-------------- next part --------------
diff -ruN -X exclude-diffs ../linux-2.6.13-rc3-mm1/include/linux/hwmon-sysfs.h linux/include/linux/hwmon-sysfs.h
--- ../linux-2.6.13-rc3-mm1/include/linux/hwmon-sysfs.h	2005-07-18 12:36:48.000000000 -0600
+++ linux/include/linux/hwmon-sysfs.h	2005-07-28 06:38:08.000000000 -0600
@@ -27,10 +27,13 @@
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
