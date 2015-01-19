From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Jan 2015 01:36:47 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (jc42) Use sign_extend32 for sign extension
Message-Id: <1421631408-30235-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Despite the name, sign_extend32 works just fine for 16 bit variables,
so it is safe to use.

Cc: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 388f8bc..262d808 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -213,11 +213,7 @@ static u16 jc42_temp_to_reg(int temp, bool extended)
 
 static int jc42_temp_from_reg(s16 reg)
 {
-	reg &= 0x1fff;
-
-	/* sign extend register */
-	if (reg & 0x1000)
-		reg |= 0xf000;
+	reg = sign_extend32(reg, 12);
 
 	/* convert from 0.0625 to 0.001 resolution */
 	return reg * 125 / 2;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
