From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:31 +0000
Subject: [lm-sensors] [PATCH 08/17] drivers/hwmon/lm70.c: fix checkpatch
Message-Id: <1326039820-11147-8-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm70.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index c274ea2..0994cb0 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -57,7 +57,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	int status, val = 0;
 	u8 rxbuf[2];
-	s16 raw=0;
+	s16 raw = 0;
 	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
 	if (mutex_lock_interruptible(&p_lm70->lock))
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
