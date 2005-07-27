From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Wed, 27 Jul 2005 13:50:28 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D add hwmon class register 2/3 -
Message-Id: <20050727115018.9241.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050727092507.28687.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050727092507.28687.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Ok here is second try.

This patch adds registration of hwmon class. Tested with help of i2c-stub.
Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply.

Regards
Rudolf

diff -Naur b/drivers/hwmon/w83792d.c c/drivers/hwmon/w83792d.c
--- b/drivers/hwmon/w83792d.c	2005-07-27 10:30:03.212372250 +0200
+++ c/drivers/hwmon/w83792d.c	2005-07-27 13:02:54.149759750 +0200
@@ -42,7 +42,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -267,6 +269,7 @@
 
 struct w83792d_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -1289,6 +1292,11 @@
 	}
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
 	device_create_file_in(new_client, 0);
 	device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
@@ -1361,6 +1369,15 @@
 
 	return 0;
 
+ERROR3:
+	if (data->lm75[0] != NULL) {
+		i2c_detach_client(data->lm75[0]);
+		kfree(data->lm75[0]);
+	}
+	if (data->lm75[1] != NULL) {
+		i2c_detach_client(data->lm75[1]);
+		kfree(data->lm75[1]);
+	}	
 ERROR2:
 	i2c_detach_client(new_client);
 ERROR1:
@@ -1372,21 +1389,25 @@
 static int
 w83792d_detach_client(struct i2c_client *client)
 {
+	struct w83792d_data *data = i2c_get_clientdata(client);
 	int err;
 
+	/* main client */
+	if (data)
+		hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 			"Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
-	if (i2c_get_clientdata(client)=NULL) {
-		/* subclients */
+	/* main client */
+	if (data)
+		kfree(data);
+	/* subclient */
+	else
 		kfree(client);
-	} else {
-		/* main client */
-		kfree(i2c_get_clientdata(client));
-	}
 
 	return 0;
 }
