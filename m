From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 02 Sep 2009 18:38:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) use programmed update rate
Message-Id: <20090902183818.GG2328@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The lm90 driver programs the sensor chip to update its readings at 2 Hz
(500 ms between readings). However, the driver only does reads from the
chip at intervals of 2 * HZ (2000 ms between readings). Change the driver
update rate to the programmed update rate.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

I think this was probably just a simple mistake made by the original
author of the driver, with the intention being that the driver update
the cached values every 500 ms. The change is confirmed against the
adm1032 datasheet. The chip is updating every 500 ms.

 drivers/hwmon/lm90.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 1aff757..f3324c5 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -960,7 +960,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ / 2) || !data->valid) {
 		u8 h, l;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
