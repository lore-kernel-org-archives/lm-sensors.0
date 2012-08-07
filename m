From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:19 +0000
Subject: [lm-sensors] [PATCH 30/39] hwmon: (mcp3021) Convert to use devm_ functions
Message-Id: <1344352828-25143-31-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Mingkai Hu <Mingkai.hu@freescale.com>
Cc: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mcp3021.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index d0afc0c..5162bb9 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -103,7 +103,8 @@ static int mcp3021_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct mcp3021_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct mcp3021_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -111,17 +112,14 @@ static int mcp3021_probe(struct i2c_client *client,
 
 	if (client->dev.platform_data) {
 		data->vdd = *(u32 *)client->dev.platform_data;
-		if (data->vdd > MCP3021_VDD_MAX ||
-				data->vdd < MCP3021_VDD_MIN) {
-			err = -EINVAL;
-			goto exit_free;
-		}
+		if (data->vdd > MCP3021_VDD_MAX || data->vdd < MCP3021_VDD_MIN)
+			return -EINVAL;
 	} else
 		data->vdd = MCP3021_VDD_REF;
 
 	err = sysfs_create_file(&client->dev.kobj, &dev_attr_in0_input.attr);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -133,8 +131,6 @@ static int mcp3021_probe(struct i2c_client *client,
 
 exit_remove:
 	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
-exit_free:
-	kfree(data);
 	return err;
 }
 
@@ -144,7 +140,6 @@ static int mcp3021_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
