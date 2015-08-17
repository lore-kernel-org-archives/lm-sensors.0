From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 18:54:39 +0000
Subject: [lm-sensors] [PATCH 5/8] hwmon: (ltc2978) Use correct ID mask to detect all chips
Message-Id: <1439837682-23748-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Per information from Linear Technologies, the ID mask is 12 bit
for all chips of this series. Use this mask to detect chips to ensure
that all chip revisions are detected.

Suggested-by: Michael Jones <mike@proclivis.com>
Tested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index c3b71668a47f..491078f499ca 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -56,23 +56,18 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883,
 #define LTC2975_MFR_PIN_PEAK		0xc6
 #define LTC2975_MFR_PIN_MIN		0xc7
 
-#define LTC2974_ID_REV1			0x0212
-#define LTC2974_ID_REV2			0x0213
-#define LTC2975_ID			0x0223
+#define LTC2978_ID_MASK			0xfff0
+
+#define LTC2974_ID			0x0210
+#define LTC2975_ID			0x0220
 #define LTC2977_ID			0x0130
-#define LTC2978_ID_REV1			0x0121
-#define LTC2978_ID_REV2			0x0122
-#define LTC2978A_ID			0x0124
+#define LTC2978_ID			0x0120
 #define LTC3880_ID			0x4000
-#define LTC3880_ID_MASK			0xff00
 #define LTC3883_ID			0x4300
-#define LTC3883_ID_MASK			0xff00
 #define LTC3887_ID			0x4700
-#define LTC3887_ID_MASK			0xff00
-#define LTM4676_ID			0x4400
-#define LTM4676_ID_2			0x4480
+#define LTM4676_ID_REV1			0x4400
+#define LTM4676_ID_REV2			0x4480
 #define LTM4676A_ID			0x47e0
-#define LTM4676_ID_MASK			0xfff0
 
 #define LTC2974_NUM_PAGES		4
 #define LTC2978_NUM_PAGES		8
@@ -463,24 +458,24 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	if (chip_id = LTC2974_ID_REV1 || chip_id = LTC2974_ID_REV2)
+	chip_id &= LTC2978_ID_MASK;
+
+	if (chip_id = LTC2974_ID)
 		return ltc2974;
 	else if (chip_id = LTC2975_ID)
 		return ltc2975;
 	else if (chip_id = LTC2977_ID)
 		return ltc2977;
-	else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2 ||
-		 chip_id = LTC2978A_ID)
+	else if (chip_id = LTC2978_ID)
 		return ltc2978;
-	else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID)
+	else if (chip_id = LTC3880_ID)
 		return ltc3880;
-	else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID)
+	else if (chip_id = LTC3883_ID)
 		return ltc3883;
-	else if ((chip_id & LTC3887_ID_MASK) = LTC3887_ID)
+	else if (chip_id = LTC3887_ID)
 		return ltc3887;
-	else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID ||
-		 (chip_id & LTM4676_ID_MASK) = LTM4676_ID_2 ||
-		 (chip_id & LTM4676_ID_MASK) = LTM4676A_ID)
+	else if (chip_id = LTM4676_ID_REV1 || chip_id = LTM4676_ID_REV2 ||
+		 chip_id = LTM4676A_ID)
 		return ltm4676;
 
 	dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
