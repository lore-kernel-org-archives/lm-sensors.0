From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Mar 2011 20:09:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus) Fix LINEAR16 data format
Message-Id: <1299614992-18346-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LINEAR16 data format is unsigned, not signed. Impact is that affected
attributes report negative values in the upper half of the supported
value range.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 92540c9..6474512 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -359,20 +359,21 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 static int pmbus_reg2data_linear(struct pmbus_data *data,
 				 struct pmbus_sensor *sensor)
 {
-	s16 exponent, mantissa;
+	s16 exponent;
+	s32 mantissa;
 	long val;
 
-	if (sensor->class = PSC_VOLTAGE_OUT) {
+	if (sensor->class = PSC_VOLTAGE_OUT) {	/* LINEAR16 */
 		exponent = data->exponent;
-		mantissa = (s16) sensor->data;
-	} else {
+		mantissa = (u16) sensor->data;
+	} else {				/* LINEAR11 */
 		exponent = (sensor->data >> 11) & 0x001f;
 		mantissa = sensor->data & 0x07ff;
 
 		if (exponent > 0x0f)
 			exponent |= 0xffe0;	/* sign extend exponent */
 		if (mantissa > 0x03ff)
-			mantissa |= 0xf800;	/* sign extend mantissa */
+			mantissa |= 0xfffff800;	/* sign extend mantissa */
 	}
 
 	val = mantissa;
@@ -454,19 +455,18 @@ static int pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 				 enum pmbus_sensor_classes class, long val)
 {
-	s16 exponent = 0, mantissa = 0;
+	s16 exponent = 0, mantissa;
 	bool negative = false;
 
 	/* simple case */
 	if (val = 0)
 		return 0;
 
-	if (val < 0) {
-		negative = true;
-		val = -val;
-	}
-
 	if (class = PSC_VOLTAGE_OUT) {
+		/* LINEAR16 does not support negative voltages */
+		if (val < 0)
+			return 0;
+
 		/*
 		 * For a static exponents, we don't have a choice
 		 * but to adjust the value to it.
@@ -476,9 +476,12 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 		else
 			val >>= data->exponent;
 		val = DIV_ROUND_CLOSEST(val, 1000);
-		if (val > 0x7fff)
-			val = 0x7fff;
-		return negative ? -val : val;
+		return val & 0xffff;
+	}
+
+	if (val < 0) {
+		negative = true;
+		val = -val;
 	}
 
 	/* Power is in uW. Convert to mW before converting. */
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
