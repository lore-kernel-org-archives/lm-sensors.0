From: Peter Hung <hpeter@gmail.com>
Date: Tue, 07 Jul 2015 08:22:38 +0000
Subject: [lm-sensors] [PATCH V3 3/3] hwmon:f71882fg fix f81866a voltage protection
Message-Id: <1436257358-31360-4-git-send-email-hpeter+linux_kernel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

The f81866a voltage-1 protector(VIN1) address
is differ from f71882.

f71882 status:12H, beep:13H, v-high:32H
f81866a status:16H, beep:17H, v-high:3aH

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/hwmon/f71882fg.c | 50 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 79f1f50..7cecd83 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -71,6 +71,10 @@
 #define F71882FG_REG_IN(nr)		(0x20  + (nr))
 #define F71882FG_REG_IN1_HIGH		0x32 /* f7188x only */
 
+#define F81866_REG_IN_STATUS		0x16 /* F81866 only */
+#define F81866_REG_IN_BEEP			0x17 /* F81866 only */
+#define F81866_REG_IN1_HIGH		0x3a /* F81866 only */
+
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
 #define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
 #define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
@@ -1204,10 +1208,21 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_limits + 60 * HZ) ||
 			!data->valid) {
 		if (f71882fg_has_in1_alarm[data->type]) {
-			data->in1_max -				f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
-			data->in_beep -				f71882fg_read8(data, F71882FG_REG_IN_BEEP);
+			if (data->type = f81866a) {
+				data->in1_max +					f71882fg_read8(data,
+							F81866_REG_IN1_HIGH);
+				data->in_beep +					f71882fg_read8(data,
+							F81866_REG_IN_BEEP);
+			} else {
+				data->in1_max +					f71882fg_read8(data,
+							F71882FG_REG_IN1_HIGH);
+				data->in_beep +					f71882fg_read8(data,
+							F71882FG_REG_IN_BEEP);
+			}
 		}
 
 		/* Get High & boundary temps*/
@@ -1331,9 +1346,16 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			data->fan[3] = f71882fg_read16(data,
 						F71882FG_REG_FAN(3));
 
-		if (f71882fg_has_in1_alarm[data->type])
-			data->in_status = f71882fg_read8(data,
+		if (f71882fg_has_in1_alarm[data->type]) {
+			if (data->type = f81866a)
+				data->in_status = f71882fg_read8(data,
+						F81866_REG_IN_STATUS);
+
+			else
+				data->in_status = f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
+		}
+
 		for (nr = 0; nr < F71882FG_MAX_INS; nr++)
 			if (f71882fg_has_in[data->type][nr])
 				data->in[nr] = f71882fg_read8(data,
@@ -1474,7 +1496,10 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute
 	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
-	f71882fg_write8(data, F71882FG_REG_IN1_HIGH, val);
+	if (data->type = f81866a)
+		f71882fg_write8(data, F81866_REG_IN1_HIGH, val);
+	else
+		f71882fg_write8(data, F71882FG_REG_IN1_HIGH, val);
 	data->in1_max = val;
 	mutex_unlock(&data->update_lock);
 
@@ -1505,13 +1530,20 @@ static ssize_t store_in_beep(struct device *dev, struct device_attribute
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
+	if (data->type = f81866a)
+		data->in_beep = f71882fg_read8(data, F81866_REG_IN_BEEP);
+	else
+		data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
+
 	if (val)
 		data->in_beep |= 1 << nr;
 	else
 		data->in_beep &= ~(1 << nr);
 
-	f71882fg_write8(data, F71882FG_REG_IN_BEEP, data->in_beep);
+	if (data->type = f81866a)
+		f71882fg_write8(data, F81866_REG_IN_BEEP, data->in_beep);
+	else
+		f71882fg_write8(data, F71882FG_REG_IN_BEEP, data->in_beep);
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
