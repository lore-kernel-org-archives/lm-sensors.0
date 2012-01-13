From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jan 2012 11:42:43 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (lm63) Add sensor type attribute for external sensor on LM96163
Message-Id: <1326454963-1852-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On LM96163, the external temperature sensor type is configurable to
either a thermal diode or a 3904 transistor. The chip reports a wrong
temperature if misconfigured. Add writable attribute to support it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- snprintf -> sprintf
- set temp sensor type to 1(CPU diode) instead of 3 (thermal diode) if trutherm
  is enabled
- return error code from kstrtoul()
- When configuring the diode type, only set trutherm enable bit
- When detecting configured diode type, only check trutherm enable bit
- Document that configuring the thermal sensor type is supported for LM96163
v3:
- Really attach documentation update this time
- Add missing parentheses

 Documentation/hwmon/lm63 |    3 +-
 drivers/hwmon/lm63.c     |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
index f96eed1..3700551 100644
--- a/Documentation/hwmon/lm63
+++ b/Documentation/hwmon/lm63
@@ -69,4 +69,5 @@ The LM64 is effectively an LM63 with GPIO lines. The driver does not
 support these GPIO lines at present.
 
 The LM96163 is an enhanced version of LM63 with improved temperature accuracy
-and better PWM resolution.
+and better PWM resolution. For LM96163, the external temperature sensor type is
+configurable as CPU embedded diode(1) or 3904 transistor(2).
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 5f6da52..75e3a15 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -93,6 +93,7 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM63_REG_MAN_ID			0xFE
 #define LM63_REG_CHIP_ID		0xFF
 
+#define LM96163_REG_TRUTHERM		0x30
 #define LM96163_REG_REMOTE_TEMP_U_MSB	0x31
 #define LM96163_REG_REMOTE_TEMP_U_LSB	0x32
 #define LM96163_REG_CONFIG_ENHANCED	0x45
@@ -213,6 +214,7 @@ struct lm63_data {
 	u8 alarms;
 	bool pwm_highres;
 	bool remote_unsigned; /* true if unsigned remote upper limits */
+	bool trutherm;
 };
 
 static inline int temp8_from_reg(struct lm63_data *data, int nr)
@@ -513,6 +515,41 @@ static ssize_t set_update_interval(struct device *dev,
 	return count;
 }
 
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+
+	return sprintf(buf, data->trutherm ? "1\n" : "2\n");
+}
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int ret;
+	u8 reg;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val != 1 && val != 2)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->trutherm = val = 1;
+	reg = i2c_smbus_read_byte_data(client, LM96163_REG_TRUTHERM) & ~0x02;
+	i2c_smbus_write_byte_data(client, LM96163_REG_TRUTHERM,
+				  reg | (data->trutherm ? 0x02 : 0x00));
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
 			   char *buf)
 {
@@ -553,6 +590,8 @@ static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
 static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
 	set_temp2_crit_hyst);
 
+static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
+
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -712,6 +751,12 @@ static int lm63_probe(struct i2c_client *new_client,
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
@@ -722,6 +767,7 @@ static int lm63_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove_files:
+	device_remove_file(&new_client->dev, &dev_attr_temp2_type);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm63_group_fan1);
 exit_free:
@@ -763,6 +809,9 @@ static void lm63_init_client(struct i2c_client *client)
 		break;
 	case lm96163:
 		data->max_convrate_hz = LM96163_MAX_CONVRATE_HZ;
+		data->trutherm
+		  = i2c_smbus_read_byte_data(client,
+					     LM96163_REG_TRUTHERM) & 0x02;
 		break;
 	}
 	convrate = i2c_smbus_read_byte_data(client, LM63_REG_CONVRATE);
@@ -803,6 +852,7 @@ static int lm63_remove(struct i2c_client *client)
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
