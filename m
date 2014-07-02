From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Jul 2014 00:18:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1029) Update fan_div cache when writing fan divisor attribute
Message-Id: <1404260284-6849-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When writing a new value into the fan1_div or fan2_div attribute,
the written value was not copied into the cache. This could result
in reading an old attribute value for up to two seconds after updating
the fan divisor, since values are cached for that long by the driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1029.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 78339e8..45b2523 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -235,6 +235,7 @@ static ssize_t set_fan_div(struct device *dev,
 	/* Write value */
 	i2c_smbus_write_byte_data(client,
 				  ADM1029_REG_FAN_DIV[attr->index], reg);
+	data->fan_div[attr->index] = reg;
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
