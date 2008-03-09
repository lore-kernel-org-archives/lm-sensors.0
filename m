From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Mar 2008 12:34:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Fix I/O resource conflict
Message-Id: <20080309133428.56de6d25@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only request I/O ports 0x295-0x296 instead of the full I/O address
range. This solves a conflict with PNP resources on a few motherboards.

Also request the I/O ports in two parts (4 low ports, 4 high ports)
during device detection, otherwise the PNP resource makes the request
(and thus the detection) fail.

This fixes lm-sensors ticket #2306:
http://www.lm-sensors.org/ticket/2306

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Mark, this fixes a regression so this should go to Linus before 2.6.25
final. This should also be backported to 2.6.24-stable (I'll take care.)

Note: I do agree that my fix is not universal and it is possible that
some boards out there have a different PNP setup not covered by this
fix. However it's hard to predict what the various BIOS do, and I also
do not expect that many boards old enough to use a W83781D to declare
it as a PNP device. So, my current position is to wait for further
reports before updating the code again if needed.

 drivers/hwmon/w83781d.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- linux-2.6.25-rc4.orig/drivers/hwmon/w83781d.c	2008-02-26 13:37:12.000000000 +0100
+++ linux-2.6.25-rc4/drivers/hwmon/w83781d.c	2008-03-08 10:50:58.000000000 +0100
@@ -1367,7 +1367,8 @@ w83781d_isa_probe(struct platform_device
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, W83781D_EXTENT, "w83781d")) {
+	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
+			    "w83781d")) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -1415,7 +1416,7 @@ w83781d_isa_probe(struct platform_device
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	kfree(data);
  exit_release_region:
-	release_region(res->start, W83781D_EXTENT);
+	release_region(res->start + W83781D_ADDR_REG_OFFSET, 2);
  exit:
 	return err;
 }
@@ -1429,7 +1430,7 @@ w83781d_isa_remove(struct platform_devic
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr, W83781D_EXTENT);
+	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
 	return 0;
@@ -1797,8 +1798,17 @@ w83781d_isa_found(unsigned short address
 {
 	int val, save, found = 0;
 
-	if (!request_region(address, W83781D_EXTENT, "w83781d"))
+	/* We have to request the region in two parts because some
+	   boards declare base+4 to base+7 as a PNP device */
+	if (!request_region(address, 4, "w83781d")) {
+		pr_debug("w83781d: Failed to request low part of region\n");
 		return 0;
+	}
+	if (!request_region(address + 4, 4, "w83781d")) {
+		pr_debug("w83781d: Failed to request high part of region\n");
+		release_region(address, 4);
+		return 0;
+	}
 
 #define REALLY_SLOW_IO
 	/* We need the timeouts for at least some W83781D-like
@@ -1871,7 +1881,8 @@ w83781d_isa_found(unsigned short address
 			val = 0x30 ? "W83782D" : "W83781D", (int)address);
 
  release:
-	release_region(address, W83781D_EXTENT);
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
