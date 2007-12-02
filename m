From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 22:32:42 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (adm1031) Fix register overwrite in
Message-Id: <20071202233242.4341923f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't rely on the register cache when setting a new fan clock divider.
For one thing, the cache might not have been initialized at all if the
driver has just been loaded. For another, the cached values may be old
and you never know what can happen in the driver's back.

Also invalidate the cache instead of trying to adjust the measured fan
speed: the whole point of changing the clock divider is to get a better
reading.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1031.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1031.c	2007-12-01 10:18:09.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1031.c	2007-12-02 22:22:18.000000000 +0100
@@ -542,18 +542,26 @@ set_fan_div(struct device *dev, const ch
 		return -EINVAL;
 	
 	mutex_lock(&data->update_lock);
+	/* Get fresh readings */
+	data->fan_div[nr] = adm1031_read_value(client,
+					       ADM1031_REG_FAN_DIV(nr));
+	data->fan_min[nr] = adm1031_read_value(client,
+					       ADM1031_REG_FAN_MIN(nr));
+
+	/* Write the new clock divider and fan min */
 	old_div = FAN_DIV_FROM_REG(data->fan_div[nr]);
 	data->fan_div[nr] = (tmp & 0xC0) | (0x3f & data->fan_div[nr]);
 	new_min = data->fan_min[nr] * old_div / 
 		FAN_DIV_FROM_REG(data->fan_div[nr]);
 	data->fan_min[nr] = new_min > 0xff ? 0xff : new_min;
-	data->fan[nr] = data->fan[nr] * old_div / 
-		FAN_DIV_FROM_REG(data->fan_div[nr]);
 
 	adm1031_write_value(client, ADM1031_REG_FAN_DIV(nr), 
 			    data->fan_div[nr]);
 	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr), 
 			    data->fan_min[nr]);
+
+	/* Invalidate the cache: fan speed is no longer valid */
+	data->valid = 0;
 	mutex_unlock(&data->update_lock);
 	return count;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
