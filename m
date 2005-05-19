From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3-mm2 2/2] i2c: modify some sensors drivers
Message-Id: <20050503035057.GD4977@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch modifies sensors chip drivers to make use of the new
sysfs class "hwmon".

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc3-mm2/drivers/i2c/chips/lm78.c
=================================--- linux-2.6.12-rc3-mm2.orig/drivers/i2c/chips/lm78.c	2005-05-02 23:07:36.000000000 -0400
+++ linux-2.6.12-rc3-mm2/drivers/i2c/chips/lm78.c	2005-05-02 23:11:11.000000000 -0400
@@ -25,6 +25,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 /* Addresses to scan */
@@ -606,6 +608,12 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -644,6 +652,8 @@ int lm78_detect(struct i2c_adapter *adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	kfree(data);
 ERROR1:
@@ -657,6 +667,8 @@ static int lm78_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc3-mm2/drivers/i2c/chips/w83627hf.c
=================================--- linux-2.6.12-rc3-mm2.orig/drivers/i2c/chips/w83627hf.c	2005-05-02 23:07:36.000000000 -0400
+++ linux-2.6.12-rc3-mm2/drivers/i2c/chips/w83627hf.c	2005-05-02 23:11:00.000000000 -0400
@@ -44,6 +44,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -1102,6 +1104,12 @@ int w83627hf_detect(struct i2c_adapter *
 	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83697hf)
 		device_create_file_in(new_client, 1);
@@ -1152,6 +1160,8 @@ int w83627hf_detect(struct i2c_adapter *
 
 	return 0;
 
+      ERROR3:
+	i2c_detach_client(new_client);
       ERROR2:
 	kfree(data);
       ERROR1:
@@ -1164,6 +1174,8 @@ static int w83627hf_detach_client(struct
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
-- 
Mark M. Hoffman
mhoffman@lightlink.com
