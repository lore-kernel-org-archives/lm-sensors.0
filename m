From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 17:43:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm77) Clean up detect function
Message-Id: <20091006194309.0ce16c32@hyperion.delvare>
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

 drivers/hwmon/lm77.c |   78 ++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/lm77.c	2009-10-06 10:33:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/lm77.c	2009-10-06 11:44:30.000000000 +0200
@@ -249,6 +249,7 @@ static int lm77_detect(struct i2c_client
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
+	int i, cur, conf, hyst, crit, min, max;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
@@ -265,51 +266,48 @@ static int lm77_detect(struct i2c_client
 	   4. registers cycling over 8-address boundaries
 
 	   Word-sized registers are high-byte first. */
-	if (kind < 0) {
-		int i, cur, conf, hyst, crit, min, max;
 
-		/* addresses cycling */
-		cur = i2c_smbus_read_word_data(new_client, 0);
-		conf = i2c_smbus_read_byte_data(new_client, 1);
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		crit = i2c_smbus_read_word_data(new_client, 3);
-		min = i2c_smbus_read_word_data(new_client, 4);
-		max = i2c_smbus_read_word_data(new_client, 5);
-		for (i = 8; i <= 0xff; i += 8)
-			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-			    || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-			    || i2c_smbus_read_word_data(new_client, i + 3) != crit
-			    || i2c_smbus_read_word_data(new_client, i + 4) != min
-			    || i2c_smbus_read_word_data(new_client, i + 5) != max)
-				return -ENODEV;
-
-		/* sign bits */
-		if (((cur & 0x00f0) != 0xf0 && (cur & 0x00f0) != 0x0)
-		    || ((hyst & 0x00f0) != 0xf0 && (hyst & 0x00f0) != 0x0)
-		    || ((crit & 0x00f0) != 0xf0 && (crit & 0x00f0) != 0x0)
-		    || ((min & 0x00f0) != 0xf0 && (min & 0x00f0) != 0x0)
-		    || ((max & 0x00f0) != 0xf0 && (max & 0x00f0) != 0x0))
+	/* addresses cycling */
+	cur = i2c_smbus_read_word_data(new_client, 0);
+	conf = i2c_smbus_read_byte_data(new_client, 1);
+	hyst = i2c_smbus_read_word_data(new_client, 2);
+	crit = i2c_smbus_read_word_data(new_client, 3);
+	min = i2c_smbus_read_word_data(new_client, 4);
+	max = i2c_smbus_read_word_data(new_client, 5);
+	for (i = 8; i <= 0xff; i += 8) {
+		if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
+		 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
+		 || i2c_smbus_read_word_data(new_client, i + 3) != crit
+		 || i2c_smbus_read_word_data(new_client, i + 4) != min
+		 || i2c_smbus_read_word_data(new_client, i + 5) != max)
 			return -ENODEV;
+	}
 
-		/* unused bits */
-		if (conf & 0xe0)
-			return -ENODEV;
+	/* sign bits */
+	if (((cur & 0x00f0) != 0xf0 && (cur & 0x00f0) != 0x0)
+	 || ((hyst & 0x00f0) != 0xf0 && (hyst & 0x00f0) != 0x0)
+	 || ((crit & 0x00f0) != 0xf0 && (crit & 0x00f0) != 0x0)
+	 || ((min & 0x00f0) != 0xf0 && (min & 0x00f0) != 0x0)
+	 || ((max & 0x00f0) != 0xf0 && (max & 0x00f0) != 0x0))
+		return -ENODEV;
 
-		/* 0x06 and 0x07 return the last read value */
-		cur = i2c_smbus_read_word_data(new_client, 0);
-		if (i2c_smbus_read_word_data(new_client, 6) != cur
-		    || i2c_smbus_read_word_data(new_client, 7) != cur)
-			return -ENODEV;
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		if (i2c_smbus_read_word_data(new_client, 6) != hyst
-		    || i2c_smbus_read_word_data(new_client, 7) != hyst)
-			return -ENODEV;
-		min = i2c_smbus_read_word_data(new_client, 4);
-		if (i2c_smbus_read_word_data(new_client, 6) != min
-		    || i2c_smbus_read_word_data(new_client, 7) != min)
-			return -ENODEV;
+	/* unused bits */
+	if (conf & 0xe0)
+		return -ENODEV;
 
-	}
+	/* 0x06 and 0x07 return the last read value */
+	cur = i2c_smbus_read_word_data(new_client, 0);
+	if (i2c_smbus_read_word_data(new_client, 6) != cur
+	 || i2c_smbus_read_word_data(new_client, 7) != cur)
+		return -ENODEV;
+	hyst = i2c_smbus_read_word_data(new_client, 2);
+	if (i2c_smbus_read_word_data(new_client, 6) != hyst
+	 || i2c_smbus_read_word_data(new_client, 7) != hyst)
+		return -ENODEV;
+	min = i2c_smbus_read_word_data(new_client, 4);
+	if (i2c_smbus_read_word_data(new_client, 6) != min
+	 || i2c_smbus_read_word_data(new_client, 7) != min)
+		return -ENODEV;
 
 	strlcpy(info->type, "lm77", I2C_NAME_SIZE);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
