From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:54 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: (lm80) Rearrange code to avoid forward declarations
Message-Id: <1397615334-30317-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Avoid need for forward declarations by rearranging code.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |  290 ++++++++++++++++++++++++--------------------------
 1 file changed, 139 insertions(+), 151 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index debaec3..c0fd512 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -140,39 +140,130 @@ struct lm80_data {
 	u16 alarms;		/* Register encoding, combined */
 };
 
-/*
- * Functions declaration
- */
+static int lm80_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
 
-static int lm80_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id);
-static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info);
-static void lm80_init_client(struct i2c_client *client);
-static struct lm80_data *lm80_update_device(struct device *dev);
-static int lm80_read_value(struct i2c_client *client, u8 reg);
-static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value);
+static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
 
-/*
- * Driver data (common to all clients)
- */
+/* Called when we have found a new LM80 and after read errors */
+static void lm80_init_client(struct i2c_client *client)
+{
+	/*
+	 * Reset all except Watchdog values and last conversion values
+	 * This sets fan-divs to 2, among others. This makes most other
+	 * initializations unnecessary
+	 */
+	lm80_write_value(client, LM80_REG_CONFIG, 0x80);
+	/* Set 11-bit temperature resolution */
+	lm80_write_value(client, LM80_REG_RES, 0x08);
 
-static const struct i2c_device_id lm80_id[] = {
-	{ "lm80", 0 },
-	{ "lm96080", 1 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm80_id);
+	/* Start monitoring */
+	lm80_write_value(client, LM80_REG_CONFIG, 0x01);
+}
 
-static struct i2c_driver lm80_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "lm80",
-	},
-	.probe		= lm80_probe,
-	.id_table	= lm80_id,
-	.detect		= lm80_detect,
-	.address_list	= normal_i2c,
-};
+static struct lm80_data *lm80_update_device(struct device *dev)
+{
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int i;
+	int rv;
+	int prev_rv;
+	struct lm80_data *ret = data;
+
+	mutex_lock(&data->update_lock);
+
+	if (data->error)
+		lm80_init_client(client);
+
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
+		dev_dbg(dev, "Starting lm80 update\n");
+		for (i = 0; i <= 6; i++) {
+			rv = lm80_read_value(client, LM80_REG_IN(i));
+			if (rv < 0)
+				goto abort;
+			data->in[i_input][i] = rv;
+
+			rv = lm80_read_value(client, LM80_REG_IN_MIN(i));
+			if (rv < 0)
+				goto abort;
+			data->in[i_min][i] = rv;
+
+			rv = lm80_read_value(client, LM80_REG_IN_MAX(i));
+			if (rv < 0)
+				goto abort;
+			data->in[i_max][i] = rv;
+		}
+
+		rv = lm80_read_value(client, LM80_REG_FAN1);
+		if (rv < 0)
+			goto abort;
+		data->fan[f_input][0] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+		if (rv < 0)
+			goto abort;
+		data->fan[f_min][0] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN2);
+		if (rv < 0)
+			goto abort;
+		data->fan[f_input][1] = rv;
+
+		rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+		if (rv < 0)
+			goto abort;
+		data->fan[f_min][1] = rv;
+
+		prev_rv = rv = lm80_read_value(client, LM80_REG_TEMP);
+		if (rv < 0)
+			goto abort;
+		rv = lm80_read_value(client, LM80_REG_RES);
+		if (rv < 0)
+			goto abort;
+		data->temp[t_input] = (prev_rv << 8) | (rv & 0xf0);
+
+		for (i = t_input + 1; i < t_num_temp; i++) {
+			rv = lm80_read_value(client, temp_regs[i]);
+			if (rv < 0)
+				goto abort;
+			data->temp[i] = rv << 8;
+		}
+
+		rv = lm80_read_value(client, LM80_REG_FANDIV);
+		if (rv < 0)
+			goto abort;
+		data->fan_div[0] = (rv >> 2) & 0x03;
+		data->fan_div[1] = (rv >> 4) & 0x03;
+
+		prev_rv = rv = lm80_read_value(client, LM80_REG_ALARM1);
+		if (rv < 0)
+			goto abort;
+		rv = lm80_read_value(client, LM80_REG_ALARM2);
+		if (rv < 0)
+			goto abort;
+		data->alarms = prev_rv + (rv << 8);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+		data->error = 0;
+	}
+	goto done;
+
+abort:
+	ret = ERR_PTR(rv);
+	data->valid = 0;
+	data->error = 1;
+
+done:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
 
 /*
  * Sysfs stuff
@@ -553,130 +644,27 @@ static int lm80_probe(struct i2c_client *client,
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static int lm80_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-
-/* Called when we have found a new LM80. */
-static void lm80_init_client(struct i2c_client *client)
-{
-	/*
-	 * Reset all except Watchdog values and last conversion values
-	 * This sets fan-divs to 2, among others. This makes most other
-	 * initializations unnecessary
-	 */
-	lm80_write_value(client, LM80_REG_CONFIG, 0x80);
-	/* Set 11-bit temperature resolution */
-	lm80_write_value(client, LM80_REG_RES, 0x08);
-
-	/* Start monitoring */
-	lm80_write_value(client, LM80_REG_CONFIG, 0x01);
-}
-
-static struct lm80_data *lm80_update_device(struct device *dev)
-{
-	struct lm80_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	int i;
-	int rv;
-	int prev_rv;
-	struct lm80_data *ret = data;
-
-	mutex_lock(&data->update_lock);
-
-	if (data->error)
-		lm80_init_client(client);
-
-	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
-		dev_dbg(dev, "Starting lm80 update\n");
-		for (i = 0; i <= 6; i++) {
-			rv = lm80_read_value(client, LM80_REG_IN(i));
-			if (rv < 0)
-				goto abort;
-			data->in[i_input][i] = rv;
-
-			rv = lm80_read_value(client, LM80_REG_IN_MIN(i));
-			if (rv < 0)
-				goto abort;
-			data->in[i_min][i] = rv;
-
-			rv = lm80_read_value(client, LM80_REG_IN_MAX(i));
-			if (rv < 0)
-				goto abort;
-			data->in[i_max][i] = rv;
-		}
-
-		rv = lm80_read_value(client, LM80_REG_FAN1);
-		if (rv < 0)
-			goto abort;
-		data->fan[f_input][0] = rv;
-
-		rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-		if (rv < 0)
-			goto abort;
-		data->fan[f_min][0] = rv;
-
-		rv = lm80_read_value(client, LM80_REG_FAN2);
-		if (rv < 0)
-			goto abort;
-		data->fan[f_input][1] = rv;
-
-		rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
-		if (rv < 0)
-			goto abort;
-		data->fan[f_min][1] = rv;
-
-		prev_rv = rv = lm80_read_value(client, LM80_REG_TEMP);
-		if (rv < 0)
-			goto abort;
-		rv = lm80_read_value(client, LM80_REG_RES);
-		if (rv < 0)
-			goto abort;
-		data->temp[t_input] = (prev_rv << 8) | (rv & 0xf0);
-
-		for (i = t_input + 1; i < t_num_temp; i++) {
-			rv = lm80_read_value(client, temp_regs[i]);
-			if (rv < 0)
-				goto abort;
-			data->temp[i] = rv << 8;
-		}
-
-		rv = lm80_read_value(client, LM80_REG_FANDIV);
-		if (rv < 0)
-			goto abort;
-		data->fan_div[0] = (rv >> 2) & 0x03;
-		data->fan_div[1] = (rv >> 4) & 0x03;
-
-		prev_rv = rv = lm80_read_value(client, LM80_REG_ALARM1);
-		if (rv < 0)
-			goto abort;
-		rv = lm80_read_value(client, LM80_REG_ALARM2);
-		if (rv < 0)
-			goto abort;
-		data->alarms = prev_rv + (rv << 8);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-		data->error = 0;
-	}
-	goto done;
-
-abort:
-	ret = ERR_PTR(rv);
-	data->valid = 0;
-	data->error = 1;
+/*
+ * Driver data (common to all clients)
+ */
 
-done:
-	mutex_unlock(&data->update_lock);
+static const struct i2c_device_id lm80_id[] = {
+	{ "lm80", 0 },
+	{ "lm96080", 1 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm80_id);
 
-	return ret;
-}
+static struct i2c_driver lm80_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "lm80",
+	},
+	.probe		= lm80_probe,
+	.id_table	= lm80_id,
+	.detect		= lm80_detect,
+	.address_list	= normal_i2c,
+};
 
 module_i2c_driver(lm80_driver);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
