From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:55 +0000
Subject: [lm-sensors] [PATCH 31/32] drivers/hwmon/w83627hf.c: Use pr_fmt and
Message-Id: <1c8f1890b6adbfe084e1443f5e5e9c7428edb3d4.1287556801.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
In-Reply-To: <20101020035346.GA20178@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Added #define pr_fmt KBUILD_MODNAME ": " fmt
Converted printks to pr_<level>
Coalesced any long formats
Removed prefixes from formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwmon/w83627hf.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 38e2805..bde50e3 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -39,6 +39,8 @@
     supported yet.
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1166,14 +1168,13 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 	       superio_inb(sio_data, WINB_BASE_REG + 1);
 	*addr = val & WINB_ALIGNMENT;
 	if (*addr = 0) {
-		printk(KERN_WARNING DRVNAME ": Base address not set, "
-		       "skipping\n");
+		pr_warn("Base address not set, skipping\n");
 		goto exit;
 	}
 
 	val = superio_inb(sio_data, WINB_ACT_REG);
 	if (!(val & 0x01)) {
-		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
+		pr_warn("Enabling HWM logical device\n");
 		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
 	}
 
@@ -1789,28 +1790,26 @@ static int __init w83627hf_device_add(unsigned short address,
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed "
-		       "(%d)\n", err);
+		pr_err("Device resource addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
 	err = platform_device_add_data(pdev, sio_data,
 				       sizeof(struct w83627hf_sio_data));
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		pr_err("Platform data allocation failed\n");
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
-		       err);
+		pr_err("Device addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
