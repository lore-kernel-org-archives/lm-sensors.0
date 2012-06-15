From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:06 +0000
Subject: [lm-sensors] [PATCH 85/95] hwmon: (w83795) Convert to use devm_ functions
Message-Id: <1339773856-3443-86-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83795.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index d887cb3..b813c64 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -2157,11 +2157,9 @@ static int w83795_probe(struct i2c_client *client,
 	struct w83795_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct w83795_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(dev, sizeof(struct w83795_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	data->chip_type = id->driver_data;
@@ -2247,8 +2245,6 @@ static int w83795_probe(struct i2c_client *client,
 
 exit_remove:
 	w83795_handle_files(dev, device_remove_file_wrapper);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -2258,7 +2254,6 @@ static int w83795_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	w83795_handle_files(&client->dev, device_remove_file_wrapper);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
