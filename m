From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:35 +0000
Subject: [lm-sensors] [PATCH 01/13] hwmon: (pmbus) Drop unnecessary error messages in probe error path
Message-Id: <1359253067-11644-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop error messages due to implementation errors and due to memory allocation
errors.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index dbacde6..e3eb324 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1685,10 +1685,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	struct pmbus_data *data;
 	int ret;
 
-	if (!info) {
-		dev_err(&client->dev, "Missing chip information");
+	if (!info)
 		return -ENODEV;
-	}
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE
 				     | I2C_FUNC_SMBUS_BYTE_DATA
@@ -1696,10 +1694,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		return -ENODEV;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "No memory to allocate driver data\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -1739,31 +1735,23 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	ret = -ENOMEM;
 	data->sensors = devm_kzalloc(&client->dev, sizeof(struct pmbus_sensor)
 				     * data->max_sensors, GFP_KERNEL);
-	if (!data->sensors) {
-		dev_err(&client->dev, "No memory to allocate sensor data\n");
+	if (!data->sensors)
 		return -ENOMEM;
-	}
 
 	data->booleans = devm_kzalloc(&client->dev, sizeof(struct pmbus_boolean)
 				 * data->max_booleans, GFP_KERNEL);
-	if (!data->booleans) {
-		dev_err(&client->dev, "No memory to allocate boolean data\n");
+	if (!data->booleans)
 		return -ENOMEM;
-	}
 
 	data->labels = devm_kzalloc(&client->dev, sizeof(struct pmbus_label)
 				    * data->max_labels, GFP_KERNEL);
-	if (!data->labels) {
-		dev_err(&client->dev, "No memory to allocate label data\n");
+	if (!data->labels)
 		return -ENOMEM;
-	}
 
 	data->attributes = devm_kzalloc(&client->dev, sizeof(struct attribute *)
 					* data->max_attributes, GFP_KERNEL);
-	if (!data->attributes) {
-		dev_err(&client->dev, "No memory to allocate attribute data\n");
+	if (!data->attributes)
 		return -ENOMEM;
-	}
 
 	pmbus_find_attributes(client, data);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
