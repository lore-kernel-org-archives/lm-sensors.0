From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Fix indentation of lm87 driver
Message-Id: <11123113952409@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113951584@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2349, 2005/03/31 14:32:36-08:00, khali@linux-fr.org

[PATCH] I2C: Fix indentation of lm87 driver

This trivial patch fixes indentation in the lm87 driver. I need this
'cause I'll soon post patches affecting these portions of code, and I'd
like these patches to be easily readable.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/lm87.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)


diff -Nru a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c	2005-03-31 15:16:03 -08:00
+++ b/drivers/i2c/chips/lm87.c	2005-03-31 15:16:03 -08:00
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

