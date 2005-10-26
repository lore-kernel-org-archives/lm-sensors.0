From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:06:37 +0000
Subject: [lm-sensors] [PATCH 03/16] hwmon: Static function fixes, 3 of 4
Message-Id: <20051026210725.577b12ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Content-Disposition: inline; filename=static-03-hwmon-other.patch

Fixup functions that have been declared static
and then actually defined without the static on.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/hwmon/adm1026.c |   18 +++++++++---------
 drivers/hwmon/ds1621.c  |    4 ++--
 drivers/hwmon/fscpos.c  |    2 +-
 drivers/hwmon/it87.c    |    2 +-
 drivers/hwmon/lm80.c    |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/hwmon/adm1026.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/adm1026.c	2005-10-18 23:02:13.000000000 +0200
@@ -315,7 +315,7 @@
 	.detach_client  = adm1026_detach_client,
 };
 
-int adm1026_attach_adapter(struct i2c_adapter *adapter)
+static int adm1026_attach_adapter(struct i2c_adapter *adapter)
 {
 	if (!(adapter->class & I2C_CLASS_HWMON)) {
 		return 0;
@@ -323,7 +323,7 @@
 	return i2c_probe(adapter, &addr_data, adm1026_detect);
 }
 
-int adm1026_detach_client(struct i2c_client *client)
+static int adm1026_detach_client(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
@@ -332,7 +332,7 @@
 	return 0;
 }
 
-int adm1026_read_value(struct i2c_client *client, u8 reg)
+static int adm1026_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
 
@@ -346,7 +346,7 @@
 	return res;
 }
 
-int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
+static int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
 {
 	int res;
 
@@ -360,7 +360,7 @@
 	return res;
 }
 
-void adm1026_init_client(struct i2c_client *client)
+static void adm1026_init_client(struct i2c_client *client)
 {
 	int value, i;
 	struct adm1026_data *data = i2c_get_clientdata(client);
@@ -460,7 +460,7 @@
 	}
 }
 
-void adm1026_print_gpio(struct i2c_client *client)
+static void adm1026_print_gpio(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
@@ -492,7 +492,7 @@
 	}
 }
 
-void adm1026_fixup_gpio(struct i2c_client *client)
+static void adm1026_fixup_gpio(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
@@ -1452,8 +1452,8 @@
 static DEVICE_ATTR(temp2_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
 static DEVICE_ATTR(temp3_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
 
-int adm1026_detect(struct i2c_adapter *adapter, int address,
-		int kind)
+static int adm1026_detect(struct i2c_adapter *adapter, int address,
+			  int kind)
 {
 	int company, verstep;
 	struct i2c_client *new_client;
--- linux-2.6.14-rc4.orig/drivers/hwmon/ds1621.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/ds1621.c	2005-10-18 23:02:13.000000000 +0200
@@ -186,8 +186,8 @@
 }
 
 /* This function is called by i2c_probe */
-int ds1621_detect(struct i2c_adapter *adapter, int address,
-                  int kind)
+static int ds1621_detect(struct i2c_adapter *adapter, int address,
+			 int kind)
 {
 	int conf, temp;
 	struct i2c_client *new_client;
--- linux-2.6.14-rc4.orig/drivers/hwmon/fscpos.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/fscpos.c	2005-10-18 23:02:13.000000000 +0200
@@ -438,7 +438,7 @@
 	return i2c_probe(adapter, &addr_data, fscpos_detect);
 }
 
-int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
+static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct fscpos_data *data;
--- linux-2.6.14-rc4.orig/drivers/hwmon/it87.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/it87.c	2005-10-18 23:02:13.000000000 +0200
@@ -738,7 +738,7 @@
 }
 
 /* This function is called by i2c_probe */
-int it87_detect(struct i2c_adapter *adapter, int address, int kind)
+static int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm80.c	2005-10-18 22:49:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm80.c	2005-10-18 23:02:13.000000000 +0200
@@ -393,7 +393,7 @@
 	return i2c_probe(adapter, &addr_data, lm80_detect);
 }
 
-int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur;
 	struct i2c_client *new_client;

-- 
Jean Delvare
