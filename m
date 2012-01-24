From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:14 +0000
Subject: [lm-sensors] [PATCH 35/79] hwmon: (adm1026) Fix checkpatch issues
Message-Id: <1327373398-997-36-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: do not use assignment in if condition
ERROR: space prohibited after that '~' (ctx:WxW)
ERROR: space required after that ';' (ctx:VxO)
ERROR: space required after that ';' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=3D' (ctx:VxV)
ERROR: spaces required around that '=3D' (ctx:VxV)
ERROR: spaces required around that ':' (ctx:VxV)
WARNING: braces {} are not necessary for any arm of this statement
WARNING: braces {} are not necessary for single statement blocks
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed:
ERROR: Macros with multiple statements should be enclosed in a do - while l=
oop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |  491 ++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 313 insertions(+), 178 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index be17083..1003219 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1,27 +1,27 @@
 /*
-    adm1026.c - Part of lm_sensors, Linux kernel modules for hardware
-	     monitoring
-    Copyright (C) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.co=
m>
-    Copyright (C) 2004 Justin Thiessen <jthiessen@penguincomputing.com>
-
-    Chip details at:
-
-    <http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * adm1026.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (C) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
+ * Copyright (C) 2004 Justin Thiessen <jthiessen@penguincomputing.com>
+ *
+ * Chip details at:
+ *
+ * <http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
=20
 #include <linux/module.h>
 #include <linux/init.h>
@@ -90,7 +90,8 @@ MODULE_PARM_DESC(gpio_fan, "List of GPIO pins (0-7) to pr=
ogram as fan tachs");
 #define E2CFG_ROM		0x08
 #define E2CFG_CLK_EXT		0x80
=20
-/* There are 10 general analog inputs and 7 dedicated inputs
+/*
+ * There are 10 general analog inputs and 7 dedicated inputs
  * They are:
  *    0 - 9  =3D  AIN0 - AIN9
  *       10  =3D  Vbat
@@ -117,7 +118,8 @@ static u16 ADM1026_REG_IN_MAX[] =3D {
 		0x43, 0x44, 0x45, 0x46, 0x47
 	};
=20
-/* Temperatures are:
+/*
+ * Temperatures are:
  *    0 - Internal
  *    1 - External 1
  *    2 - External 2
@@ -170,12 +172,14 @@ static u16 ADM1026_REG_TEMP_OFFSET[] =3D { 0x1e, 0x6e=
, 0x6f };
 #define ADM1026_FAN_CONTROL_TEMP_RANGE	20
 #define ADM1026_PWM_MAX			255
=20
-/* Conversions. Rounding and limit checking is only done on the TO_REG
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
  * variants. Note that you should be a bit careful with which arguments
  * these macros are called: arguments may be evaluated more than once.
  */
=20
-/* IN are scaled according to built-in resistors.  These are the
+/*
+ * IN are scaled according to built-in resistors.  These are the
  *   voltages corresponding to 3/4 of full scale (192 or 0xc0)
  *   NOTE: The -12V input needs an additional factor to account
  *      for the Vref pullup resistor.
@@ -197,23 +201,25 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
 	0, 255))
 #define INS_FROM_REG(n, val) (SCALE(val, 192, adm1026_scaling[n]))
=20
-/* FAN speed is measured using 22.5kHz clock and counts for 2 pulses
+/*
+ * FAN speed is measured using 22.5kHz clock and counts for 2 pulses
  *   and we assume a 2 pulse-per-rev fan tach signal
  *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) =3D 1350000
  */
 #define FAN_TO_REG(val, div)  ((val) <=3D 0 ? 0xff : \
-				SENSORS_LIMIT(1350000/((val)*(div)), 1, 254))
-#define FAN_FROM_REG(val, div) ((val) =3D 0 ? -1:(val) =3D 0xff ? 0 : \
-				1350000/((val)*(div)))
-#define DIV_FROM_REG(val) (1<<(val))
+				SENSORS_LIMIT(1350000 / ((val) * (div)), \
+					      1, 254))
+#define FAN_FROM_REG(val, div) ((val) =3D 0 ? -1 : (val) =3D 0xff ? 0 : \
+				1350000 / ((val) * (div)))
+#define DIV_FROM_REG(val) (1 << (val))
 #define DIV_TO_REG(val) ((val) >=3D 8 ? 3 : (val) >=3D 4 ? 2 : (val) >=3D =
2 ? 1 : 0)
=20
 /* Temperature is reported in 1 degC increments */
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)+((val)<0 ? -500 : 500))/100=
0,\
-	-127, 127))
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500))=
 \
+					/ 1000, -127, 127))
 #define TEMP_FROM_REG(val) ((val) * 1000)
-#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val)+((val)<0 ? -500 : 500))/1=
000,\
-	-127, 127))
+#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val) + ((val) < 0 ? -500 : 500=
)) \
+					  / 1000, -127, 127))
 #define OFFSET_FROM_REG(val) ((val) * 1000)
=20
 #define PWM_TO_REG(val) (SENSORS_LIMIT(val, 0, 255))
@@ -222,14 +228,16 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
 #define PWM_MIN_TO_REG(val) ((val) & 0xf0)
 #define PWM_MIN_FROM_REG(val) (((val) & 0xf0) + ((val) >> 4))
=20
-/* Analog output is a voltage, and scaled to millivolts.  The datasheet
+/*
+ * Analog output is a voltage, and scaled to millivolts.  The datasheet
  *   indicates that the DAC could be used to drive the fans, but in our
  *   example board (Arima HDAMA) it isn't connected to the fans at all.
  */
-#define DAC_TO_REG(val) (SENSORS_LIMIT(((((val)*255)+500)/2500), 0, 255))
-#define DAC_FROM_REG(val) (((val)*2500)/255)
+#define DAC_TO_REG(val) (SENSORS_LIMIT(((((val) * 255) + 500) / 2500), 0, =
255))
+#define DAC_FROM_REG(val) (((val) * 2500) / 255)
=20
-/* Chip sampling rates
+/*
+ * Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
  *    so it doesn't make sense to read them more often than that.
@@ -243,11 +251,13 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
 #define ADM1026_DATA_INTERVAL		(1 * HZ)
 #define ADM1026_CONFIG_INTERVAL		(5 * 60 * HZ)
=20
-/* We allow for multiple chips in a single system.
+/*
+ * We allow for multiple chips in a single system.
  *
  * For each registered ADM1026, we need to keep state information
  * at client->data. The adm1026_data structure is dynamically
- * allocated, when a new client structure is allocated. */
+ * allocated, when a new client structure is allocated.
+ */
=20
 struct pwm_data {
 	u8 pwm;
@@ -388,17 +398,16 @@ static void adm1026_init_client(struct i2c_client *cl=
ient)
 		dev_dbg(&client->dev, "THERM pin enabled.  "
 			"GPIO16 disabled.\n");
 	}
-	if (data->config3 & CFG3_VREF_250) {
+	if (data->config3 & CFG3_VREF_250)
 		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
-	} else {
+	else
 		dev_dbg(&client->dev, "Vref is 1.82 Volts.\n");
-	}
 	/* Read and pick apart the existing GPIO configuration */
 	value =3D 0;
-	for (i =3D 0;i <=3D 15;++i) {
+	for (i =3D 0; i <=3D 15; ++i) {
 		if ((i & 0x03) =3D 0) {
 			value =3D adm1026_read_value(client,
-					ADM1026_REG_GPIO_CFG_0_3 + i/4);
+					ADM1026_REG_GPIO_CFG_0_3 + i / 4);
 		}
 		data->gpio_config[i] =3D value & 0x03;
 		value >>=3D 2;
@@ -408,7 +417,8 @@ static void adm1026_init_client(struct i2c_client *clie=
nt)
 	/* ... and then print it */
 	adm1026_print_gpio(client);
=20
-	/* If the user asks us to reprogram the GPIO config, then
+	/*
+	 * If the user asks us to reprogram the GPIO config, then
 	 * do it now.
 	 */
 	if (gpio_input[0] !=3D -1 || gpio_output[0] !=3D -1
@@ -417,7 +427,8 @@ static void adm1026_init_client(struct i2c_client *clie=
nt)
 		adm1026_fixup_gpio(client);
 	}
=20
-	/* WE INTENTIONALLY make no changes to the limits,
+	/*
+	 * WE INTENTIONALLY make no changes to the limits,
 	 *   offsets, pwms, fans and zones.  If they were
 	 *   configured, we don't want to mess with them.
 	 *   If they weren't, the default is 100% PWM, no
@@ -428,7 +439,7 @@ static void adm1026_init_client(struct i2c_client *clie=
nt)
 	 *   without first setting a value for pwm1.auto_pwm_min
 	 *   will not result in potentially dangerous fan speed decrease.
 	 */
-	data->pwm1.auto_pwm_min%5;
+	data->pwm1.auto_pwm_min =3D 255;
 	/* Start monitoring */
 	value =3D adm1026_read_value(client, ADM1026_REG_CONFIG1);
 	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
@@ -440,7 +451,7 @@ static void adm1026_init_client(struct i2c_client *clie=
nt)
 	/* initialize fan_div[] to hardware defaults */
 	value =3D adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
 		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
-	for (i =3D 0;i <=3D 7;++i) {
+	for (i =3D 0; i <=3D 7; ++i) {
 		data->fan_div[i] =3D DIV_FROM_REG(value & 0x03);
 		value >>=3D 2;
 	}
@@ -452,7 +463,7 @@ static void adm1026_print_gpio(struct i2c_client *clien=
t)
 	int i;
=20
 	dev_dbg(&client->dev, "GPIO config is:\n");
-	for (i =3D 0;i <=3D 7;++i) {
+	for (i =3D 0; i <=3D 7; ++i) {
 		if (data->config2 & (1 << i)) {
 			dev_dbg(&client->dev, "\t%sGP%s%d\n",
 				data->gpio_config[i] & 0x02 ? "" : "!",
@@ -462,7 +473,7 @@ static void adm1026_print_gpio(struct i2c_client *clien=
t)
 			dev_dbg(&client->dev, "\tFAN%d\n", i);
 		}
 	}
-	for (i =3D 8;i <=3D 15;++i) {
+	for (i =3D 8; i <=3D 15; ++i) {
 		dev_dbg(&client->dev, "\t%sGP%s%d\n",
 			data->gpio_config[i] & 0x02 ? "" : "!",
 			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
@@ -485,52 +496,46 @@ static void adm1026_fixup_gpio(struct i2c_client *cli=
ent)
 	int value;
=20
 	/* Make the changes requested. */
-	/* We may need to unlock/stop monitoring or soft-reset the
+	/*
+	 * We may need to unlock/stop monitoring or soft-reset the
 	 *    chip before we can make changes.  This hasn't been
 	 *    tested much.  FIXME
 	 */
=20
 	/* Make outputs */
-	for (i =3D 0;i <=3D 16;++i) {
-		if (gpio_output[i] >=3D 0 && gpio_output[i] <=3D 16) {
+	for (i =3D 0; i <=3D 16; ++i) {
+		if (gpio_output[i] >=3D 0 && gpio_output[i] <=3D 16)
 			data->gpio_config[gpio_output[i]] |=3D 0x01;
-		}
 		/* if GPIO0-7 is output, it isn't a FAN tach */
-		if (gpio_output[i] >=3D 0 && gpio_output[i] <=3D 7) {
+		if (gpio_output[i] >=3D 0 && gpio_output[i] <=3D 7)
 			data->config2 |=3D 1 << gpio_output[i];
-		}
 	}
=20
 	/* Input overrides output */
-	for (i =3D 0;i <=3D 16;++i) {
-		if (gpio_input[i] >=3D 0 && gpio_input[i] <=3D 16) {
-			data->gpio_config[gpio_input[i]] &=3D ~ 0x01;
-		}
+	for (i =3D 0; i <=3D 16; ++i) {
+		if (gpio_input[i] >=3D 0 && gpio_input[i] <=3D 16)
+			data->gpio_config[gpio_input[i]] &=3D ~0x01;
 		/* if GPIO0-7 is input, it isn't a FAN tach */
-		if (gpio_input[i] >=3D 0 && gpio_input[i] <=3D 7) {
+		if (gpio_input[i] >=3D 0 && gpio_input[i] <=3D 7)
 			data->config2 |=3D 1 << gpio_input[i];
-		}
 	}
=20
 	/* Inverted */
-	for (i =3D 0;i <=3D 16;++i) {
-		if (gpio_inverted[i] >=3D 0 && gpio_inverted[i] <=3D 16) {
-			data->gpio_config[gpio_inverted[i]] &=3D ~ 0x02;
-		}
+	for (i =3D 0; i <=3D 16; ++i) {
+		if (gpio_inverted[i] >=3D 0 && gpio_inverted[i] <=3D 16)
+			data->gpio_config[gpio_inverted[i]] &=3D ~0x02;
 	}
=20
 	/* Normal overrides inverted */
-	for (i =3D 0;i <=3D 16;++i) {
-		if (gpio_normal[i] >=3D 0 && gpio_normal[i] <=3D 16) {
+	for (i =3D 0; i <=3D 16; ++i) {
+		if (gpio_normal[i] >=3D 0 && gpio_normal[i] <=3D 16)
 			data->gpio_config[gpio_normal[i]] |=3D 0x02;
-		}
 	}
=20
 	/* Fan overrides input and output */
-	for (i =3D 0;i <=3D 7;++i) {
-		if (gpio_fan[i] >=3D 0 && gpio_fan[i] <=3D 7) {
+	for (i =3D 0; i <=3D 7; ++i) {
+		if (gpio_fan[i] >=3D 0 && gpio_fan[i] <=3D 7)
 			data->config2 &=3D ~(1 << gpio_fan[i]);
-		}
 	}
=20
 	/* Write new configs to registers */
@@ -538,7 +543,7 @@ static void adm1026_fixup_gpio(struct i2c_client *clien=
t)
 	data->config3 =3D (data->config3 & 0x3f)
 			| ((data->gpio_config[16] & 0x03) << 6);
 	adm1026_write_value(client, ADM1026_REG_CONFIG3, data->config3);
-	for (i =3D 15, value =3D 0;i >=3D 0;--i) {
+	for (i =3D 15, value =3D 0; i >=3D 0; --i) {
 		value <<=3D 2;
 		value |=3D data->gpio_config[i] & 0x03;
 		if ((i & 0x03) =3D 0) {
@@ -563,22 +568,25 @@ static struct adm1026_data *adm1026_update_device(str=
uct device *dev)
=20
 	mutex_lock(&data->update_lock);
 	if (!data->valid
-	    || time_after(jiffies, data->last_reading + ADM1026_DATA_INTERVAL)) {
+	    || time_after(jiffies,
+			  data->last_reading + ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
-		for (i =3D 0;i <=3D 16;++i) {
+		for (i =3D 0; i <=3D 16; ++i) {
 			data->in[i]  			    adm1026_read_value(client, ADM1026_REG_IN[i]);
 		}
=20
-		for (i =3D 0;i <=3D 7;++i) {
+		for (i =3D 0; i <=3D 7; ++i) {
 			data->fan[i]  			    adm1026_read_value(client, ADM1026_REG_FAN(i));
 		}
=20
-		for (i =3D 0;i <=3D 2;++i) {
-			/* NOTE: temp[] is s8 and we assume 2's complement
-			 *   "conversion" in the assignment */
+		for (i =3D 0; i <=3D 2; ++i) {
+			/*
+			 * NOTE: temp[] is s8 and we assume 2's complement
+			 *   "conversion" in the assignment
+			 */
 			data->temp[i]  			    adm1026_read_value(client, ADM1026_REG_TEMP[i]);
 		}
@@ -614,7 +622,7 @@ static struct adm1026_data *adm1026_update_device(struc=
t device *dev)
 	    time_after(jiffies, data->last_config + ADM1026_CONFIG_INTERVAL)) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
-		for (i =3D 0;i <=3D 16;++i) {
+		for (i =3D 0; i <=3D 16; ++i) {
 			data->in_min[i] =3D adm1026_read_value(client,
 				ADM1026_REG_IN_MIN[i]);
 			data->in_max[i] =3D adm1026_read_value(client,
@@ -624,7 +632,7 @@ static struct adm1026_data *adm1026_update_device(struc=
t device *dev)
 		value =3D adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
 			| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
 			<< 8);
-		for (i =3D 0;i <=3D 7;++i) {
+		for (i =3D 0; i <=3D 7; ++i) {
 			data->fan_min[i] =3D adm1026_read_value(client,
 				ADM1026_REG_FAN_MIN(i));
 			data->fan_div[i] =3D DIV_FROM_REG(value & 0x03);
@@ -632,7 +640,8 @@ static struct adm1026_data *adm1026_update_device(struc=
t device *dev)
 		}
=20
 		for (i =3D 0; i <=3D 2; ++i) {
-			/* NOTE: temp_xxx[] are s8 and we assume 2's
+			/*
+			 * NOTE: temp_xxx[] are s8 and we assume 2's
 			 *    complement "conversion" in the assignment
 			 */
 			data->temp_min[i] =3D adm1026_read_value(client,
@@ -681,7 +690,7 @@ static struct adm1026_data *adm1026_update_device(struc=
t device *dev)
 		data->gpio_config[16] =3D (data->config3 >> 6) & 0x03;
=20
 		value =3D 0;
-		for (i =3D 0;i <=3D 15;++i) {
+		for (i =3D 0; i <=3D 15; ++i) {
 			if ((i & 0x03) =3D 0) {
 				value =3D adm1026_read_value(client,
 					    ADM1026_REG_GPIO_CFG_0_3 + i/4);
@@ -721,7 +730,12 @@ static ssize_t set_in_min(struct device *dev, struct d=
evice_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D INS_TO_REG(nr, val);
@@ -744,7 +758,12 @@ static ssize_t set_in_max(struct device *dev, struct d=
evice_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D INS_TO_REG(nr, val);
@@ -779,23 +798,31 @@ in_reg(13);
 in_reg(14);
 in_reg(15);
=20
-static ssize_t show_in16(struct device *dev, struct device_attribute *attr=
, char *buf)
+static ssize_t show_in16(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in[16]) -
 		NEG12_OFFSET);
 }
-static ssize_t show_in16_min(struct device *dev, struct device_attribute *=
attr, char *buf)
+static ssize_t show_in16_min(struct device *dev, struct device_attribute *=
attr,
+			     char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_min[16])
 		- NEG12_OFFSET);
 }
-static ssize_t set_in16_min(struct device *dev, struct device_attribute *a=
ttr, const char *buf, size_t count)
+static ssize_t set_in16_min(struct device *dev, struct device_attribute *a=
ttr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_min[16] =3D INS_TO_REG(16, val + NEG12_OFFSET);
@@ -803,17 +830,24 @@ static ssize_t set_in16_min(struct device *dev, struc=
t device_attribute *attr, c
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_in16_max(struct device *dev, struct device_attribute *=
attr, char *buf)
+static ssize_t show_in16_max(struct device *dev, struct device_attribute *=
attr,
+			     char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_max[16])
 			- NEG12_OFFSET);
 }
-static ssize_t set_in16_max(struct device *dev, struct device_attribute *a=
ttr, const char *buf, size_t count)
+static ssize_t set_in16_max(struct device *dev, struct device_attribute *a=
ttr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->in_max[16] =3D INS_TO_REG(16, val+NEG12_OFFSET);
@@ -823,10 +857,10 @@ static ssize_t set_in16_max(struct device *dev, struc=
t device_attribute *attr, c
 }
=20
 static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in16, NULL, 16);
-static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min, set_=
in16_min, 16);
-static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_=
in16_max, 16);
-
-
+static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min,
+			  set_in16_min, 16);
+static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max,
+			  set_in16_max, 16);
=20
=20
 /* Now add fan read/write functions */
@@ -856,7 +890,12 @@ static ssize_t set_fan_min(struct device *dev, struct =
device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, data->fan_div[nr]);
@@ -890,9 +929,8 @@ static void fixup_fan_min(struct device *dev, int fan, =
int old_div)
 	int new_div =3D data->fan_div[fan];
=20
 	/* 0 and 0xff are special.  Don't adjust them */
-	if (data->fan_min[fan] =3D 0 || data->fan_min[fan] =3D 0xff) {
+	if (data->fan_min[fan] =3D 0 || data->fan_min[fan] =3D 0xff)
 		return;
-	}
=20
 	new_min =3D data->fan_min[fan] * old_div / new_div;
 	new_min =3D SENSORS_LIMIT(new_min, 1, 254);
@@ -916,9 +954,14 @@ static ssize_t set_fan_div(struct device *dev, struct =
device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val, orig_div, new_div;
+	long val;
+	int orig_div, new_div;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
-	val =3D simple_strtol(buf, NULL, 10);
 	new_div =3D DIV_TO_REG(val);
=20
 	mutex_lock(&data->update_lock);
@@ -939,9 +982,9 @@ static ssize_t set_fan_div(struct device *dev, struct d=
evice_attribute *attr,
 				    (DIV_TO_REG(data->fan_div[7]) << 6));
 	}
=20
-	if (data->fan_div[nr] !=3D orig_div) {
+	if (data->fan_div[nr] !=3D orig_div)
 		fixup_fan_min(dev, nr, orig_div);
-	}
+
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -983,7 +1026,12 @@ static ssize_t set_temp_min(struct device *dev, struc=
t device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
@@ -1007,7 +1055,12 @@ static ssize_t set_temp_max(struct device *dev, stru=
ct device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
@@ -1046,7 +1099,12 @@ static ssize_t set_temp_offset(struct device *dev,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] =3D TEMP_TO_REG(val);
@@ -1056,8 +1114,8 @@ static ssize_t set_temp_offset(struct device *dev,
 	return count;
 }
=20
-#define temp_offset_reg(offset)							\
-static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,		\
+#define temp_offset_reg(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,	\
 		show_temp_offset, set_temp_offset, offset - 1);
=20
 temp_offset_reg(1);
@@ -1097,7 +1155,12 @@ static ssize_t set_temp_auto_point1_temp(struct devi=
ce *dev,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_tmin[nr] =3D TEMP_TO_REG(val);
@@ -1131,15 +1194,21 @@ static ssize_t set_temp_crit_enable(struct device *=
dev,
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->config1 =3D (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, data->config1);
+	mutex_unlock(&data->update_lock);
=20
-	if ((val =3D 1) || (val=3D0)) {
-		mutex_lock(&data->update_lock);
-		data->config1 =3D (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
-		adm1026_write_value(client, ADM1026_REG_CONFIG1,
-			data->config1);
-		mutex_unlock(&data->update_lock);
-	}
 	return count;
 }
=20
@@ -1166,7 +1235,12 @@ static ssize_t set_temp_crit(struct device *dev, str=
uct device_attribute *attr,
 	int nr =3D sensor_attr->index;
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] =3D TEMP_TO_REG(val);
@@ -1184,17 +1258,24 @@ temp_crit_reg(1);
 temp_crit_reg(2);
 temp_crit_reg(3);
=20
-static ssize_t show_analog_out_reg(struct device *dev, struct device_attri=
bute *attr, char *buf)
+static ssize_t show_analog_out_reg(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", DAC_FROM_REG(data->analog_out));
 }
-static ssize_t set_analog_out_reg(struct device *dev, struct device_attrib=
ute *attr, const char *buf,
-		size_t count)
+static ssize_t set_analog_out_reg(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->analog_out =3D DAC_TO_REG(val);
@@ -1206,7 +1287,8 @@ static ssize_t set_analog_out_reg(struct device *dev,=
 struct device_attribute *a
 static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg,
 	set_analog_out_reg);
=20
-static ssize_t show_vid_reg(struct device *dev, struct device_attribute *a=
ttr, char *buf)
+static ssize_t show_vid_reg(struct device *dev, struct device_attribute *a=
ttr,
+			    char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	int vid =3D (data->gpio >> 11) & 0x1f;
@@ -1214,25 +1296,35 @@ static ssize_t show_vid_reg(struct device *dev, str=
uct device_attribute *attr, c
 	dev_dbg(dev, "Setting VID from GPIO11-15.\n");
 	return sprintf(buf, "%d\n", vid_from_reg(vid, data->vrm));
 }
+
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
=20
-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *a=
ttr, char *buf)
+static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *a=
ttr,
+			    char *buf)
 {
 	struct adm1026_data *data =3D dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *=
attr, const char *buf,
-		size_t count)
+
+static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *=
attr,
+			     const char *buf, size_t count)
 {
 	struct adm1026_data *data =3D dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
=20
-	data->vrm =3D simple_strtol(buf, NULL, 10);
+	data->vrm =3D val;
 	return count;
 }
=20
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
=20
-static ssize_t show_alarms_reg(struct device *dev, struct device_attribute=
 *attr, char *buf)
+static ssize_t show_alarms_reg(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarms);
@@ -1277,18 +1369,24 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, sho=
w_alarm, NULL, 24);
 static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 25);
 static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 26);
=20
-static ssize_t show_alarm_mask(struct device *dev, struct device_attribute=
 *attr, char *buf)
+static ssize_t show_alarm_mask(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarm_mask);
 }
-static ssize_t set_alarm_mask(struct device *dev, struct device_attribute =
*attr, const char *buf,
-		size_t count)
+static ssize_t set_alarm_mask(struct device *dev, struct device_attribute =
*attr,
+			      const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
 	unsigned long mask;
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->alarm_mask =3D val & 0x7fffffff;
@@ -1313,18 +1411,24 @@ static DEVICE_ATTR(alarm_mask, S_IRUGO | S_IWUSR, s=
how_alarm_mask,
 	set_alarm_mask);
=20
=20
-static ssize_t show_gpio(struct device *dev, struct device_attribute *attr=
, char *buf)
+static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio);
 }
-static ssize_t set_gpio(struct device *dev, struct device_attribute *attr,=
 const char *buf,
-		size_t count)
+static ssize_t set_gpio(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
 	long gpio;
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->gpio =3D val & 0x1ffff;
@@ -1340,19 +1444,24 @@ static ssize_t set_gpio(struct device *dev, struct =
device_attribute *attr, const
=20
 static DEVICE_ATTR(gpio, S_IRUGO | S_IWUSR, show_gpio, set_gpio);
=20
-
-static ssize_t show_gpio_mask(struct device *dev, struct device_attribute =
*attr, char *buf)
+static ssize_t show_gpio_mask(struct device *dev, struct device_attribute =
*attr,
+			      char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio_mask);
 }
-static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *=
attr, const char *buf,
-		size_t count)
+static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *=
attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
 	long mask;
+	long val;
+	int err;
+
+	err =3D kstrtol(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->gpio_mask =3D val & 0x1ffff;
@@ -1368,19 +1477,26 @@ static ssize_t set_gpio_mask(struct device *dev, st=
ruct device_attribute *attr,
=20
 static DEVICE_ATTR(gpio_mask, S_IRUGO | S_IWUSR, show_gpio_mask, set_gpio_=
mask);
=20
-static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *a=
ttr, char *buf)
+static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *a=
ttr,
+			    char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm1.pwm));
 }
-static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *at=
tr, const char *buf,
-		size_t count)
+
+static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *at=
tr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
=20
 	if (data->pwm1.enable =3D 1) {
-		int val =3D simple_strtol(buf, NULL, 10);
+		long val;
+		int err;
+
+		err =3D kstrtol(buf, 10, &val);
+		if (err)
+			return err;
=20
 		mutex_lock(&data->update_lock);
 		data->pwm1.pwm =3D PWM_TO_REG(val);
@@ -1389,17 +1505,26 @@ static ssize_t set_pwm_reg(struct device *dev, stru=
ct device_attribute *attr, co
 	}
 	return count;
 }
-static ssize_t show_auto_pwm_min(struct device *dev, struct device_attribu=
te *attr, char *buf)
+
+static ssize_t show_auto_pwm_min(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.auto_pwm_min);
 }
-static ssize_t set_auto_pwm_min(struct device *dev, struct device_attribut=
e *attr, const char *buf,
-		size_t count)
+
+static ssize_t set_auto_pwm_min(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
=20
 	mutex_lock(&data->update_lock);
 	data->pwm1.auto_pwm_min =3D SENSORS_LIMIT(val, 0, 255);
@@ -1411,44 +1536,53 @@ static ssize_t set_auto_pwm_min(struct device *dev,=
 struct device_attribute *att
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_auto_pwm_max(struct device *dev, struct device_attribu=
te *attr, char *buf)
+
+static ssize_t show_auto_pwm_max(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", ADM1026_PWM_MAX);
 }
-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute=
 *attr, char *buf)
+
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data =3D adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.enable);
 }
-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute =
*attr, const char *buf,
-		size_t count)
+
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute =
*attr,
+			      const char *buf, size_t count)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10);
 	int old_enable;
+	unsigned long val;
+	int err;
=20
-	if ((val >=3D 0) && (val < 3)) {
-		mutex_lock(&data->update_lock);
-		old_enable =3D data->pwm1.enable;
-		data->pwm1.enable =3D val;
-		data->config1 =3D (data->config1 & ~CFG1_PWM_AFC)
-				| ((val =3D 2) ? CFG1_PWM_AFC : 0);
-		adm1026_write_value(client, ADM1026_REG_CONFIG1,
-			data->config1);
-		if (val =3D 2) { /* apply pwm1_auto_pwm_min to pwm1 */
-			data->pwm1.pwm =3D PWM_TO_REG((data->pwm1.pwm & 0x0f) |
-				PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));
-			adm1026_write_value(client, ADM1026_REG_PWM,
-				data->pwm1.pwm);
-		} else if (!((old_enable =3D 1) && (val =3D 1))) {
-			/* set pwm to safe value */
-			data->pwm1.pwm =3D 255;
-			adm1026_write_value(client, ADM1026_REG_PWM,
-				data->pwm1.pwm);
-		}
-		mutex_unlock(&data->update_lock);
+	err =3D kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val >=3D 3)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	old_enable =3D data->pwm1.enable;
+	data->pwm1.enable =3D val;
+	data->config1 =3D (data->config1 & ~CFG1_PWM_AFC)
+			| ((val =3D 2) ? CFG1_PWM_AFC : 0);
+	adm1026_write_value(client, ADM1026_REG_CONFIG1, data->config1);
+	if (val =3D 2) { /* apply pwm1_auto_pwm_min to pwm1 */
+		data->pwm1.pwm =3D PWM_TO_REG((data->pwm1.pwm & 0x0f) |
+			PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));
+		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
+	} else if (!((old_enable =3D 1) && (val =3D 1))) {
+		/* set pwm to safe value */
+		data->pwm1.pwm =3D 255;
+		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
 	}
+	mutex_unlock(&data->update_lock);
+
 	return count;
 }
=20
@@ -1716,7 +1850,8 @@ static int adm1026_probe(struct i2c_client *client,
 	adm1026_init_client(client);
=20
 	/* Register sysfs hooks */
-	if ((err =3D sysfs_create_group(&client->dev.kobj, &adm1026_group)))
+	err =3D sysfs_create_group(&client->dev.kobj, &adm1026_group);
+	if (err)
 		goto exitfree;
 	if (data->config1 & CFG1_AIN8_9)
 		err =3D sysfs_create_group(&client->dev.kobj,
--=20
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
