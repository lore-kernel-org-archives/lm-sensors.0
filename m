From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 07 May 2014 08:25:14 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (g762) Make of_device_id array const
Message-Id: <01f801cf69cd$defae330$9cf0a990$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/g762.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index b4b8b5b..98a8618 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -586,7 +586,7 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
  */
 
 #ifdef CONFIG_OF
-static struct of_device_id g762_dt_match[] = {
+static const struct of_device_id g762_dt_match[] = {
 	{ .compatible = "gmt,g762" },
 	{ .compatible = "gmt,g763" },
 	{ },
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
