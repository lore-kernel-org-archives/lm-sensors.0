From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 27 Sep 2013 11:38:00 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: (gpio-fan) Include linux/of.h header
Message-Id: <1380281160-7560-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hwmon/gpio-fan.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index d5148c8..73181be 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon.h>
 #include <linux/gpio.h>
 #include <linux/gpio-fan.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
