From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:57 +0000
Subject: [lm-sensors] [PATCH 76/95] hwmon: (tmp102) Convert to use devm_ functions
Message-Id: <1339773856-3443-77-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp102.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 0d466b9..b6cda09 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -159,9 +159,9 @@ static int __devinit tmp102_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	tmp102 = kzalloc(sizeof(*tmp102), GFP_KERNEL);
+	tmp102 = devm_kzalloc(&client->dev, sizeof(*tmp102), GFP_KERNEL);
 	if (!tmp102) {
-		dev_dbg(&client->dev, "kzalloc failed\n");
+		dev_dbg(&client->dev, "devm_kzalloc failed\n");
 		return -ENOMEM;
 	}
 	i2c_set_clientdata(client, tmp102);
@@ -169,7 +169,7 @@ static int __devinit tmp102_probe(struct i2c_client *client,
 	status = i2c_smbus_read_word_swapped(client, TMP102_CONF_REG);
 	if (status < 0) {
 		dev_err(&client->dev, "error reading config register\n");
-		goto fail_free;
+		return status;
 	}
 	tmp102->config_orig = status;
 	status = i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
@@ -213,9 +213,6 @@ fail_remove_sysfs:
 fail_restore_config:
 	i2c_smbus_write_word_swapped(client, TMP102_CONF_REG,
 				     tmp102->config_orig);
-fail_free:
-	kfree(tmp102);
-
 	return status;
 }
 
@@ -236,8 +233,6 @@ static int __devexit tmp102_remove(struct i2c_client *client)
 						     config | TMP102_CONF_SD);
 	}
 
-	kfree(tmp102);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
