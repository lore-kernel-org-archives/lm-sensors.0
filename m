From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 30 Mar 2010 22:56:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Increase update rate
Message-Id: <20100330225628.GE20635@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The adm1031 chip is capable of an 8 Hz update rate, configurable at runtime
with the fan filter register. Increase the update rate to get faster
temperature readings.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This may be a bit controversial. The ADM1031 chip may use more power at a
higher update rate. In my (embedded) application, this doesn't matter. The
faster update rate is more important.

Does anyone have thoughts on this? It is easy enough for me to carry
myself, but I'd much rather have it upstream.

Ira

 drivers/hwmon/adm1031.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 1644b92..c7195cc 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -36,6 +36,7 @@
 #define ADM1031_REG_FAN_DIV(nr)		(0x20 + (nr))
 #define ADM1031_REG_PWM			(0x22)
 #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
+#define ADM1031_REG_FAN_FILTER		(0x23)
 
 #define ADM1031_REG_TEMP_OFFSET(nr)	(0x0d + (nr))
 #define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
@@ -919,6 +920,9 @@ static void adm1031_init_client(struct i2c_client *client)
 				ADM1031_CONF1_MONITOR_ENABLE);
 	}
 
+	/* Increase the ADC sampling rate -- temperatures update at 8 Hz */
+	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
+	adm1031_write_value(client, ADM1031_REG_FAN_FILTER, read_val | 0x1C);
 }
 
 static struct adm1031_data *adm1031_update_device(struct device *dev)
@@ -929,7 +933,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	if (time_after(jiffies, data->last_updated + HZ / 8)
 	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting adm1031 update\n");
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
