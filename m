From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Nov 2005 19:33:48 +0000
Subject: [lm-sensors] [PATCH] Misc cleanups to the w83792d driver
Message-Id: <20051128193452.2d474a8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan, hi Rudolf,

Here's a w83792d patch, comments welcome. If there are no objections
I'll enqueue it for Linux 2.6.16.

Thanks.

* * * * *

Cleanup the w83792d driver a bit:
* Discard unused lock and irrelevant comments inherited from the
  w83781d driver.
* Inline and simplify w83792d_{read,write}_value functions.
* Drop useless address test during detection.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83792d.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/hwmon/w83792d.c	2005-11-28 14:39:35.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/w83792d.c	2005-11-28 15:29:02.000000000 +0100
@@ -268,7 +268,6 @@
 struct w83792d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -304,8 +303,8 @@
 static int w83792d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83792d_detach_client(struct i2c_client *client);
 
-static int w83792d_read_value(struct i2c_client *client, u8 register);
-static int w83792d_write_value(struct i2c_client *client, u8 register,
+static inline int w83792d_read_value(struct i2c_client *client, u8 register);
+static inline int w83792d_write_value(struct i2c_client *client, u8 register,
 				u8 value);
 static struct w83792d_data *w83792d_update_device(struct device *dev);
 
@@ -1192,7 +1191,6 @@
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83792d_driver;
 	new_client->flags = 0;
@@ -1243,7 +1241,7 @@
 			goto ERROR1;
 		}
 		val1 = w83792d_read_value(new_client, W83792D_REG_WCHIPID);
-		if (val1 = 0x7a && address >= 0x2c) {
+		if (val1 = 0x7a) {
 			kind = w83792d;
 		} else {
 			if (kind = 0)
@@ -1406,26 +1404,19 @@
 	return 0;
 }
 
-/* The SMBus locks itself, usually, but nothing may access the Winbond between
-   bank switches. ISA access must always be locked explicitly!
-   We ignore the W83792D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83792D access and should not be necessary.
-   There are some ugly typecasts here, but the good news is - they should
-   nowhere else be necessary! */
-static int
+/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
+   but the driver only accesses registers in bank 0, so we don't have
+   to switch banks and lock access between switches. */
+static inline int
 w83792d_read_value(struct i2c_client *client, u8 reg)
 {
-	int res=0;
-	res = i2c_smbus_read_byte_data(client, reg);
-
-	return res;
+	return i2c_smbus_read_byte_data(client, reg);
 }
 
-static int
+static inline int
 w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
-	i2c_smbus_write_byte_data(client, reg,  value);
-	return 0;
+	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
 static void


-- 
Jean Delvare
