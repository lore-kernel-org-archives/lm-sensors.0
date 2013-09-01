From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Sep 2013 02:49:02 +0000
Subject: [lm-sensors] [PATCH v2 9/9] hwmon: (ds1621) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1378003742-18685-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 595f4ef..51a6113 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -379,23 +379,12 @@ static int ds1621_probe(struct i2c_client *client,
 	/* Initialize the DS1621 chip */
 	ds1621_init_client(data, client);
 
-	hwmon_dev = hwmon_device_register_with_groups(&client->dev,
-						      client->name, data,
-						      ds1621_groups);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   ds1621_groups);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
-	i2c_set_clientdata(client, hwmon_dev);
-
-	return 0;
-}
-
-static int ds1621_remove(struct i2c_client *client)
-{
-	struct device *hwmon_dev = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(hwmon_dev);
-
 	return 0;
 }
 
@@ -416,7 +405,6 @@ static struct i2c_driver ds1621_driver = {
 		.name	= "ds1621",
 	},
 	.probe		= ds1621_probe,
-	.remove		= ds1621_remove,
 	.id_table	= ds1621_id,
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
