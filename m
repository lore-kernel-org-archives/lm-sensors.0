From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 09 Mar 2016 21:35:25 +0000
Subject: [lm-sensors] [PATCH 03/13] hwmon: convert tmp102 to use devm_thermal_zone_of_sensor_register
Message-Id: <1457559336-17652-4-git-send-email-edubezval@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/hwmon/tmp102.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 5289aa0..f1e96fd 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -53,7 +53,6 @@
 struct tmp102 {
 	struct i2c_client *client;
 	struct device *hwmon_dev;
-	struct thermal_zone_device *tz;
 	struct mutex lock;
 	u16 config_orig;
 	unsigned long last_update;
@@ -232,10 +231,8 @@ static int tmp102_probe(struct i2c_client *client,
 		goto fail_restore_config;
 	}
 	tmp102->hwmon_dev = hwmon_dev;
-	tmp102->tz = thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
-						     &tmp102_of_thermal_ops);
-	if (IS_ERR(tmp102->tz))
-		tmp102->tz = NULL;
+	devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
+					     &tmp102_of_thermal_ops);
 
 	dev_info(dev, "initialized\n");
 
@@ -251,7 +248,6 @@ static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
-	thermal_zone_of_sensor_unregister(tmp102->hwmon_dev, tmp102->tz);
 	hwmon_device_unregister(tmp102->hwmon_dev);
 
 	/* Stop monitoring if device was stopped originally */
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
