From: "Justin P. Mattock" <justinmattock@gmail.com>
Date: Sun, 27 Feb 2011 04:34:03 +0000
Subject: [lm-sensors] [PATCH 10/17]drivers:hwmon:sht15.c Remove one to many
Message-Id: <1298781250-2718-11-git-send-email-justinmattock@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

The Patch below removes one to many "n's" in a word..

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: Jean Delvare <khali@linux-fr.org>
CC: Guenter Roeck <guenter.roeck@ericsson.com>
CC: lm-sensors@lm-sensors.org
---
 drivers/hwmon/sht15.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index a610e78..3ba7dd8 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -610,7 +610,7 @@ static int __devexit sht15_remove(struct platform_device *pdev)
 	struct sht15_data *data = platform_get_drvdata(pdev);
 
 	/* Make sure any reads from the device are done and
-	 * prevent new ones beginnning */
+	 * prevent new ones from beginning */
 	mutex_lock(&data->read_lock);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
