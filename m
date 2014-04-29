From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:11:55 +0000
Subject: [lm-sensors] [PATCH 6/8] hwmon: (pc87427) remove unnecessary OOM messages
Message-Id: <001f01cf6382$af7c7020$0e755060$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/pc87427.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index d847e0a..9e4684e 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -1081,10 +1081,8 @@ static int pc87427_probe(struct platform_device *pdev)
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct pc87427_data),
 			    GFP_KERNEL);
-	if (!data) {
-		pr_err("Out of memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->address[0] = sio_data->address[0];
 	data->address[1] = sio_data->address[1];
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
