From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:50 +0000
Subject: [lm-sensors] [PATCH 26/32] drivers/hwmon/via-cputemp.c: Use pr_fmt
Message-Id: <bd2bd159db94be1cfdb2bc176d3a5bb2705f79ef.1287556801.git.joe@perches.com>
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
 drivers/hwmon/via-cputemp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index ec7fad7..45b08c7 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -21,6 +21,8 @@
  * 02110-1301 USA.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -202,7 +204,7 @@ static int __cpuinit via_cputemp_device_add(unsigned int cpu)
 	pdev = platform_device_alloc(DRVNAME, cpu);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
@@ -214,8 +216,7 @@ static int __cpuinit via_cputemp_device_add(unsigned int cpu)
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
-		       err);
+		pr_err("Device addition failed (%d)\n", err);
 		goto exit_device_free;
 	}
 
@@ -295,8 +296,7 @@ static int __init via_cputemp_init(void)
 			continue;
 
 		if (c->x86_model > 0x0f) {
-			printk(KERN_WARNING DRVNAME ": Unknown CPU "
-				"model 0x%x\n", c->x86_model);
+			pr_warn("Unknown CPU model 0x%x\n", c->x86_model);
 			continue;
 		}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
