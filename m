From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Aug 2006 14:06:01 +0000
Subject: [lm-sensors] [PATCH 1/5] it87: Add support for the IT8716F
Message-Id: <20060808160601.60701c88.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it87: Add support for the IT8716F

The IT8716F is a Super-I/O chip with integrated hardware monitoring
functions. It is very similar to the IT8712F, so adding support to the
it87 driver was pretty straightforward. The most significant change here
is that the IT8716F has 16-bit fan speed counters, so the user no more
needs to tweak the fan clock dividers to get the best readings.

Userspace support is already in lm_sensors SVN (to be soon released
as 2.10.1.)

Thanks to Stian Oksavik for testing the early versions of this patch.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/it87 |   40 ++++++++++----
 drivers/hwmon/Kconfig    |    4 
 drivers/hwmon/it87.c     |  127 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 134 insertions(+), 37 deletions(-)

--- linux-2.6.18-rc4.orig/Documentation/hwmon/it87	2006-08-08 14:18:25.000000000 +0200
+++ linux-2.6.18-rc4/Documentation/hwmon/it87	2006-08-08 14:47:57.000000000 +0200
@@ -13,6 +13,11 @@
                        from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
+  * IT8716F
+    Prefix: 'it8716'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Publicly available at the ITE website
+               http://www.ite.com.tw/product_info/file/pc/IT8716F_V0.3.ZIP
   * SiS950   [clone of IT8705F]
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -43,26 +48,39 @@
 Description
 -----------
 
-This driver implements support for the IT8705F, IT8712F and SiS950 chips.
-
-This driver also supports IT8712F, which adds SMBus access, and a VID
-input, used to report the Vcore voltage of the Pentium processor.
-The IT8712F additionally features VID inputs.
+This driver implements support for the IT8705F, IT8712F, IT8716F and
+SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
 include an 'environment controller' with 3 temperature sensors, 3 fan
 rotation speed sensors, 8 voltage sensors, and associated alarms.
 
+The IT8712F and IT8716F additionally feature VID inputs, used to report
+the Vcore voltage of the processor. The early IT8712F have 5 VID pins,
+the IT8716F and late IT8712F have 6. They are shared with other functions
+though, so the functionality may not be available on a given system.
+The driver dumbly assume it is there.
+
+The IT8716F and later IT8712F revisions have support for 2 additional
+fans. They are not yet supported by the driver.
+
+The IT8716F and late IT8712F and IT8705F also have optional 16-bit
+tachometer counters for fans 1 to 3. This is better (no more fan
+clock divider mess) but not compatible with the older chips and
+revisions. For now, the driver only uses the 16-bit mode on the
+IT8716F, and only if the chip was so configured.
+
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
 
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give the
-readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
+triggered if the rotation speed has dropped below a programmable limit. When
+16-bit tachometer counters aren't use, fan readings can be divided by
+a programmable divider (1, 2, 4 or 8) to give the readings more range or
+accuracy. With a divider of 2, the lowest representable value is around
+2600 RPM. Not all RPM values can accurately be represented, so some rounding
+is done.
 
 Voltage sensors (also known as IN sensors) report their values in volts. An
 alarm is triggered if the voltage has crossed a programmable minimum or
@@ -71,7 +89,7 @@
 inputs can measure voltages between 0 and 4.08 volts, with a resolution of
 0.016 volt. The battery voltage in8 does not have limit registers.
 
-The VID lines (IT8712F only) encode the core voltage value: the voltage
+The VID lines (IT8712F/IT8716F) encode the core voltage value: the voltage
 level your processor should work with. This is hardcoded by the mainboard
 and/or processor itself. It is a value in volts.
 
--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-08 14:18:25.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-08 14:47:57.000000000 +0200
@@ -4,6 +4,7 @@
 
     Supports: IT8705F  Super I/O chip w/LPC interface
               IT8712F  Super I/O chip w/LPC interface & SMBus
+              IT8716F  Super I/O chip w/LPC interface
               Sis950   A clone of the IT8705F
 
     Copyright (C) 2001 Chris Gauthron <chrisg at 0-in.com> 
@@ -50,7 +51,7 @@
 static unsigned short isa_address;
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_2(it87, it8712);
+I2C_CLIENT_INSMOD_3(it87, it8712, it8716);
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -101,6 +102,7 @@
 
 #define IT8712F_DEVID 0x8712
 #define IT8705F_DEVID 0x8705
+#define IT8716F_DEVID 0x8716
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -132,12 +134,18 @@
 #define IT87_REG_ALARM3        0x03
 
 #define IT87_REG_VID           0x0a
+/* Warning: register 0x0b is used for something completely different in
+   new chips/revisions. I suspect only 16-bit tachometer mode will work
+   for these. */
 #define IT87_REG_FAN_DIV       0x0b
+#define IT87_REG_FAN_16BIT     0x0c
 
 /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) */
 
 #define IT87_REG_FAN(nr)       (0x0d + (nr))
 #define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
+#define IT87_REG_FANX(nr)      (0x18 + (nr))
+#define IT87_REG_FANX_MIN(nr)  (0x1b + (nr))
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
 #define IT87_REG_PWM(nr)       (0x15 + (nr))
@@ -169,7 +177,15 @@
 			     254);
 }
 
+static inline u16 FAN16_TO_REG(long rpm)
+{
+	if (rpm = 0)
+		return 0xffff;
+	return SENSORS_LIMIT((1350000 + rpm / 2) / rpm, 1, 0xfffe);
+}
+
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
+#define FAN16_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:1350000/(val))
 
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
 					((val)+500)/1000),-128,127))
@@ -205,8 +221,9 @@
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
-	u8 fan[3];		/* Register value */
-	u8 fan_min[3];		/* Register value */
+	u8 fan16;		/* Bitfield, fans in 16-bit mode */
+	u16 fan[3];		/* Register values, possibly combined */
+	u16 fan_min[3];		/* Register values, possibly combined */
 	u8 temp[3];		/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
@@ -473,8 +490,11 @@
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
-				DIV_FROM_REG(data->fan_div[nr])));
+	int rpm = (data->fan16 & (1 << nr)) ?
+		FAN16_FROM_REG(data->fan[nr]) :
+		FAN_FROM_REG(data->fan[nr],
+			     DIV_FROM_REG(data->fan_div[nr]));
+	return sprintf(buf, "%d\n", rpm);
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -483,8 +503,11 @@
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n",
-		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
+	int rpm = (data->fan16 & (1 << nr)) ?
+		FAN16_FROM_REG(data->fan_min[nr]) :
+		FAN_FROM_REG(data->fan_min[nr],
+			     DIV_FROM_REG(data->fan_div[nr]));
+	return sprintf(buf, "%d\n", rpm);
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -531,8 +554,18 @@
 	case 2: data->fan_div[nr] = (reg & 0x40) ? 3 : 1; break;
 	}
 
-	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	if (data->fan16 & (1 << nr)) { /* 16-bit tachometer mode */
+		data->fan_min[nr] = FAN16_TO_REG(val);
+		it87_write_value(client, IT87_REG_FAN_MIN(nr),
+				 data->fan_min[nr] & 0xff);
+		it87_write_value(client, IT87_REG_FANX_MIN(nr),
+				 data->fan_min[nr] >> 8);
+	} else {
+		data->fan_min[nr] = FAN_TO_REG(val,
+				    DIV_FROM_REG(data->fan_div[nr]));
+		it87_write_value(client, IT87_REG_FAN_MIN(nr),
+				 data->fan_min[nr]);
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -720,6 +753,7 @@
 	superio_enter();
 	chip_type = superio_inw(DEVID);
 	if (chip_type != IT8712F_DEVID
+	 && chip_type != IT8716F_DEVID
 	 && chip_type != IT8705F_DEVID)
 	 	goto exit;
 
@@ -799,8 +833,16 @@
 		i = it87_read_value(new_client, IT87_REG_CHIPID);
 		if (i = 0x90) {
 			kind = it87;
-			if ((is_isa) && (chip_type = IT8712F_DEVID))
-				kind = it8712;
+			if (is_isa) {
+				switch (chip_type) {
+				case IT8712F_DEVID:
+					kind = it8712;
+					break;
+				case IT8716F_DEVID:
+					kind = it8716;
+					break;
+				}
+			}
 		}
 		else {
 			if (kind = 0)
@@ -817,6 +859,8 @@
 		name = "it87";
 	} else if (kind = it8712) {
 		name = "it8712";
+	} else if (kind = it8716) {
+		name = "it8716";
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
@@ -890,9 +934,18 @@
 	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
+
+	/* Only create the fan clock divider entries if not in 16-bit mode */
+	if (!(data->fan16 & (1 << 0)))
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan1_div.dev_attr);
+	if (!(data->fan16 & (1 << 1)))
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan2_div.dev_attr);
+	if (!(data->fan16 & (1 << 2)))
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan3_div.dev_attr);
+
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (enable_pwm_interface) {
 		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
@@ -903,7 +956,7 @@
 		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
 	}
 
-	if (data->type = it8712) {
+	if (data->type = it8712 || data->type = it8716) {
 		data->vrm = vid_which_vrm();
 		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
@@ -1068,6 +1121,19 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 
+	/* Read and store tachometer mode */
+	if (data->type = it8716) {
+		data->fan16 = it87_read_value(client, IT87_REG_FAN_16BIT)
+			    & 0x07;
+		for (i = 0; i < 3; i++) {
+			if (data->fan16 & (1 << i)) {
+				dev_dbg(&client->dev, "Using 16-bit "
+					"tachometer counter for fan%d\n",
+					i + 1);
+			}
+		}
+	}
+
 	/* Set current fan mode registers and the default settings for the
 	 * other mode registers */
 	for (i = 0; i < 3; i++) {
@@ -1125,10 +1191,17 @@
 		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
-			data->fan[i] -			    it87_read_value(client, IT87_REG_FAN(i));
 			data->fan_min[i]  			    it87_read_value(client, IT87_REG_FAN_MIN(i));
+			data->fan[i] = it87_read_value(client,
+				       IT87_REG_FAN(i));
+			/* Add high byte if in 16-bit mode */
+			if (data->fan16 & (1 << i)) {
+				data->fan[i] |= it87_read_value(client,
+						IT87_REG_FANX(i)) << 8;
+				data->fan_min[i] |= it87_read_value(client,
+						IT87_REG_FANX_MIN(i)) << 8;
+			}
 		}
 		for (i = 0; i < 3; i++) {
 			data->temp[i] @@ -1139,10 +1212,14 @@
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
 
-		i = it87_read_value(client, IT87_REG_FAN_DIV);
-		data->fan_div[0] = i & 0x07;
-		data->fan_div[1] = (i >> 3) & 0x07;
-		data->fan_div[2] = (i & 0x40) ? 3 : 1;
+		/* If at least one fan isn't in 16-bit tachometer mode, we
+		   need the clock divider values */
+		if (~data->fan16 & 0x07) {
+			i = it87_read_value(client, IT87_REG_FAN_DIV);
+			data->fan_div[0] = i & 0x07;
+			data->fan_div[1] = (i >> 3) & 0x07;
+			data->fan_div[2] = (i & 0x40) ? 3 : 1;
+		}
 
 		data->alarms  			it87_read_value(client, IT87_REG_ALARM1) |
@@ -1152,9 +1229,11 @@
 
 		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 		/* The 8705 does not have VID capability */
-		if (data->type = it8712) {
+		if (data->type = it8712 || data->type = it8716) {
 			data->vid = it87_read_value(client, IT87_REG_VID);
-			data->vid &= 0x1f;
+			/* The older IT8712F revisions had only 5 VID pins,
+			   but we assume it is always safe to read 6 bits. */
+			data->vid &= 0x3f;
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -1193,7 +1272,7 @@
 
 
 MODULE_AUTHOR("Chris Gauthron <chrisg at 0-in.com>");
-MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
+MODULE_DESCRIPTION("IT8705F/8712F/8716F, SiS950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
 module_param(fix_pwm_polarity, bool, 0);
--- linux-2.6.18-rc4.orig/drivers/hwmon/Kconfig	2006-08-08 14:18:25.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/Kconfig	2006-08-08 14:47:57.000000000 +0200
@@ -186,8 +186,8 @@
 	select I2C_ISA
 	select HWMON_VID
 	help
-	  If you say yes here you get support for ITE IT87xx sensor chips
-	  and clones: SiS960.
+	  If you say yes here you get support for ITE IT8705F, IT8712F and
+	  IT8716F sensor chips, and the SiS960 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.


-- 
Jean Delvare

