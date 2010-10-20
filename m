From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:34 +0000
Subject: [lm-sensors] [PATCH 10/32] drivers/hwmon/f71882fg.c: Use pr_fmt and
Message-Id: <b07026df29e679572be14846620aadf879963087.1287556801.git.joe@perches.com>
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
 drivers/hwmon/f71882fg.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 75afb3b..3f49dd3 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -18,6 +18,8 @@
  *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -865,8 +867,7 @@ static inline int superio_enter(int base)
 {
 	/* Don't step on other drivers' I/O space by accident */
 	if (!request_muxed_region(base, 2, DRVNAME)) {
-		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
-				base);
+		pr_err("I/O address 0x%04x already in use\n", base);
 		return -EBUSY;
 	}
 
@@ -2192,7 +2193,7 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 
 	devid = superio_inw(sioaddr, SIO_REG_MANID);
 	if (devid != SIO_FINTEK_ID) {
-		pr_debug(DRVNAME ": Not a Fintek device\n");
+		pr_debug("Not a Fintek device\n");
 		err = -ENODEV;
 		goto exit;
 	}
@@ -2215,8 +2216,8 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 		sio_data->type = f8000;
 		break;
 	default:
-		printk(KERN_INFO DRVNAME ": Unsupported Fintek device: %04x\n",
-		       (unsigned int)devid);
+		pr_info("Unsupported Fintek device: %04x\n",
+			(unsigned int)devid);
 		err = -ENODEV;
 		goto exit;
 	}
@@ -2227,21 +2228,21 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 		superio_select(sioaddr, SIO_F71882FG_LD_HWM);
 
 	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
-		printk(KERN_WARNING DRVNAME ": Device not activated\n");
+		pr_warn("Device not activated\n");
 		err = -ENODEV;
 		goto exit;
 	}
 
 	*address = superio_inw(sioaddr, SIO_REG_ADDR);
 	if (*address = 0) {
-		printk(KERN_WARNING DRVNAME ": Base address not set\n");
+		pr_warn("Base address not set\n");
 		err = -ENODEV;
 		goto exit;
 	}
 	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
 	err = 0;
-	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %d\n",
+	pr_info("Found %s chip at %#x, revision %d\n",
 		f71882fg_names[sio_data->type],	(unsigned int)*address,
 		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
 exit:
@@ -2270,20 +2271,20 @@ static int __init f71882fg_device_add(unsigned short address,
 
 	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed\n");
+		pr_err("Device resource addition failed\n");
 		goto exit_device_put;
 	}
 
 	err = platform_device_add_data(f71882fg_pdev, sio_data,
 				       sizeof(struct f71882fg_sio_data));
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		pr_err("Platform data allocation failed\n");
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(f71882fg_pdev);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed\n");
+		pr_err("Device addition failed\n");
 		goto exit_device_put;
 	}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
