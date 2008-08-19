From: Ben Hutchings <bhutchings@solarflare.com>
Date: Tue, 19 Aug 2008 15:02:29 +0000
Subject: [lm-sensors] [PATCH 2/2] lm87: Add support for configuration
Message-Id: <20080819150228.GI7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The lm87 driver normally assumes that firmware configured the chip
correctly.  Since this is not always the case, alllow platform code to
set the channel register value via platform_data.  All other
configuration registers can be changed after driver initialisation.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index ddad6fc..1f5cac5 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -21,11 +21,12 @@
  *   http://www.national.com/pf/LM/LM87.html
  *
  * Some functions share pins, so not all functions are available at the same
- * time. Which are depends on the hardware setup. This driver assumes that
- * the BIOS configured the chip correctly. In that respect, it  differs from
- * the original driver (from lm_sensors for Linux 2.4), which would force the
- * LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
- * chipset wiring.
+ * time. Which are depends on the hardware setup. This driver normally
+ * assumes that firmware configured the chip correctly. Where this is not
+ * the case, platform code must set the I2C client's platform_data to point
+ * to a u8 value to be written to the channel register. In that case the
+ * driver will assume that it is the only user of the chip and will reset
+ * it in the probe and remove functions.
  * For reference, here is the list of exclusive functions:
  *  - in0+in5 (default) or temp3
  *  - fan1 (default) or in6
@@ -731,7 +732,7 @@ static int lm87_probe(struct i2c_client *new_client,
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
-		goto exit_free;
+		goto exit_reset;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
 		if ((err = device_create_file(&new_client->dev,
@@ -831,7 +832,10 @@ static int lm87_probe(struct i2c_client *new_client,
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
-exit_free:
+exit_reset:
+	if (new_client->dev.platform_data)
+		lm87_write_value(new_client, LM87_REG_CONFIG, 0x80);
+
 	kfree(data);
 exit:
 	return err;
@@ -842,9 +846,17 @@ static void lm87_init_client(struct i2c_client *client)
 	struct lm87_data *data = i2c_get_clientdata(client);
 	u8 config;
 
-	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
+	if (client->dev.platform_data) {
+		config = 0x80;
+		lm87_write_value(client, LM87_REG_CONFIG, config);
+		data->channel = *(u8 *)client->dev.platform_data;
+		lm87_write_value(client,
+				 LM87_REG_CHANNEL_MODE, data->channel);
+	} else {
+		data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
+		config = lm87_read_value(client, LM87_REG_CONFIG);
+	}
 
-	config = lm87_read_value(client, LM87_REG_CONFIG);
 	if (!(config & 0x01)) {
 		int i;
 
@@ -882,6 +894,9 @@ static int lm87_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
+	if (client->dev.platform_data)
+		lm87_write_value(client, LM87_REG_CONFIG, 0x80);
+
 	kfree(data);
 	return 0;
 }
-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
