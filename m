From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: pcf8574 doesn't need a lock
Message-Id: <20050328211632.656659fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While investigating the i2c chips drivers that were not properly
locking, we found that the pcf8574 driver does the exact contrary. It
uses a lock where it's not needed.

While we were there, we did some additional cleanups to the driver:
1* Merge pcf8574_update_client() in show_read(), as it was the only user
and the function became trivial once the locking was removed.
2* Add a validity check on values provided by user-space.

Aurelien Jarno tested the modified code for confirmation and it worked
just fine.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8574.c.orig	2005-03-27 10:34:55.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8574.c	2005-03-27 10:40:31.000000000 +0200
@@ -56,7 +56,6 @@
 /* Each client has this additional data */
 struct pcf8574_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
 
 	u8 read, write;			/* Register values */
 };
@@ -65,7 +64,6 @@
 static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind);
 static int pcf8574_detach_client(struct i2c_client *client);
 static void pcf8574_init_client(struct i2c_client *client);
-static struct pcf8574_data *pcf8574_update_client(struct device *dev);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver pcf8574_driver = {
@@ -80,7 +78,9 @@
 /* following are the sysfs callback functions */
 static ssize_t show_read(struct device *dev, char *buf)
 {
-	struct pcf8574_data *data = pcf8574_update_client(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+	data->read = i2c_smbus_read_byte(client); 
 	return sprintf(buf, "%u\n", data->read);
 }
 
@@ -97,7 +97,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->write = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	data->write = val;
 	i2c_smbus_write_byte(client, data->write);
 	return count;
 }
@@ -157,7 +162,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
@@ -202,19 +206,6 @@
 	i2c_smbus_write_byte(client, data->write);
 }
 
-static struct pcf8574_data *pcf8574_update_client(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-
-	down(&data->update_lock);
-	dev_dbg(&client->dev, "Starting pcf8574 update\n");
-	data->read = i2c_smbus_read_byte(client); 
-	up(&data->update_lock);
-	
-	return data;
-}
-
 static int __init pcf8574_init(void)
 {
 	return i2c_add_driver(&pcf8574_driver);


-- 
Jean Delvare
