From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:44 +0000
Subject: [lm-sensors] [PATCH 50/82] hwmon: (max6650) Fix multi-line comments
Message-Id: <1327017376-20466-51-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Hans J Koch <hjk@hansjkoch.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6650.c |   51 +++++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 159ce02..0998094 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -159,13 +159,13 @@ static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
 	int rpm;
 
 	/*
-	* Calculation details:
-	*
-	* Each tachometer counts over an interval given by the "count"
-	* register (0.25, 0.5, 1 or 2 seconds). This module assumes
-	* that the fans produce two pulses per revolution (this seems
-	* to be the most common).
-	*/
+	 * Calculation details:
+	 *
+	 * Each tachometer counts over an interval given by the "count"
+	 * register (0.25, 0.5, 1 or 2 seconds). This module assumes
+	 * that the fans produce two pulses per revolution (this seems
+	 * to be the most common).
+	 */
 
 	rpm = ((data->tach[attr->index] * 120) / DIV_FROM_REG(data->count));
 	return sprintf(buf, "%d\n", rpm);
@@ -219,12 +219,12 @@ static ssize_t get_target(struct device *dev, struct device_attribute *devattr,
 	int kscale, ktach, rpm;
 
 	/*
-	* Use the datasheet equation:
-	*
-	*    FanSpeed = KSCALE x fCLK / [256 x (KTACH + 1)]
-	*
-	* then multiply by 60 to give rpm.
-	*/
+	 * Use the datasheet equation:
+	 *
+	 *    FanSpeed = KSCALE x fCLK / [256 x (KTACH + 1)]
+	 *
+	 * then multiply by 60 to give rpm.
+	 */
 
 	kscale = DIV_FROM_REG(data->config);
 	ktach = data->speed;
@@ -248,11 +248,11 @@ static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
 	rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
 
 	/*
-	* Divide the required speed by 60 to get from rpm to rps, then
-	* use the datasheet equation:
-	*
-	*     KTACH = [(fCLK x KSCALE) / (256 x FanSpeed)] - 1
-	*/
+	 * Divide the required speed by 60 to get from rpm to rps, then
+	 * use the datasheet equation:
+	 *
+	 *     KTACH = [(fCLK x KSCALE) / (256 x FanSpeed)] - 1
+	 */
 
 	mutex_lock(&data->update_lock);
 
@@ -286,8 +286,10 @@ static ssize_t get_pwm(struct device *dev, struct device_attribute *devattr,
 	int pwm;
 	struct max6650_data *data = max6650_update_device(dev);
 
-	/* Useful range for dac is 0-180 for 12V fans and 0-76 for 5V fans.
-	   Lower DAC values mean higher speeds. */
+	/*
+	 * Useful range for dac is 0-180 for 12V fans and 0-76 for 5V fans.
+	 * Lower DAC values mean higher speeds.
+	 */
 	if (data->config & MAX6650_CFG_V12)
 		pwm = 255 - (255 * (int)data->dac)/180;
 	else
@@ -657,7 +659,8 @@ static int max6650_init_client(struct i2c_client *client)
 	dev_info(&client->dev, "Prescaler is set to %d.\n",
 		 1 << (config & MAX6650_CFG_PRESCALER_MASK));
 
-	/* If mode is set to "full off", we change it to "open loop" and
+	/*
+	 * If mode is set to "full off", we change it to "open loop" and
 	 * set DAC to 255, which has the same effect. We do this because
 	 * there's no "full off" mode defined in hwmon specifcations.
 	 */
@@ -711,9 +714,11 @@ static struct max6650_data *max6650_update_device(struct device *dev)
 							MAX6650_REG_COUNT);
 		data->dac = i2c_smbus_read_byte_data(client, MAX6650_REG_DAC);
 
-		/* Alarms are cleared on read in case the condition that
+		/*
+		 * Alarms are cleared on read in case the condition that
 		 * caused the alarm is removed. Keep the value latched here
-		 * for providing the register through different alarm files. */
+		 * for providing the register through different alarm files.
+		 */
 		data->alarm |= i2c_smbus_read_byte_data(client,
 							MAX6650_REG_ALARM);
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
