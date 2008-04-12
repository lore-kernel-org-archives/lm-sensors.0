From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 17:56:35 +0000
Subject: [lm-sensors] [PATCH 04/10] hwmon: (lm85) Don't write back cached
Message-Id: <20080412195635.10a49b26@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In set_pwm_auto_pwm_minctl, we write cached register bits back to the
chip. This is a bad idea as we have no guarantee that the cache is
up-to-date. Better read a fresh register value from the chip, it's
safer and in fact it is also more simple.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 09:50:16.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 09:50:19.000000000 +0200
@@ -309,10 +309,8 @@ struct lm85_data {
 	u8 pwm[3];		/* Register value */
 	u8 temp_ext[3];		/* Decoded values */
 	u8 in_ext[8];		/* Decoded values */
-	u8 smooth[1];		/* Register encoding */
 	u8 vid;			/* Register value */
 	u8 vrm;			/* VRM version */
-	u8 syncpwm3;		/* Saved PWM3 for TACH 2,3,4 config */
 	u32 alarms;		/* Register encoding, combined */
 	struct lm85_autofan autofan[3];
 	struct lm85_zone zone[3];
@@ -757,14 +755,15 @@ static ssize_t set_pwm_auto_pwm_minctl(s
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+	u8 tmp;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_off = val;
-	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
-		| data->syncpwm3
-		| (data->autofan[0].min_off ? 0x20 : 0)
-		| (data->autofan[1].min_off ? 0x40 : 0)
-		| (data->autofan[2].min_off ? 0x80 : 0));
+	tmp = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
+	tmp &= ~(0x20 << nr);
+	if (data->autofan[nr].min_off)
+		tmp |= 0x20 << nr;
+	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, tmp);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1530,8 +1529,6 @@ static struct lm85_data *lm85_update_dev
 		}
 
 		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
-		data->smooth[0] = i & 0x0f;
-		data->syncpwm3 = i & 0x10;  /* Save PWM3 config */
 		data->autofan[0].min_off = (i & 0x20) != 0;
 		data->autofan[1].min_off = (i & 0x40) != 0;
 		data->autofan[2].min_off = (i & 0x80) != 0;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
