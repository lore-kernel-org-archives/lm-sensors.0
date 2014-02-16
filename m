From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:07:59 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (max1668) Fix writing the minimum temperature
Message-Id: <1392516481-16548-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When trying to set the minimum temperature, the driver was erroneously
writing the maximum temperature into the chip.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for -stable.

 drivers/hwmon/max1668.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index a762635..029b65e 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -243,7 +243,7 @@ static ssize_t set_temp_min(struct device *dev,
 	data->temp_min[index] = clamp_val(temp/1000, -128, 127);
 	if (i2c_smbus_write_byte_data(client,
 					MAX1668_REG_LIML_WR(index),
-					data->temp_max[index]))
+					data->temp_min[index]))
 		count = -EIO;
 	mutex_unlock(&data->update_lock);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
