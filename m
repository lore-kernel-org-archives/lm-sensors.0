From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH via686a update set_fan_div
Message-Id: <rhp641t035sjttuetlpg17eoqpahpvt5fj@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46n64155ipo0sq0tl17ddm7uhnji304c12@4ax.com>
In-Reply-To: <46n64155ipo0sq0tl17ddm7uhnji304c12@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Mar 2005 11:37:46 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:
>Resend of patch against -mm2, compile tested.

This patch updates drivers/i2c/chips/via686a.c over my previous patch 
to add full update locking like lm85 does.

Compile tested only.


--- linux-2.6.12-rc1-mm2x/drivers/i2c/chips/via686a.c~	2005-03-25 10:54:14.000000000 +1100
+++ linux-2.6.12-rc1-mm2x/drivers/i2c/chips/via686a.c	2005-03-25 12:09:35.000000000 +1100
@@ -361,20 +361,28 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
 	data->in_min[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+
+	down(&data->update_lock);
+	val = simple_strtoul(buf, NULL, 10);
 	data->in_max[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_in_offset(offset)					\
@@ -432,18 +440,26 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -500,9 +516,13 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int val;
+
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 
@@ -515,10 +535,13 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int val;
 	u8 new, old;
 	unsigned long min;
 
+	down(&data->update_lock);
+	val = simple_strtol(buf, NULL, 10);
+
 	switch (val) {
 	case 1: new = 0; break;
 	case 2: new = 1; break;
@@ -527,13 +550,12 @@
 	default:
 		dev_err(&client->dev, "fan_div value %d not supported. "
 				"Choose one of 1, 2, 4, or 8!\n", val);
-		return -EINVAL;
+		count = -EINVAL;
+		goto exit;
 	}
 	if (new = data->fan_div[nr])
 		goto exit;
 	
-	down(&data->update_lock);
-
 	old = via686a_read_value(client, VIA686A_REG_FANDIV);
 	min = FAN_FROM_REG(data->fan_min[nr], 
 					DIV_FROM_REG(data->fan_div[nr]));
@@ -543,8 +565,8 @@
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr + 1),
 					data->fan_min[nr]);
-	up(&data->update_lock);
 exit:
+	up(&data->update_lock);
 	return count;
 }
 
