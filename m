From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:09 +0000
Subject: [lm-sensors] [PATCH 30/79] hwmon: (max1111) Fix multi-line comments
Message-Id: <1327373398-997-31-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1111.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index e5206ae..362a40e 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -106,7 +106,8 @@ static ssize_t show_adc(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	/* assume the reference voltage to be 2.048V, with an 8-bit sample,
+	/*
+	 * assume the reference voltage to be 2.048V, with an 8-bit sample,
 	 * the LSB weight is 8mV
 	 */
 	return sprintf(buf, "%d\n", ret * 8);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
