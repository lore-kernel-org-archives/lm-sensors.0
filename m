From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jul 2015 21:09:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc2978) LTM4676 supports CLEAR_PEAKS
Message-Id: <1437426550-1507-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the CLEAR_PEAKS command on LTM4676.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 0835050ec245..33081d1d1c5a 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -313,7 +313,7 @@ static int ltc2978_clear_peaks(struct i2c_client *client, int page,
 {
 	int ret;
 
-	if (id = ltc3880 || id = ltc3883)
+	if (id = ltc3880 || id = ltc3883 || id = ltm4676)
 		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
 	else
 		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
