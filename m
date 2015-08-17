From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:40 +0000
Subject: [lm-sensors] [PATCH 6/8] hwmon: (ltc2978) Add missing chip IDs for LTC2978 and LTC3882
Message-Id: <1439837682-23748-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add additional chip ID for an older revision of LTC2978, as well
as two chip IDs for LTC3882. Turns out the LTC3882 does support the
LTC2978_MFR_SPECIAL_ID register, and reading it returns its chip ID,
but the register is undocumented.

Suggested-by: Michael Jones <mike@proclivis.com>
Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 491078f499ca..87e3fb67d025 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -31,7 +31,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
 #define LTC2978_MFR_VOUT_PEAK		0xdd
 #define LTC2978_MFR_VIN_PEAK		0xde
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
-#define LTC2978_MFR_SPECIAL_ID		0xe7	/* Not on LTC3882 */
+#define LTC2978_MFR_SPECIAL_ID		0xe7	/* Undocumented on LTC3882 */
 
 /* LTC2974, LTC2975, LCT2977, and LTC2978 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
@@ -61,8 +61,11 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
 #define LTC2974_ID			0x0210
 #define LTC2975_ID			0x0220
 #define LTC2977_ID			0x0130
-#define LTC2978_ID			0x0120
+#define LTC2978_ID_REV1			0x0110	/* Early revision */
+#define LTC2978_ID_REV2			0x0120
 #define LTC3880_ID			0x4000
+#define LTC3882_ID			0x4200
+#define LTC3882_ID_D1			0x4240	/* Dash 1 */
 #define LTC3883_ID			0x4300
 #define LTC3887_ID			0x4700
 #define LTM4676_ID_REV1			0x4400
@@ -466,10 +469,12 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc2975;
 	else if (chip_id = LTC2977_ID)
 		return ltc2977;
-	else if (chip_id = LTC2978_ID)
+	else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2)
 		return ltc2978;
 	else if (chip_id = LTC3880_ID)
 		return ltc3880;
+	else if (chip_id = LTC3882_ID || chip_id = LTC3882_ID_D1)
+		return ltc3882;
 	else if (chip_id = LTC3883_ID)
 		return ltc3883;
 	else if (chip_id = LTC3887_ID)
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
