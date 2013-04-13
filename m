From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 16:36:42 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (nct6775) Support two SuperIO chips in the same system
Message-Id: <1365871004-14448-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |  100 ++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index f11d311..4d63943 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3486,8 +3486,8 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 	}
 
 	superio_exit(sioaddr);
-	pr_info("Found %s or compatible chip at %#x\n",
-		nct6775_sio_names[sio_data->kind], *addr);
+	pr_info("Found %s or compatible chip at %#x:%#x\n",
+		nct6775_sio_names[sio_data->kind], sioaddr, *addr);
 	sio_data->sioreg = sioaddr;
 
 	return 0;
@@ -3499,14 +3499,20 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
  * track of the nct6775 driver. But since we platform_device_alloc(), we
  * must keep track of the device
  */
-static struct platform_device *pdev;
+static struct platform_device *pdev[2];
 
 static int __init sensors_nct6775_init(void)
 {
-	int err;
+	int i, err;
+	bool found = false;
 	unsigned short address;
 	struct resource res;
 	struct nct6775_sio_data sio_data;
+	int sioaddr[2] = { 0x2e, 0x4e };
+
+	err = platform_driver_register(&nct6775_driver);
+	if (err)
+		return err;
 
 	/*
 	 * initialize sio_data->kind and sio_data->sioreg.
@@ -3515,64 +3521,70 @@ static int __init sensors_nct6775_init(void)
 	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
 	 * nct6775 hardware monitor, and call probe()
 	 */
-	if (nct6775_find(0x2e, &address, &sio_data) &&
-	    nct6775_find(0x4e, &address, &sio_data))
-		return -ENODEV;
-
-	err = platform_driver_register(&nct6775_driver);
-	if (err)
-		goto exit;
+	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+		if (nct6775_find(sioaddr[i], &address, &sio_data))
+			continue;
 
-	pdev = platform_device_alloc(DRVNAME, address);
-	if (!pdev) {
-		err = -ENOMEM;
-		pr_err("Device allocation failed\n");
-		goto exit_unregister;
-	}
+		found = true;
 
-	err = platform_device_add_data(pdev, &sio_data,
-				       sizeof(struct nct6775_sio_data));
-	if (err) {
-		pr_err("Platform data allocation failed\n");
-		goto exit_device_put;
-	}
+		pdev[i] = platform_device_alloc(DRVNAME, address);
+		if (!pdev[i]) {
+			err = -ENOMEM;
+			goto exit_device_put;
+		}
 
-	memset(&res, 0, sizeof(res));
-	res.name = DRVNAME;
-	res.start = address + IOREGION_OFFSET;
-	res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
-	res.flags = IORESOURCE_IO;
+		err = platform_device_add_data(pdev[i], &sio_data,
+					       sizeof(struct nct6775_sio_data));
+		if (err)
+			goto exit_device_put;
+
+		memset(&res, 0, sizeof(res));
+		res.name = DRVNAME;
+		res.start = address + IOREGION_OFFSET;
+		res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
+		res.flags = IORESOURCE_IO;
+
+		err = acpi_check_resource_conflict(&res);
+		if (err) {
+			platform_device_put(pdev[i]);
+			pdev[i] = NULL;
+			continue;
+		}
 
-	err = acpi_check_resource_conflict(&res);
-	if (err)
-		goto exit_device_put;
+		err = platform_device_add_resources(pdev[i], &res, 1);
+		if (err)
+			goto exit_device_put;
 
-	err = platform_device_add_resources(pdev, &res, 1);
-	if (err) {
-		pr_err("Device resource addition failed (%d)\n", err);
-		goto exit_device_put;
+		/* platform_device_add calls probe() */
+		err = platform_device_add(pdev[i]);
+		if (err)
+			goto exit_device_put;
 	}
-
-	/* platform_device_add calls probe() */
-	err = platform_device_add(pdev);
-	if (err) {
-		pr_err("Device addition failed (%d)\n", err);
-		goto exit_device_put;
+	if (!found) {
+		err = -ENODEV;
+		goto exit_unregister;
 	}
 
 	return 0;
 
 exit_device_put:
-	platform_device_put(pdev);
+	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+		if (pdev[i])
+			platform_device_put(pdev[i]);
+	}
 exit_unregister:
 	platform_driver_unregister(&nct6775_driver);
-exit:
 	return err;
 }
 
 static void __exit sensors_nct6775_exit(void)
 {
-	platform_device_unregister(pdev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+		if (pdev[i])
+			platform_device_unregister(pdev[i]);
+	}
 	platform_driver_unregister(&nct6775_driver);
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
