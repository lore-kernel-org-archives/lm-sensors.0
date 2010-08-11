From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 15:11:54 +0000
Subject: [lm-sensors] [PATCH 4/6] hwmon: (pc87427) Add support for the
Message-Id: <20100811171154.40b1ade5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The second logical device contains the voltage and temperature
registers. We have to extend the driver to support a second logical
device before we can add support for these features.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/pc87427.c |  129 +++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 42 deletions(-)

--- linux-2.6.35-rc4.orig/drivers/hwmon/pc87427.c	2010-07-07 22:13:42.000000000 +0200
+++ linux-2.6.35-rc4/drivers/hwmon/pc87427.c	2010-07-08 08:58:31.000000000 +0200
@@ -65,6 +65,7 @@ struct pc87427_data {
 };
 
 struct pc87427_sio_data {
+	unsigned short address[2];
 	u8 has_fanin;
 	u8 has_fanout;
 };
@@ -608,6 +609,46 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
  * Device detection, attach and detach
  */
 
+static void pc87427_release_regions(struct platform_device *pdev, int count)
+{
+	struct resource *res;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IO, i);
+		release_region(res->start, resource_size(res));
+	}
+}
+
+static int __devinit pc87427_request_regions(struct platform_device *pdev,
+					     int count)
+{
+	struct resource *res;
+	int i, err = 0;
+
+	for (i = 0; i < count; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IO, i);
+		if (!res) {
+			err = -ENOENT;
+			dev_err(&pdev->dev, "Missing resource #%d\n", i);
+			break;
+		}
+		if (!request_region(res->start, resource_size(res), DRVNAME)) {
+			err = -EBUSY;
+			dev_err(&pdev->dev,
+				"Failed to request region 0x%lx-0x%lx\n",
+				(unsigned long)res->start,
+				(unsigned long)res->end);
+			break;
+		}
+	}
+
+	if (err && i)
+		pc87427_release_regions(pdev, i);
+
+	return err;
+}
+
 static void __devinit pc87427_init_device(struct device *dev)
 {
 	struct pc87427_sio_data *sio_data = dev->platform_data;
@@ -664,9 +705,9 @@ static void __devinit pc87427_init_devic
 
 static int __devinit pc87427_probe(struct platform_device *pdev)
 {
+	struct pc87427_sio_data *sio_data = pdev->dev.platform_data;
 	struct pc87427_data *data;
-	struct resource *res;
-	int i, err;
+	int i, err, res_count;
 
 	data = kzalloc(sizeof(struct pc87427_data), GFP_KERNEL);
 	if (!data) {
@@ -675,16 +716,13 @@ static int __devinit pc87427_probe(struc
 		goto exit;
 	}
 
-	/* This will need to be revisited when we add support for
-	   temperature and voltage monitoring. */
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, resource_size(res), DRVNAME)) {
-		err = -EBUSY;
-		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
-			(unsigned long)res->start, (unsigned long)res->end);
+	data->address[0] = sio_data->address[0];
+	data->address[1] = sio_data->address[1];
+	res_count = (data->address[0] != 0) + (data->address[1] != 0);
+
+	err = pc87427_request_regions(pdev, res_count);
+	if (err)
 		goto exit_kfree;
-	}
-	data->address[0] = res->start;
 
 	mutex_init(&data->lock);
 	data->name = "pc87427";
@@ -733,7 +771,7 @@ exit_remove_files:
 		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
 	}
 exit_release_region:
-	release_region(res->start, resource_size(res));
+	pc87427_release_regions(pdev, res_count);
 exit_kfree:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
@@ -744,8 +782,9 @@ exit:
 static int __devexit pc87427_remove(struct platform_device *pdev)
 {
 	struct pc87427_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
-	int i;
+	int i, res_count;
+
+	res_count = (data->address[0] != 0) + (data->address[1] != 0);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
@@ -762,8 +801,7 @@ static int __devexit pc87427_remove(stru
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, resource_size(res));
+	pc87427_release_regions(pdev, res_count);
 
 	return 0;
 }
@@ -778,29 +816,37 @@ static struct platform_driver pc87427_dr
 	.remove		= __devexit_p(pc87427_remove),
 };
 
-static int __init pc87427_device_add(unsigned short address,
-				     const struct pc87427_sio_data *sio_data)
+static int __init pc87427_device_add(const struct pc87427_sio_data *sio_data)
 {
-	struct resource res = {
-		.start	= address,
-		.end	= address + REGION_LENGTH - 1,
-		.name	= logdev_str[0],
-		.flags	= IORESOURCE_IO,
+	struct resource res[2] = {
+		{ .flags	= IORESOURCE_IO },
+		{ .flags	= IORESOURCE_IO },
 	};
-	int err;
+	int err, i, res_count;
 
-	err = acpi_check_resource_conflict(&res);
-	if (err)
-		goto exit;
+	res_count = 0;
+	for (i = 0; i < 2; i++) {
+		if (!sio_data->address[i])
+			continue;
+		res[res_count].start = sio_data->address[i];
+		res[res_count].end = sio_data->address[i] + REGION_LENGTH - 1;
+		res[res_count].name = logdev_str[i];
 
-	pdev = platform_device_alloc(DRVNAME, address);
+		err = acpi_check_resource_conflict(&res[res_count]);
+		if (err)
+			goto exit;
+
+		res_count++;
+	}
+
+	pdev = platform_device_alloc(DRVNAME, res[0].start);
 	if (!pdev) {
 		err = -ENOMEM;
 		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
 		goto exit;
 	}
 
-	err = platform_device_add_resources(pdev, &res, 1);
+	err = platform_device_add_resources(pdev, res, res_count);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
 		       "(%d)\n", err);
@@ -829,8 +875,7 @@ exit:
 	return err;
 }
 
-static int __init pc87427_find(int sioaddr, unsigned short *address,
-			       struct pc87427_sio_data *sio_data)
+static int __init pc87427_find(int sioaddr, struct pc87427_sio_data *sio_data)
 {
 	u16 val;
 	u8 cfg, cfg_b;
@@ -844,7 +889,7 @@ static int __init pc87427_find(int sioad
 	}
 
 	for (i = 0; i < 2; i++) {
-		address[i] = 0;
+		sio_data->address[i] = 0;
 		/* Select logical device */
 		superio_outb(sioaddr, SIOREG_LDSEL, logdev[i]);
 
@@ -869,7 +914,13 @@ static int __init pc87427_find(int sioad
 			       "for logical device 0x%02x\n", logdev[i]);
 			continue;
 		}
-		address[i] = val;
+		sio_data->address[i] = val;
+	}
+
+	/* No point in loading the driver if everything is disabled */
+	if (!sio_data->address[0] && !sio_data->address[1]) {
+		err = -ENODEV;
+		goto exit;
 	}
 
 	/* Check which fan inputs are wired */
@@ -923,16 +974,10 @@ exit:
 static int __init pc87427_init(void)
 {
 	int err;
-	unsigned short address[2];
 	struct pc87427_sio_data sio_data;
 
-	if (pc87427_find(0x2e, address, &sio_data)
-	 && pc87427_find(0x4e, address, &sio_data))
-		return -ENODEV;
-
-	/* For now the driver only handles fans so we only care about the
-	   first address. */
-	if (!address[0])
+	if (pc87427_find(0x2e, &sio_data)
+	 && pc87427_find(0x4e, &sio_data))
 		return -ENODEV;
 
 	err = platform_driver_register(&pc87427_driver);
@@ -940,7 +985,7 @@ static int __init pc87427_init(void)
 		goto exit;
 
 	/* Sets global pdev as a side effect */
-	err = pc87427_device_add(address[0], &sio_data);
+	err = pc87427_device_add(&sio_data);
 	if (err)
 		goto exit_driver;
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
