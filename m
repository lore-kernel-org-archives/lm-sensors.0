From: claus.gindhart@kontron-modular.com (Claus Gindhart)
Date: Mon, 20 Feb 2006 09:08:24 +0000
Subject: [lm-sensors] Fwd: Linux 2.6 Driver for MAX6650/66551
Message-Id: <200602201008.24613.claus.gindhart@kontron-modular.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602081718.04898.claus.gindhart@kontron-modular.com>
In-Reply-To: <200602081718.04898.claus.gindhart@kontron-modular.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

thank you for the feedback.

About testing:
I implemented this driver for a customer of us; he will also test it, and 
provide feedback. They have a consultant, who is very active in the open 
source community (T.Gleixner), and i assume, that he will check this driver 
also for the CodingStyle conventions.
Additionally i have given away a copy of my patch to a student of TU Chemnitz 
in the hope, that he will test this driver also.
So, in some weeks i will hopefully have at least 2 feedbacks.

I have read the SubmittingPatches and CodingStyle docs, and tried to follow 
these rules.

However, i have 2 questions: 
1) SubmittingPatches tells me to provide the patch in "diff -uprN" (this is 
what i did), but you tell me, that you need "diff -Naur". What is correct  ?

2) What do you mean with Signed-off by line ?

Regards,
Claus






Am Saturday 18 February 2006 21:37 schrieb Rudolf Marek:
Hello,

Sorry for delay, I think I have some of those chips in a drawer
so I can try interface them a and give a try if you want. I must solder
those tiny chips somehow to wires which I admit would be not so easy task,
but anyway I can give a try if you dont have any testers so far.

If you want to submit the driver to a kernel, this is a correct mailing list
 for that. (Please read the SubmittingPatches and CodingStyle first)

We need:

1) Signed-off-by line
2) patch inline or in TEXT attachment
3) form of diff -Naur

I think you got the idea :)

Regards
Rudolf
-------------- next part --------------
diff -uprN -X linux-2.6.15.1-vanilla/Documentation/dontdiff linux-2.6.15.1-vanilla/Documentation/hwmon/max6650 linux-2.6.15.1/Documentation/hwmon/max6650
--- linux-2.6.15.1-vanilla/Documentation/hwmon/max6650	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15.1/Documentation/hwmon/max6650	2006-02-08 11:47:53.000000000 +0100
@@ -0,0 +1,32 @@
+Kernel driver max6650
+==========+
+Supported chips:
+  * Maxim 6650 / 6651
+    Prefix: 'w83792d'
+    Addresses scanned: I2C 0x1b, 0x1f, 0x48, 0x4b
+    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+
+Authors: 
+    John Morris <john.morris at spirentcom.com>
+    Claus Gindhart <claus.gindhart at kontron.com>
+
+Description
+-----------
+
+This driver implements support for the Maxim 6650/6651
+
+The 2 devices are very similar, bit the Maxim 6550 has a reduced feature
+set, e.g. only one fan-input, instead of 4 for the 6651.
+
+The driver is not able to distinguish between the 2 devices.
+
+The driver provides the following sensor accesses
+
+fan0   ro     fan tachometer speed in RPM
+fan1   ro     "
+fan2   ro     "
+fan3   ro     "
+config ro     contents of the config register (for debugging)
+count  ro     tachometer count time in milliseconds
+speed  rw     fan speed adjustment value
diff -uprN -X linux-2.6.15.1-vanilla/Documentation/dontdiff linux-2.6.15.1-vanilla/drivers/hwmon/Kconfig linux-2.6.15.1/drivers/hwmon/Kconfig
--- linux-2.6.15.1-vanilla/drivers/hwmon/Kconfig	2006-02-06 15:40:17.000000000 +0100
+++ linux-2.6.15.1/drivers/hwmon/Kconfig	2006-02-08 11:26:06.000000000 +0100
@@ -290,6 +290,16 @@ config SENSORS_MAX1619
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
+config SENSORS_MAX6650
+	tristate "Maxim MAX6650 sensor chip"
+	depends on HWMON && I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the MAX6650 / MAX6651
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6650.
+
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	depends on HWMON && I2C && EXPERIMENTAL
diff -uprN -X linux-2.6.15.1-vanilla/Documentation/dontdiff linux-2.6.15.1-vanilla/drivers/hwmon/Makefile linux-2.6.15.1/drivers/hwmon/Makefile
--- linux-2.6.15.1-vanilla/drivers/hwmon/Makefile	2006-02-06 15:40:16.000000000 +0100
+++ linux-2.6.15.1/drivers/hwmon/Makefile	2006-02-08 11:27:03.000000000 +0100
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
diff -uprN -X linux-2.6.15.1-vanilla/Documentation/dontdiff linux-2.6.15.1-vanilla/drivers/hwmon/max6650.c linux-2.6.15.1/drivers/hwmon/max6650.c
--- linux-2.6.15.1-vanilla/drivers/hwmon/max6650.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15.1/drivers/hwmon/max6650.c	2006-02-08 14:27:07.000000000 +0100
@@ -0,0 +1,572 @@
+/*
+ * max6650.c - Part of lm_sensors, Linux kernel modules for hardware
+ *             monitoring. 
+ * 
+ * Author: John Morris <john.morris at spirentcom.com>
+ * Copyright (c) 2003 Spirent Communications
+ *
+ * This module has only been tested with the MAX6650 chip. It should
+ * work with the MAX6650 also, though with reduced functionality. It
+ * does not distinguish max6650 and max6651 chips.
+ * 
+ * Tha datasheet was last seen at: 
+ *
+ *        http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+ *
+ * Ported to Linux 2.6 by Claus Gindhart <claus.gindhart at kontron.com>
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
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+
+#ifndef I2C_DRIVERID_MAX6650
+#define I2C_DRIVERID_MAX6650	1044
+#endif
+
+/* HW-related: Set this to 1 for 12V and 0 for 5V configuration */
+static const int voltage_12V=0;
+
+/* #define DEBUG */
+
+/*
+ * Addresses to scan. There are four disjoint possibilities, by pin config.
+ */
+
+static unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b, I2C_CLIENT_END};
+
+/*
+ * Insmod parameters
+ */
+
+I2C_CLIENT_INSMOD_1(max6650);
+
+/* 
+ * MAX 6650/6651 registers
+ */
+
+#define MAX6650_REG_SPEED       0x00
+#define MAX6650_REG_CONFIG      0x02
+#define MAX6650_REG_GPIO_DEF    0x04
+#define MAX6650_REG_DAC         0x06
+#define MAX6650_REG_ALARM_EN    0x08
+#define MAX6650_REG_ALARM       0x0A
+#define MAX6650_REG_TACH0       0x0C
+#define MAX6650_REG_TACH1       0x0E
+#define MAX6650_REG_TACH2       0x10
+#define MAX6650_REG_TACH3       0x12
+#define MAX6650_REG_GPIO_STAT   0x14
+#define MAX6650_REG_COUNT       0x16
+
+
+/*
+ * Config register bits
+ */
+ 
+#define MAX6650_CFG_V12           		0x08
+#define MAX6650_CFG_MODE_MASK           0x30
+#define MAX6650_CFG_MODE_ON             0x00
+#define MAX6650_CFG_MODE_OFF            0x10
+#define MAX6650_CFG_MODE_CLOSED_LOOP    0x20
+#define MAX6650_CFG_MODE_OPEN_LOOP      0x30
+
+#define MAX6650_INT_CLK 254000  /* Default clock speed - 254 kHz */
+
+/* Minimum and maximum values of the FAN-RPM */
+#define FAN_RPM_MIN 240
+#define FAN_RPM_MAX 30000
+
+
+#define DIV_FROM_REG(reg)               (1 << (reg & 7))
+
+
+static int max6650_attach_adapter(struct i2c_adapter *adapter);
+static int max6650_detect(struct i2c_adapter *adapter, int address, int kind);
+static void max6650_init_client(struct i2c_client *client);
+static int max6650_detach_client(struct i2c_client *client);
+static struct max6650_data *max6650_update_device(struct device *dev);
+static int max6650_read_value(struct i2c_client *client, u8 reg);
+static int max6650_write_value(struct i2c_client *client, u8 reg, u8 value);
+
+/*
+ * Driver data (common to all clients)
+ */
+
+
+static struct i2c_driver max6650_driver = {
+	.owner          = THIS_MODULE,
+	.name           = "max6650",
+	.id             = I2C_DRIVERID_MAX6650,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = max6650_attach_adapter,
+	.detach_client  = max6650_detach_client
+};
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct max6650_data
+{
+	struct i2c_client client;
+	struct class_device *class_dev;
+    struct semaphore update_lock;
+    char valid; /* zero until following fields are valid */
+    unsigned long last_updated; /* in jiffies */
+
+    /* register values */
+    u8 speed;
+    u8 config;
+    u8 tach[4];
+    u8 count;
+};
+
+static ssize_t get_fan(struct device *dev, struct device_attribute *devattr, char *buf, int nr)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+	
+
+	/*
+	* Calculation details:
+	*
+	* Each tachometer counts over an interval given by the "count"
+	* register (0.25, 0.5, 1 or 2 seconds). This module assumes
+	* that the fans produce two pulses per revolution (this seems
+	* to be the most common).
+	*/
+
+	int rpm = ((data->tach[nr] * 120) / DIV_FROM_REG(data->count));
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t get_fan0(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	return get_fan(dev,devattr,buf,0);
+}
+static ssize_t get_fan1(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	return get_fan(dev,devattr,buf,1);
+}
+static ssize_t get_fan2(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	return get_fan(dev,devattr,buf,2);
+}
+static ssize_t get_fan3(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	return get_fan(dev,devattr,buf,3);
+}
+
+/* Show values of the config register for debugging purposes
+ */
+
+static ssize_t get_config(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+
+	return sprintf(buf, "mode: %s%s%s%s, voltage:%s prescale: %d\n",
+		((data->config & MAX6650_CFG_MODE_MASK) = MAX6650_CFG_MODE_ON) ? "On" : "",
+		((data->config & MAX6650_CFG_MODE_MASK) = MAX6650_CFG_MODE_OFF) ? "Off" : "",
+		((data->config & MAX6650_CFG_MODE_MASK) = MAX6650_CFG_MODE_CLOSED_LOOP) ? "closed loop" : "",
+		((data->config & MAX6650_CFG_MODE_MASK) = MAX6650_CFG_MODE_OPEN_LOOP) ? "open Loop" : "",
+		(data->config & MAX6650_CFG_V12) ? "12V" : "5V",
+		DIV_FROM_REG(data->config)
+		);
+}
+
+/* Returns count time in ms */
+static ssize_t get_count(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->count) * 250 );
+}
+
+/*
+ * Set the fan speed to the specified RPM (or read back the RPM setting).
+ *
+ * The MAX6650/1 will automatically control fan speed when in closed loop
+ * mode.
+ *
+ * Assumptions:
+ *
+ * 1) The MAX6650/1 is running from its internal 254kHz clock (perhaps
+ *    this should be made a module parameter).
+ *
+ * 2) The prescaler (low three bits of the config register) has already
+ *    been set to an appropriate value.
+ *
+ * The relevant equations are given on pages 21 and 22 of the datasheet.
+ *
+ * From the datasheet, the relevant equation when in regulation is:
+ *
+ *    [fCLK / (128 x (KTACH + 1))] = 2 x FanSpeed / KSCALE
+ *
+ * where:
+ *
+ *    fCLK is the oscillator frequency (either the 254kHz internal 
+ *         oscillator or the externally applied clock)
+ *
+ *    KTACH is the value in the speed register
+ *
+ *    FanSpeed is the speed of the fan in rps
+ *
+ *    KSCALE is the prescaler value (1, 2, 4, 8, or 16)
+ *
+ * When reading, we need to solve for FanSpeed. When writing, we need to
+ * solve for KTACH.
+ *
+ * Note: this tachometer is completely separate from the tachometers
+ * used to measure the fan speeds. Only one fan's speed (fan1) is
+ * controlled.
+ */
+
+static ssize_t get_speed(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct max6650_data *data = max6650_update_device(dev);
+    int kscale, ktach, fclk, rpm;
+
+	/*
+	* Use the datasheet equation:
+	*
+	*    FanSpeed = KSCALE x fCLK / [256 x (KTACH + 1)]
+	*
+	* then multiply by 60 to give rpm.
+	*/
+
+	kscale = DIV_FROM_REG(data->config);
+	ktach  = data->speed;
+	fclk   = MAX6650_INT_CLK;
+	rpm    = 60 * kscale * fclk / (256 * (ktach + 1));
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t set_speed(struct device *dev, struct device_attribute *devattr, const char *buf,
+                size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = i2c_get_clientdata(client);
+	int rpm = simple_strtoul(buf, NULL, 10);
+    int kscale, ktach, fclk;
+
+#ifdef DEBUG
+	printk("%s called, rpm=%d\n",__FUNCTION__,rpm);
+#endif
+
+	down(&data->update_lock);
+	if (rpm = 0)
+	{
+		/* Switch totally off */
+		data->speed  = 0;
+		data->config = (data->config & ~MAX6650_CFG_MODE_MASK) | 
+										MAX6650_CFG_MODE_OFF;
+	}
+	else
+	{
+		rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
+
+		/*
+		* Divide the required speed by 60 to get from rpm to rps, then
+		* use the datasheet equation:
+		*
+		*     KTACH = [(fCLK x KSCALE) / (256 x FanSpeed)] - 1
+		*/
+	
+		kscale = DIV_FROM_REG(data->config);
+		fclk   = MAX6650_INT_CLK;
+		ktach  = ((fclk * kscale) / (256 * rpm / 60)) - 1;
+	
+		data->speed  = ktach;
+		data->config = (data->config & ~MAX6650_CFG_MODE_MASK) | 
+											MAX6650_CFG_MODE_CLOSED_LOOP;
+	}
+	max6650_write_value (client, MAX6650_REG_CONFIG, data->config);
+	max6650_write_value (client, MAX6650_REG_SPEED,  data->speed);
+
+	up(&data->update_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(fan0, S_IRUGO, get_fan0, NULL);
+static DEVICE_ATTR(fan1, S_IRUGO, get_fan1, NULL);
+static DEVICE_ATTR(fan2, S_IRUGO, get_fan2, NULL);
+static DEVICE_ATTR(fan3, S_IRUGO, get_fan3, NULL);
+static DEVICE_ATTR(count, S_IRUGO, get_count, NULL);
+static DEVICE_ATTR(config, S_IRUGO, get_config, NULL);
+static DEVICE_ATTR(speed, S_IWUSR | S_IRUGO, get_speed, set_speed);
+
+
+/*
+ * Real code
+ */
+
+static int max6650_attach_adapter(struct i2c_adapter *adapter)
+{
+#ifdef DEBUG
+	printk("max6650_attach_adapter called\n");
+#endif
+	if (!(adapter->class & I2C_CLASS_HWMON))
+	{
+#ifdef DEBUG
+		printk("FATAL: max6650_attach_adapter class HWMON not set\n");
+#endif
+		return 0;
+	}
+	return i2c_probe(adapter, &addr_data, max6650_detect);
+}
+
+/*
+ * The following function does more than just detection. If detection
+ * succeeds, it also registers the new chip.
+ */
+
+static int max6650_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+    struct i2c_client *new_client;
+    struct max6650_data *data;
+    int err = 0;
+    const char *name = "";
+
+#ifdef DEBUG
+	printk("max6650_detect called, kind = %d\n",kind);
+#endif
+
+
+    if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+#ifdef DEBUG
+        printk("max6650.o: I2C bus doesn't support byte read mode, skipping.\n");
+#endif
+        return 0;
+    }
+
+    if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
+        printk("max6650.o: Out of memory in max6650_detect (new_client).\n");
+        return -ENOMEM;
+    }
+
+    /*
+     * The common I2C client data is placed right before the
+     * max6650-specific data. The max6650-specific data is pointed to by the
+	 * data field from the I2C client data.
+     */
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+    new_client->adapter = adapter;
+    new_client->driver = &max6650_driver;
+    new_client->flags = 0;
+
+    /*
+     * Now we do the remaining detection. A negative kind means that
+     * the driver was loaded with no force parameter (default), so we
+     * must both detect and identify the chip (actually there is only
+     * one possible kind of chip for now, max6650). A zero kind means that
+     * the driver was loaded with the force parameter, the detection
+     * step shall be skipped. A positive kind means that the driver
+     * was loaded with the force parameter and a given kind of chip is
+     * requested, so both the detection and the identification steps
+     * are skipped.
+     *
+     * Currently I can find no way to distinguish between a MAX6650 and 
+     * a MAX6651. This driver has only been tried on the latter.
+     */
+
+    if (kind < 0) {     /* detection */
+        if (
+            (max6650_read_value(new_client, MAX6650_REG_CONFIG) & 0xC0) ||
+            (max6650_read_value(new_client, MAX6650_REG_GPIO_STAT) & 0xE0) ||
+            (max6650_read_value(new_client, MAX6650_REG_ALARM_EN) & 0xE0) ||
+            (max6650_read_value(new_client, MAX6650_REG_ALARM) & 0xE0) ||
+            (max6650_read_value(new_client, MAX6650_REG_COUNT) & 0xFC) 
+        )
+        {
+#ifdef DEBUG
+            printk("max6650.o: max6650 detection failed at 0x%02x.\n",
+                                                                    address);
+#endif
+            goto ERROR1;
+        }
+    }
+
+	/* Configure HW-related voltage setting */
+	if (voltage_12V)
+	{
+		max6650_write_value 
+			(new_client, 
+			MAX6650_REG_CONFIG, 
+			max6650_read_value(new_client, MAX6650_REG_CONFIG) | MAX6650_CFG_V12);
+
+	}
+	else
+	{
+		max6650_write_value 
+			(new_client, 
+			MAX6650_REG_CONFIG, 
+			max6650_read_value(new_client, MAX6650_REG_CONFIG) & ~MAX6650_CFG_V12);
+
+	}
+
+
+    if (kind <= 0) { /* identification */
+        kind = max6650;
+    }
+
+    if (kind <= 0) {    /* identification failed */
+        printk("max6650.o: Unsupported chip.\n");
+        goto ERROR1;
+    }
+
+    if (kind = max6650) {
+        name = "max6650";
+    }
+	
+    /*
+     * OK, we got a valid chip so we can fill in the remaining client
+     * fields.
+     */
+
+    strlcpy(new_client->name, name, I2C_NAME_SIZE);
+    data->valid = 0;
+    init_MUTEX(&data->update_lock);
+
+    /*
+     * Tell the I2C layer a new client has arrived.
+     */
+
+    if ((err = i2c_attach_client(new_client))) {
+#ifdef DEBUG
+        printk("max6650.o: Failed attaching client.\n");
+#endif
+        goto ERROR1;
+    }
+
+
+    /*
+     * Initialize the max6650 chip
+     */
+    max6650_init_client(new_client);
+
+
+	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR2;
+	}
+
+
+	device_create_file(&new_client->dev, &dev_attr_fan0);
+	device_create_file(&new_client->dev, &dev_attr_fan1);
+	device_create_file(&new_client->dev, &dev_attr_fan2);
+	device_create_file(&new_client->dev, &dev_attr_fan3);
+	device_create_file(&new_client->dev, &dev_attr_speed);
+	device_create_file(&new_client->dev, &dev_attr_config);
+	device_create_file(&new_client->dev, &dev_attr_count);
+
+    return 0;
+
+ERROR2:
+    i2c_detach_client(new_client);
+ERROR1:
+    kfree(data);
+    return err;
+}
+
+static int max6650_detach_client(struct i2c_client *client)
+{
+	struct max6650_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
+
+	i2c_detach_client(client);
+    kfree(data);
+
+    return 0;
+}
+
+static void max6650_init_client(struct i2c_client *client)
+{
+	while(0)
+	{
+		;
+	}
+    /* Nothing to do here - assume the BIOS has initialized the chip */
+
+}
+
+
+static int max6650_read_value(struct i2c_client *client, u8 reg)
+{
+    return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int max6650_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+    return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static const u8 tach_reg[] = 
+{
+	MAX6650_REG_TACH0, MAX6650_REG_TACH1, 
+	MAX6650_REG_TACH2, MAX6650_REG_TACH3 
+};
+
+static struct max6650_data *max6650_update_device(struct device *dev)
+{
+	int i;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6650_data *data = i2c_get_clientdata(client);
+
+    down(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) 
+	{
+        data->speed  = max6650_read_value (client, MAX6650_REG_SPEED);
+        data->config = max6650_read_value (client, MAX6650_REG_CONFIG);
+        for (i = 0; i < 4; i++) {
+            data->tach[i] = max6650_read_value(client, tach_reg[i]);
+        }
+        data->count = max6650_read_value (client, MAX6650_REG_COUNT);
+        data->last_updated = jiffies;
+        data->valid = 1;
+    }
+    up(&data->update_lock);
+
+	return data;
+}
+
+static int __init sensors_max6650_init(void)
+{
+	return i2c_add_driver(&max6650_driver);
+}
+
+static void __exit sensors_max6650_exit(void)
+{
+	i2c_del_driver(&max6650_driver);
+}
+
+MODULE_AUTHOR("john.morris at spirentcom.com");
+MODULE_DESCRIPTION("max6650 sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_max6650_init);
+module_exit(sensors_max6650_exit);
