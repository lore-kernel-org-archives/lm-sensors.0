From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:07 +0000
Subject: [lm-sensors] [PATCH 86/95] hwmon: (w83l785ts) Convert to use devm_ functions
Message-Id: <1339773856-3443-87-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Also, in probe function, rename new_client variable to client, and introduce
local variable dev to point to client->dev, to simplify the code further and
improve readability.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83l785ts.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 5f14e38..35671f5 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -176,19 +176,18 @@ static int w83l785ts_detect(struct i2c_client *client,
 	return 0;
 }
 
-static int w83l785ts_probe(struct i2c_client *new_client,
+static int w83l785ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct w83l785ts_data *data;
+	struct device *dev = &client->dev;
 	int err = 0;
 
-	data = kzalloc(sizeof(struct w83l785ts_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(dev, sizeof(struct w83l785ts_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
@@ -200,18 +199,16 @@ static int w83l785ts_probe(struct i2c_client *new_client,
 	 * Nothing yet, assume it is already started.
 	 */
 
-	err = device_create_file(&new_client->dev,
-				 &sensor_dev_attr_temp1_input.dev_attr);
+	err = device_create_file(dev, &sensor_dev_attr_temp1_input.dev_attr);
 	if (err)
 		goto exit_remove;
 
-	err = device_create_file(&new_client->dev,
-				 &sensor_dev_attr_temp1_max.dev_attr);
+	err = device_create_file(dev, &sensor_dev_attr_temp1_max.dev_attr);
 	if (err)
 		goto exit_remove;
 
 	/* Register sysfs hooks */
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -220,12 +217,8 @@ static int w83l785ts_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove:
-	device_remove_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	device_remove_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_max.dev_attr);
-	kfree(data);
-exit:
+	device_remove_file(dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(dev, &sensor_dev_attr_temp1_max.dev_attr);
 	return err;
 }
 
@@ -239,7 +232,6 @@ static int w83l785ts_remove(struct i2c_client *client)
 	device_remove_file(&client->dev,
 			   &sensor_dev_attr_temp1_max.dev_attr);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
