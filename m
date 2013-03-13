From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:58:40 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (pmbus/lm25066) Clamp limit attributes
Message-Id: <1363219122-27226-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Limits on all supported sensors and chips have to be within 0..0x0fff,
and limits are always positive.

Clamp written values in chip driver. Also clear value cache to ensure
that the actually written value is read back and reported correctly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/lm25066.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 5489d70..f9f0c93 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -123,15 +123,28 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	int ret;
 
 	switch (reg) {
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
+		ret = pmbus_write_word_data(client, 0, reg, word);
+		pmbus_clear_cache(client);
+		break;
 	case PMBUS_IIN_OC_WARN_LIMIT:
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_IIN_OC_WARN_LIMIT,
 					    word);
+		pmbus_clear_cache(client);
 		break;
 	case PMBUS_PIN_OP_WARN_LIMIT:
+		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, 0x0fff);
 		ret = pmbus_write_word_data(client, 0,
 					    LM25066_MFR_PIN_OP_WARN_LIMIT,
 					    word);
+		pmbus_clear_cache(client);
 		break;
 	case PMBUS_VIRT_RESET_PIN_HISTORY:
 		ret = pmbus_write_byte(client, 0, LM25066_CLEAR_PIN_PEAK);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
