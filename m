From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 26 Jul 2005 23:48:59 +0000
Subject: [lm-sensors] patch i2c-max6875-simplify.patch added to gregkh-2.6
Message-Id: <1DxXI8-2m4-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: simplify max6875 driver

to my gregkh-2.6 tree.  Its filename is

     i2c-max6875-simplify.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c-max6875-simplify.patch
i2c-max6875-documentation-update.patch


From BGardner@Wabtec.com Tue Jul 12 11:24:04 2005
From: bgardner@wabtec.com
To: Jean Delvare <khali@linux-fr.org>
Subject: I2C: simplify max6875 driver
Date: Tue, 12 Jul 2005 13:21:11 -0500
Cc: "lm-sensors" <lm-sensors@lm-sensors.org>,
 greg@kroah.com
Message-Id: <200507121321.11458.bgardner@wabtec.com>

[PATCH] I2C: simplify max6875 driver

This is an update to the max6875 driver.
It no longer does any detection, so the address must be forced on module load.
It only makes available the user EEPROM (read-only).

This patch is based off 2.6.13-rc2-mm2.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.13-rc2-mm2.orig/drivers/i2c/chips/max6875.c
+++ linux-2.6.13-rc2-mm2/drivers/i2c/chips/max6875.c
@@ -5,97 +5,62 @@
 
     Based on i2c/chips/eeprom.c
 
-    The MAX6875 has two EEPROM sections: config and user.
-    At reset, the config EEPROM is read into the registers.
+    The MAX6875 has a bank of registers and two banks of EEPROM.
+    Address ranges are defined as follows:
+     * 0x0000 - 0x0046 = configuration registers
+     * 0x8000 - 0x8046 = configuration EEPROM
+     * 0x8100 - 0x82FF = user EEPROM
 
-    This driver make 3 binary files available in sysfs:
-      reg_config    - direct access to the registers
-      eeprom_config - acesses configuration eeprom space
-      eeprom_user   - free for application use
-
-    In our application, we put device serial & model numbers in user eeprom.
-
-    Notes:
-      1) The datasheet says that register 0x44 / EEPROM 0x8044 should NOT
-         be overwritten, so the driver explicitly prevents that.
-      2) It's a good idea to keep the config (0x45) locked in config EEPROM.
-         You can temporarily enable config writes by changing register 0x45.
+    This driver makes the user EEPROM available for read.
+
+    The registers & config EEPROM should be accessed via i2c-dev.
+
+    The MAX6875 ignores the lowest address bit, so each chip responds to
+    two addresses - 0x50/0x51 and 0x52/0x53.
+
+    Note that the MAX6875 uses i2c_smbus_write_byte_data() to set the read
+    address, so this driver is destructive if loaded for the wrong EEPROM chip.
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; version 2 of the License.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <asm/semaphore.h>
 
-/* Addresses to scan */
-/* No address scanned by default, as this could corrupt standard EEPROMS. */
+/* Do not scan - the MAX6875 access method will write to some EEPROM chips */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(max6875);
 
-/* this param will prevent 'accidental' writes to the eeprom */
-static int allow_write = 0;
-module_param(allow_write, int, 0);
-MODULE_PARM_DESC(allow_write,
-		 "Enable write access:\n"
-		 "*0: Read only\n"
-		 " 1: Read/Write access");
-
 /* The MAX6875 can only read/write 16 bytes at a time */
 #define SLICE_SIZE			16
 #define SLICE_BITS			4
 
-/* CONFIG EEPROM is at addresses 0x8000 - 0x8045, registers are at 0 - 0x45 */
-#define CONFIG_EEPROM_BASE		0x8000
-#define CONFIG_EEPROM_SIZE		0x0046
-#define CONFIG_EEPROM_SLICES		5
-
 /* USER EEPROM is at addresses 0x8100 - 0x82FF */
 #define USER_EEPROM_BASE		0x8100
 #define USER_EEPROM_SIZE		0x0200
 #define USER_EEPROM_SLICES		32
 
 /* MAX6875 commands */
-#define MAX6875_CMD_BLOCK_WRITE		0x83
-#define MAX6875_CMD_BLOCK_READ		0x84
-#define MAX6875_CMD_REBOOT		0x88
-
-enum max6875_area_type {
-	max6875_register_config=0,
-	max6875_eeprom_config,
-	max6875_eeprom_user,
-	max6857_max
-};
-
-struct eeprom_block {
-	enum max6875_area_type	type;
-	u8			slices;
-	u32			size;
-	u32			valid;
-	u32			base;
-	unsigned long		*updated;
-	u8			*data;
-};
+#define MAX6875_CMD_BLK_READ		0x84
 
 /* Each client has this additional data */
 struct max6875_data {
 	struct i2c_client	client;
 	struct semaphore	update_lock;
-	struct eeprom_block	blocks[max6857_max];
-	/* the above structs point into the arrays below */
-	u8 data[USER_EEPROM_SIZE + (CONFIG_EEPROM_SIZE*2)];
-	unsigned long last_updated[USER_EEPROM_SLICES + (CONFIG_EEPROM_SLICES*2)];
+
+	u32			valid;
+	u8			data[USER_EEPROM_SIZE];
+	unsigned long		last_updated[USER_EEPROM_SLICES];
 };
 
 static int max6875_attach_adapter(struct i2c_adapter *adapter);
@@ -111,224 +76,98 @@ static struct i2c_driver max6875_driver 
 	.detach_client	= max6875_detach_client,
 };
 
-static int max6875_update_slice(struct i2c_client *client,
-				struct eeprom_block *blk,
-				int slice)
+static void max6875_update_slice(struct i2c_client *client, int slice)
 {
 	struct max6875_data *data = i2c_get_clientdata(client);
-	int i, j, addr, count;
-	u8 rdbuf[SLICE_SIZE];
+	int i, j, addr;
+	u8 *buf;
 	int retval = 0;
 
-	if (slice >= blk->slices)
-		return -1;
+	if (slice >= USER_EEPROM_SLICES)
+		return;
 
 	down(&data->update_lock);
 
-	if (!(blk->valid & (1 << slice)) ||
-	    (jiffies - blk->updated[slice] > 300 * HZ) ||
-	    (jiffies < blk->updated[slice])) {
-		dev_dbg(&client->dev, "Starting eeprom update, slice %u, base %u\n",
+	buf = &data->data[slice << SLICE_BITS];
+
+	if (!(data->valid & (1 << slice)) ||
+	    time_after(jiffies, data->last_updated[slice])) {
+
+		dev_dbg(&client->dev, "Starting update of slice %u\n",
 			slice, blk->base);
 
-		addr = blk->base + (slice << SLICE_BITS);
-		count = blk->size - (slice << SLICE_BITS);
-		if (count > SLICE_SIZE) {
-			count = SLICE_SIZE;
-		}
+		data->valid &= ~(1 << slice);
 
-		/* Preset the read address */
-		if (addr < 0x100) {
-			/* select the register */
-			if (i2c_smbus_write_byte(client, addr & 0xFF)) {
-				dev_dbg(&client->dev, "max6875 register select has failed!\n");
-				retval = -1;
-				goto exit;
-			}
-		} else {
-			/* select the eeprom */
-			if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
-				dev_dbg(&client->dev, "max6875 address set has failed!\n");
-				retval = -1;
-				goto exit;
-			}
+		addr = USER_EEPROM_BASE + (slice << SLICE_BITS);
+
+		/* select the eeprom address */
+		if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
+			dev_err(&client->dev, "address set failed\n");
+			retval = -1;
+			goto exit_up;
 		}
 
-		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			if (i2c_smbus_read_i2c_block_data(client, MAX6875_CMD_BLOCK_READ,
-							  rdbuf) != SLICE_SIZE)
-			{
+		if (i2c_check_functionality(client->adapter,
+					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			if (i2c_smbus_read_i2c_block_data(client,
+							  MAX6875_CMD_BLK_READ,
+							  buf) != SLICE_SIZE) {
 				retval = -1;
-				goto exit;
+				goto exit_up;
 			}
-
-			memcpy(&blk->data[slice << SLICE_BITS], rdbuf, count);
 		} else {
-			for (i = 0; i < count; i++) {
+			for (i = 0; i < SLICE_SIZE; i++) {
 				j = i2c_smbus_read_byte(client);
-				if (j < 0)
-				{
+				if (j < 0) {
 					retval = -1;
-					goto exit;
+					goto exit_up;
 				}
-				blk->data[(slice << SLICE_BITS) + i] = (u8) j;
+				buf[i] = j;
 			}
 		}
-		blk->updated[slice] = jiffies;
-		blk->valid |= (1 << slice);
+		data->last_updated[slice] = jiffies;
+		data->valid |= (1 << slice);
 	}
-	exit:
+exit_up:
 	up(&data->update_lock);
-	return retval;
 }
 
-static ssize_t max6875_read(struct kobject *kobj, char *buf, loff_t off, size_t count,
-			    enum max6875_area_type area_type)
+static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
-	struct max6875_data *data = i2c_get_clientdata(client);
-	struct eeprom_block *blk;
-	int slice;
-
-	blk = &data->blocks[area_type];
-
-	if (off > blk->size)
-		return 0;
-	if (off + count > blk->size)
-		count = blk->size - off;
-
-	/* Only refresh slices which contain requested bytes */
-	for (slice = (off >> SLICE_BITS); slice <= ((off + count - 1) >> SLICE_BITS); slice++)
-		max6875_update_slice(client, blk, slice);
-
-	memcpy(buf, &blk->data[off], count);
-
-	return count;
+	return to_i2c_client(container_of(kobj, struct device, kobj));
 }
 
-static ssize_t max6875_user_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+static ssize_t max6875_read(struct kobject *kobj, char *buf, loff_t off,
+			    size_t count)
 {
-	return max6875_read(kobj, buf, off, count, max6875_eeprom_user);
-}
-
-static ssize_t max6875_config_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	return max6875_read(kobj, buf, off, count, max6875_eeprom_config);
-}
-
-static ssize_t max6875_cfgreg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	return max6875_read(kobj, buf, off, count, max6875_register_config);
-}
-
-
-static ssize_t max6875_write(struct kobject *kobj, char *buf, loff_t off, size_t count,
-			     enum max6875_area_type area_type)
-{
-	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
 	struct max6875_data *data = i2c_get_clientdata(client);
-	struct eeprom_block *blk;
-	int slice, addr, retval;
-	ssize_t sent = 0;
-
-	blk = &data->blocks[area_type];
+	int slice, max_slice;
 
-	if (off > blk->size)
+	if (off > USER_EEPROM_SIZE)
 		return 0;
-	if ((off + count) > blk->size)
-		count = blk->size - off;
-
-	if (down_interruptible(&data->update_lock))
-		return -EAGAIN;
 
-	/* writing to a register is done with i2c_smbus_write_byte_data() */
-	if (blk->type = max6875_register_config) {
-		for (sent = 0; sent < count; sent++) {
-			addr = off + sent;
-			if (addr = 0x44)
-				continue;
-
-			retval = i2c_smbus_write_byte_data(client, addr, buf[sent]);
-		}
-	} else {
-		int cmd, val;
+	if (off + count > USER_EEPROM_SIZE)
+		count = USER_EEPROM_SIZE - off;
 
-		/* We are writing to EEPROM */
-		for (sent = 0; sent < count; sent++) {
-			addr = blk->base + off + sent;
-			cmd = addr >> 8;
-			val = (addr & 0xff) | (buf[sent] << 8);	// reversed
+	/* refresh slices which contain requested bytes */
+	max_slice = (off + count - 1) >> SLICE_BITS;
+	for (slice = (off >> SLICE_BITS); slice <= max_slice; slice++)
+		max6875_update_slice(client, slice);
 
-			if (addr = 0x8044)
-				continue;
+	memcpy(buf, &data->data[off], count);
 
-			retval = i2c_smbus_write_word_data(client, cmd, val);
-
-			if (retval) {
-				goto error_exit;
-			}
-
-			/* A write takes up to 11 ms */
-			msleep(11);
-		}
-	}
-
-	/* Invalidate the scratch buffer */
-	for (slice = (off >> SLICE_BITS); slice <= ((off + count - 1) >> SLICE_BITS); slice++)
-		blk->valid &= ~(1 << slice);
-
-	error_exit:
-	up(&data->update_lock);
-
-	return sent;
-}
-
-static ssize_t max6875_user_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	return max6875_write(kobj, buf, off, count, max6875_eeprom_user);
-}
-
-static ssize_t max6875_config_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	return max6875_write(kobj, buf, off, count, max6875_eeprom_config);
-}
-
-static ssize_t max6875_cfgreg_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	return max6875_write(kobj, buf, off, count, max6875_register_config);
+	return count;
 }
 
 static struct bin_attribute user_eeprom_attr = {
 	.attr = {
-		.name = "eeprom_user",
-		.mode = S_IRUGO | S_IWUSR | S_IWGRP,
-		.owner = THIS_MODULE,
-	},
-	.size  = USER_EEPROM_SIZE,
-	.read  = max6875_user_read,
-	.write = max6875_user_write,
-};
-
-static struct bin_attribute config_eeprom_attr = {
-	.attr = {
-		.name = "eeprom_config",
-		.mode = S_IRUGO | S_IWUSR,
+		.name = "eeprom",
+		.mode = S_IRUGO,
 		.owner = THIS_MODULE,
 	},
-	.size  = CONFIG_EEPROM_SIZE,
-	.read  = max6875_config_read,
-	.write = max6875_config_write,
-};
-
-static struct bin_attribute config_register_attr = {
-	.attr = {
-		.name = "reg_config",
-		.mode = S_IRUGO | S_IWUSR,
-		.owner = THIS_MODULE,
-	},
-	.size  = CONFIG_EEPROM_SIZE,
-	.read  = max6875_cfgreg_read,
-	.write = max6875_cfgreg_write,
+	.size = USER_EEPROM_SIZE,
+	.read = max6875_read,
 };
 
 static int max6875_attach_adapter(struct i2c_adapter *adapter)
@@ -339,107 +178,68 @@ static int max6875_attach_adapter(struct
 /* This function is called by i2c_detect */
 static int max6875_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *real_client;
+	struct i2c_client *fake_client;
 	struct max6875_data *data;
 	int err = 0;
 
-	/* There are three ways we can read the EEPROM data:
-	   (1) I2C block reads (faster, but unsupported by most adapters)
-	   (2) Consecutive byte reads (100% overhead)
-	   (3) Regular byte data reads (200% overhead)
-	   The third method is not implemented by this driver because all
-	   known adapters support at least the second. */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA |
-				     I2C_FUNC_SMBUS_BYTE |
-				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
-		goto exit;
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access eeprom_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct max6875_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	memset(data, 0, sizeof(struct max6875_data));
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_BYTE))
+		return 0;
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &max6875_driver;
-	new_client->flags = 0;
-
-	/* Prevent 24RF08 corruption */
-	i2c_smbus_write_quick(new_client, 0);
-
-	/* Setup the user section */
-	data->blocks[max6875_eeprom_user].type    = max6875_eeprom_user;
-	data->blocks[max6875_eeprom_user].slices  = USER_EEPROM_SLICES;
-	data->blocks[max6875_eeprom_user].size    = USER_EEPROM_SIZE;
-	data->blocks[max6875_eeprom_user].base    = USER_EEPROM_BASE;
-	data->blocks[max6875_eeprom_user].data    = data->data;
-	data->blocks[max6875_eeprom_user].updated = data->last_updated;
-
-	/* Setup the config section */
-	data->blocks[max6875_eeprom_config].type    = max6875_eeprom_config;
-	data->blocks[max6875_eeprom_config].slices  = CONFIG_EEPROM_SLICES;
-	data->blocks[max6875_eeprom_config].size    = CONFIG_EEPROM_SIZE;
-	data->blocks[max6875_eeprom_config].base    = CONFIG_EEPROM_BASE;
-	data->blocks[max6875_eeprom_config].data    = &data->data[USER_EEPROM_SIZE];
-	data->blocks[max6875_eeprom_config].updated = &data->last_updated[USER_EEPROM_SLICES];
-
-	/* Setup the register section */
-	data->blocks[max6875_register_config].type    = max6875_register_config;
-	data->blocks[max6875_register_config].slices  = CONFIG_EEPROM_SLICES;
-	data->blocks[max6875_register_config].size    = CONFIG_EEPROM_SIZE;
-	data->blocks[max6875_register_config].base    = 0;
-	data->blocks[max6875_register_config].data    = &data->data[USER_EEPROM_SIZE+CONFIG_EEPROM_SIZE];
-	data->blocks[max6875_register_config].updated = &data->last_updated[USER_EEPROM_SLICES+CONFIG_EEPROM_SLICES];
+	/* Only check even addresses */
+	if (address & 1)
+		return 0;
 
-	/* Init the data */
-	memset(data->data, 0xff, sizeof(data->data));
+	if (!(data = kmalloc(sizeof(struct max6875_data), GFP_KERNEL)))
+		return -ENOMEM;
+	memset(data, 0, sizeof(struct max6875_data));
+
+	/* A fake client is created on the odd address */
+	if (!(fake_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_kfree1;
+	}
+	memset(fake_client, 0, sizeof(struct i2c_client));
 
-	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, "max6875", I2C_NAME_SIZE);
+	/* Init real i2c_client */
+	real_client = &data->client;
+	i2c_set_clientdata(real_client, data);
+	real_client->addr = address;
+	real_client->adapter = adapter;
+	real_client->driver = &max6875_driver;
+	real_client->flags = 0;
+	strlcpy(real_client->name, "max6875", I2C_NAME_SIZE);
 	init_MUTEX(&data->update_lock);
 
-	/* Verify that the chip is really what we think it is */
-	if ((max6875_update_slice(new_client, &data->blocks[max6875_eeprom_config], 4) < 0) ||
-	    (max6875_update_slice(new_client, &data->blocks[max6875_register_config], 4) < 0))
-		goto exit_kfree;
-
-	/* 0x41,0x42 must be zero and 0x40 must match in eeprom and registers */
-	if ((data->blocks[max6875_eeprom_config].data[0x41] != 0) ||
-	    (data->blocks[max6875_eeprom_config].data[0x42] != 0) ||
-	    (data->blocks[max6875_register_config].data[0x41] != 0) ||
-	    (data->blocks[max6875_register_config].data[0x42] != 0) ||
-	    (data->blocks[max6875_eeprom_config].data[0x40] !-	     data->blocks[max6875_register_config].data[0x40]))
-		goto exit_kfree;
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_kfree;
-
-	/* create the sysfs eeprom files with the correct permissions */
-	if (allow_write = 0) {
-		user_eeprom_attr.attr.mode &= ~S_IWUGO;
-		user_eeprom_attr.write = NULL;
-		config_eeprom_attr.attr.mode &= ~S_IWUGO;
-		config_eeprom_attr.write = NULL;
-		config_register_attr.attr.mode &= ~S_IWUGO;
-		config_register_attr.write = NULL;
-	}
-	sysfs_create_bin_file(&new_client->dev.kobj, &user_eeprom_attr);
-	sysfs_create_bin_file(&new_client->dev.kobj, &config_eeprom_attr);
-	sysfs_create_bin_file(&new_client->dev.kobj, &config_register_attr);
+	/* Init fake client data */
+	/* set the client data to the i2c_client so that it will get freed */
+	i2c_set_clientdata(fake_client, fake_client);
+	fake_client->addr = address | 1;
+	fake_client->adapter = adapter;
+	fake_client->driver = &max6875_driver;
+	fake_client->flags = 0;
+	strlcpy(fake_client->name, "max6875-dummy", I2C_NAME_SIZE);
+
+	/* Prevent 24RF08 corruption (in case of user error) */
+	i2c_smbus_write_quick(real_client, 0);
+
+	if ((err = i2c_attach_client(real_client)) != 0)
+		goto exit_kfree2;
+	
+	if ((err = i2c_attach_client(fake_client)) != 0)
+		goto exit_detach;
+
+	sysfs_create_bin_file(&real_client->dev.kobj, &user_eeprom_attr);
 
 	return 0;
 
-exit_kfree:
+exit_detach:
+	i2c_detach_client(real_client);
+exit_kfree2:
+	kfree(fake_client);
+exit_kfree1:
 	kfree(data);
-exit:
 	return err;
 }
 
@@ -449,12 +249,10 @@ static int max6875_detach_client(struct 
 
 	err = i2c_detach_client(client);
 	if (err) {
-		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev, "i2c_detach_client() failed\n");
 		return err;
 	}
-
 	kfree(i2c_get_clientdata(client));
-
 	return 0;
 }
 

