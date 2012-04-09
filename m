From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 09 Apr 2012 17:53:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Fix build warning
Message-Id: <1333993980-23324-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following build warning is seen in some configurations.

drivers/hwmon/ads1015.c: In function 'show_in':
drivers/hwmon/ads1015.c:129: warning: 'in' may be used uninitialized in this function

Fix by separating the register read function from the code converting the result
into mV.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Dirk Eibach <eibach@gdsys.de>
---
 drivers/hwmon/ads1015.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 7765e4f..1958f03 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -59,14 +59,11 @@ struct ads1015_data {
 	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
 };
 
-static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
-			      int *value)
+static int ads1015_read_adc(struct i2c_client *client, unsigned int channel)
 {
 	u16 config;
-	s16 conversion;
 	struct ads1015_data *data = i2c_get_clientdata(client);
 	unsigned int pga = data->channel_data[channel].pga;
-	int fullscale;
 	unsigned int data_rate = data->channel_data[channel].data_rate;
 	unsigned int conversion_time_ms;
 	int res;
@@ -78,7 +75,6 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
 	if (res < 0)
 		goto err_unlock;
 	config = res;
-	fullscale = fullscale_table[pga];
 	conversion_time_ms = DIV_ROUND_UP(1000, data_rate_table[data_rate]);
 
 	/* setup and start single conversion */
@@ -105,33 +101,36 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
 	}
 
 	res = i2c_smbus_read_word_swapped(client, ADS1015_CONVERSION);
-	if (res < 0)
-		goto err_unlock;
-	conversion = res;
-
-	mutex_unlock(&data->update_lock);
-
-	*value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
-
-	return 0;
 
 err_unlock:
 	mutex_unlock(&data->update_lock);
 	return res;
 }
 
+static int ads1015_reg_to_mv(struct i2c_client *client, unsigned int channel,
+			     s16 reg)
+{
+	struct ads1015_data *data = i2c_get_clientdata(client);
+	unsigned int pga = data->channel_data[channel].pga;
+	int fullscale = fullscale_table[pga];
+
+	return DIV_ROUND_CLOSEST(reg * fullscale, 0x7ff0);
+}
+
 /* sysfs callback function */
 static ssize_t show_in(struct device *dev, struct device_attribute *da,
 	char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
-	int in;
 	int res;
+	int index = attr->index;
 
-	res = ads1015_read_value(client, attr->index, &in);
+	res = ads1015_read_adc(client, index);
+	if (res < 0)
+		return res;
 
-	return (res < 0) ? res : sprintf(buf, "%d\n", in);
+	return sprintf(buf, "%d\n", ads1015_reg_to_mv(client, index, res));
 }
 
 static const struct sensor_device_attribute ads1015_in[] = {
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
