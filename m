From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:53 +0000
Subject: [lm-sensors] [PATCH 29/32] drivers/hwmon/vt8231.c: Use pr_fmt and
Message-Id: <2f9af9098da1daa404968edb93ae4387f81ec1a2.1287556801.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
In-Reply-To: <20101020035346.GA20178@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Roger Lucas <vt8231@hiddenengine.co.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Added #define pr_fmt KBUILD_MODNAME ": " fmt
Converted printks to pr_<level>
Coalesced any long formats
Removed prefixes from formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwmon/vt8231.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index e6078c9..db3b2e8 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -24,6 +24,8 @@
 /* Supports VIA VT8231 South Bridge embedded sensors
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -902,21 +904,19 @@ static int __devinit vt8231_device_add(unsigned short address)
 	pdev = platform_device_alloc("vt8231", address);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR "vt8231: Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
-		printk(KERN_ERR "vt8231: Device resource addition failed "
-		       "(%d)\n", err);
+		pr_err("Device resource addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR "vt8231: Device addition failed (%d)\n",
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
