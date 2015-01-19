From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Jan 2015 01:36:48 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (jc42) Fix integer overflow
Message-Id: <1421631408-30235-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mixed use of long and int caused an integer overflow when writing large limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 262d808..f8e3bbb 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -201,7 +201,7 @@ struct jc42_data {
 #define JC42_TEMP_MIN		0
 #define JC42_TEMP_MAX		125000
 
-static u16 jc42_temp_to_reg(int temp, bool extended)
+static u16 jc42_temp_to_reg(long temp, bool extended)
 {
 	int ntemp = clamp_val(temp,
 			      extended ? JC42_TEMP_MIN_EXTENDED :
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
