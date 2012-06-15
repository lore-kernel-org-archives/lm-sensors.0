From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:04 +0000
Subject: [lm-sensors] [PATCH 23/95] hwmon: (asc7621) Convert to use devm_ functions
Message-Id: <1339773856-3443-24-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: George Joseph <george.joseph@fairview5.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asc7621.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 7caa242..b867aab7 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -1109,7 +1109,8 @@ asc7621_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	data = kzalloc(sizeof(struct asc7621_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct asc7621_data),
+			    GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
 
@@ -1143,7 +1144,6 @@ exit_remove:
 				   &(asc7621_params[i].sda.dev_attr));
 	}
 
-	kfree(data);
 	return err;
 }
 
@@ -1192,7 +1192,6 @@ static int asc7621_remove(struct i2c_client *client)
 				   &(asc7621_params[i].sda.dev_attr));
 	}
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
