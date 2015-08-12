From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Aug 2015 18:18:51 +0000
Subject: [lm-sensors] [PATCH v2 3/4] hwmon: (ltc2978) Add additional chip IDs for LTM4676 and LTM4676A
Message-Id: <1439403532-30884-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Per datasheet, the chip ID for LTM4676 is 0x448x. This was observed
in real systems. In addition to that, chip ID 0x4401 was observed
as well. Research shows that the chip ID has been changed from 0x440x
to 0x448x in datasheet revision C. Add support for the additional chip ID.

Also add the chip ID for LTM4676A, which is functionally identical
to LTM4676.

Reported-by: Ananda Babu Nettam <anandab@juniper.net>
Cc: Ananda Babu Nettam <anandab@juniper.net>
Cc: Amit U Jain <amjain@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: rebase

 drivers/hwmon/pmbus/ltc2978.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 28e1e735b5c2..acbfe3ec2ffd 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -60,7 +60,9 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3882, ltc3883, ltm4676 };
 #define LTC3880_ID_MASK			0xff00
 #define LTC3883_ID			0x4300
 #define LTC3883_ID_MASK			0xff00
-#define LTM4676_ID			0x4480	/* datasheet claims 0x440X */
+#define LTM4676_ID			0x4400
+#define LTM4676_ID_2			0x4480
+#define LTM4676A_ID			0x47E0
 #define LTM4676_ID_MASK			0xfff0
 
 #define LTC2974_NUM_PAGES		4
@@ -430,7 +432,9 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc3880;
 	else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID)
 		return ltc3883;
-	else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID)
+	else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID ||
+		 (chip_id & LTM4676_ID_MASK) = LTM4676_ID_2 ||
+		 (chip_id & LTM4676_ID_MASK) = LTM4676A_ID)
 		return ltm4676;
 
 	dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
