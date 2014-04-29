From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:06:59 +0000
Subject: [lm-sensors] [PATCH 1/8] hwmon: (f71805f) remove unnecessary OOM messages
Message-Id: <001a01cf6381$fec10f70$fc432e50$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/f71805f.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 32f5132..9e57b77 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1387,10 +1387,8 @@ static int f71805f_probe(struct platform_device *pdev)
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct f71805f_data),
 			    GFP_KERNEL);
-	if (!data) {
-		pr_err("Out of memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start + ADDR_REG_OFFSET, 2,
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
