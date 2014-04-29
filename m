From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:13:50 +0000
Subject: [lm-sensors] [PATCH 8/8] hwmon: (vt1211) remove unnecessary OOM messages
Message-Id: <002101cf6382$f42ef490$dc8cddb0$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/vt1211.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 6b2f1a4..344b22e 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1152,10 +1152,8 @@ static int vt1211_probe(struct platform_device *pdev)
 	int i, err;
 
 	data = devm_kzalloc(dev, sizeof(struct vt1211_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(dev, "Out of memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(dev, res->start, resource_size(res),
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
