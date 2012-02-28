From: Nikolaus Schulz <mail@microschulz.de>
Date: Tue, 28 Feb 2012 21:15:51 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (f75375s) Fix writes to the pwm* attribute for the F75387
Message-Id: <1330463755-5763-2-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For the F75387, the register holding the current PWM duty cycle value is
r/o; changing it requires writing to the fan expect register instead.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 5dae122..1c26652 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -178,6 +178,15 @@ static inline void f75375_write16(struct i2c_client *client, u8 reg,
 	i2c_smbus_write_byte_data(client, reg + 1, (value & 0xFF));
 }
 
+static void f75375_write_pwm(struct i2c_client *client, int nr, u8 pwm)
+{
+	struct f75375_data *data = i2c_get_clientdata(client);
+	if (data->kind = f75387)
+		f75375_write16(client, F75375_REG_FAN_EXP(nr), pwm);
+	else
+		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr), pwm);
+}
+
 static struct f75375_data *f75375_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -309,7 +318,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
-	f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr), data->pwm[nr]);
+	f75375_write_pwm(client, nr, data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -374,8 +383,7 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 	f75375_write8(client, F75375_REG_FAN_TIMER, fanmode);
 	data->pwm_enable[nr] = val;
 	if (val = 0)
-		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-				data->pwm[nr]);
+		f75375_write_pwm(client, nr, data->pwm[nr]);
 	return 0;
 }
 
@@ -759,8 +767,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
 	for (nr = 0; nr < 2; nr++) {
 		data->pwm[nr] = SENSORS_LIMIT(f75375s_pdata->pwm[nr], 0, 255);
-		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-			data->pwm[nr]);
+		f75375_write_pwm(client, nr, data->pwm[nr]);
 	}
 
 }
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
