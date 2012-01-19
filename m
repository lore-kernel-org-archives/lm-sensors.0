From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:09 +0000
Subject: [lm-sensors] [PATCH 75/82] hwmon: (w83781d) Fix multi-line comments
Message-Id: <1327017376-20466-76-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |  197 ++++++++++++++++++++++++++++-------------------
 1 files changed, 117 insertions(+), 80 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index e8a1900..cbed525 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1,37 +1,37 @@
 /*
-    w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
-		monitoring
-    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
-			       Philip Edelbrock <phil@netroedge.com>,
-			       and Mark Studebaker <mdsxyz123@yahoo.com>
-    Copyright (c) 2007 - 2008  Jean Delvare <khali@linux-fr.org>
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
+ * w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	       monitoring
+ * Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
+ *			      Philip Edelbrock <phil@netroedge.com>,
+ *			      and Mark Studebaker <mdsxyz123@yahoo.com>
+ * Copyright (c) 2007 - 2008  Jean Delvare <khali@linux-fr.org>
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
-    Supports following chips:
-
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    as99127f	7	3	0	3	0x31	0x12c3	yes	no
-    as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
-    w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
-    w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
-    w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
-
-*/
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * as99127f	7	3	0	3	0x31	0x12c3	yes	no
+ * as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
+ * w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
+ * w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
+ * w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
+ *
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -145,8 +145,10 @@ static const u8 W83781D_REG_PWM[] = { 0x5B, 0x5A, 0x5E, 0x5F };
 #define W83781D_REG_I2C_ADDR		0x48
 #define W83781D_REG_I2C_SUBADDR		0x4A
 
-/* The following are undocumented in the data sheets however we
-   received the information in an email from Winbond tech support */
+/*
+ * The following are undocumented in the data sheets however we
+ * received the information in an email from Winbond tech support
+ */
 /* Sensor selection - not on 781d */
 #define W83781D_REG_SCFG1		0x5D
 static const u8 BIT_SCFG1[] = { 0x02, 0x04, 0x08 };
@@ -238,9 +240,11 @@ struct w83781d_data {
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 pwm[4];		/* Register value */
 	u8 pwm2_enable;		/* Boolean */
-	u16 sens[3];		/* 782D/783S only.
-				   1 = pentium diode; 2 = 3904 diode;
-				   4 = thermistor */
+	u16 sens[3];		/*
+				 * 782D/783S only.
+				 * 1 = pentium diode; 2 = 3904 diode;
+				 * 4 = thermistor
+				 */
 	u8 vrm;
 };
 
@@ -636,10 +640,12 @@ show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
 		       (long) DIV_FROM_REG(data->fan_div[attr->index]));
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
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count)
@@ -847,7 +853,8 @@ static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
 	show_sensor, store_sensor, 2);
 
-/* Assumes that adapter is of I2C, not ISA variety.
+/*
+ * Assumes that adapter is of I2C, not ISA variety.
  * OTHERWISE DON'T CALL THIS
  */
 static int
@@ -1102,9 +1109,11 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/* We block updates of the ISA device to minimize the risk of
-	   concurrent access to the same W83781D chip through different
-	   interfaces. */
+	/*
+	 * We block updates of the ISA device to minimize the risk of
+	 * concurrent access to the same W83781D chip through different
+	 * interfaces.
+	 */
 	if (isa)
 		mutex_lock(&isa->update_lock);
 
@@ -1124,8 +1133,10 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 			"Detection of w83781d chip failed at step 4\n");
 		goto err_nodev;
 	}
-	/* If Winbond SMBus, check address at 0x48.
-	   Asus doesn't support, except for as99127f rev.2 */
+	/*
+	 * If Winbond SMBus, check address at 0x48.
+	 * Asus doesn't support, except for as99127f rev.2
+	 */
 	if ((!(val1 & 0x80) && val2 = 0xa3) ||
 	    ((val1 & 0x80) && val2 = 0x5c)) {
 		if (i2c_smbus_read_byte_data(client, W83781D_REG_I2C_ADDR)
@@ -1346,25 +1357,33 @@ w83781d_init_device(struct device *dev)
 	int type = data->type;
 	u8 tmp;
 
-	if (reset && type != as99127f) { /* this resets registers we don't have
-					   documentation for on the as99127f */
-		/* Resetting the chip has been the default for a long time,
-		   but it causes the BIOS initializations (fan clock dividers,
-		   thermal sensor types...) to be lost, so it is now optional.
-		   It might even go away if nobody reports it as being useful,
-		   as I see very little reason why this would be needed at
-		   all. */
+	if (reset && type != as99127f) { /*
+					  * this resets registers we don't have
+					  * documentation for on the as99127f
+					  */
+		/*
+		 * Resetting the chip has been the default for a long time,
+		 * but it causes the BIOS initializations (fan clock dividers,
+		 * thermal sensor types...) to be lost, so it is now optional.
+		 * It might even go away if nobody reports it as being useful,
+		 * as I see very little reason why this would be needed at
+		 * all.
+		 */
 		dev_info(dev, "If reset=1 solved a problem you were "
 			 "having, please report!\n");
 
 		/* save these registers */
 		i = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
 		p = w83781d_read_value(data, W83781D_REG_PWMCLK12);
-		/* Reset all except Watchdog values and last conversion values
-		   This sets fan-divs to 2, among others */
+		/*
+		 * Reset all except Watchdog values and last conversion values
+		 * This sets fan-divs to 2, among others
+		 */
 		w83781d_write_value(data, W83781D_REG_CONFIG, 0x80);
-		/* Restore the registers and disable power-on abnormal beep.
-		   This saves FAN 1/2/3 input/output values set by BIOS. */
+		/*
+		 * Restore the registers and disable power-on abnormal beep.
+		 * This saves FAN 1/2/3 input/output values set by BIOS.
+		 */
 		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
 		w83781d_write_value(data, W83781D_REG_PWMCLK12, p);
 		/*
@@ -1375,8 +1394,10 @@ w83781d_init_device(struct device *dev)
 		w83781d_write_value(data, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	/* Disable power-on abnormal beep, as advised by the datasheet.
-	   Already done if reset=1. */
+	/*
+	 * Disable power-on abnormal beep, as advised by the datasheet.
+	 * Already done if reset=1.
+	 */
 	if (init && !reset && type != as99127f) {
 		i = w83781d_read_value(data, W83781D_REG_BEEP_CONFIG);
 		w83781d_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
@@ -1533,8 +1554,10 @@ static struct w83781d_data *w83781d_update_device(struct device *dev)
 				     | (w83781d_read_value(data,
 						W83782D_REG_ALARM2) << 8);
 		} else {
-			/* No real-time status registers, fall back to
-			   interrupt status registers */
+			/*
+			 * No real-time status registers, fall back to
+			 * interrupt status registers
+			 */
 			data->alarms = w83781d_read_value(data,
 						W83781D_REG_ALARM1)
 				     | (w83781d_read_value(data,
@@ -1588,8 +1611,10 @@ static struct platform_device *pdev;
 
 static unsigned short isa_address = 0x290;
 
-/* I2C devices get this name attribute automatically, but for ISA devices
-   we must create it by ourselves. */
+/*
+ * I2C devices get this name attribute automatically, but for ISA devices
+ * we must create it by ourselves.
+ */
 static ssize_t
 show_name(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -1619,8 +1644,10 @@ static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
 	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
 		return 0;	/* Chip type doesn't match */
 
-	/* We compare all the limit registers, the config register and the
-	 * interrupt mask registers */
+	/*
+	 * We compare all the limit registers, the config register and the
+	 * interrupt mask registers
+	 */
 	for (i = 0x2b; i <= 0x3d; i++) {
 		if (w83781d_read_value(isa, i) ! 		    i2c_smbus_read_byte_data(client, i))
@@ -1701,12 +1728,14 @@ w83781d_write_value_isa(struct w83781d_data *data, u16 reg, u16 value)
 	}
 }
 
-/* The SMBus locks itself, usually, but nothing may access the Winbond between
-   bank switches. ISA access must always be locked explicitly!
-   We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83781D access and should not be necessary.
-   There are some ugly typecasts here, but the good news is - they should
-   nowhere else be necessary! */
+/*
+ * The SMBus locks itself, usually, but nothing may access the Winbond between
+ * bank switches. ISA access must always be locked explicitly!
+ * We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the W83781D access and should not be necessary.
+ * There are some ugly typecasts here, but the good news is - they should
+ * nowhere else be necessary!
+ */
 static int
 w83781d_read_value(struct w83781d_data *data, u16 reg)
 {
@@ -1833,9 +1862,11 @@ w83781d_isa_found(unsigned short address)
 	int val, save, found = 0;
 	int port;
 
-	/* Some boards declare base+0 to base+7 as a PNP device, some base+4
+	/*
+	 * Some boards declare base+0 to base+7 as a PNP device, some base+4
 	 * to base+7 and some base+5 to base+6. So we better request each port
-	 * individually for the probing phase. */
+	 * individually for the probing phase.
+	 */
 	for (port = address; port < address + W83781D_EXTENT; port++) {
 		if (!request_region(port, 1, "w83781d")) {
 			pr_debug("Failed to request port 0x%x\n", port);
@@ -1844,8 +1875,10 @@ w83781d_isa_found(unsigned short address)
 	}
 
 #define REALLY_SLOW_IO
-	/* We need the timeouts for at least some W83781D-like
-	   chips. But only if we read 'undefined' registers. */
+	/*
+	 * We need the timeouts for at least some W83781D-like
+	 * chips. But only if we read 'undefined' registers.
+	 */
 	val = inb_p(address + 1);
 	if (inb_p(address + 2) != val
 	 || inb_p(address + 3) != val
@@ -1855,8 +1888,10 @@ w83781d_isa_found(unsigned short address)
 	}
 #undef REALLY_SLOW_IO
 
-	/* We should be able to change the 7 LSB of the address port. The
-	   MSB (busy flag) should be clear initially, set after the write. */
+	/*
+	 * We should be able to change the 7 LSB of the address port. The
+	 * MSB (busy flag) should be clear initially, set after the write.
+	 */
 	save = inb_p(address + W83781D_ADDR_REG_OFFSET);
 	if (save & 0x80) {
 		pr_debug("Detection failed at step %d\n", 2);
@@ -2042,8 +2077,10 @@ sensors_w83781d_init(void)
 {
 	int res;
 
-	/* We register the ISA device first, so that we can skip the
-	 * registration of an I2C interface to the same device. */
+	/*
+	 * We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device.
+	 */
 	res = w83781d_isa_register();
 	if (res)
 		goto exit;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
