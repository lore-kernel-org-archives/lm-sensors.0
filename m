From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:59 +0000
Subject: [lm-sensors] [PATCH 05/82] hwmon: (adm1026) Fix multi-line comments
Message-Id: <1327017376-20466-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |   91 +++++++++++++++++++++++++++----------------=
---
 1 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index cd773ce..7575630 100644
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
@@ -197,7 +201,8 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
 	0, 255))
 #define INS_FROM_REG(n, val) (SCALE(val, 192, adm1026_scaling[n]))
=20
-/* FAN speed is measured using 22.5kHz clock and counts for 2 pulses
+/*
+ * FAN speed is measured using 22.5kHz clock and counts for 2 pulses
  *   and we assume a 2 pulse-per-rev fan tach signal
  *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) =3D 1350000
  */
@@ -223,14 +228,16 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
 #define PWM_MIN_TO_REG(val) ((val) & 0xf0)
 #define PWM_MIN_FROM_REG(val) (((val) & 0xf0) + ((val) >> 4))
=20
-/* Analog output is a voltage, and scaled to millivolts.  The datasheet
+/*
+ * Analog output is a voltage, and scaled to millivolts.  The datasheet
  *   indicates that the DAC could be used to drive the fans, but in our
  *   example board (Arima HDAMA) it isn't connected to the fans at all.
  */
 #define DAC_TO_REG(val) (SENSORS_LIMIT(((((val) * 255) + 500) / 2500), 0, =
255))
 #define DAC_FROM_REG(val) (((val) * 2500) / 255)
=20
-/* Chip sampling rates
+/*
+ * Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
  *    so it doesn't make sense to read them more often than that.
@@ -244,11 +251,13 @@ static int adm1026_scaling[] =3D { /* .001 Volts */
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
@@ -485,7 +496,8 @@ static void adm1026_fixup_gpio(struct i2c_client *clien=
t)
 	int value;
=20
 	/* Make the changes requested. */
-	/* We may need to unlock/stop monitoring or soft-reset the
+	/*
+	 * We may need to unlock/stop monitoring or soft-reset the
 	 *    chip before we can make changes.  This hasn't been
 	 *    tested much.  FIXME
 	 */
@@ -571,8 +583,10 @@ static struct adm1026_data *adm1026_update_device(stru=
ct device *dev)
 		}
=20
 		for (i =3D 0; i <=3D 2; ++i) {
-			/* NOTE: temp[] is s8 and we assume 2's complement
-			 *   "conversion" in the assignment */
+			/*
+			 * NOTE: temp[] is s8 and we assume 2's complement
+			 *   "conversion" in the assignment
+			 */
 			data->temp[i]  			    adm1026_read_value(client, ADM1026_REG_TEMP[i]);
 		}
@@ -626,7 +640,8 @@ static struct adm1026_data *adm1026_update_device(struc=
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
--=20
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
