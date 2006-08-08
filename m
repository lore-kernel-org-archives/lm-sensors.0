From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Aug 2006 14:07:16 +0000
Subject: [lm-sensors] [PATCH 2/5] it87: No sysfs files for disabled fans
Message-Id: <20060808160716.a2ab189f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it87: No sysfs files for disabled fans

Only create the fan attributes for enabled fan tachometers. Some
motherboards have a nice BIOS which only enables the fan inputs which
are wired to a fan header on the board. This makes the configuration
easier for the user

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-08 12:58:56.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-08 13:02:41.000000000 +0200
@@ -221,6 +221,7 @@
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
+	u8 has_fan;		/* Bitfield, fans enabled */
 	u8 fan16;		/* Bitfield, fans in 16-bit mode */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
@@ -928,23 +929,36 @@
 	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
 
-	/* Only create the fan clock divider entries if not in 16-bit mode */
-	if (!(data->fan16 & (1 << 0)))
+	/* Do not create fan files for disabled fans. Also only create the
+	   fan clock divider entries if not in 16-bit mode. */
+	if (data->has_fan & (1 << 0)) {
 		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_div.dev_attr);
-	if (!(data->fan16 & (1 << 1)))
+				   &sensor_dev_attr_fan1_input.dev_attr);
 		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_div.dev_attr);
-	if (!(data->fan16 & (1 << 2)))
+				   &sensor_dev_attr_fan1_min.dev_attr);
+		if (!(data->fan16 & (1 << 0)))
+			device_create_file(&new_client->dev,
+					   &sensor_dev_attr_fan1_div.dev_attr);
+	}
+	if (data->has_fan & (1 << 1)) {
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan2_input.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan2_min.dev_attr);
+		if (!(data->fan16 & (1 << 1)))
+			device_create_file(&new_client->dev,
+					   &sensor_dev_attr_fan2_div.dev_attr);
+	}
+	if (data->has_fan & (1 << 2)) {
 		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_div.dev_attr);
+				   &sensor_dev_attr_fan3_input.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan3_min.dev_attr);
+		if (!(data->fan16 & (1 << 2)))
+			device_create_file(&new_client->dev,
+					   &sensor_dev_attr_fan3_div.dev_attr);
+	}
 
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (enable_pwm_interface) {
@@ -1120,13 +1134,14 @@
 		data->fan_main_ctrl |= 0x70;
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
+	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
 	/* Read and store tachometer mode */
 	if (data->type = it8716) {
 		data->fan16 = it87_read_value(client, IT87_REG_FAN_16BIT)
 			    & 0x07;
 		for (i = 0; i < 3; i++) {
-			if (data->fan16 & (1 << i)) {
+			if (data->fan16 & data->has_fan & (1 << i)) {
 				dev_dbg(&client->dev, "Using 16-bit "
 					"tachometer counter for fan%d\n",
 					i + 1);
@@ -1191,6 +1206,10 @@
 		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
+			/* Skip disabled fans */
+			if (!(data->has_fan & (1 << i)))
+				continue;
+
 			data->fan_min[i]  			    it87_read_value(client, IT87_REG_FAN_MIN(i));
 			data->fan[i] = it87_read_value(client,
@@ -1214,7 +1233,7 @@
 
 		/* If at least one fan isn't in 16-bit tachometer mode, we
 		   need the clock divider values */
-		if (~data->fan16 & 0x07) {
+		if (~data->fan16 & data->has_fan & 0x07) {
 			i = it87_read_value(client, IT87_REG_FAN_DIV);
 			data->fan_div[0] = i & 0x07;
 			data->fan_div[1] = (i >> 3) & 0x07;


-- 
Jean Delvare

