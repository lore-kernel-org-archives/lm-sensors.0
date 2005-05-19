From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test1
Message-Id: <10586300923537@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <105863009030@kroah.com>
References: <105863009030@kroah.com>
In-Reply-To: <105863009030@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1358.10.2, 2003/07/03 12:22:45-07:00, j.dittmer@portrix.net

[PATCH] I2C: convert via686a temp_* to milli degree celsius

Forgot to send this.

This converts the i2c chip driver via686a to handle milli degree celsius
instead of centi degree celsius. Applies for temp_input, temp_min, temp_max.


 drivers/i2c/chips/via686a.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Sat Jul 19 08:48:34 2003
+++ b/drivers/i2c/chips/via686a.c	Sat Jul 19 08:48:34 2003
@@ -494,27 +494,27 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*10 );
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
 }
 /* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*10);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
 }
 /* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
-	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*10);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_over[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
 	return count;
@@ -523,7 +523,7 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
 	return count;

