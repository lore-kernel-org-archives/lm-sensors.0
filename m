From: waltergoossens@home.nl (waltergoossens at home.nl)
Date: Wed, 22 Nov 2006 14:02:12 +0000
Subject: [lm-sensors] RFC patch to add eeprom write support
Message-Id: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi list,

I created a patch to add write support to the i2c eeprom driver. This driver was originally developed for eeproms on DIMM modules (ones to which you do NOT want to write) so apart from the menu option to enable compile time write support you'll also need to "unlock" that functionality at runtime to protect people from accidentally destroying their chips.
This driver is tested with the Philips pcf8594C-2 but should also work with the 24c* microchip chips.


 
Add write support to the i2c eeproms. I protected write support by an
additional "lock" to make sure people don't accidentally overwrite 
data in an i2c eeprom that should be left alone.

Signed off by Walter Goossens <waltergoossens at home.nl>

diff -uarN -x '*.o' -x '*.ko' linux-2.6.17/drivers/i2c/chips/Kconfig linux-2.6.17-mpe04/drivers/i2c/chips/Kconfig
--- linux-2.6.17/drivers/i2c/chips/Kconfig	2006-11-22 15:33:39.000000000 +0000
+++ linux-2.6.17-mpe04/drivers/i2c/chips/Kconfig	2006-11-21 15:47:50.000000000 +0000
@@ -26,7 +26,7 @@
 	  will be called ds1374.
 
 config SENSORS_EEPROM
-	tristate "EEPROM reader"
+	tristate "EEPROM Chips"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get read-only access to the EEPROM data
@@ -35,7 +35,18 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
-
+config SENSORS_EEPROM_WRITE
+  bool "EEPROM Write support (experimental)"
+  depends on I2C && SENSORS_EEPROM && EXPERIMENTAL
+  help
+    If you say yes here you get write access to the EEPROM data. Be 
+    VERY carefull when writing since this driver is designed to work
+    with chips on memory DIMMs which you will NOT want to destroy!
+    
+    Even when write support is enabled you will need to unlock it at
+    runtime to prevent errors. Write UNLOCK to the lock file in the 
+    sys/i2c/devices/<address>/ directory to gain write access. Any 
+    other value will lock write support.
 config SENSORS_PCF8574
 	tristate "Philips PCF8574 and PCF8574A"
 	depends on I2C && EXPERIMENTAL
diff -uarN -x '*.o' -x '*.ko' linux-2.6.17/drivers/i2c/chips/eeprom.c linux-2.6.17-mpe04/drivers/i2c/chips/eeprom.c
--- linux-2.6.17/drivers/i2c/chips/eeprom.c	2006-06-18 01:49:35.000000000 +0000
+++ linux-2.6.17-mpe04/drivers/i2c/chips/eeprom.c	2006-11-22 15:28:11.000000000 +0000
@@ -5,6 +5,10 @@
 			       Philip Edelbrock <phil at netroedge.com>
     Copyright (C) 2003 Greg Kroah-Hartman <greg at kroah.com>
     Copyright (C) 2003 IBM Corp.
+    Copyright (C) 2006 Walter Goossens <walter.goossens at axon.tv>
+    
+    2006-11-21 Walter Goossens <walter.goossens at axon.tv>
+    Added write support.
 
     2004-01-16  Jean Delvare <khali at linux-fr.org>
     Divide the eeprom in 32-byte (arbitrary) slices. This significantly
@@ -34,6 +38,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/delay.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
@@ -60,9 +65,11 @@
 	unsigned long last_updated[8];	/* In jiffies, 8 slices */
 	u8 data[EEPROM_SIZE];		/* Register values */
 	enum eeprom_nature nature;
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+	u8 write_lock;
+#endif
 };
 
-
 static int eeprom_attach_adapter(struct i2c_adapter *adapter);
 static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind);
 static int eeprom_detach_client(struct i2c_client *client);
@@ -140,14 +147,86 @@
 	return count;
 }
 
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+
+static ssize_t eeprom_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	int i = 0;
+	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct eeprom_data *data = i2c_get_clientdata(client);
+	char shadow[count];
+	
+	if(count>EEPROM_SIZE)
+		return 0;
+	/* Refuse to write Vaio Chips */
+	if(data->nature = VAIO)
+		return 0;
+	/* Only allow writes when we are unlocked! */
+	if(data->write_lock != 0)
+		return 0;
+	if(off + count > EEPROM_SIZE)
+		count = EEPROM_SIZE - off;
+	
+	memcpy(shadow,buf,count);
+	/* Prevent reading when we're writing */
+	mutex_lock(&data->update_lock);	
+	while(i < count) {
+		if((count - i) >= 8) {
+			/* Pagewrites (8 bytes) are the relatively fast */
+			i2c_smbus_write_i2c_block_data(client, (off + i), 8, shadow + i);
+			/* Wait for the chip to store everything. */
+			msleep(32);
+			i += 8;
+		} else {
+			i2c_smbus_write_i2c_block_data(client, (off + i), (count - i), shadow + i);
+			/* Wait for the chip to store everything. */
+			msleep(10 * (count - i));
+			i += (count - i);
+		}
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_lock(struct device *dev, struct device_attribute *attr, char *buf)
+{
+  struct eeprom_data *data = i2c_get_clientdata(to_i2c_client(dev));
+  return sprintf(buf, "%u\n", data->write_lock);
+}
+
+static ssize_t set_lock(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+  struct i2c_client *client = to_i2c_client(dev);
+  struct eeprom_data *data = i2c_get_clientdata(client);
+  unsigned long val = simple_strtoul(buf, NULL, 10);
+  if (val = 0)
+  {
+  	data->write_lock = 0;
+  } else {
+  	data->write_lock = 1;
+  }
+  return count;
+}
+
+static DEVICE_ATTR(write_lock, S_IWUSR | S_IRUGO, show_lock, set_lock);
+
+#endif //CONFIG_SENSORS_EEPROM_WRITE
+
 static struct bin_attribute eeprom_attr = {
 	.attr = {
 		.name = "eeprom",
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+		.mode = S_IRUGO | S_IWUSR,
+#else
 		.mode = S_IRUGO,
+#endif
 		.owner = THIS_MODULE,
 	},
 	.size = EEPROM_SIZE,
 	.read = eeprom_read,
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+	.write = eeprom_write,
+#endif
 };
 
 static int eeprom_attach_adapter(struct i2c_adapter *adapter)
@@ -191,6 +270,11 @@
 	mutex_init(&data->update_lock);
 	data->nature = UNKNOWN;
 
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+	/* Disallow write by default */
+	data->write_lock = 1;
+#endif
+
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_kfree;
@@ -210,6 +294,10 @@
 
 	/* create the sysfs eeprom file */
 	sysfs_create_bin_file(&new_client->dev.kobj, &eeprom_attr);
+#ifdef CONFIG_SENSORS_EEPROM_WRITE
+	/* create the sysfs write lock file */
+	device_create_file(&new_client->dev, &dev_attr_write_lock);
+#endif
 
 	return 0;
 


