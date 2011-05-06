From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 May 2011 11:33:38 +0000
Subject: [lm-sensors] [[PATCH 1/2] hwmon: (max6650) Drop device detection
Message-Id: <20110506133338.4df4dc58@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (max6650) Drop device detection

MAX6650 device detection is unreliable, we got reports of false
positives. We now have many ways to let users instantiate the devices
explicitly, so unreliable detection should be dropped.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
---
 Documentation/hwmon/max6650 |    9 +++++++-
 drivers/hwmon/max6650.c     |   44 -------------------------------------------
 2 files changed, 8 insertions(+), 45 deletions(-)

--- linux-2.6.39-rc6.orig/Documentation/hwmon/max6650	2011-05-06 13:07:38.000000000 +0200
+++ linux-2.6.39-rc6/Documentation/hwmon/max6650	2011-05-06 13:13:01.000000000 +0200
@@ -4,7 +4,7 @@ Kernel driver max6650
 Supported chips:
   * Maxim 6650 / 6651
     Prefix: 'max6650'
-    Addresses scanned: I2C 0x1b, 0x1f, 0x48, 0x4b
+    Addresses scanned: none
     Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
 
 Authors:
@@ -36,6 +36,13 @@ fan1_div	rw	sets the speed range the inp
 			values are 1, 2, 4, and 8. Use lower values for
 			faster fans.
 
+Usage notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
 Module parameters
 -----------------
 
--- linux-2.6.39-rc6.orig/drivers/hwmon/max6650.c	2011-05-06 13:07:38.000000000 +0200
+++ linux-2.6.39-rc6/drivers/hwmon/max6650.c	2011-05-06 13:12:16.000000000 +0200
@@ -41,13 +41,6 @@
 #include <linux/err.h>
 
 /*
- * Addresses to scan. There are four disjoint possibilities, by pin config.
- */
-
-static const unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b,
-						I2C_CLIENT_END};
-
-/*
  * Insmod parameters
  */
 
@@ -114,8 +107,6 @@ module_param(clock, int, S_IRUGO);
 
 static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int max6650_detect(struct i2c_client *client,
-			  struct i2c_board_info *info);
 static int max6650_init_client(struct i2c_client *client);
 static int max6650_remove(struct i2c_client *client);
 static struct max6650_data *max6650_update_device(struct device *dev);
@@ -131,15 +122,12 @@ static const struct i2c_device_id max665
 MODULE_DEVICE_TABLE(i2c, max6650_id);
 
 static struct i2c_driver max6650_driver = {
-	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "max6650",
 	},
 	.probe		= max6650_probe,
 	.remove		= max6650_remove,
 	.id_table	= max6650_id,
-	.detect		= max6650_detect,
-	.address_list	= normal_i2c,
 };
 
 /*
@@ -525,38 +513,6 @@ static struct attribute_group max6650_at
  * Real code
  */
 
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int max6650_detect(struct i2c_client *client,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	int address = client->addr;
-
-	dev_dbg(&adapter->dev, "max6650_detect called\n");
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_dbg(&adapter->dev, "max6650: I2C bus doesn't support "
-					"byte read mode, skipping.\n");
-		return -ENODEV;
-	}
-
-	if (((i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG) & 0xC0)
-	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_GPIO_STAT) & 0xE0)
-	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN) & 0xE0)
-	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM) & 0xE0)
-	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_COUNT) & 0xFC))) {
-		dev_dbg(&adapter->dev,
-			"max6650: detection failed at 0x%02x.\n", address);
-		return -ENODEV;
-	}
-
-	dev_info(&adapter->dev, "max6650: chip found at 0x%02x.\n", address);
-
-	strlcpy(info->type, "max6650", I2C_NAME_SIZE);
-
-	return 0;
-}
-
 static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
