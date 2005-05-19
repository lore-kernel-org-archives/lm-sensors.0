From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] More i2c driver changes for 2.5.69
Message-Id: <10525245932907@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030509235504.GD3517@kroah.com>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1083.2.1, 2003/05/09 13:53:57-07:00, greg@kroah.com

[PATCH] i2c: add i2c_adapter class support


 drivers/i2c/i2c-core.c |   23 ++++++++++++++++++++---
 include/linux/i2c.h    |    3 ++-
 2 files changed, 22 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri May  9 16:48:30 2003
+++ b/drivers/i2c/i2c-core.c	Fri May  9 16:48:30 2003
@@ -62,6 +62,10 @@
 	.remove = i2c_device_remove,
 };
 
+static struct class i2c_adapter_class = {
+	.name =		"i2c-adapter"
+};
+
 
 /* ---------------------------------------------------
  * registering functions 
@@ -97,6 +101,13 @@
 	adap->dev.driver = &i2c_generic_driver;
 	device_register(&adap->dev);
 
+	/* Add this adapter to the i2c_adapter class */
+	memset(&adap->class_dev, 0x00, sizeof(struct class_device));
+	adap->class_dev.dev = &adap->dev;
+	adap->class_dev.class = &i2c_adapter_class;
+	strncpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
+	class_device_register(&adap->class_dev);
+
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
@@ -150,6 +161,7 @@
 	}
 
 	/* clean up the sysfs representation */
+	class_device_unregister(&adap->class_dev);
 	device_unregister(&adap->dev);
 	list_del(&adap->list);
 
@@ -443,14 +455,19 @@
 	.match =	i2c_device_match,
 };
 
-
 static int __init i2c_init(void)
 {
-	return bus_register(&i2c_bus_type);
+	int retval;
+
+	retval = bus_register(&i2c_bus_type);
+	if (retval)
+		return retval;
+	return class_register(&i2c_adapter_class);
 }
 
 static void __exit i2c_exit(void)
 {
+	class_unregister(&i2c_adapter_class);
 	bus_unregister(&i2c_bus_type);
 }
 
@@ -475,7 +492,7 @@
 
 		return ret;
 	} else {
-		dev_err(&adap->dev, "I2C level transfers not supported\n");
+		DEB2(dev_dbg(&adap->dev, "I2C level transfers not supported\n"));
 		return -ENOSYS;
 	}
 }
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri May  9 16:48:30 2003
+++ b/include/linux/i2c.h	Fri May  9 16:48:30 2003
@@ -240,7 +240,8 @@
 
 	int timeout;
 	int retries;
-	struct device dev;	/* the adapter device */
+	struct device dev;		/* the adapter device */
+	struct class_device class_dev;	/* the class device */
 
 #ifdef CONFIG_PROC_FS 
 	/* No need to set this when you initialize the adapter          */

