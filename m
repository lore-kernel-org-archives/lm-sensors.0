From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 12:03:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Invalidate cache on temperature
Message-Id: <20100409140338.72296aab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When any temperature sensor type is changed, the corresponding
temperature value needs to be updated. The register caching mechanism
may delay this update, so we want to invalidate the cache to force an
immediate update.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.34-rc3.orig/drivers/hwmon/it87.c	2010-04-09 13:37:12.000000000 +0200
+++ linux-2.6.34-rc3/drivers/hwmon/it87.c	2010-04-09 13:45:08.000000000 +0200
@@ -563,6 +563,7 @@ static ssize_t set_sensor(struct device
 	mutex_lock(&data->update_lock);
 	data->sensor = reg;
 	it87_write_value(data, IT87_REG_TEMP_ENABLE, data->sensor);
+	data->valid = 0;	/* Force cache refresh */
 	mutex_unlock(&data->update_lock);
 	return count;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
