From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 18 Feb 2010 17:46:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: (g760a) Make rpm_from_cnt static
Message-Id: <20100218184625.6dd29565@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function rpm_from_cnt is only used internally so it can be made
static. Make it inline while we're here, for performance reasons
(although hopefully gcc would figure out by itself...)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Herbert Valerio Riedel <hvr@gnu.org>
Cc: Martin Michlmayr <tbm@cyrius.com>
---
 drivers/hwmon/g760a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.33-rc8.orig/drivers/hwmon/g760a.c	2010-02-18 16:13:16.000000000 +0100
+++ linux-2.6.33-rc8/drivers/hwmon/g760a.c	2010-02-18 16:35:22.000000000 +0100
@@ -68,7 +68,7 @@ struct g760a_data {
 #define PWM_FROM_CNT(cnt)	(0xff-(cnt))
 #define PWM_TO_CNT(pwm)		(0xff-(pwm))
 
-unsigned int rpm_from_cnt(u8 val, u32 clk, u16 div)
+static inline unsigned int rpm_from_cnt(u8 val, u32 clk, u16 div)
 {
 	return ((val = 0x00) ? 0 : ((clk*30)/(val*div)));
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
