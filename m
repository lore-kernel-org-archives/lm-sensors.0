From: David Brownell <david-b@pacbell.net>
Date: Fri, 25 Jul 2008 23:44:34 +0000
Subject: [lm-sensors] Fwd: [PATCH 4/4] i2c: Drop legacy lm75 driver
Message-Id: <200807251644.34244.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Seems the conversion of the lm75 driver which I mentioned earlier
has already been done ... I *think* this is the latest version.  ;)


----------  Forwarded Message  ----------

Subject: [PATCH 4/4] i2c: Drop legacy lm75 driver
Date: Friday 06 June 2008
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>

Drop the legacy lm75 driver, and add a detect callback to the
new-style driver to achieve the same functionality.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This goes on top of David Brownell's patches:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022931.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023040.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023041.html

Also available from:
http://jdelvare.pck.nerim.net/sensors/lm75/

 drivers/hwmon/lm75.c |  120 ++++++++++++++------------------------------------
 1 file changed, 35 insertions(+), 85 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/hwmon/lm75.c	2008-06-05 21:04:26.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/lm75.c	2008-06-05 22:19:23.000000000 +0200
@@ -54,11 +54,11 @@ enum lm75_type {		/* keep sorted in alph
 	tmp75,
 };
 
-/* Addresses scanned by legacy style driver binding */
+/* Addresses scanned */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-/* Insmod parameters (only for legacy style driver binding) */
+/* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm75);
 
 
@@ -217,46 +217,12 @@ static int lm75_remove(struct i2c_client
 	return 0;
 }
 
-static const struct i2c_device_id lm75_ids[] = {
-	{ "ds1775", ds1775, },
-	{ "ds75", ds75, },
-	{ "lm75", lm75, },
-	{ "lm75a", lm75a, },
-	{ "max6625", max6625, },
-	{ "max6626", max6626, },
-	{ "mcp980x", mcp980x, },
-	{ "stds75", stds75, },
-	{ "tcn75", tcn75, },
-	{ "tmp100", tmp100, },
-	{ "tmp101", tmp101, },
-	{ "tmp175", tmp175, },
-	{ "tmp275", tmp275, },
-	{ "tmp75", tmp75, },
-	{ /* LIST END */ }
-};
-MODULE_DEVICE_TABLE(i2c, lm75_ids);
-
-static struct i2c_driver lm75_driver = {
-	.driver = {
-		.name	= "lm75",
-	},
-	.probe		= lm75_probe,
-	.remove		= lm75_remove,
-	.id_table	= lm75_ids,
-};
-
-/*-----------------------------------------------------------------------*/
-
-/* "Legacy" I2C driver binding */
-
-static struct i2c_driver lm75_legacy_driver;
-
-/* This function is called by i2c_probe */
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm75_detect(struct i2c_adapter *adapter, int address, int kind,
+		       struct i2c_board_info *info)
 {
 	int i;
 	struct i2c_client *new_client;
-	int err = 0;
+	int err = -ENODEV;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
@@ -273,8 +239,6 @@ static int lm75_detect(struct i2c_adapte
 
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm75_legacy_driver;
-	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. There is no identification-
 	   dedicated register so we have to rely on several tricks:
@@ -313,52 +277,49 @@ static int lm75_detect(struct i2c_adapte
 			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
 				goto exit_free;
 	}
+	err = 0;	/* detection OK */
 
 	/* NOTE: we treat "force=..." and "force_lm75=..." the same.
 	 * Only new-style driver binding distinguishes chip types.
 	 */
-	strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
-
-	/* Tell the I2C layer a new client has arrived */
-	err = i2c_attach_client(new_client);
-	if (err)
-		goto exit_free;
-
-	err = lm75_probe(new_client, NULL);
-	if (err < 0)
-		goto exit_detach;
+	strlcpy(info->type, "lm75", I2C_NAME_SIZE);
+	info->addr = address;
 
-	return 0;
-
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(new_client);
 exit:
 	return err;
 }
 
-static int lm75_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm75_detect);
-}
-
-static int lm75_detach_client(struct i2c_client *client)
-{
-	lm75_remove(client);
-	i2c_detach_client(client);
-	kfree(client);
-	return 0;
-}
+static const struct i2c_device_id lm75_ids[] = {
+	{ "ds1775", ds1775, },
+	{ "ds75", ds75, },
+	{ "lm75", lm75, },
+	{ "lm75a", lm75a, },
+	{ "max6625", max6625, },
+	{ "max6626", max6626, },
+	{ "mcp980x", mcp980x, },
+	{ "stds75", stds75, },
+	{ "tcn75", tcn75, },
+	{ "tmp100", tmp100, },
+	{ "tmp101", tmp101, },
+	{ "tmp175", tmp175, },
+	{ "tmp275", tmp275, },
+	{ "tmp75", tmp75, },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, lm75_ids);
 
-static struct i2c_driver lm75_legacy_driver = {
+static struct i2c_driver lm75_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
-		.name	= "lm75_legacy",
+		.name	= "lm75",
 	},
-	.attach_adapter	= lm75_attach_adapter,
-	.detach_client	= lm75_detach_client,
+	.probe		= lm75_probe,
+	.remove		= lm75_remove,
+	.id_table	= lm75_ids,
+	.detect		= lm75_detect,
+	.address_data	= &addr_data,
 };
 
 /*-----------------------------------------------------------------------*/
@@ -424,22 +385,11 @@ static struct lm75_data *lm75_update_dev
 
 static int __init sensors_lm75_init(void)
 {
-	int status;
-
-	status = i2c_add_driver(&lm75_driver);
-	if (status < 0)
-		return status;
-
-	status = i2c_add_driver(&lm75_legacy_driver);
-	if (status < 0)
-		i2c_del_driver(&lm75_driver);
-
-	return status;
+	return i2c_add_driver(&lm75_driver);
 }
 
 static void __exit sensors_lm75_exit(void)
 {
-	i2c_del_driver(&lm75_legacy_driver);
 	i2c_del_driver(&lm75_driver);
 }
 

-- 
Jean Delvare

-------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
