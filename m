From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 reset option
Message-Id: <20040301102259.31d6c3a9.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228183508.200a8655.komoriya@paken.org>
In-Reply-To: <20040228183508.200a8655.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, 28 Feb 2004 18:27:58 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> First of all, the patch leaves all INIT macros untouched. They are not
> used anywhere in the driver now, so they should go.

> No extra line here please.

Sorry for my rush patch. I should have been more careful...
I've fixed these two issues.

How about this patch?


--- linux-2.6.3/drivers/i2c/chips/it87.c.sensor_type	2004-02-25 10:27:21.000000000 +0900
+++ linux-2.6.3/drivers/i2c/chips/it87.c	2004-03-01 10:10:43.496604080 +0900
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -129,61 +132,6 @@
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* Initial limits. Use the config file to set better limits. */
-#define IT87_INIT_IN_0 170
-#define IT87_INIT_IN_1 250
-#define IT87_INIT_IN_2 (330 / 2)
-#define IT87_INIT_IN_3 (((500)   * 100)/168)
-#define IT87_INIT_IN_4 (((1200)  * 10)/38)
-#define IT87_INIT_IN_5 (((1200)  * 10)/72)
-#define IT87_INIT_IN_6 (((500)   * 10)/56)
-#define IT87_INIT_IN_7 (((500)   * 100)/168)
-
-#define IT87_INIT_IN_PERCENTAGE 10
-
-#define IT87_INIT_IN_MIN_0 \
-	(IT87_INIT_IN_0 - IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_0 \
-	(IT87_INIT_IN_0 + IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_1 \
-	(IT87_INIT_IN_1 - IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_1 \
-	(IT87_INIT_IN_1 + IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_2 \
-	(IT87_INIT_IN_2 - IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_2 \
-	(IT87_INIT_IN_2 + IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_3 \
-	(IT87_INIT_IN_3 - IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_3 \
-	(IT87_INIT_IN_3 + IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_4 \
-	(IT87_INIT_IN_4 - IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_4 \
-	(IT87_INIT_IN_4 + IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_5 \
-	(IT87_INIT_IN_5 - IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_5 \
-	(IT87_INIT_IN_5 + IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_6 \
-	(IT87_INIT_IN_6 - IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_6 \
-	(IT87_INIT_IN_6 + IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MIN_7 \
-	(IT87_INIT_IN_7 - IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
-#define IT87_INIT_IN_MAX_7 \
-	(IT87_INIT_IN_7 + IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
-
-#define IT87_INIT_FAN_MIN_1 3000
-#define IT87_INIT_FAN_MIN_2 3000
-#define IT87_INIT_FAN_MIN_3 3000
-
-#define IT87_INIT_TEMP_HIGH_1 600
-#define IT87_INIT_TEMP_LOW_1  200
-#define IT87_INIT_TEMP_HIGH_2 600
-#define IT87_INIT_TEMP_LOW_2  200
-#define IT87_INIT_TEMP_HIGH_3 600 
-#define IT87_INIT_TEMP_LOW_3  200
 
 /* For each registered IT87, we need to keep some data in memory. That
    data is pointed to by it87_list[NR]->data. The structure itself is
@@ -822,80 +770,44 @@
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
 
-	/* Enable fans */
-	it87_write_value(client, IT87_REG_FAN_CTRL,
-			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
-			| 0x70);
+	if (reset) {
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	}
+
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
 
@@ -988,6 +900,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);



Thanks in advance.
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
