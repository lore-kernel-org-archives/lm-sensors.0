From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 Oct 2005 12:24:58 +0000
Subject: [lm-sensors] [PATCH] hwmon - lm78, lm85  sparse fixes
Message-Id: <20051013102407.GA31018@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm78.c and lm85.c have a number of items declared static
then implemented without the static on them. The following
patch fixes the sparse errors below

  CHECK   drivers/hwmon/lm78.c
drivers/hwmon/lm78.c:483:5: warning: symbol 'lm78_detect' was not declared. Should it be static?
  CHECK   drivers/hwmon/lm85.c
drivers/hwmon/lm85.c:1010:5: warning: symbol 'lm85_attach_adapter' was not declared. Should it be static?
drivers/hwmon/lm85.c:1017:5: warning: symbol 'lm85_detect' was not declared. Should it be static?
drivers/hwmon/lm85.c:1239:5: warning: symbol 'lm85_detach_client' was not declared. Should it be static?
drivers/hwmon/lm85.c:1249:5: warning: symbol 'lm85_read_value' was not declared. Should it be static?
drivers/hwmon/lm85.c:1279:5: warning: symbol 'lm85_write_value' was not declared. Should it be static?
drivers/hwmon/lm85.c:1308:6: warning: symbol 'lm85_init_client' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/hwmon/lm78.c linux-2.6.14-rc4-bjd2/drivers/hwmon/lm78.c
--- linux-2.6.14-rc4-bjd1/drivers/hwmon/lm78.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/hwmon/lm78.c	2005-10-13 11:18:54.000000000 +0100
@@ -480,7 +480,7 @@ static int lm78_isa_attach_adapter(struc
 }
 
 /* This function is called by i2c_probe */
-int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
 	struct i2c_client *new_client;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/hwmon/lm85.c linux-2.6.14-rc4-bjd2/drivers/hwmon/lm85.c
--- linux-2.6.14-rc4-bjd1/drivers/hwmon/lm85.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/hwmon/lm85.c	2005-10-13 11:18:51.000000000 +0100
@@ -1007,14 +1007,14 @@ temp_auto(1);
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
@@ -1236,7 +1236,7 @@ int lm85_detect(struct i2c_adapter *adap
 	return err;
 }
 
-int lm85_detach_client(struct i2c_client *client)
+static int lm85_detach_client(struct i2c_client *client)
 {
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
@@ -1246,7 +1246,7 @@ int lm85_detach_client(struct i2c_client
 }
 
 
-int lm85_read_value(struct i2c_client *client, u8 reg)
+static int lm85_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
 
@@ -1276,7 +1276,7 @@ int lm85_read_value(struct i2c_client *c
 	return res ;
 }
 
-int lm85_write_value(struct i2c_client *client, u8 reg, int value)
+static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
 {
 	int res ;
 
@@ -1305,7 +1305,7 @@ int lm85_write_value(struct i2c_client *
 	return res ;
 }
 
-void lm85_init_client(struct i2c_client *client)
+static void lm85_init_client(struct i2c_client *client)
 {
 	int value;
 	struct lm85_data *data = i2c_get_clientdata(client);
