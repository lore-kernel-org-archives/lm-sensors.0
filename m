From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:03:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: Static function fixes, 3 of 4
Message-Id: <11305336632602@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Static function fixes, 3 of 4

Fixup functions that have been declared static
and then actually defined without the static on.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c49efceffa599299ab3f38b1cdf8c2f1bf9811c4
tree e7b0124f85ad5563875c92679545f4c2fb38c956
parent d8d2061590c87c20bf78133461bc74df78803ecb
author Ben Dooks <ben-linux@fluff.org> Wed, 26 Oct 2005 21:07:25 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 drivers/hwmon/adm1026.c |   18 +++++++++---------
 drivers/hwmon/ds1621.c  |    4 ++--
 drivers/hwmon/fscpos.c  |    2 +-
 drivers/hwmon/it87.c    |    2 +-
 drivers/hwmon/lm80.c    |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 3b58141..e0f5654 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -315,7 +315,7 @@ static struct i2c_driver adm1026_driver 
 	.detach_client  = adm1026_detach_client,
 };
 
-int adm1026_attach_adapter(struct i2c_adapter *adapter)
+static int adm1026_attach_adapter(struct i2c_adapter *adapter)
 {
 	if (!(adapter->class & I2C_CLASS_HWMON)) {
 		return 0;
@@ -323,7 +323,7 @@ int adm1026_attach_adapter(struct i2c_ad
 	return i2c_probe(adapter, &addr_data, adm1026_detect);
 }
 
-int adm1026_detach_client(struct i2c_client *client)
+static int adm1026_detach_client(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->class_dev);
@@ -332,7 +332,7 @@ int adm1026_detach_client(struct i2c_cli
 	return 0;
 }
 
-int adm1026_read_value(struct i2c_client *client, u8 reg)
+static int adm1026_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
 
@@ -346,7 +346,7 @@ int adm1026_read_value(struct i2c_client
 	return res;
 }
 
-int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
+static int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
 {
 	int res;
 
@@ -360,7 +360,7 @@ int adm1026_write_value(struct i2c_clien
 	return res;
 }
 
-void adm1026_init_client(struct i2c_client *client)
+static void adm1026_init_client(struct i2c_client *client)
 {
 	int value, i;
 	struct adm1026_data *data = i2c_get_clientdata(client);
@@ -460,7 +460,7 @@ void adm1026_init_client(struct i2c_clie
 	}
 }
 
-void adm1026_print_gpio(struct i2c_client *client)
+static void adm1026_print_gpio(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
@@ -492,7 +492,7 @@ void adm1026_print_gpio(struct i2c_clien
 	}
 }
 
-void adm1026_fixup_gpio(struct i2c_client *client)
+static void adm1026_fixup_gpio(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
@@ -1452,8 +1452,8 @@ static DEVICE_ATTR(temp1_auto_point2_pwm
 static DEVICE_ATTR(temp2_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
 static DEVICE_ATTR(temp3_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
 
-int adm1026_detect(struct i2c_adapter *adapter, int address,
-		int kind)
+static int adm1026_detect(struct i2c_adapter *adapter, int address,
+			  int kind)
 {
 	int company, verstep;
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index c5afa00..34f71b7 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -186,8 +186,8 @@ static int ds1621_attach_adapter(struct 
 }
 
 /* This function is called by i2c_probe */
-int ds1621_detect(struct i2c_adapter *adapter, int address,
-                  int kind)
+static int ds1621_detect(struct i2c_adapter *adapter, int address,
+			 int kind)
 {
 	int conf, temp;
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index a378e4f..64e4edc 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -438,7 +438,7 @@ static int fscpos_attach_adapter(struct 
 	return i2c_probe(adapter, &addr_data, fscpos_detect);
 }
 
-int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
+static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct fscpos_data *data;
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 9a5b8b2..6c41e25 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -738,7 +738,7 @@ exit:
 }
 
 /* This function is called by i2c_probe */
-int it87_detect(struct i2c_adapter *adapter, int address, int kind)
+static int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index b4cd6c6..c359fde 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -393,7 +393,7 @@ static int lm80_attach_adapter(struct i2
 	return i2c_probe(adapter, &addr_data, lm80_detect);
 }
 
-int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur;
 	struct i2c_client *new_client;

