From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Nov 2011 20:39:58 +0000
Subject: [lm-sensors] [PATCH v2 1/3] hwmon: (lm63) Add support for unsigned
Message-Id: <1321994400-29295-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM96163 supports unsigned upper limits for the external temperature sensor.
Add support for it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Improved rounding for TEMP11U_TO_REG()

 drivers/hwmon/lm63.c |   57 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index de6cf7f..b2ffea9 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -92,6 +92,8 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 #define LM63_REG_MAN_ID			0xFE
 #define LM63_REG_CHIP_ID		0xFF
 
+#define LM96163_REG_REMOTE_TEMP_U_MSB	0x31
+#define LM96163_REG_REMOTE_TEMP_U_LSB	0x32
 #define LM96163_REG_CONFIG_ENHANCED	0x45
 
 /*
@@ -120,6 +122,9 @@ static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };
 				 (val) >= 127875 ? 0x7FE0 : \
 				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
 				 ((val) + 62) / 125 * 32)
+#define TEMP11U_TO_REG(val)	((val) <= 0 ? 0 : \
+				 (val) >= 255875 ? 0xFFE0 : \
+				 ((val) + 62) / 125 * 32)
 #define HYST_TO_REG(val)	((val) <= 0 ? 0 : \
 				 (val) >= 127000 ? 127 : \
 				 ((val) + 500) / 1000)
@@ -188,11 +193,20 @@ struct lm63_data {
 			   1: remote low limit
 			   2: remote high limit
 			   3: remote offset */
+	u16 temp11u;	/* remote input (unsigned) */
 	u8 temp2_crit_hyst;
 	u8 alarms;
 	bool pwm_highres;
+	bool remote_unsigned; /* true if unsigned remote upper limits */
 };
 
+static inline int temp8_from_reg(struct lm63_data *data, int nr)
+{
+	if (data->remote_unsigned)
+		return TEMP8_FROM_REG((u8)data->temp8[nr]);
+	return TEMP8_FROM_REG(data->temp8[nr]);
+}
+
 /*
  * Sysfs callback functions and files
  */
@@ -295,7 +309,7 @@ static ssize_t show_remote_temp8(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[attr->index])
+	return sprintf(buf, "%d\n", temp8_from_reg(data, attr->index)
 		       + data->temp2_offset);
 }
 
@@ -324,8 +338,25 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[attr->index])
-		       + data->temp2_offset);
+	int nr = attr->index;
+	int temp;
+
+	if (!nr) {
+		/*
+		 * Use unsigned temperature unless its value is zero.
+		 * If it is zero, use signed temperature.
+		 */
+		if (data->temp11u)
+			temp = TEMP11_FROM_REG(data->temp11u);
+		else
+			temp = TEMP11_FROM_REG(data->temp11[nr]);
+	} else {
+		if (data->remote_unsigned && nr = 2)
+			temp = TEMP11_FROM_REG((u16)data->temp11[nr]);
+		else
+			temp = TEMP11_FROM_REG(data->temp11[nr]);
+	}
+	return sprintf(buf, "%d\n", temp + data->temp2_offset);
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
@@ -352,7 +383,11 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp11[nr] = TEMP11_TO_REG(val - data->temp2_offset);
+	if (data->remote_unsigned && nr = 2)
+		data->temp11[nr] = TEMP11U_TO_REG(val - data->temp2_offset);
+	else
+		data->temp11[nr] = TEMP11_TO_REG(val - data->temp2_offset);
+
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
@@ -369,7 +404,7 @@ static ssize_t show_temp2_crit_hyst(struct device *dev,
 				    struct device_attribute *dummy, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[2])
+	return sprintf(buf, "%d\n", temp8_from_reg(data, 2)
 		       + data->temp2_offset
 		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
 }
@@ -393,7 +428,7 @@ static ssize_t set_temp2_crit_hyst(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	hyst = TEMP8_FROM_REG(data->temp8[2]) + data->temp2_offset - val;
+	hyst = temp8_from_reg(data, 2) + data->temp2_offset - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
 	mutex_unlock(&data->update_lock);
@@ -632,8 +667,7 @@ static void lm63_init_client(struct i2c_client *client)
 		    && !(data->config_fan & 0x08) && data->pwm1_freq = 8)
 			data->pwm_highres = true;
 		if (config_enhanced & 0x08)
-			dev_warn(&client->dev,
-				 "Unsigned format for High and Crit setpoints enabled but not supported by driver");
+			data->remote_unsigned = true;
 	}
 
 	/* Show some debug info about the LM63 configuration */
@@ -709,6 +743,13 @@ static struct lm63_data *lm63_update_device(struct device *dev)
 				  LM63_REG_REMOTE_OFFSET_MSB) << 8)
 				| i2c_smbus_read_byte_data(client,
 				  LM63_REG_REMOTE_OFFSET_LSB);
+
+		if (data->kind = lm96163)
+			data->temp11u = (i2c_smbus_read_byte_data(client,
+					LM96163_REG_REMOTE_TEMP_U_MSB) << 8)
+				      | i2c_smbus_read_byte_data(client,
+					LM96163_REG_REMOTE_TEMP_U_LSB);
+
 		data->temp8[2] = i2c_smbus_read_byte_data(client,
 				 LM63_REG_REMOTE_TCRIT);
 		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
