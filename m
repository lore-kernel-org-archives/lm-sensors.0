From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jan 2013 16:59:07 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: Replace SENSORS_LIMIT with clamp_val
Message-Id: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, George Joseph <george.joseph@fairview5.com>, Juerg Haefliger <juergh@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Roger Lucas <vt8231@hiddenengine.co.uk>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

SENSORS_LIMIT and the generic clamp_val have the same functionality,
and clamp_val is more efficient.

This patch reduces text size by 9052 bytes and bss size by 11624 bytes
for x86_64 builds.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7414.c           |    2 +-
 drivers/hwmon/adm1021.c          |    4 ++--
 drivers/hwmon/adm1026.c          |   16 ++++++-------
 drivers/hwmon/adm1031.c          |   12 +++++-----
 drivers/hwmon/adm9240.c          |    6 ++---
 drivers/hwmon/ads7828.c          |    6 ++---
 drivers/hwmon/adt7410.c          |   10 ++++----
 drivers/hwmon/adt7462.c          |   20 ++++++++--------
 drivers/hwmon/adt7470.c          |   20 ++++++++--------
 drivers/hwmon/adt7475.c          |   18 +++++++-------
 drivers/hwmon/amc6821.c          |   32 ++++++++++---------------
 drivers/hwmon/asb100.c           |   10 ++++----
 drivers/hwmon/asc7621.c          |   26 ++++++++++-----------
 drivers/hwmon/dme1737.c          |   15 ++++++------
 drivers/hwmon/emc2103.c          |    2 +-
 drivers/hwmon/emc6w201.c         |    6 ++---
 drivers/hwmon/f71882fg.c         |   25 ++++++++++----------
 drivers/hwmon/f75375s.c          |   12 +++++-----
 drivers/hwmon/fschmd.c           |    4 ++--
 drivers/hwmon/g760a.c            |    2 +-
 drivers/hwmon/gl518sm.c          |   10 ++++----
 drivers/hwmon/gl520sm.c          |    9 ++++---
 drivers/hwmon/it87.c             |   13 +++++------
 drivers/hwmon/jc42.c             |    6 ++---
 drivers/hwmon/lm63.c             |    8 +++----
 drivers/hwmon/lm73.c             |    4 ++--
 drivers/hwmon/lm75.h             |    2 +-
 drivers/hwmon/lm77.c             |    2 +-
 drivers/hwmon/lm78.c             |    6 ++---
 drivers/hwmon/lm80.c             |    8 +++----
 drivers/hwmon/lm85.c             |   10 ++++----
 drivers/hwmon/lm90.c             |    2 +-
 drivers/hwmon/lm93.c             |   48 +++++++++++++++++++-------------------
 drivers/hwmon/lm95245.c          |    4 ++--
 drivers/hwmon/max16065.c         |    2 +-
 drivers/hwmon/max1668.c          |    4 ++--
 drivers/hwmon/max6639.c          |    4 ++--
 drivers/hwmon/max6642.c          |    2 +-
 drivers/hwmon/max6650.c          |    4 ++--
 drivers/hwmon/pmbus/pmbus_core.c |    2 +-
 drivers/hwmon/sis5595.c          |    6 ++---
 drivers/hwmon/smsc47m1.c         |    2 +-
 drivers/hwmon/smsc47m192.c       |    4 ++--
 drivers/hwmon/thmc50.c           |    6 ++---
 drivers/hwmon/tmp102.c           |    2 +-
 drivers/hwmon/tmp401.c           |   14 +++++------
 drivers/hwmon/via686a.c          |   17 ++++++--------
 drivers/hwmon/vt1211.c           |   10 ++++----
 drivers/hwmon/vt8231.c           |   22 ++++++++---------
 drivers/hwmon/w83627ehf.c        |   17 +++++++-------
 drivers/hwmon/w83627hf.c         |   23 ++++++++----------
 drivers/hwmon/w83781d.c          |   17 +++++++-------
 drivers/hwmon/w83791d.c          |   10 ++++----
 drivers/hwmon/w83792d.c          |   25 ++++++++++----------
 drivers/hwmon/w83793.c           |   18 +++++++-------
 drivers/hwmon/w83795.c           |   28 +++++++++++-----------
 drivers/hwmon/w83l786ng.c        |   17 +++++++-------
 57 files changed, 307 insertions(+), 329 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index f3a5d47..5d501ad 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -137,7 +137,7 @@ static ssize_t set_max_min(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	temp = SENSORS_LIMIT(temp, -40000, 85000);
+	temp = clamp_val(temp, -40000, 85000);
 	temp = (temp + (temp < 0 ? -500 : 500)) / 1000;
 
 	mutex_lock(&data->lock);
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index fd1d1b1..71bcba8a 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -193,7 +193,7 @@ static ssize_t set_temp_max(struct device *dev,
 	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);
+	data->temp_max[index] = clamp_val(temp, -128, 127);
 	if (!read_only)
 		i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W(index),
 					  data->temp_max[index]);
@@ -218,7 +218,7 @@ static ssize_t set_temp_min(struct device *dev,
 	temp /= 1000;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[index] = SENSORS_LIMIT(temp, -128, 127);
+	data->temp_min[index] = clamp_val(temp, -128, 127);
 	if (!read_only)
 		i2c_smbus_write_byte_data(client, ADM1021_REG_THYST_W(index),
 					  data->temp_min[index]);
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 0f068e7..ea09046 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -197,7 +197,7 @@ static int adm1026_scaling[] = { /* .001 Volts */
 	};
 #define NEG12_OFFSET  16000
 #define SCALE(val, from, to) (((val)*(to) + ((from)/2))/(from))
-#define INS_TO_REG(n, val)  (SENSORS_LIMIT(SCALE(val, adm1026_scaling[n], 192),\
+#define INS_TO_REG(n, val)  (clamp_val(SCALE(val, adm1026_scaling[n], 192),\
 	0, 255))
 #define INS_FROM_REG(n, val) (SCALE(val, 192, adm1026_scaling[n]))
 
@@ -207,7 +207,7 @@ static int adm1026_scaling[] = { /* .001 Volts */
  *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) = 1350000
  */
 #define FAN_TO_REG(val, div)  ((val) <= 0 ? 0xff : \
-				SENSORS_LIMIT(1350000 / ((val) * (div)), \
+				clamp_val(1350000 / ((val) * (div)), \
 					      1, 254))
 #define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
 				1350000 / ((val) * (div)))
@@ -215,14 +215,14 @@ static int adm1026_scaling[] = { /* .001 Volts */
 #define DIV_TO_REG(val) ((val) >= 8 ? 3 : (val) >= 4 ? 2 : (val) >= 2 ? 1 : 0)
 
 /* Temperature is reported in 1 degC increments */
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500)) \
+#define TEMP_TO_REG(val) (clamp_val(((val) + ((val) < 0 ? -500 : 500)) \
 					/ 1000, -127, 127))
 #define TEMP_FROM_REG(val) ((val) * 1000)
-#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500)) \
+#define OFFSET_TO_REG(val) (clamp_val(((val) + ((val) < 0 ? -500 : 500)) \
 					  / 1000, -127, 127))
 #define OFFSET_FROM_REG(val) ((val) * 1000)
 
-#define PWM_TO_REG(val) (SENSORS_LIMIT(val, 0, 255))
+#define PWM_TO_REG(val) (clamp_val(val, 0, 255))
 #define PWM_FROM_REG(val) (val)
 
 #define PWM_MIN_TO_REG(val) ((val) & 0xf0)
@@ -233,7 +233,7 @@ static int adm1026_scaling[] = { /* .001 Volts */
  *   indicates that the DAC could be used to drive the fans, but in our
  *   example board (Arima HDAMA) it isn't connected to the fans at all.
  */
-#define DAC_TO_REG(val) (SENSORS_LIMIT(((((val) * 255) + 500) / 2500), 0, 255))
+#define DAC_TO_REG(val) (clamp_val(((((val) * 255) + 500) / 2500), 0, 255))
 #define DAC_FROM_REG(val) (((val) * 2500) / 255)
 
 /*
@@ -933,7 +933,7 @@ static void fixup_fan_min(struct device *dev, int fan, int old_div)
 		return;
 
 	new_min = data->fan_min[fan] * old_div / new_div;
-	new_min = SENSORS_LIMIT(new_min, 1, 254);
+	new_min = clamp_val(new_min, 1, 254);
 	data->fan_min[fan] = new_min;
 	adm1026_write_value(client, ADM1026_REG_FAN_MIN(fan), new_min);
 }
@@ -1527,7 +1527,7 @@ static ssize_t set_auto_pwm_min(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1.auto_pwm_min = SENSORS_LIMIT(val, 0, 255);
+	data->pwm1.auto_pwm_min = clamp_val(val, 0, 255);
 	if (data->pwm1.enable = 2) { /* apply immediately */
 		data->pwm1.pwm = PWM_TO_REG((data->pwm1.pwm & 0x0f) |
 			PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index c6a4631..253ea39 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -162,13 +162,13 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
 static int FAN_TO_REG(int reg, int div)
 {
 	int tmp;
-	tmp = FAN_FROM_REG(SENSORS_LIMIT(reg, 0, 65535), div);
+	tmp = FAN_FROM_REG(clamp_val(reg, 0, 65535), div);
 	return tmp > 255 ? 255 : tmp;
 }
 
 #define FAN_DIV_FROM_REG(reg)		(1<<(((reg)&0xc0)>>6))
 
-#define PWM_TO_REG(val)			(SENSORS_LIMIT((val), 0, 255) >> 4)
+#define PWM_TO_REG(val)			(clamp_val((val), 0, 255) >> 4)
 #define PWM_FROM_REG(val)		((val) << 4)
 
 #define FAN_CHAN_FROM_REG(reg)		(((reg) >> 5) & 7)
@@ -675,7 +675,7 @@ static ssize_t set_temp_offset(struct device *dev,
 	if (ret)
 		return ret;
 
-	val = SENSORS_LIMIT(val, -15000, 15000);
+	val = clamp_val(val, -15000, 15000);
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_OFFSET_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_OFFSET(nr),
@@ -696,7 +696,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MIN(nr),
@@ -717,7 +717,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MAX(nr),
@@ -738,7 +738,7 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = SENSORS_LIMIT(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
 	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_CRIT(nr),
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index dafa477..2416628 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -98,13 +98,13 @@ static inline unsigned int IN_FROM_REG(u8 reg, int n)
 
 static inline u8 IN_TO_REG(unsigned long val, int n)
 {
-	return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
+	return clamp_val(SCALE(val, 192, nom_mv[n]), 0, 255);
 }
 
 /* temperature range: -40..125, 127 disables temperature alarm */
 static inline s8 TEMP_TO_REG(long val)
 {
-	return SENSORS_LIMIT(SCALE(val, 1, 1000), -40, 127);
+	return clamp_val(SCALE(val, 1, 1000), -40, 127);
 }
 
 /* two fans, each with low fan speed limit */
@@ -122,7 +122,7 @@ static inline unsigned int FAN_FROM_REG(u8 reg, u8 div)
 /* analog out 0..1250mV */
 static inline u8 AOUT_TO_REG(unsigned long val)
 {
-	return SENSORS_LIMIT(SCALE(val, 255, 1250), 0, 255);
+	return clamp_val(SCALE(val, 255, 1250), 0, 255);
 }
 
 static inline unsigned int AOUT_FROM_REG(u8 reg)
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 409b5c1..ba962ac 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -163,9 +163,9 @@ static int ads7828_probe(struct i2c_client *client,
 
 	/* Bound Vref with min/max values if it was provided */
 	if (data->vref_mv)
-		data->vref_mv = SENSORS_LIMIT(data->vref_mv,
-					      ADS7828_EXT_VREF_MV_MIN,
-					      ADS7828_EXT_VREF_MV_MAX);
+		data->vref_mv = clamp_val(data->vref_mv,
+					  ADS7828_EXT_VREF_MV_MIN,
+					  ADS7828_EXT_VREF_MV_MAX);
 	else
 		data->vref_mv = ADS7828_INT_VREF_MV;
 
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 030c8d7..797c2b8 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -173,8 +173,8 @@ abort:
 
 static s16 ADT7410_TEMP_TO_REG(long temp)
 {
-	return DIV_ROUND_CLOSEST(SENSORS_LIMIT(temp, ADT7410_TEMP_MIN,
-					       ADT7410_TEMP_MAX) * 128, 1000);
+	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
+					   ADT7410_TEMP_MAX) * 128, 1000);
 }
 
 static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
@@ -269,9 +269,9 @@ static ssize_t adt7410_set_t_hyst(struct device *dev,
 		return ret;
 	/* convert absolute hysteresis value to a 4 bit delta value */
 	limit = ADT7410_REG_TO_TEMP(data, data->temp[1]);
-	hyst = SENSORS_LIMIT(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
-	data->hyst = SENSORS_LIMIT(DIV_ROUND_CLOSEST(limit - hyst, 1000),
-				   0, ADT7410_T_HYST_MASK);
+	hyst = clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
+	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000), 0,
+			       ADT7410_T_HYST_MASK);
 	ret = i2c_smbus_write_byte_data(client, ADT7410_T_HYST, data->hyst);
 	if (ret)
 		return ret;
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 98a7d81..69481d3 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -836,7 +836,7 @@ static ssize_t set_temp_min(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
@@ -874,7 +874,7 @@ static ssize_t set_temp_max(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
@@ -939,7 +939,7 @@ static ssize_t set_volt_max(struct device *dev,
 
 	temp *= 1000; /* convert mV to uV */
 	temp = DIV_ROUND_CLOSEST(temp, x);
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->volt_max[attr->index] = temp;
@@ -981,7 +981,7 @@ static ssize_t set_volt_min(struct device *dev,
 
 	temp *= 1000; /* convert mV to uV */
 	temp = DIV_ROUND_CLOSEST(temp, x);
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->volt_min[attr->index] = temp;
@@ -1071,7 +1071,7 @@ static ssize_t set_fan_min(struct device *dev,
 
 	temp = FAN_RPM_TO_PERIOD(temp);
 	temp >>= 8;
-	temp = SENSORS_LIMIT(temp, 1, 255);
+	temp = clamp_val(temp, 1, 255);
 
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] = temp;
@@ -1149,7 +1149,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] = temp;
@@ -1179,7 +1179,7 @@ static ssize_t set_pwm_max(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_max = temp;
@@ -1211,7 +1211,7 @@ static ssize_t set_pwm_min(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;
@@ -1246,7 +1246,7 @@ static ssize_t set_pwm_hyst(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = SENSORS_LIMIT(temp, 0, 15);
+	temp = clamp_val(temp, 0, 15);
 
 	/* package things up */
 	temp &= ADT7462_PWM_HYST_MASK;
@@ -1333,7 +1333,7 @@ static ssize_t set_pwm_tmin(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + 64;
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] = temp;
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 39ecb1a..b83bf4b 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -452,7 +452,7 @@ static ssize_t set_auto_update_interval(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 60000);
+	temp = clamp_val(temp, 0, 60000);
 
 	mutex_lock(&data->lock);
 	data->auto_update_interval = temp;
@@ -481,7 +481,7 @@ static ssize_t set_num_temp_sensors(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, -1, 10);
+	temp = clamp_val(temp, -1, 10);
 
 	mutex_lock(&data->lock);
 	data->num_temp_sensors = temp;
@@ -515,7 +515,7 @@ static ssize_t set_temp_min(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
@@ -549,7 +549,7 @@ static ssize_t set_temp_max(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
@@ -604,7 +604,7 @@ static ssize_t set_fan_max(struct device *dev,
 		return -EINVAL;
 
 	temp = FAN_RPM_TO_PERIOD(temp);
-	temp = SENSORS_LIMIT(temp, 1, 65534);
+	temp = clamp_val(temp, 1, 65534);
 
 	mutex_lock(&data->lock);
 	data->fan_max[attr->index] = temp;
@@ -641,7 +641,7 @@ static ssize_t set_fan_min(struct device *dev,
 		return -EINVAL;
 
 	temp = FAN_RPM_TO_PERIOD(temp);
-	temp = SENSORS_LIMIT(temp, 1, 65534);
+	temp = clamp_val(temp, 1, 65534);
 
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] = temp;
@@ -717,7 +717,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] = temp;
@@ -749,7 +749,7 @@ static ssize_t set_pwm_max(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
@@ -782,7 +782,7 @@ static ssize_t set_pwm_min(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;
@@ -826,7 +826,7 @@ static ssize_t set_pwm_tmin(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = SENSORS_LIMIT(temp, 0, 255);
+	temp = clamp_val(temp, 0, 255);
 
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] = temp;
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 989e54c..22d008b 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -201,10 +201,10 @@ static inline u16 temp2reg(struct adt7475_data *data, long val)
 	u16 ret;
 
 	if (!(data->config5 & CONFIG5_TWOSCOMP)) {
-		val = SENSORS_LIMIT(val, -64000, 191000);
+		val = clamp_val(val, -64000, 191000);
 		ret = (val + 64500) / 1000;
 	} else {
-		val = SENSORS_LIMIT(val, -128000, 127000);
+		val = clamp_val(val, -128000, 127000);
 		if (val < -500)
 			ret = (256500 + val) / 1000;
 		else
@@ -240,7 +240,7 @@ static inline u16 rpm2tach(unsigned long rpm)
 	if (rpm = 0)
 		return 0;
 
-	return SENSORS_LIMIT((90000 * 60) / rpm, 1, 0xFFFF);
+	return clamp_val((90000 * 60) / rpm, 1, 0xFFFF);
 }
 
 /* Scaling factors for voltage inputs, taken from the ADT7490 datasheet */
@@ -271,7 +271,7 @@ static inline u16 volt2reg(int channel, long volt, u8 bypass_attn)
 		reg = (volt * 1024) / 2250;
 	else
 		reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
-	return SENSORS_LIMIT(reg, 0, 1023) & (0xff << 2);
+	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
 
 static u16 adt7475_read_word(struct i2c_client *client, int reg)
@@ -451,10 +451,10 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	switch (sattr->nr) {
 	case OFFSET:
 		if (data->config5 & CONFIG5_TEMPOFFSET) {
-			val = SENSORS_LIMIT(val, -63000, 127000);
+			val = clamp_val(val, -63000, 127000);
 			out = data->temp[OFFSET][sattr->index] = val / 1000;
 		} else {
-			val = SENSORS_LIMIT(val, -63000, 64000);
+			val = clamp_val(val, -63000, 64000);
 			out = data->temp[OFFSET][sattr->index] = val / 500;
 		}
 		break;
@@ -471,7 +471,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 		adt7475_read_hystersis(client);
 
 		temp = reg2temp(data, data->temp[THERM][sattr->index]);
-		val = SENSORS_LIMIT(val, temp - 15000, temp);
+		val = clamp_val(val, temp - 15000, temp);
 		val = (temp - val) / 1000;
 
 		if (sattr->index != 1) {
@@ -577,7 +577,7 @@ static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
 	 * to figure the range
 	 */
 	temp = reg2temp(data, data->temp[AUTOMIN][sattr->index]);
-	val = SENSORS_LIMIT(val, temp + autorange_table[0],
+	val = clamp_val(val, temp + autorange_table[0],
 		temp + autorange_table[ARRAY_SIZE(autorange_table) - 1]);
 	val -= temp;
 
@@ -701,7 +701,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		break;
 	}
 
-	data->pwm[sattr->nr][sattr->index] = SENSORS_LIMIT(val, 0, 0xFF);
+	data->pwm[sattr->nr][sattr->index] = clamp_val(val, 0, 0xFF);
 	i2c_smbus_write_byte_data(client, reg,
 				  data->pwm[sattr->nr][sattr->index]);
 
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index ae482e3..4fe49d2 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -241,7 +241,7 @@ static ssize_t set_temp(
 	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
-	val = SENSORS_LIMIT(val / 1000, -128, 127);
+	val = clamp_val(val / 1000, -128, 127);
 
 	mutex_lock(&data->update_lock);
 	data->temp[ix] = val;
@@ -332,7 +332,7 @@ static ssize_t set_pwm1(
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1 = SENSORS_LIMIT(val , 0, 255);
+	data->pwm1 = clamp_val(val , 0, 255);
 	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -499,11 +499,11 @@ static ssize_t set_temp_auto_point_temp(
 	mutex_lock(&data->update_lock);
 	switch (ix) {
 	case 0:
-		ptemp[0] = SENSORS_LIMIT(val / 1000, 0,
-				data->temp1_auto_point_temp[1]);
-		ptemp[0] = SENSORS_LIMIT(ptemp[0], 0,
-				data->temp2_auto_point_temp[1]);
-		ptemp[0] = SENSORS_LIMIT(ptemp[0], 0, 63);
+		ptemp[0] = clamp_val(val / 1000, 0,
+				     data->temp1_auto_point_temp[1]);
+		ptemp[0] = clamp_val(ptemp[0], 0,
+				     data->temp2_auto_point_temp[1]);
+		ptemp[0] = clamp_val(ptemp[0], 0, 63);
 		if (i2c_smbus_write_byte_data(
 					client,
 					AMC6821_REG_PSV_TEMP,
@@ -515,20 +515,12 @@ static ssize_t set_temp_auto_point_temp(
 		goto EXIT;
 		break;
 	case 1:
-		ptemp[1] = SENSORS_LIMIT(
-					val / 1000,
-					(ptemp[0] & 0x7C) + 4,
-					124);
+		ptemp[1] = clamp_val(val / 1000, (ptemp[0] & 0x7C) + 4, 124);
 		ptemp[1] &= 0x7C;
-		ptemp[2] = SENSORS_LIMIT(
-					ptemp[2], ptemp[1] + 1,
-					255);
+		ptemp[2] = clamp_val(ptemp[2], ptemp[1] + 1, 255);
 		break;
 	case 2:
-		ptemp[2] = SENSORS_LIMIT(
-					val / 1000,
-					ptemp[1]+1,
-					255);
+		ptemp[2] = clamp_val(val / 1000, ptemp[1]+1, 255);
 		break;
 	default:
 		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
@@ -561,7 +553,7 @@ static ssize_t set_pwm1_auto_point_pwm(
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1_auto_point_pwm[1] = SENSORS_LIMIT(val, 0, 254);
+	data->pwm1_auto_point_pwm[1] = clamp_val(val, 0, 254);
 	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
 			data->pwm1_auto_point_pwm[1])) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
@@ -629,7 +621,7 @@ static ssize_t set_fan(
 	val = 1 > val ? 0xFFFF : 6000000/val;
 
 	mutex_lock(&data->update_lock);
-	data->fan[ix] = (u16) SENSORS_LIMIT(val, 1, 0xFFFF);
+	data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
 	if (i2c_smbus_write_byte_data(client, fan_reg_low[ix],
 			data->fan[ix] & 0xFF)) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 520e5bf..6ac612c 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -114,7 +114,7 @@ static const u16 asb100_reg_temp_hyst[]	= {0, 0x3a, 0x153, 0x253, 0x19};
  */
 static u8 IN_TO_REG(unsigned val)
 {
-	unsigned nval = SENSORS_LIMIT(val, ASB100_IN_MIN, ASB100_IN_MAX);
+	unsigned nval = clamp_val(val, ASB100_IN_MIN, ASB100_IN_MAX);
 	return (nval + 8) / 16;
 }
 
@@ -129,8 +129,8 @@ static u8 FAN_TO_REG(long rpm, int div)
 		return 0;
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 static int FAN_FROM_REG(u8 val, int div)
@@ -148,7 +148,7 @@ static int FAN_FROM_REG(u8 val, int div)
  */
 static u8 TEMP_TO_REG(long temp)
 {
-	int ntemp = SENSORS_LIMIT(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
+	int ntemp = clamp_val(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
 	ntemp += (ntemp < 0 ? -500 : 500);
 	return (u8)(ntemp / 1000);
 }
@@ -164,7 +164,7 @@ static int TEMP_FROM_REG(u8 reg)
  */
 static u8 ASB100_PWM_TO_REG(int pwm)
 {
-	pwm = SENSORS_LIMIT(pwm, 0, 255);
+	pwm = clamp_val(pwm, 0, 255);
 	return (u8)(pwm / 16);
 }
 
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index b867aab7..da7f5b5 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -191,7 +191,7 @@ static ssize_t store_u8(struct device *dev, struct device_attribute *attr,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	reqval = SENSORS_LIMIT(reqval, 0, 255);
+	reqval = clamp_val(reqval, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->reg[param->msb[0]] = reqval;
@@ -224,7 +224,7 @@ static ssize_t store_bitmask(struct device *dev,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	reqval = SENSORS_LIMIT(reqval, 0, param->mask[0]);
+	reqval = clamp_val(reqval, 0, param->mask[0]);
 
 	reqval = (reqval & param->mask[0]) << param->shift[0];
 
@@ -274,7 +274,7 @@ static ssize_t store_fan16(struct device *dev,
 	 * generating an alarm.
 	 */
 	reqval -	    (reqval <= 0 ? 0xffff : SENSORS_LIMIT(5400000 / reqval, 0, 0xfffe));
+	    (reqval <= 0 ? 0xffff : clamp_val(5400000 / reqval, 0, 0xfffe));
 
 	mutex_lock(&data->update_lock);
 	data->reg[param->msb[0]] = (reqval >> 8) & 0xff;
@@ -343,11 +343,11 @@ static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	reqval = SENSORS_LIMIT(reqval, 0, 0xffff);
+	reqval = clamp_val(reqval, 0, 0xffff);
 
 	reqval = reqval * 0xc0 / asc7621_in_scaling[nr];
 
-	reqval = SENSORS_LIMIT(reqval, 0, 0xff);
+	reqval = clamp_val(reqval, 0, 0xff);
 
 	mutex_lock(&data->update_lock);
 	data->reg[param->msb[0]] = reqval;
@@ -376,7 +376,7 @@ static ssize_t store_temp8(struct device *dev,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	reqval = SENSORS_LIMIT(reqval, -127000, 127000);
+	reqval = clamp_val(reqval, -127000, 127000);
 
 	temp = reqval / 1000;
 
@@ -432,7 +432,7 @@ static ssize_t store_temp62(struct device *dev,
 	if (kstrtol(buf, 10, &reqval))
 		return -EINVAL;
 
-	reqval = SENSORS_LIMIT(reqval, -32000, 31750);
+	reqval = clamp_val(reqval, -32000, 31750);
 	i = reqval / 1000;
 	f = reqval - (i * 1000);
 	temp = i << 2;
@@ -468,7 +468,7 @@ static ssize_t show_ap2_temp(struct device *dev,
 	auto_point1 = ((s8) data->reg[param->msb[1]]) * 1000;
 	regval  	    ((data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0]);
-	temp = auto_point1 + asc7621_range_map[SENSORS_LIMIT(regval, 0, 15)];
+	temp = auto_point1 + asc7621_range_map[clamp_val(regval, 0, 15)];
 	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", temp);
@@ -489,7 +489,7 @@ static ssize_t store_ap2_temp(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	auto_point1 = data->reg[param->msb[1]] * 1000;
-	reqval = SENSORS_LIMIT(reqval, auto_point1 + 2000, auto_point1 + 80000);
+	reqval = clamp_val(reqval, auto_point1 + 2000, auto_point1 + 80000);
 
 	for (i = ARRAY_SIZE(asc7621_range_map) - 1; i >= 0; i--) {
 		if (reqval >= auto_point1 + asc7621_range_map[i]) {
@@ -523,7 +523,7 @@ static ssize_t show_pwm_ac(struct device *dev,
 	regval = config | (altbit << 3);
 	mutex_unlock(&data->update_lock);
 
-	return sprintf(buf, "%u\n", map[SENSORS_LIMIT(regval, 0, 15)]);
+	return sprintf(buf, "%u\n", map[clamp_val(regval, 0, 15)]);
 }
 
 static ssize_t store_pwm_ac(struct device *dev,
@@ -663,7 +663,7 @@ static ssize_t show_pwm_freq(struct device *dev,
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
 
-	regval = SENSORS_LIMIT(regval, 0, 15);
+	regval = clamp_val(regval, 0, 15);
 
 	return sprintf(buf, "%u\n", asc7621_pwm_freq_map[regval]);
 }
@@ -711,7 +711,7 @@ static ssize_t show_pwm_ast(struct device *dev,
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
 
-	regval = SENSORS_LIMIT(regval, 0, 7);
+	regval = clamp_val(regval, 0, 7);
 
 	return sprintf(buf, "%u\n", asc7621_pwm_auto_spinup_map[regval]);
 
@@ -759,7 +759,7 @@ static ssize_t show_temp_st(struct device *dev,
 	SETUP_SHOW_data_param(dev, attr);
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
-	regval = SENSORS_LIMIT(regval, 0, 7);
+	regval = clamp_val(regval, 0, 7);
 
 	return sprintf(buf, "%u\n", asc7621_temp_smoothing_time_map[regval]);
 }
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 7430f70..c347c94 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -277,7 +277,7 @@ static inline int IN_FROM_REG(int reg, int nominal, int res)
 
 static inline int IN_TO_REG(int val, int nominal)
 {
-	return SENSORS_LIMIT((val * 192 + nominal / 2) / nominal, 0, 255);
+	return clamp_val((val * 192 + nominal / 2) / nominal, 0, 255);
 }
 
 /*
@@ -293,8 +293,7 @@ static inline int TEMP_FROM_REG(int reg, int res)
 
 static inline int TEMP_TO_REG(int val)
 {
-	return SENSORS_LIMIT((val < 0 ? val - 500 : val + 500) / 1000,
-			     -128, 127);
+	return clamp_val((val < 0 ? val - 500 : val + 500) / 1000, -128, 127);
 }
 
 /* Temperature range */
@@ -332,7 +331,7 @@ static inline int TEMP_HYST_FROM_REG(int reg, int ix)
 
 static inline int TEMP_HYST_TO_REG(int val, int ix, int reg)
 {
-	int hyst = SENSORS_LIMIT((val + 500) / 1000, 0, 15);
+	int hyst = clamp_val((val + 500) / 1000, 0, 15);
 
 	return (ix = 1) ? (reg & 0xf0) | hyst : (reg & 0x0f) | (hyst << 4);
 }
@@ -349,10 +348,10 @@ static inline int FAN_FROM_REG(int reg, int tpc)
 static inline int FAN_TO_REG(int val, int tpc)
 {
 	if (tpc) {
-		return SENSORS_LIMIT(val / tpc, 0, 0xffff);
+		return clamp_val(val / tpc, 0, 0xffff);
 	} else {
 		return (val <= 0) ? 0xffff :
-			SENSORS_LIMIT(90000 * 60 / val, 0, 0xfffe);
+			clamp_val(90000 * 60 / val, 0, 0xfffe);
 	}
 }
 
@@ -1282,7 +1281,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	switch (fn) {
 	case SYS_PWM:
-		data->pwm[ix] = SENSORS_LIMIT(val, 0, 255);
+		data->pwm[ix] = clamp_val(val, 0, 255);
 		dme1737_write(data, DME1737_REG_PWM(ix), data->pwm[ix]);
 		break;
 	case SYS_PWM_FREQ:
@@ -1450,7 +1449,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		break;
 	case SYS_PWM_AUTO_POINT1_PWM:
 		/* Only valid for pwm[1-3] */
-		data->pwm_min[ix] = SENSORS_LIMIT(val, 0, 255);
+		data->pwm_min[ix] = clamp_val(val, 0, 255);
 		dme1737_write(data, DME1737_REG_PWM_MIN(ix),
 			      data->pwm_min[ix]);
 		break;
diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 77f434c..b073056 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -405,7 +405,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
 	if (rpm_target = 0)
 		data->fan_target = 0x1fff;
 	else
-		data->fan_target = SENSORS_LIMIT(
+		data->fan_target = clamp_val(
 			(FAN_RPM_FACTOR * data->fan_multiplier) / rpm_target,
 			0, 0x1fff);
 
diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index 789bd4f..936898f 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -220,7 +220,7 @@ static ssize_t set_in(struct device *dev, struct device_attribute *devattr,
 			  : EMC6W201_REG_IN_HIGH(nr);
 
 	mutex_lock(&data->update_lock);
-	data->in[sf][nr] = SENSORS_LIMIT(val, 0, 255);
+	data->in[sf][nr] = clamp_val(val, 0, 255);
 	err = emc6w201_write8(client, reg, data->in[sf][nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -257,7 +257,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			  : EMC6W201_REG_TEMP_HIGH(nr);
 
 	mutex_lock(&data->update_lock);
-	data->temp[sf][nr] = SENSORS_LIMIT(val, -127, 128);
+	data->temp[sf][nr] = clamp_val(val, -127, 128);
 	err = emc6w201_write8(client, reg, data->temp[sf][nr]);
 	mutex_unlock(&data->update_lock);
 
@@ -298,7 +298,7 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *devattr,
 		val = 0xFFFF;
 	} else {
 		val = DIV_ROUND_CLOSEST(5400000U, val);
-		val = SENSORS_LIMIT(val, 0, 0xFFFE);
+		val = clamp_val(val, 0, 0xFFFE);
 	}
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index bb7275c..cfb02dd 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1350,7 +1350,7 @@ static ssize_t store_fan_full_speed(struct device *dev,
 	if (err)
 		return err;
 
-	val = SENSORS_LIMIT(val, 23, 1500000);
+	val = clamp_val(val, 23, 1500000);
 	val = fan_to_reg(val);
 
 	mutex_lock(&data->update_lock);
@@ -1438,7 +1438,7 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute
 		return err;
 
 	val /= 8;
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_IN1_HIGH, val);
@@ -1542,7 +1542,7 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute
 		return err;
 
 	val /= 1000;
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_TEMP_HIGH(nr), val);
@@ -1589,8 +1589,7 @@ static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
 
 	/* convert abs to relative and check */
 	data->temp_high[nr] = f71882fg_read8(data, F71882FG_REG_TEMP_HIGH(nr));
-	val = SENSORS_LIMIT(val, data->temp_high[nr] - 15,
-			    data->temp_high[nr]);
+	val = clamp_val(val, data->temp_high[nr] - 15, data->temp_high[nr]);
 	val = data->temp_high[nr] - val;
 
 	/* convert value to register contents */
@@ -1627,7 +1626,7 @@ static ssize_t store_temp_crit(struct device *dev, struct device_attribute
 		return err;
 
 	val /= 1000;
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_TEMP_OVT(nr), val);
@@ -1754,7 +1753,7 @@ static ssize_t store_pwm(struct device *dev,
 	if (err)
 		return err;
 
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
@@ -1805,7 +1804,7 @@ static ssize_t store_simple_pwm(struct device *dev,
 	if (err)
 		return err;
 
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
@@ -1932,7 +1931,7 @@ static ssize_t store_pwm_auto_point_pwm(struct device *dev,
 	if (err)
 		return err;
 
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
@@ -1991,8 +1990,8 @@ static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
 	mutex_lock(&data->update_lock);
 	data->pwm_auto_point_temp[nr][point]  		f71882fg_read8(data, F71882FG_REG_POINT_TEMP(nr, point));
-	val = SENSORS_LIMIT(val, data->pwm_auto_point_temp[nr][point] - 15,
-				data->pwm_auto_point_temp[nr][point]);
+	val = clamp_val(val, data->pwm_auto_point_temp[nr][point] - 15,
+			data->pwm_auto_point_temp[nr][point]);
 	val = data->pwm_auto_point_temp[nr][point] - val;
 
 	reg = f71882fg_read8(data, F71882FG_REG_FAN_HYST(nr / 2));
@@ -2126,9 +2125,9 @@ static ssize_t store_pwm_auto_point_temp(struct device *dev,
 	val /= 1000;
 
 	if (data->auto_point_temp_signed)
-		val = SENSORS_LIMIT(val, -128, 127);
+		val = clamp_val(val, -128, 127);
 	else
-		val = SENSORS_LIMIT(val, 0, 127);
+		val = clamp_val(val, 0, 127);
 
 	mutex_lock(&data->update_lock);
 	f71882fg_write8(data, F71882FG_REG_POINT_TEMP(pwm, point), val);
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index f7dba22..9e300e5 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -359,7 +359,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	data->pwm[nr] = clamp_val(val, 0, 255);
 	f75375_write_pwm(client, nr);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -556,7 +556,7 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(VOLT_TO_REG(val), 0, 0xff);
+	val = clamp_val(VOLT_TO_REG(val), 0, 0xff);
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = val;
 	f75375_write8(client, F75375_REG_VOLT_HIGH(nr), data->in_max[nr]);
@@ -577,7 +577,7 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(VOLT_TO_REG(val), 0, 0xff);
+	val = clamp_val(VOLT_TO_REG(val), 0, 0xff);
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = val;
 	f75375_write8(client, F75375_REG_VOLT_LOW(nr), data->in_min[nr]);
@@ -625,7 +625,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(TEMP_TO_REG(val), 0, 127);
+	val = clamp_val(TEMP_TO_REG(val), 0, 127);
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = val;
 	f75375_write8(client, F75375_REG_TEMP_HIGH(nr), data->temp_high[nr]);
@@ -646,7 +646,7 @@ static ssize_t set_temp_max_hyst(struct device *dev,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(TEMP_TO_REG(val), 0, 127);
+	val = clamp_val(TEMP_TO_REG(val), 0, 127);
 	mutex_lock(&data->update_lock);
 	data->temp_max_hyst[nr] = val;
 	f75375_write8(client, F75375_REG_TEMP_HYST(nr),
@@ -822,7 +822,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 		if (auto_mode_enabled(f75375s_pdata->pwm_enable[nr]) ||
 		    !duty_mode_enabled(f75375s_pdata->pwm_enable[nr]))
 			continue;
-		data->pwm[nr] = SENSORS_LIMIT(f75375s_pdata->pwm[nr], 0, 255);
+		data->pwm[nr] = clamp_val(f75375s_pdata->pwm[nr], 0, 255);
 		f75375_write_pwm(client, nr);
 	}
 
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 519ce8b..8af2755 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -379,7 +379,7 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute
 	if (err)
 		return err;
 
-	v = SENSORS_LIMIT(v / 1000, -128, 127) + 128;
+	v = clamp_val(v / 1000, -128, 127) + 128;
 
 	mutex_lock(&data->update_lock);
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
@@ -540,7 +540,7 @@ static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
 
 	/* reg: 0 = allow turning off (except on the syl), 1-255 = 50-100% */
 	if (v || data->kind = fscsyl) {
-		v = SENSORS_LIMIT(v, 128, 255);
+		v = clamp_val(v, 128, 255);
 		v = (v - 128) * 2 + 1;
 	}
 
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 8b2106f..ea6480b 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -171,7 +171,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->set_cnt = PWM_TO_CNT(SENSORS_LIMIT(val, 0, 255));
+	data->set_cnt = PWM_TO_CNT(clamp_val(val, 0, 255));
 	g760a_write_value(client, G760A_REG_SET_CNT, data->set_cnt);
 	mutex_unlock(&data->update_lock);
 
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 2c74673..e2e5909 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -86,7 +86,7 @@ enum chips { gl518sm_r00, gl518sm_r80 };
 #define BOOL_FROM_REG(val)	((val) ? 0 : 1)
 #define BOOL_TO_REG(val)	((val) ? 0 : 1)
 
-#define TEMP_TO_REG(val)	SENSORS_LIMIT(((((val) < 0 ? \
+#define TEMP_TO_REG(val)	clamp_val(((((val) < 0 ? \
 				(val) - 500 : \
 				(val) + 500) / 1000) + 119), 0, 255)
 #define TEMP_FROM_REG(val)	(((val) - 119) * 1000)
@@ -96,15 +96,15 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 	long rpmdiv;
 	if (rpm = 0)
 		return 0;
-	rpmdiv = SENSORS_LIMIT(rpm, 1, 960000) * div;
-	return SENSORS_LIMIT((480000 + rpmdiv / 2) / rpmdiv, 1, 255);
+	rpmdiv = clamp_val(rpm, 1, 960000) * div;
+	return clamp_val((480000 + rpmdiv / 2) / rpmdiv, 1, 255);
 }
 #define FAN_FROM_REG(val, div)	((val) = 0 ? 0 : (480000 / ((val) * (div))))
 
-#define IN_TO_REG(val)		SENSORS_LIMIT((((val) + 9) / 19), 0, 255)
+#define IN_TO_REG(val)		clamp_val((((val) + 9) / 19), 0, 255)
 #define IN_FROM_REG(val)	((val) * 19)
 
-#define VDD_TO_REG(val)		SENSORS_LIMIT((((val) * 4 + 47) / 95), 0, 255)
+#define VDD_TO_REG(val)		clamp_val((((val) * 4 + 47) / 95), 0, 255)
 #define VDD_FROM_REG(val)	(((val) * 95 + 2) / 4)
 
 #define DIV_FROM_REG(val)	(1 << (val))
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index a21ff25..ed56e09 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -144,10 +144,10 @@ static ssize_t get_cpu_vid(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, get_cpu_vid, NULL);
 
 #define VDD_FROM_REG(val) (((val) * 95 + 2) / 4)
-#define VDD_TO_REG(val) SENSORS_LIMIT((((val) * 4 + 47) / 95), 0, 255)
+#define VDD_TO_REG(val) clamp_val((((val) * 4 + 47) / 95), 0, 255)
 
 #define IN_FROM_REG(val) ((val) * 19)
-#define IN_TO_REG(val) SENSORS_LIMIT((((val) + 9) / 19), 0, 255)
+#define IN_TO_REG(val) clamp_val((((val) + 9) / 19), 0, 255)
 
 static ssize_t get_in_input(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -285,8 +285,7 @@ static SENSOR_DEVICE_ATTR(in4_max, S_IRUGO | S_IWUSR,
 #define DIV_FROM_REG(val) (1 << (val))
 #define FAN_FROM_REG(val, div) ((val) = 0 ? 0 : (480000 / ((val) << (div))))
 #define FAN_TO_REG(val, div) ((val) <= 0 ? 0 : \
-	SENSORS_LIMIT((480000 + ((val) << ((div)-1))) / ((val) << (div)), 1, \
-		      255))
+	clamp_val((480000 + ((val) << ((div)-1))) / ((val) << (div)), 1, 255))
 
 static ssize_t get_fan_input(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -450,7 +449,7 @@ static DEVICE_ATTR(fan1_off, S_IRUGO | S_IWUSR,
 		get_fan_off, set_fan_off);
 
 #define TEMP_FROM_REG(val) (((val) - 130) * 1000)
-#define TEMP_TO_REG(val) SENSORS_LIMIT(((((val) < 0 ? \
+#define TEMP_TO_REG(val) clamp_val(((((val) < 0 ? \
 			(val) - 500 : (val) + 500) / 1000) + 130), 0, 255)
 
 static ssize_t get_temp_input(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 117d66f..29632e8 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -384,7 +384,7 @@ static int adc_lsb(const struct it87_data *data, int nr)
 static u8 in_to_reg(const struct it87_data *data, int nr, long val)
 {
 	val = DIV_ROUND_CLOSEST(val, adc_lsb(data, nr));
-	return SENSORS_LIMIT(val, 0, 255);
+	return clamp_val(val, 0, 255);
 }
 
 static int in_from_reg(const struct it87_data *data, int nr, int val)
@@ -396,16 +396,15 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
-			     254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 static inline u16 FAN16_TO_REG(long rpm)
 {
 	if (rpm = 0)
 		return 0xffff;
-	return SENSORS_LIMIT((1350000 + rpm) / (rpm * 2), 1, 0xfffe);
+	return clamp_val((1350000 + rpm) / (rpm * 2), 1, 0xfffe);
 }
 
 #define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 255 ? 0 : \
@@ -414,8 +413,8 @@ static inline u16 FAN16_TO_REG(long rpm)
 #define FAN16_FROM_REG(val) ((val) = 0 ? -1 : (val) = 0xffff ? 0 : \
 			     1350000 / ((val) * 2))
 
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val) < 0 ? (((val) - 500) / 1000) : \
-					((val) + 500) / 1000), -128, 127))
+#define TEMP_TO_REG(val) (clamp_val(((val) < 0 ? (((val) - 500) / 1000) : \
+				    ((val) + 500) / 1000), -128, 127))
 #define TEMP_FROM_REG(val) ((val) * 1000)
 
 static u8 pwm_to_reg(const struct it87_data *data, long val)
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index e21e43c..82d9624 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -237,9 +237,9 @@ static struct i2c_driver jc42_driver = {
 
 static u16 jc42_temp_to_reg(int temp, bool extended)
 {
-	int ntemp = SENSORS_LIMIT(temp,
-				  extended ? JC42_TEMP_MIN_EXTENDED :
-				  JC42_TEMP_MIN, JC42_TEMP_MAX);
+	int ntemp = clamp_val(temp,
+			      extended ? JC42_TEMP_MIN_EXTENDED :
+			      JC42_TEMP_MIN, JC42_TEMP_MAX);
 
 	/* convert from 0.001 to 0.0625 resolution */
 	return (ntemp * 2 / 125) & 0x1fff;
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index eed4d94..f644a2e 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -209,9 +209,9 @@ static inline int lut_temp_to_reg(struct lm63_data *data, long val)
 {
 	val -= data->temp2_offset;
 	if (data->lut_temp_highres)
-		return DIV_ROUND_CLOSEST(SENSORS_LIMIT(val, 0, 127500), 500);
+		return DIV_ROUND_CLOSEST(clamp_val(val, 0, 127500), 500);
 	else
-		return DIV_ROUND_CLOSEST(SENSORS_LIMIT(val, 0, 127000), 1000);
+		return DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 }
 
 /*
@@ -415,7 +415,7 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
 		return err;
 
 	reg = nr ? LM63_REG_LUT_PWM(nr - 1) : LM63_REG_PWM_VALUE;
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm1[nr] = data->pwm_highres ? val :
@@ -700,7 +700,7 @@ static ssize_t set_update_interval(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	lm63_set_convrate(client, data, SENSORS_LIMIT(val, 0, 100000));
+	lm63_set_convrate(client, data, clamp_val(val, 0, 100000));
 	mutex_unlock(&data->update_lock);
 
 	return count;
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 7272176..5166a8e3 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -56,8 +56,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 		return status;
 
 	/* Write value */
-	value = (short) SENSORS_LIMIT(temp/250, (LM73_TEMP_MIN*4),
-		(LM73_TEMP_MAX*4)) << 5;
+	value = (short) clamp_val(temp / 250, LM73_TEMP_MIN * 4,
+				  LM73_TEMP_MAX * 4) << 5;
 	err = i2c_smbus_write_word_swapped(client, attr->index, value);
 	return (err < 0) ? err : count;
 }
diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
index 89aa909..668ff47 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -36,7 +36,7 @@
    REG: (0.5C/bit, two's complement) << 7 */
 static inline u16 LM75_TEMP_TO_REG(long temp)
 {
-	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
+	int ntemp = clamp_val(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
 	ntemp += (ntemp < 0 ? -250 : 250);
 	return (u16)((ntemp / 500) << 7);
 }
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index f82acf6..f17beb5 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -101,7 +101,7 @@ static struct i2c_driver lm77_driver = {
  */
 static inline s16 LM77_TEMP_TO_REG(int temp)
 {
-	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
+	int ntemp = clamp_val(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
 	return (ntemp / 500) * 8;
 }
 
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 53d6ee8..483538f 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -85,7 +85,7 @@ enum chips { lm78, lm79 };
  */
 static inline u8 IN_TO_REG(unsigned long val)
 {
-	unsigned long nval = SENSORS_LIMIT(val, 0, 4080);
+	unsigned long nval = clamp_val(val, 0, 4080);
 	return (nval + 8) / 16;
 }
 #define IN_FROM_REG(val) ((val) *  16)
@@ -94,7 +94,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm <= 0)
 		return 255;
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 static inline int FAN_FROM_REG(u8 val, int div)
@@ -108,7 +108,7 @@ static inline int FAN_FROM_REG(u8 val, int div)
  */
 static inline s8 TEMP_TO_REG(int val)
 {
-	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
+	int nval = clamp_val(val, -128000, 127000) ;
 	return nval < 0 ? (nval - 500) / 1000 : (nval + 500) / 1000;
 }
 
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 28a8b71..357fbb9 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -72,15 +72,15 @@ static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
  * Fixing this is just not worth it.
  */
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT(((val) + 5) / 10, 0, 255))
+#define IN_TO_REG(val)		(clamp_val(((val) + 5) / 10, 0, 255))
 #define IN_FROM_REG(val)	((val) * 10)
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 #define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
@@ -102,7 +102,7 @@ static inline long TEMP_FROM_REG(u16 temp)
 #define TEMP_LIMIT_FROM_REG(val)	(((val) > 0x80 ? \
 	(val) - 0x100 : (val)) * 1000)
 
-#define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val) < 0 ? \
+#define TEMP_LIMIT_TO_REG(val)		clamp_val((val) < 0 ? \
 	((val) - 500) / 1000 : ((val) + 500) / 1000, 0, 255)
 
 #define DIV_FROM_REG(val)		(1 << (val))
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 9f2dd77..47ade8b 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -139,7 +139,7 @@ static const int lm85_scaling[] = {  /* .001 Volts */
 #define SCALE(val, from, to)	(((val) * (to) + ((from) / 2)) / (from))
 
 #define INS_TO_REG(n, val)	\
-		SENSORS_LIMIT(SCALE(val, lm85_scaling[n], 192), 0, 255)
+		clamp_val(SCALE(val, lm85_scaling[n], 192), 0, 255)
 
 #define INSEXT_FROM_REG(n, val, ext)	\
 		SCALE(((val) << 4) + (ext), 192 << 4, lm85_scaling[n])
@@ -151,19 +151,19 @@ static inline u16 FAN_TO_REG(unsigned long val)
 {
 	if (!val)
 		return 0xffff;
-	return SENSORS_LIMIT(5400000 / val, 1, 0xfffe);
+	return clamp_val(5400000 / val, 1, 0xfffe);
 }
 #define FAN_FROM_REG(val)	((val) = 0 ? -1 : (val) = 0xffff ? 0 : \
 				 5400000 / (val))
 
 /* Temperature is reported in .001 degC increments */
 #define TEMP_TO_REG(val)	\
-		SENSORS_LIMIT(SCALE(val, 1000, 1), -127, 127)
+		clamp_val(SCALE(val, 1000, 1), -127, 127)
 #define TEMPEXT_FROM_REG(val, ext)	\
 		SCALE(((val) << 4) + (ext), 16, 1000)
 #define TEMP_FROM_REG(val)	((val) * 1000)
 
-#define PWM_TO_REG(val)			SENSORS_LIMIT(val, 0, 255)
+#define PWM_TO_REG(val)			clamp_val(val, 0, 255)
 #define PWM_FROM_REG(val)		(val)
 
 
@@ -258,7 +258,7 @@ static int ZONE_TO_REG(int zone)
 	return i << 5;
 }
 
-#define HYST_TO_REG(val)	SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
+#define HYST_TO_REG(val)	clamp_val(((val) + 500) / 1000, 0, 15)
 #define HYST_FROM_REG(val)	((val) * 1000)
 
 /*
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 863412a..8eeb141 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -931,7 +931,7 @@ static ssize_t set_update_interval(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	lm90_set_convrate(client, data, SENSORS_LIMIT(val, 0, 100000));
+	lm90_set_convrate(client, data, clamp_val(val, 0, 100000));
 	mutex_unlock(&data->update_lock);
 
 	return count;
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 1a003f7..81449a2 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -371,22 +371,22 @@ static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
 static u8 LM93_IN_TO_REG(int nr, unsigned val)
 {
 	/* range limit */
-	const long mV = SENSORS_LIMIT(val,
-		lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
+	const long mv = clamp_val(val,
+				  lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
 
 	/* try not to lose too much precision here */
-	const long uV = mV * 1000;
-	const long uV_max = lm93_vin_val_max[nr] * 1000;
-	const long uV_min = lm93_vin_val_min[nr] * 1000;
+	const long uv = mv * 1000;
+	const long uv_max = lm93_vin_val_max[nr] * 1000;
+	const long uv_min = lm93_vin_val_min[nr] * 1000;
 
 	/* convert */
-	const long slope = (uV_max - uV_min) /
+	const long slope = (uv_max - uv_min) /
 		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
-	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
+	const long intercept = uv_min - slope * lm93_vin_reg_min[nr];
 
-	u8 result = ((uV - intercept + (slope/2)) / slope);
-	result = SENSORS_LIMIT(result,
-			lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
+	u8 result = ((uv - intercept + (slope/2)) / slope);
+	result = clamp_val(result,
+			   lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
 	return result;
 }
 
@@ -409,13 +409,13 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
  */
 static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
 {
-	long uV_offset = vid * 1000 - val * 10000;
+	long uv_offset = vid * 1000 - val * 10000;
 	if (upper) {
-		uV_offset = SENSORS_LIMIT(uV_offset, 12500, 200000);
-		return (u8)((uV_offset /  12500 - 1) << 4);
+		uv_offset = clamp_val(uv_offset, 12500, 200000);
+		return (u8)((uv_offset /  12500 - 1) << 4);
 	} else {
-		uV_offset = SENSORS_LIMIT(uV_offset, -400000, -25000);
-		return (u8)((uV_offset / -25000 - 1) << 0);
+		uv_offset = clamp_val(uv_offset, -400000, -25000);
+		return (u8)((uv_offset / -25000 - 1) << 0);
 	}
 }
 
@@ -437,7 +437,7 @@ static int LM93_TEMP_FROM_REG(u8 reg)
  */
 static u8 LM93_TEMP_TO_REG(long temp)
 {
-	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
+	int ntemp = clamp_val(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
 	ntemp += (ntemp < 0 ? -500 : 500);
 	return (u8)(ntemp / 1000);
 }
@@ -472,7 +472,7 @@ static u8 LM93_TEMP_OFFSET_TO_REG(int off, int mode)
 {
 	int factor = mode ? 5 : 10;
 
-	off = SENSORS_LIMIT(off, LM93_TEMP_OFFSET_MIN,
+	off = clamp_val(off, LM93_TEMP_OFFSET_MIN,
 		mode ? LM93_TEMP_OFFSET_MAX1 : LM93_TEMP_OFFSET_MAX0);
 	return (u8)((off + factor/2) / factor);
 }
@@ -620,8 +620,8 @@ static u16 LM93_FAN_TO_REG(long rpm)
 	if (rpm = 0) {
 		count = 0x3fff;
 	} else {
-		rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-		count = SENSORS_LIMIT((1350000 + rpm) / rpm, 1, 0x3ffe);
+		rpm = clamp_val(rpm, 1, 1000000);
+		count = clamp_val((1350000 + rpm) / rpm, 1, 0x3ffe);
 	}
 
 	regs = count << 2;
@@ -692,7 +692,7 @@ static int LM93_RAMP_FROM_REG(u8 reg)
  */
 static u8 LM93_RAMP_TO_REG(int ramp)
 {
-	ramp = SENSORS_LIMIT(ramp, LM93_RAMP_MIN, LM93_RAMP_MAX);
+	ramp = clamp_val(ramp, LM93_RAMP_MIN, LM93_RAMP_MAX);
 	return (u8)((ramp + 2) / 5);
 }
 
@@ -702,7 +702,7 @@ static u8 LM93_RAMP_TO_REG(int ramp)
  */
 static u8 LM93_PROCHOT_TO_REG(long prochot)
 {
-	prochot = SENSORS_LIMIT(prochot, 0, 255);
+	prochot = clamp_val(prochot, 0, 255);
 	return (u8)prochot;
 }
 
@@ -2052,9 +2052,9 @@ static ssize_t store_pwm_auto_channels(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
+	data->block9[nr][LM93_PWM_CTL1] = clamp_val(val, 0, 255);
 	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL1),
-				data->block9[nr][LM93_PWM_CTL1]);
+			data->block9[nr][LM93_PWM_CTL1]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2397,7 +2397,7 @@ static ssize_t store_prochot_override_duty_cycle(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->prochot_override = (data->prochot_override & 0xf0) |
-					SENSORS_LIMIT(val, 0, 15);
+					clamp_val(val, 0, 15);
 	lm93_write_byte(client, LM93_REG_PROCHOT_OVERRIDE,
 			data->prochot_override);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 2915fd9..a6c85f0 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -259,7 +259,7 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
 
 	val /= 1000;
 
-	val = SENSORS_LIMIT(val, 0, (index = 6 ? 127 : 255));
+	val = clamp_val(val, 0, (index = 6 ? 127 : 255));
 
 	mutex_lock(&data->update_lock);
 
@@ -284,7 +284,7 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
 
 	val /= 1000;
 
-	val = SENSORS_LIMIT(val, 0, 31);
+	val = clamp_val(val, 0, 31);
 
 	mutex_lock(&data->update_lock);
 
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index e0019c6..2fa2c02 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -118,7 +118,7 @@ static inline int LIMIT_TO_MV(int limit, int range)
 
 static inline int MV_TO_LIMIT(int mv, int range)
 {
-	return SENSORS_LIMIT(DIV_ROUND_CLOSEST(mv * 256, range), 0, 255);
+	return clamp_val(DIV_ROUND_CLOSEST(mv * 256, range), 0, 255);
 }
 
 static inline int ADC_TO_CURR(int adc, int gain)
diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index 666d9f6..a762635 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -215,7 +215,7 @@ static ssize_t set_temp_max(struct device *dev,
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[index] = SENSORS_LIMIT(temp/1000, -128, 127);
+	data->temp_max[index] = clamp_val(temp/1000, -128, 127);
 	if (i2c_smbus_write_byte_data(client,
 					MAX1668_REG_LIMH_WR(index),
 					data->temp_max[index]))
@@ -240,7 +240,7 @@ static ssize_t set_temp_min(struct device *dev,
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[index] = SENSORS_LIMIT(temp/1000, -128, 127);
+	data->temp_min[index] = clamp_val(temp/1000, -128, 127);
 	if (i2c_smbus_write_byte_data(client,
 					MAX1668_REG_LIML_WR(index),
 					data->temp_max[index]))
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 6e60036..3e7b426 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -74,7 +74,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 #define FAN_FROM_REG(val, rpm_range)	((val) = 0 || (val) = 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
-#define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)
+#define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
 
 /*
  * Client data (each client gets its own)
@@ -312,7 +312,7 @@ static ssize_t set_pwm(struct device *dev,
 	if (res)
 		return res;
 
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] = (u8)(val * 120 / 255);
diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 223461a..57d58cd 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -239,7 +239,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_high[attr2->nr] = SENSORS_LIMIT(temp_to_reg(val), 0, 255);
+	data->temp_high[attr2->nr] = clamp_val(temp_to_reg(val), 0, 255);
 	i2c_smbus_write_byte_data(client, attr2->index,
 				  data->temp_high[attr2->nr]);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index f739f83..3c16cbd 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -245,7 +245,7 @@ static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
 	if (err)
 		return err;
 
-	rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
+	rpm = clamp_val(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
 
 	/*
 	 * Divide the required speed by 60 to get from rpm to rps, then
@@ -313,7 +313,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 	if (err)
 		return err;
 
-	pwm = SENSORS_LIMIT(pwm, 0, 255);
+	pwm = clamp_val(pwm, 0, 255);
 
 	mutex_lock(&data->update_lock);
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7d19b1b..dbacde6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -657,7 +657,7 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
 			      enum pmbus_sensor_classes class, long val)
 {
-	val = SENSORS_LIMIT(val, 500, 1600);
+	val = clamp_val(val, 500, 1600);
 
 	return 2 + DIV_ROUND_CLOSEST((1600 - val) * 100, 625);
 }
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 06ce3c9..c35847a 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -132,7 +132,7 @@ static struct platform_device *pdev;
  */
 static inline u8 IN_TO_REG(unsigned long val)
 {
-	unsigned long nval = SENSORS_LIMIT(val, 0, 4080);
+	unsigned long nval = clamp_val(val, 0, 4080);
 	return (nval + 8) / 16;
 }
 #define IN_FROM_REG(val) ((val) *  16)
@@ -141,7 +141,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm <= 0)
 		return 255;
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 static inline int FAN_FROM_REG(u8 val, int div)
@@ -159,7 +159,7 @@ static inline int TEMP_FROM_REG(s8 val)
 }
 static inline s8 TEMP_TO_REG(int val)
 {
-	int nval = SENSORS_LIMIT(val, -54120, 157530) ;
+	int nval = clamp_val(val, -54120, 157530) ;
 	return nval < 0 ? (nval - 5212 - 415) / 830 : (nval - 5212 + 415) / 830;
 }
 
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index dba0c56..6d8255c 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -326,7 +326,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute
 	/* Preserve fan min */
 	tmp = 192 - (old_div * (192 - data->fan_preload[nr])
 		     + new_div / 2) / new_div;
-	data->fan_preload[nr] = SENSORS_LIMIT(tmp, 0, 191);
+	data->fan_preload[nr] = clamp_val(tmp, 0, 191);
 	smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
 			     data->fan_preload[nr]);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 36a3478..efee4c5 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -77,7 +77,7 @@ static inline unsigned int IN_FROM_REG(u8 reg, int n)
 
 static inline u8 IN_TO_REG(unsigned long val, int n)
 {
-	return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
+	return clamp_val(SCALE(val, 192, nom_mv[n]), 0, 255);
 }
 
 /*
@@ -86,7 +86,7 @@ static inline u8 IN_TO_REG(unsigned long val, int n)
  */
 static inline s8 TEMP_TO_REG(int val)
 {
-	return SENSORS_LIMIT(SCALE(val, 1, 1000), -128000, 127000);
+	return clamp_val(SCALE(val, 1, 1000), -128000, 127000);
 }
 
 static inline int TEMP_FROM_REG(s8 val)
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 3c2c48d9..4b59eb5 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -134,7 +134,7 @@ static ssize_t set_analog_out(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->analog_out = SENSORS_LIMIT(tmp, 0, 255);
+	data->analog_out = clamp_val(tmp, 0, 255);
 	i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
 				  data->analog_out);
 
@@ -187,7 +187,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
+	data->temp_min[nr] = clamp_val(val / 1000, -128, 127);
 	i2c_smbus_write_byte_data(client, THMC50_REG_TEMP_MIN[nr],
 				  data->temp_min[nr]);
 	mutex_unlock(&data->update_lock);
@@ -216,7 +216,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
+	data->temp_max[nr] = clamp_val(val / 1000, -128, 127);
 	i2c_smbus_write_byte_data(client, THMC50_REG_TEMP_MAX[nr],
 				  data->temp_max[nr]);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index b10c3d3..523dd89 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -115,7 +115,7 @@ static ssize_t tmp102_set_temp(struct device *dev,
 
 	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
-	val = SENSORS_LIMIT(val, -256000, 255000);
+	val = clamp_val(val, -256000, 255000);
 
 	mutex_lock(&tmp102->lock);
 	tmp102->temp[sda->index] = val;
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index e620548..c85f696 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -142,10 +142,10 @@ static int tmp401_register_to_temp(u16 reg, u8 config)
 static u16 tmp401_temp_to_register(long temp, u8 config)
 {
 	if (config & TMP401_CONFIG_RANGE) {
-		temp = SENSORS_LIMIT(temp, -64000, 191000);
+		temp = clamp_val(temp, -64000, 191000);
 		temp += 64000;
 	} else
-		temp = SENSORS_LIMIT(temp, 0, 127000);
+		temp = clamp_val(temp, 0, 127000);
 
 	return (temp * 160 + 312) / 625;
 }
@@ -163,10 +163,10 @@ static int tmp401_crit_register_to_temp(u8 reg, u8 config)
 static u8 tmp401_crit_temp_to_register(long temp, u8 config)
 {
 	if (config & TMP401_CONFIG_RANGE) {
-		temp = SENSORS_LIMIT(temp, -64000, 191000);
+		temp = clamp_val(temp, -64000, 191000);
 		temp += 64000;
 	} else
-		temp = SENSORS_LIMIT(temp, 0, 127000);
+		temp = clamp_val(temp, 0, 127000);
 
 	return (temp + 500) / 1000;
 }
@@ -417,14 +417,14 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
 		return -EINVAL;
 
 	if (data->config & TMP401_CONFIG_RANGE)
-		val = SENSORS_LIMIT(val, -64000, 191000);
+		val = clamp_val(val, -64000, 191000);
 	else
-		val = SENSORS_LIMIT(val, 0, 127000);
+		val = clamp_val(val, 0, 127000);
 
 	mutex_lock(&data->update_lock);
 	temp = tmp401_crit_register_to_temp(data->temp_crit[index],
 						data->config);
-	val = SENSORS_LIMIT(val, temp - 255000, temp);
+	val = clamp_val(val, temp - 255000, temp);
 	reg = ((temp - val) + 500) / 1000;
 
 	i2c_smbus_write_byte_data(to_i2c_client(dev),
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index e0e14a9..3123b30 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -135,17 +135,14 @@ static inline u8 IN_TO_REG(long val, int inNum)
 	 * for the constants.
 	 */
 	if (inNum <= 1)
-		return (u8)
-		    SENSORS_LIMIT((val * 21024 - 1205000) / 250000, 0, 255);
+		return (u8) clamp_val((val * 21024 - 1205000) / 250000, 0, 255);
 	else if (inNum = 2)
-		return (u8)
-		    SENSORS_LIMIT((val * 15737 - 1205000) / 250000, 0, 255);
+		return (u8) clamp_val((val * 15737 - 1205000) / 250000, 0, 255);
 	else if (inNum = 3)
-		return (u8)
-		    SENSORS_LIMIT((val * 10108 - 1205000) / 250000, 0, 255);
+		return (u8) clamp_val((val * 10108 - 1205000) / 250000, 0, 255);
 	else
-		return (u8)
-		    SENSORS_LIMIT((val * 41714 - 12050000) / 2500000, 0, 255);
+		return (u8) clamp_val((val * 41714 - 12050000) / 2500000, 0,
+				      255);
 }
 
 static inline long IN_FROM_REG(u8 val, int inNum)
@@ -175,8 +172,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 0;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 255);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 255);
 }
 
 #define FAN_FROM_REG(val, div) ((val) = 0 ? 0 : (val) = 255 ? 0 : 1350000 / \
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 7517030..dcc62f8 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -158,7 +158,7 @@ struct vt1211_data {
 #define IN_FROM_REG(ix, reg)	((reg) < 3 ? 0 : (ix) = 5 ? \
 				 (((reg) - 3) * 15882 + 479) / 958 : \
 				 (((reg) - 3) * 10000 + 479) / 958)
-#define IN_TO_REG(ix, val)	(SENSORS_LIMIT((ix) = 5 ? \
+#define IN_TO_REG(ix, val)	(clamp_val((ix) = 5 ? \
 				 ((val) * 958 + 7941) / 15882 + 3 : \
 				 ((val) * 958 + 5000) / 10000 + 3, 0, 255))
 
@@ -173,7 +173,7 @@ struct vt1211_data {
 				 (ix) = 1 ? (reg) < 51 ? 0 : \
 				 ((reg) - 51) * 1000 : \
 				 ((253 - (reg)) * 2200 + 105) / 210)
-#define TEMP_TO_REG(ix, val)	SENSORS_LIMIT( \
+#define TEMP_TO_REG(ix, val)	clamp_val( \
 				 ((ix) = 0 ? ((val) + 500) / 1000 : \
 				  (ix) = 1 ? ((val) + 500) / 1000 + 51 : \
 				  253 - ((val) * 210 + 1100) / 2200), 0, 255)
@@ -183,7 +183,7 @@ struct vt1211_data {
 #define RPM_FROM_REG(reg, div)	(((reg) = 0) || ((reg) = 255) ? 0 : \
 				 1310720 / (reg) / DIV_FROM_REG(div))
 #define RPM_TO_REG(val, div)	((val) = 0 ? 255 : \
-				 SENSORS_LIMIT((1310720 / (val) / \
+				 clamp_val((1310720 / (val) / \
 				 DIV_FROM_REG(div)), 1, 254))
 
 /* ---------------------------------------------------------------------
@@ -687,7 +687,7 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 				data->fan_ctl));
 		break;
 	case SHOW_SET_PWM_FREQ:
-		val = 135000 / SENSORS_LIMIT(val, 135000 >> 7, 135000);
+		val = 135000 / clamp_val(val, 135000 >> 7, 135000);
 		/* calculate tmp = log2(val) */
 		tmp = 0;
 		for (val >>= 1; val > 0; val >>= 1)
@@ -845,7 +845,7 @@ static ssize_t set_pwm_auto_point_pwm(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->pwm_auto_pwm[ix][ap] = SENSORS_LIMIT(val, 0, 255);
+	data->pwm_auto_pwm[ix][ap] = clamp_val(val, 0, 255);
 	vt1211_write8(data, VT1211_REG_PWM_AUTO_PWM(ix, ap),
 		      data->pwm_auto_pwm[ix][ap]);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index a56355c..988a2a7 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -147,7 +147,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 0;
-	return SENSORS_LIMIT(1310720 / (rpm * div), 1, 255);
+	return clamp_val(1310720 / (rpm * div), 1, 255);
 }
 
 #define FAN_FROM_REG(val, div) ((val) = 0 ? 0 : 1310720 / ((val) * (div)))
@@ -236,7 +236,7 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->in_min[nr] = SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
+	data->in_min[nr] = clamp_val(((val * 958) / 10000) + 3, 0, 255);
 	vt8231_write_value(data, regvoltmin[nr], data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -256,7 +256,7 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->in_max[nr] = SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
+	data->in_max[nr] = clamp_val(((val * 958) / 10000) + 3, 0, 255);
 	vt8231_write_value(data, regvoltmax[nr], data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -302,8 +302,8 @@ static ssize_t set_in5_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->in_min[5] = SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
-					0, 255);
+	data->in_min[5] = clamp_val(((val * 958 * 34) / (10000 * 54)) + 3,
+				    0, 255);
 	vt8231_write_value(data, regvoltmin[5], data->in_min[5]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -321,8 +321,8 @@ static ssize_t set_in5_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->in_max[5] = SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
-					0, 255);
+	data->in_max[5] = clamp_val(((val * 958 * 34) / (10000 * 54)) + 3,
+				    0, 255);
 	vt8231_write_value(data, regvoltmax[5], data->in_max[5]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -380,7 +380,7 @@ static ssize_t set_temp0_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[0] = SENSORS_LIMIT((val + 500) / 1000, 0, 255);
+	data->temp_max[0] = clamp_val((val + 500) / 1000, 0, 255);
 	vt8231_write_value(data, regtempmax[0], data->temp_max[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -397,7 +397,7 @@ static ssize_t set_temp0_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[0] = SENSORS_LIMIT((val + 500) / 1000, 0, 255);
+	data->temp_min[0] = clamp_val((val + 500) / 1000, 0, 255);
 	vt8231_write_value(data, regtempmin[0], data->temp_min[0]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -444,7 +444,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[nr] = SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
+	data->temp_max[nr] = clamp_val(TEMP_MAXMIN_TO_REG(val), 0, 255);
 	vt8231_write_value(data, regtempmax[nr], data->temp_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -463,7 +463,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[nr] = SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
+	data->temp_min[nr] = clamp_val(TEMP_MAXMIN_TO_REG(val), 0, 255);
 	vt8231_write_value(data, regtempmin[nr], data->temp_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0e8ffd6..0a89211 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -354,8 +354,8 @@ static inline unsigned int step_time_from_reg(u8 reg, u8 mode)
 
 static inline u8 step_time_to_reg(unsigned int msec, u8 mode)
 {
-	return SENSORS_LIMIT((mode ? (msec + 50) / 100 :
-						(msec + 200) / 400), 1, 255);
+	return clamp_val((mode ? (msec + 50) / 100 : (msec + 200) / 400),
+			 1, 255);
 }
 
 static unsigned int fan_from_reg8(u16 reg, unsigned int divreg)
@@ -414,8 +414,7 @@ static inline long in_from_reg(u8 reg, u8 nr, const u16 *scale_in)
 
 static inline u8 in_to_reg(u32 val, u8 nr, const u16 *scale_in)
 {
-	return SENSORS_LIMIT(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0,
-			     255);
+	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0, 255);
 }
 
 /*
@@ -1267,7 +1266,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
@@ -1435,7 +1434,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = val;
@@ -1514,7 +1513,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -1540,7 +1539,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = SENSORS_LIMIT(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
 
 	mutex_lock(&data->update_lock);
 	if (sio_data->kind = nct6775 || sio_data->kind = nct6776) {
@@ -1639,7 +1638,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	err = kstrtoul(buf, 10, &val); \
 	if (err < 0) \
 		return err; \
-	val = SENSORS_LIMIT(val, 1, 255); \
+	val = clamp_val(val, 1, 255); \
 	mutex_lock(&data->update_lock); \
 	data->reg[nr] = val; \
 	w83627ehf_write_value(data, data->REG_##REG[nr], val); \
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 81f4865..3b9ef2d 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -254,16 +254,15 @@ static const u8 BIT_SCFG2[] = { 0x10, 0x20, 0x40 };
  * these macros are called: arguments may be evaluated more than once.
  * Fixing this is just not worth it.
  */
-#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
+#define IN_TO_REG(val)  (clamp_val((((val) + 8) / 16), 0, 255))
 #define IN_FROM_REG(val) ((val) * 16)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
-			     254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 #define TEMP_MIN (-128000)
@@ -275,9 +274,9 @@ static inline u8 FAN_TO_REG(long rpm, int div)
  */
 static u8 TEMP_TO_REG(long temp)
 {
-        int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
-        ntemp += (ntemp<0 ? -500 : 500);
-        return (u8)(ntemp / 1000);
+	int ntemp = clamp_val(temp, TEMP_MIN, TEMP_MAX);
+	ntemp += (ntemp < 0 ? -500 : 500);
+	return (u8)(ntemp / 1000);
 }
 
 static int TEMP_FROM_REG(u8 reg)
@@ -287,7 +286,7 @@ static int TEMP_FROM_REG(u8 reg)
 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
 
-#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
+#define PWM_TO_REG(val) (clamp_val((val), 0, 255))
 
 static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
 {
@@ -342,7 +341,7 @@ static inline u8 pwm_freq_to_reg(unsigned long val)
 static inline u8 DIV_TO_REG(long val)
 {
 	int i;
-	val = SENSORS_LIMIT(val, 1, 128) >> 1;
+	val = clamp_val(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
@@ -614,8 +613,7 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
 
 		/* use VRM9 calculation */
 		data->in_min[0] -			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
-					255);
+			clamp_val(((val * 100) - 70000 + 244) / 488, 0, 255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
@@ -644,8 +642,7 @@ static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *a
 		
 		/* use VRM9 calculation */
 		data->in_max[0] -			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
-					255);
+			clamp_val(((val * 100) - 70000 + 244) / 488, 0, 255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_max[0] = IN_TO_REG(val);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 93bd286..aeec5b1 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -159,7 +159,7 @@ static const u8 BIT_SCFG2[] = { 0x10, 0x20, 0x40 };
 #define W83781D_DEFAULT_BETA		3435
 
 /* Conversions */
-#define IN_TO_REG(val)			SENSORS_LIMIT(((val) + 8) / 16, 0, 255)
+#define IN_TO_REG(val)			clamp_val(((val) + 8) / 16, 0, 255)
 #define IN_FROM_REG(val)		((val) * 16)
 
 static inline u8
@@ -167,8 +167,8 @@ FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 static inline long
@@ -181,7 +181,7 @@ FAN_FROM_REG(u8 val, int div)
 	return 1350000 / (val * div);
 }
 
-#define TEMP_TO_REG(val)		SENSORS_LIMIT((val) / 1000, -127, 128)
+#define TEMP_TO_REG(val)		clamp_val((val) / 1000, -127, 128)
 #define TEMP_FROM_REG(val)		((val) * 1000)
 
 #define BEEP_MASK_FROM_REG(val, type)	((type) = as99127f ? \
@@ -195,9 +195,8 @@ static inline u8
 DIV_TO_REG(long val, enum chips type)
 {
 	int i;
-	val = SENSORS_LIMIT(val, 1,
-			    ((type = w83781d
-			      || type = as99127f) ? 8 : 128)) >> 1;
+	val = clamp_val(val, 1,
+			((type = w83781d || type = as99127f) ? 8 : 128)) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
@@ -443,7 +442,7 @@ store_vrm_reg(struct device *dev, struct device_attribute *attr,
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
-	data->vrm = SENSORS_LIMIT(val, 0, 255);
+	data->vrm = clamp_val(val, 0, 255);
 
 	return count;
 }
@@ -730,7 +729,7 @@ store_pwm(struct device *dev, struct device_attribute *da, const char *buf,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	data->pwm[nr] = clamp_val(val, 0, 255);
 	w83781d_write_value(data, W83781D_REG_PWM[nr], data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index ed397c6..38ddddd 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -220,15 +220,15 @@ static inline int w83791d_write(struct i2c_client *client, u8 reg, u8 value)
  * in mV as would be measured on the chip input pin, need to just
  * multiply/divide by 16 to translate from/to register values.
  */
-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 8) / 16), 0, 255))
+#define IN_TO_REG(val)		(clamp_val((((val) + 8) / 16), 0, 255))
 #define IN_FROM_REG(val)	((val) * 16)
 
 static u8 fan_to_reg(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 #define FAN_FROM_REG(val, div)	((val) = 0 ? -1 : \
@@ -273,7 +273,7 @@ static u8 div_to_reg(int nr, long val)
 	int i;
 
 	/* fan divisors max out at 128 */
-	val = SENSORS_LIMIT(val, 1, 128) >> 1;
+	val = clamp_val(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
@@ -747,7 +747,7 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
+	data->pwm[nr] = clamp_val(val, 0, 255);
 	w83791d_write(client, W83791D_REG_PWM[nr], data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 301942d..5cb83dd 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -235,8 +235,8 @@ FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 #define FAN_FROM_REG(val, div)	((val) = 0   ? -1 : \
@@ -244,16 +244,15 @@ FAN_TO_REG(long rpm, int div)
 						1350000 / ((val) * (div))))
 
 /* for temp1 */
-#define TEMP1_TO_REG(val)	(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
-					: (val)) / 1000, 0, 0xff))
+#define TEMP1_TO_REG(val)	(clamp_val(((val) < 0 ? (val) + 0x100 * 1000 \
+						      : (val)) / 1000, 0, 0xff))
 #define TEMP1_FROM_REG(val)	(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
 /* for temp2 and temp3, because they need additional resolution */
 #define TEMP_ADD_FROM_REG(val1, val2) \
 	((((val1) & 0x80 ? (val1)-0x100 \
 		: (val1)) * 1000) + ((val2 & 0x80) ? 500 : 0))
 #define TEMP_ADD_TO_REG_HIGH(val) \
-	(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
-			: (val)) / 1000, 0, 0xff))
+	(clamp_val(((val) < 0 ? (val) + 0x100 * 1000 : (val)) / 1000, 0, 0xff))
 #define TEMP_ADD_TO_REG_LOW(val)	((val%1000) ? 0x80 : 0x00)
 
 #define DIV_FROM_REG(val)		(1 << (val))
@@ -262,7 +261,7 @@ static inline u8
 DIV_TO_REG(long val)
 {
 	int i;
-	val = SENSORS_LIMIT(val, 1, 128) >> 1;
+	val = clamp_val(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
@@ -397,7 +396,7 @@ static ssize_t store_in_##reg(struct device *dev, \
 	if (err) \
 		return err; \
 	mutex_lock(&data->update_lock); \
-	data->in_##reg[nr] = SENSORS_LIMIT(IN_TO_REG(nr, val) / 4, 0, 255); \
+	data->in_##reg[nr] = clamp_val(IN_TO_REG(nr, val) / 4, 0, 255); \
 	w83792d_write_value(client, W83792D_REG_IN_##REG[nr], \
 			    data->in_##reg[nr]); \
 	mutex_unlock(&data->update_lock); \
@@ -645,7 +644,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
-	val = SENSORS_LIMIT(val, 0, 255) >> 4;
+	val = clamp_val(val, 0, 255) >> 4;
 
 	mutex_lock(&data->update_lock);
 	val |= w83792d_read_value(client, W83792D_REG_PWM[nr]) & 0xf0;
@@ -799,7 +798,7 @@ store_thermal_cruise(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	target_mask = w83792d_read_value(client,
 					 W83792D_REG_THERMAL[nr]) & 0x80;
-	data->thermal_cruise[nr] = SENSORS_LIMIT(target_tmp, 0, 255);
+	data->thermal_cruise[nr] = clamp_val(target_tmp, 0, 255);
 	w83792d_write_value(client, W83792D_REG_THERMAL[nr],
 		(data->thermal_cruise[nr]) | target_mask);
 	mutex_unlock(&data->update_lock);
@@ -837,7 +836,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	tol_mask = w83792d_read_value(client,
 		W83792D_REG_TOLERANCE[nr]) & ((nr = 1) ? 0x0f : 0xf0);
-	tol_tmp = SENSORS_LIMIT(val, 0, 15);
+	tol_tmp = clamp_val(val, 0, 15);
 	tol_tmp &= 0x0f;
 	data->tolerance[nr] = tol_tmp;
 	if (nr = 1)
@@ -881,7 +880,7 @@ store_sf2_point(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->sf2_points[index][nr] = SENSORS_LIMIT(val, 0, 127);
+	data->sf2_points[index][nr] = clamp_val(val, 0, 127);
 	mask_tmp = w83792d_read_value(client,
 					W83792D_REG_POINTS[index][nr]) & 0x80;
 	w83792d_write_value(client, W83792D_REG_POINTS[index][nr],
@@ -923,7 +922,7 @@ store_sf2_level(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->sf2_levels[index][nr] = SENSORS_LIMIT((val * 15) / 100, 0, 15);
+	data->sf2_levels[index][nr] = clamp_val((val * 15) / 100, 0, 15);
 	mask_tmp = w83792d_read_value(client, W83792D_REG_LEVELS[index][nr])
 		& ((nr = 3) ? 0xf0 : 0x0f);
 	if (nr = 3)
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 99799fd..6604275 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -191,7 +191,7 @@ static inline u16 FAN_TO_REG(long rpm)
 {
 	if (rpm <= 0)
 		return 0x0fff;
-	return SENSORS_LIMIT((1350000 + (rpm >> 1)) / rpm, 1, 0xffe);
+	return clamp_val((1350000 + (rpm >> 1)) / rpm, 1, 0xffe);
 }
 
 static inline unsigned long TIME_FROM_REG(u8 reg)
@@ -201,7 +201,7 @@ static inline unsigned long TIME_FROM_REG(u8 reg)
 
 static inline u8 TIME_TO_REG(unsigned long val)
 {
-	return SENSORS_LIMIT((val + 50) / 100, 0, 0xff);
+	return clamp_val((val + 50) / 100, 0, 0xff);
 }
 
 static inline long TEMP_FROM_REG(s8 reg)
@@ -211,7 +211,7 @@ static inline long TEMP_FROM_REG(s8 reg)
 
 static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
 {
-	return SENSORS_LIMIT((val + (val < 0 ? -500 : 500)) / 1000, min, max);
+	return clamp_val((val + (val < 0 ? -500 : 500)) / 1000, min, max);
 }
 
 struct w83793_data {
@@ -558,7 +558,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 		w83793_write_value(client, W83793_REG_PWM_STOP_TIME(index),
 				   val);
 	} else {
-		val = SENSORS_LIMIT(val, 0, 0xff) >> 2;
+		val = clamp_val(val, 0, 0xff) >> 2;
 		data->pwm[index][nr]  		    w83793_read_value(client, W83793_REG_PWM(index, nr)) & 0xc0;
 		data->pwm[index][nr] |= val;
@@ -739,7 +739,7 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 	if (nr = SETUP_PWM_DEFAULT) {
 		data->pwm_default  		    w83793_read_value(client, W83793_REG_PWM_DEFAULT) & 0xc0;
-		data->pwm_default |= SENSORS_LIMIT(val, 0, 0xff) >> 2;
+		data->pwm_default |= clamp_val(val, 0, 0xff) >> 2;
 		w83793_write_value(client, W83793_REG_PWM_DEFAULT,
 							data->pwm_default);
 	} else if (nr = SETUP_PWM_UPTIME) {
@@ -838,7 +838,7 @@ store_sf_ctrl(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	if (nr = TEMP_FAN_MAP) {
-		val = SENSORS_LIMIT(val, 0, 255);
+		val = clamp_val(val, 0, 255);
 		w83793_write_value(client, W83793_REG_TEMP_FAN_MAP(index), val);
 		data->temp_fan_map[index] = val;
 	} else if (nr = TEMP_PWM_ENABLE) {
@@ -907,7 +907,7 @@ store_sf2_pwm(struct device *dev, struct device_attribute *attr,
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
-	val = SENSORS_LIMIT(val, 0, 0xff) >> 2;
+	val = clamp_val(val, 0, 0xff) >> 2;
 
 	mutex_lock(&data->update_lock);
 	data->sf2_pwm[index][nr] @@ -1003,9 +1003,9 @@ store_in(struct device *dev, struct device_attribute *attr,
 		/* fix the limit values of 5VDD and 5VSB to ALARM mechanism */
 		if (nr = 1 || nr = 2)
 			val -= scale_in_add[index] / scale_in[index];
-		val = SENSORS_LIMIT(val, 0, 255);
+		val = clamp_val(val, 0, 255);
 	} else {
-		val = SENSORS_LIMIT(val, 0, 0x3FF);
+		val = clamp_val(val, 0, 0x3FF);
 		data->in_low_bits[nr]  		    w83793_read_value(client, W83793_REG_IN_LOW_BITS[nr]);
 		data->in_low_bits[nr] &= ~(0x03 << (2 * index));
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 55a4f48..e226096 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -262,7 +262,7 @@ static inline u16 fan_to_reg(long rpm)
 {
 	if (rpm <= 0)
 		return 0x0fff;
-	return SENSORS_LIMIT((1350000 + (rpm >> 1)) / rpm, 1, 0xffe);
+	return clamp_val((1350000 + (rpm >> 1)) / rpm, 1, 0xffe);
 }
 
 static inline unsigned long time_from_reg(u8 reg)
@@ -272,7 +272,7 @@ static inline unsigned long time_from_reg(u8 reg)
 
 static inline u8 time_to_reg(unsigned long val)
 {
-	return SENSORS_LIMIT((val + 50) / 100, 0, 0xff);
+	return clamp_val((val + 50) / 100, 0, 0xff);
 }
 
 static inline long temp_from_reg(s8 reg)
@@ -282,7 +282,7 @@ static inline long temp_from_reg(s8 reg)
 
 static inline s8 temp_to_reg(long val, s8 min, s8 max)
 {
-	return SENSORS_LIMIT(val / 1000, min, max);
+	return clamp_val(val / 1000, min, max);
 }
 
 static const u16 pwm_freq_cksel0[16] = {
@@ -319,7 +319,7 @@ static u8 pwm_freq_to_reg(unsigned long val, u16 clkin)
 
 	/* Best fit for cksel = 1 */
 	base_clock = clkin * 1000 / ((clkin = 48000) ? 384 : 256);
-	reg1 = SENSORS_LIMIT(DIV_ROUND_CLOSEST(base_clock, val), 1, 128);
+	reg1 = clamp_val(DIV_ROUND_CLOSEST(base_clock, val), 1, 128);
 	best1 = base_clock / reg1;
 	reg1 = 0x80 | (reg1 - 1);
 
@@ -889,7 +889,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 		val = pwm_freq_to_reg(val, data->clkin);
 		break;
 	default:
-		val = SENSORS_LIMIT(val, 0, 0xff);
+		val = clamp_val(val, 0, 0xff);
 		break;
 	}
 	w83795_write(client, W83795_REG_PWM(index, nr), val);
@@ -1126,7 +1126,7 @@ store_temp_pwm_enable(struct device *dev, struct device_attribute *attr,
 		break;
 	case TEMP_PWM_FAN_MAP:
 		mutex_lock(&data->update_lock);
-		tmp = SENSORS_LIMIT(tmp, 0, 0xff);
+		tmp = clamp_val(tmp, 0, 0xff);
 		w83795_write(client, W83795_REG_TFMR(index), tmp);
 		data->pwm_tfmr[index] = tmp;
 		mutex_unlock(&data->update_lock);
@@ -1177,13 +1177,13 @@ store_fanin(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	switch (nr) {
 	case FANIN_TARGET:
-		val = fan_to_reg(SENSORS_LIMIT(val, 0, 0xfff));
+		val = fan_to_reg(clamp_val(val, 0, 0xfff));
 		w83795_write(client, W83795_REG_FTSH(index), val >> 4);
 		w83795_write(client, W83795_REG_FTSL(index), (val << 4) & 0xf0);
 		data->target_speed[index] = val;
 		break;
 	case FANIN_TOL:
-		val = SENSORS_LIMIT(val, 0, 0x3f);
+		val = clamp_val(val, 0, 0x3f);
 		w83795_write(client, W83795_REG_TFTS, val);
 		data->tol_speed = val;
 		break;
@@ -1227,22 +1227,22 @@ store_temp_pwm(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	switch (nr) {
 	case TEMP_PWM_TTTI:
-		val = SENSORS_LIMIT(val, 0, 0x7f);
+		val = clamp_val(val, 0, 0x7f);
 		w83795_write(client, W83795_REG_TTTI(index), val);
 		break;
 	case TEMP_PWM_CTFS:
-		val = SENSORS_LIMIT(val, 0, 0x7f);
+		val = clamp_val(val, 0, 0x7f);
 		w83795_write(client, W83795_REG_CTFS(index), val);
 		break;
 	case TEMP_PWM_HCT:
-		val = SENSORS_LIMIT(val, 0, 0x0f);
+		val = clamp_val(val, 0, 0x0f);
 		tmp = w83795_read(client, W83795_REG_HT(index));
 		tmp &= 0x0f;
 		tmp |= (val << 4) & 0xf0;
 		w83795_write(client, W83795_REG_HT(index), tmp);
 		break;
 	case TEMP_PWM_HOT:
-		val = SENSORS_LIMIT(val, 0, 0x0f);
+		val = clamp_val(val, 0, 0x0f);
 		tmp = w83795_read(client, W83795_REG_HT(index));
 		tmp &= 0xf0;
 		tmp |= val & 0x0f;
@@ -1541,7 +1541,7 @@ store_in(struct device *dev, struct device_attribute *attr,
 	if ((index >= 17) &&
 	    !((data->has_gain >> (index - 17)) & 1))
 		val /= 8;
-	val = SENSORS_LIMIT(val, 0, 0x3FF);
+	val = clamp_val(val, 0, 0x3FF);
 	mutex_lock(&data->update_lock);
 
 	lsb_idx = IN_LSB_SHIFT_IDX[index][IN_LSB_IDX];
@@ -1596,7 +1596,7 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 
 	switch (nr) {
 	case SETUP_PWM_DEFAULT:
-		val = SENSORS_LIMIT(val, 0, 0xff);
+		val = clamp_val(val, 0, 0xff);
 		break;
 	case SETUP_PWM_UPTIME:
 	case SETUP_PWM_DOWNTIME:
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 79710bc..edb06cd 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -86,8 +86,8 @@ FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+	rpm = clamp_val(rpm, 1, 1000000);
+	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
 #define FAN_FROM_REG(val, div)	((val) = 0   ? -1 : \
@@ -95,9 +95,8 @@ FAN_TO_REG(long rpm, int div)
 				1350000 / ((val) * (div))))
 
 /* for temp */
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT(((val) < 0 ? \
-						(val) + 0x100 * 1000 \
-						: (val)) / 1000, 0, 0xff))
+#define TEMP_TO_REG(val)	(clamp_val(((val) < 0 ? (val) + 0x100 * 1000 \
+						      : (val)) / 1000, 0, 0xff))
 #define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
 				  (val) - 0x100 : (val)) * 1000)
 
@@ -106,7 +105,7 @@ FAN_TO_REG(long rpm, int div)
  * in mV as would be measured on the chip input pin, need to just
  * multiply/divide by 8 to translate from/to register values.
  */
-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val) + 4) / 8), 0, 255))
+#define IN_TO_REG(val)		(clamp_val((((val) + 4) / 8), 0, 255))
 #define IN_FROM_REG(val)	((val) * 8)
 
 #define DIV_FROM_REG(val)	(1 << (val))
@@ -115,7 +114,7 @@ static inline u8
 DIV_TO_REG(long val)
 {
 	int i;
-	val = SENSORS_LIMIT(val, 1, 128) >> 1;
+	val = clamp_val(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
@@ -481,7 +480,7 @@ store_pwm(struct device *dev, struct device_attribute *attr,
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
-	val = SENSORS_LIMIT(val, 0, 255);
+	val = clamp_val(val, 0, 255);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = val;
@@ -564,7 +563,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	tol_mask = w83l786ng_read_value(client,
 	    W83L786NG_REG_TOLERANCE) & ((nr = 1) ? 0x0f : 0xf0);
-	tol_tmp = SENSORS_LIMIT(val, 0, 15);
+	tol_tmp = clamp_val(val, 0, 15);
 	tol_tmp &= 0x0f;
 	data->tolerance[nr] = tol_tmp;
 	if (nr = 1)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
