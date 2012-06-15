From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:18 +0000
Subject: [lm-sensors] [PATCH 37/95] hwmon: (gl518sm) Convert to use devm_ functions
Message-Id: <1339773856-3443-38-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gl518sm.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 764a083..2c74673 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -544,11 +544,10 @@ static int gl518_probe(struct i2c_client *client,
 	struct gl518_data *data;
 	int err, revision;
 
-	data = kzalloc(sizeof(struct gl518_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct gl518_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	revision = gl518_read_value(client, GL518_REG_REVISION);
@@ -562,7 +561,7 @@ static int gl518_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &gl518_group);
 	if (err)
-		goto exit_free;
+		return err;
 	if (data->type = gl518sm_r80) {
 		err = sysfs_create_group(&client->dev.kobj, &gl518_group_r80);
 		if (err)
@@ -581,9 +580,6 @@ exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &gl518_group);
 	if (data->type = gl518sm_r80)
 		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -617,7 +613,6 @@ static int gl518_remove(struct i2c_client *client)
 	if (data->type = gl518sm_r80)
 		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
