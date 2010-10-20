From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:44 +0000
Subject: [lm-sensors] [PATCH 20/32] drivers/hwmon/pc87427.c: Use pr_fmt and
Message-Id: <8a5f258d9b494988e1ca2ded006423d9cdab8e54.1287556801.git.joe@perches.com>
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
 drivers/hwmon/pc87427.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 9ec4daa..78c3e32 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -22,6 +22,8 @@
  *  mode, and voltages aren't supported at all.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1077,7 +1079,7 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 	data = kzalloc(sizeof(struct pc87427_data), GFP_KERNEL);
 	if (!data) {
 		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Out of memory\n");
+		pr_err("Out of memory\n");
 		goto exit;
 	}
 
@@ -1196,28 +1198,26 @@ static int __init pc87427_device_add(const struct pc87427_sio_data *sio_data)
 	pdev = platform_device_alloc(DRVNAME, res[0].start);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
 	err = platform_device_add_resources(pdev, res, res_count);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed "
-		       "(%d)\n", err);
+		pr_err("Device resource addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
 	err = platform_device_add_data(pdev, sio_data,
 				       sizeof(struct pc87427_sio_data));
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
 
@@ -1249,23 +1249,23 @@ static int __init pc87427_find(int sioaddr, struct pc87427_sio_data *sio_data)
 
 		val = superio_inb(sioaddr, SIOREG_ACT);
 		if (!(val & 0x01)) {
-			printk(KERN_INFO DRVNAME ": Logical device 0x%02x "
-			       "not activated\n", logdev[i]);
+			pr_info("Logical device 0x%02x not activated\n",
+				logdev[i]);
 			continue;
 		}
 
 		val = superio_inb(sioaddr, SIOREG_MAP);
 		if (val & 0x01) {
-			printk(KERN_WARNING DRVNAME ": Logical device 0x%02x "
-			       "is memory-mapped, can't use\n", logdev[i]);
+			pr_warn("Logical device 0x%02x is memory-mapped, can't use\n",
+				logdev[i]);
 			continue;
 		}
 
 		val = (superio_inb(sioaddr, SIOREG_IOBASE) << 8)
 		    | superio_inb(sioaddr, SIOREG_IOBASE + 1);
 		if (!val) {
-			printk(KERN_INFO DRVNAME ": I/O base address not set "
-			       "for logical device 0x%02x\n", logdev[i]);
+			pr_info("I/O base address not set for logical device 0x%02x\n",
+				logdev[i]);
 			continue;
 		}
 		sio_data->address[i] = val;
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
