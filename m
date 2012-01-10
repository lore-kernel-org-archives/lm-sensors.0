From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 10 Jan 2012 17:14:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm63) Add sensor type attribute for
Message-Id: <1326215659-13330-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On LM96163, the external temperature sensor type is configurable to
either a thermal diode or a 3904 transistor. The chip reports a wrong
temperature if misconfigured. Add writable attribute to support sensor type
configuration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm63.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 368db01..f8f4739 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -93,6 +93,7 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM63_REG_MAN_ID			0xFE
 #define LM63_REG_CHIP_ID		0xFF
 
+#define LM96163_REG_TRUTHERM		0x30
 #define LM96163_REG_REMOTE_TEMP_U_MSB	0x31
 #define LM96163_REG_REMOTE_TEMP_U_LSB	0x32
 #define LM96163_REG_CONFIG_ENHANCED	0x45
@@ -214,6 +215,7 @@ struct lm63_data {
 	u8 alarms;
 	bool pwm_highres;
 	bool remote_unsigned; /* true if unsigned remote upper limits */
+	bool trutherm;
 };
 
 static inline int temp8_from_reg(struct lm63_data *data, int nr)
@@ -529,6 +531,38 @@ static ssize_t set_update_interval(struct device *dev,
 	return count;
 }
 
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+
+	return snprintf(buf, PAGE_SIZE - 1,
+		data->trutherm ? "3\n" : "2\n");
+}
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+	if (val != 2 && val != 3)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->trutherm = val = 3;
+	i2c_smbus_write_byte_data(client, LM96163_REG_TRUTHERM,
+				  data->trutherm ? 0x02 : 0x00);
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
 			   char *buf)
 {
@@ -569,6 +603,8 @@ static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
 static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
 	set_temp2_crit_hyst);
 
+static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
+
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -728,6 +764,12 @@ static int lm63_probe(struct i2c_client *new_client,
 		if (err)
 			goto exit_remove_files;
 	}
+	if (data->kind = lm96163) {
+		err = device_create_file(&new_client->dev,
+					 &dev_attr_temp2_type);
+		if (err)
+			goto exit_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -738,6 +780,7 @@ static int lm63_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove_files:
+	device_remove_file(&new_client->dev, &dev_attr_temp2_type);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group_fan1);
 exit_free:
@@ -779,6 +822,9 @@ static void lm63_init_client(struct i2c_client *client)
 		break;
 	case lm96163:
 		data->max_convrate_hz = LM96163_MAX_CONVRATE_HZ;
+		data->trutherm
+		  = i2c_smbus_read_byte_data(client,
+					     LM96163_REG_TRUTHERM) = 0x02;
 		break;
 	default:
 		BUG();
@@ -822,6 +868,7 @@ static int lm63_remove(struct i2c_client *client)
 	struct lm63_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_temp2_type);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
