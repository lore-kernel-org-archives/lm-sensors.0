From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:58 +0000
Subject: [lm-sensors] [PATCH 77/95] hwmon: (tmp401) Convert to use devm_ functions
Message-Id: <1339773856-3443-78-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index ea54c33..e620548 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -594,7 +594,6 @@ static int tmp401_remove(struct i2c_client *client)
 					   &tmp411_attr[i].dev_attr);
 	}
 
-	kfree(data);
 	return 0;
 }
 
@@ -605,7 +604,8 @@ static int tmp401_probe(struct i2c_client *client,
 	struct tmp401_data *data;
 	const char *names[] = { "TMP401", "TMP411" };
 
-	data = kzalloc(sizeof(struct tmp401_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct tmp401_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -646,7 +646,7 @@ static int tmp401_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove:
-	tmp401_remove(client); /* will also free data for us */
+	tmp401_remove(client);
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
