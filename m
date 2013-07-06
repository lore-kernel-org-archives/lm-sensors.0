From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jul 2013 17:24:52 +0000
Subject: [lm-sensors] [RFC PATCH 2/5] hwmon: Introduce hwmon_device_register_groups
Message-Id: <1373131495-13465-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

hwmon_device_register_groups() lets callers register a hwmon device
together with all sysfs attributes in a single call.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c |   14 +++++++++++---
 include/linux/hwmon.h |    4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 646314f..e94a053 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -38,7 +38,9 @@ static DEFINE_IDA(hwmon_ida);
  *
  * Returns the pointer to the new device.
  */
-struct device *hwmon_device_register(struct device *dev)
+struct device *
+hwmon_device_register_groups(struct device *dev, void *drvdata,
+			     const struct attribute_group **groups)
 {
 	struct device *hwdev;
 	int id;
@@ -47,14 +49,20 @@ struct device *hwmon_device_register(struct device *dev)
 	if (id < 0)
 		return ERR_PTR(id);
 
-	hwdev = device_create(hwmon_class, dev, MKDEV(0, 0), NULL,
-			      HWMON_ID_FORMAT, id);
+	hwdev = device_create_groups(hwmon_class, dev, MKDEV(0, 0), drvdata,
+				     groups, HWMON_ID_FORMAT, id);
 
 	if (IS_ERR(hwdev))
 		ida_simple_remove(&hwmon_ida, id);
 
 	return hwdev;
 }
+EXPORT_SYMBOL_GPL(hwmon_device_register_groups);
+
+struct device *hwmon_device_register(struct device *dev)
+{
+	return hwmon_device_register_groups(dev, NULL, NULL);
+}
 EXPORT_SYMBOL_GPL(hwmon_device_register);
 
 /**
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index b2514f7..ad91c45 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -15,8 +15,12 @@
 #define _HWMON_H_
 
 struct device;
+struct attribute_group;
 
 struct device *hwmon_device_register(struct device *dev);
+struct device *
+hwmon_device_register_groups(struct device *dev, void *drvdata,
+			     const struct attribute_group **groups);
 
 void hwmon_device_unregister(struct device *dev);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
