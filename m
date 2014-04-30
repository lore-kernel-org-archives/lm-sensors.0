From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Apr 2014 21:14:54 +0000
Subject: [lm-sensors] [PATCH] Revert "hwmon: (coretemp) Refine TjMax detection"
Message-Id: <1398892494-15771-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This reverts commit 9fb6c9c73b11bef65ba80a362547fd116c1e1c9d.

Tjmax on some Intel CPUs is below 85 degrees C. One known example is
L5630 with Tjmax of 71 degrees C. Also, the Intel IA32 System Programming
document states that the temperature target is in bits 23:16 of MSR 0x1a2
(MSR_TEMPERATURE_TARGET), which that's 8 bits, not 7.

So even if turbostst uses similar checks to validate Tjmax, there is no
evidence that the checks are actually required. On the contrary, the checks
are known to cause problems and therefore need to be removed.

Fixes: 9fb6c9c hwmon: (coretemp) Refine TjMax detection
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I'll add Cc: stable when pushing the patch.

 drivers/hwmon/coretemp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6d02e3b..d76f0b7 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -365,12 +365,12 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		if (cpu_has_tjmax(c))
 			dev_warn(dev, "Unable to read TjMax from CPU %u\n", id);
 	} else {
-		val = (eax >> 16) & 0x7f;
+		val = (eax >> 16) & 0xff;
 		/*
 		 * If the TjMax is not plausible, an assumption
 		 * will be used
 		 */
-		if (val >= 85) {
+		if (val) {
 			dev_dbg(dev, "TjMax is %d degrees C\n", val);
 			return val * 1000;
 		}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
