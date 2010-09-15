From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:55:27 +0000
Subject: [lm-sensors] [patch 05/36] hwmon: (w83795) Improve detection routine
Message-Id: <20100915155527.1138fee9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Check for additional identification registers. Improve debugging
messages on failed detection.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   80 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 23 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:11:39.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:11:42.000000000 +0200
@@ -48,6 +48,7 @@ MODULE_PARM_DESC(reset, "Set to 1 to res
 #define W83795_REG_VENDORID		0xfd
 #define W83795_REG_CHIPID		0xfe
 #define W83795_REG_DEVICEID		0xfb
+#define W83795_REG_DEVICEID_A		0xff
 
 #define W83795_REG_I2C_ADDR		0xfc
 #define W83795_REG_CONFIG		0x01
@@ -1684,11 +1685,31 @@ static void w83795_init_client(struct i2
 		     w83795_read(client, W83795_REG_CONFIG) | 0x01);
 }
 
+static int w83795_get_device_id(struct i2c_client *client)
+{
+	int device_id;
+
+	device_id = i2c_smbus_read_byte_data(client, W83795_REG_DEVICEID);
+
+	/* Special case for rev. A chips; can't be checked first because later
+	   revisions emulate this for compatibility */
+	if (device_id < 0 || (device_id & 0xf0) != 0x50) {
+		int alt_id;
+
+		alt_id = i2c_smbus_read_byte_data(client,
+						  W83795_REG_DEVICEID_A);
+		if (alt_id = 0x50)
+			device_id = alt_id;
+	}
+
+	return device_id;
+}
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int w83795_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
-	u8 tmp, bank;
+	int bank, vendor_id, device_id, expected, i2c_addr, config;
 	struct i2c_adapter *adapter = client->adapter;
 	unsigned short address = client->addr;
 	const char *chip_name;
@@ -1696,32 +1717,44 @@ static int w83795_detect(struct i2c_clie
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 	bank = i2c_smbus_read_byte_data(client, W83795_REG_BANKSEL);
+	if (bank < 0 || (bank & 0x7c)) {
+		dev_dbg(&adapter->dev,
+			"w83795: Detection failed at addr 0x%02hx, check %s\n",
+			address, "bank");
+		return -ENODEV;
+	}
 
-	tmp = bank & 0x80 ? 0x5c : 0xa3;
 	/* Check Nuvoton vendor ID */
-	if (tmp != i2c_smbus_read_byte_data(client,
-						W83795_REG_VENDORID)) {
-		pr_debug("w83795: Detection failed at check "
-			 "vendor id\n");
+	vendor_id = i2c_smbus_read_byte_data(client, W83795_REG_VENDORID);
+	expected = bank & 0x80 ? 0x5c : 0xa3;
+	if (vendor_id != expected) {
+		dev_dbg(&adapter->dev,
+			"w83795: Detection failed at addr 0x%02hx, check %s\n",
+			address, "vendor id");
 		return -ENODEV;
 	}
 
-	/* If Nuvoton chip, address of chip and W83795_REG_I2C_ADDR
-	   should match */
-	if ((bank & 0x07) = 0
-	 && (i2c_smbus_read_byte_data(client, W83795_REG_I2C_ADDR) & 0x7f) !-	    address) {
-		pr_debug("w83795: Detection failed at check "
-			 "i2c addr\n");
+	/* Check device ID */
+	device_id = w83795_get_device_id(client) |
+		    (i2c_smbus_read_byte_data(client, W83795_REG_CHIPID) << 8);
+	if ((device_id >> 4) != 0x795) {
+		dev_dbg(&adapter->dev,
+			"w83795: Detection failed at addr 0x%02hx, check %s\n",
+			address, "device id\n");
 		return -ENODEV;
 	}
 
-	/* Determine the chip type now */
-	if (0x79 != i2c_smbus_read_byte_data(client,
-					     W83795_REG_CHIPID)) {
-		pr_debug("w83795: Detection failed at check "
-			 "chip id\n");
-		return -ENODEV;
+	/* If Nuvoton chip, address of chip and W83795_REG_I2C_ADDR
+	   should match */
+	if ((bank & 0x07) = 0) {
+		i2c_addr = i2c_smbus_read_byte_data(client,
+						    W83795_REG_I2C_ADDR);
+		if ((i2c_addr & 0x7f) != address) {
+			dev_dbg(&adapter->dev,
+				"w83795: Detection failed at addr 0x%02hx, "
+				"check %s\n", address, "i2c addr");
+			return -ENODEV;
+		}
 	}
 
 	/* Check 795 chip type: 795G or 795ADG
@@ -1731,14 +1764,15 @@ static int w83795_detect(struct i2c_clie
 	if ((bank & 0x07) != 0)
 		i2c_smbus_write_byte_data(client, W83795_REG_BANKSEL,
 					  bank & ~0x07);
-	if (W83795_REG_CONFIG_CONFIG48 &
-		  i2c_smbus_read_byte_data(client, W83795_REG_CONFIG)) {
+	config = i2c_smbus_read_byte_data(client, W83795_REG_CONFIG);
+	if (config & W83795_REG_CONFIG_CONFIG48)
 		chip_name = "w83795adg";
-	} else {
+	else
 		chip_name = "w83795g";
-	}
 
 	strlcpy(info->type, chip_name, I2C_NAME_SIZE);
+	dev_info(&adapter->dev, "Found %s rev. %c at 0x%02hx\n", chip_name,
+		 'A' + (device_id & 0xf), address);
 
 	return 0;
 }


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
