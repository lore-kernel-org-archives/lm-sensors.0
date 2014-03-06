From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Mar 2014 05:26:20 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (pmbus/ltc2978) Add new chip ID for LTC2974
Message-Id: <1394083580-26077-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC2974 datasheet revision C lists the chip ID for LTC2974 as 0x0213.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Mark old revision ID as _REV1.

 drivers/hwmon/pmbus/ltc2978.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index de3c152..629bfe0 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -53,7 +53,8 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883 };
 /* LTC3883 only */
 #define LTC3883_MFR_IIN_PEAK		0xe1
 
-#define LTC2974_ID			0x0212
+#define LTC2974_ID_REV1			0x0212
+#define LTC2974_ID_REV2			0x0213
 #define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
@@ -394,7 +395,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	if (chip_id < 0)
 		return chip_id;
 
-	if (chip_id = LTC2974_ID) {
+	if (chip_id = LTC2974_ID_REV1 || chip_id = LTC2974_ID_REV2) {
 		data->id = ltc2974;
 	} else if (chip_id = LTC2977_ID) {
 		data->id = ltc2977;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
