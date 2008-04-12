From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 18:06:29 +0000
Subject: [lm-sensors] [PATCH 10/10] hwmon: (lm85) Support different PWM
Message-Id: <20080412200629.0e6b7ecb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Analog Devices and SMSC devices supported by the lm85 driver do
not have the same PWM frequency table as the National Semiconductor
devices. Add support for per-device frequency tables.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 19:28:40.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 22:49:57.000000000 +0200
@@ -5,6 +5,7 @@
     Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
     Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
     Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
+    Copyright (C) 2007, 2008  Jean Delvare <khali@linux-fr.org>
 
     Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
 
@@ -195,19 +196,21 @@ static int RANGE_TO_REG(int range)
 static const int lm85_freq_map[8] = { /* 1 Hz */
 	10, 15, 23, 30, 38, 47, 62, 94
 };
+static const int adm1027_freq_map[8] = { /* 1 Hz */
+	11, 15, 22, 29, 35, 44, 59, 88
+};
 
-static int FREQ_TO_REG(int freq)
+static int FREQ_TO_REG(const int *map, int freq)
 {
 	int i;
 
-	if (freq >= lm85_freq_map[7])
+	if (freq >= map[7])
 		return 7;
 
 	/* Find the closest match */
 	for (i = 6; i >= 0; --i) {
-		if (freq >= lm85_freq_map[i]) {
-			if ((lm85_freq_map[i + 1] - freq) <
-					(freq - lm85_freq_map[i]))
+		if (freq >= map[i]) {
+			if ((map[i + 1] - freq) < (freq - map[i]))
 				return i + 1;
 			return i;
 		}
@@ -215,7 +218,11 @@ static int FREQ_TO_REG(int freq)
 
 	return 0;
 }
-#define FREQ_FROM_REG(val)	lm85_freq_map[(val) & 0x07]
+
+static int FREQ_FROM_REG(const int *map, u8 reg)
+{
+	return map[reg & 0x07];
+}
 
 /* Since we can't use strings, I'm abusing these numbers
  *   to stand in for the following meanings:
@@ -293,6 +300,7 @@ struct lm85_autofan {
 struct lm85_data {
 	struct i2c_client client;
 	struct device *hwmon_dev;
+	const int *freq_map;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -542,7 +550,8 @@ static ssize_t show_pwm_freq(struct devi
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", FREQ_FROM_REG(data->pwm_freq[nr]));
+	return sprintf(buf, "%d\n", FREQ_FROM_REG(data->freq_map,
+						  data->pwm_freq[nr]));
 }
 
 static ssize_t set_pwm_freq(struct device *dev,
@@ -554,7 +563,7 @@ static ssize_t set_pwm_freq(struct devic
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->pwm_freq[nr] = FREQ_TO_REG(val);
+	data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		(data->zone[nr].range << 4)
 		| data->pwm_freq[nr]);
@@ -1198,24 +1207,31 @@ static int lm85_detect(struct i2c_adapte
 	switch (kind) {
 	case lm85b:
 		type_name = "lm85b";
+		data->freq_map = lm85_freq_map;
 		break;
 	case lm85c:
 		type_name = "lm85c";
+		data->freq_map = lm85_freq_map;
 		break;
 	case adm1027:
 		type_name = "adm1027";
+		data->freq_map = adm1027_freq_map;
 		break;
 	case adt7463:
 		type_name = "adt7463";
+		data->freq_map = adm1027_freq_map;
 		break;
 	case emc6d100:
 		type_name = "emc6d100";
+		data->freq_map = adm1027_freq_map;
 		break;
 	case emc6d102:
 		type_name = "emc6d102";
+		data->freq_map = adm1027_freq_map;
 		break;
 	default:
 		type_name = "lm85";
+		data->freq_map = lm85_freq_map;
 	}
 	strlcpy(client->name, type_name, I2C_NAME_SIZE);
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
