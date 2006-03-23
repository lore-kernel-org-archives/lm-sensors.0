From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:40:23 +0000
Subject: [lm-sensors] [PATCH 06/10] f71805f: Resource needs not be global
Message-Id: <20060323164023.f5380bf9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-f71805f-no-global-resource.patch

The F71805F I/O resource structure needs not be a global variable,
as the platform core allocs its own copy of it anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/f71805f.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/hwmon/f71805f.c	2006-02-27 21:01:16.000000000 +0100
+++ linux-2.6.16-rc5/drivers/hwmon/f71805f.c	2006-03-02 22:44:15.000000000 +0100
@@ -99,10 +99,6 @@
 #define ADDR_REG_OFFSET		0
 #define DATA_REG_OFFSET		1
 
-static struct resource f71805f_resource __initdata = {
-	.flags	= IORESOURCE_IO,
-};
-
 /*
  * Registers
  */
@@ -782,6 +778,11 @@
 
 static int __init f71805f_device_add(unsigned short address)
 {
+	struct resource res = {
+		.start	= address,
+		.end	= address + REGION_LENGTH - 1,
+		.flags	= IORESOURCE_IO,
+	};
 	int err;
 
 	pdev = platform_device_alloc(DRVNAME, address);
@@ -791,10 +792,8 @@
 		goto exit;
 	}
 
-	f71805f_resource.start = address;
-	f71805f_resource.end = address + REGION_LENGTH - 1;
-	f71805f_resource.name = pdev->name;
-	err = platform_device_add_resources(pdev, &f71805f_resource, 1);
+	res.name = pdev->name;
+	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
 		       "(%d)\n", err);

-- 
Jean Delvare

