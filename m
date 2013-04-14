From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 14 Apr 2013 17:56:11 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (tmp401) Reset valid flag when resetting temperature history
Message-Id: <1365962173-28311-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cached data is no longer valid after resetting the temperature history.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index a92746f..2f581a5 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -353,6 +353,8 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
 static ssize_t reset_temp_history(struct device *dev,
 	struct device_attribute	*devattr, const char *buf, size_t count)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp401_data *data = i2c_get_clientdata(client);
 	long val;
 
 	if (kstrtol(buf, 10, &val))
@@ -364,8 +366,10 @@ static ssize_t reset_temp_history(struct device *dev,
 			val);
 		return -EINVAL;
 	}
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-				  TMP401_TEMP_MSB_WRITE[5][0], val);
+	mutex_lock(&data->update_lock);
+	i2c_smbus_write_byte_data(client, TMP401_TEMP_MSB_WRITE[5][0], val);
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
