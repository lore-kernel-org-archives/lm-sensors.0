From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH asb100 set_fan_div update
Message-Id: <2bv641119itatrp5g464rjjvi548jjgv0g@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch updates drivers/i2c/chips/asb100.c to return error 
when invalid fan divisor requested and adds update_lock handling.

Compile tested only, needs real test.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm2/drivers/i2c/chips/asb100.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm2x/drivers/i2c/chips/asb100.c	2005-03-25 13:49:48.000000000 +1100
@@ -172,13 +172,6 @@
 
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
-   REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
-static u8 DIV_TO_REG(long val)
-{
-	return val=8 ? 3 : val=4 ? 2 : val=1 ? 0 : 1;
-}
-
 /* For each registered client, we need to keep some data in memory. That
    data is pointed to by client->data. The structure itself is
    dynamically allocated, at the same time the client itself is allocated. */
@@ -245,10 +238,13 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
+	unsigned long val; \
+	down(&data->update_lock); \
+	val = simple_strtoul(buf, NULL, 10); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
 		data->in_##reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -328,27 +324,49 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	u32 val;
+
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * set_fan_div: Return error for invalid new divisor, skip update if 
+ * no change in divisor, adjust fan_min to match new divisor.
+ */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 				size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long min = FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-	int reg;
+	unsigned long min, val;
+	u8 new, reg;
+
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
+
+	switch (val) {
+	case 1: new = 0; break;
+	case 2: new = 1; break;
+	case 4: new = 2; break;
+	case 8: new = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not supported. "
+				"Choose one of 1, 2, 4, or 8!\n", val);
+		count = -EINVAL;
+		goto exit;
+	}
 	
-	data->fan_div[nr] = DIV_TO_REG(val);
+	if (new = data->fan_div[nr])
+		goto exit;
+
+	min = FAN_FROM_REG(data->fan_min[nr], 
+				DIV_FROM_REG(data->fan_div[nr]));
+	data->fan_div[nr] = new;
 
 	switch(nr) {
 	case 0:	/* fan 1 */
@@ -373,6 +391,8 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+exit:
+	up(&data->update_lock);
 	return count;
 }
 
@@ -449,7 +469,9 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
+	unsigned long val; \
+	down(&data->update_lock); \
+	val = simple_strtoul(buf, NULL, 10); \
 	switch (nr) { \
 	case 1: case 2: \
 		data->reg[nr] = LM75_TEMP_TO_REG(val); \
@@ -460,6 +482,7 @@
 	} \
 	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
 
@@ -559,10 +582,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
 	data->pwm &= 0x80; /* keep the enable bit */
 	data->pwm |= (0x0f & ASB100_PWM_TO_REG(val));
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -577,10 +604,14 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
 	data->pwm &= 0x0f; /* keep the duty cycle bits */
 	data->pwm |= (val ? 0x80 : 0x00);
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
 
