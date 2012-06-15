From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:09 +0000
Subject: [lm-sensors] [PATCH 28/95] hwmon: (emc1403) Convert to use devm_ functions
Message-Id: <1339773856-3443-29-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 149dcb0..22f7e41 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -306,7 +306,8 @@ static int emc1403_probe(struct i2c_client *client,
 	int res;
 	struct thermal_data *data;
 
-	data = kzalloc(sizeof(struct thermal_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct thermal_data),
+			    GFP_KERNEL);
 	if (data = NULL) {
 		dev_warn(&client->dev, "out of memory");
 		return -ENOMEM;
@@ -319,21 +320,19 @@ static int emc1403_probe(struct i2c_client *client,
 	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
 	if (res) {
 		dev_warn(&client->dev, "create group failed\n");
-		goto thermal_error1;
+		return res;
 	}
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		res = PTR_ERR(data->hwmon_dev);
 		dev_warn(&client->dev, "register hwmon dev failed\n");
-		goto thermal_error2;
+		goto thermal_error;
 	}
 	dev_info(&client->dev, "EMC1403 Thermal chip found\n");
-	return res;
+	return 0;
 
-thermal_error2:
+thermal_error:
 	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
-thermal_error1:
-	kfree(data);
 	return res;
 }
 
@@ -343,7 +342,6 @@ static int emc1403_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
