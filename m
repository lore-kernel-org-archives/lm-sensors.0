From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:49 +0000
Subject: [lm-sensors] [PATCH 01/36] hwmon: Allow sensor attributes arrays
Message-Id: <11431538293198-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch refactors SENSOR_DEVICE_ATTR macro.  First it creates a new
macro SENSOR_ATTR() which expands to an initialization expression, then
it uses that in SENSOR_DEVICE_ATTR, which declares and initializes a
struct sensor_device_attribute.

IOW, SENSOR_ATTR() imitates __ATTR() in include/linux/device.h.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 include/linux/hwmon-sysfs.h |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

42d3b83fecb7b576d477244347982baa02fa4f44
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index 7eb4004..dedca6a 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -27,11 +27,13 @@ struct sensor_device_attribute{
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
1.2.4



