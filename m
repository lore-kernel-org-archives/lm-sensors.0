From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:37 +0000
Subject: [lm-sensors] [PATCH 13/32] drivers/hwmon/hwmon.c: Use pr_fmt and
Message-Id: <d657ce6b56427cd2cce069275ec162da1815b196.1287556801.git.joe@perches.com>
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
 drivers/hwmon/hwmon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 29ea675..a61e781 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -10,6 +10,8 @@
     the Free Software Foundation; version 2 of the License.
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -119,7 +121,7 @@ static int __init hwmon_init(void)
 
 	hwmon_class = class_create(THIS_MODULE, "hwmon");
 	if (IS_ERR(hwmon_class)) {
-		printk(KERN_ERR "hwmon.c: couldn't create sysfs class\n");
+		pr_err("couldn't create sysfs class\n");
 		return PTR_ERR(hwmon_class);
 	}
 	return 0;
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
