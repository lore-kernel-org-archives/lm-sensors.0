From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 08 Dec 2011 13:33:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: jz4740: Staticise jz4740_hwmon_driver
Message-Id: <1323351217.3398.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

It is not used outside this driver so no need to make the symbol global.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/jz4740-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 3d7e590..5253d23 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -203,7 +203,7 @@ static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct platform_driver jz4740_hwmon_driver = {
+static struct platform_driver jz4740_hwmon_driver = {
 	.probe	= jz4740_hwmon_probe,
 	.remove = __devexit_p(jz4740_hwmon_remove),
 	.driver = {
-- 
1.7.5.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
