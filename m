From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Apr 2014 22:28:09 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (max1619) Fix critical alarm display
Message-Id: <1397946493-4455-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The overtemperature status bit, which is used to display critical alarm status,
matches the output of the OVERT signal 1:1. If that signal is active-low, the
bit will read 1 if there is no alarm. It is therefore necessary to reverse
the bit in this case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for -stable or not worth it ?

 drivers/hwmon/max1619.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 4c23afe..0927902 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -325,6 +325,7 @@ static struct max1619_data *max1619_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max1619_data *data = i2c_get_clientdata(client);
+	int config;
 
 	mutex_lock(&data->update_lock);
 
@@ -344,6 +345,10 @@ static struct max1619_data *max1619_update_device(struct device *dev)
 					MAX1619_REG_R_TCRIT_HYST);
 		data->alarms = i2c_smbus_read_byte_data(client,
 					MAX1619_REG_R_STATUS);
+		/* If OVERT polarity is low, reverse alarm bit */
+		config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
+		if (!(config & 0x20))
+			data->alarms ^= 0x02;
 
 		data->last_updated = jiffies;
 		data->valid = 1;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
