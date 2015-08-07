From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 07 Aug 2015 17:03:50 +0000
Subject: [lm-sensors] [PATCH hwmon] watchdog: lpc18xx_wdt_get_timeleft() can be static
Message-Id: <20150807170350.GA92637@athens>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 lpc18xx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 00ff5bd..ab7b8b1 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -123,7 +123,7 @@ static int lpc18xx_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
+static unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
 	unsigned int val;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
