From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2012 13:56:54 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (fam15h_power) Fix unintentional integer overflow
Message-Id: <1340287015-14008-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Expression with two unsigned integer variables is calculated as unsigned integer
before it is converted to u64. This may result in an integer overflow.
Fix by typecasting the left operand to u64 before performing the left shift.

This patch addresses Coverity #402320: Unintentional integer overflow.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/fam15h_power.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6b13f1a..2764b78 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -67,7 +67,8 @@ static ssize_t show_power(struct device *dev,
 				  REG_TDP_LIMIT3, &val);
 
 	tdp_limit = val >> 16;
-	curr_pwr_watts = (tdp_limit + data->base_tdp) << running_avg_range;
+	curr_pwr_watts = ((u64)(tdp_limit +
+				data->base_tdp)) << running_avg_range;
 	curr_pwr_watts -= running_avg_capture;
 	curr_pwr_watts *= data->tdp_to_watts;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
