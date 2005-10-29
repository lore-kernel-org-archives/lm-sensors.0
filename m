From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:10:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: Static function fixes, 2 of 4
Message-Id: <11305336633202@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Static function fixes, 2 of 4

lm78.c and lm85.c have a number of items declared static
then implemented without the static on them. The following
patch fixes these sparse errors.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d8d2061590c87c20bf78133461bc74df78803ecb
tree 39ca3da820be362cabfff53f9d5446f6c3dc8059
parent 6536c49a1ee2bd85eee0e7fa41e67c5743f2f93e
author Ben Dooks <ben-linux@fluff.org> Wed, 26 Oct 2005 21:05:46 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 drivers/hwmon/lm78.c |    2 +-
 drivers/hwmon/lm85.c |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 9244623..bde0cda 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -480,7 +480,7 @@ static int lm78_isa_attach_adapter(struc
 }
 
 /* This function is called by i2c_probe */
-int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index d5537a5..d1070ed 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
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
@@ -1235,7 +1235,7 @@ int lm85_detect(struct i2c_adapter *adap
 	return err;
 }
 
-int lm85_detach_client(struct i2c_client *client)
+static int lm85_detach_client(struct i2c_client *client)
 {
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
@@ -1245,7 +1245,7 @@ int lm85_detach_client(struct i2c_client
 }
 
 
-int lm85_read_value(struct i2c_client *client, u8 reg)
+static int lm85_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
 
@@ -1275,7 +1275,7 @@ int lm85_read_value(struct i2c_client *c
 	return res ;
 }
 
-int lm85_write_value(struct i2c_client *client, u8 reg, int value)
+static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
 {
 	int res ;
 
@@ -1304,7 +1304,7 @@ int lm85_write_value(struct i2c_client *
 	return res ;
 }
 
-void lm85_init_client(struct i2c_client *client)
+static void lm85_init_client(struct i2c_client *client)
 {
 	int value;
 	struct lm85_data *data = i2c_get_clientdata(client);

