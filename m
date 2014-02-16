From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:16:11 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (ltc4245) Associate log messages with hwmon device
Message-Id: <1392516972-27576-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since sysfs attributes are not attached to the hwmon device,
it makes sense to associate log messages with the hwmon device
as well.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4245.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 2c6da5d..0a3eddb 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -95,7 +95,7 @@ static void ltc4245_update_gpios(struct device *dev)
 	 * readings as stale by setting them to -EAGAIN
 	 */
 	if (time_after(jiffies, data->last_updated + 5 * HZ)) {
-		dev_dbg(&client->dev, "Marking GPIOs invalid\n");
+		dev_dbg(dev, "Marking GPIOs invalid\n");
 		for (i = 0; i < ARRAY_SIZE(data->gpios); i++)
 			data->gpios[i] = -EAGAIN;
 	}
@@ -141,7 +141,7 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 
-		dev_dbg(&client->dev, "Starting ltc4245 update\n");
+		dev_dbg(dev, "Starting ltc4245 update\n");
 
 		/* Read control registers -- 0x00 to 0x07 */
 		for (i = 0; i < ARRAY_SIZE(data->cregs); i++) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
