From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 09 Jul 2012 10:10:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (applesmc) Shorten minimum wait time
Message-Id: <1341828626-6543-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The 2012 series of MacBooks have a faster SMC, and the current driver
timings do not work at all. Tests show that decreasing the minimum
wait time, from 64 us to 16 us, works well. Since this is still larger
than the original minimum of 10 us used before 2008, there is nothing
inherently problematic with changing it. The fail frequency on older
machines seems to increase slightly, but not enough to be noticeable.

Tested on MBA11, MBA31, MBA5,2, MBP9,2.

The patch was originally written by adamski99 (ubuntuforums.org) and
later tested by janhouse (bbs.archlinux.org).

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Guenter,

This patch enables the mid-2012 MacBook models. The patch affects
older models slightly, but mostly in a good way; all models get
slightly faster reads, but some older models see a slight increase in
read fail frequency. I do not think this will be noticeable, but I
would hesitate to backport too far. For 3.6.

Thanks,
Henrik

 drivers/hwmon/applesmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 0162f55..f41585e 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -54,7 +54,7 @@
 #define APPLESMC_MAX_DATA_LENGTH 32
 
 /* wait up to 32 ms for a status change. */
-#define APPLESMC_MIN_WAIT	0x0040
+#define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_MAX_WAIT	0x8000
 
 #define APPLESMC_STATUS_MASK	0x0f
-- 
1.7.11.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
