From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:41 +0000
Subject: [lm-sensors] [PATCH 47/82] hwmon: (max1111) Fix multi-line comments
Message-Id: <1327017376-20466-48-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1111.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 482ca90..a110a38 100644
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
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
