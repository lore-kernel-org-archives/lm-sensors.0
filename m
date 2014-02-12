From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Feb 2014 09:05:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95245) Avoid initializing the same field twice
Message-Id: <20140212100527.447d3e3c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

data is kzalloc'd, so data->valid is already 0.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/hwmon/lm95245.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-3.14-rc1.orig/drivers/hwmon/lm95245.c	2014-02-12 09:47:05.791692082 +0100
+++ linux-3.14-rc1/drivers/hwmon/lm95245.c	2014-02-12 09:47:38.143402204 +0100
@@ -447,7 +447,6 @@ static int lm95245_detect(struct i2c_cli
 static void lm95245_init_client(struct i2c_client *client,
 				struct lm95245_data *data)
 {
-	data->valid = 0;
 	data->interval = lm95245_read_conversion_rate(client);
 
 	data->config1 = i2c_smbus_read_byte_data(client,


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
