From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 29 Sep 2011 00:05:15 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus_core) Simplify sign extensions
Message-Id: <1317254715-32416-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Shift operations can be used for sign extensions. Use it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 0824182..35cf2f2 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -455,13 +455,8 @@ static long pmbus_reg2data_linear(struct pmbus_data *data,
 		exponent = data->exponent;
 		mantissa = (u16) sensor->data;
 	} else {				/* LINEAR11 */
-		exponent = (sensor->data >> 11) & 0x001f;
-		mantissa = sensor->data & 0x07ff;
-
-		if (exponent > 0x0f)
-			exponent |= 0xffe0;	/* sign extend exponent */
-		if (mantissa > 0x03ff)
-			mantissa |= 0xfffff800;	/* sign extend mantissa */
+		exponent = ((s16)sensor->data) >> 11;
+		mantissa = (((s16)(sensor->data & 0x7ff)) << 5) >> 5;
 	}
 
 	val = mantissa;
@@ -1641,7 +1636,7 @@ static void pmbus_find_attributes(struct i2c_client *client,
 static int pmbus_identify_common(struct i2c_client *client,
 				 struct pmbus_data *data)
 {
-	int vout_mode = -1, exponent;
+	int vout_mode = -1;
 
 	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
 		vout_mode = _pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
@@ -1655,11 +1650,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 			if (data->info->format[PSC_VOLTAGE_OUT] != linear)
 				return -ENODEV;
 
-			exponent = vout_mode & 0x1f;
-			/* and sign-extend it */
-			if (exponent & 0x10)
-				exponent |= ~0x1f;
-			data->exponent = exponent;
+			data->exponent = ((s8)(vout_mode << 3)) >> 3;
 			break;
 		case 1: /* VID mode         */
 			if (data->info->format[PSC_VOLTAGE_OUT] != vid)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
