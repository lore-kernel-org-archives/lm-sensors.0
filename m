From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Oct 2010 13:56:20 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (w83795) More style cleanups
Message-Id: <20101028155620.5cb01b08@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cleanups suggested by Guenter Roeck, falling into 4 categories:
* Swapping test orders, because if (var = CONSTANT) is much easier to
  read than if (CONSTANT = var).
* Simplifying comparisons with 0.
* Dropping unneeded masks.
* Dropping unneeded parentheses and curly braces.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83795.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

--- linux-2.6.37-rc0.orig/drivers/hwmon/w83795.c	2010-10-28 15:32:35.000000000 +0200
+++ linux-2.6.37-rc0/drivers/hwmon/w83795.c	2010-10-28 15:38:47.000000000 +0200
@@ -491,7 +491,7 @@ static void w83795_update_limits(struct
 	}
 
 	/* Read the DTS limits */
-	if (data->enable_dts != 0) {
+	if (data->enable_dts) {
 		for (limit = DTS_CRIT; limit <= DTS_WARN_HYST; limit++)
 			data->dts_ext[limit]  				w83795_read(client, W83795_REG_DTS_EXT(limit));
@@ -544,7 +544,7 @@ static struct w83795_data *w83795_update
 		data->pwm_temp[i][TEMP_PWM_CTFS]  			w83795_read(client, W83795_REG_CTFS(i));
 		tmp = w83795_read(client, W83795_REG_HT(i));
-		data->pwm_temp[i][TEMP_PWM_HCT] = (tmp >> 4) & 0x0f;
+		data->pwm_temp[i][TEMP_PWM_HCT] = tmp >> 4;
 		data->pwm_temp[i][TEMP_PWM_HOT] = tmp & 0x0f;
 	}
 
@@ -618,8 +618,7 @@ static struct w83795_data *w83795_update
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
-		data->fan[i] |-		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;
+		data->fan[i] |= w83795_read(client, W83795_REG_VRLSB) >> 4;
 	}
 
 	/* Update temperature */
@@ -631,7 +630,7 @@ static struct w83795_data *w83795_update
 	}
 
 	/* Update dts temperature */
-	if (data->enable_dts != 0) {
+	if (data->enable_dts) {
 		for (i = 0; i < ARRAY_SIZE(data->dts); i++) {
 			if (!(data->has_dts & (1 << i)))
 				continue;
@@ -677,11 +676,10 @@ show_alarm_beep(struct device *dev, stru
 	int bit = sensor_attr->index & 0x07;
 	u8 val;
 
-	if (ALARM_STATUS = nr) {
-		val = (data->alarms[index] >> (bit)) & 1;
-	} else {		/* BEEP_ENABLE */
-		val = (data->beeps[index] >> (bit)) & 1;
-	}
+	if (nr = ALARM_STATUS)
+		val = (data->alarms[index] >> bit) & 1;
+	else		/* BEEP_ENABLE */
+		val = (data->beeps[index] >> bit) & 1;
 
 	return sprintf(buf, "%u\n", val);
 }
@@ -744,7 +742,7 @@ show_fan(struct device *dev, struct devi
 	struct w83795_data *data = w83795_update_device(dev);
 	u16 val;
 
-	if (FAN_INPUT = nr)
+	if (nr = FAN_INPUT)
 		val = data->fan[index] & 0x0fff;
 	else
 		val = data->fan_min[index] & 0x0fff;
@@ -1011,7 +1009,7 @@ store_temp_pwm_enable(struct device *dev
 
 	switch (nr) {
 	case TEMP_PWM_ENABLE:
-		if ((tmp != 3) && (tmp != 4))
+		if (tmp != 3 && tmp != 4)
 			return -EINVAL;
 		tmp -= 3;
 		mutex_lock(&data->update_lock);
@@ -1074,7 +1072,7 @@ store_fanin(struct device *dev, struct d
 	switch (nr) {
 	case FANIN_TARGET:
 		val = fan_to_reg(SENSORS_LIMIT(val, 0, 0xfff));
-		w83795_write(client, W83795_REG_FTSH(index), (val >> 4) & 0xff);
+		w83795_write(client, W83795_REG_FTSH(index), val >> 4);
 		w83795_write(client, W83795_REG_FTSL(index), (val << 4) & 0xf0);
 		data->target_speed[index] = val;
 		break;
@@ -1234,7 +1232,7 @@ show_temp(struct device *dev, struct dev
 	struct w83795_data *data = w83795_update_device(dev);
 	long temp = temp_from_reg(data->temp[index][nr]);
 
-	if (TEMP_READ = nr)
+	if (nr = TEMP_READ)
 		temp += (data->temp_read_vrlsb[index] >> 6) * 250;
 	return sprintf(buf, "%ld\n", temp);
 }
@@ -1891,7 +1889,7 @@ static int w83795_handle_files(struct de
 		}
 	}
 
-	if (data->enable_dts != 0) {
+	if (data->enable_dts) {
 		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
 			if (!(data->has_dts & (1 << i)))
 				continue;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
