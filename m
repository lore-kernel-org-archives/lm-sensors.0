From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 22 Feb 2012 22:18:47 +0000
Subject: [lm-sensors] [PATCH 4/6] hwmon: (f75375s) Fix hysteresis register access for the F75387
Message-Id: <1329949129-4265-5-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The F75387 stores its temperature hysteresis in a different register than
the other chips supported by that driver.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 944937c..3b06abf 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -65,6 +65,7 @@ enum chips { f75373, f75375, f75387 };
 #define F75387_REG_TEMP11_LSB(nr)	(0x1a + (nr))
 #define F75375_REG_TEMP_HIGH(nr)	(0x28 + (nr) * 2)
 #define F75375_REG_TEMP_HYST(nr)	(0x29 + (nr) * 2)
+#define F75387_REG_TEMP_HYST		0x62
 
 #define F75375_REG_FAN(nr)		(0x16 + (nr) * 2)
 #define F75375_REG_FAN_MIN(nr)		(0x2C + (nr) * 2)
@@ -183,23 +184,34 @@ static struct f75375_data *f75375_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct f75375_data *data = i2c_get_clientdata(client);
 	int nr;
+	u8 f75387_hyst_reg = 0;
 
 	mutex_lock(&data->update_lock);
 
 	/* Limit registers cache is refreshed after 60 seconds */
 	if (time_after(jiffies, data->last_limits + 60 * HZ)
 		|| !data->valid) {
+		if (data->kind = f75387)
+			f75387_hyst_reg +				f75375_read8(client, F75387_REG_TEMP_HYST);
 		for (nr = 0; nr < 2; nr++) {
 			data->temp_high[nr]  				f75375_read8(client, F75375_REG_TEMP_HIGH(nr));
-			data->temp_max_hyst[nr] -				f75375_read8(client, F75375_REG_TEMP_HYST(nr));
 			data->fan_max[nr]  				f75375_read16(client, F75375_REG_FAN_FULL(nr));
 			data->fan_min[nr]  				f75375_read16(client, F75375_REG_FAN_MIN(nr));
 			data->fan_target[nr]  				f75375_read16(client, F75375_REG_FAN_EXP(nr));
+			if (data->kind = f75387) {
+				data->temp_max_hyst[nr] +					data->temp_high[nr] -
+					(0xf & f75387_hyst_reg);
+			} else {
+				data->temp_max_hyst[nr] +					f75375_read8(client,
+						F75375_REG_TEMP_HYST(nr));
+			}
 		}
 		for (nr = 0; nr < 4; nr++) {
 			data->in_max[nr] @@ -599,11 +611,23 @@ static ssize_t set_temp_max_hyst(struct device *dev,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(TEMP_TO_REG(val), 0, 127);
+	val = TEMP_TO_REG(val);
 	mutex_lock(&data->update_lock);
-	data->temp_max_hyst[nr] = val;
-	f75375_write8(client, F75375_REG_TEMP_HYST(nr),
-		data->temp_max_hyst[nr]);
+	if (data->kind = f75387) {
+		u8 regval;
+		val = SENSORS_LIMIT(val,
+				data->temp_high[nr] - 0xf,
+				data->temp_high[nr]);
+		data->temp_max_hyst[nr] = val;
+		regval = f75375_read8(client, F75387_REG_TEMP_HYST);
+		regval &= 0xf0;
+		regval |= data->temp_high[nr] - val;
+		f75375_write8(client, F75387_REG_TEMP_HYST, regval);
+	} else {
+		val = SENSORS_LIMIT(val, 0, 127);
+		data->temp_max_hyst[nr] = val;
+		f75375_write8(client, F75375_REG_TEMP_HYST(nr), val);
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
