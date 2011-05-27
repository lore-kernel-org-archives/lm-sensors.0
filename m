From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 May 2011 11:58:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc6w201) Properly handle all errors
Message-Id: <20110527135858.2c5a904e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Handle errors on 8-bit register reads and writes too. Also use likely
and unlikely to make the functions faster on success.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/emc6w201.c |   58 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 14 deletions(-)

--- linux-2.6.40-rc0.orig/drivers/hwmon/emc6w201.c	2011-05-27 09:46:54.000000000 +0200
+++ linux-2.6.40-rc0/drivers/hwmon/emc6w201.c	2011-05-27 13:36:21.000000000 +0200
@@ -78,8 +78,9 @@ static u16 emc6w201_read16(struct i2c_cl
 
 	lsb = i2c_smbus_read_byte_data(client, reg);
 	msb = i2c_smbus_read_byte_data(client, reg + 1);
-	if (lsb < 0 || msb < 0) {
-		dev_err(&client->dev, "16-bit read failed at 0x%02x\n", reg);
+	if (unlikely(lsb < 0 || msb < 0)) {
+		dev_err(&client->dev, "%d-bit %s failed at 0x%02x\n",
+			16, "read", reg);
 		return 0xFFFF;	/* Arbitrary value */
 	}
 
@@ -95,10 +96,39 @@ static int emc6w201_write16(struct i2c_c
 	int err;
 
 	err = i2c_smbus_write_byte_data(client, reg, val & 0xff);
-	if (!err)
+	if (likely(!err))
 		err = i2c_smbus_write_byte_data(client, reg + 1, val >> 8);
-	if (err < 0)
-		dev_err(&client->dev, "16-bit write failed at 0x%02x\n", reg);
+	if (unlikely(err < 0))
+		dev_err(&client->dev, "%d-bit %s failed at 0x%02x\n",
+			16, "write", reg);
+
+	return err;
+}
+
+/* Read 8-bit value from register */
+static u8 emc6w201_read8(struct i2c_client *client, u8 reg)
+{
+	int val;
+
+	val = i2c_smbus_read_byte_data(client, reg);
+	if (unlikely(val < 0)) {
+		dev_err(&client->dev, "%d-bit %s failed at 0x%02x\n",
+			8, "read", reg);
+		return 0x00;	/* Arbitrary value */
+	}
+
+	return val;
+}
+
+/* Write 8-bit value to register */
+static int emc6w201_write8(struct i2c_client *client, u8 reg, u8 val)
+{
+	int err;
+
+	err = i2c_smbus_write_byte_data(client, reg, val);
+	if (unlikely(err < 0))
+		dev_err(&client->dev, "%d-bit %s failed at 0x%02x\n",
+			8, "write", reg);
 
 	return err;
 }
@@ -114,25 +144,25 @@ static struct emc6w201_data *emc6w201_up
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		for (nr = 0; nr < 6; nr++) {
 			data->in[input][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_IN(nr));
 			data->in[min][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_IN_LOW(nr));
 			data->in[max][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_IN_HIGH(nr));
 		}
 
 		for (nr = 0; nr < 6; nr++) {
 			data->temp[input][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_TEMP(nr));
 			data->temp[min][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_TEMP_LOW(nr));
 			data->temp[max][nr] -				i2c_smbus_read_byte_data(client,
+				emc6w201_read8(client,
 						EMC6W201_REG_TEMP_HIGH(nr));
 		}
 
@@ -192,7 +222,7 @@ static ssize_t set_in(struct device *dev
 
 	mutex_lock(&data->update_lock);
 	data->in[sf][nr] = SENSORS_LIMIT(val, 0, 255);
-	err = i2c_smbus_write_byte_data(client, reg, data->in[sf][nr]);
+	err = emc6w201_write8(client, reg, data->in[sf][nr]);
 	mutex_unlock(&data->update_lock);
 
 	return err < 0 ? err : count;
@@ -229,7 +259,7 @@ static ssize_t set_temp(struct device *d
 
 	mutex_lock(&data->update_lock);
 	data->temp[sf][nr] = SENSORS_LIMIT(val, -127, 128);
-	err = i2c_smbus_write_byte_data(client, reg, data->temp[sf][nr]);
+	err = emc6w201_write8(client, reg, data->temp[sf][nr]);
 	mutex_unlock(&data->update_lock);
 
 	return err < 0 ? err : count;
@@ -444,7 +474,7 @@ static int emc6w201_detect(struct i2c_cl
 
 	/* Check configuration */
 	config = i2c_smbus_read_byte_data(client, EMC6W201_REG_CONFIG);
-	if ((config & 0xF4) != 0x04)
+	if (config < 0 || (config & 0xF4) != 0x04)
 		return -ENODEV;
 	if (!(config & 0x01)) {
 		dev_err(&client->dev, "Monitoring not enabled\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
