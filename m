From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 14:45:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1021) Fix cache problem when writing temperature limits
Message-Id: <1404398745.15193.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The module test script for the adm1021 driver exposes a cache problem
when writing temperature limits. temp_min and temp_max are expected
to be stored in milli-degrees C but are stored in degrees C.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1021.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 7f7635b..1fdcc3e 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -207,7 +207,7 @@ static ssize_t set_temp_max(struct device *dev,
 	struct adm1021_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long temp;
-	int err;
+	int reg_val, err;
 
 	err = kstrtol(buf, 10, &temp);
 	if (err)
@@ -215,10 +215,11 @@ static ssize_t set_temp_max(struct device *dev,
 	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[index] = clamp_val(temp, -128, 127);
+	reg_val = clamp_val(temp, -128, 127);
+	data->temp_max[index] = reg_val * 1000;
 	if (!read_only)
 		i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W(index),
-					  data->temp_max[index]);
+					  reg_val);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -232,7 +233,7 @@ static ssize_t set_temp_min(struct device *dev,
 	struct adm1021_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long temp;
-	int err;
+	int reg_val, err;
 
 	err = kstrtol(buf, 10, &temp);
 	if (err)
@@ -240,10 +241,11 @@ static ssize_t set_temp_min(struct device *dev,
 	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[index] = clamp_val(temp, -128, 127);
+	reg_val = clamp_val(temp, -128, 127);
+	data->temp_min[index] = reg_val * 1000;
 	if (!read_only)
 		i2c_smbus_write_byte_data(client, ADM1021_REG_THYST_W(index),
-					  data->temp_min[index]);
+					  reg_val);
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
