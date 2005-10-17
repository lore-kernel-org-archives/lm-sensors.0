From: ben@fluff.org.uk (Ben Dooks)
Date: Mon, 17 Oct 2005 23:05:30 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon - fix static function
Message-Id: <20051017210412.GA7485@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixup functions that have been declared static
and then actually defined without the static on

 adm1026.c |   18 +++++++++---------
 ds1621.c  |    4 ++--
 fscpos.c  |    2 +-
 it87.c    |    2 +-
 lm80.c    |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/adm1026.c linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/adm1026.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/adm1026.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/adm1026.c	2005-10-17 21:55:21.000000000 +0100
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
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/ds1621.c linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/ds1621.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/ds1621.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/ds1621.c	2005-10-17 21:56:26.000000000 +0100
@@ -184,8 +184,8 @@ static int ds1621_attach_adapter(struct 
 }
 
 /* This function is called by i2c_probe */
-int ds1621_detect(struct i2c_adapter *adapter, int address,
-                  int kind)
+static int ds1621_detect(struct i2c_adapter *adapter, int address,
+			 int kind)
 {
 	int conf, temp;
 	struct i2c_client *new_client;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/fscpos.c linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/fscpos.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/fscpos.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/fscpos.c	2005-10-17 21:56:49.000000000 +0100
@@ -438,7 +438,7 @@ static int fscpos_attach_adapter(struct 
 	return i2c_probe(adapter, &addr_data, fscpos_detect);
 }
 
-int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
+static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct fscpos_data *data;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/it87.c linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/it87.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/it87.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/it87.c	2005-10-17 21:57:11.000000000 +0100
@@ -738,7 +738,7 @@ exit:
 }
 
 /* This function is called by i2c_probe */
-int it87_detect(struct i2c_adapter *adapter, int address, int kind)
+static int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/lm80.c linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/lm80.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/hwmon/lm80.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/hwmon/lm80.c	2005-10-17 21:57:43.000000000 +0100
@@ -393,7 +393,7 @@ static int lm80_attach_adapter(struct i2
 	return i2c_probe(adapter, &addr_data, lm80_detect);
 }
 
-int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
+static int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur;
 	struct i2c_client *new_client;
