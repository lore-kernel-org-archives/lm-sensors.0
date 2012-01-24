From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 22:45:12 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (lm78) Fix checkpatch issues
Message-Id: <1327445112-23654-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: trailing statements should be on next line
ERROR: trailing whitespace
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Merged checkpatch and multi-line patches into one
v3: Comment cleanup per review feedback

 drivers/hwmon/lm78.c |  206 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 132 insertions(+), 74 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 6df0b46..f6bc414 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -1,23 +1,23 @@
 /*
-    lm78.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
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
 
@@ -74,11 +74,15 @@ enum chips { lm78, lm79 };
 #define LM78_REG_I2C_ADDR 0x48
 
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG 
-   variants. */
+/*
+ * Conversions. Rounding and limit checking is only done on the TO_REG
+ * variants.
+ */
 
-/* IN: mV, (0V to 4.08V)
-   REG: 16mV/bit */
+/*
+ * IN: mV (0V to 4.08V)
+ * REG: 16mV/bit
+ */
 static inline u8 IN_TO_REG(unsigned long val)
 {
 	unsigned long nval = SENSORS_LIMIT(val, 0, 4080);
@@ -95,15 +99,17 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 static inline int FAN_FROM_REG(u8 val, int div)
 {
-	return val=0 ? -1 : val=255 ? 0 : 1350000/(val*div);
+	return val = 0 ? -1 : val = 255 ? 0 : 1350000 / (val * div);
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
-	return nval<0 ? (nval-500)/1000 : (nval+500)/1000;
+	return nval < 0 ? (nval - 500) / 1000 : (nval + 500) / 1000;
 }
 
 static inline int TEMP_FROM_REG(s8 val)
@@ -177,8 +183,13 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = attr->index;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -192,8 +203,13 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int nr = attr->index;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -201,7 +217,7 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-	
+
 #define show_in_offset(offset)					\
 static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
 		show_in, NULL, offset);				\
@@ -237,7 +253,12 @@ static ssize_t set_temp_over(struct device *dev, struct device_attribute *da,
 			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
@@ -257,7 +278,12 @@ static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *da,
 			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
@@ -280,7 +306,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *da,
 	struct lm78_data *data = lm78_update_device(dev);
 	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
@@ -289,8 +315,8 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
 	int nr = attr->index;
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
@@ -299,7 +325,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -316,29 +347,44 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
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
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	unsigned long min;
 	u8 reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1:
+		data->fan_div[nr] = 0;
+		break;
+	case 2:
+		data->fan_div[nr] = 1;
+		break;
+	case 4:
+		data->fan_div[nr] = 2;
+		break;
+	case 8:
+		data->fan_div[nr] = 3;
+		break;
 	default:
 		dev_err(dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
@@ -484,8 +530,10 @@ static struct platform_device *pdev;
 
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
@@ -515,8 +563,10 @@ static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
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
@@ -558,9 +608,11 @@ static int lm78_i2c_detect(struct i2c_client *client,
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
 
@@ -669,11 +721,13 @@ static struct i2c_driver lm78_driver = {
 	.address_list	= normal_i2c,
 };
 
-/* The SMBus locks itself, but ISA access must be locked explicitly! 
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
-   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary.  */
+/*
+ * The SMBus locks itself, but ISA access must be locked explicitly!
+ * We don't want to lock the whole ISA bus, so we lock each client
+ * separately.
+ * We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
+ * would slow down the LM78 access and should not be necessary.
+ */
 static int lm78_read_value(struct lm78_data *data, u8 reg)
 {
 	struct i2c_client *client = data->client;
@@ -691,13 +745,6 @@ static int lm78_read_value(struct lm78_data *data, u8 reg)
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitly! 
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
-   We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the LM78 access and should not be necessary. 
-   There are some ugly typecasts here, but the good new is - they should
-   nowhere else be necessary! */
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
 {
 	struct i2c_client *client = data->client;
@@ -823,8 +870,11 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
 	lm78_init_device(data);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
-	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
+	err = sysfs_create_group(&pdev->dev.kobj, &lm78_group);
+	if (err)
+		goto exit_remove_files;
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
 		goto exit_remove_files;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
@@ -876,9 +926,11 @@ static int __init lm78_isa_found(unsigned short address)
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
@@ -887,8 +939,10 @@ static int __init lm78_isa_found(unsigned short address)
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
@@ -896,8 +950,10 @@ static int __init lm78_isa_found(unsigned short address)
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
@@ -1036,8 +1092,10 @@ static int __init sm_lm78_init(void)
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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
