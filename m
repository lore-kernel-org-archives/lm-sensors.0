From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 12 Jan 2015 13:47:21 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (ina2xx) remove an unnecessary dev_get_drvdata() result check
Message-Id: <1421070442-9635-2-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421070442-9635-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1421070442-9635-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index a16d6a2..ae110c5 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -370,9 +370,6 @@ static ssize_t ina226_set_interval(struct device *dev,
 	unsigned long val;
 	int status;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
 	status = kstrtoul(buf, 10, &val);
 	if (status < 0)
 		return status;
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
