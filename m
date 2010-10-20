From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:36 +0000
Subject: [lm-sensors] [PATCH 12/32] drivers/hwmon/hwmon-vid.c: Use pr_fmt
Message-Id: <6fb075d630e3fb20dc42ede9cca39c0c45ed9c0f.1287556801.git.joe@perches.com>
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
 drivers/hwmon/hwmon-vid.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index bf0862a..5328ad5 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -22,6 +22,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/hwmon-vid.h>
@@ -146,8 +148,8 @@ int vid_from_reg(int val, u8 vrm)
 		return(val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000);
 	default:		/* report 0 for unknown */
 		if (vrm)
-			printk(KERN_WARNING "hwmon-vid: Requested unsupported "
-			       "VRM version (%u)\n", (unsigned int)vrm);
+			pr_warn("Requested unsupported VRM version (%u)\n",
+				(unsigned int)vrm);
 		return 0;
 	}
 }
@@ -246,8 +248,7 @@ u8 vid_which_vrm(void)
 	}
 	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
 	if (vrm_ret = 0)
-		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
-		       "x86 CPU\n");
+		pr_info("Unknown VRM version of your x86 CPU\n");
 	return vrm_ret;
 }
 
@@ -255,7 +256,7 @@ u8 vid_which_vrm(void)
 #else
 u8 vid_which_vrm(void)
 {
-	printk(KERN_INFO "hwmon-vid: Unknown VRM version of your CPU\n");
+	pr_info("Unknown VRM version of your CPU\n");
 	return 0;
 }
 #endif
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
