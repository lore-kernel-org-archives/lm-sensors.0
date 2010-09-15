From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:06 +0000
Subject: [lm-sensors] [patch 03/36] hwmon: (w83795) Drop duplicate enum
Message-Id: <20100915155506.459b6369@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Enum chips and chip_types are redundant, get rid of the former. Fix
the detection code to properly identify the chip variant and name the
client accordingly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:10:49.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:14.000000000 +0200
@@ -38,8 +38,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 
-enum chips { w83795 };
-
 
 static int reset;
 module_param(reset, bool, 0);
@@ -1686,6 +1684,7 @@ static int w83795_detect(struct i2c_clie
 	u8 tmp, bank;
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
+	const char *chip_name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -1718,18 +1717,21 @@ static int w83795_detect(struct i2c_clie
 		return -ENODEV;
 	}
 
-#if 0
-	/* Check 795 chip type: 795G or 795ADG */
+	/* Check 795 chip type: 795G or 795ADG
+	   Usually we don't write to chips during detection, but here we don't
+	   quite have the choice; hopefully it's OK, we are about to return
+	   success anyway */
+	if ((bank & 0x07) != 0)
+		i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL,
+					  bank & ~0x07);
 	if (W83795_REG_CONFIG_CONFIG48 &
-		  w83795_read(client, W83795_REG_CONFIG)) {
-		data->chip_type = w83795adg;
+		  i2c_smbus_read_byte_data(client, W83795_REG_CONFIG)) {
+		chip_name = "w83795adg";
 	} else {
-		data->chip_type = w83795g;
+		chip_name = "w83795g";
 	}
-#endif
 
-	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(info->type, "w83795", I2C_NAME_SIZE);
+	strlcpy(info->type, chip_name, I2C_NAME_SIZE);
 
 	return 0;
 }
@@ -1750,20 +1752,13 @@ static int w83795_probe(struct i2c_clien
 	}
 
 	i2c_set_clientdata(client, data);
+	data->chip_type = id->driver_data;
 	data->bank = i2c_smbus_read_byte_data(client, W83795_REG_BANKSEL);
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chip */
 	w83795_init_client(client);
 
-	/* Check 795 chip type: 795G or 795ADG */
-	if (W83795_REG_CONFIG_CONFIG48 &
-		  w83795_read(client, W83795_REG_CONFIG)) {
-		data->chip_type = w83795adg;
-	} else {
-		data->chip_type = w83795g;
-	}
-
 	data->has_in = w83795_read(client, W83795_REG_VOLT_CTRL1);
 	data->has_in |= w83795_read(client, W83795_REG_VOLT_CTRL2) << 8;
 	/* VSEN11-9 not for 795adg */
@@ -2097,7 +2092,8 @@ static int w83795_remove(struct i2c_clie
 
 
 static const struct i2c_device_id w83795_id[] = {
-	{ "w83795", w83795 },
+	{ "w83795g", w83795g },
+	{ "w83795adg", w83795adg },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83795_id);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
