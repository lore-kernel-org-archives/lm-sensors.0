From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 17:42:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: Avoid initializing the same field twice
Message-Id: <20140203184211.35536a4b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All hwmon drivers allocate their data structure with some form of
kzalloc, so setting data fields to zero explicitly is a waste of time.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Guenter, this is likely to conflict with your current conversion work,
as most of these drivers have not been converted yet (lm63 is the
exception.) I thought splitting this patch per driver was a little
overkill but maybe this would be better for you? I think I'll split at
least pc87360 anyway as it's non-trivial. Let me know how you want to
proceed.

 drivers/hwmon/asc7621.c   |    1 -
 drivers/hwmon/atxp1.c     |    2 --
 drivers/hwmon/lm63.c      |    1 -
 drivers/hwmon/lm77.c      |    1 -
 drivers/hwmon/lm83.c      |    1 -
 drivers/hwmon/lm87.c      |    1 -
 drivers/hwmon/lm92.c      |    1 -
 drivers/hwmon/lm93.c      |    1 -
 drivers/hwmon/lm95241.c   |    2 --
 drivers/hwmon/lm95245.c   |    1 -
 drivers/hwmon/max1619.c   |    1 -
 drivers/hwmon/pc87360.c   |   12 ++++++------
 drivers/hwmon/w83792d.c   |    1 -
 drivers/hwmon/w83l785ts.c |    4 ----
 14 files changed, 6 insertions(+), 24 deletions(-)

--- linux-3.14-rc0.orig/drivers/hwmon/lm63.c	2014-02-03 16:13:41.932281268 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm63.c	2014-02-03 18:16:47.830795982 +0100
@@ -1121,7 +1121,6 @@ static int lm63_probe(struct i2c_client
 		return -ENOMEM;
 
 	data->client = client;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Set the device type */
--- linux-3.14-rc0.orig/drivers/hwmon/lm77.c	2014-01-30 10:09:31.250577669 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm77.c	2014-02-03 18:17:22.243608345 +0100
@@ -348,7 +348,6 @@ static int lm77_probe(struct i2c_client
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM77 chip */
--- linux-3.14-rc0.orig/drivers/hwmon/lm83.c	2014-02-02 16:53:20.044990023 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm83.c	2014-02-03 18:16:02.964736773 +0100
@@ -349,7 +349,6 @@ static int lm83_probe(struct i2c_client
 		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/*
--- linux-3.14-rc0.orig/drivers/hwmon/lm92.c	2014-02-02 16:53:20.045990046 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm92.c	2014-02-03 18:17:09.263301938 +0100
@@ -380,7 +380,6 @@ static int lm92_probe(struct i2c_client
 		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chipset */
--- linux-3.14-rc0.orig/drivers/hwmon/lm95241.c	2014-01-30 10:09:31.250577669 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm95241.c	2014-02-03 18:17:50.865283951 +0100
@@ -371,9 +371,7 @@ static void lm95241_init_client(struct i
 	struct lm95241_data *data = i2c_get_clientdata(client);
 
 	data->interval = HZ;	/* 1 sec default */
-	data->valid = 0;
 	data->config = CFG_CR0076;
-	data->model = 0;
 	data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
 
 	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
--- linux-3.14-rc0.orig/drivers/hwmon/asc7621.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc0/drivers/hwmon/asc7621.c	2014-02-03 18:26:44.478888693 +0100
@@ -1115,7 +1115,6 @@ asc7621_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the asc7621 chip */
--- linux-3.14-rc0.orig/drivers/hwmon/atxp1.c	2014-01-30 10:09:31.250577669 +0100
+++ linux-3.14-rc0/drivers/hwmon/atxp1.c	2014-02-03 18:19:25.282512337 +0100
@@ -353,8 +353,6 @@ static int atxp1_probe(struct i2c_client
 	data->vrm = vid_which_vrm();
 
 	i2c_set_clientdata(new_client, data);
-	data->valid = 0;
-
 	mutex_init(&data->update_lock);
 
 	/* Register sysfs hooks */
--- linux-3.14-rc0.orig/drivers/hwmon/lm87.c	2014-02-02 16:53:20.044990023 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm87.c	2014-02-03 18:27:19.145719394 +0100
@@ -903,7 +903,6 @@ static int lm87_probe(struct i2c_client
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM87 chip */
--- linux-3.14-rc0.orig/drivers/hwmon/lm93.c	2014-02-02 16:53:20.045990046 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm93.c	2014-02-03 18:21:18.956194604 +0100
@@ -2754,7 +2754,6 @@ static int lm93_probe(struct i2c_client
 	i2c_set_clientdata(client, data);
 
 	/* housekeeping */
-	data->valid = 0;
 	data->update = update;
 	mutex_init(&data->update_lock);
 
--- linux-3.14-rc0.orig/drivers/hwmon/lm95245.c	2014-01-30 10:09:31.249577646 +0100
+++ linux-3.14-rc0/drivers/hwmon/lm95245.c	2014-02-03 18:25:57.755770551 +0100
@@ -440,7 +440,6 @@ static void lm95245_init_client(struct i
 {
 	struct lm95245_data *data = i2c_get_clientdata(client);
 
-	data->valid = 0;
 	data->interval = lm95245_read_conversion_rate(client);
 
 	data->config1 = i2c_smbus_read_byte_data(client,
--- linux-3.14-rc0.orig/drivers/hwmon/max1619.c	2014-02-02 16:53:20.045990046 +0100
+++ linux-3.14-rc0/drivers/hwmon/max1619.c	2014-02-03 18:25:06.711566861 +0100
@@ -273,7 +273,6 @@ static int max1619_probe(struct i2c_clie
 		return -ENOMEM;
 
 	i2c_set_clientdata(new_client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the MAX1619 chip */
--- linux-3.14-rc0.orig/drivers/hwmon/pc87360.c	2014-02-02 16:53:20.047990092 +0100
+++ linux-3.14-rc0/drivers/hwmon/pc87360.c	2014-02-03 18:24:18.701434614 +0100
@@ -1225,7 +1225,7 @@ static int pc87360_probe(struct platform
 	int i;
 	struct pc87360_data *data;
 	int err = 0;
-	const char *name = "pc87360";
+	const char *name;
 	int use_thermistors = 0;
 	struct device *dev = &pdev->dev;
 
@@ -1233,13 +1233,14 @@ static int pc87360_probe(struct platform
 	if (!data)
 		return -ENOMEM;
 
-	data->fannr = 2;
-	data->innr = 0;
-	data->tempnr = 0;
-
 	switch (devid) {
+	default:
+		name = "pc87360";
+		data->fannr = 2;
+		break;
 	case 0xe8:
 		name = "pc87363";
+		data->fannr = 2;
 		break;
 	case 0xe4:
 		name = "pc87364";
@@ -1260,7 +1261,6 @@ static int pc87360_probe(struct platform
 	}
 
 	data->name = name;
-	data->valid = 0;
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
--- linux-3.14-rc0.orig/drivers/hwmon/w83792d.c	2014-01-30 10:09:31.250577669 +0100
+++ linux-3.14-rc0/drivers/hwmon/w83792d.c	2014-02-03 18:20:16.372717944 +0100
@@ -1376,7 +1376,6 @@ w83792d_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	err = w83792d_detect_subclients(client);
--- linux-3.14-rc0.orig/drivers/hwmon/w83l785ts.c	2014-02-02 16:53:20.050990162 +0100
+++ linux-3.14-rc0/drivers/hwmon/w83l785ts.c	2014-02-03 18:20:50.586525248 +0100
@@ -188,12 +188,8 @@ static int w83l785ts_probe(struct i2c_cl
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
-	/* Default values in case the first read fails (unlikely). */
-	data->temp[1] = data->temp[0] = 0;
-
 	/*
 	 * Initialize the W83L785TS chip
 	 * Nothing yet, assume it is already started.


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
