From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:48 +0000
Subject: [lm-sensors] patch hwmon-it87-disabled-fans.patch added to
Message-Id: <20060829232550.B5591895AA1@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 05/14] it87: No sysfs files for disabled fans

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-disabled-fans.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:24:24 2006
Date: Mon, 28 Aug 2006 14:24:17 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 05/14] it87: No sysfs files for disabled fans
Message-Id: <20060828142417.66044218.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-it87-disabled-fans.patch

it87: No sysfs files for disabled fans

Only create the fan attributes for enabled fan tachometers. Some
motherboards have a nice BIOS which only enables the fan inputs which
are wired to a fan header on the board. This makes the configuration
easier for the user.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/it87.c |   83 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 32 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -222,6 +222,7 @@ struct it87_data {
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
+	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
 	u8 temp[3];		/* Register value */
@@ -966,38 +967,51 @@ static int it87_detect(struct i2c_adapte
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
@@ -1174,11 +1188,12 @@ static void it87_init_client(struct i2c_
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
@@ -1243,6 +1258,10 @@ static struct it87_data *it87_update_dev
 		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
+			/* Skip disabled fans */
+			if (!(data->has_fan & (1 << i)))
+				continue;
+
 			data->fan_min[i]  			    it87_read_value(client, IT87_REG_FAN_MIN(i));
 			data->fan[i] = it87_read_value(client,
@@ -1265,7 +1284,7 @@ static struct it87_data *it87_update_dev
 		}
 
 		/* Newer chips don't have clock dividers */
-		if (data->type != it8716) {
+		if ((data->has_fan & 0x07) && data->type != it8716) {
 			i = it87_read_value(client, IT87_REG_FAN_DIV);
 			data->fan_div[0] = i & 0x07;
 			data->fan_div[1] = (i >> 3) & 0x07;


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/i2c-algo-bit-kill-mdelay.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/i2c-__must_check-fixes-i2c-dev.patch
i2c/i2c-__must_check-fixes.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/i2c-algo-sibyte-cleanups.patch
i2c/i2c-algo-sibyte-merge-in-i2c-sibyte.patch
i2c/i2c-au1550-add-au1200-support.patch
i2c/i2c-au1550-add-smbus-functionality-flag.patch
i2c/i2c-au1550-fix-timeout-problem.patch
i2c/i2c-bus-driver-for-TI-OMAP-boards.patch
i2c/i2c-isa-plan-for-removal.patch
i2c/i2c-dev-cleanups.patch
i2c/i2c-dev-convert-array-to-list.patch
i2c/i2c-dev-drop-template-client.patch
i2c/i2c-dev-device.patch
i2c/i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
i2c/i2c-matroxfb-c99-struct-init.patch
i2c/i2c-sibyte-drop-kip-walker-address.patch
i2c/i2c-stub-add-chip_addr-param.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch

