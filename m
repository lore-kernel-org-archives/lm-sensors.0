From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:24:17 +0000
Subject: [lm-sensors] [PATCH 05/14] it87: No sysfs files for disabled fans
Message-Id: <20060828142417.66044218.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-disabled-fans.patch

it87: No sysfs files for disabled fans

Only create the fan attributes for enabled fan tachometers. Some
motherboards have a nice BIOS which only enables the fan inputs which
are wired to a fan header on the board. This makes the configuration
easier for the user.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |   83 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 32 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-27 22:42:16.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-27 22:52:20.000000000 +0200
@@ -222,6 +222,7 @@
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
+	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
 	u8 temp[3];		/* Register value */
@@ -966,38 +967,51 @@
 	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
 
+	/* Do not create fan files for disabled fans */
 	if (data->type = it8716) { /* 16-bit tachometers */
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_input16.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_input16.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_input16.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_min16.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_min16.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_min16.dev_attr);
+		if (data->has_fan & (1 << 0)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan1_input16.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan1_min16.dev_attr);
+		}
+		if (data->has_fan & (1 << 1)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan2_input16.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan2_min16.dev_attr);
+		}
+		if (data->has_fan & (1 << 2)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan3_input16.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan3_min16.dev_attr);
+		}
 	} else {
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_input.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_input.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_input.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_min.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_min.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_min.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan1_div.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan2_div.dev_attr);
-		device_create_file(&new_client->dev,
-				   &sensor_dev_attr_fan3_div.dev_attr);
+		if (data->has_fan & (1 << 0)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan1_input.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan1_min.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan1_div.dev_attr);
+		}
+		if (data->has_fan & (1 << 1)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan2_input.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan2_min.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan2_div.dev_attr);
+		}
+		if (data->has_fan & (1 << 2)) {
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan3_input.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan3_min.dev_attr);
+			device_create_file(&new_client->dev,
+				&sensor_dev_attr_fan3_div.dev_attr);
+		}
 	}
 
 	device_create_file(&new_client->dev, &dev_attr_alarms);
@@ -1174,11 +1188,12 @@
 		data->fan_main_ctrl |= 0x70;
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
+	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
 	/* Set tachometers to 16-bit mode if needed */
 	if (data->type = it8716) {
 		tmp = it87_read_value(client, IT87_REG_FAN_16BIT);
-		if ((tmp & 0x07) != 0x07) {
+		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&client->dev,
 				"Setting fan1-3 to 16-bit mode\n");
 			it87_write_value(client, IT87_REG_FAN_16BIT,
@@ -1243,6 +1258,10 @@
 		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
+			/* Skip disabled fans */
+			if (!(data->has_fan & (1 << i)))
+				continue;
+
 			data->fan_min[i]  			    it87_read_value(client, IT87_REG_FAN_MIN(i));
 			data->fan[i] = it87_read_value(client,
@@ -1265,7 +1284,7 @@
 		}
 
 		/* Newer chips don't have clock dividers */
-		if (data->type != it8716) {
+		if ((data->has_fan & 0x07) && data->type != it8716) {
 			i = it87_read_value(client, IT87_REG_FAN_DIV);
 			data->fan_div[0] = i & 0x07;
 			data->fan_div[1] = (i >> 3) & 0x07;

-- 
Jean Delvare

