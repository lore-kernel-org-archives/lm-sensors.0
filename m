From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 2/2] i2c: modify some sensors drivers to
Message-Id: <20050411044737.GC4963@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch modifies sensors chip drivers to make use of the new
sysfs class "hwmon".

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc2-mm2/drivers/i2c/chips/lm78.c
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/i2c/chips/lm78.c	2005-04-07 21:12:49.000000000 -0400
+++ linux-2.6.12-rc2-mm2/drivers/i2c/chips/lm78.c	2005-04-11 00:02:07.000000000 -0400
@@ -25,6 +25,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
 #include <asm/io.h>
 
 /* Addresses to scan */
@@ -642,6 +643,8 @@ int lm78_detect(struct i2c_adapter *adap
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 
+	hwmon_device_register(&new_client->class_dev, &new_client->dev);
+
 	return 0;
 
 ERROR2:
@@ -657,6 +660,8 @@ static int lm78_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(&client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc2-mm2/drivers/i2c/chips/w83627hf.c
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/i2c/chips/w83627hf.c	2005-04-10 23:28:13.000000000 -0400
+++ linux-2.6.12-rc2-mm2/drivers/i2c/chips/w83627hf.c	2005-04-10 23:36:54.000000000 -0400
@@ -44,6 +44,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -1150,6 +1151,8 @@ int w83627hf_detect(struct i2c_adapter *
 	if (kind != w83697hf)
 		device_create_file_sensor(new_client, 3);
 
+	hwmon_device_register(&new_client->class_dev, &new_client->dev);
+
 	return 0;
 
       ERROR2:
@@ -1164,6 +1167,8 @@ static int w83627hf_detach_client(struct
 {
 	int err;
 
+	hwmon_device_unregister(&client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");

-- 
Mark M. Hoffman
mhoffman@lightlink.com
