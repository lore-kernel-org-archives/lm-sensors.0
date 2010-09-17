From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Sep 2010 00:14:44 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100917001444.GA19494@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 15, 2010 at 09:40:05AM -0400, Jean Delvare wrote:
> This is a new driver for the Winbond/Nuvoton W83795G/ADG hardware
> monitoring chips. The original code was contributed by Wei Song, a
> former employee of Nuvoton. I've fixed and improved a lot of things
> on top of his work.
> 
Hi Jean,

highly unusual, I know, but I integrated all individual patches of this set
and then added my coments into the resulting file.
The result is a patch file with my comments.

I might be able to spend some more time on it, but this is what I have so far.
Hope it is useful.

Mostly nitpicks and suggested simplifications, but there may be one
real bug (see the comment about lsb).

Guenter

--
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 76c7f24..e19e6c9 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -124,6 +124,14 @@ static const u8 W83795_REG_IN_HL_LSB[] = {
 	0xa4,	/* VSEN17 */
 };
 
+/*
+ * type is either 1 or 2.
+ * 1: index := index --> could use index + type - 1
+ * 2: index := index + 1 --> could use index + type - 1
+ * Suggestion:
+ *  #define IN_LSB_REG(index, type) W83795_REG_IN_HL_LSB[(index + type - 1)]
+ * or at least use type = IN_MAX instead of type = 1.
+ */
 #define IN_LSB_REG(index, type) \
 	(((type) = 1) ? W83795_REG_IN_HL_LSB[(index)] \
 	: (W83795_REG_IN_HL_LSB[(index)] + 1))
@@ -161,6 +169,7 @@ static const u8 IN_LSB_SHIFT_IDX[][2] = {
 #define W83795_REG_FAN_MIN_LSB(index)	(0xC4 + (index) / 2)
 #define W83795_REG_FAN_MIN_LSB_SHIFT(index) \
 	(((index) & 1) ? 4 : 0)
+/* could use ((index) & 1) << 2) */
 
 #define W83795_REG_VID_CTRL		0x6A
 
@@ -349,6 +358,9 @@ struct w83795_data {
 	u8 dts_read_vrlsb[8];	/* Register value */
 	s8 dts_ext[4];		/* Register value */
 
+	/* something like pwm_count would be better here. 
+	 * All other has_xxx variables are bit masks.
+	 */
 	u8 has_pwm;		/* 795g supports 8 pwm, 795adg only supports 2,
 				 * no config register, only affected by chip
 				 * type */
@@ -470,6 +482,12 @@ static void w83795_update_limits(struct i2c_client *client)
 
 		/* Each register contains LSB for 2 fans, but we want to
 		 * read it only once to save time */
+		/*
+		 * But that causes lsb to be undefined across loop instances,
+		 * doesn't it, since it is only defined inside the loop ?
+		 * And what happens if an even fan does not exist
+		 * but the odd one does ?
+		 */
 		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
 			lsb = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
 
@@ -491,6 +509,7 @@ static void w83795_update_limits(struct i2c_client *client)
 	}
 
 	/* Read the DTS limits */
+	/* != 0 isn't really needed */
 	if (data->enable_dts != 0) {
 		for (limit = DTS_CRIT; limit <= DTS_WARN_HYST; limit++)
 			data->dts_ext[limit] @@ -544,6 +563,7 @@ static struct w83795_data *w83795_update_pwm_config(struct device *dev)
 		data->pwm_temp[i][TEMP_PWM_CTFS]  			w83795_read(client, W83795_REG_CTFS(i));
 		tmp = w83795_read(client, W83795_REG_HT(i));
+		/* & 0x0f doesn't hurt but also isn't needed. */
 		data->pwm_temp[i][TEMP_PWM_HCT] = (tmp >> 4) & 0x0f;
 		data->pwm_temp[i][TEMP_PWM_HOT] = tmp & 0x0f;
 	}
@@ -620,6 +640,7 @@ static struct w83795_data *w83795_update_device(struct device *dev)
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
 		data->fan[i] | 		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;
+		    /* & 0x0f doesn't hurt but isn't needed either. */
 	}
 
 	/* Update temperature */
@@ -631,6 +652,7 @@ static struct w83795_data *w83795_update_device(struct device *dev)
 	}
 
 	/* Update dts temperature */
+	/* != 0 isn't really needed */
 	if (data->enable_dts != 0) {
 		for (i = 0; i < ARRAY_SIZE(data->dts); i++) {
 			if (!(data->has_dts & (1 << i)))
@@ -677,10 +699,11 @@ show_alarm_beep(struct device *dev, struct device_attribute *attr, char *buf)
 	int bit = sensor_attr->index & 0x07;
 	u8 val;
 
-	if (ALARM_STATUS = nr) {
-		val = (data->alarms[index] >> (bit)) & 1;
+	/* nr = ALARM_STATUS ? */
+	if (ALARM_STATUS = nr) {			    /* { } not needed ? */
+		val = (data->alarms[index] >> (bit)) & 1; /* (bit) --> bit */
 	} else {		/* BEEP_ENABLE */
-		val = (data->beeps[index] >> (bit)) & 1;
+		val = (data->beeps[index] >> (bit)) & 1; /* (bit) --> bit */
 	}
 
 	return sprintf(buf, "%u\n", val);
@@ -744,6 +767,18 @@ show_fan(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83795_data *data = w83795_update_device(dev);
 	u16 val;
 
+	/* Those reversed comparisons always confuse me.
+	 * I think the compiler should refuse to compile 
+	 * such code to make me happy. And, no, I don't buy
+	 * the argument that the compiler magically produces
+	 * better code this way.
+	 * They are used in this driver to compare variables against
+	 * defined constants (though not all the time).
+	 * Direct value comparisons are (most of the time) the other way.
+	 * Any reason ?
+	 * Maybe I shouldn't even ask since this one always create a lot of
+	 * heated discussion. Let me know.
+	 */
 	if (FAN_INPUT = nr)
 		val = data->fan[index] & 0x0fff;
 	else
@@ -855,6 +890,13 @@ show_pwm_enable(struct device *dev, struct device_attribute *attr, char *buf)
 	int index = sensor_attr->index;
 	u8 tmp;
 
+	/* so we are talking about
+	 *  (index = 0 && (data->pwm_fcms[0] & 1)),
+	 * correct ? Or maybe
+	 *  (index = 0 && (data->pwm_fcms[0] & (1 << index))),
+	 * Seems to me that would be less confusing and actually be less
+	 * expensive.
+	 */
 	if (1 = (data->pwm_fcms[0] & (1 << index))) {
 		tmp = 2;
 		goto out;
@@ -1011,6 +1053,7 @@ store_temp_pwm_enable(struct device *dev, struct device_attribute *attr,
 
 	switch (nr) {
 	case TEMP_PWM_ENABLE:
+		/* excessive () */
 		if ((tmp != 3) && (tmp != 4))
 			return -EINVAL;
 		tmp -= 3;
@@ -1075,6 +1118,7 @@ store_fanin(struct device *dev, struct device_attribute *attr,
 	case FANIN_TARGET:
 		val = fan_to_reg(SENSORS_LIMIT(val, 0, 0xfff));
 		w83795_write(client, W83795_REG_FTSH(index), (val >> 4) & 0xff);
+		    /* & 0xff doesn't hurt but isn't needed either. */
 		w83795_write(client, W83795_REG_FTSL(index), (val << 4) & 0xf0);
 		data->target_speed[index] = val;
 		break;
@@ -1234,6 +1278,7 @@ show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83795_data *data = w83795_update_device(dev);
 	long temp = temp_from_reg(data->temp[index][nr]);
 
+	/* reverse order ? */
 	if (TEMP_READ = nr)
 		temp += (data->temp_read_vrlsb[index] >> 6) * 250;
 	return sprintf(buf, "%ld\n", temp);
@@ -1810,6 +1855,7 @@ static int w83795_detect(struct i2c_client *client,
 
 	/* If Nuvoton chip, address of chip and W83795_REG_I2C_ADDR
 	   should match */
+	/* !((bank & 0x07) ? */
 	if ((bank & 0x07) = 0) {
 		i2c_addr = i2c_smbus_read_byte_data(client,
 						    W83795_REG_I2C_ADDR);
@@ -1825,6 +1871,8 @@ static int w83795_detect(struct i2c_client *client,
 	   Usually we don't write to chips during detection, but here we don't
 	   quite have the choice; hopefully it's OK, we are about to return
 	   success anyway */
+	/* != 0 isn't really needed.
+	 * Also, looks like a candicate for an else statement. */
 	if ((bank & 0x07) != 0)
 		i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL,
 					  bank & ~0x07);
@@ -1891,6 +1939,7 @@ static int w83795_handle_files(struct device *dev, int (*fn)(struct device *,
 		}
 	}
 
+	/* != 0 isn't really needed */
 	if (data->enable_dts != 0) {
 		for (i = 0; i < ARRAY_SIZE(w83795_dts); i++) {
 			if (!(data->has_dts & (1 << i)))
@@ -1923,6 +1972,7 @@ static void w83795_check_dynamic_in_limits(struct i2c_client *client)
 	vid_ctl = w83795_read(client, W83795_REG_VID_CTRL);
 
 	/* Return immediately if VRM isn't configured */
+	/* !(vid_ctl & 0x07) ? */
 	if ((vid_ctl & 0x07) = 0x00 || (vid_ctl & 0x07) = 0x07)
 		return;
 
@@ -2021,6 +2071,8 @@ static int w83795_probe(struct i2c_client *client,
 			if (!(data->has_dts & (1 << i)))
 				continue;
 			tmp = w83795_read(client, W83795_REG_PECI_TBASE(i));
+			/* Is it common to report such values during boot ?
+			 * Or is it just excessive noise ? */
 			dev_info(&client->dev,
 				 "PECI agent %d Tbase temperature: %u\n",
 				 i + 1, (unsigned int)tmp & 0x7f);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
