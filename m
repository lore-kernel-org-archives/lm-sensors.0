From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Fri, 01 May 2015 15:56:22 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: max197: Constify platform_device_id
Message-Id: <1430495783-31969-1-git-send-email-k.kozlowski.k@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/hwmon/max197.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index cb0dcfda958c..07628569547a 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -324,7 +324,7 @@ static int max197_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id max197_device_ids[] = {
+static const struct platform_device_id max197_device_ids[] = {
 	{ "max197", max197 },
 	{ "max199", max199 },
 	{ }
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
