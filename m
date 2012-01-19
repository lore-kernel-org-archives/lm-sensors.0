From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:08 +0000
Subject: [lm-sensors] [PATCH 14/82] hwmon: (asb100) Fix multi-line comments
Message-Id: <1327017376-20466-15-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Mark M Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asb100.c |  122 +++++++++++++++++++++++++++---------------------
 1 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index a5f1642..e937280 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -1,40 +1,40 @@
 /*
-    asb100.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-
-    Copyright (C) 2004 Mark M. Hoffman <mhoffman@lightlink.com>
-
-	(derived from w83781d.c)
-
-    Copyright (C) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>, and
-    Mark Studebaker <mdsxyz123@yahoo.com>
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
+ * asb100.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	      monitoring
+ *
+ * Copyright (C) 2004 Mark M. Hoffman <mhoffman@lightlink.com>
+ *
+ * (derived from w83781d.c)
+ *
+ * Copyright (C) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
+ *			      Philip Edelbrock <phil@netroedge.com>, and
+ *			      Mark Studebaker <mdsxyz123@yahoo.com>
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
 
 /*
-    This driver supports the hardware sensor chips: Asus ASB100 and
-    ASB100-A "BACH".
-
-    ASB100-A supports pwm1, while plain ASB100 does not.  There is no known
-    way for the driver to tell which one is there.
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    asb100	7	3	1	4	0x31	0x0694	yes	no
-*/
+ * This driver supports the hardware sensor chips: Asus ASB100 and
+ * ASB100-A "BACH".
+ *
+ * ASB100-A supports pwm1, while plain ASB100 does not.  There is no known
+ * way for the driver to tell which one is there.
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * asb100	7	3	1	4	0x31	0x0694	yes	no
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -99,15 +99,19 @@ static const u16 asb100_reg_temp_hyst[]	= {0, 0x3a, 0x153, 0x253, 0x19};
 /* bit 7 -> enable, bits 0-3 -> duty cycle */
 #define ASB100_REG_PWM1		0x59
 
-/* CONVERSIONS
-   Rounding and limit checking is only done on the TO_REG variants. */
+/*
+ * CONVERSIONS
+ * Rounding and limit checking is only done on the TO_REG variants.
+ */
 
 /* These constants are a guess, consistent w/ w83781d */
 #define ASB100_IN_MIN		0
 #define ASB100_IN_MAX		4080
 
-/* IN: 1/1000 V (0V to 4.08V)
-   REG: 16mV/bit */
+/*
+ * IN: 1/1000 V (0V to 4.08V)
+ * REG: 16mV/bit
+ */
 static u8 IN_TO_REG(unsigned val)
 {
 	unsigned nval = SENSORS_LIMIT(val, ASB100_IN_MIN, ASB100_IN_MAX);
@@ -138,8 +142,10 @@ static int FAN_FROM_REG(u8 val, int div)
 #define ASB100_TEMP_MIN		-128000
 #define ASB100_TEMP_MAX		127000
 
-/* TEMP: 0.001C/bit (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 0.001C/bit (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static u8 TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
@@ -152,8 +158,10 @@ static int TEMP_FROM_REG(u8 reg)
 	return (s8)reg * 1000;
 }
 
-/* PWM: 0 - 255 per sensors documentation
-   REG: (6.25% duty cycle per bit) */
+/*
+ * PWM: 0 - 255 per sensors documentation
+ * REG: (6.25% duty cycle per bit)
+ */
 static u8 ASB100_PWM_TO_REG(int pwm)
 {
 	pwm = SENSORS_LIMIT(pwm, 0, 255);
@@ -167,16 +175,20 @@ static int ASB100_PWM_FROM_REG(u8 reg)
 
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
-   REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
+/*
+ * FAN DIV: 1, 2, 4, or 8 (defaults to 2)
+ * REG: 0, 1, 2, or 3 (respectively) (defaults to 1)
+ */
 static u8 DIV_TO_REG(long val)
 {
 	return val = 8 ? 3 : val = 4 ? 2 : val = 1 ? 0 : 1;
 }
 
-/* For each registered client, we need to keep some data in memory. That
-   data is pointed to by client->data. The structure itself is
-   dynamically allocated, at the same time the client itself is allocated. */
+/*
+ * For each registered client, we need to keep some data in memory. That
+ * data is pointed to by client->data. The structure itself is
+ * dynamically allocated, at the same time the client itself is allocated.
+ */
 struct asb100_data {
 	struct device *hwmon_dev;
 	struct mutex lock;
@@ -331,10 +343,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan divisor.  This follows the principle of
-   least surprise; the user doesn't expect the fan minimum to change just
-   because the divisor changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan divisor.  This follows the principle of
+ * least surprise; the user doesn't expect the fan minimum to change just
+ * because the divisor changed.
+ */
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
@@ -836,8 +850,10 @@ static int asb100_remove(struct i2c_client *client)
 	return 0;
 }
 
-/* The SMBus locks itself, usually, but nothing may access the chip between
-   bank switches. */
+/*
+ * The SMBus locks itself, usually, but nothing may access the chip between
+ * bank switches.
+ */
 static int asb100_read_value(struct i2c_client *client, u16 reg)
 {
 	struct asb100_data *data = i2c_get_clientdata(client);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
