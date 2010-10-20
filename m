From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:41 +0000
Subject: [lm-sensors] [PATCH 17/32] drivers/hwmon/lm70.c: Use pr_fmt and
Message-Id: <a482fe578a9717ce670aca34f42edfc097b10a1f.1287556801.git.joe@perches.com>
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
 drivers/hwmon/lm70.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index fd108cf..3b84fb5 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -24,6 +24,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -67,8 +69,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	 */
 	status = spi_write_then_read(spi, NULL, 0, &rxbuf[0], 2);
 	if (status < 0) {
-		printk(KERN_WARNING
-		"spi_write_then_read failed with status %d\n", status);
+		pr_warn("spi_write_then_read failed with status %d\n", status);
 		goto out;
 	}
 	raw = (rxbuf[0] << 8) + rxbuf[1];
-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
