From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:45 +0000
Subject: [lm-sensors] [PATCH 21/32] drivers/hwmon/pcf8591.c: Use pr_fmt and
Message-Id: <e021d63730a851db5af583961145f95217f1787d.1287556801.git.joe@perches.com>
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
 drivers/hwmon/pcf8591.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index dc7259d..731b09a 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -18,6 +18,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -290,8 +292,7 @@ static struct i2c_driver pcf8591_driver = {
 static int __init pcf8591_init(void)
 {
 	if (input_mode < 0 || input_mode > 3) {
-		printk(KERN_WARNING "pcf8591: invalid input_mode (%d)\n",
-		       input_mode);
+		pr_warn("invalid input_mode (%d)\n", input_mode);
 		input_mode = 0;
 	}
 	return i2c_add_driver(&pcf8591_driver);
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
