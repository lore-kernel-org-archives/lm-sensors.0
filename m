From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 18:10:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Clean up detect function
Message-Id: <20091006201033.046eecf1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
The patch looks large, but most of it is really only removing one
depth of indentation.

 drivers/hwmon/w83781d.c |  131 +++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 78 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/w83781d.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/w83781d.c	2009-10-06 11:55:34.000000000 +0200
@@ -1054,11 +1054,11 @@ static int
 w83781d_detect(struct i2c_client *client, int kind,
 	       struct i2c_board_info *info)
 {
-	int val1 = 0, val2;
+	int val1, val2;
 	struct w83781d_data *isa = w83781d_data_if_isa();
 	struct i2c_adapter *adapter = client->adapter;
 	int address = client->addr;
-	const char *client_name = "";
+	const char *client_name;
 	enum vendor { winbond, asus } vendid;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -1070,98 +1070,73 @@ w83781d_detect(struct i2c_client *client
 	if (isa)
 		mutex_lock(&isa->update_lock);
 
-	/* The w8378?d may be stuck in some other bank than bank 0. This may
-	   make reading other information impossible. Specify a force=... or
-	   force_*=... parameter, and the Winbond will be reset to the right
-	   bank. */
-	if (kind < 0) {
-		if (i2c_smbus_read_byte_data
-		    (client, W83781D_REG_CONFIG) & 0x80) {
-			dev_dbg(&adapter->dev, "Detection of w83781d chip "
-				"failed at step 3\n");
-			goto err_nodev;
-		}
-		val1 = i2c_smbus_read_byte_data(client, W83781D_REG_BANK);
-		val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
-		/* Check for Winbond or Asus ID if in bank 0 */
-		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
-		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
-			dev_dbg(&adapter->dev, "Detection of w83781d chip "
-				"failed at step 4\n");
+	if (i2c_smbus_read_byte_data(client, W83781D_REG_CONFIG) & 0x80) {
+		dev_dbg(&adapter->dev,
+			"Detection of w83781d chip failed at step 3\n");
+		goto err_nodev;
+	}
+
+	val1 = i2c_smbus_read_byte_data(client, W83781D_REG_BANK);
+	val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
+	/* Check for Winbond or Asus ID if in bank 0 */
+	if (!(val1 & 0x07) &&
+	    ((!(val1 & 0x80) && val2 != 0xa3 && val2 != 0xc3) ||
+	     ( (val1 & 0x80) && val2 != 0x5c && val2 != 0x12))) {
+		dev_dbg(&adapter->dev,
+			"Detection of w83781d chip failed at step 4\n");
+		goto err_nodev;
+	}
+	/* If Winbond SMBus, check address at 0x48.
+	   Asus doesn't support, except for as99127f rev.2 */
+	if ((!(val1 & 0x80) && val2 = 0xa3) ||
+	    ( (val1 & 0x80) && val2 = 0x5c)) {
+		if (i2c_smbus_read_byte_data(client, W83781D_REG_I2C_ADDR)
+		    != address) {
+			dev_dbg(&adapter->dev,
+				"Detection of w83781d chip failed at step 5\n");
 			goto err_nodev;
 		}
-		/* If Winbond SMBus, check address at 0x48.
-		   Asus doesn't support, except for as99127f rev.2 */
-		if ((!(val1 & 0x80) && (val2 = 0xa3)) ||
-		    ((val1 & 0x80) && (val2 = 0x5c))) {
-			if (i2c_smbus_read_byte_data
-			    (client, W83781D_REG_I2C_ADDR) != address) {
-				dev_dbg(&adapter->dev, "Detection of w83781d "
-					"chip failed at step 5\n");
-				goto err_nodev;
-			}
-		}
 	}
 
-	/* We have either had a force parameter, or we have already detected the
-	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
+	/* Put it now into bank 0 and Vendor ID High Byte */
 	i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
 		(i2c_smbus_read_byte_data(client, W83781D_REG_BANK)
 		 & 0x78) | 0x80);
 
-	/* Determine the chip type. */
-	if (kind <= 0) {
-		/* get vendor ID */
-		val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
-		if (val2 = 0x5c)
-			vendid = winbond;
-		else if (val2 = 0x12)
-			vendid = asus;
-		else {
-			dev_dbg(&adapter->dev, "w83781d chip vendor is "
-				"neither Winbond nor Asus\n");
-			goto err_nodev;
-		}
-
-		val1 = i2c_smbus_read_byte_data(client, W83781D_REG_WCHIPID);
-		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
-			kind = w83781d;
-		else if (val1 = 0x30 && vendid = winbond)
-			kind = w83782d;
-		else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
-			kind = w83783s;
-		else if (val1 = 0x31)
-			kind = as99127f;
-		else {
-			if (kind = 0)
-				dev_warn(&adapter->dev, "Ignoring 'force' "
-					 "parameter for unknown chip at "
-					 "address 0x%02x\n", address);
-			goto err_nodev;
-		}
-
-		if ((kind = w83781d || kind = w83782d)
-		 && w83781d_alias_detect(client, val1)) {
-			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
-				"be the same as ISA device\n", address);
-			goto err_nodev;
-		}
+	/* Get the vendor ID */
+	val2 = i2c_smbus_read_byte_data(client, W83781D_REG_CHIPMAN);
+	if (val2 = 0x5c)
+		vendid = winbond;
+	else if (val2 = 0x12)
+		vendid = asus;
+	else {
+		dev_dbg(&adapter->dev,
+			"w83781d chip vendor is neither Winbond nor Asus\n");
+		goto err_nodev;
 	}
 
-	if (isa)
-		mutex_unlock(&isa->update_lock);
-
-	if (kind = w83781d) {
+	/* Determine the chip type. */
+	val1 = i2c_smbus_read_byte_data(client, W83781D_REG_WCHIPID);
+	if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
 		client_name = "w83781d";
-	} else if (kind = w83782d) {
+	else if (val1 = 0x30 && vendid = winbond)
 		client_name = "w83782d";
-	} else if (kind = w83783s) {
+	else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
 		client_name = "w83783s";
-	} else if (kind = as99127f) {
+	else if (val1 = 0x31)
 		client_name = "as99127f";
+	else
+		goto err_nodev;
+
+	if (val1 <= 0x30 && w83781d_alias_detect(client, val1)) {
+		dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
+			"be the same as ISA device\n", address);
+		goto err_nodev;
 	}
 
+	if (isa)
+		mutex_unlock(&isa->update_lock);
+
 	strlcpy(info->type, client_name, I2C_NAME_SIZE);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
