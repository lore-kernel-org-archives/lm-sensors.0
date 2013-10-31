From: Wei Ni <wni@nvidia.com>
Date: Thu, 31 Oct 2013 03:07:41 +0000
Subject: [lm-sensors] [PATCH RESEND v4 1/3] hwmon: (lm90) Define status bits
Message-Id: <1383188862-4157-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add bit defines for the status register. And add a function
lm90_is_tripped() which will read status register and return
tripped or not, then lm90_alert can call it directly, and in the
future the IRQ thread also can use it.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   75 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index cdff742..57485ef 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -179,6 +179,18 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
 #define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
 
+/* LM90 status */
+#define LM90_STATUS_LTHRM	(1 << 0) /* local THERM limit tripped */
+#define LM90_STATUS_RTHRM	(1 << 1) /* remote THERM limit tripped */
+#define LM90_STATUS_OPEN	(1 << 2) /* remote is an open circuit */
+#define LM90_STATUS_RLOW	(1 << 3) /* remote low temp limit tripped */
+#define LM90_STATUS_RHIGH	(1 << 4) /* remote high temp limit tripped */
+#define LM90_STATUS_LLOW	(1 << 5) /* local low temp limit tripped */
+#define LM90_STATUS_LHIGH	(1 << 6) /* local high temp limit tripped */
+
+#define MAX6696_STATUS2_RLOW	(1 << 3) /* remote2 low temp limit tripped */
+#define MAX6696_STATUS2_RHIGH	(1 << 4) /* remote2 high temp limit tripped */
+
 /*
  * Driver data (common to all clients)
  */
@@ -1391,6 +1403,38 @@ static void lm90_init_client(struct i2c_client *client)
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
+static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
+{
+	struct lm90_data *data = i2c_get_clientdata(client);
+	u8 st, st2 = 0;
+
+	lm90_read_reg(client, LM90_REG_R_STATUS, &st);
+
+	if (data->kind = max6696)
+		lm90_read_reg(client, MAX6696_REG_R_STATUS2, &st2);
+
+	*status = st | (st2 << 8);
+
+	if ((st & 0x7f) = 0 && (st2 & 0xfe) = 0)
+		return false;
+
+	if (st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM))
+		dev_warn(&client->dev,
+			 "temp%d out of range, please check!\n", 1);
+	if (st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM))
+		dev_warn(&client->dev,
+			 "temp%d out of range, please check!\n", 2);
+	if (st & LM90_STATUS_OPEN)
+		dev_warn(&client->dev,
+			 "temp%d diode open, please check!\n", 2);
+
+	if (st2 & (MAX6696_STATUS2_RLOW | MAX6696_STATUS2_RHIGH))
+		dev_warn(&client->dev,
+			 "temp%d out of range, please check!\n", 3);
+
+	return true;
+}
+
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -1489,43 +1533,26 @@ static int lm90_remove(struct i2c_client *client)
 
 static void lm90_alert(struct i2c_client *client, unsigned int flag)
 {
-	struct lm90_data *data = i2c_get_clientdata(client);
-	u8 config, alarms, alarms2 = 0;
-
-	lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
-
-	if (data->kind = max6696)
-		lm90_read_reg(client, MAX6696_REG_R_STATUS2, &alarms2);
-
-	if ((alarms & 0x7f) = 0 && (alarms2 & 0xfe) = 0) {
-		dev_info(&client->dev, "Everything OK\n");
-	} else {
-		if (alarms & 0x61)
-			dev_warn(&client->dev,
-				 "temp%d out of range, please check!\n", 1);
-		if (alarms & 0x1a)
-			dev_warn(&client->dev,
-				 "temp%d out of range, please check!\n", 2);
-		if (alarms & 0x04)
-			dev_warn(&client->dev,
-				 "temp%d diode open, please check!\n", 2);
-
-		if (alarms2 & 0x18)
-			dev_warn(&client->dev,
-				 "temp%d out of range, please check!\n", 3);
+	u16 alarms;
 
+	if (lm90_is_tripped(client, &alarms)) {
 		/*
 		 * Disable ALERT# output, because these chips don't implement
 		 * SMBus alert correctly; they should only hold the alert line
 		 * low briefly.
 		 */
+		struct lm90_data *data = i2c_get_clientdata(client);
+
 		if ((data->flags & LM90_HAVE_BROKEN_ALERT)
 		 && (alarms & data->alert_alarms)) {
+			u8 config;
 			dev_dbg(&client->dev, "Disabling ALERT#\n");
 			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
 			i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
 						  config | 0x80);
 		}
+	} else {
+		dev_info(&client->dev, "Everything OK\n");
 	}
 }
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
