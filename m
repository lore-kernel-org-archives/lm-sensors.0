From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:38 +0000
Subject: [lm-sensors] [PATCH 14/32] drivers/hwmon/ibmaem.c: Use pr_fmt and
Message-Id: <49a48933aca71fbd388f438b6c24791a895e886c.1287556801.git.joe@perches.com>
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
 drivers/hwmon/ibmaem.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index eaee546..bc6e2ab 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -20,6 +20,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/ipmi.h>
 #include <linux/module.h>
 #include <linux/hwmon.h>
@@ -1090,7 +1092,7 @@ static int __init aem_init(void)
 
 	res = driver_register(&aem_driver.driver);
 	if (res) {
-		printk(KERN_ERR "Can't register aem driver\n");
+		pr_err("Can't register aem driver\n");
 		return res;
 	}
 
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
