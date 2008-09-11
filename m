From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Sep 2008 10:10:42 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (lm78) Fix I/O resource conflict
Message-Id: <20080911121042.315386db@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only request I/O ports 0x295-0x296 instead of the full I/O address
range. This solves a conflict with PNP resources on a few motherboards.

Also request the I/O ports in two parts (4 low ports, 4 high ports)
during device detection, otherwise the PNP resource make the request
(and thus the detection) fail.

This is the exact same fix that was applied to driver w83781d in
March 2008 to address the same problem:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h)61cb22ef02850d90e7a12c28a14d74e327df8d

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.26-rc7.orig/drivers/hwmon/lm78.c	2008-06-23 22:09:16.000000000 +0200
+++ linux-2.6.26-rc7/drivers/hwmon/lm78.c	2008-06-23 22:11:10.000000000 +0200
@@ -655,7 +655,7 @@ static int __devinit lm78_isa_probe(stru
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, LM78_EXTENT, "lm78")) {
+	if (!request_region(res->start + LM78_ADDR_REG_OFFSET, 2, "lm78")) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -699,7 +699,7 @@ static int __devinit lm78_isa_probe(stru
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	kfree(data);
  exit_release_region:
-	release_region(res->start, LM78_EXTENT);
+	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
  exit:
 	return err;
 }
@@ -711,7 +711,7 @@ static int __devexit lm78_isa_remove(str
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr, LM78_EXTENT);
+	release_region(data->client.addr + LM78_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
 	return 0;
@@ -837,8 +837,17 @@ static int __init lm78_isa_found(unsigne
 {
 	int val, save, found = 0;
 
-	if (!request_region(address, LM78_EXTENT, "lm78"))
+	/* We have to request the region in two parts because some
+	   boards declare base+4 to base+7 as a PNP device */
+	if (!request_region(address, 4, "lm78")) {
+		pr_debug("lm78: Failed to request low part of region\n");
 		return 0;
+	}
+	if (!request_region(address + 4, 4, "lm78")) {
+		pr_debug("lm78: Failed to request high part of region\n");
+		release_region(address, 4);
+		return 0;
+	}
 
 #define REALLY_SLOW_IO
 	/* We need the timeouts for at least some LM78-like
@@ -901,7 +910,8 @@ static int __init lm78_isa_found(unsigne
 			val & 0x80 ? "LM79" : "LM78", (int)address);
 
  release:
-	release_region(address, LM78_EXTENT);
+	release_region(address + 4, 4);
+	release_region(address, 4);
 	return found;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
