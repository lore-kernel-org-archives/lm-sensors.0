From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 26 Jan 2012 20:59:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (SHT15) fix bad error code
Message-Id: <1327611540-21023-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org

When no platform data was supplied, returned error code was 0.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hwmon/sht15.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index fe4104c..5357925 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -883,7 +883,7 @@ static int sht15_invalidate_voltage(struct notifier_block *nb,
 
 static int __devinit sht15_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret;
 	struct sht15_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
 	u8 status = 0;
 
@@ -901,6 +901,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	init_waitqueue_head(&data->wait_queue);
 
 	if (pdev->dev.platform_data = NULL) {
+		ret = -EINVAL;
 		dev_err(&pdev->dev, "no platform data supplied\n");
 		goto err_free_data;
 	}
-- 
1.7.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
