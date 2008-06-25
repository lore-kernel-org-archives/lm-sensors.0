From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 11:49:28 +0000
Subject: [lm-sensors] [PATCH 3/6] hwmon: (lm90) Don't access nonexistent
Message-Id: <20080625134928.6750ec87@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Maxim chips supported by the lm90 driver have 8-bit high and low
remote limit values, not 11-bit as the other chips have. So stop reading
from and writing to registers that do not exist on these chips. Also
round the limit values set by the user properly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/hwmon/lm90.c	2008-05-28 17:00:24.000000000 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/lm90.c	2008-05-28 17:00:50.000000000 +0200
@@ -303,12 +303,16 @@ static ssize_t set_temp11(struct device 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
 		data->temp11[nr] = TEMP2_TO_REG_ADT7461(val);
+	else if (data->kind = max6657 || data->kind = max6680)
+		data->temp11[nr] = TEMP1_TO_REG(val) << 8;
 	else
 		data->temp11[nr] = TEMP2_TO_REG(val);
+
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
-	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
-				  data->temp11[nr] & 0xff);
+	if (data->kind != max6657 && data->kind != max6680)
+		i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
+					  data->temp11[nr] & 0xff);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -794,12 +798,21 @@ static struct lm90_data *lm90_update_dev
 		lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
 			    LM90_REG_R_REMOTE_TEMPL, &data->temp11[0]);
 
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0
-		 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL, &l) = 0)
-			data->temp11[1] = (h << 8) | l;
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0
-		 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL, &l) = 0)
-			data->temp11[2] = (h << 8) | l;
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0) {
+			data->temp11[1] = h << 8;
+			if (data->kind != max6657 && data->kind != max6680
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
+					  &l) = 0)
+				data->temp11[1] |= l;
+		}
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0) {
+			data->temp11[2] = h << 8;
+			if (data->kind != max6657 && data->kind != max6680
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
+					  &l) = 0)
+				data->temp11[2] |= l;
+		}
+
 		if (data->kind != max6657) {
 			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
 					  &h) = 0

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
