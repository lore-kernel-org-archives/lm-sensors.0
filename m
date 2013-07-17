From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 17 Jul 2013 15:02:54 +0000
Subject: [lm-sensors] [PATCH 9/9] hwmon: tmp102: expose to thermal fw via DT nodes
Message-Id: <1374073374-30946-19-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: wni@nvidia.com, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

This patch adds to tmp102 temperature sensor the possibility
to expose itself as thermal zone device, registered on the
thermal framework.

The thermal zone is built only if a device tree node
describing a thermal zone for this sensor is present
inside the tmp102 DT node. Otherwise, the driver behavior
will be the same.

Cc: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/hwmon/tmp102.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index d7b47ab..621093b 100644
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
 
+static int tmp102_read_temp(void *dev, unsigned long *temp)
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
@@ -204,10 +216,22 @@ static int tmp102_probe(struct i2c_client *client,
 		goto fail_remove_sysfs;
 	}
 
+	if (of_find_node_by_name(client->dev.of_node, "thermal_zone")) {
+		tmp102->tz = thermal_zone_of_device_register(&client->dev,
+							     &client->dev,
+							     tmp102_read_temp);
+		if (IS_ERR(tmp102->tz)) {
+			status = PTR_ERR(tmp102->tz);
+			goto exit_hwmon;
+		}
+	}
+
 	dev_info(&client->dev, "initialized\n");
 
 	return 0;
 
+exit_hwmon:
+	hwmon_device_unregister(tmp102->hwmon_dev);
 fail_remove_sysfs:
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
 fail_restore_config:
@@ -220,6 +244,7 @@ static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
+	thermal_zone_device_unregister(tmp102->tz);
 	hwmon_device_unregister(tmp102->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
 
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
