From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:30 +0000
Subject: [lm-sensors] [PATCH 06/32] drivers/hwmon/asus_atk0110.c: Use pr_fmt
Message-Id: <506bc745e46020fb99159fd73288d3b0202c99cf.1287556801.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
In-Reply-To: <20101020035346.GA20178@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Added #define pr_fmt KBUILD_MODNAME ": " fmt
Converted printks to pr_<level>
Coalesced any long formats
Removed prefixes from formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwmon/asus_atk0110.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 23b8555..2d68cf3 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -5,6 +5,8 @@
  * See COPYING in the top level directory of the kernel tree.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/hwmon.h>
@@ -1414,14 +1416,13 @@ static int __init atk0110_init(void)
 
 	/* Make sure it's safe to access the device through ACPI */
 	if (!acpi_resources_are_enforced()) {
-		pr_err("atk: Resources not safely usable due to "
-		       "acpi_enforce_resources kernel parameter\n");
+		pr_err("Resources not safely usable due to acpi_enforce_resources kernel parameter\n");
 		return -EBUSY;
 	}
 
 	ret = acpi_bus_register_driver(&atk_driver);
 	if (ret)
-		pr_info("atk: acpi_bus_register_driver failed: %d\n", ret);
+		pr_info("acpi_bus_register_driver failed: %d\n", ret);
 
 	return ret;
 }
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
