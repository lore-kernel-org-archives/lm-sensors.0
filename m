From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Fri, 01 May 2015 15:56:23 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: sht15: Constify platform_device_id
Message-Id: <1430495783-31969-2-git-send-email-k.kozlowski.k@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1430495783-31969-1-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495783-31969-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/hwmon/sht15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index d4f0935daaa1..497a7f822a12 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -1074,7 +1074,7 @@ static int sht15_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id sht15_device_ids[] = {
+static const struct platform_device_id sht15_device_ids[] = {
 	{ "sht10", sht10 },
 	{ "sht11", sht11 },
 	{ "sht15", sht15 },
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
