From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Oct 2013 21:29:34 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (pmbus/ltc2978): Add support for LTC2978A
Message-Id: <1381008574-21557-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Detect LTC2978A chip ID. Treat it as LC2978.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/ltc2978   |    3 ++-
 drivers/hwmon/pmbus/ltc2978.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 6934936..a0546fc 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -10,10 +10,11 @@ Supported chips:
     Prefix: 'ltc2977'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc2977
-  * Linear Technology LTC2978
+  * Linear Technology LTC2978, LTC2978A
     Prefix: 'ltc2978'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltc2978
+    	       http://www.linear.com/product/ltc2978a
   * Linear Technology LTC3880
     Prefix: 'ltc3880'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index e05ff56..de3c152 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -57,6 +57,7 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883 };
 #define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0121
 #define LTC2978_ID_REV2			0x0122
+#define LTC2978A_ID			0x0124
 #define LTC3880_ID			0x4000
 #define LTC3880_ID_MASK			0xff00
 #define LTC3883_ID			0x4300
@@ -397,7 +398,8 @@ static int ltc2978_probe(struct i2c_client *client,
 		data->id = ltc2974;
 	} else if (chip_id = LTC2977_ID) {
 		data->id = ltc2977;
-	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
+	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2 ||
+		   chip_id = LTC2978A_ID) {
 		data->id = ltc2978;
 	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
 		data->id = ltc3880;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
