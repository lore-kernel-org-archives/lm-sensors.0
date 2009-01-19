From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 19 Jan 2009 08:39:40 +0000
Subject: [lm-sensors] PATCH: hwmon-fschmd-add-fscsyl-v2.patch
Message-Id: <49743C4C.8010202@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080105020800010806090308"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105020800010806090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

New version, atleast on the system FSC has provided me with, their is no 
voltage scaling DMI info the (new) in3 - in5 inputs. So instead in this version 
the DMI scaling info from Vbat gets re-used for Vcc3.3 and Vcc3.3aux and from 
Vcc5 for Vcc5aux. This yields correct readings on my system. I'll contact FSC 
about this as according to the docs there should now also be scaling info for 
the 3 additional voltage inputs in the DMI tables.

This patch adds support for the FSC Syleus IC to the fschmd driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


--------------080105020800010806090308
Content-Type: text/plain;
 name="hwmon-fschmd-add-fscsyl-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fschmd-add-fscsyl-v2.patch"

This patch adds support for the FSC Syleus IC to the fschmd driver.

Many thanks to Fujitsu Siemens Computers for providing docs and a machine to
test the driver on.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- /home/hans/fschmd.c	2009-01-18 23:17:16.000000000 +0100
+++ fschmd.c	2009-01-19 09:17:53.000000000 +0100
@@ -1,6 +1,6 @@
 /* fschmd.c
  *
- * Copyright (C) 2007,2008 Hans de Goede <hdegoede@redhat.com>
+ * Copyright (C) 2007 - 2009 Hans de Goede <hdegoede@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,7 +19,7 @@
 
 /*
  *  Merged Fujitsu Siemens hwmon driver, supporting the Poseidon, Hermes,
- *  Scylla, Heracles and Heimdall chips
+ *  Scylla, Heracles, Heimdall and Syleus chips
  *
  *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
  *  (candidate) fschmd drivers:
@@ -56,7 +56,7 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
+I2C_CLIENT_INSMOD_6(fscpos, fscher, fscscy, fschrc, fschmd, fscsyl);
 
 /*
  * The FSCHMD registers and other defines
@@ -75,9 +75,10 @@
 #define FSCHMD_CONTROL_ALERT_LED	0x01
 
 /* watchdog */
-#define FSCHMD_REG_WDOG_PRESET		0x28
-#define FSCHMD_REG_WDOG_STATE		0x23
-#define FSCHMD_REG_WDOG_CONTROL		0x21
+/* fscsyl - 1 as data->kind is an array index, not a chips */
+#define FSCHMD_REG_WDOG_PRESET	((data->kind == fscsyl - 1) ?  0x2a : 0x28)
+#define FSCHMD_REG_WDOG_STATE	((data->kind == fscsyl - 1) ?  0x29 : 0x23)
+#define FSCHMD_REG_WDOG_CONTROL	((data->kind == fscsyl - 1) ?  0x28 : 0x21)
 
 #define FSCHMD_WDOG_CONTROL_TRIGGER	0x10
 #define FSCHMD_WDOG_CONTROL_STARTED	0x10 /* the same as trigger */
@@ -87,70 +88,86 @@
 #define FSCHMD_WDOG_STATE_CARDRESET	0x02
 
 /* voltages, weird order is to keep the same order as the old drivers */
-static const u8 FSCHMD_REG_VOLT[3] = { 0x45, 0x42, 0x48 };
+static const u8 FSCHMD_REG_VOLT[6][6] = {
+	{ 0x45, 0x42, 0x48 },				/* pos */
+	{ 0x45, 0x42, 0x48 },				/* her */
+	{ 0x45, 0x42, 0x48 },				/* scy */
+	{ 0x45, 0x42, 0x48 },				/* hrc */
+	{ 0x45, 0x42, 0x48 },				/* hmd */
+	{ 0x21, 0x20, 0x22, 0x23, 0x24, 0x25 },		/* syl */
+};
+
+static const int FSCHMD_NO_VOLT_SENSORS[6] = { 3, 3, 3, 3, 3, 6 };
 
 /* minimum pwm at which the fan is driven (pwm can by increased depending on
    the temp. Notice that for the scy some fans share there minimum speed.
    Also notice that with the scy the sensor order is different than with the
    other chips, this order was in the 2.4 driver and kept for consistency. */
-static const u8 FSCHMD_REG_FAN_MIN[5][6] = {
+static const u8 FSCHMD_REG_FAN_MIN[6][7] = {
 	{ 0x55, 0x65 },					/* pos */
 	{ 0x55, 0x65, 0xb5 },				/* her */
 	{ 0x65, 0x65, 0x55, 0xa5, 0x55, 0xa5 },		/* scy */
 	{ 0x55, 0x65, 0xa5, 0xb5 },			/* hrc */
 	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 },		/* hmd */
+	{ 0x54, 0x64, 0x74, 0x84, 0x94, 0xa4, 0xb4 },	/* syl */
 };
 
 /* actual fan speed */
-static const u8 FSCHMD_REG_FAN_ACT[5][6] = {
+static const u8 FSCHMD_REG_FAN_ACT[6][7] = {
 	{ 0x0e, 0x6b, 0xab },				/* pos */
 	{ 0x0e, 0x6b, 0xbb },				/* her */
 	{ 0x6b, 0x6c, 0x0e, 0xab, 0x5c, 0xbb },		/* scy */
 	{ 0x0e, 0x6b, 0xab, 0xbb },			/* hrc */
 	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb },		/* hmd */
+	{ 0x57, 0x67, 0x77, 0x87, 0x97, 0xa7, 0xb7 },	/* syl */
 };
 
 /* fan status registers */
-static const u8 FSCHMD_REG_FAN_STATE[5][6] = {
+static const u8 FSCHMD_REG_FAN_STATE[6][7] = {
 	{ 0x0d, 0x62, 0xa2 },				/* pos */
 	{ 0x0d, 0x62, 0xb2 },				/* her */
 	{ 0x62, 0x61, 0x0d, 0xa2, 0x52, 0xb2 },		/* scy */
 	{ 0x0d, 0x62, 0xa2, 0xb2 },			/* hrc */
 	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 },		/* hmd */
+	{ 0x50, 0x60, 0x70, 0x80, 0x90, 0xa0, 0xb0 },	/* syl */
 };
 
 /* fan ripple / divider registers */
-static const u8 FSCHMD_REG_FAN_RIPPLE[5][6] = {
+static const u8 FSCHMD_REG_FAN_RIPPLE[6][7] = {
 	{ 0x0f, 0x6f, 0xaf },				/* pos */
 	{ 0x0f, 0x6f, 0xbf },				/* her */
 	{ 0x6f, 0x6f, 0x0f, 0xaf, 0x0f, 0xbf },		/* scy */
 	{ 0x0f, 0x6f, 0xaf, 0xbf },			/* hrc */
 	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf },		/* hmd */
+	{ 0x56, 0x66, 0x76, 0x86, 0x96, 0xa6, 0xb6 },	/* syl */
 };
 
-static const int FSCHMD_NO_FAN_SENSORS[5] = { 3, 3, 6, 4, 5 };
+static const int FSCHMD_NO_FAN_SENSORS[6] = { 3, 3, 6, 4, 5, 7 };
 
 /* Fan status register bitmasks */
 #define FSCHMD_FAN_ALARM	0x04 /* called fault by FSC! */
-#define FSCHMD_FAN_NOT_PRESENT	0x08 /* not documented */
+#define FSCHMD_FAN_NOT_PRESENT	0x08
+#define FSCHMD_FAN_DISABLED	0x80
 
 
 /* actual temperature registers */
-static const u8 FSCHMD_REG_TEMP_ACT[5][5] = {
+static const u8 FSCHMD_REG_TEMP_ACT[6][11] = {
 	{ 0x64, 0x32, 0x35 },				/* pos */
 	{ 0x64, 0x32, 0x35 },				/* her */
 	{ 0x64, 0xD0, 0x32, 0x35 },			/* scy */
 	{ 0x64, 0x32, 0x35 },				/* hrc */
-	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 },		/* hmd */
+	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 },		/* < hmd, \/ syl */
+	{ 0x58, 0x68, 0x78, 0x88, 0x98, 0xa8, 0xb8, 0xc8, 0xd8, 0xe8, 0xf8 },
 };
 
 /* temperature state registers */
-static const u8 FSCHMD_REG_TEMP_STATE[5][5] = {
+static const u8 FSCHMD_REG_TEMP_STATE[6][11] = {
 	{ 0x71, 0x81, 0x91 },				/* pos */
 	{ 0x71, 0x81, 0x91 },				/* her */
 	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
 	{ 0x71, 0x81, 0x91 },				/* hrc */
-	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* hmd */
+	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* < hmd, \/ syl */
+	{ 0x59, 0x69, 0x79, 0x89, 0x99, 0xa9, 0xb9, 0xc9, 0xd9, 0xe9, 0xf9 },
 };
 
 /* temperature high limit registers, FSC does not document these. Proven to be
@@ -158,24 +175,28 @@
    in the fscscy 2.4 driver. FSC has confirmed that the fschmd has registers
    at these addresses, but doesn't want to confirm they are the same as with
    the fscher?? */
-static const u8 FSCHMD_REG_TEMP_LIMIT[5][5] = {
+static const u8 FSCHMD_REG_TEMP_LIMIT[6][11] = {
 	{ 0, 0, 0 },					/* pos */
 	{ 0x76, 0x86, 0x96 },				/* her */
 	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
 	{ 0x76, 0x86, 0x96 },				/* hrc */
-	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* hmd */
+	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* < hmd, \/ syl */
+	{ 0x5a, 0x6a, 0x7a, 0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa },
 };
 
 /* These were found through experimenting with an fscher, currently they are
    not used, but we keep them around for future reference.
+   On the fscsyl these are 0x#c 0x#e and 0x#1 is a bitmask defining which
+   temps influence the 0x## fan.
 static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
 static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 }; */
 
-static const int FSCHMD_NO_TEMP_SENSORS[5] = { 3, 3, 4, 3, 5 };
+static const int FSCHMD_NO_TEMP_SENSORS[6] = { 3, 3, 4, 3, 5, 11 };
 
 /* temp status register bitmasks */
 #define FSCHMD_TEMP_WORKING	0x01
 #define FSCHMD_TEMP_ALERT	0x02
+#define FSCHMD_TEMP_DISABLED	0x80
 /* there only really is an alarm if the sensor is working and alert == 1 */
 #define FSCHMD_TEMP_ALARM_MASK \
 	(FSCHMD_TEMP_WORKING | FSCHMD_TEMP_ALERT)
@@ -201,6 +222,7 @@
 	{ "fscscy", fscscy },
 	{ "fschrc", fschrc },
 	{ "fschmd", fschmd },
+	{ "fscsyl", fscsyl },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fschmd_id);
@@ -242,14 +264,14 @@
 	u8 watchdog_control;    /* watchdog control register */
 	u8 watchdog_state;      /* watchdog status register */
 	u8 watchdog_preset;     /* watchdog counter preset on trigger val */
-	u8 volt[3];		/* 12, 5, battery voltage */
-	u8 temp_act[5];		/* temperature */
-	u8 temp_status[5];	/* status of sensor */
-	u8 temp_max[5];		/* high temp limit, notice: undocumented! */
-	u8 fan_act[6];		/* fans revolutions per second */
-	u8 fan_status[6];	/* fan status */
-	u8 fan_min[6];		/* fan min value for rps */
-	u8 fan_ripple[6];	/* divider for rps */
+	u8 volt[6];		/* voltage */
+	u8 temp_act[11];	/* temperature */
+	u8 temp_status[11];	/* status of sensor */
+	u8 temp_max[11];	/* high temp limit, notice: undocumented! */
+	u8 fan_act[7];		/* fans revolutions per second */
+	u8 fan_status[7];	/* fan status */
+	u8 fan_min[7];		/* fan min value for rps */
+	u8 fan_ripple[7];	/* divider for rps */
 };
 
 /* Global variables to hold information read from special DMI tables, which are
@@ -257,8 +279,8 @@
    protect these with a lock as they are only modified from our attach function
    which always gets called with the i2c-core lock held and never accessed
    before the attach function is done with them. */
-static int dmi_mult[3] = { 490, 200, 100 };
-static int dmi_offset[3] = { 0, 0, 0 };
+static int dmi_mult[6] = { 490, 200, 100, 100, 200, 100 };
+static int dmi_offset[6] = { 0, 0, 0, 0, 0, 0 };
 static int dmi_vref = -1;
 
 /* Somewhat ugly :( global data pointer list with all fschmd devices, so that
@@ -450,10 +472,11 @@
 	struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
-	int val = fschmd_update_device(dev)->fan_min[index];
+	struct fschmd_data *data = fschmd_update_device(dev);
+	int val = data->fan_min[index];
 
-	/* 0 = allow turning off, 1-255 = 50-100% */
-	if (val)
+	/* 0 = allow turning off (except on the syl), 1-255 = 50-100% */
+	if (val || data->kind == fscsyl - 1)
 		val = val / 2 + 128;
 
 	return sprintf(buf, "%d\n", val);
@@ -466,8 +489,8 @@
 	struct fschmd_data *data = dev_get_drvdata(dev);
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
-	/* register: 0 = allow turning off, 1-255 = 50-100% */
-	if (v) {
+	/* reg: 0 = allow turning off (except on the syl), 1-255 = 50-100% */
+	if (v || data->kind == fscsyl - 1) {
 		v = SENSORS_LIMIT(v, 128, 255);
 		v = (v - 128) * 2 + 1;
 	}
@@ -523,10 +546,13 @@
 }
 
 static struct sensor_device_attribute fschmd_attr[] = {
+	SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
 	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
 	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
 	SENSOR_ATTR(in2_input, 0444, show_in_value, NULL, 2),
-	SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
+	SENSOR_ATTR(in3_input, 0444, show_in_value, NULL, 3),
+	SENSOR_ATTR(in4_input, 0444, show_in_value, NULL, 4),
+	SENSOR_ATTR(in5_input, 0444, show_in_value, NULL, 5),
 };
 
 static struct sensor_device_attribute fschmd_temp_attr[] = {
@@ -550,6 +576,30 @@
 	SENSOR_ATTR(temp5_max,   0644, show_temp_max, store_temp_max, 4),
 	SENSOR_ATTR(temp5_fault, 0444, show_temp_fault, NULL, 4),
 	SENSOR_ATTR(temp5_alarm, 0444, show_temp_alarm, NULL, 4),
+	SENSOR_ATTR(temp6_input, 0444, show_temp_value, NULL, 5),
+	SENSOR_ATTR(temp6_max,   0644, show_temp_max, store_temp_max, 5),
+	SENSOR_ATTR(temp6_fault, 0444, show_temp_fault, NULL, 5),
+	SENSOR_ATTR(temp6_alarm, 0444, show_temp_alarm, NULL, 5),
+	SENSOR_ATTR(temp7_input, 0444, show_temp_value, NULL, 6),
+	SENSOR_ATTR(temp7_max,   0644, show_temp_max, store_temp_max, 6),
+	SENSOR_ATTR(temp7_fault, 0444, show_temp_fault, NULL, 6),
+	SENSOR_ATTR(temp7_alarm, 0444, show_temp_alarm, NULL, 6),
+	SENSOR_ATTR(temp8_input, 0444, show_temp_value, NULL, 7),
+	SENSOR_ATTR(temp8_max,   0644, show_temp_max, store_temp_max, 7),
+	SENSOR_ATTR(temp8_fault, 0444, show_temp_fault, NULL, 7),
+	SENSOR_ATTR(temp8_alarm, 0444, show_temp_alarm, NULL, 7),
+	SENSOR_ATTR(temp9_input, 0444, show_temp_value, NULL, 8),
+	SENSOR_ATTR(temp9_max,   0644, show_temp_max, store_temp_max, 8),
+	SENSOR_ATTR(temp9_fault, 0444, show_temp_fault, NULL, 8),
+	SENSOR_ATTR(temp9_alarm, 0444, show_temp_alarm, NULL, 8),
+	SENSOR_ATTR(temp10_input, 0444, show_temp_value, NULL, 9),
+	SENSOR_ATTR(temp10_max,   0644, show_temp_max, store_temp_max, 9),
+	SENSOR_ATTR(temp10_fault, 0444, show_temp_fault, NULL, 9),
+	SENSOR_ATTR(temp10_alarm, 0444, show_temp_alarm, NULL, 9),
+	SENSOR_ATTR(temp11_input, 0444, show_temp_value, NULL, 10),
+	SENSOR_ATTR(temp11_max,   0644, show_temp_max, store_temp_max, 10),
+	SENSOR_ATTR(temp11_fault, 0444, show_temp_fault, NULL, 10),
+	SENSOR_ATTR(temp11_alarm, 0444, show_temp_alarm, NULL, 10),
 };
 
 static struct sensor_device_attribute fschmd_fan_attr[] = {
@@ -589,6 +639,12 @@
 	SENSOR_ATTR(fan6_fault, 0444, show_fan_fault, NULL, 5),
 	SENSOR_ATTR(pwm6_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
 		store_pwm_auto_point1_pwm, 5),
+	SENSOR_ATTR(fan7_input, 0444, show_fan_value, NULL, 6),
+	SENSOR_ATTR(fan7_div,   0644, show_fan_div, store_fan_div, 6),
+	SENSOR_ATTR(fan7_alarm, 0444, show_fan_alarm, NULL, 6),
+	SENSOR_ATTR(fan7_fault, 0444, show_fan_fault, NULL, 6),
+	SENSOR_ATTR(pwm7_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
+		store_pwm_auto_point1_pwm, 6),
 };
 
 
@@ -912,6 +968,12 @@
 			dmi_mult[i] = mult[i] * 10;
 			dmi_offset[i] = offset[i] * 10;
 		}
+		/* According to the docs there should be separate dmi entries
+		   for the mult's and offsets of in3-5 of the syl, but on
+		   my test machine these are not present */
+		dmi_mult[3] = dmi_mult[2]; dmi_offset[3] = dmi_offset[2];
+		dmi_mult[4] = dmi_mult[1]; dmi_offset[4] = dmi_offset[1];
+		dmi_mult[5] = dmi_mult[2]; dmi_offset[5] = dmi_offset[2];
 		dmi_vref = vref;
 	}
 }
@@ -920,8 +982,6 @@
 			 struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	const char * const client_names[5] = { "fscpos", "fscher", "fscscy",
-						"fschrc", "fschmd" };
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -948,11 +1008,13 @@
 			kind = fschrc;
 		else if (!strcmp(id, "HMD"))
 			kind = fschmd;
+		else if (!strcmp(id, "SYL"))
+			kind = fscsyl;
 		else
 			return -ENODEV;
 	}
 
-	strlcpy(info->type, client_names[kind - 1], I2C_NAME_SIZE);
+	strlcpy(info->type, fschmd_id[kind - 1].name, I2C_NAME_SIZE);
 
 	return 0;
 }
@@ -961,8 +1023,8 @@
 			const struct i2c_device_id *id)
 {
 	struct fschmd_data *data;
-	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
-					"Heracles", "Heimdall" };
+	const char * const names[6] = { "Poseidon", "Hermes", "Scylla",
+					"Heracles", "Heimdall", "Syleus" };
 	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	int i, err;
 	enum chips kind = id->driver_data;
@@ -1000,6 +1062,9 @@
 		}
 	}
 
+	/* i2c kind goes from 1-6, we want from 0-5 to address arrays */
+	data->kind = kind - 1;
+
 	/* Read in some never changing registers */
 	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
 	data->global_control = i2c_smbus_read_byte_data(client,
@@ -1011,10 +1076,8 @@
 	data->watchdog_preset = i2c_smbus_read_byte_data(client,
 					FSCHMD_REG_WDOG_PRESET);
 
-	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
-	data->kind = kind - 1;
-
-	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++) {
+	/* FSCHMD_NO_VOLT_SENSORS + 1 for alert_led attribute */
+	for (i = 0; i < (FSCHMD_NO_VOLT_SENSORS[data->kind] + 1); i++) {
 		err = device_create_file(&client->dev,
 					&fschmd_attr[i].dev_attr);
 		if (err)
@@ -1027,6 +1090,16 @@
 				show_temp_max)
 			continue;
 
+		if (kind == fscsyl) {
+			if (i % 4 == 0)
+				data->temp_status[i / 4] =
+					i2c_smbus_read_byte_data(client,
+						FSCHMD_REG_TEMP_STATE
+						[data->kind][i / 4]);
+			if (data->temp_status[i / 4] & FSCHMD_TEMP_DISABLED)
+				continue;
+		}
+
 		err = device_create_file(&client->dev,
 					&fschmd_temp_attr[i].dev_attr);
 		if (err)
@@ -1040,6 +1113,16 @@
 					"pwm3_auto_point1_pwm"))
 			continue;
 
+		if (kind == fscsyl) {
+			if (i % 5 == 0)
+				data->fan_status[i / 5] =
+					i2c_smbus_read_byte_data(client,
+						FSCHMD_REG_FAN_STATE
+						[data->kind][i / 5]);
+			if (data->fan_status[i / 5] & FSCHMD_FAN_DISABLED)
+				continue;
+		}
+
 		err = device_create_file(&client->dev,
 					&fschmd_fan_attr[i].dev_attr);
 		if (err)
@@ -1126,7 +1209,7 @@
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
-	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++)
+	for (i = 0; i < (FSCHMD_NO_VOLT_SENSORS[data->kind] + 1); i++)
 		device_remove_file(&client->dev, &fschmd_attr[i].dev_attr);
 	for (i = 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++)
 		device_remove_file(&client->dev,
@@ -1171,7 +1254,7 @@
 					data->temp_act[i] < data->temp_max[i])
 				i2c_smbus_write_byte_data(client,
 					FSCHMD_REG_TEMP_STATE[data->kind][i],
-					FSCHMD_TEMP_ALERT);
+					data->temp_status[i]);
 		}
 
 		for (i = 0; i < FSCHMD_NO_FAN_SENSORS[data->kind]; i++) {
@@ -1193,12 +1276,12 @@
 					data->fan_act[i])
 				i2c_smbus_write_byte_data(client,
 					FSCHMD_REG_FAN_STATE[data->kind][i],
-					FSCHMD_FAN_ALARM);
+					data->fan_status[i]);
 		}
 
-		for (i = 0; i < 3; i++)
+		for (i = 0; i < FSCHMD_NO_VOLT_SENSORS[data->kind]; i++)
 			data->volt[i] = i2c_smbus_read_byte_data(client,
-						FSCHMD_REG_VOLT[i]);
+					       FSCHMD_REG_VOLT[data->kind][i]);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -1220,8 +1303,8 @@
 }
 
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
-			"Heimdall driver");
+MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles, Heimdall and "
+			"Syleus driver");
 MODULE_LICENSE("GPL");
 
 module_init(fschmd_init);

--------------080105020800010806090308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080105020800010806090308--
