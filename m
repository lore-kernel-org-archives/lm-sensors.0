From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Jun 2013 18:07:00 +0000
Subject: [lm-sensors] [PATCH v2 2/4] hwmon: (nct6775) Support two SuperIO chips in the same system
Message-Id: <1372097222-11289-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebase to latest baseline

 drivers/hwmon/nct6775.c |  113 ++++++++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 778772d..caff726 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3484,11 +3484,11 @@ static const char * const nct6775_sio_names[] __initconst = {
 };
 
 /* nct6775_find() looks for a '627 in the Super-I/O config space */
-static int __init nct6775_find(int sioaddr, unsigned short *addr,
-			       struct nct6775_sio_data *sio_data)
+static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 {
 	u16 val;
 	int err;
+	int addr;
 
 	err = superio_enter(sioaddr);
 	if (err)
@@ -3520,8 +3520,8 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 	superio_select(sioaddr, NCT6775_LD_HWM);
 	val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
 	    | superio_inb(sioaddr, SIO_REG_ADDR + 1);
-	*addr = val & IOREGION_ALIGNMENT;
-	if (*addr = 0) {
+	addr = val & IOREGION_ALIGNMENT;
+	if (addr = 0) {
 		pr_err("Refusing to enable a Super-I/O device with a base I/O port 0\n");
 		superio_exit(sioaddr);
 		return -ENODEV;
@@ -3535,11 +3535,11 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 	}
 
 	superio_exit(sioaddr);
-	pr_info("Found %s or compatible chip at %#x\n",
-		nct6775_sio_names[sio_data->kind], *addr);
+	pr_info("Found %s or compatible chip at %#x:%#x\n",
+		nct6775_sio_names[sio_data->kind], sioaddr, addr);
 	sio_data->sioreg = sioaddr;
 
-	return 0;
+	return addr;
 }
 
 /*
@@ -3548,14 +3548,20 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
  * track of the nct6775 driver. But since we platform_device_alloc(), we
  * must keep track of the device
  */
-static struct platform_device *pdev;
+static struct platform_device *pdev[2];
 
 static int __init sensors_nct6775_init(void)
 {
-	int err;
-	unsigned short address;
+	int i, err;
+	bool found = false;
+	int address;
 	struct resource res;
 	struct nct6775_sio_data sio_data;
+	int sioaddr[2] = { 0x2e, 0x4e };
+
+	err = platform_driver_register(&nct6775_driver);
+	if (err)
+		return err;
 
 	/*
 	 * initialize sio_data->kind and sio_data->sioreg.
@@ -3564,64 +3570,71 @@ static int __init sensors_nct6775_init(void)
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
+		address = nct6775_find(sioaddr[i], &sio_data);
+		if (address <= 0)
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
