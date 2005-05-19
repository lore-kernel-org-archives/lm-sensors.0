From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <422318E5.4000201@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch adds 2.6 kernel support to the lm92 driver from
sensors-2.9.0. Tested with linux-2.6.11-rc5 on ppc32.

- change i2c API for 2.6
- fix endian bugs - use cpu_to_le16(), not swab16()
- if max6635 is detected, show a different device name in sysfs

/james



-------------- next part --------------
diff -Naur orig/lm92.c new/lm92.c
--- orig/lm92.c	2005-02-27 13:07:23.000000000 +0000
+++ new/lm92.c	2005-02-27 13:10:50.000000000 +0000
@@ -1,10 +1,12 @@
-
 /*
  * LM92 - Part of lm_sensors, Linux kernel modules for hardware
  *        monitoring
  *
  * Author: Abraham van der Merwe <abraham@2d3d.co.za>
  *
+ * - James Chapman <jchapman@katalix.com>
+ *	Modify for 2.6 kernels
+ *
  * Linux support for the National Semiconductor LM92 Temperature
  * Sensor.
  *
@@ -19,16 +21,28 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+#include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
 #include <linux/proc_fs.h>
 #include <linux/sysctl.h>
 #include <asm/semaphore.h>
-#include "version.h"
+
+/*
+ * Addresses to scan
+ */
+
+static unsigned short normal_i2c[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* if defined, 4 faults must occur consecutively to set alarm flags */
 /* #define ENABLE_FAULT_QUEUE */
@@ -55,9 +69,6 @@
 #define NATIVE_TO_PROC(x) ((x) * 625)
 #define CELSIUS(x) ((x) * 16)
 
-static void lm92_temp (struct i2c_client *client,int operation,int ctl_name,int *nrels_mag,long *results);
-static void lm92_alarms (struct i2c_client *client,int operation,int ctl_name,int *nrels_mag,long *results);
-
 /* -- SENSORS SYSCTL START -- */
 #define LM92_SYSCTL_ALARMS		2001	/* high, low, critical */
 #define LM92_SYSCTL_TEMP		1200	/* high, low, critical, hysteresis, input */
@@ -71,16 +82,6 @@
 #define LM92_TEMP_HYST			0x40
 #define LM92_TEMP_INPUT			0x80
 
-/* -- SENSORS SYSCTL END -- */
-
-static ctl_table lm92_dir_table[] = {
-	{LM92_SYSCTL_TEMP, "temp", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &lm92_temp, NULL},
-	{LM92_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &lm92_alarms, NULL},
-	{0}
-};
-
 /* NOTE: all temperatures are degrees centigrade * 16 */
 typedef struct {
 	struct i2c_client client;
@@ -103,17 +104,8 @@
 /* this is needed for each client driver method */
 static struct i2c_driver lm92_driver;
 
-/* ensure exclusive access to chip and static variables */
-static DECLARE_MUTEX (mutex);
-
-/* addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
-
 /* insmod parameters */
-SENSORS_INSMOD_1 (lm92);
+SENSORS_INSMOD_2 (lm92, max6635);
 
 static inline int lm92_write8 (struct i2c_client *client,u8 reg,u8 value)
 {
@@ -126,16 +118,16 @@
 
 	if (tmp < 0) return (-EIO);
 
-	/* convert the data to little endian format */
-	*value = swab16((u16) tmp);
+	/* register values are little endian format */
+	*value = le16_to_cpu((u16) tmp);
 
 	return (0);
 }
 
 static inline int lm92_write16 (struct i2c_client *client,u8 reg,u16 value)
 {
-	/* convert the data to big endian format */
-	if (i2c_smbus_write_word_data(client, reg, swab16(value)) < 0)
+	/* register values are little endian format */
+	if (i2c_smbus_write_word_data(client, reg, cpu_to_le16(value)) < 0)
 		return -EIO;
 
 	return 0;
@@ -143,7 +135,7 @@
 
 static int lm92_read (struct i2c_client *client)
 {
-	lm92_t *data = (lm92_t *) client->data;
+	lm92_t *data = (lm92_t *) i2c_get_clientdata(client);
 	u16 value[5];
 
 	if ((jiffies - data->timestamp) > HZ) {
@@ -172,7 +164,7 @@
 
 static int lm92_write (struct i2c_client *client)
 {
-	lm92_t *data = (lm92_t *) client->data;
+	lm92_t *data = (lm92_t *) i2c_get_clientdata(client);
 
 	LIMIT (data->temp.hyst);
 	LIMIT (data->temp.crit);
@@ -188,49 +180,58 @@
 	return (0);
 }
 
-static void lm92_temp (struct i2c_client *client,int operation,int ctl_name,int *nrels_mag,long *results)
-{
-	if (!down_interruptible (&mutex)) {
-		lm92_t *data = (lm92_t *) client->data;
-
-		if (operation = SENSORS_PROC_REAL_READ) {
-			lm92_read (client);
-			results[0] = NATIVE_TO_PROC (data->temp.input);
-			results[1] = NATIVE_TO_PROC (data->temp.high);
-			results[2] = NATIVE_TO_PROC (data->temp.low);
-			results[3] = NATIVE_TO_PROC (data->temp.crit);
-			results[4] = NATIVE_TO_PROC (data->temp.hyst);
-			*nrels_mag = 5;
-		} else if (operation = SENSORS_PROC_REAL_WRITE && *nrels_mag = 4) {
-			data->temp.high = PROC_TO_NATIVE (results[0]);
-			data->temp.low = PROC_TO_NATIVE (results[1]);
-			data->temp.crit = PROC_TO_NATIVE (results[2]);
-			data->temp.hyst = PROC_TO_NATIVE (results[3]);
-			lm92_write (client);
-		} else if (operation = SENSORS_PROC_REAL_INFO) {
-			*nrels_mag = 4;
-		}
-
-		up (&mutex);
-	}
-}
-
-static void lm92_alarms (struct i2c_client *client,int operation,int ctl_name,int *nrels_mag,long *results)
-{
-	if (!down_interruptible (&mutex)) {
-		lm92_t *data = (lm92_t *) client->data;
-
-		if (operation = SENSORS_PROC_REAL_READ) {
-			lm92_read (client);
-			results[0] = data->alarms.high || (data->alarms.low << 1) || (data->alarms.crit << 2);
-			*nrels_mag = 1;
-		} else if (operation = SENSORS_PROC_REAL_INFO) {
-			*nrels_mag = 0;
-		}
+/*
+ * Sysfs stuff
+ */
 
-		up (&mutex);
-	}
-}
+#define show_temp(value, converter) \
+static ssize_t show_temp_##value(struct device *dev, char *buf) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	lm92_t *data = i2c_get_clientdata(client); \
+	lm92_read(client); \
+	return sprintf(buf, "%ld\n", converter(data->temp.value)); \
+}
+show_temp(input, NATIVE_TO_PROC);
+show_temp(low, NATIVE_TO_PROC);
+show_temp(high, NATIVE_TO_PROC);
+show_temp(crit, NATIVE_TO_PROC);
+show_temp(hyst, NATIVE_TO_PROC);
+
+#define set_temp(value, reg) \
+static ssize_t set_temp_##value(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	lm92_t *data = i2c_get_clientdata(client); \
+	data->temp.value = PROC_TO_NATIVE(simple_strtol(buf, NULL, 10)); \
+	lm92_write8(client, reg, data->temp.value); \
+	return count; \
+}
+set_temp(low, LM92_REG_TRIP_LOW);
+set_temp(high, LM92_REG_TRIP_HIGH);
+set_temp(crit, LM92_REG_TRIP_CRITICAL);
+set_temp(hyst, LM92_REG_TRIP_HYSTERESIS);
+
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	lm92_t *data = i2c_get_clientdata(client);
+	lm92_read(client);
+	return sprintf(buf, "%ld\n", (data->alarms.crit << 2) |
+		       (data->alarms.high << 1) | (data->alarms.low << 0));
+}
+
+static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_low,
+	set_temp_low);
+static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_high,
+	set_temp_high);
+static DEVICE_ATTR(temp_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+	set_temp_crit);
+static DEVICE_ATTR(temp_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
+	set_temp_hyst);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static int max6635_check(struct i2c_client *client)
 {
@@ -263,7 +264,7 @@
 
 static int lm92_init_client (struct i2c_client *client)
 {
-	lm92_t *data = (lm92_t *) client->data;
+	lm92_t *data = (lm92_t *) i2c_get_clientdata(client);
 	u8 value = 0;
 	int result;
 
@@ -297,13 +298,13 @@
 	return (0);
 }
 
-static int lm92_detect (struct i2c_adapter *adapter,int address,unsigned short flags,int kind)
+static int lm92_detect (struct i2c_adapter *adapter,int address,int kind)
 {
 	static int id = 0;
 	struct i2c_client *client;
 	lm92_t *data;
-	int result;
-	u16 manufacturer;
+	int result = -ENODEV;
+	const char *name = "";
 
 	if (!i2c_check_functionality (adapter,I2C_FUNC_SMBUS_BYTE_DATA))
 		return (-ENODEV);
@@ -311,58 +312,68 @@
 	if (!(data = kmalloc(sizeof(lm92_t), GFP_KERNEL)))
 		return (-ENOMEM);
 
+	memset(data, 0, sizeof(lm92_t));
+
 	client = &data->client;
+	client->id = id++;
 	client->addr = address;
-	client->data = data;
+	i2c_set_clientdata(client, data);
 	client->adapter = adapter;
 	client->driver = &lm92_driver;
 	client->flags = 0;
-	strcpy (client->name,lm92_driver.name);
 
-	if (down_interruptible (&mutex)) {
-		result = -ERESTARTSYS;
-		goto ERROR1;
-	}
+	/* Default to an LM92 if forced */
+	if (kind = 0)
+		kind = lm92;
 
 	if (kind < 0) {
-		/* Is it an lm92? */
-		if (address < 0x4c
-		 && (lm92_read16(client,LM92_REG_MANUFACTURER,&manufacturer) < 0
-		  || manufacturer != LM92_MANUFACTURER_ID)) {
+		u16 man_id = 0xffff;
+
+		if (lm92_read16(client, LM92_REG_MANUFACTURER, &man_id) < 0) {
 		  	/* Is it a MAX6635/MAX6635/MAX6635? */
-			if (!max6635_check(client)) {
-				result = -ENODEV;
-				goto ERROR2;
-			}
+			if (!max6635_check(client))
+				kind = max6635;
+		}
+		
+		/* National Semiconductor LM92? */
+		if (man_id = LM92_MANUFACTURER_ID) 
+			kind = lm92;
+
+		if (kind <= 0) { /* identification failed */
+			dev_info(&adapter->dev,
+				 "Unsupported chip (man_id=0x%04X)\n",
+				 man_id);
+			goto ERROR1;
 		}
 	}
 
-	if ((result = i2c_attach_client (client))) {
-		goto ERROR2;
-	}
+	if (kind = lm92)
+		name = "lm92";
+	else if (kind = max6635)
+		name = "max6635";
 
-	if ((result = i2c_register_entry(client, client->name, lm92_dir_table,
-					 THIS_MODULE)) < 0) {
-		goto ERROR3;
+	strlcpy(client->name, name, I2C_NAME_SIZE);
+
+	if ((result = i2c_attach_client (client))) {
+		goto ERROR1;
 	}
-	data->sysctl_id = result;
 
 	if ((result = lm92_init_client (client)) < 0) {
-		goto ERROR4;
+		goto ERROR2;
 	}
 
-	client->id = id++;
-
-	up (&mutex);
+	/* Register sysfs hooks */
+	device_create_file(&client->dev, &dev_attr_temp_input);
+	device_create_file(&client->dev, &dev_attr_temp_min);
+	device_create_file(&client->dev, &dev_attr_temp_max);
+	device_create_file(&client->dev, &dev_attr_temp_hyst);
+	device_create_file(&client->dev, &dev_attr_temp_crit);
+	device_create_file(&client->dev, &dev_attr_alarms);
 
 	return (0);
 
-ERROR4:
-	i2c_deregister_entry(data->sysctl_id);
-ERROR3:
-	i2c_detach_client(client);
 ERROR2:
-	up(&mutex);
+	i2c_detach_client(client);
 ERROR1:
 	kfree(data);
 	return result;
@@ -370,25 +381,27 @@
 
 static int lm92_attach_adapter (struct i2c_adapter *adapter)
 {
-	return i2c_detect (adapter,&addr_data,lm92_detect);
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+
+	return i2c_detect(adapter, &addr_data, lm92_detect);
 }
 
 static int lm92_detach_client (struct i2c_client *client)
 {
 	int result;
 
-	i2c_deregister_entry (((lm92_t *) (client->data))->sysctl_id);
-
 	if ((result = i2c_detach_client (client)))
 		return (result);
 
-	kfree(client->data);
+	kfree(i2c_get_clientdata(client));
 
 	return (0);
 }
 
 
 static struct i2c_driver lm92_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "lm92",
 	.id		= I2C_DRIVERID_LM92,
 	.flags		= I2C_DF_NOTIFY,
@@ -398,7 +411,6 @@
 
 static int __init sm_lm92_init(void)
 {
-	printk ("lm92.o version %s (%s)\n",LM_VERSION,LM_DATE);
 	return i2c_add_driver(&lm92_driver);
 }
 
