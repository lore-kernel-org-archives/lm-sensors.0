From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 22 Apr 2014 11:26:41 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (lm77) Do not preserve hysteresis when updating critical temp limit
Message-Id: <20140422112641.GA15567@roeck-us.net>
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
v3: Replace documentation with text suggested by Jean
    Drop obsolete comment
v2: Move this patch ahead of subsequent patches to simplify those

 Documentation/hwmon/lm77 |   20 ++++++++++++++++++--
 drivers/hwmon/lm77.c     |    6 ------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/lm77 b/Documentation/hwmon/lm77
index 57c3a46..bfc915f 100644
--- a/Documentation/hwmon/lm77
+++ b/Documentation/hwmon/lm77
@@ -18,5 +18,21 @@ sensor incorporates a band-gap type temperature sensor,
 10-bit ADC, and a digital comparator with user-programmable upper
 and lower limit values.
 
-Limits can be set through the Overtemperature Shutdown register and
-Hysteresis register.
+The LM77 implements 3 limits: low (temp1_min), high (temp1_max) and
+critical (temp1_crit.) It also implements an hysteresis mechanism which
+applies to all 3 limits. The relative difference is stored in a single
+register on the chip, which means that the relative difference between
+the limit and its hysteresis is always the same for all 3 limits.
+
+This implementation detail implies the following:
+* When setting a limit, its hysteresis will automatically follow, the
+  difference staying unchanged. For example, if the old critical limit
+  was 80 degrees C, and the hysteresis was 75 degrees C, and you change
+  the critical limit to 90 degrees C, then the hysteresis will
+  automatically change to 85 degrees C.
+* All 3 hysteresis can't be set independently. We decided to make
+  temp1_crit_hyst writable, while temp1_min_hyst and temp1_max_hyst are
+  read-only. Setting temp1_crit_hyst writes the difference between
+  temp1_crit_hyst and temp1_crit into the chip, and the same relative
+  hysteresis applies automatically to the low and high limits.
+* The limits should be set before the hysteresis.
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 4cd8a513..85e5b33 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -216,13 +216,11 @@ static ssize_t set_temp_crit_hyst(struct device *dev,
 	return count;
 }
 
-/* preserve hysteresis when setting T_crit */
 static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
-	int oldcrithyst;
 	unsigned long val;
 	int err;
 
@@ -231,13 +229,9 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
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
