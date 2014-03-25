From: Alex Shi <alex.shi@linaro.org>
Date: Tue, 25 Mar 2014 10:49:21 +0000
Subject: [lm-sensors] [PATCH 08/19] hwmon: tmp102: expose to thermal fw via DT nodes
Message-Id: <1395744572-20014-9-git-send-email-alex.shi@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
In-Reply-To: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linaro.org>

From: Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds to tmp102 temperature sensor the possibility
to expose itself as thermal zone device, registered on the
thermal framework.

The thermal zone is built only if a device tree node
describing a thermal zone for this sensor is present
inside the tmp102 DT node. Otherwise, the driver behavior
will be the same.

Note: This patch has also been reviewed by Jean D. He has
requested to perform a wider inspection of possible
users of thermal and hwmon interaction API. On the other
hand, the change on this patch is acceptable on first
step of overall code change.

Cc: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
(cherry picked from commit 6a027523f30f1cc90037686e6a682d15c6a555d6)

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/hwmon/tmp102.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index d7b47ab..6748b45 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -27,6 +27,8 @@
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/jiffies.h>
+#include <linux/thermal.h>
+#include <linux/of.h>
 
 #define	DRIVER_NAME "tmp102"
 
@@ -50,6 +52,7 @@
 
 struct tmp102 {
 	struct device *hwmon_dev;
+	struct thermal_zone_device *tz;
 	struct mutex lock;
 	u16 config_orig;
 	unsigned long last_update;
@@ -93,6 +96,15 @@ static struct tmp102 *tmp102_update_device(struct i2c_client *client)
 	return tmp102;
 }
 
+static int tmp102_read_temp(void *dev, long *temp)
+{
+	struct tmp102 *tmp102 = tmp102_update_device(to_i2c_client(dev));
+
+	*temp = tmp102->temp[0];
+
+	return 0;
+}
+
 static ssize_t tmp102_show_temp(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -204,6 +216,12 @@ static int tmp102_probe(struct i2c_client *client,
 		goto fail_remove_sysfs;
 	}
 
+	tmp102->tz = thermal_zone_of_sensor_register(&client->dev, 0,
+						     &client->dev,
+						     tmp102_read_temp, NULL);
+	if (IS_ERR(tmp102->tz))
+		tmp102->tz = NULL;
+
 	dev_info(&client->dev, "initialized\n");
 
 	return 0;
@@ -220,6 +238,7 @@ static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
+	thermal_zone_of_sensor_unregister(&client->dev, tmp102->tz);
 	hwmon_device_unregister(tmp102->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
 
-- 
1.8.1.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
