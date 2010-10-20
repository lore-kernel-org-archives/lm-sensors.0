From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:35 +0000
Subject: [lm-sensors] [PATCH 11/32] drivers/hwmon/hp_accel.c: Use pr_fmt and
Message-Id: <a6d44b515f7e22737ee2e9b6f5449ea44ed19dc0.1287556801.git.joe@perches.com>
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
 drivers/hwmon/hp_accel.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
index a56a784..3d21fa2 100644
--- a/drivers/hwmon/hp_accel.c
+++ b/drivers/hwmon/hp_accel.c
@@ -20,6 +20,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
@@ -147,7 +149,7 @@ int lis3lv02d_acpi_write(struct lis3lv02d *lis3, int reg, u8 val)
 static int lis3lv02d_dmi_matched(const struct dmi_system_id *dmi)
 {
 	lis3_dev.ac = *((union axis_conversion *)dmi->driver_data);
-	printk(KERN_INFO DRIVER_NAME ": hardware type %s found.\n", dmi->ident);
+	pr_info("hardware type %s found\n", dmi->ident);
 
 	return 1;
 }
@@ -303,11 +305,10 @@ static int lis3lv02d_add(struct acpi_device *device)
 
 	/* If possible use a "standard" axes order */
 	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
-		printk(KERN_INFO DRIVER_NAME ": Using custom axes %d,%d,%d\n",
-		       lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
+		pr_info("Using custom axes %d,%d,%d\n",
+			lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
 	} else if (dmi_check_system(lis3lv02d_dmi_ids) = 0) {
-		printk(KERN_INFO DRIVER_NAME ": laptop model unknown, "
-				 "using default axes configuration\n");
+		pr_info("laptop model unknown, using default axes configuration\n");
 		lis3_dev.ac = lis3lv02d_axis_normal;
 	}
 
@@ -385,7 +386,7 @@ static int __init lis3lv02d_init_module(void)
 	if (ret < 0)
 		return ret;
 
-	printk(KERN_INFO DRIVER_NAME " driver loaded.\n");
+	pr_info("driver loaded\n");
 
 	return 0;
 }
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
