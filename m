From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:08:00 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (max1668) Don't hide return value from i2c_smbus_write_byte_data
Message-Id: <1392516481-16548-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c_smbus_write_byte_data returns a valid error code.
Return it to the user instead of replacing it with -EIO.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1668.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index 029b65e..bbbe340 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -216,10 +216,11 @@ static ssize_t set_temp_max(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[index] = clamp_val(temp/1000, -128, 127);
-	if (i2c_smbus_write_byte_data(client,
+	ret = i2c_smbus_write_byte_data(client,
 					MAX1668_REG_LIMH_WR(index),
-					data->temp_max[index]))
-		count = -EIO;
+					data->temp_max[index]);
+	if (ret < 0)
+		count = ret;
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -241,10 +242,11 @@ static ssize_t set_temp_min(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[index] = clamp_val(temp/1000, -128, 127);
-	if (i2c_smbus_write_byte_data(client,
+	ret = i2c_smbus_write_byte_data(client,
 					MAX1668_REG_LIML_WR(index),
-					data->temp_min[index]))
-		count = -EIO;
+					data->temp_min[index]);
+	if (ret < 0)
+		count = ret;
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
