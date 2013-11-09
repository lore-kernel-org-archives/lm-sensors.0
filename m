From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 09 Nov 2013 17:51:09 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (coretemp) Refine TjMax detection
Message-Id: <1384019469-18666-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384019469-18666-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1384019469-18666-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Fenghua Yu <fenghua.yu@intel.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Intel's turbostat code uses only 7 bits from MSR_IA32_TEMPERATURE_TARGET to
read TjMax, and also only accepts it if the reported temperature is at least
85 degrees C. Play safe and do the same.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cde4e47..310ce19 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -368,12 +368,12 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		if (cpu_has_tjmax(c))
 			dev_warn(dev, "Unable to read TjMax from CPU %u\n", id);
 	} else {
-		val = (eax >> 16) & 0xff;
+		val = (eax >> 16) & 0x7f;
 		/*
 		 * If the TjMax is not plausible, an assumption
 		 * will be used
 		 */
-		if (val) {
+		if (val >= 85) {
 			dev_dbg(dev, "TjMax is %d degrees C\n", val);
 			return val * 1000;
 		}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
