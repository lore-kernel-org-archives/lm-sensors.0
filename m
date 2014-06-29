From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 02:32:36 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (amc6821) Avoid forward declaration
Message-Id: <1404009156.19191.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/amc6821.c | 360 +++++++++++++++++++++---------------------------
 1 file changed, 154 insertions(+), 206 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index eea8172..7b055a4 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -21,7 +21,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-
 #include <linux/kernel.h>	/* Needed for KERN_INFO */
 #include <linux/module.h>
 #include <linux/init.h>
@@ -33,7 +32,6 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
-
 /*
  * Addresses to scan.
  */
@@ -41,8 +39,6 @@
 static const unsigned short normal_i2c[] = {0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e,
 	0x4c, 0x4d, 0x4e, I2C_CLIENT_END};
 
-
-
 /*
  * Insmod parameters
  */
@@ -53,7 +49,6 @@ module_param(pwminv, int, S_IRUGO);
 static int init = 1; /*Power-on initialization.*/
 module_param(init, int, S_IRUGO);
 
-
 enum chips { amc6821 };
 
 #define AMC6821_REG_DEV_ID 0x3D
@@ -152,40 +147,6 @@ static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
 			AMC6821_REG_TACH_LLIMITH,
 			AMC6821_REG_TACH_HLIMITH, };
 
-static int amc6821_probe(
-		struct i2c_client *client,
-		const struct i2c_device_id *id);
-static int amc6821_detect(
-		struct i2c_client *client,
-		struct i2c_board_info *info);
-static int amc6821_init_client(struct i2c_client *client);
-static int amc6821_remove(struct i2c_client *client);
-static struct amc6821_data *amc6821_update_device(struct device *dev);
-
-/*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id amc6821_id[] = {
-	{ "amc6821", amc6821 },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(i2c, amc6821_id);
-
-static struct i2c_driver amc6821_driver = {
-	.class = I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "amc6821",
-	},
-	.probe = amc6821_probe,
-	.remove = amc6821_remove,
-	.id_table = amc6821_id,
-	.detect = amc6821_detect,
-	.address_list = normal_i2c,
-};
-
-
 /*
  * Client data (each client gets its own)
  */
@@ -213,6 +174,108 @@ struct amc6821_data {
 	u8 stat2;
 };
 
+static struct amc6821_data *amc6821_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct amc6821_data *data = i2c_get_clientdata(client);
+	int timeout = HZ;
+	u8 reg;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + timeout) ||
+			!data->valid) {
+
+		for (i = 0; i < TEMP_IDX_LEN; i++)
+			data->temp[i] = i2c_smbus_read_byte_data(client,
+				temp_reg[i]);
+
+		data->stat1 = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_STAT1);
+		data->stat2 = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_STAT2);
+
+		data->pwm1 = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_DCY);
+		for (i = 0; i < FAN1_IDX_LEN; i++) {
+			data->fan[i] = i2c_smbus_read_byte_data(
+					client,
+					fan_reg_low[i]);
+			data->fan[i] += i2c_smbus_read_byte_data(
+					client,
+					fan_reg_hi[i]) << 8;
+		}
+		data->fan1_div = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_CONF4);
+		data->fan1_div = data->fan1_div & AMC6821_CONF4_PSPR ? 4 : 2;
+
+		data->pwm1_auto_point_pwm[0] = 0;
+		data->pwm1_auto_point_pwm[2] = 255;
+		data->pwm1_auto_point_pwm[1] = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_DCY_LOW_TEMP);
+
+		data->temp1_auto_point_temp[0] +			i2c_smbus_read_byte_data(client,
+					AMC6821_REG_PSV_TEMP);
+		data->temp2_auto_point_temp[0] +				data->temp1_auto_point_temp[0];
+		reg = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_LTEMP_FAN_CTRL);
+		data->temp1_auto_point_temp[1] = (reg & 0xF8) >> 1;
+		reg &= 0x07;
+		reg = 0x20 >> reg;
+		if (reg > 0)
+			data->temp1_auto_point_temp[2] +				data->temp1_auto_point_temp[1] +
+				(data->pwm1_auto_point_pwm[2] -
+				data->pwm1_auto_point_pwm[1]) / reg;
+		else
+			data->temp1_auto_point_temp[2] = 255;
+
+		reg = i2c_smbus_read_byte_data(client,
+			AMC6821_REG_RTEMP_FAN_CTRL);
+		data->temp2_auto_point_temp[1] = (reg & 0xF8) >> 1;
+		reg &= 0x07;
+		reg = 0x20 >> reg;
+		if (reg > 0)
+			data->temp2_auto_point_temp[2] +				data->temp2_auto_point_temp[1] +
+				(data->pwm1_auto_point_pwm[2] -
+				data->pwm1_auto_point_pwm[1]) / reg;
+		else
+			data->temp2_auto_point_temp[2] = 255;
+
+		reg = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
+		reg = (reg >> 5) & 0x3;
+		switch (reg) {
+		case 0: /*open loop: software sets pwm1*/
+			data->pwm1_auto_channels_temp = 0;
+			data->pwm1_enable = 1;
+			break;
+		case 2: /*closed loop: remote T (temp2)*/
+			data->pwm1_auto_channels_temp = 2;
+			data->pwm1_enable = 2;
+			break;
+		case 3: /*closed loop: local and remote T (temp2)*/
+			data->pwm1_auto_channels_temp = 3;
+			data->pwm1_enable = 3;
+			break;
+		case 1: /*
+			 * semi-open loop: software sets rpm, chip controls
+			 * pwm1, currently not implemented
+			 */
+			data->pwm1_auto_channels_temp = 0;
+			data->pwm1_enable = 0;
+			break;
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	mutex_unlock(&data->update_lock);
+	return data;
+}
 
 static ssize_t get_temp(
 		struct device *dev,
@@ -225,8 +288,6 @@ static ssize_t get_temp(
 	return sprintf(buf, "%d\n", data->temp[ix] * 1000);
 }
 
-
-
 static ssize_t set_temp(
 		struct device *dev,
 		struct device_attribute *attr,
@@ -253,9 +314,6 @@ static ssize_t set_temp(
 	return count;
 }
 
-
-
-
 static ssize_t get_temp_alarm(
 	struct device *dev,
 	struct device_attribute *devattr,
@@ -294,9 +352,6 @@ static ssize_t get_temp_alarm(
 		return sprintf(buf, "0");
 }
 
-
-
-
 static ssize_t get_temp2_fault(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -393,7 +448,6 @@ static ssize_t set_pwm1_enable(
 	return count;
 }
 
-
 static ssize_t get_pwm1_auto_channels_temp(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -403,7 +457,6 @@ static ssize_t get_pwm1_auto_channels_temp(
 	return sprintf(buf, "%d\n", data->pwm1_auto_channels_temp);
 }
 
-
 static ssize_t get_temp_auto_point_temp(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -425,7 +478,6 @@ static ssize_t get_temp_auto_point_temp(
 	}
 }
 
-
 static ssize_t get_pwm1_auto_point_pwm(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -436,7 +488,6 @@ static ssize_t get_pwm1_auto_point_pwm(
 	return sprintf(buf, "%d\n", data->pwm1_auto_point_pwm[ix]);
 }
 
-
 static inline ssize_t set_slope_register(struct i2c_client *client,
 		u8 reg,
 		u8 dpwm,
@@ -459,8 +510,6 @@ static inline ssize_t set_slope_register(struct i2c_client *client,
 	return 0;
 }
 
-
-
 static ssize_t set_temp_auto_point_temp(
 		struct device *dev,
 		struct device_attribute *attr,
@@ -533,8 +582,6 @@ EXIT:
 	return count;
 }
 
-
-
 static ssize_t set_pwm1_auto_point_pwm(
 		struct device *dev,
 		struct device_attribute *attr,
@@ -587,8 +634,6 @@ static ssize_t get_fan(
 	return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
 }
 
-
-
 static ssize_t get_fan1_fault(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -601,8 +646,6 @@ static ssize_t get_fan1_fault(
 		return sprintf(buf, "0");
 }
 
-
-
 static ssize_t set_fan(
 		struct device *dev,
 		struct device_attribute *attr,
@@ -635,8 +678,6 @@ EXIT:
 	return count;
 }
 
-
-
 static ssize_t get_fan1_div(
 		struct device *dev,
 		struct device_attribute *devattr,
@@ -688,8 +729,6 @@ EXIT:
 	return count;
 }
 
-
-
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 	get_temp, NULL, IDX_TEMP1_INPUT);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, get_temp,
@@ -754,8 +793,6 @@ static SENSOR_DEVICE_ATTR_2(temp2_auto_point2_temp, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR_2(temp2_auto_point3_temp, S_IWUSR | S_IRUGO,
 	get_temp_auto_point_temp, set_temp_auto_point_temp, 2, 2);
 
-
-
 static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -796,8 +833,6 @@ static struct attribute_group amc6821_attr_grp = {
 	.attrs = amc6821_attrs,
 };
 
-
-
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int amc6821_detect(
 		struct i2c_client *client,
@@ -844,53 +879,6 @@ static int amc6821_detect(
 	return 0;
 }
 
-static int amc6821_probe(
-	struct i2c_client *client,
-	const struct i2c_device_id *id)
-{
-	struct amc6821_data *data;
-	int err;
-
-	data = devm_kzalloc(&client->dev, sizeof(struct amc6821_data),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-
-	/*
-	 * Initialize the amc6821 chip
-	 */
-	err = amc6821_init_client(client);
-	if (err)
-		return err;
-
-	err = sysfs_create_group(&client->dev.kobj, &amc6821_attr_grp);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
-
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
-	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
-	return err;
-}
-
-static int amc6821_remove(struct i2c_client *client)
-{
-	struct amc6821_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
-
-	return 0;
-}
-
-
 static int amc6821_init_client(struct i2c_client *client)
 {
 	int config;
@@ -977,110 +965,70 @@ static int amc6821_init_client(struct i2c_client *client)
 	return 0;
 }
 
-
-static struct amc6821_data *amc6821_update_device(struct device *dev)
+static int amc6821_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
-	int timeout = HZ;
-	u8 reg;
-	int i;
-
-	mutex_lock(&data->update_lock);
+	struct amc6821_data *data;
+	int err;
 
-	if (time_after(jiffies, data->last_updated + timeout) ||
-			!data->valid) {
+	data = devm_kzalloc(&client->dev, sizeof(struct amc6821_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-		for (i = 0; i < TEMP_IDX_LEN; i++)
-			data->temp[i] = i2c_smbus_read_byte_data(client,
-				temp_reg[i]);
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
 
-		data->stat1 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_STAT1);
-		data->stat2 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_STAT2);
+	/*
+	 * Initialize the amc6821 chip
+	 */
+	err = amc6821_init_client(client);
+	if (err)
+		return err;
 
-		data->pwm1 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_DCY);
-		for (i = 0; i < FAN1_IDX_LEN; i++) {
-			data->fan[i] = i2c_smbus_read_byte_data(
-					client,
-					fan_reg_low[i]);
-			data->fan[i] += i2c_smbus_read_byte_data(
-					client,
-					fan_reg_hi[i]) << 8;
-		}
-		data->fan1_div = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_CONF4);
-		data->fan1_div = data->fan1_div & AMC6821_CONF4_PSPR ? 4 : 2;
+	err = sysfs_create_group(&client->dev.kobj, &amc6821_attr_grp);
+	if (err)
+		return err;
 
-		data->pwm1_auto_point_pwm[0] = 0;
-		data->pwm1_auto_point_pwm[2] = 255;
-		data->pwm1_auto_point_pwm[1] = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_DCY_LOW_TEMP);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (!IS_ERR(data->hwmon_dev))
+		return 0;
 
-		data->temp1_auto_point_temp[0] -			i2c_smbus_read_byte_data(client,
-					AMC6821_REG_PSV_TEMP);
-		data->temp2_auto_point_temp[0] -				data->temp1_auto_point_temp[0];
-		reg = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_LTEMP_FAN_CTRL);
-		data->temp1_auto_point_temp[1] = (reg & 0xF8) >> 1;
-		reg &= 0x07;
-		reg = 0x20 >> reg;
-		if (reg > 0)
-			data->temp1_auto_point_temp[2] -				data->temp1_auto_point_temp[1] +
-				(data->pwm1_auto_point_pwm[2] -
-				data->pwm1_auto_point_pwm[1]) / reg;
-		else
-			data->temp1_auto_point_temp[2] = 255;
+	err = PTR_ERR(data->hwmon_dev);
+	dev_err(&client->dev, "error registering hwmon device.\n");
+	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
+	return err;
+}
 
-		reg = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_RTEMP_FAN_CTRL);
-		data->temp2_auto_point_temp[1] = (reg & 0xF8) >> 1;
-		reg &= 0x07;
-		reg = 0x20 >> reg;
-		if (reg > 0)
-			data->temp2_auto_point_temp[2] -				data->temp2_auto_point_temp[1] +
-				(data->pwm1_auto_point_pwm[2] -
-				data->pwm1_auto_point_pwm[1]) / reg;
-		else
-			data->temp2_auto_point_temp[2] = 255;
+static int amc6821_remove(struct i2c_client *client)
+{
+	struct amc6821_data *data = i2c_get_clientdata(client);
 
-		reg = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
-		reg = (reg >> 5) & 0x3;
-		switch (reg) {
-		case 0: /*open loop: software sets pwm1*/
-			data->pwm1_auto_channels_temp = 0;
-			data->pwm1_enable = 1;
-			break;
-		case 2: /*closed loop: remote T (temp2)*/
-			data->pwm1_auto_channels_temp = 2;
-			data->pwm1_enable = 2;
-			break;
-		case 3: /*closed loop: local and remote T (temp2)*/
-			data->pwm1_auto_channels_temp = 3;
-			data->pwm1_enable = 3;
-			break;
-		case 1: /*
-			 * semi-open loop: software sets rpm, chip controls
-			 * pwm1, currently not implemented
-			 */
-			data->pwm1_auto_channels_temp = 0;
-			data->pwm1_enable = 0;
-			break;
-		}
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
 
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-	mutex_unlock(&data->update_lock);
-	return data;
+	return 0;
 }
 
+static const struct i2c_device_id amc6821_id[] = {
+	{ "amc6821", amc6821 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, amc6821_id);
+
+static struct i2c_driver amc6821_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "amc6821",
+	},
+	.probe = amc6821_probe,
+	.remove = amc6821_remove,
+	.id_table = amc6821_id,
+	.detect = amc6821_detect,
+	.address_list = normal_i2c,
+};
+
 module_i2c_driver(amc6821_driver);
 
 MODULE_LICENSE("GPL");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
