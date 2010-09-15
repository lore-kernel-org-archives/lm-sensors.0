From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:15 +0000
Subject: [lm-sensors] [patch 04/36] hwmon: (w83795) Refactor bank selection
Message-Id: <20100915155515.36711951@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the bank selection code to a separate function, to avoid
duplicating it in read and write functions. Improve error reporting
on register access error.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   89 +++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:14.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:39.000000000 +0200
@@ -360,60 +360,67 @@ struct w83795_data {
 
 /*
  * Hardware access
+ * We assume that nobdody can change the bank outside the driver.
  */
 
-/* Ignore the possibility that somebody change bank outside the driver
- * Must be called with data->update_lock held, except during initialization */
-static u8 w83795_read(struct i2c_client *client, u16 reg)
+/* Must be called with data->update_lock held, except during initialization */
+static int w83795_set_bank(struct i2c_client *client, u8 bank)
 {
 	struct w83795_data *data = i2c_get_clientdata(client);
-	u8 res = 0xff;
-	u8 new_bank = reg >> 8;
+	int err;
 
-	new_bank |= data->bank & 0xfc;
-	if (data->bank != new_bank) {
-		if (i2c_smbus_write_byte_data
-		    (client, W83795_REG_BANKSEL, new_bank) >= 0)
-			data->bank = new_bank;
-		else {
-			dev_err(&client->dev,
-				"set bank to %d failed, fall back "
-				"to bank %d, read reg 0x%x error\n",
-				new_bank, data->bank, reg);
-			res = 0x0;	/* read 0x0 from the chip */
-			goto END;
-		}
+	/* If the same bank is already set, nothing to do */
+	if ((data->bank & 0x07) = bank)
+		return 0;
+
+	/* Change to new bank, preserve all other bits */
+	bank |= data->bank & ~0x07;
+	err = i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL, bank);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to set bank to %d, err %d\n",
+			(int)bank, err);
+		return err;
 	}
-	res = i2c_smbus_read_byte_data(client, reg & 0xff);
-END:
-	return res;
+	data->bank = bank;
+
+	return 0;
 }
 
 /* Must be called with data->update_lock held, except during initialization */
-static int w83795_write(struct i2c_client *client, u16 reg, u8 value)
+static u8 w83795_read(struct i2c_client *client, u16 reg)
 {
-	struct w83795_data *data = i2c_get_clientdata(client);
-	int res;
-	u8 new_bank = reg >> 8;
+	int err;
 
-	new_bank |= data->bank & 0xfc;
-	if (data->bank != new_bank) {
-		res = i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL,
-						new_bank);
-		if (res >= 0)
-			data->bank = new_bank;
-		else {
-			dev_err(&client->dev,
-				"set bank to %d failed, fall back "
-				"to bank %d, write reg 0x%x error\n",
-				new_bank, data->bank, reg);
-			goto END;
-		}
+	err = w83795_set_bank(client, reg >> 8);
+	if (err < 0)
+		return 0x00;	/* Arbitrary */
+
+	err = i2c_smbus_read_byte_data(client, reg & 0xff);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to read from register 0x%03x, err %d\n",
+			(int)reg, err);
+		return 0x00;	/* Arbitrary */
 	}
+	return err;
+}
+
+/* Must be called with data->update_lock held, except during initialization */
+static int w83795_write(struct i2c_client *client, u16 reg, u8 value)
+{
+	int err;
 
-	res = i2c_smbus_write_byte_data(client, reg & 0xff, value);
-END:
-	return res;
+	err = w83795_set_bank(client, reg >> 8);
+	if (err < 0)
+		return err;
+
+	err = i2c_smbus_write_byte_data(client, reg & 0xff, value);
+	if (err < 0)
+		dev_err(&client->dev,
+			"Failed to write to register 0x%03x, err %d\n",
+			(int)reg, err);
+	return err;
 }
 
 static struct w83795_data *w83795_update_device(struct device *dev)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
