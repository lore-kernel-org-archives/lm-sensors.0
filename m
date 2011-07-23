From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jul 2011 16:10:30 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm78) Make ISA interface depend on
Message-Id: <20110723181030.72a8dc7b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should only include support for the ISA interface of the LM78/LM79
if CONFIG_ISA is set. Not only this makes the driver somewhat smaller
on most architectures, but this also avoids poking at random I/O
ports on these architectures.

This is very similiar to what was done for the w83781d driver in
October 2008.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Dean Nelson <dnelson@redhat.com>
---
Dean, with these 2 patches, the lm78 driver should no longer crash on
PPC64. Please test and report if you can.

 drivers/hwmon/lm78.c |   98 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 19 deletions(-)

--- linux-3.0.orig/drivers/hwmon/lm78.c	2011-07-23 14:21:25.000000000 +0200
+++ linux-3.0/drivers/hwmon/lm78.c	2011-07-23 14:42:04.000000000 +0200
@@ -2,7 +2,7 @@
     lm78.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
-    Copyright (c) 2007        Jean Delvare <khali@linux-fr.org>
+    Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -26,23 +26,21 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/ioport.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/io.h>
 
-/* ISA device, if found */
-static struct platform_device *pdev;
+#ifdef CONFIG_ISA
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#endif
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 						0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned short isa_address = 0x290;
-
 enum chips { lm78, lm79 };
 
 /* Many LM78 constants specified below */
@@ -476,6 +474,16 @@ static const struct attribute_group lm78
 	.attrs = lm78_attributes,
 };
 
+/*
+ * ISA related code
+ */
+#ifdef CONFIG_ISA
+
+/* ISA device, if found */
+static struct platform_device *pdev;
+
+static unsigned short isa_address = 0x290;
+
 /* I2C devices get this name attribute automatically, but for ISA devices
    we must create it by ourselves. */
 static ssize_t show_name(struct device *dev, struct device_attribute
@@ -487,6 +495,11 @@ static ssize_t show_name(struct device *
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
+static struct lm78_data *lm78_data_if_isa(void)
+{
+	return pdev ? platform_get_drvdata(pdev) : NULL;
+}
+
 /* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
 static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
 {
@@ -520,12 +533,24 @@ static int lm78_alias_detect(struct i2c_
 
 	return 1;
 }
+#else /* !CONFIG_ISA */
+
+static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
+{
+	return 0;
+}
+
+static struct lm78_data *lm78_data_if_isa(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_ISA */
 
 static int lm78_i2c_detect(struct i2c_client *client,
 			   struct i2c_board_info *info)
 {
 	int i;
-	struct lm78_data *isa = pdev ? platform_get_drvdata(pdev) : NULL;
+	struct lm78_data *isa = lm78_data_if_isa();
 	const char *client_name;
 	struct i2c_adapter *adapter = client->adapter;
 	int address = client->addr;
@@ -653,6 +678,7 @@ static int lm78_read_value(struct lm78_d
 {
 	struct i2c_client *client = data->client;
 
+#ifdef CONFIG_ISA
 	if (!client) { /* ISA device */
 		int res;
 		mutex_lock(&data->lock);
@@ -661,6 +687,7 @@ static int lm78_read_value(struct lm78_d
 		mutex_unlock(&data->lock);
 		return res;
 	} else
+#endif
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
@@ -675,6 +702,7 @@ static int lm78_write_value(struct lm78_
 {
 	struct i2c_client *client = data->client;
 
+#ifdef CONFIG_ISA
 	if (!client) { /* ISA device */
 		mutex_lock(&data->lock);
 		outb_p(reg, data->isa_addr + LM78_ADDR_REG_OFFSET);
@@ -682,6 +710,7 @@ static int lm78_write_value(struct lm78_
 		mutex_unlock(&data->lock);
 		return 0;
 	} else
+#endif
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
@@ -759,6 +788,7 @@ static struct lm78_data *lm78_update_dev
 	return data;
 }
 
+#ifdef CONFIG_ISA
 static int __devinit lm78_isa_probe(struct platform_device *pdev)
 {
 	int err;
@@ -960,12 +990,10 @@ static int __init lm78_isa_device_add(un
 	return err;
 }
 
-static int __init sm_lm78_init(void)
+static int __init lm78_isa_register(void)
 {
 	int res;
 
-	/* We register the ISA device first, so that we can skip the
-	 * registration of an I2C interface to the same device. */
 	if (lm78_isa_found(isa_address)) {
 		res = platform_driver_register(&lm78_isa_driver);
 		if (res)
@@ -977,26 +1005,58 @@ static int __init sm_lm78_init(void)
 			goto exit_unreg_isa_driver;
 	}
 
-	res = i2c_add_driver(&lm78_driver);
-	if (res)
-		goto exit_unreg_isa_device;
-
 	return 0;
 
- exit_unreg_isa_device:
-	platform_device_unregister(pdev);
  exit_unreg_isa_driver:
 	platform_driver_unregister(&lm78_isa_driver);
  exit:
 	return res;
 }
 
-static void __exit sm_lm78_exit(void)
+static void lm78_isa_unregister(void)
 {
 	if (pdev) {
 		platform_device_unregister(pdev);
 		platform_driver_unregister(&lm78_isa_driver);
 	}
+}
+#else /* !CONFIG_ISA */
+
+static int __init lm78_isa_register(void)
+{
+	return 0;
+}
+
+static void lm78_isa_unregister(void)
+{
+}
+#endif /* CONFIG_ISA */
+
+static int __init sm_lm78_init(void)
+{
+	int res;
+
+	/* We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device. */
+	res = lm78_isa_register();
+	if (res)
+		goto exit;
+
+	res = i2c_add_driver(&lm78_driver);
+	if (res)
+		goto exit_unreg_isa_device;
+
+	return 0;
+
+ exit_unreg_isa_device:
+	lm78_isa_unregister();
+ exit:
+	return res;
+}
+
+static void __exit sm_lm78_exit(void)
+{
+	lm78_isa_unregister();
 	i2c_del_driver(&lm78_driver);
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
