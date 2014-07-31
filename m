From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 01:43:19 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (amc6821) Fix possible race condition bug
Message-Id: <1406770999.16771.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ensure mutex lock protects the read-modify-write period to prevent possible
race condition bug.
In additional, update data->valid should also be protected by the mutex lock.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/amc6821.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 66b994a..12e851a 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -415,11 +415,13 @@ static ssize_t set_pwm1_enable(
 	if (config)
 		return config;
 
+	mutex_lock(&data->update_lock);
 	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
 	if (config < 0) {
 			dev_err(&client->dev,
 			"Error reading configuration register, aborting.\n");
-			return config;
+			count = config;
+			goto unlock;
 	}
 
 	switch (val) {
@@ -436,14 +438,15 @@ static ssize_t set_pwm1_enable(
 		config |= AMC6821_CONF1_FDRC1;
 		break;
 	default:
-		return -EINVAL;
+		count = -EINVAL;
+		goto unlock;
 	}
-	mutex_lock(&data->update_lock);
 	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF1, config)) {
 			dev_err(&client->dev,
 			"Configuration register write error, aborting.\n");
 			count = -EIO;
 	}
+unlock:
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -542,8 +545,9 @@ static ssize_t set_temp_auto_point_temp(
 		return -EINVAL;
 	}
 
-	data->valid = 0;
 	mutex_lock(&data->update_lock);
+	data->valid = 0;
+
 	switch (ix) {
 	case 0:
 		ptemp[0] = clamp_val(val / 1000, 0,
@@ -699,13 +703,14 @@ static ssize_t set_fan1_div(
 	if (config)
 		return config;
 
+	mutex_lock(&data->update_lock);
 	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF4);
 	if (config < 0) {
 		dev_err(&client->dev,
 			"Error reading configuration register, aborting.\n");
-		return config;
+		count = config;
+		goto EXIT;
 	}
-	mutex_lock(&data->update_lock);
 	switch (val) {
 	case 2:
 		config &= ~AMC6821_CONF4_PSPR;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
