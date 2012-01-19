From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:30 +0000
Subject: [lm-sensors] [PATCH 36/82] hwmon: (lm78) Fix multi-line comments
Message-Id: <1327017376-20466-37-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm78.c |  120 +++++++++++++++++++++++++++++--------------------
 1 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 84f99e2..6a69d1e 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -1,23 +1,23 @@
 /*
-    lm78.c - Part of lm_sensors, Linux kernel modules for hardware
-	monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
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
+ * lm78.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	    monitoring
+ * Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+ * Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
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
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -79,8 +79,10 @@ enum chips { lm78, lm79 };
  * variants.
  */
 
-/* IN: mV, (0V to 4.08V)
-   REG: 16mV/bit */
+/*
+ * IN: mV, (0V to 4.08V)
+ * REG: 16mV/bit
+ */
 static inline u8 IN_TO_REG(unsigned long val)
 {
 	unsigned long nval = SENSORS_LIMIT(val, 0, 4080);
@@ -100,8 +102,10 @@ static inline int FAN_FROM_REG(u8 val, int div)
 	return val = 0 ? -1 : val = 255 ? 0 : 1350000 / (val * div);
 }
 
-/* TEMP: mC (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: mC (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static inline s8 TEMP_TO_REG(int val)
 {
 	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
@@ -343,10 +347,12 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
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
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 			   const char *buf, size_t count)
 {
@@ -524,8 +530,10 @@ static struct platform_device *pdev;
 
 static unsigned short isa_address = 0x290;
 
-/* I2C devices get this name attribute automatically, but for ISA devices
-   we must create it by ourselves. */
+/*
+ * I2C devices get this name attribute automatically, but for ISA devices
+ * we must create it by ourselves.
+ */
 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
 {
@@ -555,8 +563,10 @@ static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
 	if ((lm78_read_value(isa, LM78_REG_CHIPID) & 0xfe) != (chipid & 0xfe))
 		return 0;	/* Chip type doesn't match */
 
-	/* We compare all the limit registers, the config register and the
-	 * interrupt mask registers */
+	/*
+	 * We compare all the limit registers, the config register and the
+	 * interrupt mask registers
+	 */
 	for (i = 0x2b; i <= 0x3d; i++) {
 		if (lm78_read_value(isa, i) ! 		    i2c_smbus_read_byte_data(client, i))
@@ -598,9 +608,11 @@ static int lm78_i2c_detect(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/* We block updates of the ISA device to minimize the risk of
-	   concurrent access to the same LM78 chip through different
-	   interfaces. */
+	/*
+	 * We block updates of the ISA device to minimize the risk of
+	 * concurrent access to the same LM78 chip through different
+	 * interfaces.
+	 */
 	if (isa)
 		mutex_lock(&isa->update_lock);
 
@@ -733,13 +745,15 @@ static int lm78_read_value(struct lm78_data *data, u8 reg)
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitly!
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
-   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary.
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
+/*
+ * The SMBus locks itself, but ISA access muse be locked explicitly!
+ * We don't want to lock the whole ISA bus, so we lock each client
+ * separately.
+ * We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the LM78 access and should not be necessary.
+ * There are some ugly typecasts here, but the good new is - they should
+ * nowhere else be necessary!
+ */
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
 {
 	struct i2c_client *client = data->client;
@@ -921,9 +935,11 @@ static int __init lm78_isa_found(unsigned short address)
 	int val, save, found = 0;
 	int port;
 
-	/* Some boards declare base+0 to base+7 as a PNP device, some base+4
+	/*
+	 * Some boards declare base+0 to base+7 as a PNP device, some base+4
 	 * to base+7 and some base+5 to base+6. So we better request each port
-	 * individually for the probing phase. */
+	 * individually for the probing phase.
+	 */
 	for (port = address; port < address + LM78_EXTENT; port++) {
 		if (!request_region(port, 1, "lm78")) {
 			pr_debug("Failed to request port 0x%x\n", port);
@@ -932,8 +948,10 @@ static int __init lm78_isa_found(unsigned short address)
 	}
 
 #define REALLY_SLOW_IO
-	/* We need the timeouts for at least some LM78-like
-	   chips. But only if we read 'undefined' registers. */
+	/*
+	 * We need the timeouts for at least some LM78-like
+	 * chips. But only if we read 'undefined' registers.
+	 */
 	val = inb_p(address + 1);
 	if (inb_p(address + 2) != val
 	 || inb_p(address + 3) != val
@@ -941,8 +959,10 @@ static int __init lm78_isa_found(unsigned short address)
 		goto release;
 #undef REALLY_SLOW_IO
 
-	/* We should be able to change the 7 LSB of the address port. The
-	   MSB (busy flag) should be clear initially, set after the write. */
+	/*
+	 * We should be able to change the 7 LSB of the address port. The
+	 * MSB (busy flag) should be clear initially, set after the write.
+	 */
 	save = inb_p(address + LM78_ADDR_REG_OFFSET);
 	if (save & 0x80)
 		goto release;
@@ -1081,8 +1101,10 @@ static int __init sm_lm78_init(void)
 {
 	int res;
 
-	/* We register the ISA device first, so that we can skip the
-	 * registration of an I2C interface to the same device. */
+	/*
+	 * We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device.
+	 */
 	res = lm78_isa_register();
 	if (res)
 		goto exit;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
