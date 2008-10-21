From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 14:24:26 +0000
Subject: [lm-sensors] PATCH: f71882fg style cleanups and put some repeating
Message-Id: <48FDE61A.9000501@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000805020003020208010904"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000805020003020208010904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Various small cleanups as preparation for adding f71862fg support to the
f71882fg driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------000805020003020208010904
Content-Type: text/plain;
 name="f71882fg-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="f71882fg-cleanup.patch"

Various small cleanups as preparation for adding f71862fg support to the
f71882fg driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.pre-f71862fg	2008-10-20 11:32:17.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2008-10-21 15:29:17.000000000 +0200
@@ -1,6 +1,6 @@
 /***************************************************************************
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
- *   Copyright (C) 2007 by Hans de Goede  <j.w.r.degoede@hhs.nl>           *
+ *   Copyright (C) 2007,2008 by Hans de Goede <hdegoede@redhat.com>        *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -228,11 +228,7 @@
 	char *buf);
 
 static int __devinit f71882fg_probe(struct platform_device * pdev);
-static int __devexit f71882fg_remove(struct platform_device *pdev);
-static int __init f71882fg_init(void);
-static int __init f71882fg_find(int sioaddr, unsigned short *address);
-static int __init f71882fg_device_add(unsigned short address);
-static void __exit f71882fg_exit(void);
+static int f71882fg_remove(struct platform_device *pdev);
 
 static struct platform_driver f71882fg_driver = {
 	.driver = {
@@ -243,10 +239,7 @@
 	.remove		= __devexit_p(f71882fg_remove),
 };
 
-static struct device_attribute f71882fg_dev_attr[] =
-{
-	__ATTR( name, S_IRUGO, show_name, NULL ),
-};
+DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] =
 {
@@ -1396,14 +1389,27 @@
 	return sprintf(buf, DRVNAME "\n");
 }
 
+static int __devinit f71882fg_create_sysfs_files(struct platform_device *pdev,
+	struct sensor_device_attribute_2 *attr, int count)
+{
+	int err, i;
+
+	for (i = 0; i < count; i++) {
+		err = device_create_file(&pdev->dev, &attr[i].dev_attr);
+		if (err)
+			return err;
+	}
+	return 0;
+}
 
-static int __devinit f71882fg_probe(struct platform_device * pdev)
+static int __devinit f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
-	int err, i;
+	int err;
 	u8 start_reg;
 
-	if (!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
@@ -1411,65 +1417,50 @@
 	platform_set_drvdata(pdev, data);
 
 	/* Register sysfs interface files */
-	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++) {
-		err = device_create_file(&pdev->dev, &f71882fg_dev_attr[i]);
-		if (err)
-			goto exit_unregister_sysfs;
-	}
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
+		goto exit_unregister_sysfs;
 
 	start_reg = f71882fg_read8(data, F71882FG_REG_START);
 	if (start_reg & 0x01) {
-		for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++) {
-			err = device_create_file(&pdev->dev,
-					&f71882fg_in_temp_attr[i].dev_attr);
-			if (err)
-				goto exit_unregister_sysfs;
-		}
+		err = f71882fg_create_sysfs_files(pdev, f71882fg_in_temp_attr,
+					ARRAY_SIZE(f71882fg_in_temp_attr));
+		if (err)
+			goto exit_unregister_sysfs;
 	}
 
 	if (start_reg & 0x02) {
-		for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++) {
-			err = device_create_file(&pdev->dev,
-					&f71882fg_fan_attr[i].dev_attr);
-			if (err)
-				goto exit_unregister_sysfs;
-		}
+		err = f71882fg_create_sysfs_files(pdev, f71882fg_fan_attr,
+					ARRAY_SIZE(f71882fg_fan_attr));
+		if (err)
+			goto exit_unregister_sysfs;
 	}
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
 		goto exit_unregister_sysfs;
 	}
 
 	return 0;
 
 exit_unregister_sysfs:
-	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
-		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
-
-	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
-		device_remove_file(&pdev->dev,
-					&f71882fg_in_temp_attr[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
-		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
-
-	kfree(data);
+	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
 
 	return err;
 }
 
-static int __devexit f71882fg_remove(struct platform_device *pdev)
+static int f71882fg_remove(struct platform_device *pdev)
 {
 	int i;
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
-	hwmon_device_unregister(data->hwmon_dev);
+	if (data->hwmon_dev)
+		hwmon_device_unregister(data->hwmon_dev);
 
-	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
-		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
+	device_remove_file(&pdev->dev, &dev_attr_name);
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
 		device_remove_file(&pdev->dev,
@@ -1577,10 +1568,12 @@
 	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))
 		goto exit;
 
-	if ((err = platform_driver_register(&f71882fg_driver)))
+	err = platform_driver_register(&f71882fg_driver);
+	if (err)
 		goto exit;
 
-	if ((err = f71882fg_device_add(address)))
+	err = f71882fg_device_add(address);
+	if (err)
 		goto exit_driver;
 
 	return 0;
@@ -1598,7 +1591,7 @@
 }
 
 MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
-MODULE_AUTHOR("Hans Edgington (hans@edgington.nl)");
+MODULE_AUTHOR("Hans Edgington, Hans de Goede (hdegoede@redhat.com)");
 MODULE_LICENSE("GPL");
 
 module_init(f71882fg_init);

--------------000805020003020208010904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000805020003020208010904--
