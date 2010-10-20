From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:43 +0000
Subject: [lm-sensors] [PATCH 19/32] drivers/hwmon/pc87360.c: Use pr_fmt and
Message-Id: <190459d6c56001d564155d8a73ee8e47024b6149.1287556801.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
In-Reply-To: <20101020035346.GA20178@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Added #define pr_fmt KBUILD_MODNAME ": " fmt
Converted printks to pr_<level>
Coalesced any long formats
Removed prefixes from formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwmon/pc87360.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 68e69a4..f8459a9 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -33,6 +33,8 @@
  *  the standard Super-I/O addresses is used (0x2E/0x2F or 0x4E/0x4F).
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1031,16 +1033,15 @@ static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses
 
 		val = superio_inb(sioaddr, ACT);
 		if (!(val & 0x01)) {
-			printk(KERN_INFO "pc87360: Device 0x%02x not "
-			       "activated\n", logdev[i]);
+			pr_info("Device 0x%02x not activated\n", logdev[i]);
 			continue;
 		}
 
 		val = (superio_inb(sioaddr, BASE) << 8)
 		    | superio_inb(sioaddr, BASE + 1);
 		if (!val) {
-			printk(KERN_INFO "pc87360: Base address not set for "
-			       "device 0x%02x\n", logdev[i]);
+			pr_info("Base address not set for device 0x%02x\n",
+				logdev[i]);
 			continue;
 		}
 
@@ -1071,14 +1072,11 @@ static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses
 				confreg[3] = superio_inb(sioaddr, 0x25);
 
 				if (confreg[2] & 0x40) {
-					printk(KERN_INFO "pc87360: Using "
-					       "thermistors for temperature "
-					       "monitoring\n");
+					pr_info("Using thermistors for temperature monitoring\n");
 				}
 				if (confreg[3] & 0xE0) {
-					printk(KERN_INFO "pc87360: VID "
-					       "inputs routed (mode %u)\n",
-					       confreg[3] >> 5);
+					pr_info("VID inputs routed (mode %u)\n",
+						confreg[3] >> 5);
 				}
 			}
 		}
@@ -1616,7 +1614,7 @@ static int __init pc87360_device_add(unsigned short address)
 	pdev = platform_device_alloc("pc87360", address);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR "pc87360: Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
@@ -1639,15 +1637,13 @@ static int __init pc87360_device_add(unsigned short address)
 
 	err = platform_device_add_resources(pdev, res, res_count);
 	if (err) {
-		printk(KERN_ERR "pc87360: Device resources addition failed "
-		       "(%d)\n", err);
+		pr_err("Device resources addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR "pc87360: Device addition failed (%d)\n",
-		       err);
+		pr_err("Device addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
@@ -1666,8 +1662,7 @@ static int __init pc87360_init(void)
 
 	if (pc87360_find(0x2e, &devid, extra_isa)
 	 && pc87360_find(0x4e, &devid, extra_isa)) {
-		printk(KERN_WARNING "pc87360: PC8736x not detected, "
-		       "module not inserted.\n");
+		pr_warn("PC8736x not detected, module not inserted\n");
 		return -ENODEV;
 	}
 
@@ -1680,8 +1675,7 @@ static int __init pc87360_init(void)
 	}
 
 	if (address = 0x0000) {
-		printk(KERN_WARNING "pc87360: No active logical device, "
-		       "module not inserted.\n");
+		pr_warn("No active logical device, module not inserted\n");
 		return -ENODEV;
 	}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
