From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: [PATCH 2.6] I2C: Fix indentation of lm87 driver
Message-Id: <20050325225724.2004e2ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This trivial patch fixes indentation in the lm87 driver. I need this
'cause I'll soon post patches affecting these portions of code, and I'd
like these patches to be easily readable.

Please apply, thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm2/drivers/i2c/chips/lm87.c.orig	2005-03-25 10:11:23.000000000 +0100
+++ linux-2.6.12-rc1-mm2/drivers/i2c/chips/lm87.c	2005-03-25 11:40:36.000000000 +0100
@@ -317,20 +317,20 @@
 
 static void set_temp_low(struct device *dev, const char *buf, int nr)
 {
-    struct i2c_client *client = to_i2c_client(dev);
-    struct lm87_data *data = i2c_get_clientdata(client);
-    long val = simple_strtol(buf, NULL, 10);
-    data->temp_low[nr] = TEMP_TO_REG(val);
-    lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm87_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	data->temp_low[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
 }
 
 static void set_temp_high(struct device *dev, const char *buf, int nr)
 {
-    struct i2c_client *client = to_i2c_client(dev);
-    struct lm87_data *data = i2c_get_clientdata(client);
-    long val = simple_strtol(buf, NULL, 10);
-    data->temp_high[nr] = TEMP_TO_REG(val);
-    lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm87_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	data->temp_high[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
 }
 
 #define set_temp(offset) \


-- 
Jean Delvare
