From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:26 +0000
Subject: [lm-sensors] [PATCH 03/17] drivers/hwmon/sht15.c: fix checkpatch
Message-Id: <1326039820-11147-3-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/sht15.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index fe4104c..baa5fdc 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -806,7 +806,7 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 		 */
 		atomic_set(&data->interrupt_handled, 0);
 		enable_irq(gpio_to_irq(data->pdata->gpio_data));
-		/* If still not occurred or another handler has been scheduled */
+		/* If still not occurred or another handler was scheduled */
 		if (gpio_get_value(data->pdata->gpio_data)
 		    || atomic_read(&data->interrupt_handled))
 			return;
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
