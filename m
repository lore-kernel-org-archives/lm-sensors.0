From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch adds locking around set operations that access 
data->something and go out to the chip.

for:
asb100, max1619, ds1621, pcf8574, fscher, pcf8591, fscpos, 
sis5595, gl518sm, via686a, gl520sm, w83627hf, w83781d

as separate files from: 
  http://scatter.mine.nu/lmsensors/lock-on-set/

Sign-off-by: Grant Coady <gcoady@gmail.com>


diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/asb100.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/asb100.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/asb100.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/asb100.c	2005-03-26 11:40:20.000000000 +1100
@@ -246,9 +246,12 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
 	unsigned long val = simple_strtoul(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
 		data->in_##reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -329,8 +332,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	u32 val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
 
@@ -343,11 +350,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
-	
+
+	down(&data->update_lock);
+
+	min = FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
 	data->fan_div[nr] = DIV_TO_REG(val);
 
 	switch(nr) {
@@ -373,6 +383,9 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+
+	up(&data->update_lock);
+
 	return count;
 }
 
@@ -450,6 +463,8 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
 	unsigned long val = simple_strtoul(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	switch (nr) { \
 	case 1: case 2: \
 		data->reg[nr] = LM75_TEMP_TO_REG(val); \
@@ -460,6 +475,7 @@
 	} \
 	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -560,9 +576,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &= 0x80; /* keep the enable bit */
 	data->pwm |= (0x0f & ASB100_PWM_TO_REG(val));
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -578,9 +597,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &= 0x0f; /* keep the duty cycle bits */
 	data->pwm |= (val ? 0x80 : 0x00);
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/ds1621.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/ds1621.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/ds1621.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/ds1621.c	2005-03-26 11:40:20.000000000 +1100
@@ -153,8 +153,11 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
+\
+	down(&data->update_lock);					\
 	data->value = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
 	ds1621_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscher.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscher.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscher.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscher.c	2005-03-26 11:40:20.000000000 +1100
@@ -464,9 +464,11 @@
 {
 	/* bits 0..1, 3..7 reserved => mask with 0x04 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x04;
+	
+	down(&data->update_lock);
 	data->fan_status[FAN_INDEX_FROM_NUM(nr)] &= ~v;
-
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -480,9 +482,11 @@
 		       const char *buf, size_t count, int nr, int reg)
 {
 	unsigned long v = simple_strtoul(buf, NULL, 10);
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 
+	down(&data->update_lock);
+	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -497,6 +501,8 @@
 	/* supported values: 2, 4, 8 */
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (v) {
 	case 2: v = 1; break;
 	case 4: v = 2; break;
@@ -504,14 +510,16 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
 	/* bits 2..7 reserved => mask with 0x03 */
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &= ~0x03;
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |= v;
-
 	fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
+
+	up(&data->update_lock);
 	return count;
 }
 
@@ -537,9 +545,11 @@
 {
 	/* bits 2..7 reserved, 0 read only => mask with 0x02 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
-	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &= ~v;
 
+	down(&data->update_lock);
+	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -592,9 +602,11 @@
 {
 	/* bits 1..7 reserved => mask with 0x01 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x01;
-	data->global_control &= ~v;
 
+	down(&data->update_lock);
+	data->global_control &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -612,10 +624,12 @@
 {
 	/* bits 0..3 reserved => mask with 0xf0 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->watchdog[2] &= ~0xf0;
 	data->watchdog[2] |= v;
-
 	fscher_write_value(client, reg, data->watchdog[2]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -630,9 +644,11 @@
 {
 	/* bits 0, 2..7 reserved => mask with 0x02 */  
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
-	data->watchdog[1] &= ~v;
 
+	down(&data->update_lock);
+	data->watchdog[1] &= ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -645,9 +661,10 @@
 static ssize_t set_watchdog_preset(struct i2c_client *client, struct fscher_data *data,
 				   const char *buf, size_t count, int nr, int reg)
 {
+	down(&data->update_lock);
 	data->watchdog[0] = simple_strtoul(buf, NULL, 10) & 0xff;
-
 	fscher_write_value(client, reg, data->watchdog[0]);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscpos.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscpos.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscpos.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscpos.c	2005-03-26 11:40:20.000000000 +1100
@@ -206,11 +206,13 @@
 		return -EINVAL;
 	}
 	
+	down(&data->update_lock);
 	/* bits 2..7 reserved => mask with 0x03 */
 	data->fan_ripple[nr - 1] &= ~0x03;
 	data->fan_ripple[nr - 1] |= v;
 	
 	fscpos_write_value(client, reg, data->fan_ripple[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -228,8 +230,10 @@
 	if (v < 0) v = 0;
 	if (v > 255) v = 255;
 
+	down(&data->update_lock);
 	data->pwm[nr - 1] = v;
 	fscpos_write_value(client, reg, data->pwm[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -271,10 +275,13 @@
 {
 	/* bits 0..3 reserved => mask with 0xf0 */
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->wdog_control &= ~0xf0;
 	data->wdog_control |= v;
 	
 	fscpos_write_value(client, reg, data->wdog_control);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -296,9 +303,11 @@
 		return -EINVAL;
 	}
 
+	down(&data->update_lock);
 	data->wdog_state &= ~v;
 	
 	fscpos_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl518sm.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl518sm.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl518sm.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl518sm.c	2005-03-26 11:40:20.000000000 +1100
@@ -211,8 +211,11 @@
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	long val = simple_strtol(buf, NULL, 10);			\
+\
+	down(&data->update_lock);					\
 	data->value = type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
@@ -222,11 +225,15 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
-	int regvalue = gl518_read_value(client, reg);			\
+	int regvalue;							\
 	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+\
+	down(&data->update_lock);					\
+	regvalue = gl518_read_value(client, reg);			\
 	data->value = type##_TO_REG(val);				\
 	regvalue = (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
@@ -255,7 +262,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
-	int regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
+
+	down(&data->update_lock);
+	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
 
 	data->fan_min[0] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[0]));
@@ -270,6 +280,7 @@
 	data->beep_mask &= data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -277,8 +288,10 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
-	int regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
 
+	down(&data->update_lock);
+	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
 	data->fan_min[1] = FAN_TO_REG(simple_strtoul(buf, NULL, 10),
 		DIV_FROM_REG(data->fan_div[1]));
 	regvalue = (regvalue & 0xff00) | data->fan_min[1];
@@ -292,6 +305,7 @@
 	data->beep_mask &= data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl520sm.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl520sm.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl520sm.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl520sm.c	2005-03-26 11:40:20.000000000 +1100
@@ -299,6 +299,8 @@
 static ssize_t set_in_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r;
 
 	if (n = 0)
@@ -313,12 +315,15 @@
 	else
 		gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_in_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r;
 
 	if (n = 0)
@@ -333,6 +338,7 @@
 	else
 		gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -363,6 +369,8 @@
 static ssize_t set_fan_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	unsigned long v = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r = FAN_TO_REG(v, data->fan_div[n - 1]);
 
 	data->fan_min[n - 1] = r;
@@ -380,12 +388,15 @@
 	data->beep_mask &= data->alarm_mask;
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
 
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_fan_div(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	unsigned long v = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r;
 
 	switch (v) {
@@ -394,17 +405,22 @@
 	case 4: r = 2; break;
 	case 8: r = 3; break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not supported. Choose one of 1, 2, 4 or 8!\n", v);
+		dev_err(&client->dev, "fan_div value %ld not supported. "
+				"Choose one of 1, 2, 4 or 8!\n", v);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
 	data->fan_div[n - 1] = r;
 
 	if (n = 1)
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xc0) | (r << 6));
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) 
+					& ~0xc0) | (r << 6));
 	else
-		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) | (r << 4));
+		gl520_write_value(client, reg, (gl520_read_value(client, reg) 
+					& ~0x30) | (r << 4));
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -412,9 +428,12 @@
 {
 	u8 r = simple_strtoul(buf, NULL, 10)?1:0;
 
+	down(&data->update_lock);
 	data->fan_off = r;
-	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | (r << 2));
+	gl520_write_value(client, reg, (gl520_read_value(client, reg) 
+				& ~0x0c) | (r << 2));
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -439,22 +458,28 @@
 static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r = TEMP_TO_REG(v);
 
 	data->temp_max[n - 1] = r;
 	gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	long v = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	u8 r = TEMP_TO_REG(v);
 
 	data->temp_max_hyst[n - 1] = r;
 	gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -477,19 +502,24 @@
 {
 	u8 r = simple_strtoul(buf, NULL, 10)?0:1;
 
+	down(&data->update_lock);
 	data->beep_enable = !r;
-	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | (r << 2));
+	gl520_write_value(client, reg, (gl520_read_value(client, reg) 
+				& ~0x04) | (r << 2));
 
+	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
+	down(&data->update_lock);
 	u8 r = simple_strtoul(buf, NULL, 10) & data->alarm_mask;
 
 	data->beep_mask = r;
 	gl520_write_value(client, reg, r);
 
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/max1619.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/max1619.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/max1619.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/max1619.c	2005-03-26 11:40:20.000000000 +1100
@@ -141,8 +141,11 @@
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8574.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/pcf8574.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8574.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/pcf8574.c	2005-03-26 11:40:20.000000000 +1100
@@ -97,8 +97,11 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
 	data->write = simple_strtoul(buf, NULL, 10);
 	i2c_smbus_write_byte(client, data->write);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8591.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/pcf8591.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8591.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/pcf8591.c	2005-03-26 11:40:20.000000000 +1100
@@ -124,8 +124,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
 	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
+
+		down(&data->update_lock);
 		data->aout = value;
 		i2c_smbus_write_byte_data(client, data->control, data->aout);
+		up(&data->update_lock);
 		return count;
 	}
 	return -EINVAL;
@@ -144,11 +147,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
 	if (simple_strtoul(buf, NULL, 10))
 		data->control |= PCF8591_CONTROL_AOEF;
 	else
 		data->control &= ~PCF8591_CONTROL_AOEF;
 	i2c_smbus_write_byte(client, data->control);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/sis5595.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/sis5595.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/sis5595.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/sis5595.c	2005-03-26 11:40:20.000000000 +1100
@@ -232,8 +232,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -243,8 +246,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -305,8 +311,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_OVER, data->temp_over);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -321,8 +330,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_HYST, data->temp_hyst);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -353,8 +365,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -373,10 +388,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
-	int reg = sis5595_read_value(client, SIS5595_REG_FANDIV);
+	int reg;
+
+	down(&data->update_lock);
+	min = FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
+	reg = sis5595_read_value(client, SIS5595_REG_FANDIV);
 	switch (val) {
 	case 1: data->fan_div[nr] = 0; break;
 	case 2: data->fan_div[nr] = 1; break;
@@ -385,6 +404,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 	
@@ -400,6 +420,7 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/via686a.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/via686a.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/via686a.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/via686a.c	2005-03-26 11:40:20.000000000 +1100
@@ -363,9 +363,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf, 
@@ -373,9 +376,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_in_offset(offset)					\
@@ -434,8 +440,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
@@ -443,8 +452,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -502,8 +514,11 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
@@ -511,10 +526,13 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
 	data->fan_div[nr] = DIV_TO_REG(val);
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83627hf.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83627hf.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83627hf.c	2005-03-26 07:26:41.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83627hf.c	2005-03-26 11:40:20.000000000 +1100
@@ -354,10 +354,13 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83627hf_write_value(client, W83781D_REG_IN_##REG(nr), \
 			    data->in_##reg[nr]); \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min)
@@ -442,6 +445,9 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf = data->type || w83637hf = data->type))
 
@@ -452,6 +458,7 @@
 		data->in_min[0] = IN_TO_REG(val);
 
 	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -463,6 +470,9 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf = data->type || w83637hf = data->type))
 		
@@ -473,6 +483,7 @@
 		data->in_max[0] = IN_TO_REG(val);
 
 	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -508,11 +519,14 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -573,6 +587,8 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
@@ -584,6 +600,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -692,6 +709,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val);
 		w83627hf_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -708,6 +727,7 @@
 	w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -753,6 +773,8 @@
 	unsigned long min;
 	u8 reg;
 
+	down(&data->update_lock);
+
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
@@ -773,6 +795,7 @@
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -815,6 +838,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (data->type = w83627thf) {
 		/* bits 0-3 are reserved  in 627THF */
 		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
@@ -830,6 +855,7 @@
 				     data->pwm[nr - 1]);
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -871,6 +897,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
@@ -903,6 +931,7 @@
 		break;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
diff -Nur linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83781d.c linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83781d.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83781d.c	2005-03-26 11:40:20.000000000 +1100
@@ -302,9 +302,12 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10) / 10; \
+\
+	down(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min);
@@ -369,11 +372,14 @@
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -431,6 +437,8 @@
 	s32 val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
+\
+	down(&data->update_lock); \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
@@ -442,6 +450,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -554,6 +563,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -573,6 +584,7 @@
 	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -616,6 +628,8 @@
 	unsigned long min;
 	u8 reg;
 
+	down(&data->update_lock);
+	
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
@@ -640,6 +654,7 @@
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -686,9 +701,12 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	data->pwm[nr - 1] = PWM_TO_REG(val);
 	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -701,6 +719,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 0:
 	case 1:
@@ -716,9 +736,11 @@
 		break;
 
 	default:
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -780,6 +802,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
@@ -811,6 +835,7 @@
 		break;
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
@@ -859,6 +884,8 @@
 	struct w83781d_data *data = i2c_get_clientdata(client);
 	u32 val, i;
 
+	down(&data->update_lock);
+
 	for (i = 0; i < count; i++) {
 		val = simple_strtoul(buf + count, NULL, 10);
 
@@ -869,6 +896,7 @@
 				    data->rt[nr - 1][i]);
 	}
 
+	up(&data->update_lock);
 	return count;
 }
 
