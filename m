From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:09:19 +0000
Subject: [lm-sensors] [PATCH 3/8] hwmon: (lm93) remove unnecessary OOM messages
Message-Id: <001c01cf6382$5290bfb0$f7b23f10$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/lm93.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index adf2316..6c2df57 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -2747,10 +2747,8 @@ static int lm93_probe(struct i2c_client *client,
 	}
 
 	data = devm_kzalloc(&client->dev, sizeof(struct lm93_data), GFP_KERNEL);
-	if (!data) {
-		dev_dbg(&client->dev, "out of memory!\n");
+	if (!data)
 		return -ENOMEM;
-	}
 	i2c_set_clientdata(client, data);
 
 	/* housekeeping */
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
