From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 19:02:35 +0000
Subject: [lm-sensors] [PATCH 3/5] w83781d: Be less i2c_client-centric
Message-Id: <20070407210235.9c5730d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the driver data structure as the main device reference, instead of
the i2c client. It makes the driver a bit smaller, and makes more sense
as this is an hybrid driver, supporting both I2C and ISA devices.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |  193 ++++++++++++++++++++++-------------------------
 1 file changed, 92 insertions(+), 101 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/w83781d.c	2007-04-07 15:29:13.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/w83781d.c	2007-04-07 15:29:14.000000000 +0200
@@ -271,8 +271,8 @@ static int w83781d_detach_client(struct 
 static int __devinit w83781d_isa_probe(struct platform_device *pdev);
 static int __devexit w83781d_isa_remove(struct platform_device *pdev);
 
-static int w83781d_read_value(struct i2c_client *client, u16 reg);
-static int w83781d_write_value(struct i2c_client *client, u16 reg, u16 value);
+static int w83781d_read_value(struct w83781d_data *data, u16 reg);
+static int w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_device(struct device *dev);
 
@@ -310,14 +310,13 @@ show_in_reg(in_max);
 static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
-	struct i2c_client *client = &data->client; \
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
 	 \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
-	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
+	w83781d_write_value(data, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
 	mutex_unlock(&data->update_lock); \
 	return count; \
@@ -373,7 +372,6 @@ static ssize_t
 store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -381,7 +379,7 @@ store_fan_min(struct device *dev, const 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
+	w83781d_write_value(data, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
 	mutex_unlock(&data->update_lock);
@@ -432,7 +430,6 @@ show_temp_reg(temp_max_hyst);
 static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
-	struct i2c_client *client = &data->client; \
 	s32 val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
@@ -441,11 +438,11 @@ static ssize_t store_temp_##reg (struct 
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
-		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+		w83781d_write_value(data, W83781D_REG_TEMP_##REG(nr), \
 				data->temp_##reg##_add[nr-2]); \
 	} else {	/* TEMP1 */ \
 		data->temp_##reg = TEMP_TO_REG(val); \
-		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+		w83781d_write_value(data, W83781D_REG_TEMP_##REG(nr), \
 			data->temp_##reg); \
 	} \
 	 \
@@ -542,7 +539,6 @@ store_beep_reg(struct device *dev, const
 	       int update_mask)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	u32 val, val2;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -551,21 +547,21 @@ store_beep_reg(struct device *dev, const
 
 	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
-		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS1,
 				    data->beep_mask & 0xff);
 
 		if ((data->type != w83781d) && (data->type != as99127f)) {
-			w83781d_write_value(client, W83781D_REG_BEEP_INTS3,
+			w83781d_write_value(data, W83781D_REG_BEEP_INTS3,
 					    ((data->beep_mask) >> 16) & 0xff);
 		}
 
 		val2 = (data->beep_mask >> 8) & 0x7f;
 	} else {		/* We are storing beep_enable */
-		val2 = w83781d_read_value(client, W83781D_REG_BEEP_INTS2) & 0x7f;
+		val2 = w83781d_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
 		data->beep_enable = !!val;
 	}
 
-	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
+	w83781d_write_value(data, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
 	mutex_unlock(&data->update_lock);
@@ -602,7 +598,6 @@ static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	unsigned long min;
 	u8 reg;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -615,22 +610,22 @@ store_fan_div_reg(struct device *dev, co
 
 	data->fan_div[nr] = DIV_TO_REG(val, data->type);
 
-	reg = (w83781d_read_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+	reg = (w83781d_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
 	       & (nr=0 ? 0xcf : 0x3f))
 	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
-	w83781d_write_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
+	w83781d_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
 
 	/* w83781d and as99127f don't have extended divisor bits */
 	if (data->type != w83781d && data->type != as99127f) {
-		reg = (w83781d_read_value(client, W83781D_REG_VBAT)
+		reg = (w83781d_read_value(data, W83781D_REG_VBAT)
 		       & ~(1 << (5 + nr)))
 		    | ((data->fan_div[nr] & 0x04) << (3 + nr));
-		w83781d_write_value(client, W83781D_REG_VBAT, reg);
+		w83781d_write_value(data, W83781D_REG_VBAT, reg);
 	}
 
 	/* Restore fan_min */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	w83781d_write_value(data, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -669,14 +664,13 @@ static ssize_t
 store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr - 1] = SENSORS_LIMIT(val, 0, 255);
-	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
+	w83781d_write_value(data, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -685,7 +679,6 @@ static ssize_t
 store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	u32 val, reg;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -695,12 +688,12 @@ store_pwmenable_reg(struct device *dev, 
 	switch (val) {
 	case 0:
 	case 1:
-		reg = w83781d_read_value(client, W83781D_REG_PWMCLK12);
-		w83781d_write_value(client, W83781D_REG_PWMCLK12,
+		reg = w83781d_read_value(data, W83781D_REG_PWMCLK12);
+		w83781d_write_value(data, W83781D_REG_PWMCLK12,
 				    (reg & 0xf7) | (val << 3));
 
-		reg = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
-		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG,
+		reg = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
+		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG,
 				    (reg & 0xef) | (!val << 4));
 
 		data->pwmenable[nr - 1] = val;
@@ -758,7 +751,6 @@ static ssize_t
 store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	u32 val, tmp;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -767,26 +759,26 @@ store_sensor_reg(struct device *dev, con
 
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
-		w83781d_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
+		w83781d_write_value(data, W83781D_REG_SCFG1,
 				    tmp | BIT_SCFG1[nr - 1]);
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG2);
-		w83781d_write_value(client, W83781D_REG_SCFG2,
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG2);
+		w83781d_write_value(data, W83781D_REG_SCFG2,
 				    tmp | BIT_SCFG2[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
 	case 2:		/* 3904 */
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
-		w83781d_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
+		w83781d_write_value(data, W83781D_REG_SCFG1,
 				    tmp | BIT_SCFG1[nr - 1]);
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG2);
-		w83781d_write_value(client, W83781D_REG_SCFG2,
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG2);
+		w83781d_write_value(data, W83781D_REG_SCFG2,
 				    tmp & ~BIT_SCFG2[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
 	case W83781D_DEFAULT_BETA:	/* thermistor */
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
-		w83781d_write_value(client, W83781D_REG_SCFG1,
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
+		w83781d_write_value(data, W83781D_REG_SCFG1,
 				    tmp & ~BIT_SCFG1[nr - 1]);
 		data->sens[nr - 1] = val;
 		break;
@@ -868,12 +860,12 @@ w83781d_detect_subclients(struct i2c_ada
 				goto ERROR_SC_1;
 			}
 		}
-		w83781d_write_value(new_client, W83781D_REG_I2C_SUBADDR,
+		w83781d_write_value(data, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
 		data->lm75[0]->addr = force_subclients[2];
 	} else {
-		val1 = w83781d_read_value(new_client, W83781D_REG_I2C_SUBADDR);
+		val1 = w83781d_read_value(data, W83781D_REG_I2C_SUBADDR);
 		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
 	}
 
@@ -1105,14 +1097,14 @@ w83781d_detect(struct i2c_adapter *adapt
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(client, W83781D_REG_CONFIG) & 0x80) {
+		if (w83781d_read_value(data, W83781D_REG_CONFIG) & 0x80) {
 			dev_dbg(&adapter->dev, "Detection of w83781d chip "
 				"failed at step 3\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
-		val1 = w83781d_read_value(client, W83781D_REG_BANK);
-		val2 = w83781d_read_value(client, W83781D_REG_CHIPMAN);
+		val1 = w83781d_read_value(data, W83781D_REG_BANK);
+		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
@@ -1127,7 +1119,7 @@ w83781d_detect(struct i2c_adapter *adapt
 		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
 		    ((val1 & 0x80) && (val2 = 0x5c))) {
 			if (w83781d_read_value
-			    (client, W83781D_REG_I2C_ADDR) != address) {
+			    (data, W83781D_REG_I2C_ADDR) != address) {
 				dev_dbg(&adapter->dev, "Detection of w83781d "
 					"chip failed at step 5\n");
 				err = -ENODEV;
@@ -1138,14 +1130,14 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	/* We have either had a force parameter, or we have already detected the
 	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
-	w83781d_write_value(client, W83781D_REG_BANK,
-			    (w83781d_read_value(client, W83781D_REG_BANK)
+	w83781d_write_value(data, W83781D_REG_BANK,
+			    (w83781d_read_value(data, W83781D_REG_BANK)
 			     & 0x78) | 0x80);
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
 		/* get vendor ID */
-		val2 = w83781d_read_value(client, W83781D_REG_CHIPMAN);
+		val2 = w83781d_read_value(data, W83781D_REG_CHIPMAN);
 		if (val2 = 0x5c)
 			vendid = winbond;
 		else if (val2 = 0x12)
@@ -1157,7 +1149,7 @@ w83781d_detect(struct i2c_adapter *adapt
 			goto ERROR2;
 		}
 
-		val1 = w83781d_read_value(client, W83781D_REG_WCHIPID);
+		val1 = w83781d_read_value(data, W83781D_REG_WCHIPID);
 		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
 			kind = w83781d;
 		else if (val1 = 0x30 && vendid = winbond)
@@ -1290,7 +1282,7 @@ w83781d_isa_probe(struct platform_device
 	i2c_set_clientdata(&data->client, data);
 	platform_set_drvdata(pdev, data);
 
-	reg = w83781d_read_value(&data->client, W83781D_REG_WCHIPID);
+	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
 	switch (reg) {
 	case 0x21:
 		data->type = w83627hf;
@@ -1355,9 +1347,9 @@ w83781d_isa_remove(struct platform_devic
    There are some ugly typecasts here, but the good news is - they should
    nowhere else be necessary! */
 static int
-w83781d_read_value(struct i2c_client *client, u16 reg)
+w83781d_read_value(struct w83781d_data *data, u16 reg)
 {
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = &data->client;
 	int res, word_sized, bank;
 	struct i2c_client *cl;
 
@@ -1424,9 +1416,9 @@ w83781d_read_value(struct i2c_client *cl
 }
 
 static int
-w83781d_write_value(struct i2c_client *client, u16 reg, u16 value)
+w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct w83781d_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = &data->client;
 	int word_sized, bank;
 	struct i2c_client *cl;
 
@@ -1491,7 +1483,6 @@ static void
 w83781d_init_device(struct device *dev)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	int i, p;
 	int type = data->type;
 	u8 tmp;
@@ -1508,38 +1499,38 @@ w83781d_init_device(struct device *dev)
 			 "having, please report!\n");
 
 		/* save these registers */
-		i = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
-		p = w83781d_read_value(client, W83781D_REG_PWMCLK12);
+		i = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
+		p = w83781d_read_value(data, W83781D_REG_PWMCLK12);
 		/* Reset all except Watchdog values and last conversion values
 		   This sets fan-divs to 2, among others */
-		w83781d_write_value(client, W83781D_REG_CONFIG, 0x80);
+		w83781d_write_value(data, W83781D_REG_CONFIG, 0x80);
 		/* Restore the registers and disable power-on abnormal beep.
 		   This saves FAN 1/2/3 input/output values set by BIOS. */
-		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
-		w83781d_write_value(client, W83781D_REG_PWMCLK12, p);
+		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
+		w83781d_write_value(data, W83781D_REG_PWMCLK12, p);
 		/* Disable master beep-enable (reset turns it on).
 		   Individual beep_mask should be reset to off but for some reason
 		   disabling this bit helps some people not get beeped */
-		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS2, 0);
 	}
 
 	/* Disable power-on abnormal beep, as advised by the datasheet.
 	   Already done if reset=1. */
 	if (init && !reset && type != as99127f) {
-		i = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
-		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
+		i = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
+		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
 	}
 
 	data->vrm = vid_which_vrm();
 
 	if ((type != w83781d) && (type != as99127f)) {
-		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
+		tmp = w83781d_read_value(data, W83781D_REG_SCFG1);
 		for (i = 1; i <= 3; i++) {
 			if (!(tmp & BIT_SCFG1[i - 1])) {
 				data->sens[i - 1] = W83781D_DEFAULT_BETA;
 			} else {
 				if (w83781d_read_value
-				    (client,
+				    (data,
 				     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
 					data->sens[i - 1] = 1;
 				else
@@ -1552,36 +1543,36 @@ w83781d_init_device(struct device *dev)
 
 	if (init && type != as99127f) {
 		/* Enable temp2 */
-		tmp = w83781d_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		tmp = w83781d_read_value(data, W83781D_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
 			dev_warn(dev, "Enabling temp2, readings "
 				 "might not make sense\n");
-			w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG,
+			w83781d_write_value(data, W83781D_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
 		}
 
 		/* Enable temp3 */
 		if (type != w83783s) {
-			tmp = w83781d_read_value(client,
+			tmp = w83781d_read_value(data,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
 				dev_warn(dev, "Enabling temp3, "
 					 "readings might not make sense\n");
-				w83781d_write_value(client,
+				w83781d_write_value(data,
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
 		}
 	}
 
 	/* Start monitoring */
-	w83781d_write_value(client, W83781D_REG_CONFIG,
-			    (w83781d_read_value(client,
+	w83781d_write_value(data, W83781D_REG_CONFIG,
+			    (w83781d_read_value(data,
 						W83781D_REG_CONFIG) & 0xf7)
 			    | 0x01);
 
 	/* A few vars need to be filled upon startup */
 	for (i = 1; i <= 3; i++) {
-		data->fan_min[i - 1] = w83781d_read_value(client,
+		data->fan_min[i - 1] = w83781d_read_value(data,
 					W83781D_REG_FAN_MIN(i));
 	}
 	if (type != w83781d && type != as99127f)
@@ -1607,97 +1598,97 @@ static struct w83781d_data *w83781d_upda
 			if (data->type = w83783s && i = 1)
 				continue;	/* 783S has no in1 */
 			data->in[i] -			    w83781d_read_value(client, W83781D_REG_IN(i));
+			    w83781d_read_value(data, W83781D_REG_IN(i));
 			data->in_min[i] -			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
+			    w83781d_read_value(data, W83781D_REG_IN_MIN(i));
 			data->in_max[i] -			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
+			    w83781d_read_value(data, W83781D_REG_IN_MAX(i));
 			if ((data->type != w83782d)
 			    && (data->type != w83627hf) && (i = 6))
 				break;
 		}
 		for (i = 1; i <= 3; i++) {
 			data->fan[i - 1] -			    w83781d_read_value(client, W83781D_REG_FAN(i));
+			    w83781d_read_value(data, W83781D_REG_FAN(i));
 			data->fan_min[i - 1] -			    w83781d_read_value(client, W83781D_REG_FAN_MIN(i));
+			    w83781d_read_value(data, W83781D_REG_FAN_MIN(i));
 		}
 		if (data->type != w83781d && data->type != as99127f) {
 			for (i = 1; i <= 4; i++) {
 				data->pwm[i - 1] -				    w83781d_read_value(client,
+				    w83781d_read_value(data,
 						       W83781D_REG_PWM(i));
 				if ((data->type != w83782d || !client->driver)
 				    && i = 2)
 					break;
 			}
 			/* Only PWM2 can be disabled */
-			data->pwmenable[1] = (w83781d_read_value(client,
+			data->pwmenable[1] = (w83781d_read_value(data,
 					      W83781D_REG_PWMCLK12) & 0x08) >> 3;
 		}
 
-		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));
+		data->temp = w83781d_read_value(data, W83781D_REG_TEMP(1));
 		data->temp_max -		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
+		    w83781d_read_value(data, W83781D_REG_TEMP_OVER(1));
 		data->temp_max_hyst -		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
+		    w83781d_read_value(data, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0] -		    w83781d_read_value(client, W83781D_REG_TEMP(2));
+		    w83781d_read_value(data, W83781D_REG_TEMP(2));
 		data->temp_max_add[0] -		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
+		    w83781d_read_value(data, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0] -		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
+		    w83781d_read_value(data, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83783s) {
 			data->temp_add[1] -			    w83781d_read_value(client, W83781D_REG_TEMP(3));
+			    w83781d_read_value(data, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] -			    w83781d_read_value(client,
+			    w83781d_read_value(data,
 					       W83781D_REG_TEMP_OVER(3));
 			data->temp_max_hyst_add[1] -			    w83781d_read_value(client,
+			    w83781d_read_value(data,
 					       W83781D_REG_TEMP_HYST(3));
 		}
-		i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+		i = w83781d_read_value(data, W83781D_REG_VID_FANDIV);
 		data->vid = i & 0x0f;
-		data->vid |= (w83781d_read_value(client,
+		data->vid |= (w83781d_read_value(data,
 					W83781D_REG_CHIPID) & 0x01) << 4;
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = (i >> 6) & 0x03;
-		data->fan_div[2] = (w83781d_read_value(client,
+		data->fan_div[2] = (w83781d_read_value(data,
 					W83781D_REG_PIN) >> 6) & 0x03;
 		if ((data->type != w83781d) && (data->type != as99127f)) {
-			i = w83781d_read_value(client, W83781D_REG_VBAT);
+			i = w83781d_read_value(data, W83781D_REG_VBAT);
 			data->fan_div[0] |= (i >> 3) & 0x04;
 			data->fan_div[1] |= (i >> 4) & 0x04;
 			data->fan_div[2] |= (i >> 5) & 0x04;
 		}
 		if ((data->type = w83782d) || (data->type = w83627hf)) {
-			data->alarms = w83781d_read_value(client,
+			data->alarms = w83781d_read_value(data,
 						W83782D_REG_ALARM1)
-				     | (w83781d_read_value(client,
+				     | (w83781d_read_value(data,
 						W83782D_REG_ALARM2) << 8)
-				     | (w83781d_read_value(client,
+				     | (w83781d_read_value(data,
 						W83782D_REG_ALARM3) << 16);
 		} else if (data->type = w83783s) {
-			data->alarms = w83781d_read_value(client,
+			data->alarms = w83781d_read_value(data,
 						W83782D_REG_ALARM1)
-				     | (w83781d_read_value(client,
+				     | (w83781d_read_value(data,
 						W83782D_REG_ALARM2) << 8);
 		} else {
 			/* No real-time status registers, fall back to
 			   interrupt status registers */
-			data->alarms = w83781d_read_value(client,
+			data->alarms = w83781d_read_value(data,
 						W83781D_REG_ALARM1)
-				     | (w83781d_read_value(client,
+				     | (w83781d_read_value(data,
 						W83781D_REG_ALARM2) << 8);
 		}
-		i = w83781d_read_value(client, W83781D_REG_BEEP_INTS2);
+		i = w83781d_read_value(data, W83781D_REG_BEEP_INTS2);
 		data->beep_enable = i >> 7;
 		data->beep_mask = ((i & 0x7f) << 8) +
-		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+		    w83781d_read_value(data, W83781D_REG_BEEP_INTS1);
 		if ((data->type != w83781d) && (data->type != as99127f)) {
 			data->beep_mask |-			    w83781d_read_value(client,
+			    w83781d_read_value(data,
 					       W83781D_REG_BEEP_INTS3) << 16;
 		}
 		data->last_updated = jiffies;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
