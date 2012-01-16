From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:23 +0000
Subject: [lm-sensors] [PATCH 21/39] hwmon: (lm93) Fix checkpatch issues
Message-Id: <1326703781-14272-22-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: else should follow close brace '}'
ERROR: space prohibited after that open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<=' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxW)
ERROR: trailing statements should be on next line
WARNING: braces {} are not necessary for any arm of this statement
WARNING: do not add new typedefs
WARNING: please, no space before tabs
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (unknown impact):
WARNING: msleep < 20ms can sleep for up to 20ms

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm93.c |  408 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 267 insertions(+), 141 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 3b43df4..6e9e0b5 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -18,10 +18,10 @@
 	Copyright (c) 2005 Aspen Systems, Inc.
 
     Adapted to 2.6.20 by Carsten Emde <cbe@osadl.org>
-        Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
+	Copyright (c) 2006 Carsten Emde, Open Source Automation Development Lab
 
     Modified for mainline integration by Hans J. Koch <hjk@hansjkoch.de>
-        Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
+	Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -83,7 +83,7 @@
 #define LM93_REG_FAN_MIN(nr)		(0xb4 + (nr) * 2)
 
 /* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
-#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
+#define LM93_REG_PWM_CTL(nr, reg)	(0xc8 + (reg) + (nr) * 4)
 #define LM93_PWM_CTL1	0x0
 #define LM93_PWM_CTL2	0x1
 #define LM93_PWM_CTL3	0x2
@@ -160,7 +160,7 @@ static int init;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to non-zero to force chip initialization.");
 
-static int vccp_limit_type[2] = {0,0};
+static int vccp_limit_type[2] = {0, 0};
 module_param_array(vccp_limit_type, int, NULL, 0);
 MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes.");
 
@@ -386,8 +386,8 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
 	return (uV_vid + uV_offset + 5000) / 10000;
 }
 
-#define LM93_IN_MIN_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,0,vid)
-#define LM93_IN_MAX_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,1,vid)
+#define LM93_IN_MIN_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 0, (vid))
+#define LM93_IN_MAX_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 1, (vid))
 
 /* vid in mV , upper = 0 indicates low limit, otherwise upper limit
    upper also determines which nibble of the register is returned
@@ -412,14 +412,14 @@ static int LM93_TEMP_FROM_REG(u8 reg)
 }
 
 #define LM93_TEMP_MIN (-128000)
-#define LM93_TEMP_MAX ( 127000)
+#define LM93_TEMP_MAX (127000)
 
 /* TEMP: 1/1000 degrees C (-128C to +127C)
    REG: 1C/bit, two's complement */
 static u8 LM93_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
-	ntemp += (ntemp<0 ? -500 : 500);
+	ntemp += (ntemp < 0 ? -500 : 500);
 	return (u8)(ntemp / 1000);
 }
 
@@ -438,9 +438,9 @@ static int LM93_TEMP_OFFSET_FROM_REG(u8 reg, int mode)
 	return (reg & 0x0f) * (mode ? 5 : 10);
 }
 
-#define LM93_TEMP_OFFSET_MIN  (  0)
+#define LM93_TEMP_OFFSET_MIN  (0)
 #define LM93_TEMP_OFFSET_MAX0 (150)
-#define LM93_TEMP_OFFSET_MAX1 ( 75)
+#define LM93_TEMP_OFFSET_MAX1 (75)
 
 /* This function is common to all 4-bit temperature offsets
    returns 4 bits right justified
@@ -534,7 +534,8 @@ static u8 LM93_AUTO_BOOST_HYST_TO_REG(struct lm93_data *data, long hyst,
 
 /* PWM: 0-255 per sensors documentation
    REG: 0-13 as mapped below... right justified */
-typedef enum { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ } pwm_freq_t;
+enum pwm_freq { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ };
+
 static int lm93_pwm_map[2][16] = {
 	{
 		0x00, /*   0.00% */ 0x40, /*  25.00% */
@@ -558,13 +559,13 @@ static int lm93_pwm_map[2][16] = {
 	},
 };
 
-static int LM93_PWM_FROM_REG(u8 reg, pwm_freq_t freq)
+static int LM93_PWM_FROM_REG(u8 reg, enum pwm_freq freq)
 {
 	return lm93_pwm_map[freq][reg & 0x0f];
 }
 
 /* round up to nearest match */
-static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
+static u8 LM93_PWM_TO_REG(int pwm, enum pwm_freq freq)
 {
 	int i;
 	for (i = 0; i < 13; i++)
@@ -578,7 +579,7 @@ static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
 static int LM93_FAN_FROM_REG(u16 regs)
 {
 	const u16 count = le16_to_cpu(regs) >> 2;
-	return count=0 ? -1 : count=0x3fff ? 0: 1350000 / count;
+	return count = 0 ? -1 : count = 0x3fff ? 0 : 1350000 / count;
 }
 
 /*
@@ -772,11 +773,12 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 	int value, i;
 
 	/* retry in case of read errors */
-	for (i=1; i<=MAX_RETRIES; i++) {
-		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_byte_data(client, reg);
+		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev,"lm93: read byte data failed, "
+			dev_warn(&client->dev, "lm93: read byte data failed, "
 				"address 0x%02x.\n", reg);
 			mdelay(i + 3);
 		}
@@ -784,7 +786,7 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 	}
 
 	/* <TODO> what to return in case of error? */
-	dev_err(&client->dev,"lm93: All read byte retries failed!!\n");
+	dev_err(&client->dev, "lm93: All read byte retries failed!!\n");
 	return 0;
 }
 
@@ -796,7 +798,7 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
 	result = i2c_smbus_write_byte_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev,"lm93: write byte data failed, "
+		dev_warn(&client->dev, "lm93: write byte data failed, "
 			 "0x%02x at address 0x%02x.\n", value, reg);
 
 	return result;
@@ -807,11 +809,12 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 	int value, i;
 
 	/* retry in case of read errors */
-	for (i=1; i<=MAX_RETRIES; i++) {
-		if ((value = i2c_smbus_read_word_data(client, reg)) >= 0) {
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_word_data(client, reg);
+		if (value >= 0) {
 			return value;
 		} else {
-			dev_warn(&client->dev,"lm93: read word data failed, "
+			dev_warn(&client->dev, "lm93: read word data failed, "
 				 "address 0x%02x.\n", reg);
 			mdelay(i + 3);
 		}
@@ -819,7 +822,7 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 	}
 
 	/* <TODO> what to return in case of error? */
-	dev_err(&client->dev,"lm93: All read word retries failed!!\n");
+	dev_err(&client->dev, "lm93: All read word retries failed!!\n");
 	return 0;
 }
 
@@ -831,7 +834,7 @@ static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
 	result = i2c_smbus_write_word_data(client, reg, value);
 
 	if (result < 0)
-		dev_warn(&client->dev,"lm93: write word data failed, "
+		dev_warn(&client->dev, "lm93: write word data failed, "
 			 "0x%04x at address 0x%02x.\n", value, reg);
 
 	return result;
@@ -846,7 +849,7 @@ static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
 */
 static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 {
-	int i, result=0;
+	int i, result = 0;
 
 	for (i = 1; i <= MAX_RETRIES; i++) {
 		result = i2c_smbus_read_block_data(client,
@@ -855,18 +858,18 @@ static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
 		if (result = lm93_block_read_cmds[fbn].len) {
 			break;
 		} else {
-			dev_warn(&client->dev,"lm93: block read data failed, "
+			dev_warn(&client->dev, "lm93: block read data failed, "
 				 "command 0x%02x.\n",
 				 lm93_block_read_cmds[fbn].cmd);
 			mdelay(i + 3);
 		}
 	}
 
-	if (result = lm93_block_read_cmds[fbn].len) {
-		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
-	} else {
-		/* <TODO> what to do in case of error? */
-	}
+	if (result = lm93_block_read_cmds[fbn].len)
+		memcpy(values, lm93_block_buffer,
+		       lm93_block_read_cmds[fbn].len);
+
+	/* <TODO> what to do in case of error? */
 }
 
 static struct lm93_data *lm93_update_device(struct device *dev)
@@ -964,7 +967,7 @@ static void lm93_update_client_common(struct lm93_data *data,
 static void lm93_update_client_full(struct lm93_data *data,
 				    struct i2c_client *client)
 {
-	dev_dbg(&client->dev,"starting device update (block data enabled)\n");
+	dev_dbg(&client->dev, "starting device update (block data enabled)\n");
 
 	/* in1 - in16: values & limits */
 	lm93_read_block(client, 3, (u8 *)(data->block3));
@@ -996,10 +999,10 @@ static void lm93_update_client_full(struct lm93_data *data,
 static void lm93_update_client_min(struct lm93_data *data,
 				   struct i2c_client *client)
 {
-	int i,j;
+	int i, j;
 	u8 *ptr;
 
-	dev_dbg(&client->dev,"starting device update (block data disabled)\n");
+	dev_dbg(&client->dev, "starting device update (block data disabled)\n");
 
 	/* in1 - in16: values & limits */
 	for (i = 0; i < 16; i++) {
@@ -1037,7 +1040,7 @@ static void lm93_update_client_min(struct lm93_data *data,
 	for (i = 0; i < 2; i++) {
 		for (j = 0; j < 4; j++) {
 			data->block9[i][j] -				lm93_read_byte(client, LM93_REG_PWM_CTL(i,j));
+				lm93_read_byte(client, LM93_REG_PWM_CTL(i, j));
 		}
 	}
 
@@ -1097,14 +1100,13 @@ static ssize_t show_in_min(struct device *dev,
 	int vccp = nr - 6;
 	long rc, vid;
 
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		rc = LM93_IN_MIN_FROM_REG(data->vccp_limits[vccp], vid);
+	} else {
+		rc = LM93_IN_FROM_REG(nr, data->block7[nr].min);
 	}
-	else {
-		rc = LM93_IN_FROM_REG(nr, data->block7[nr].min); \
-	}
-	return sprintf(buf, "%ld\n", rc); \
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
@@ -1113,20 +1115,24 @@ static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	int vccp = nr - 6;
 	long vid;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0xf0) |
 				LM93_IN_REL_TO_REG(val, 0, vid);
 		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
 				data->vccp_limits[vccp]);
-	}
-	else {
-		data->block7[nr].min = LM93_IN_TO_REG(nr,val);
+	} else {
+		data->block7[nr].min = LM93_IN_TO_REG(nr, val);
 		lm93_write_byte(client, LM93_REG_IN_MIN(nr),
 				data->block7[nr].min);
 	}
@@ -1175,14 +1181,13 @@ static ssize_t show_in_max(struct device *dev,
 	int vccp = nr - 6;
 	long rc, vid;
 
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
-		rc = LM93_IN_MAX_FROM_REG(data->vccp_limits[vccp],vid);
-	}
-	else {
-		rc = LM93_IN_FROM_REG(nr,data->block7[nr].max); \
+		rc = LM93_IN_MAX_FROM_REG(data->vccp_limits[vccp], vid);
+	} else {
+		rc = LM93_IN_FROM_REG(nr, data->block7[nr].max);
 	}
-	return sprintf(buf,"%ld\n",rc); \
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
@@ -1191,20 +1196,24 @@ static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	int vccp = nr - 6;
 	long vid;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	if ((nr=6 || nr=7) && (vccp_limit_type[vccp])) {
+	if ((nr = 6 || nr = 7) && vccp_limit_type[vccp]) {
 		vid = LM93_VID_FROM_REG(data->vid[vccp]);
 		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0x0f) |
 				LM93_IN_REL_TO_REG(val, 1, vid);
 		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
 				data->vccp_limits[vccp]);
-	}
-	else {
-		data->block7[nr].max = LM93_IN_TO_REG(nr,val);
+	} else {
+		data->block7[nr].max = LM93_IN_TO_REG(nr, val);
 		lm93_write_byte(client, LM93_REG_IN_MAX(nr),
 				data->block7[nr].max);
 	}
@@ -1250,7 +1259,7 @@ static ssize_t show_temp(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block2[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block2[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
@@ -1262,7 +1271,7 @@ static ssize_t show_temp_min(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
 }
 
 static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
@@ -1271,7 +1280,12 @@ static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].min = LM93_TEMP_TO_REG(val);
@@ -1292,7 +1306,7 @@ static ssize_t show_temp_max(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
 }
 
 static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
@@ -1301,7 +1315,12 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].max = LM93_TEMP_TO_REG(val);
@@ -1322,7 +1341,7 @@ static ssize_t show_temp_auto_base(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block10.base[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block10.base[nr]));
 }
 
 static ssize_t store_temp_auto_base(struct device *dev,
@@ -1332,7 +1351,12 @@ static ssize_t store_temp_auto_base(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
@@ -1349,11 +1373,11 @@ static SENSOR_DEVICE_ATTR(temp3_auto_base, S_IWUSR | S_IRUGO,
 			  show_temp_auto_base, store_temp_auto_base, 2);
 
 static ssize_t show_temp_auto_boost(struct device *dev,
-				    struct device_attribute *attr,char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->boost[nr]));
+	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->boost[nr]));
 }
 
 static ssize_t store_temp_auto_boost(struct device *dev,
@@ -1363,7 +1387,12 @@ static ssize_t store_temp_auto_boost(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->boost[nr] = LM93_TEMP_TO_REG(val);
@@ -1386,7 +1415,7 @@ static ssize_t show_temp_auto_boost_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_AUTO_BOOST_HYST_FROM_REGS(data, nr, mode));
 }
 
@@ -1397,7 +1426,12 @@ static ssize_t store_temp_auto_boost_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1429,9 +1463,9 @@ static ssize_t show_temp_auto_offset(struct device *dev,
 	int ofs = s_attr->nr;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 	       LM93_TEMP_AUTO_OFFSET_FROM_REG(data->block10.offset[ofs],
-					      nr,mode));
+					      nr, mode));
 }
 
 static ssize_t store_temp_auto_offset(struct device *dev,
@@ -1443,7 +1477,12 @@ static ssize_t store_temp_auto_offset(struct device *dev,
 	int ofs = s_attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1539,7 +1578,7 @@ static ssize_t show_temp_auto_pwm_min(struct device *dev,
 	struct lm93_data *data = lm93_update_device(dev);
 	reg = data->auto_pwm_min_hyst[nr/2] >> 4 & 0x0f;
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
+	return sprintf(buf, "%d\n", LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
 				LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }
 
@@ -1550,12 +1589,17 @@ static ssize_t store_temp_auto_pwm_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 reg, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	reg = lm93_read_byte(client, LM93_REG_PWM_MIN_HYST(nr));
-	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
 	reg = (reg & 0x0f) |
 		LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 				LM93_PWM_MAP_LO_FREQ :
@@ -1582,8 +1626,8 @@ static ssize_t show_temp_auto_offset_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
-	return sprintf(buf,"%d\n",LM93_TEMP_OFFSET_FROM_REG(
-					data->auto_pwm_min_hyst[nr/2], mode));
+	return sprintf(buf, "%d\n", LM93_TEMP_OFFSET_FROM_REG(
+					data->auto_pwm_min_hyst[nr / 2], mode));
 }
 
 static ssize_t store_temp_auto_offset_hyst(struct device *dev,
@@ -1593,8 +1637,13 @@ static ssize_t store_temp_auto_offset_hyst(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* force 0.5C/bit mode */
@@ -1626,7 +1675,7 @@ static ssize_t show_fan_input(struct device *dev,
 	int nr = s_attr->index;
 	struct lm93_data *data = lm93_update_device(dev);
 
-	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block5[nr]));
+	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block5[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
@@ -1640,7 +1689,7 @@ static ssize_t show_fan_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 
-	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block8[nr]));
+	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block8[nr]));
 }
 
 static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
@@ -1649,11 +1698,16 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block8[nr] = LM93_FAN_TO_REG(val);
-	lm93_write_word(client,LM93_REG_FAN_MIN(nr),data->block8[nr]);
+	lm93_write_word(client, LM93_REG_FAN_MIN(nr), data->block8[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1694,7 +1748,7 @@ static ssize_t show_fan_smart_tach(struct device *dev,
 	/* if there's a mapping and it's enabled */
 	if (mapping && ((data->sfc2 >> nr) & 0x01))
 		rc = mapping;
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
 }
 
 /* helper function - must grab data->update_lock before calling
@@ -1724,7 +1778,12 @@ static ssize_t store_fan_smart_tach(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* sanity test, ignore the write otherwise */
@@ -1732,7 +1791,7 @@ static ssize_t store_fan_smart_tach(struct device *dev,
 		/* can't enable if pwm freq is 22.5KHz */
 		if (val) {
 			u8 ctl4 = lm93_read_byte(client,
-				LM93_REG_PWM_CTL(val-1,LM93_PWM_CTL4));
+				LM93_REG_PWM_CTL(val - 1, LM93_PWM_CTL4));
 			if ((ctl4 & 0x07) = 0)
 				val = 0;
 		}
@@ -1766,7 +1825,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 	else /* show present h/w value if manual pwm disabled */
 		rc = LM93_PWM_FROM_REG(ctl2 >> 4, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ);
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
@@ -1775,19 +1834,24 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl2, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
-	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
-	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val,(ctl4 & 0x07) ?
+	ctl2 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
+	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ) << 4;
 	/* save user commanded value */
 	data->pwm_override[nr] = LM93_PWM_FROM_REG(ctl2 >> 4,
 			(ctl4 & 0x07) ?  LM93_PWM_MAP_LO_FREQ :
 			LM93_PWM_MAP_HI_FREQ);
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2), ctl2);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1808,7 +1872,7 @@ static ssize_t show_pwm_enable(struct device *dev,
 		rc = ((ctl2 & 0xF0) = 0xF0) ? 0 : 1;
 	else
 		rc = 2;
-	return sprintf(buf,"%ld\n",rc);
+	return sprintf(buf, "%ld\n", rc);
 }
 
 static ssize_t store_pwm_enable(struct device *dev,
@@ -1818,26 +1882,33 @@ static ssize_t store_pwm_enable(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl2;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
+	ctl2 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2));
 
 	switch (val) {
 	case 0:
 		ctl2 |= 0xF1; /* enable manual override, set PWM to max */
 		break;
-	case 1: ctl2 |= 0x01; /* enable manual override */
+	case 1:
+		ctl2 |= 0x01; /* enable manual override */
 		break;
-	case 2: ctl2 &= ~0x01; /* disable manual override */
+	case 2:
+		ctl2 &= ~0x01; /* disable manual override */
 		break;
 	default:
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
 
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL2), ctl2);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1855,7 +1926,7 @@ static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 	u8 ctl4;
 
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",LM93_PWM_FREQ_FROM_REG(ctl4));
+	return sprintf(buf, "%d\n", LM93_PWM_FREQ_FROM_REG(ctl4));
 }
 
 /* helper function - must grab data->update_lock before calling
@@ -1887,17 +1958,22 @@ static ssize_t store_pwm_freq(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
 	ctl4 = (ctl4 & 0xf8) | LM93_PWM_FREQ_TO_REG(val);
 	data->block9[nr][LM93_PWM_CTL4] = ctl4;
 	/* ctl4 = 0 -> 22.5KHz -> disable smart tach */
 	if (!ctl4)
 		lm93_disable_fan_smart_tach(client, data, nr);
-	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4), ctl4);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4), ctl4);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1912,7 +1988,7 @@ static ssize_t show_pwm_auto_channels(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block9[nr][LM93_PWM_CTL1]);
+	return sprintf(buf, "%d\n", data->block9[nr][LM93_PWM_CTL1]);
 }
 
 static ssize_t store_pwm_auto_channels(struct device *dev,
@@ -1922,11 +1998,16 @@ static ssize_t store_pwm_auto_channels(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
-	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL1),
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL1),
 				data->block9[nr][LM93_PWM_CTL1]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1938,7 +2019,7 @@ static SENSOR_DEVICE_ATTR(pwm2_auto_channels, S_IWUSR | S_IRUGO,
 			  show_pwm_auto_channels, store_pwm_auto_channels, 1);
 
 static ssize_t show_pwm_auto_spinup_min(struct device *dev,
-				struct device_attribute *attr,char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
@@ -1946,7 +2027,7 @@ static ssize_t show_pwm_auto_spinup_min(struct device *dev,
 
 	ctl3 = data->block9[nr][LM93_PWM_CTL3];
 	ctl4 = data->block9[nr][LM93_PWM_CTL4];
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_PWM_FROM_REG(ctl3 & 0x0f, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }
@@ -1958,17 +2039,22 @@ static ssize_t store_pwm_auto_spinup_min(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl3, ctl4;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
-	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
-	ctl3 = (ctl3 & 0xf0) | 	LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
+	ctl3 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
+	ctl3 = (ctl3 & 0xf0) | LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
 			LM93_PWM_MAP_LO_FREQ :
 			LM93_PWM_MAP_HI_FREQ);
 	data->block9[nr][LM93_PWM_CTL3] = ctl3;
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1985,7 +2071,7 @@ static ssize_t show_pwm_auto_spinup_time(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_SPINUP_TIME_FROM_REG(
+	return sprintf(buf, "%d\n", LM93_SPINUP_TIME_FROM_REG(
 				data->block9[nr][LM93_PWM_CTL3]));
 }
 
@@ -1996,14 +2082,19 @@ static ssize_t store_pwm_auto_spinup_time(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ctl3;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
-	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl3 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
 	ctl3 = (ctl3 & 0x1f) | (LM93_SPINUP_TIME_TO_REG(val) << 5 & 0xe0);
 	data->block9[nr][LM93_PWM_CTL3] = ctl3;
-	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	lm93_write_byte(client, LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2019,7 +2110,7 @@ static ssize_t show_pwm_auto_prochot_ramp(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl >> 4 & 0x0f));
 }
 
@@ -2029,8 +2120,13 @@ static ssize_t store_pwm_auto_prochot_ramp(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ramp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
@@ -2048,7 +2144,7 @@ static ssize_t show_pwm_auto_vrdhot_ramp(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl & 0x0f));
 }
 
@@ -2058,8 +2154,13 @@ static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 ramp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
@@ -2078,7 +2179,7 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_VID_FROM_REG(data->vid[nr]));
+	return sprintf(buf, "%d\n", LM93_VID_FROM_REG(data->vid[nr]));
 }
 
 static SENSOR_DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL, 0);
@@ -2089,7 +2190,7 @@ static ssize_t show_prochot(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block4[nr].cur);
+	return sprintf(buf, "%d\n", data->block4[nr].cur);
 }
 
 static SENSOR_DEVICE_ATTR(prochot1, S_IRUGO, show_prochot, NULL, 0);
@@ -2100,7 +2201,7 @@ static ssize_t show_prochot_avg(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->block4[nr].avg);
+	return sprintf(buf, "%d\n", data->block4[nr].avg);
 }
 
 static SENSOR_DEVICE_ATTR(prochot1_avg, S_IRUGO, show_prochot_avg, NULL, 0);
@@ -2111,7 +2212,7 @@ static ssize_t show_prochot_max(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->prochot_max[nr]);
+	return sprintf(buf, "%d\n", data->prochot_max[nr]);
 }
 
 static ssize_t store_prochot_max(struct device *dev,
@@ -2121,7 +2222,12 @@ static ssize_t store_prochot_max(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->prochot_max[nr] = LM93_PROCHOT_TO_REG(val);
@@ -2143,7 +2249,7 @@ static ssize_t show_prochot_override(struct device *dev,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
+	return sprintf(buf, "%d\n",
 		(data->prochot_override & prochot_override_mask[nr]) ? 1 : 0);
 }
 
@@ -2154,7 +2260,12 @@ static ssize_t store_prochot_override(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -2178,11 +2289,11 @@ static ssize_t show_prochot_interval(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
 	u8 tmp;
-	if (nr=1)
+	if (nr = 1)
 		tmp = (data->prochot_interval & 0xf0) >> 4;
 	else
 		tmp = data->prochot_interval & 0x0f;
-	return sprintf(buf,"%d\n",LM93_INTERVAL_FROM_REG(tmp));
+	return sprintf(buf, "%d\n", LM93_INTERVAL_FROM_REG(tmp));
 }
 
 static ssize_t store_prochot_interval(struct device *dev,
@@ -2192,12 +2303,17 @@ static ssize_t store_prochot_interval(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
 	u8 tmp;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	tmp = lm93_read_byte(client, LM93_REG_PROCHOT_INTERVAL);
-	if (nr=1)
+	if (nr = 1)
 		tmp = (tmp & 0x0f) | (LM93_INTERVAL_TO_REG(val) << 4);
 	else
 		tmp = (tmp & 0xf0) | LM93_INTERVAL_TO_REG(val);
@@ -2217,7 +2333,7 @@ static ssize_t show_prochot_override_duty_cycle(struct device *dev,
 						char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",data->prochot_override & 0x0f);
+	return sprintf(buf, "%d\n", data->prochot_override & 0x0f);
 }
 
 static ssize_t store_prochot_override_duty_cycle(struct device *dev,
@@ -2226,7 +2342,12 @@ static ssize_t store_prochot_override_duty_cycle(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->prochot_override = (data->prochot_override & 0xf0) |
@@ -2245,7 +2366,7 @@ static ssize_t show_prochot_short(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",(data->config & 0x10) ? 1 : 0);
+	return sprintf(buf, "%d\n", (data->config & 0x10) ? 1 : 0);
 }
 
 static ssize_t store_prochot_short(struct device *dev,
@@ -2254,7 +2375,12 @@ static ssize_t store_prochot_short(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	if (val)
@@ -2274,8 +2400,8 @@ static ssize_t show_vrdhot(struct device *dev, struct device_attribute *attr,
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",
-		       data->block1.host_status_1 & (1 << (nr+4)) ? 1 : 0);
+	return sprintf(buf, "%d\n",
+		       data->block1.host_status_1 & (1 << (nr + 4)) ? 1 : 0);
 }
 
 static SENSOR_DEVICE_ATTR(vrdhot1, S_IRUGO, show_vrdhot, NULL, 0);
@@ -2285,7 +2411,7 @@ static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_GPI_FROM_REG(data->gpi));
+	return sprintf(buf, "%d\n", LM93_GPI_FROM_REG(data->gpi));
 }
 
 static DEVICE_ATTR(gpio, S_IRUGO, show_gpio, NULL);
@@ -2294,7 +2420,7 @@ static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
-	return sprintf(buf,"%d\n",LM93_ALARMS_FROM_REG(data->block1));
+	return sprintf(buf, "%d\n", LM93_ALARMS_FROM_REG(data->block1));
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
@@ -2494,13 +2620,13 @@ static void lm93_init_client(struct i2c_client *client)
 	lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x01);
 
 	/* spin until ready */
-	for (i=0; i<20; i++) {
+	for (i = 0; i < 20; i++) {
 		msleep(10);
 		if ((lm93_read_byte(client, LM93_REG_CONFIG) & 0x80) = 0x80)
 			return;
 	}
 
-	dev_warn(&client->dev,"timed out waiting for sensor "
+	dev_warn(&client->dev, "timed out waiting for sensor "
 		 "chip to signal ready!\n");
 }
 
@@ -2540,7 +2666,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 	}
 
 	strlcpy(info->type, name, I2C_NAME_SIZE);
-	dev_dbg(&adapter->dev,"loading %s at %d,0x%02x\n",
+	dev_dbg(&adapter->dev, "loading %s at %d, 0x%02x\n",
 		client->name, i2c_adapter_id(client->adapter),
 		client->addr);
 
@@ -2593,7 +2719,7 @@ static int lm93_probe(struct i2c_client *client,
 
 	/* Register hwmon driver class */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if ( !IS_ERR(data->hwmon_dev))
+	if (!IS_ERR(data->hwmon_dev))
 		return 0;
 
 	err = PTR_ERR(data->hwmon_dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
