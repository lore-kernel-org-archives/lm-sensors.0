From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:10 +0000
Subject: [lm-sensors] [PATCH 29/95] hwmon: (emc2103) Convert to use devm_ functions
Message-Id: <1339773856-3443-30-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc2103.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index e7d234b..b01fe81 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -590,7 +590,8 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	data = kzalloc(sizeof(struct emc2103_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct emc2103_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -608,7 +609,7 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (status < 0) {
 			dev_dbg(&client->dev, "reg 0x%02x, err %d\n", REG_CONF1,
 				status);
-			goto exit_free;
+			return status;
 		}
 
 		/* detect current state of hardware */
@@ -631,7 +632,7 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* Register sysfs hooks */
 	status = sysfs_create_group(&client->dev.kobj, &emc2103_group);
 	if (status)
-		goto exit_free;
+		return status;
 
 	if (data->temp_count >= 3) {
 		status = sysfs_create_group(&client->dev.kobj,
@@ -666,8 +667,6 @@ exit_remove_temp3:
 		sysfs_remove_group(&client->dev.kobj, &emc2103_temp3_group);
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
-exit_free:
-	kfree(data);
 	return status;
 }
 
@@ -685,7 +684,6 @@ static int emc2103_remove(struct i2c_client *client)
 
 	sysfs_remove_group(&client->dev.kobj, &emc2103_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
