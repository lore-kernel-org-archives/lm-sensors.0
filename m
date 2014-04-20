From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 18:41:19 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm77) Do not preserve hysteresis when updating critical temp limit
Message-Id: <1398019279-31757-3-git-send-email-linux@roeck-us.net>
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
 Documentation/hwmon/lm77 |    8 ++++++++
 drivers/hwmon/lm77.c     |    9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

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
index 20dfa6e..369399b 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -168,21 +168,14 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	struct lm77_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int nr = attr->index;
-	int err, oldhyst;
 	long val;
+	int err;
 
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
 
 	mutex_lock(&data->update_lock);
-	if (nr = t_crit) {
-		/* preserve hysteresis when setting T_crit */
-		oldhyst = data->temp[nr] - data->temp[t_hyst];
-		data->temp[t_hyst] = data->temp[nr] - oldhyst;
-		lm77_write_value(client, LM77_REG_TEMP_HYST,
-				 LM77_TEMP_TO_REG(data->temp[t_hyst]));
-	}
 	data->temp[nr] = val;
 	lm77_write_value(client, temp_regs[nr], LM77_TEMP_TO_REG(val));
 	mutex_unlock(&data->update_lock);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
