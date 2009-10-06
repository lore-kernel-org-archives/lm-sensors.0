From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 18:09:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83l785ts) Clean up detect function
Message-Id: <20091006200958.1141f32d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As kind is now hard-coded to -1, there is room for code clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83l785ts.c |   70 ++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/w83l785ts.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/w83l785ts.c	2009-10-06 12:14:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * w83l785ts.c - Part of lm_sensors, Linux kernel modules for hardware
  *               monitoring
- * Copyright (C) 2003-2004  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2009  Jean Delvare <khali@linux-fr.org>
  *
  * Inspired from the lm83 driver. The W83L785TS-S is a sensor chip made
  * by Winbond. It reports a single external temperature with a 1 deg
@@ -146,60 +146,36 @@ static SENSOR_DEVICE_ATTR(temp1_max, S_I
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int w83l785ts_detect(struct i2c_client *new_client, int kind,
+static int w83l785ts_detect(struct i2c_client *client, int kind,
 			    struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
+	u16 man_id;
+	u8 chip_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/*
-	 * Now we do the remaining detection. A negative kind means that
-	 * the driver was loaded with no force parameter (default), so we
-	 * must both detect and identify the chip (actually there is only
-	 * one possible kind of chip for now, W83L785TS-S). A zero kind means
-	 * that the driver was loaded with the force parameter, the detection
-	 * step shall be skipped. A positive kind means that the driver
-	 * was loaded with the force parameter and a given kind of chip is
-	 * requested, so both the detection and the identification steps
-	 * are skipped.
-	 */
-	if (kind < 0) { /* detection */
-		if (((w83l785ts_read_value(new_client,
-		      W83L785TS_REG_CONFIG, 0) & 0x80) != 0x00)
-		 || ((w83l785ts_read_value(new_client,
-		      W83L785TS_REG_TYPE, 0) & 0xFC) != 0x00)) {
-			dev_dbg(&adapter->dev,
-				"W83L785TS-S detection failed at 0x%02x.\n",
-				new_client->addr);
-			return -ENODEV;
-		}
+	/* detection */
+	if ((w83l785ts_read_value(client, W83L785TS_REG_CONFIG, 0) & 0x80)
+	 || (w83l785ts_read_value(client, W83L785TS_REG_TYPE, 0) & 0xFC)) {
+		dev_dbg(&adapter->dev,
+			"W83L785TS-S detection failed at 0x%02x\n",
+			client->addr);
+		return -ENODEV;
 	}
 
-	if (kind <= 0) { /* identification */
-		u16 man_id;
-		u8 chip_id;
-
-		man_id = (w83l785ts_read_value(new_client,
-			 W83L785TS_REG_MAN_ID1, 0) << 8) +
-			 w83l785ts_read_value(new_client,
-			 W83L785TS_REG_MAN_ID2, 0);
-		chip_id = w83l785ts_read_value(new_client,
-			  W83L785TS_REG_CHIP_ID, 0);
-
-		if (man_id = 0x5CA3) { /* Winbond */
-			if (chip_id = 0x70) { /* W83L785TS-S */
-				kind = w83l785ts;			
-			}
-		}
-	
-		if (kind <= 0) { /* identification failed */
-			dev_info(&adapter->dev,
-				 "Unsupported chip (man_id=0x%04X, "
-				 "chip_id=0x%02X).\n", man_id, chip_id);
-			return -ENODEV;
-		}
+	/* Identification */
+	man_id = (w83l785ts_read_value(client, W83L785TS_REG_MAN_ID1, 0) << 8)
+	       + w83l785ts_read_value(client, W83L785TS_REG_MAN_ID2, 0);
+	chip_id = w83l785ts_read_value(client, W83L785TS_REG_CHIP_ID, 0);
+
+	if (man_id != 0x5CA3		/* Winbond */
+	 || chip_id != 0x70) {		/* W83L785TS-S */
+		dev_dbg(&adapter->dev,
+			"Unsupported chip (man_id=0x%04X, chip_id=0x%02X)\n",
+			man_id, chip_id);
+		return -ENODEV;
 	}
 
 	strlcpy(info->type, "w83l785ts", I2C_NAME_SIZE);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
