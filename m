From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:42 +0000
Subject: [lm-sensors] [PATCH 18/32] drivers/hwmon/lm78.c: Use pr_fmt and
Message-Id: <35be973bc0b3c4866421f001dabfbcab69093f72.1287556801.git.joe@perches.com>
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
 drivers/hwmon/lm78.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 72ff2c4..4cb24ea 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -19,6 +19,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -858,7 +860,7 @@ static int __init lm78_isa_found(unsigned short address)
 	 * individually for the probing phase. */
 	for (port = address; port < address + LM78_EXTENT; port++) {
 		if (!request_region(port, 1, "lm78")) {
-			pr_debug("lm78: Failed to request port 0x%x\n", port);
+			pr_debug("Failed to request port 0x%x\n", port);
 			goto release;
 		}
 	}
@@ -920,7 +922,7 @@ static int __init lm78_isa_found(unsigned short address)
 		found = 1;
 
 	if (found)
-		pr_info("lm78: Found an %s chip at %#x\n",
+		pr_info("Found an %s chip at %#x\n",
 			val & 0x80 ? "LM79" : "LM78", (int)address);
 
  release:
@@ -942,21 +944,19 @@ static int __init lm78_isa_device_add(unsigned short address)
 	pdev = platform_device_alloc("lm78", address);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR "lm78: Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
-		printk(KERN_ERR "lm78: Device resource addition failed "
-		       "(%d)\n", err);
+		pr_err("Device resource addition failed (%d)\n", err);
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR "lm78: Device addition failed (%d)\n",
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
