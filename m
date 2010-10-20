From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:46 +0000
Subject: [lm-sensors] [PATCH 22/32] drivers/hwmon/pkgtemp.c: Use pr_fmt and
Message-Id: <e0f2792980f2c443d6b229d3d8d5f0539c621c08.1287556801.git.joe@perches.com>
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
 drivers/hwmon/pkgtemp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
index 0798210..21c817d 100644
--- a/drivers/hwmon/pkgtemp.c
+++ b/drivers/hwmon/pkgtemp.c
@@ -20,6 +20,8 @@
  * 02110-1301 USA.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -303,7 +305,7 @@ static int __cpuinit pkgtemp_device_add(unsigned int cpu)
 	pdev = platform_device_alloc(DRVNAME, cpu);
 	if (!pdev) {
 		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		pr_err("Device allocation failed\n");
 		goto exit;
 	}
 
@@ -315,8 +317,7 @@ static int __cpuinit pkgtemp_device_add(unsigned int cpu)
 
 	err = platform_device_add(pdev);
 	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
-		       err);
+		pr_err("Device addition failed (%d)\n", err);
 		goto exit_device_free;
 	}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
