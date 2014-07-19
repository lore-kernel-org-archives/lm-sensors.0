From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 14:29:44 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (g762) Convert to hwmon_device_register_with_groups
Message-Id: <1405780184.15902.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and hwmon_device_register_with_groups() to simplify
the code a bit.

Use hwmon_device_register_with_groups rather than the device managed version to
ensure g762_of_clock_disable() is called after hwmon_device_unregister().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/g762.c | 71 ++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 98a8618..7dbc8c9 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -128,8 +128,8 @@ enum g762_regs {
 			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
 
 struct g762_data {
-	struct i2c_client *client;
 	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct clk *clk;
 
 	/* update mutex */
@@ -206,8 +206,8 @@ static inline unsigned char cnt_from_rpm(u32 rpm, u32 clk_freq, u16 p,
 /* helper to grab and cache data, at most one time per second */
 static struct g762_data *g762_update_client(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct g762_data *data = i2c_get_clientdata(client);
+	struct g762_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ret = 0;
 
 	mutex_lock(&data->update_lock);
@@ -266,8 +266,7 @@ static struct g762_data *g762_update_client(struct device *dev)
  */
 static int do_set_clk_freq(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct g762_data *data = i2c_get_clientdata(client);
+	struct g762_data *data = dev_get_drvdata(dev);
 
 	if (val > 0xffffff)
 		return -EINVAL;
@@ -282,7 +281,6 @@ static int do_set_clk_freq(struct device *dev, unsigned long val)
 /* Set pwm mode. Accepts either 0 (PWM mode) or 1 (DC mode) */
 static int do_set_pwm_mode(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -301,7 +299,7 @@ static int do_set_pwm_mode(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					data->fan_cmd1);
 	data->valid = false;
  out:
@@ -313,7 +311,6 @@ static int do_set_pwm_mode(struct device *dev, unsigned long val)
 /* Set fan clock divisor. Accepts either 1, 2, 4 or 8. */
 static int do_set_fan_div(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -342,7 +339,7 @@ static int do_set_fan_div(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					data->fan_cmd1);
 	data->valid = false;
  out:
@@ -354,7 +351,6 @@ static int do_set_fan_div(struct device *dev, unsigned long val)
 /* Set fan gear mode. Accepts either 0, 1 or 2. */
 static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -379,7 +375,7 @@ static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
 					data->fan_cmd2);
 	data->valid = false;
  out:
@@ -391,7 +387,6 @@ static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
 /* Set number of fan pulses per revolution. Accepts either 2 or 4. */
 static int do_set_fan_pulses(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -410,7 +405,7 @@ static int do_set_fan_pulses(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					data->fan_cmd1);
 	data->valid = false;
  out:
@@ -422,7 +417,6 @@ static int do_set_fan_pulses(struct device *dev, unsigned long val)
 /* Set fan mode. Accepts either 1 (open-loop) or 2 (closed-loop). */
 static int do_set_pwm_enable(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -444,15 +438,15 @@ static int do_set_pwm_enable(struct device *dev, unsigned long val)
 		 * value of 254 if it is 255 when switching to open-loop.
 		 */
 		if (data->set_cnt = 0xff)
-			i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
-						  254);
+			i2c_smbus_write_byte_data(data->client,
+						  G762_REG_SET_CNT, 254);
 		break;
 	default:
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					data->fan_cmd1);
 	data->valid = false;
  out:
@@ -464,7 +458,6 @@ static int do_set_pwm_enable(struct device *dev, unsigned long val)
 /* Set PWM polarity. Accepts either 0 (positive duty) or 1 (negative duty) */
 static int do_set_pwm_polarity(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -483,7 +476,7 @@ static int do_set_pwm_polarity(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					data->fan_cmd1);
 	data->valid = false;
  out:
@@ -498,8 +491,8 @@ static int do_set_pwm_polarity(struct device *dev, unsigned long val)
  */
 static int do_set_pwm(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct g762_data *data = i2c_get_clientdata(client);
+	struct g762_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ret;
 
 	if (val > 255)
@@ -519,7 +512,6 @@ static int do_set_pwm(struct device *dev, unsigned long val)
  */
 static int do_set_fan_target(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -531,7 +523,7 @@ static int do_set_fan_target(struct device *dev, unsigned long val)
 				     G762_PULSE_FROM_REG(data->fan_cmd1),
 				     G762_CLKDIV_FROM_REG(data->fan_cmd1),
 				     G762_GEARMULT_FROM_REG(data->fan_cmd2));
-	ret = i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_SET_CNT,
 					data->set_cnt);
 	data->valid = false;
 	mutex_unlock(&data->update_lock);
@@ -542,7 +534,6 @@ static int do_set_fan_target(struct device *dev, unsigned long val)
 /* Set fan startup voltage. Accepted values are either 0, 1, 2 or 3. */
 static int do_set_fan_startv(struct device *dev, unsigned long val)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 	int ret;
 
@@ -571,7 +562,7 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
 					data->fan_cmd2);
 	data->valid = false;
  out:
@@ -1026,7 +1017,7 @@ static DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO,
 		   get_fan_pulses, set_fan_pulses);
 
 /* Driver data */
-static struct attribute *g762_attributes[] = {
+static struct attribute *g762_attrs[] = {
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_alarm.attr,
 	&dev_attr_fan1_fault.attr,
@@ -1039,9 +1030,7 @@ static struct attribute *g762_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group g762_group = {
-	.attrs = g762_attributes,
-};
+ATTRIBUTE_GROUPS(g762);
 
 /*
  * Enable both fan failure detection and fan out of control protection. The
@@ -1050,7 +1039,6 @@ static const struct attribute_group g762_group = {
  */
 static inline int g762_fan_init(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g762_data *data = g762_update_client(dev);
 
 	if (IS_ERR(data))
@@ -1060,12 +1048,13 @@ static inline int g762_fan_init(struct device *dev)
 	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
 	data->valid = false;
 
-	return i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
 					 data->fan_cmd1);
 }
 
 static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct g762_data *data;
 	int ret;
 
@@ -1073,7 +1062,7 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct g762_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct g762_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1082,7 +1071,7 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	mutex_init(&data->update_lock);
 
 	/* Enable fan failure detection and fan out of control protection */
-	ret = g762_fan_init(&client->dev);
+	ret = g762_fan_init(dev);
 	if (ret)
 		return ret;
 
@@ -1098,22 +1087,17 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (ret)
 		goto clock_dis;
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &g762_group);
-	if (ret)
-		goto clock_dis;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+								 client->name,
+								 data,
+								 g762_groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-		goto sysfs_rem;
+		goto clock_dis;
 	}
 
 	return 0;
 
- sysfs_rem:
-	sysfs_remove_group(&client->dev.kobj, &g762_group);
-
  clock_dis:
 	g762_of_clock_disable(client);
 
@@ -1125,7 +1109,6 @@ static int g762_remove(struct i2c_client *client)
 	struct g762_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &g762_group);
 	g762_of_clock_disable(client);
 
 	return 0;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
