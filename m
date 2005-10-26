From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:05:08 +0000
Subject: [lm-sensors] [PATCH 02/16] hwmon: Static function fixes, 2 of 4
Message-Id: <20051026210546.3337fe63.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Content-Disposition: inline; filename=static-02-hwmon-lm78-lm85.patch

lm78.c and lm85.c have a number of items declared static
then implemented without the static on them. The following
patch fixes these sparse errors.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/hwmon/lm78.c |    2 +-
 drivers/hwmon/lm85.c |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/hwmon/lm78.c	2005-10-18 22:49:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm78.c	2005-10-18 22:50:17.000000000 +0200
@@ -480,7 +480,7 @@
 }
 
 /* This function is called by i2c_probe */
-int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
 	struct i2c_client *new_client;
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm85.c	2005-10-18 22:49:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm85.c	2005-10-18 22:50:17.000000000 +0200
@@ -1007,14 +1007,14 @@
 temp_auto(2);
 temp_auto(3);
 
-int lm85_attach_adapter(struct i2c_adapter *adapter)
+static int lm85_attach_adapter(struct i2c_adapter *adapter)
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
 	return i2c_probe(adapter, &addr_data, lm85_detect);
 }
 
-int lm85_detect(struct i2c_adapter *adapter, int address,
+static int lm85_detect(struct i2c_adapter *adapter, int address,
 		int kind)
 {
 	int company, verstep ;
@@ -1235,7 +1235,7 @@
 	return err;
 }
 
-int lm85_detach_client(struct i2c_client *client)
+static int lm85_detach_client(struct i2c_client *client)
 {
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
@@ -1245,7 +1245,7 @@
 }
 
 
-int lm85_read_value(struct i2c_client *client, u8 reg)
+static int lm85_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
 
@@ -1275,7 +1275,7 @@
 	return res ;
 }
 
-int lm85_write_value(struct i2c_client *client, u8 reg, int value)
+static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
 {
 	int res ;
 
@@ -1304,7 +1304,7 @@
 	return res ;
 }
 
-void lm85_init_client(struct i2c_client *client)
+static void lm85_init_client(struct i2c_client *client)
 {
 	int value;
 	struct lm85_data *data = i2c_get_clientdata(client);

-- 
Jean Delvare
