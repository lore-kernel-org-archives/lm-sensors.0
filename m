From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:55 +0000
Subject: [lm-sensors] [PATCH 14/95] hwmon: (ads1015) Convert to use devm_ functions
Message-Id: <1339773856-3443-15-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Dirk Eibach <eibach@gdsys.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads1015.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 1958f03..2798246 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -156,7 +156,6 @@ static int ads1015_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	for (k = 0; k < ADS1015_CHANNELS; ++k)
 		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
-	kfree(data);
 	return 0;
 }
 
@@ -254,11 +253,10 @@ static int ads1015_probe(struct i2c_client *client,
 	int err;
 	unsigned int k;
 
-	data = kzalloc(sizeof(struct ads1015_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ads1015_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -284,8 +282,6 @@ static int ads1015_probe(struct i2c_client *client,
 exit_remove:
 	for (k = 0; k < ADS1015_CHANNELS; ++k)
 		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
-	kfree(data);
-exit:
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
