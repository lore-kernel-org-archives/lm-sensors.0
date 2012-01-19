From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:07 +0000
Subject: [lm-sensors] [PATCH 73/82] hwmon: (w83627ehf) Fix multi-line comments
Message-Id: <1327017376-20466-74-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |  192 +++++++++++++++++++++++++-------------------
 1 files changed, 109 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0e0af04..2a61685 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1,50 +1,50 @@
 /*
-    w83627ehf - Driver for the hardware monitoring functionality of
-		the Winbond W83627EHF Super-I/O chip
-    Copyright (C) 2005-2011  Jean Delvare <khali@linux-fr.org>
-    Copyright (C) 2006  Yuan Mu (Winbond),
-			Rudolf Marek <r.marek@assembler.cz>
-			David Hubbard <david.c.hubbard@gmail.com>
-			Daniel J Blueman <daniel.blueman@gmail.com>
-    Copyright (C) 2010  Sheng-Yuan Huang (Nuvoton) (PS00)
-
-    Shamelessly ripped from the w83627hf driver
-    Copyright (C) 2003  Mark Studebaker
-
-    Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
-    in testing and debugging this driver.
-
-    This driver also supports the W83627EHG, which is the lead-free
-    version of the W83627EHF.
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
-
-
-    Supports the following chips:
-
-    Chip        #vin    #fan    #pwm    #temp  chip IDs       man ID
-    w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
-					       0x8860 0xa1
-    w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
-    w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
-    w83627uhg    8      2       2       2      0xa230 0xc1    0x5ca3
-    w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
-    w83667hg-b   9      5       3       4      0xb350 0xc1    0x5ca3
-    nct6775f     9      4       3       9      0xb470 0xc1    0x5ca3
-    nct6776f     9      5       3       9      0xC330 0xc1    0x5ca3
-*/
+ * w83627ehf - Driver for the hardware monitoring functionality of
+ *	       the Winbond W83627EHF Super-I/O chip
+ * Copyright (C) 2005-2011  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2006  Yuan Mu (Winbond),
+ *		       Rudolf Marek <r.marek@assembler.cz>
+ *		       David Hubbard <david.c.hubbard@gmail.com>
+ *		       Daniel J Blueman <daniel.blueman@gmail.com>
+ * Copyright (C) 2010  Sheng-Yuan Huang (Nuvoton) (PS00)
+ *
+ * Shamelessly ripped from the w83627hf driver
+ * Copyright (C) 2003  Mark Studebaker
+ *
+ * Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
+ * in testing and debugging this driver.
+ *
+ * This driver also supports the W83627EHG, which is the lead-free
+ * version of the W83627EHF.
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
+ *
+ *
+ * Supports the following chips:
+ *
+ * Chip        #vin    #fan    #pwm    #temp  chip IDs       man ID
+ * w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
+ *					      0x8860 0xa1
+ * w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
+ * w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
+ * w83627uhg    8      2       2       2      0xa230 0xc1    0x5ca3
+ * w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
+ * w83667hg-b   9      5       3       4      0xb350 0xc1    0x5ca3
+ * nct6775f     9      4       3       9      0xb470 0xc1    0x5ca3
+ * nct6776f     9      5       3       9      0xC330 0xc1    0x5ca3
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -164,11 +164,13 @@ superio_exit(int ioreg)
 #define W83627EHF_REG_BANK		0x4E
 #define W83627EHF_REG_CONFIG		0x40
 
-/* Not currently used:
+/*
+ * Not currently used:
  * REG_MAN_ID has the value 0x5ca3 for all supported chips.
  * REG_CHIP_ID = 0x88/0xa1/0xc1 depending on chip model.
  * REG_MAN_ID is at port 0x4f
- * REG_CHIP_ID is at port 0x58 */
+ * REG_CHIP_ID is at port 0x58
+ */
 
 static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
 static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
@@ -393,8 +395,10 @@ div_from_reg(u8 reg)
 	return 1 << reg;
 }
 
-/* Some of the voltage inputs have internal scaling, the tables below
- * contain 8 (the ADC LSB in mV) * scaling factor * 100 */
+/*
+ * Some of the voltage inputs have internal scaling, the tables below
+ * contain 8 (the ADC LSB in mV) * scaling factor * 100
+ */
 static const u16 scale_in_common[10] = {
 	800, 800, 1600, 1600, 800, 800, 800, 1600, 1600, 800
 };
@@ -469,13 +473,15 @@ struct w83627ehf_data {
 	u8 caseopen;
 
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
-	u8 pwm_enable[4]; /* 1->manual
-			     2->thermal cruise mode (also called SmartFan I)
-			     3->fan speed cruise mode
-			     4->variable thermal cruise (also called
-				SmartFan III)
-			     5->enhanced variable thermal cruise (also called
-				SmartFan IV) */
+	u8 pwm_enable[4]; /*
+			   * 1->manual
+			   * 2->thermal cruise mode (also called SmartFan I)
+			   * 3->fan speed cruise mode
+			   * 4->variable thermal cruise (also called
+			   * SmartFan III)
+			   * 5->enhanced variable thermal cruise (also called
+			   * SmartFan IV)
+			   */
 	u8 pwm_enable_orig[4];	/* original value of pwm_enable */
 	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
@@ -816,9 +822,11 @@ static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 				data->fan_min[i] = w83627ehf_read_value(data,
 					   data->REG_FAN_MIN[i]);
 
-			/* If we failed to measure the fan speed and clock
-			   divider can be increased, let's try that for next
-			   time */
+			/*
+			 * If we failed to measure the fan speed and clock
+			 * divider can be increased, let's try that for next
+			 * time
+			 */
 			if (data->has_fan_div
 			    && (reg >= 0xff || (sio_data->kind = nct6775
 						&& reg = 0x00))
@@ -1081,25 +1089,31 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 		new_div = data->fan_div[nr]; /* No change */
 		dev_info(dev, "fan%u low limit and alarm disabled\n", nr + 1);
 	} else if ((reg = 1350000U / val) >= 128 * 255) {
-		/* Speed below this value cannot possibly be represented,
-		   even with the highest divider (128) */
+		/*
+		 * Speed below this value cannot possibly be represented,
+		 * even with the highest divider (128)
+		 */
 		data->fan_min[nr] = 254;
 		new_div = 7; /* 128 = (1 << 7) */
 		dev_warn(dev, "fan%u low limit %lu below minimum %u, set to "
 			 "minimum\n", nr + 1, val,
 			 data->fan_from_reg_min(254, 7));
 	} else if (!reg) {
-		/* Speed above this value cannot possibly be represented,
-		   even with the lowest divider (1) */
+		/*
+		 * Speed above this value cannot possibly be represented,
+		 * even with the lowest divider (1)
+		 */
 		data->fan_min[nr] = 1;
 		new_div = 0; /* 1 = (1 << 0) */
 		dev_warn(dev, "fan%u low limit %lu above maximum %u, set to "
 			 "maximum\n", nr + 1, val,
 			 data->fan_from_reg_min(1, 0));
 	} else {
-		/* Automatically pick the best divider, i.e. the one such
-		   that the min limit will correspond to a register value
-		   in the 96..192 range */
+		/*
+		 * Automatically pick the best divider, i.e. the one such
+		 * that the min limit will correspond to a register value
+		 * in the 96..192 range
+		 */
 		new_div = 0;
 		while (reg > 192 && new_div < 7) {
 			reg >>= 1;
@@ -1108,8 +1122,10 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 		data->fan_min[nr] = reg;
 	}
 
-	/* Write both the fan clock divider (if it changed) and the new
-	   fan min (unconditionally) */
+	/*
+	 * Write both the fan clock divider (if it changed) and the new
+	 * fan min (unconditionally)
+	 */
 	if (new_div != data->fan_div[nr]) {
 		dev_dbg(dev, "fan%u clock divider changed from %u to %u\n",
 			nr + 1, div_from_reg(data->fan_div[nr]),
@@ -1730,8 +1746,10 @@ static struct sensor_device_attribute_2 sda_caseopen[] = {
 
 static void w83627ehf_device_remove_files(struct device *dev)
 {
-	/* some entries in the following arrays may not have been used in
-	 * device_create_file(), but device_remove_file() will ignore them */
+	/*
+	 * some entries in the following arrays may not have been used in
+	 * device_create_file(), but device_remove_file() will ignore them
+	 */
 	int i;
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
 
@@ -2255,9 +2273,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 	/* Read VID value */
 	if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b ||
 	    sio_data->kind = nct6775 || sio_data->kind = nct6776) {
-		/* W83667HG has different pins for VID input and output, so
-		we can get the VID input values directly at logical device D
-		0xe3. */
+		/*
+		 * W83667HG has different pins for VID input and output, so
+		 * we can get the VID input values directly at logical device D
+		 * 0xe3.
+		 */
 		superio_select(sio_data->sioreg, W83667HG_LD_VID);
 		data->vid = superio_inb(sio_data->sioreg, 0xe3);
 		err = device_create_file(dev, &dev_attr_cpu0_vid);
@@ -2266,11 +2286,13 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 	} else if (sio_data->kind != w83627uhg) {
 		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
 		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
-			/* Set VID input sensibility if needed. In theory the
-			   BIOS should have set it, but in practice it's not
-			   always the case. We only do it for the W83627EHF/EHG
-			   because the W83627DHG is more complex in this
-			   respect. */
+			/*
+			 * Set VID input sensibility if needed. In theory the
+			 * BIOS should have set it, but in practice it's not
+			 * always the case. We only do it for the W83627EHF/EHG
+			 * because the W83627DHG is more complex in this
+			 * respect.
+			 */
 			if (sio_data->kind = w83627ehf) {
 				en_vrm10 = superio_inb(sio_data->sioreg,
 						       SIO_REG_EN_VRM10);
@@ -2599,10 +2621,12 @@ static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
 	return 0;
 }
 
-/* when Super-I/O functions move to a separate file, the Super-I/O
+/*
+ * when Super-I/O functions move to a separate file, the Super-I/O
  * bus will manage the lifetime of the device and this module will only keep
  * track of the w83627ehf driver. But since we platform_device_alloc(), we
- * must keep track of the device */
+ * must keep track of the device
+ */
 static struct platform_device *pdev;
 
 static int __init sensors_w83627ehf_init(void)
@@ -2612,11 +2636,13 @@ static int __init sensors_w83627ehf_init(void)
 	struct resource res;
 	struct w83627ehf_sio_data sio_data;
 
-	/* initialize sio_data->kind and sio_data->sioreg.
+	/*
+	 * initialize sio_data->kind and sio_data->sioreg.
 	 *
 	 * when Super-I/O functions move to a separate file, the Super-I/O
 	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
-	 * w83627ehf hardware monitor, and call probe() */
+	 * w83627ehf hardware monitor, and call probe()
+	 */
 	if (w83627ehf_find(0x2e, &address, &sio_data) &&
 	    w83627ehf_find(0x4e, &address, &sio_data))
 		return -ENODEV;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
