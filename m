From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 13/36] hwmon: Refactor SENSOR_DEVICE_ATTR_2
Message-Id: <11431538302068-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands
to an initialization expression, then it uses that in SENSOR_DEVICE_ATTR_2,
which declares and initializes a struct sensor_device_attribute_2.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 include/linux/hwmon-sysfs.h |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

70adca5a9f506942ec88fb2d9d6e71ef271888b7
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index dedca6a..a90c09d 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -43,11 +43,13 @@ struct sensor_device_attribute_2 {
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
1.2.4



