From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040116195255.65703948.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Depends on what the patch looks like.  Care to make it up to see if
> it's not too ugly?

Here you go. Comments at the bottom.

--- linux-2.6.1-g1/drivers/i2c/chips/eeprom.c	2004-01-16 11:03:45.000000000 +0100
+++ linux-2.6.1-g1-k1/drivers/i2c/chips/eeprom.c	2004-01-16 13:32:14.000000000 +0100
@@ -6,6 +6,11 @@
     Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
     Copyright (C) 2003 IBM Corp.
 
+    2004-01-16  Jean Delvare <khali@linux-fr.org>
+    Divide the eeprom in 32-byte (arbitrary) slices. This significantly
+    speeds sensors up, as well as various scripts using the eeprom
+    module.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -60,8 +65,8 @@
 /* Each client has this additional data */
 struct eeprom_data {
 	struct semaphore update_lock;
-	char valid;			/* !=0 if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
+	u8 valid;			/* bitfield, bit!=0 if slice is valid */
+	unsigned long last_updated[8];	/* In jiffies, 8 slices */
 	u8 data[EEPROM_SIZE];		/* Register values */
 	enum eeprom_nature nature;
 };
@@ -83,35 +88,36 @@
 
 static int eeprom_id = 0;
 
-static void eeprom_update_client(struct i2c_client *client)
+static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
 	int i, j;
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 300 * HZ) |
-	    (jiffies < data->last_updated) || !data->valid) {
-		dev_dbg(&client->dev, "Starting eeprom update\n");
+	if (!(data->valid & (1 << slice)) ||
+	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
+	    (jiffies < data->last_updated[slice])) {
+		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i=0; i < EEPROM_SIZE; i += I2C_SMBUS_I2C_BLOCK_MAX)
+			for (i = slice << 5; i < (slice + 1) << 5; i += I2C_SMBUS_I2C_BLOCK_MAX)
 				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
 					goto exit;
 		} else {
-			if (i2c_smbus_write_byte(client, 0)) {
+			if (i2c_smbus_write_byte(client, slice << 5)) {
 				dev_dbg(&client->dev, "eeprom read start has failed!\n");
 				goto exit;
 			}
-			for (i = 0; i < EEPROM_SIZE; i++) {
+			for (i = slice << 5; i < (slice + 1) << 5; i++) {
 				j = i2c_smbus_read_byte(client);
 				if (j < 0)
 					goto exit;
 				data->data[i] = (u8) j;
 			}
 		}
-		data->last_updated = jiffies;
-		data->valid = 1;
+		data->last_updated[slice] = jiffies;
+		data->valid |= (1 << slice);
 	}
 exit:
 	up(&data->update_lock);
@@ -121,14 +127,17 @@
 {
 	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
 	struct eeprom_data *data = i2c_get_clientdata(client);
-
-	eeprom_update_client(client);
+	u8 slice;
 
 	if (off > EEPROM_SIZE)
 		return 0;
 	if (off + count > EEPROM_SIZE)
 		count = EEPROM_SIZE - off;
 
+	/* Only refresh slices which contain requested bytes */
+	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
+		eeprom_update_client(client, slice);
+
 	/* Hide Vaio security settings to regular users (16 first bytes) */
 	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
 		int in_row1 = 16 - off;


Basically, I divide the eeprom in 8 32-byte slices. Each of it has a
"valid" boolean (combined together into a bitfield) and a jiffies
counter. Eeprom_update_client() is added a new parameter to specify
which slice to update. Code updated accordingly. Finally, the read
function updates only slices that need to be. The code is heavily
inspired from what was done in the CVS driver, of course.

Three additional notes:

1* This fixes a bug in eeprom_update_client()'s refresh condition. We
used to check jiffies before valid, although jiffies are not defined if
valid isn't true. That was already fixed in our CVS driver but for some
reason the fix did not go into 2.6 yet.

2* This also skips the update if the read if out of bounds. I think this
is the thing to do.

3* It can be discussed wether eeprom_update_client() should take two
slice parameters instead of one (start slice, end slice). This would
make things slightly faster when consecutive slices are requested. Maybe
the code would even be clearer. It wasn't done so far because the CVS
driver wouldn't benefit from it (because the EEPROM's contents are split
over several "output" files in that version of the driver) but I'll
probably give it a try in 2.6.

So, what do you think? Too ugly?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
