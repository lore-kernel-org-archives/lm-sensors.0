From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 12 Mar 2013 10:38:45 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <1363084727-2372-1-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Currently each time the temperature register is read the driver also reads the
threshold and hysteresis registers. This increases the amount of I2C traffic and
time needed to read the temperature by a factor of ~5. Neither the threshold nor
the hysteresis change on their own, so once we have read them, we should be able
to just use the cached value of the registers. This patch modifies the code
accordingly and only reads the threshold and hysteresis registers once during
probe.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v2:
	* Fix error the register address in the "Failed to read value" error message
	Otherwise I left the patch as it is hoping that the result of our discussion
	was that the problem outlined by Hartmut is more of a theoretical nature.
Changes since v1:
	* Fix error checking for i2c reads

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7410.c | 91 +++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 99a7290..894ff71 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -119,45 +119,33 @@ static int adt7410_temp_ready(struct i2c_client *client)
 	return -ETIMEDOUT;
 }
 
-static struct adt7410_data *adt7410_update_device(struct device *dev)
+static int adt7410_update_temp(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7410_data *data = i2c_get_clientdata(client);
-	struct adt7410_data *ret = data;
+	int ret = 0;
+
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
-		int i, status;
+		int temp;
 
 		dev_dbg(&client->dev, "Starting update\n");
 
-		status = adt7410_temp_ready(client); /* check for new value */
-		if (unlikely(status)) {
-			ret = ERR_PTR(status);
+		ret = adt7410_temp_ready(client); /* check for new value */
+		if (ret)
 			goto abort;
-		}
-		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
-			status = i2c_smbus_read_word_swapped(client,
-							ADT7410_REG_TEMP[i]);
-			if (unlikely(status < 0)) {
-				dev_dbg(dev,
-					"Failed to read value: reg %d, error %d\n",
-					ADT7410_REG_TEMP[i], status);
-				ret = ERR_PTR(status);
-				goto abort;
-			}
-			data->temp[i] = status;
-		}
-		status = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
-		if (unlikely(status < 0)) {
-			dev_dbg(dev,
-				"Failed to read value: reg %d, error %d\n",
-				ADT7410_T_HYST, status);
-			ret = ERR_PTR(status);
+
+		temp = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[0]);
+		if (temp < 0) {
+			ret = temp;
+			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
+				ADT7410_REG_TEMP[0], ret);
 			goto abort;
 		}
-		data->hyst = status;
+		data->temp[0] = temp;
+
 		data->last_updated = jiffies;
 		data->valid = true;
 	}
@@ -167,6 +155,35 @@ abort:
 	return ret;
 }
 
+static int adt7410_fill_cache(struct i2c_client *client)
+{
+	struct adt7410_data *data = i2c_get_clientdata(client);
+	int ret;
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(ADT7410_REG_TEMP); i++) {
+		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[i]);
+		if (ret < 0) {
+			dev_dbg(&client->dev,
+				"Failed to read value: reg %d, error %d\n",
+				ADT7410_REG_TEMP[i], ret);
+			return ret;
+		}
+		data->temp[i] = ret;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
+	if (ret < 0) {
+		dev_dbg(&client->dev,
+			"Failed to read value: hyst reg, error %d\n",
+			ret);
+		return ret;
+	}
+	data->hyst = ret;
+
+	return 0;
+}
+
 static s16 ADT7410_TEMP_TO_REG(long temp)
 {
 	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
@@ -193,10 +210,16 @@ static ssize_t adt7410_show_temp(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7410_data *data = adt7410_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7410_data *data = i2c_get_clientdata(client);
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	if (attr->index = 0) {
+		int ret;
+
+		ret = adt7410_update_temp(dev);
+		if (ret)
+			return ret;
+	}
 
 	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
 		       data->temp[attr->index]));
@@ -232,13 +255,11 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
 				   char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7410_data *data;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7410_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
 	int hyst;
 
-	data = adt7410_update_device(dev);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
 	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
 
 	/*
@@ -371,6 +392,10 @@ static int adt7410_probe(struct i2c_client *client,
 	}
 	dev_dbg(&client->dev, "Config %02x\n", data->config);
 
+	ret = adt7410_fill_cache(client);
+	if (ret)
+		goto exit_restore;
+
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &adt7410_group);
 	if (ret)
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
