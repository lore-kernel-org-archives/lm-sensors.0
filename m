From: David Brownell <david-b@pacbell.net>
Date: Tue, 18 Sep 2007 16:51:07 +0000
Subject: [lm-sensors] [patch 2.6.23-rc6] lm75 should handle I/O errors
Message-Id: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When talking to a TMP75 chip with a flakey I2C adapter (it easily gets
underrun errors on loaded systems), I happened to notice that the LM75
driver holds the delusion that I/O calls can never fail.

This patch corrects that by retrying a few times after errors, and then
by refusing to record error codes as register values.  The retries seem
to resolve the problem under light system loads.  Clearly they won't be
able to resolve it in all cases, so the second mechanism is also needed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hwmon/lm75.c |   50 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 15 deletions(-)

--- a/drivers/hwmon/lm75.c	2007-09-17 23:10:45.000000000 -0700
+++ b/drivers/hwmon/lm75.c	2007-09-18 09:29:02.000000000 -0700
@@ -390,26 +390,44 @@ static int lm75_detach_client(struct i2c
 
 /* register access */
 
+#define N_RETRIES	3
+
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
+   the SMBus standard. */
 static int lm75_read_value(struct i2c_client *client, u8 reg)
 {
-	if (reg = LM75_REG_CONF)
-		return i2c_smbus_read_byte_data(client, reg);
-	else
-		return swab16(i2c_smbus_read_word_data(client, reg));
+	int retries = N_RETRIES;
+	int status;
+
+	do {
+		if (reg = LM75_REG_CONF)
+			status = i2c_smbus_read_byte_data(client, reg);
+		else {
+			status = i2c_smbus_read_word_data(client, reg);
+			if (status > 0)
+				status = swab16(status);
+		}
+	} while (status < 0 && retries-- > 0);
+	return status;
 }
 
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
+   the SMBus standard. */
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
-	if (reg = LM75_REG_CONF)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	else
-		return i2c_smbus_write_word_data(client, reg, swab16(value));
+	int retries = N_RETRIES;
+	int status;
+
+	do {
+		if (reg = LM75_REG_CONF)
+			status = i2c_smbus_write_byte_data(client, reg, value);
+		else
+			status = i2c_smbus_write_word_data(client, reg,
+						swab16(value));
+	} while (status < 0 && retries-- > 0);
+	return status;
 }
 
 static struct lm75_data *lm75_update_device(struct device *dev)
@@ -421,12 +439,14 @@ static struct lm75_data *lm75_update_dev
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
-		int i;
-		dev_dbg(&client->dev, "Starting lm75 update\n");
+		int i, status;
 
-		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
-			data->temp[i] = lm75_read_value(client,
-							LM75_REG_TEMP[i]);
+		dev_dbg(&client->dev, "Starting lm75 update\n");
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
+			status = lm75_read_value(client, LM75_REG_TEMP[i]);
+			if (status >= 0)
+				data->temp[i] = status;
+		}
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
