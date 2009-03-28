From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 Mar 2009 08:07:56 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-add-fscsyl-v3.patch
Message-Id: <49CDDADC.8000305@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050900070806050105020702"
List-Id: <lm-sensors.vger.kernel.org>
References: <49CCC1D5.6040804@redhat.com>
In-Reply-To: <49CCC1D5.6040804@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050900070806050105020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 27 Mar 2009 13:08:53 +0100, Hans de Goede wrote:
>> This patch adds support for the FSC Syleus IC to the fschmd driver.
> 
> Not sure what you used to generate this patch, but it's improperly
> formatted and I just can't apply it. Please try again, in attachment
> maybe?
> 

Sorry,

I'm lately sending patches inline because most people prefer that,
I guess my mail client (thunderbird) mangled the patch. Here it is
again, this time attached.

Regards,

Hans

--------------050900070806050105020702
Content-Type: text/plain;
 name="hwmon-fschmd-add-fscsyl-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fschmd-add-fscsyl-v3.patch"

This patch adds support for the FSC Syleus IC to the fschmd driver.

Many thanks to Fujitsu Siemens Computers for providing docs and a machine to
test the driver on.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up vanilla-2.6.29/drivers/hwmon/Kconfig.orig vanilla-2.6.29/drivers/hwmon/Kconfig
--- vanilla-2.6.29/drivers/hwmon/Kconfig.orig	2009-03-27 12:41:22.000000000 +0100
+++ vanilla-2.6.29/drivers/hwmon/Kconfig	2009-03-27 12:44:29.000000000 +0100
@@ -343,11 +343,12 @@ config SENSORS_FSCPOS
 	  will be called fscpos.
 
 config SENSORS_FSCHMD
-	tristate "FSC Poseidon, Scylla, Hermes, Heimdall and Heracles"
+	tristate "Fujitsu Siemens Computers sensor chips"
 	depends on X86 && I2C
 	help
-	  If you say yes here you get support for various Fujitsu Siemens
-	  Computers sensor chips, including support for the integrated
+	  If you say yes here you get support for the following Fujitsu
+	  Siemens Computers (FSC) sensor chips: Poseidon, Scylla, Hermes,
+	  Heimdall, Heracles and Syleus including support for the integrated
 	  watchdog.
 
 	  This is a merged driver for FSC sensor chips replacing the fscpos,
diff -up vanilla-2.6.29/drivers/hwmon/fschmd.c.orig vanilla-2.6.29/drivers/hwmon/fschmd.c
--- vanilla-2.6.29/drivers/hwmon/fschmd.c.orig	2009-03-24 00:12:14.000000000 +0100
+++ vanilla-2.6.29/drivers/hwmon/fschmd.c	2009-03-27 12:40:36.000000000 +0100
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
@@ -56,7 +56,7 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
+I2C_CLIENT_INSMOD_6(fscpos, fscher, fscscy, fschrc, fschmd, fscsyl);
 
 /*
  * The FSCHMD registers and other defines
@@ -75,9 +75,12 @@ I2C_CLIENT_INSMOD_5(fscpos, fscher, fscs
 #define FSCHMD_CONTROL_ALERT_LED	0x01
 
 /* watchdog */
-#define FSCHMD_REG_WDOG_PRESET		0x28
-#define FSCHMD_REG_WDOG_STATE		0x23
-#define FSCHMD_REG_WDOG_CONTROL		0x21
+static const u8 FSCHMD_REG_WDOG_CONTROL[6] =
+	{ 0x21, 0x21, 0x21, 0x21, 0x21, 0x28 };
+static const u8 FSCHMD_REG_WDOG_STATE[6] =
+	{ 0x23, 0x23, 0x23, 0x23, 0x23, 0x29 };
+static const u8 FSCHMD_REG_WDOG_PRESET[6] =
+	{ 0x28, 0x28, 0x28, 0x28, 0x28, 0x2a };
 
 #define FSCHMD_WDOG_CONTROL_TRIGGER	0x10
 #define FSCHMD_WDOG_CONTROL_STARTED	0x10 /* the same as trigger */
@@ -87,70 +90,88 @@ I2C_CLIENT_INSMOD_5(fscpos, fscher, fscs
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
 	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 },		/* hmd */
+	{ 0x58, 0x68, 0x78, 0x88, 0x98, 0xa8,		/* syl */
+	  0xb8, 0xc8, 0xd8, 0xe8, 0xf8 },
 };
 
 /* temperature state registers */
-static const u8 FSCHMD_REG_TEMP_STATE[5][5] = {
+static const u8 FSCHMD_REG_TEMP_STATE[6][11] = {
 	{ 0x71, 0x81, 0x91 },				/* pos */
 	{ 0x71, 0x81, 0x91 },				/* her */
 	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
 	{ 0x71, 0x81, 0x91 },				/* hrc */
 	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* hmd */
+	{ 0x59, 0x69, 0x79, 0x89, 0x99, 0xa9,		/* syl */
+	  0xb9, 0xc9, 0xd9, 0xe9, 0xf9 },
 };
 
 /* temperature high limit registers, FSC does not document these. Proven to be
@@ -158,24 +179,30 @@ static const u8 FSCHMD_REG_TEMP_STATE[5]
    in the fscscy 2.4 driver. FSC has confirmed that the fschmd has registers
    at these addresses, but doesn't want to confirm they are the same as with
    the fscher?? */
-static const u8 FSCHMD_REG_TEMP_LIMIT[5][5] = {
+static const u8 FSCHMD_REG_TEMP_LIMIT[6][11] = {
 	{ 0, 0, 0 },					/* pos */
 	{ 0x76, 0x86, 0x96 },				/* her */
 	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
 	{ 0x76, 0x86, 0x96 },				/* hrc */
 	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* hmd */
+	{ 0x5a, 0x6a, 0x7a, 0x8a, 0x9a, 0xaa,		/* syl */
+	  0xba, 0xca, 0xda, 0xea, 0xfa },
 };
 
 /* These were found through experimenting with an fscher, currently they are
    not used, but we keep them around for future reference.
+   On the fscsyl AUTOP1 lives at 0x#c (so 0x5c for fan1, 0x6c for fan2, etc),
+   AUTOP2 lives at 0x#e, and 0x#1 is a bitmask defining which temps influence
+   the fan speed.
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
@@ -201,6 +228,7 @@ static const struct i2c_device_id fschmd
 	{ "fscscy", fscscy },
 	{ "fschrc", fschrc },
 	{ "fschmd", fschmd },
+	{ "fscsyl", fscsyl },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fschmd_id);
@@ -242,14 +270,14 @@ struct fschmd_data {
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
@@ -257,8 +285,8 @@ struct fschmd_data {
    protect these with a lock as they are only modified from our attach function
    which always gets called with the i2c-core lock held and never accessed
    before the attach function is done with them. */
-static int dmi_mult[3] = { 490, 200, 100 };
-static int dmi_offset[3] = { 0, 0, 0 };
+static int dmi_mult[6] = { 490, 200, 100, 100, 200, 100 };
+static int dmi_offset[6] = { 0, 0, 0, 0, 0, 0 };
 static int dmi_vref = -1;
 
 /* Somewhat ugly :( global data pointer list with all fschmd devices, so that
@@ -450,10 +478,11 @@ static ssize_t show_pwm_auto_point1_pwm(
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
@@ -466,8 +495,8 @@ static ssize_t store_pwm_auto_point1_pwm
 	struct fschmd_data *data = dev_get_drvdata(dev);
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
-	/* register: 0 = allow turning off, 1-255 = 50-100% */
-	if (v) {
+	/* reg: 0 = allow turning off (except on the syl), 1-255 = 50-100% */
+	if (v || data->kind == fscsyl - 1) {
 		v = SENSORS_LIMIT(v, 128, 255);
 		v = (v - 128) * 2 + 1;
 	}
@@ -522,11 +551,15 @@ static ssize_t store_alert_led(struct de
 	return count;
 }
 
+static DEVICE_ATTR(alert_led, 0644, show_alert_led, store_alert_led);
+
 static struct sensor_device_attribute fschmd_attr[] = {
 	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
 	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
 	SENSOR_ATTR(in2_input, 0444, show_in_value, NULL, 2),
-	SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
+	SENSOR_ATTR(in3_input, 0444, show_in_value, NULL, 3),
+	SENSOR_ATTR(in4_input, 0444, show_in_value, NULL, 4),
+	SENSOR_ATTR(in5_input, 0444, show_in_value, NULL, 5),
 };
 
 static struct sensor_device_attribute fschmd_temp_attr[] = {
@@ -550,6 +583,30 @@ static struct sensor_device_attribute fs
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
@@ -589,6 +646,12 @@ static struct sensor_device_attribute fs
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
 
 
@@ -624,10 +687,11 @@ static int watchdog_set_timeout(struct f
 	data->watchdog_preset = DIV_ROUND_UP(timeout, resolution);
 
 	/* Write new timeout value */
-	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_PRESET,
-		data->watchdog_preset);
+	i2c_smbus_write_byte_data(data->client,
+		FSCHMD_REG_WDOG_PRESET[data->kind], data->watchdog_preset);
 	/* Write new control register, do not trigger! */
-	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
+	i2c_smbus_write_byte_data(data->client,
+		FSCHMD_REG_WDOG_CONTROL[data->kind],
 		data->watchdog_control & ~FSCHMD_WDOG_CONTROL_TRIGGER);
 
 	ret = data->watchdog_preset * resolution;
@@ -662,8 +726,9 @@ static int watchdog_trigger(struct fschm
 	}
 
 	data->watchdog_control |= FSCHMD_WDOG_CONTROL_TRIGGER;
-	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
-					data->watchdog_control);
+	i2c_smbus_write_byte_data(data->client,
+				  FSCHMD_REG_WDOG_CONTROL[data->kind],
+				  data->watchdog_control);
 leave:
 	mutex_unlock(&data->watchdog_lock);
 	return ret;
@@ -682,7 +747,8 @@ static int watchdog_stop(struct fschmd_d
 	data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_STARTED;
 	/* Don't store the stop flag in our watchdog control register copy, as
 	   its a write only bit (read always returns 0) */
-	i2c_smbus_write_byte_data(data->client, FSCHMD_REG_WDOG_CONTROL,
+	i2c_smbus_write_byte_data(data->client,
+		FSCHMD_REG_WDOG_CONTROL[data->kind],
 		data->watchdog_control | FSCHMD_WDOG_CONTROL_STOP);
 leave:
 	mutex_unlock(&data->watchdog_lock);
@@ -856,7 +922,7 @@ static struct file_operations watchdog_f
 
 /* DMI decode routine to read voltage scaling factors from special DMI tables,
    which are available on FSC machines with an fscher or later chip. */
-static void fschmd_dmi_decode(const struct dmi_header *header)
+static void fschmd_dmi_decode(const struct dmi_header *header, void *priv)
 {
 	int i, mult[3] = { 0 }, offset[3] = { 0 }, vref = 0, found = 0;
 
@@ -912,6 +978,15 @@ static void fschmd_dmi_decode(const stru
 			dmi_mult[i] = mult[i] * 10;
 			dmi_offset[i] = offset[i] * 10;
 		}
+		/* According to the docs there should be separate dmi entries
+		   for the mult's and offsets of in3-5 of the syl, but on
+		   my test machine these are not present */
+		dmi_mult[3] = dmi_mult[2];
+		dmi_mult[4] = dmi_mult[1];
+		dmi_mult[5] = dmi_mult[2];
+		dmi_offset[3] = dmi_offset[2];
+		dmi_offset[4] = dmi_offset[1];
+		dmi_offset[5] = dmi_offset[2];
 		dmi_vref = vref;
 	}
 }
@@ -920,8 +995,6 @@ static int fschmd_detect(struct i2c_clie
 			 struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	const char * const client_names[5] = { "fscpos", "fscher", "fscscy",
-						"fschrc", "fschmd" };
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -948,11 +1021,13 @@ static int fschmd_detect(struct i2c_clie
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
@@ -961,8 +1036,8 @@ static int fschmd_probe(struct i2c_clien
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
@@ -991,7 +1066,7 @@ static int fschmd_probe(struct i2c_clien
 
 	/* Read the special DMI table for fscher and newer chips */
 	if ((kind == fscher || kind >= fschrc) && dmi_vref == -1) {
-		dmi_walk(fschmd_dmi_decode);
+		dmi_walk(fschmd_dmi_decode, NULL);
 		if (dmi_vref == -1) {
 			dev_warn(&client->dev,
 				"Couldn't get voltage scaling factors from "
@@ -1000,21 +1075,25 @@ static int fschmd_probe(struct i2c_clien
 		}
 	}
 
+	/* i2c kind goes from 1-6, we want from 0-5 to address arrays */
+	data->kind = kind - 1;
+
 	/* Read in some never changing registers */
 	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
 	data->global_control = i2c_smbus_read_byte_data(client,
 					FSCHMD_REG_CONTROL);
 	data->watchdog_control = i2c_smbus_read_byte_data(client,
-					FSCHMD_REG_WDOG_CONTROL);
+					FSCHMD_REG_WDOG_CONTROL[data->kind]);
 	data->watchdog_state = i2c_smbus_read_byte_data(client,
-					FSCHMD_REG_WDOG_STATE);
+					FSCHMD_REG_WDOG_STATE[data->kind]);
 	data->watchdog_preset = i2c_smbus_read_byte_data(client,
-					FSCHMD_REG_WDOG_PRESET);
+					FSCHMD_REG_WDOG_PRESET[data->kind]);
 
-	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
-	data->kind = kind - 1;
+	err = device_create_file(&client->dev, &dev_attr_alert_led);
+	if (err)
+		goto exit_detach;
 
-	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++) {
+	for (i = 0; i < FSCHMD_NO_VOLT_SENSORS[data->kind]; i++) {
 		err = device_create_file(&client->dev,
 					&fschmd_attr[i].dev_attr);
 		if (err)
@@ -1027,6 +1106,16 @@ static int fschmd_probe(struct i2c_clien
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
@@ -1040,6 +1129,16 @@ static int fschmd_probe(struct i2c_clien
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
@@ -1126,7 +1225,7 @@ static int fschmd_remove(struct i2c_clie
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
-	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++)
+	for (i = 0; i < (FSCHMD_NO_VOLT_SENSORS[data->kind] + 1); i++)
 		device_remove_file(&client->dev, &fschmd_attr[i].dev_attr);
 	for (i = 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++)
 		device_remove_file(&client->dev,
@@ -1171,7 +1270,7 @@ static struct fschmd_data *fschmd_update
 					data->temp_act[i] < data->temp_max[i])
 				i2c_smbus_write_byte_data(client,
 					FSCHMD_REG_TEMP_STATE[data->kind][i],
-					FSCHMD_TEMP_ALERT);
+					data->temp_status[i]);
 		}
 
 		for (i = 0; i < FSCHMD_NO_FAN_SENSORS[data->kind]; i++) {
@@ -1193,12 +1292,12 @@ static struct fschmd_data *fschmd_update
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
@@ -1220,8 +1319,8 @@ static void __exit fschmd_exit(void)
 }
 
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
-			"Heimdall driver");
+MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles, Heimdall and "
+			"Syleus driver");
 MODULE_LICENSE("GPL");
 
 module_init(fschmd_init);

--------------050900070806050105020702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050900070806050105020702--
