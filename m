From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:56 +0000
Subject: [lm-sensors] [PATCH 07/39] hwmon: (adm1029) Convert to use devm_ functions
Message-Id: <1344352828-25143-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1029.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 80cc465..97f4718 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -342,11 +342,10 @@ static int adm1029_probe(struct i2c_client *client,
 	struct adm1029_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct adm1029_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1029_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -355,15 +354,13 @@ static int adm1029_probe(struct i2c_client *client,
 	 * Initialize the ADM1029 chip
 	 * Check config register
 	 */
-	if (adm1029_init_client(client) = 0) {
-		err = -ENODEV;
-		goto exit_free;
-	}
+	if (adm1029_init_client(client) = 0)
+		return -ENODEV;
 
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &adm1029_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -375,9 +372,6 @@ static int adm1029_probe(struct i2c_client *client,
 
  exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
- exit_free:
-	kfree(data);
- exit:
 	return err;
 }
 
@@ -405,7 +399,6 @@ static int adm1029_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
