From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 01 Apr 2008 03:25:46 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon update against v2.6.25-rc7
Message-Id: <20080401032546.GF27659@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You'll get one patch (attached) which fixes a regression in w83781d
http://bugzilla.kernel.org/show_bug.cgi?id357

Thanks & regards,

commit 2961cb22ef02850d90e7a12c28a14d74e327df8d
Author: Jean Delvare <khali@linux-fr.org>
Date:   Sun Mar 9 13:34:28 2008 +0100

    hwmon: (w83781d) Fix I/O resource conflict with PNP
    
    Only request I/O ports 0x295-0x296 instead of the full I/O address
    range. This solves a conflict with PNP resources on a few motherboards.
    
    Also request the I/O ports in two parts (4 low ports, 4 high ports)
    during device detection, otherwise the PNP resource makes the request
    (and thus the detection) fail.
    
    This fixes lm-sensors ticket #2306:
    http://www.lm-sensors.org/ticket/2306
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 5c85670..f942ecd 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1367,7 +1367,8 @@ w83781d_isa_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, W83781D_EXTENT, "w83781d")) {
+	if (!request_region(res->start + W83781D_ADDR_REG_OFFSET, 2,
+			    "w83781d")) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -1415,7 +1416,7 @@ w83781d_isa_probe(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	kfree(data);
  exit_release_region:
-	release_region(res->start, W83781D_EXTENT);
+	release_region(res->start + W83781D_ADDR_REG_OFFSET, 2);
  exit:
 	return err;
 }
@@ -1429,7 +1430,7 @@ w83781d_isa_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr, W83781D_EXTENT);
+	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
 	return 0;
@@ -1797,8 +1798,17 @@ w83781d_isa_found(unsigned short address)
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
@@ -1871,7 +1881,8 @@ w83781d_isa_found(unsigned short address)
 			val = 0x30 ? "W83782D" : "W83781D", (int)address);
 
  release:
-	release_region(address, W83781D_EXTENT);
+	release_region(address + 4, 4);
+	release_region(address, 4);
 	return found;
 }
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
