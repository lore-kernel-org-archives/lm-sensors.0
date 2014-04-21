From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 01:28:10 +0000
Subject: [lm-sensors] [PATCH v2 1/3] hwmon: (lm77) Do not preserve hysteresis when updating critical temp lim
Message-Id: <1398043692-10522-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Updating the hysteresis value when updating the critical temperature limit
was following the rule of 'least surprise'. However, it had the undesirable
side effect of changing the hysteresis for all other attributes, which
defeats the purpose of least surprise. In addition, it could result in
invalid hysteresis values if the resulting hysteresis was too large. In such
cases the resulting hysteresis ended up changed anyway, which again defeats
the purpose. So drop that code and document the new behavior.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Move this patch ahead of subsequent patches to simplify those

 Documentation/hwmon/lm77 |    8 ++++++++
 drivers/hwmon/lm77.c     |    5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/lm77 b/Documentation/hwmon/lm77
index 57c3a46..7ff66c4 100644
--- a/Documentation/hwmon/lm77
+++ b/Documentation/hwmon/lm77
@@ -20,3 +20,11 @@ and lower limit values.
 
 Limits can be set through the Overtemperature Shutdown register and
 Hysteresis register.
+
+The hysteresis value is common for all attributes. It can be set with
+temp1_crit_hyst. Changing it will affect the hysteresis for all other
+attributes as well. Note that when changing temp1_crit, the hysteresis
+temperature offset will not change. For example, let's assume the old
+critical limit is 80 degrees C, and the hysteresis is 75 degrees C.
+If the critical limit is changed to 90 degrees C, the hysteresis will
+automatically change to 85 degrees C.
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 4cd8a513..cf8f763 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -222,7 +222,6 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	int oldcrithyst;
 	unsigned long val;
 	int err;
 
@@ -231,13 +230,9 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	oldcrithyst = data->temp_crit - data->temp_hyst;
 	data->temp_crit = val;
-	data->temp_hyst = data->temp_crit - oldcrithyst;
 	lm77_write_value(client, LM77_REG_TEMP_CRIT,
 			 LM77_TEMP_TO_REG(data->temp_crit));
-	lm77_write_value(client, LM77_REG_TEMP_HYST,
-			 LM77_TEMP_TO_REG(data->temp_hyst));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
