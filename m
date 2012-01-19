From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:06 +0000
Subject: [lm-sensors] [PATCH 72/82] hwmon: (vt8231) Fix multi-line comments
Message-Id: <1327017376-20466-73-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Roger Lucas <vt8231@hiddenengine.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt8231.c |  164 +++++++++++++++++++++++++----------------------
 1 files changed, 87 insertions(+), 77 deletions(-)

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index eb74f37..386a845 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -1,28 +1,29 @@
 /*
-	vt8231.c - Part of lm_sensors, Linux kernel modules
-				for hardware monitoring
+ * vt8231.c - Part of lm_sensors, Linux kernel modules
+ *	      for hardware monitoring
+ *
+ * Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
+ * Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+ *		      Aaron M. Marsh <amarsh@sdf.lonestar.org>
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
 
-	Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
-	Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-			   Aaron M. Marsh <amarsh@sdf.lonestar.org>
-
-	This program is free software; you can redistribute it and/or modify
-	it under the terms of the GNU General Public License as published by
-	the Free Software Foundation; either version 2 of the License, or
-	(at your option) any later version.
-
-	This program is distributed in the hope that it will be useful,
-	but WITHOUT ANY WARRANTY; without even the implied warranty of
-	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-	GNU General Public License for more details.
-
-	You should have received a copy of the GNU General Public License
-	along with this program; if not, write to the Free Software
-	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-/* Supports VIA VT8231 South Bridge embedded sensors
-*/
+/*
+ * Supports VIA VT8231 South Bridge embedded sensors
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -50,26 +51,27 @@ static struct platform_device *pdev;
 #define VT8231_BASE_REG 0x70
 #define VT8231_ENABLE_REG 0x74
 
-/* The VT8231 registers
-
-   The reset value for the input channel configuration is used (Reg 0x4A=0x07)
-   which sets the selected inputs marked with '*' below if multiple options are
-   possible:
-
-		    Voltage Mode	  Temperature Mode
-	Sensor	      Linux Id	      Linux Id	      VIA Id
-	--------      --------	      --------	      ------
-	CPU Diode	N/A		temp1		0
-	UIC1		in0		temp2 *		1
-	UIC2		in1 *		temp3		2
-	UIC3		in2 *		temp4		3
-	UIC4		in3 *		temp5		4
-	UIC5		in4 *		temp6		5
-	3.3V		in5		N/A
-
-   Note that the BIOS may set the configuration register to a different value
-   to match the motherboard configuration.
-*/
+/*
+ * The VT8231 registers
+ *
+ * The reset value for the input channel configuration is used (Reg 0x4A=0x07)
+ * which sets the selected inputs marked with '*' below if multiple options are
+ * possible:
+ *
+ *		    Voltage Mode	  Temperature Mode
+ *	Sensor	      Linux Id	      Linux Id	      VIA Id
+ *	--------      --------	      --------	      ------
+ *	CPU Diode	N/A		temp1		0
+ *	UIC1		in0		temp2 *		1
+ *	UIC2		in1 *		temp3		2
+ *	UIC3		in2 *		temp4		3
+ *	UIC4		in3 *		temp5		4
+ *	UIC5		in4 *		temp6		5
+ *	3.3V		in5		N/A
+ *
+ * Note that the BIOS may set the configuration register to a different value
+ * to match the motherboard configuration.
+ */
 
 /* fans numbered 0-1 */
 #define VT8231_REG_FAN_MIN(nr)	(0x3b + (nr))
@@ -81,13 +83,14 @@ static const u8 regvolt[]    = { 0x21, 0x22, 0x23, 0x24, 0x25, 0x26 };
 static const u8 regvoltmax[] = { 0x3d, 0x2b, 0x2d, 0x2f, 0x31, 0x33 };
 static const u8 regvoltmin[] = { 0x3e, 0x2c, 0x2e, 0x30, 0x32, 0x34 };
 
-/* Temperatures are numbered 1-6 according to the Linux kernel specification.
-**
-** In the VIA datasheet, however, the temperatures are numbered from zero.
-** Since it is important that this driver can easily be compared to the VIA
-** datasheet, we will use the VIA numbering within this driver and map the
-** kernel sysfs device name to the VIA number in the sysfs callback.
-*/
+/*
+ * Temperatures are numbered 1-6 according to the Linux kernel specification.
+ *
+ * In the VIA datasheet, however, the temperatures are numbered from zero.
+ * Since it is important that this driver can easily be compared to the VIA
+ * datasheet, we will use the VIA numbering within this driver and map the
+ * kernel sysfs device name to the VIA number in the sysfs callback.
+ */
 
 #define VT8231_REG_TEMP_LOW01	0x49
 #define VT8231_REG_TEMP_LOW25	0x4d
@@ -108,9 +111,10 @@ static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
 #define VT8231_REG_TEMP1_CONFIG 0x4b
 #define VT8231_REG_TEMP2_CONFIG 0x4c
 
-/* temps 0-5 as numbered in VIA datasheet - see later for mapping to Linux
-** numbering
-*/
+/*
+ * temps 0-5 as numbered in VIA datasheet - see later for mapping to Linux
+ * numbering
+ */
 #define ISTEMP(i, ch_config) ((i) = 0 ? 1 : \
 			      ((ch_config) >> ((i)+1)) & 0x01)
 /* voltages 0-5 */
@@ -119,24 +123,26 @@ static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
 
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* NB  The values returned here are NOT temperatures.  The calibration curves
-**     for the thermistor curves are board-specific and must go in the
-**     sensors.conf file.  Temperature sensors are actually ten bits, but the
-**     VIA datasheet only considers the 8 MSBs obtained from the regtemp[]
-**     register.  The temperature value returned should have a magnitude of 3,
-**     so we use the VIA scaling as the "true" scaling and use the remaining 2
-**     LSBs as fractional precision.
-**
-**     All the on-chip hardware temperature comparisons for the alarms are only
-**     8-bits wide, and compare against the 8 MSBs of the temperature.  The bits
-**     in the registers VT8231_REG_TEMP_LOW01 and VT8231_REG_TEMP_LOW25 are
-**     ignored.
-*/
-
-/******** FAN RPM CONVERSIONS ********
-** This chip saturates back at 0, not at 255 like many the other chips.
-** So, 0 means 0 RPM
-*/
+/*
+ * NB  The values returned here are NOT temperatures.  The calibration curves
+ *     for the thermistor curves are board-specific and must go in the
+ *     sensors.conf file.  Temperature sensors are actually ten bits, but the
+ *     VIA datasheet only considers the 8 MSBs obtained from the regtemp[]
+ *     register.  The temperature value returned should have a magnitude of 3,
+ *     so we use the VIA scaling as the "true" scaling and use the remaining 2
+ *     LSBs as fractional precision.
+ *
+ *     All the on-chip hardware temperature comparisons for the alarms are only
+ *     8-bits wide, and compare against the 8 MSBs of the temperature.  The bits
+ *     in the registers VT8231_REG_TEMP_LOW01 and VT8231_REG_TEMP_LOW25 are
+ *     ignored.
+ */
+
+/*
+ ****** FAN RPM CONVERSIONS ********
+ * This chip saturates back at 0, not at 255 like many the other chips.
+ * So, 0 means 0 RPM
+ */
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
@@ -463,9 +469,10 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* Note that these map the Linux temperature sensor numbering (1-6) to the VIA
-** temperature sensor numbering (0-5)
-*/
+/*
+ * Note that these map the Linux temperature sensor numbering (1-6) to the VIA
+ * temperature sensor numbering (0-5)
+ */
 #define define_temperature_sysfs(offset)				\
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
 		show_temp, NULL, offset - 1);				\
@@ -1032,13 +1039,16 @@ static int __devinit vt8231_pci_probe(struct pci_dev *dev,
 	if (vt8231_device_add(address))
 		goto exit_unregister;
 
-	/* Always return failure here.  This is to allow other drivers to bind
+	/*
+	 * Always return failure here.  This is to allow other drivers to bind
 	 * to this pci device.  We don't really want to have control over the
 	 * pci device, we only wanted to read as few register values from it.
 	 */
 
-	/* We do, however, mark ourselves as using the PCI device to stop it
-	   getting unloaded. */
+	/*
+	 * We do, however, mark ourselves as using the PCI device to stop it
+	 * getting unloaded.
+	 */
 	s_bridge = pci_dev_get(dev);
 	return -ENODEV;
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
