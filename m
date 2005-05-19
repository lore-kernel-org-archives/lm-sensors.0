From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 reset option
Message-Id: <20040228183508.200a8655.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Greg,

I wrote a patch which adds reset option to the it87 driver talking
with Jean Delvare.

* Do not reset the registers unless users want to do because
  resetting registers makes all fans go to full power and we can
  usually rely on values set by BIOS
* Remove all limit initializations as they should be done from
  user-space
* Better register mask for start of monitoring

The patch has been reviewed by Jean.

Thanks in advance.


Jean,

Thanks for your kind advices! I'll go on with the next part.


--- linux-2.6.3/drivers/i2c/chips/it87.c.sensor_type	2004-02-25 10:27:21.000000000 +0900
+++ linux-2.6.3/drivers/i2c/chips/it87.c	2004-02-28 13:38:21.000000000 +0900
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -822,80 +825,45 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new IT87. It should set limits, etc. */
+/* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others */
-	it87_write_value(client, IT87_REG_CONFIG, 0x80);
-	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0));
-	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0));
-	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1));
-	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1));
-	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2));
-	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2));
-	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3));
-	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3));
-	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4));
-	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4));
-	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5));
-	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5));
-	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6));
-	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6));
-	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7));
-	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7));
-	/* Note: Battery voltage does not have limit registers */
-	it87_write_value(client, IT87_REG_FAN_MIN(0),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(1),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(2),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
-	it87_write_value(client, IT87_REG_TEMP_LOW(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
-	it87_write_value(client, IT87_REG_TEMP_LOW(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
-	it87_write_value(client, IT87_REG_TEMP_LOW(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
-
-	/* Enable voltage monitors */
-	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
-
-	/* Enable Temp1-Temp3 */
-	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	int tmp;
+
+	if (reset) {
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+
+	}
 
-	/* Enable fans */
-	it87_write_value(client, IT87_REG_FAN_CTRL,
-			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
-			| 0x70);
+	/* Check if temperature channnels are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+	if ((tmp & 0x3f) = 0) {
+		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
+		tmp = (tmp & 0xc0) | 0x2a;
+		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
+	}
+	data->sensor = tmp;
+
+	/* Check if voltage monitors are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_VIN_ENABLE);
+	if ((tmp & 0xff) = 0) {
+		/* Enable all voltage monitors */
+		it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+	}
+
+	/* Check if tachometers are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_FAN_CTRL);
+	if ((tmp & 0x70) = 0) {
+		/* Enable all fan tachometers */
+		tmp = (tmp & 0x8f) | 0x70;
+		it87_write_value(client, IT87_REG_FAN_CTRL, tmp);
+	}
 
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
@@ -988,6 +956,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);



-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
