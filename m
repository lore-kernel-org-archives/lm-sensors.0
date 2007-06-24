From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:19:01 +0000
Subject: [lm-sensors] [PATCH 05/10] hwmon/w83627ehf: Fix timing issues
Message-Id: <20070624111901.5327aad5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* I have experimental evidence that the W83627EHG needs more than 1
second to refresh all the measured values. Increase the caching time to
1.5 second.
* When changing a fan clock divider, the corresponding fan speed
measurement register is no longer valid, until the next time the chip
will refresh it. One way to fix this is to pretend that the cache is
still valid for one more period (1.5 second.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-24 10:07:49.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-24 10:25:18.000000000 +0200
@@ -421,7 +421,7 @@ static struct w83627ehf_data *w83627ehf_
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ)
+	if (time_after(jiffies, data->last_updated + HZ + HZ/2)
 	 || !data->valid) {
 		/* Fan clock dividers */
 		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
@@ -727,6 +727,8 @@ store_fan_min(struct device *dev, struct
 			div_from_reg(new_div));
 		data->fan_div[nr] = new_div;
 		w83627ehf_write_fan_div(data, nr);
+		/* Give the chip time to sample a new speed value */
+		data->last_updated = jiffies;
 	}
 	w83627ehf_write_value(data, W83627EHF_REG_FAN_MIN[nr],
 			      data->fan_min[nr]);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
