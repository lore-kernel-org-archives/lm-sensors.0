From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Feb 2010 16:07:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Restore configuration on exit
Message-Id: <20100213170759.5b93b693@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Restore the chip configuration when unloading the driver. This ensures
we don't leave the chip running if it was initially stopped.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.33-rc8.orig/drivers/hwmon/lm90.c	2010-02-13 15:50:55.000000000 +0100
+++ linux-2.6.33-rc8/drivers/hwmon/lm90.c	2010-02-13 15:53:00.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003-2009  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2010  Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
@@ -203,6 +203,8 @@ struct lm90_data {
 	int kind;
 	int flags;
 
+	u8 config_orig;		/* Original configuration register value */
+
 	/* registers values */
 	s8 temp8[4];	/* 0: local low limit
 			   1: local high limit
@@ -840,7 +842,7 @@ exit:
 
 static void lm90_init_client(struct i2c_client *client)
 {
-	u8 config, config_orig;
+	u8 config;
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	/*
@@ -852,7 +854,7 @@ static void lm90_init_client(struct i2c_
 		dev_warn(&client->dev, "Initialization failed!\n");
 		return;
 	}
-	config_orig = config;
+	data->config_orig = config;
 
 	/* Check Temperature Range Select */
 	if (data->kind = adt7461) {
@@ -870,7 +872,7 @@ static void lm90_init_client(struct i2c_
 	}
 
 	config &= 0xBF;	/* run */
-	if (config != config_orig) /* Only write if changed */
+	if (config != data->config_orig) /* Only write if changed */
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
@@ -885,6 +887,10 @@ static int lm90_remove(struct i2c_client
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
 
+	/* Restore initial configuration */
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
+				  data->config_orig);
+
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
