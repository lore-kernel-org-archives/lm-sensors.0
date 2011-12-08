From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 08 Dec 2011 13:04:12 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: jz4740: fix signedness bug
Message-Id: <1323349452.2823.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

wait_for_completion_interruptible_timeout() may return negative value.
In this case, checking if (t > 0)  will return true if t is unsigned.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/jz4740-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 7a48b1e..3d7e590 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -59,7 +59,7 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
 {
 	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
 	struct completion *completion = &hwmon->read_completion;
-	unsigned long t;
+	long t;
 	unsigned long val;
 	int ret;
 
-- 
1.7.5.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
