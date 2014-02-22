From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Feb 2014 17:30:11 +0000
Subject: [lm-sensors] [PATCH v2 3/4] hwmon: (lm95245) Drop useless debug message
Message-Id: <1393090212-24900-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It doesn't provide value to get a log message whenever the driver
updates its cached data, so drop the message.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Additional patch

 drivers/hwmon/lm95245.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index b62a1f4..310e145 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -149,7 +149,6 @@ static struct lm95245_data *lm95245_update_device(struct device *dev)
 		+ msecs_to_jiffies(data->interval)) || !data->valid) {
 		int i;
 
-		dev_dbg(dev, "Updating lm95245 data.\n");
 		for (i = 0; i < ARRAY_SIZE(lm95245_reg_address); i++)
 			data->regs[i]
 			  = i2c_smbus_read_byte_data(client,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
