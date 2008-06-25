From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 11:43:22 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (lm90) Move 16-bit value read to a
Message-Id: <20080625134322.6d097d28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the code which aggregates two 8-bit register values into a 16-bit
value to a separate function. We'll need to do it a second time soon and
I don't want to duplicate the code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |   70 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/lm90.c	2008-06-25 10:13:42.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/lm90.c	2008-06-25 10:13:49.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003-2006  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2008  Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
@@ -729,6 +729,38 @@ static int lm90_detach_client(struct i2c
 	return 0;
 }
 
+static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
+{
+	int err;
+	u8 oldh, newh, l;
+
+	/*
+	 * There is a trick here. We have to read two registers to have the
+	 * sensor temperature, but we have to beware a conversion could occur
+	 * inbetween the readings. The datasheet says we should either use
+	 * the one-shot conversion register, which we don't want to do
+	 * (disables hardware monitoring) or monitor the busy bit, which is
+	 * impossible (we can't read the values and monitor that bit at the
+	 * exact same time). So the solution used here is to read the high
+	 * byte once, then the low byte, then the high byte again. If the new
+	 * high byte matches the old one, then we have a valid reading. Else
+	 * we have to read the low byte again, and now we believe we have a
+	 * correct reading.
+	 */
+	if ((err = lm90_read_reg(client, regh, &oldh))
+	 || (err = lm90_read_reg(client, regl, &l))
+	 || (err = lm90_read_reg(client, regh, &newh)))
+		return err;
+	if (oldh != newh) {
+		err = lm90_read_reg(client, regl, &l);
+		if (err)
+			return err;
+	}
+	*value = (newh << 8) | l;
+
+	return 0;
+}
+
 static struct lm90_data *lm90_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -737,7 +769,7 @@ static struct lm90_data *lm90_update_dev
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
-		u8 oldh, newh, l;
+		u8 h, l;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
 		lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP, &data->temp8[0]);
@@ -747,39 +779,21 @@ static struct lm90_data *lm90_update_dev
 		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[4]);
 		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
 
-		/*
-		 * There is a trick here. We have to read two registers to
-		 * have the remote sensor temperature, but we have to beware
-		 * a conversion could occur inbetween the readings. The
-		 * datasheet says we should either use the one-shot
-		 * conversion register, which we don't want to do (disables
-		 * hardware monitoring) or monitor the busy bit, which is
-		 * impossible (we can't read the values and monitor that bit
-		 * at the exact same time). So the solution used here is to
-		 * read the high byte once, then the low byte, then the high
-		 * byte again. If the new high byte matches the old one,
-		 * then we have a valid reading. Else we have to read the low
-		 * byte again, and now we believe we have a correct reading.
-		 */
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_TEMPH, &oldh) = 0
-		 && lm90_read_reg(client, LM90_REG_R_REMOTE_TEMPL, &l) = 0
-		 && lm90_read_reg(client, LM90_REG_R_REMOTE_TEMPH, &newh) = 0
-		 && (newh = oldh
-		  || lm90_read_reg(client, LM90_REG_R_REMOTE_TEMPL, &l) = 0))
-			data->temp11[0] = (newh << 8) | l;
+		lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
+			    LM90_REG_R_REMOTE_TEMPL, &data->temp11[0]);
 
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &newh) = 0
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0
 		 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL, &l) = 0)
-			data->temp11[1] = (newh << 8) | l;
-		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &newh) = 0
+			data->temp11[1] = (h << 8) | l;
+		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0
 		 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL, &l) = 0)
-			data->temp11[2] = (newh << 8) | l;
+			data->temp11[2] = (h << 8) | l;
 		if (data->kind != max6657) {
 			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
-					  &newh) = 0
+					  &h) = 0
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,
 					  &l) = 0)
-				data->temp11[3] = (newh << 8) | l;
+				data->temp11[3] = (h << 8) | l;
 		}
 		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
