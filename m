From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:01 +0000
Subject: [lm-sensors] [PATCH] I2C: W83792D add hwmon class register 2/3
Message-Id: <11259567674063@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: W83792D add hwmon class register 2/3

This patch adds registration of hwmon class. Tested with help of i2c-stub.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ce785ab460ce8728a9daf337ba8fab3ba692b6aa
tree ff3bbb4d1f417b4db05ad8d3c7e96f1ee82caf93
parent 5563e27d3a42667734e81c1cb8ad72bff76321f6
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Wed, 27 Jul 2005 11:50:18 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:13 -0700

 drivers/hwmon/w83792d.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -42,7 +42,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -267,6 +269,7 @@ DIV_TO_REG(long val)
 
 struct w83792d_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -1289,6 +1292,11 @@ w83792d_detect(struct i2c_adapter *adapt
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
@@ -1361,6 +1369,15 @@ w83792d_detect(struct i2c_adapter *adapt
 
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
@@ -1372,21 +1389,25 @@ ERROR0:
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

