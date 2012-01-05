From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 13:41:54 +0000
Subject: [lm-sensors] [PATCH v2 2/2] lm80.c: reinitialize client if data is
Message-Id: <1325770914-23620-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if data->valid = 0 when asking for an update reinitialize
the client.
This is done for the case that the device got disconnected
as without reinitialisation it will not give any sensible
readings.

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---

Tested with actual system and unplugging and replugging the device

 drivers/hwmon/lm80.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 616f470..1d86912 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -583,6 +583,11 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
+    /* If the data is not valid it might be the device was temporarily
+       disconnected. In order to keep things running re-initialize the lm80 */
+	if (!data->valid)
+		lm80_init_client(client);
+
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
