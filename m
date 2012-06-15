From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:50 +0000
Subject: [lm-sensors] [PATCH 09/95] hwmon: (adm1025) Convert to use devm_ functions
Message-Id: <1339773856-3443-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1025.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index b8557f9..7e16e5d 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -477,11 +477,10 @@ static int adm1025_probe(struct i2c_client *client,
 	int err;
 	u8 config;
 
-	data = kzalloc(sizeof(struct adm1025_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1025_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -492,7 +491,7 @@ static int adm1025_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &adm1025_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
@@ -513,9 +512,6 @@ static int adm1025_probe(struct i2c_client *client,
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -569,7 +565,6 @@ static int adm1025_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
