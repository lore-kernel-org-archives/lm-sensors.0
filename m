From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 14:58:04 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (lm77) Prevent overflow problem when writing large limits
Message-Id: <1406818684.13799.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip.
Clamp the input values to the supported limits first to fix the problem.

For set_temp_hyst:
As Guenter pointed out that the temperature is read as unsigned and stored in
an unsigned long. This is wrong; nothing in the datasheet suggests that the
value (the absolute temperature) must be positive.
So change it to signed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm77.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 5ceb443..69b05cc 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -80,8 +80,7 @@ struct lm77_data {
  */
 static inline s16 LM77_TEMP_TO_REG(int temp)
 {
-	int ntemp = clamp_val(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
-	return (ntemp / 500) * 8;
+	return (temp / 500) * 8;
 }
 
 static inline int LM77_TEMP_FROM_REG(s16 reg)
@@ -175,6 +174,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	if (err)
 		return err;
 
+	val = clamp_val(val, LM77_TEMP_MIN, LM77_TEMP_MAX);
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = val;
 	lm77_write_value(client, temp_regs[nr], LM77_TEMP_TO_REG(val));
@@ -192,15 +192,16 @@ static ssize_t set_temp_hyst(struct device *dev,
 {
 	struct lm77_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	unsigned long val;
+	long val;
 	int err;
 
-	err = kstrtoul(buf, 10, &val);
+	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp[t_hyst] = data->temp[t_crit] - val;
+	val = clamp_val(data->temp[t_crit] - val, LM77_TEMP_MIN, LM77_TEMP_MAX);
+	data->temp[t_hyst] = val;
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp[t_hyst]));
 	mutex_unlock(&data->update_lock);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
